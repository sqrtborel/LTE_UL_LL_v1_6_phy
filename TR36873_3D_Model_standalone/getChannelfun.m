function getChannelfun(L,K,ip)

num_trial = 10;
% L = 21;
% K = 105;
N_NE = 2;
N_BS = 32;
M = 24;

G_freq = zeros(num_trial, L, K, N_NE, N_BS, M);
betas1_2 = zeros(num_trial, L, K);
for trial = 1:num_trial
    [UEs] = Simulate();
    for uei = 1:K
        h0 = reshape(UEs(uei).H_0_final, N_NE, N_BS, []);
        h0_M = h0(:,:,1:M);
        hi = reshape(UEs(uei).H_i_full_final, N_NE, N_BS, [], L - 1);
        hi_M = permute(hi(:,:,1:M,:), [4,1,2,3]);
        node_id = UEs(uei).attached_eNodeB.eNodeB_id;
        U = zeros(L, N_NE, N_BS, M);
        U(1:node_id-1,:,:,:) = hi_M(1:node_id-1,:,:,:);
        U(node_id,:,:,:) = h0_M;
        U(node_id+1:end,:,:,:) = hi_M(node_id:end,:,:,:);
        betas1_2(trial, 1:node_id-1, uei) = UEs(uei).beta_i(1:node_id-1);
        betas1_2(trial, node_id, uei) = UEs(uei).beta_0;
        betas1_2(trial, node_id+1:end, uei) = UEs(uei).beta_i(node_id:end);
        
        G_freq(trial, :, uei, :, :, :) = U;
    end
end
%%
save(['Channel_',num2str(ip),'.mat'],'G_freq','betas1_2');
end