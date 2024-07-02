function [kls_value] = kl_symmetric(p, q)
    % KL divergence from p to q
    kl_pq = sum(p .* log(p ./ q));
    % KL divergence from q to p
    kl_qp = sum(q .* log(q ./ p));
    % Symmetric KL divergence
    kls_value = kl_pq + kl_qp;
end