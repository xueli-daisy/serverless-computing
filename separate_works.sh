functions=("deltablue" "json-dumps")

#separate_works_C_M_d_0_j_1
#mems=("0" "1")
#cpus=("0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30" "1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31")

#separate_works_C_M_d_1_j_0
mems=("1" "0")
cpus=("0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30" "1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31")

#separate_works_d_0_j_0-1
#mems=("0" "0-1")
#cpus=("0,2,4,6,8,10,12,14,16,18" "1,3,5,7,9,11,13,15,17,19-31")

#all_C_M
#mems=("0-1" "0-1")
#cpus=("0-31" "0-31")

for (( i=0; i<600; i++ ))
do
#  sudo bash -c "echo $i > /sys/fs/cgroup/cpuset/cpuset.mems"
#  echo "changed /sys/fs/cgroup/cpuset/cpuset.sched_relax_domain_level"
#  sudo bash -c "echo ${sched_relax_domain_level} > /sys/fs/cgroup/cpuset/kubepods/cpuset.sched_relax_domain_level"
#  echo "changed /sys/fs/cgroup/cpuset/kubepods/cpuset.sched_relax_domain_level"
#  sudo bash -c "echo ${sched_relax_domain_level} > /sys/fs/cgroup/cpuset/kubepods/burstable/cpuset.sched_relax_domain_level"
#  echo "changed /sys/fs/cgroup/cpuset/kubepods/burstable/cpuset.sched_relax_domain_level"
  for i in ${!functions[@]}; do
    for pod in $(kubectl get pods -n openfaas-fn --field-selector status.phase==Running|grep -v 'NAME'|grep ${functions[$i]}|awk '{print $1}')
    do
      #echo $pod
      podID=`kubectl get pods $pod -n openfaas-fn -o=jsonpath='{.metadata.uid}'`
      #echo podID $podID
      #sudo bash -c "echo ${mems[$i]} > /sys/fs/cgroup/cpuset/kubepods/burstable/pod${podID}/cpuset.mems"
      #sudo bash -c "echo ${cpus[$i]} > /sys/fs/cgroup/cpuset/kubepods/burstable/pod${podID}/cpuset.cpus"
      dockerID=`kubectl get pods $pod -n openfaas-fn -o=jsonpath='{.status.containerStatuses}'|awk -F 'docker://' '{print $2}'|awk -F '"' '{print $1}'`
      #echo dockerID $dockerID
      sudo bash -c "echo ${mems[$i]} > /sys/fs/cgroup/cpuset/kubepods/burstable/pod${podID}/${dockerID}/cpuset.mems"
      echo changed /sys/fs/cgroup/cpuset/kubepods/burstable/pod${podID}/${dockerID}/cpuset.mems
      sudo bash -c "echo ${cpus[$i]} > /sys/fs/cgroup/cpuset/kubepods/burstable/pod${podID}/${dockerID}/cpuset.cpus"
      echo changed /sys/fs/cgroup/cpuset/kubepods/burstable/pod${podID}/${dockerID}/cpuset.cpus
    done
  done
  sleep 1s
done

