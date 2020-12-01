load('Channel_1.mat');
[num_trial, L, K, N_NE, N_BS, M] = size(G_freq);
file_ind = 1:12;
G_freq_all = zeros(num_trial*length(file_ind),L, K, N_NE, N_BS, M);
betas1_2_all = zeros(num_trial*length(file_ind),L, K);
for i_file = file_ind
    file_name = ['Channel_',num2str(ip),'.mat'];
    load(file_name)
    G_freq_all((i_file-1)*num_trial+1:i_file*num_trial,:,:,:,:,:) = G_freq;
    betas1_2_all((i_file-1)*num_trial+1:i_file*num_trial,:,:) = betas1_2;
end
save('Channel.mat','G_freq_all','betas1_2_all');