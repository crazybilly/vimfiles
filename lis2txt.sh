#! /bin/sh

for file in *
do 
	mv "$file" "$(echo "$file" | sed 's/lis/txt/')"
done


