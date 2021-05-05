using RanDAGen


dag = DAG(0:20, 2:4, 0:2)

# depth:  20
# width_min:  2       # [Sept 5]: 1, 2, 3
# width_max:  4       # [Sept 5]: 3, 4, 5
# ccr:  20            # [Sept 5]: 2, 20, 200
# comp_mu:    2       # computation workload
# comp_sigma: 0.5
# link_comm_sigma:  0.5   # [Sept 5] 0.1,0.5,0.9  #link_comm is in normal distribution. It is the data transmitted on links.
# deg_mu: 4           # [Sept 5]: 2, 4, 6
# deg_sigma: 0.5
# total_num: 5
# struct _Task {
#     int tag;
#     double cost;
#     int data_size;
#     double alpha;
#     int nb_children;
#     Task *children;
#     double *comm_costs;
#     int *transfer_tags;
#     complexity_t complexity;
#   };

#   struct _DAG {
#     int nb_levels;
#     int *nb_tasks_per_level;
#     Task **levels;
#   };
