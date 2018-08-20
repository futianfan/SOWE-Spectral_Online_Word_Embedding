awk '{for(i=2;i<301;i=i+1){printf $i" "};printf "\n"}' bow5.words > bow5.words2

awk '{for(i=2;i<301;i=i+1){printf $i" "};printf "\n"}' bow5.contexts > bow5.contexts2

