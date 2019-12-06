declare -a data
declare -a frekuensi
declare -a ascending
declare -a descending

counter=0;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
max=-10;
modus=0;
temp=0;
jumlah=0;
c=0;
mean=0;
	select pilih in "Input Data" "list Data" "Modus Data" "Median Data" "Mean Data" "Simpan" "Tampilkan History" "Exit"
	do
	case "$pilih" in

	"Input Data" )
		select input in "Manual" "Dari File"
		do
		case "$input" in
		"Manual")
			echo "masukan jumlah data : "
			read n
			i=0;
		while [ $i -lt $n ]
		do
			echo "Masukkan Data (maks.20, min 1):"
			read angka
			data[$i]=$angka
			let i=$i+1;
		done
		break
		;;
		
		"Dari File")
		echo "Masukkan Nama Folder : "
		read folder
		cd $folder
		ls
		echo "Masukkan Nama File : "
		read nama_file
		while read line
		do
		data[$n]="$line"
		let n=$n+1
		done < $nama_file.txt
		cd
		for h in ${data[@]}
		do
		let counter=$counter+1
		done
		echo "jumlah data $counter"	
		break
		;;
		esac
		done
		;;

	"list Data")
		for ((a=0;a<n;a++))
		do
		ascending[$a]=${data[$a]}
		descending[$a]=${data[$a]}
		done
		select list in asli ascending descending
		do
		case "$list" in
	 	"asli")
		echo ${data[*]}
		break
		;;
		"ascending")
		echo "alur sorting :
"
		for ((i=0;i<n;i++))
		do
			for ((j=i;j<n-i-1;j++))
			do 
				let k=$j+1;
				if [ ${ascending[$j]} -gt ${ascending[$k]} ]
				then
				temp=${ascending[$j]}
				ascending[$j]=${ascending[$k]}
				ascending[$k]=$temp
				echo ${ascending[*]}
				fi
			done
		done
		echo "Hasil Sorting : ${ascending[*]}"
		break
		;;
		"descending")
		echo "alur sorting :
"
		for ((i=n-1;i>=0;i--))
		do
			for ((j=0;j<n-1;j++))
			do 
				let k=$j+1;
				if [ ${descending[$j]} -lt ${descending[$k]} ]
				then
				temp=${descending[$j]}
				descending[$j]=${descending[$k]}
				descending[$k]=$temp
				echo ${descending[*]}
				fi
			done
		done
		echo "Hasil Sorting : ${descending[*]}"
		break
		;;
		esac
		done
		;;
	"Modus Data" )
		for ((a=0;a<=20;a=a+1))
		do  
			frekuensi[$a]=0
			for ((b=0;b<n;b=b+1))
			do
				if [ ${data[$b]} == $a ]
				then
					let frekuensi[$a]=${frekuensi[$a]}+1
				fi
			done
				if [ ${frekuensi[$a]} -ge $max ]
				then 
					max=${frekuensi[$a]}
					modus=$a
				fi
		done
		echo ${data[*]}
		echo "modus = $modus"
		echo "frekuensi = $max"
		;;
	"Median Data")
		for ((i=0;i<n;i++))
		do
			for ((j=i;j<n-i-1;j++))
			do 
				let k=$j+1;
				if [ ${data[$j]} -gt ${data[$k]} ]
				then
				temp=${data[$j]}
				data[$j]=${data[$k]}
				data[$k]=$temp
				fi
			done
		done
		echo ${data[*]}
		let c=$n/2
		echo "Median = ${data[$c]}"
		;;

	"Mean Data")
		q=0;
		while [ $q -lt $n ]
		do
		let jumlah=$jumlah+${data[$q]} 
		let q=$q+1;
		done
		echo $jumlah $counter
		echo "mean=$jumlah/$counter"
		echo 'maaf bash hanya bisa memproses integer kecuali ditambahkan beberapa add-o lain'
		
		;;

	"Simpan")
		echo "masukkan nama folder : (kosongkan jika tidak ingin)"
		read nmfolder
		mkdir $nmfolder
		cd $nmfolder
		echo "Masukkan Nama File : "
		read Name
		echo "Data : ${data[@]}" > $Name.txt
		echo "Ascending : ${ascending[@]}" >> $Name.txt 
		echo "Descending : ${descending[@]}" >> $Name.txt
		echo "Modus : $modus" >> $Name.txt
		echo "Median : ${data[$c]}" >> $Name.txt
		echo "Mean : $mean" >> $Name.txt
		cat $Name.txt
		cd
		;;
	"Tampilkan History")
		echo "Data : ${data[@]}" > history.txt
		echo "Ascending : ${ascending[@]}" >> history.txt 
		echo "Descending : ${descending[@]}" >> history.txt
		echo "Modus : $modus" >> history.txt
		echo "Median : ${data[$c]}" >> history.txt
		echo "Mean : $jumlah/$counter" >> history.txt
		cat history.txt
		;;

	"Exit")
		echo "terima kasih telah mencoba"
		exit
		;;

esac
done



