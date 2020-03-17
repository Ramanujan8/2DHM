#------------------------------------------------------------------------------------------------------------------------#
#    This is central notebook which executes coupled heat and moisture transfer based on defined input (\"input.jl\")    #
#------------------------------------------------------------------------------------------------------------------------#

using PlotlyJS
using DelimitedFiles
using LinearAlgebra
using Distributed
using DistributedArrays
using SparseArrays
using Krylov
# using ArrayFire
# using CUDAdrv, CUDAnative, CuArrays

include("material_library.jl")
include("functions.jl")

###---1D problem analysed as 2D steady-state heat transfer---###

#  include("inputs/input_1D_ss.jl")
#
#  M=mesh(E,dl) #Mesh matrix -- function on matrix of geometry, materials and boundary conditions (E) included from input.jl
#  #M=readdlm("projects/HM_T/mesh.csv",',');	#Reading already defined mesh
#  Ns=nsort(E,M,dl)
#  Con=con1(E,M,dl,Ns)
#  K=Kmat(M,Con,dl)
#  @time begin
#  x=modconjgrad(K,M)
#  end
#
#  # @time begin
#  # K2=Kmat2(M,Con,dl)
#  # k2=K2[1];f=K2[2]
#  # kinv=inv(k2)
#  # x=kinv*f
#  M2=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]#M2=[["x_coord" "y_coord"];M[:,3:4]]#M2=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]#
#  Z0_vect=zeros(size(M2)[1]-1)#Z0_vect=zeros(size(M)[1])#Z0_vect=zeros(size(M2)[1]-1)#
#  Z0_vect=["z_coord";Z0_vect]#Z0_vect=["z_coord";Z0_vect]#Z0_vect=["z_coord";Z0_vect]#
#  x1=["temp";x]#x1=["temp";x;M[size(x)[1]+1:end,7]]#x1=["temp";x]#
#  writedlm("results/paraview_1D_ss.csv",  [M2 Z0_vect x1], ',')#writedlm("results/paraview_results.csv",  [M2 Z0_vect x1], ',')
#  # end
#  xres=[x;M[size(x)[1]+1:end,7]]; #results with BC
#
# ###---1D problem analysed as 2D transient heat transfer---###
#
#  println("Calculation started!")
#  @time begin
#  include("inputs/input_1D_transient.jl")
#  M=mesh(E,dl)
#  M2=copy(M)
#  Ns=nsort(E,M,dl)
#  Con=con1(E,M,dl,Ns)
#  K=Kmat(M,Con,dl,dt)
#  x_in=10*ones(size(K)[1])
#  Temp_e=readdlm("inputs/Cos_1_240.csv",',')
#  t_e_ind1=floor(Int64,Ns[4][1,1])	#global IDs of left - exterior BC
#  t_e_ind2=floor(Int64,Ns[4][end,1])	#
#  Temp_i=22*ones(size(K)[1])
#  t_i_ind1=floor(Int64,Ns[6][1,1])	#global IDs of right - interior BC
#  t_i_ind2=floor(Int64,Ns[6][end,1])	#
#  for i=1:floor(Int64,round(T/dt))
#  	for j=t_e_ind1:t_e_ind2
#  		M2[j,7]=Temp_e[i]
#  	end
#  	for j=t_i_ind1:t_i_ind2
#  		M2[j,7]=Temp_i[i]
#  	end
#  	global K2=Kmat(M2,Con,dl,dt)
#  	global x1=modconjgrad(K2,M2,dt,dl,0,x_in)
#  	global M3=[["x_coord" "y_coord"];M2[1:(size(x)[1]),3:4]]
#  	global Z0_vect=zeros(size(M3)[1]-1)
#  	global Z0_vect=["z_coord";Z0_vect]
#  	global xx=["temp";x1]
#  	writedlm("results/transient/1Dt/1D_transient$i.csv",  [M3 Z0_vect xx], ',')
#  	global x_in=copy(x1)
#  end
#  println("End of calculation!")
#  end
#
# ###Up to steady state input1###
#  println("Calculation started!")
#  @time begin
#  include("inputs/input.jl")
#  M=mesh(E,dl)
#  M2=copy(M)
#  Ns=nsort(E,M,dl)
#  Con=con1(E,M,dl,Ns)
#  K=Kmat(M,Con,dl,dt)
#  x_in=10*ones(size(K)[1])
#  #Temp_e=readdlm("inputs/Cos_1_240.csv",',')
#  #t_e_ind1=floor(Int64,Ns[4][1,1])	#global IDs of left - exterior BC
#  #t_e_ind2=floor(Int64,Ns[4][end,1])	#
#  #Temp_i=20*ones(size(K)[1])
#  #t_i_ind1=floor(Int64,Ns[6][1,1])	#global IDs of right - interior BC
#  #t_i_ind2=floor(Int64,Ns[6][end,1])	#
#  for i=1:floor(Int64,round(T/dt))
#  	# for j=t_e_ind1:t_e_ind2
#  	# 	M2[j,7]=Temp_e[i]
#  	# end
#  	# for j=t_i_ind1:t_i_ind2
#  	# 	M2[j,7]=Temp_i[i]
#  	# end
#  	global K2=Kmat(M2,Con,dl,dt)
#  	@time begin
#  	global x1=modconjgrad(K2,M2,dt,dl,0,x_in)
#  	time end
#  	global M3=[["x_coord" "y_coord"];M2[1:(size(x1)[1]),3:4]]
#  	global Z0_vect=zeros(size(M3)[1]-1)
#  	global Z0_vect=["z_coord";Z0_vect]
#  	global xx=["temp";x1]
#  	writedlm("results/transient/input_ss_to_tr/iss$i.csv",  [M3 Z0_vect xx], ',')
#  	global x_in=copy(x1)
#  end
#  println("End of calculation!")
#  end
#
# ##---2D steady-state heat transfer SparseArrays---###
#  include("inputs/input.jl")
#  @time begin
#  M=mesh(E,dl) #Mesh matrix -- function on matrix of geometry, materials and boundary conditions (E) included from input.jl
#  end
#  #M=readdlm("projects/HM_T/mesh.csv",',');	#Reading already defined mesh
#  @time begin
#  Ns=nsort(E,M,dl)
#  end
#  @time begin
#  Con=con1(E,M,dl,Ns)
#  end
#  @time begin
#  Spar=Kspar_ss(M,Con,dl)
#  end
#  K=Spar[1]
#  f=Spar[2]
#  @time begin
#  x=cg_lanczos(K,f)[1]
#  end
#
#  # @time begin
#  # K2=Kmat2(M,Con,dl)
#  # k2=K2[1];f=K2[2]
#  # kinv=inv(k2)
#  # x=kinv*f
#  M2=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]#M2=[["x_coord" "y_coord"];M[:,3:4]]#M2=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]#
#  Z0_vect=zeros(size(M2)[1]-1)#Z0_vect=zeros(size(M)[1])#Z0_vect=zeros(size(M2)[1]-1)#
#  Z0_vect=["z_coord";Z0_vect]#Z0_vect=["z_coord";Z0_vect]#Z0_vect=["z_coord";Z0_vect]#
#  x1=["temp";x]#x1=["temp";x;M[size(x)[1]+1:end,7]]#x1=["temp";x]#
#  writedlm("results/paraview_input.csv",  [M2 Z0_vect x1], ',')#writedlm("results/paraview_results.csv",  [M2 Z0_vect x1], ',')
#  # end
#  xres=[x;M[size(x)[1]+1:end,7]]; #results with BC
#
# ###---2D steady-state heat transfer SparseArrays---###
#
#  include("inputs/input.jl")
#  @time begin
#  M=mesh(E,dl) #Mesh matrix -- function on matrix of geometry, materials and boundary conditions (E) included from input.jl
#  end
#  #M=readdlm("projects/HM_T/mesh.csv",',');	#Reading already defined mesh
#  @time begin
#  Ns=nsort(E,M,dl)
#  end
#  @time begin
#  Con=con1(E,M,dl,Ns)
#  end
#  @time begin
#  Spar=Kspar_ss(M,Con,dl)
#  end
#  K=Spar[1]
#  f=Spar[2]
#  @time begin
#  x=cg_lanczos(K,f)[1]
#  end
#
#  # @time begin
#  # K2=Kmat2(M,Con,dl)
#  # k2=K2[1];f=K2[2]
#  # kinv=inv(k2)
#  # x=kinv*f
#  M2=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]#M2=[["x_coord" "y_coord"];M[:,3:4]]#M2=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]#
#  Z0_vect=zeros(size(M2)[1]-1)#Z0_vect=zeros(size(M)[1])#Z0_vect=zeros(size(M2)[1]-1)#
#  Z0_vect=["z_coord";Z0_vect]#Z0_vect=["z_coord";Z0_vect]#Z0_vect=["z_coord";Z0_vect]#
#  x1=["temp";x]#x1=["temp";x;M[size(x)[1]+1:end,7]]#x1=["temp";x]#
#  writedlm("results/paraview_input.csv",  [M2 Z0_vect x1], ',')#writedlm("results/paraview_results.csv",  [M2 Z0_vect x1], ',')
#  # end
#  xres=[x;M[size(x)[1]+1:end,7]]; #results with BC
#
# ###---2D transient heat transfer SparseArrays---###
#
#  println("Calculation started!")
#  @time begin
#  include("inputs/input.jl")
#  M=mesh(E,dl)
#  M2=copy(M)
#  Ns=nsort(E,M,dl)
#  Con=con1(E,M,dl,Ns)
#  Spar=Kspar_t(M,Con,dl,dt)
#  K=Spar[1]
#  f=Spar[2]
#  x_in=10*ones(size(K)[1])
#  #Temp_e=readdlm("inputs/Cos_1_240.csv",',')
#  #t_e_ind1=floor(Int64,Ns[4][1,1])	#global IDs of left - exterior BC
#  #t_e_ind2=floor(Int64,Ns[4][end,1])	#
#  #Temp_i=20*ones(size(K)[1])
#  #t_i_ind1=floor(Int64,Ns[6][1,1])	#global IDs of right - interior BC
#  #t_i_ind2=floor(Int64,Ns[6][end,1])	#
#  for i=1:floor(Int64,round(T/dt))
#  	# for j=t_e_ind1:t_e_ind2
#  	# 	M2[j,7]=Temp_e[i]
#  	# end
#  	# for j=t_i_ind1:t_i_ind2
#  	# 	M2[j,7]=Temp_i[i]
#  	# end
#  	#global Spar=Kspar_t(M2,Con,dl,dt)
#  	#global K2=Spar[1]
#  	println("Timestep $i")
#  	@time begin
#  	global ft=init(x_in,M2,dl,dt)
#  	global f2=f+ft
#  	global x1=cg_lanczos(K,f2)[1]
#  	global M3=[["x_coord" "y_coord"];M2[1:(size(x1)[1]),3:4]]
#  	global Z0_vect=zeros(size(M3)[1]-1)
#  	global Z0_vect=["z_coord";Z0_vect]
#  	global xx=["temp";x1]
#  	writedlm("results/transient/input_ss_to_tr/iss$i.csv",  [M3 Z0_vect xx], ',')
#  	global x_in=copy(x1)
#  	end
#  end
#  println("End of calculation!")
#  end
#
###---2D transient heat and mass transfer SparseArrays---###
 println("Calculation started!")
 @time begin
 include("inputs/input.jl")
 include("environmental.jl")		#Environmental hourly BC --> Tem{Float64}(2919,1), r_H{Float64}(2919,1) Ns[20]
 M=mesh(E,dl)
 Ns=nsort(E,M,dl)
 Con=con1(E,M,dl,Ns)
 Spar=Kspar_ss(M,Con,dl)
 K=Spar[1]
 f=Spar[2]
 x_t_in=cg_lanczos(K,f)[1]
 M2=[["x_coord" "y_coord"];M[1:(size(x_t_in)[1]),3:4]]
 Z0_vect=zeros(size(M2)[1]-1)
 Z0_vect=["z_coord";Z0_vect]
 xx=["temp";x_t_in]
 writedlm("results/transient/input_HM/t/t0.csv", [M2 Z0_vect xx], ',')
 x_m_in=0.1*ones(size(x_t_in)[1])
 xx=["temp";x_m_in]
 writedlm("results/transient/input_HM/m/m0.csv",  [M2 Z0_vect xx], ',')
 t_e_ind1=floor(Int64,Ns[20][1,1])
 t_e_ind2=floor(Int64,Ns[20][end,1])
 s1_1=floor(Int64,Ns[17][1,1])
 s1_2=floor(Int64,Ns[17][end,1])
 s2_1=floor(Int64,Ns[18][1,1])
 s2_2=floor(Int64,Ns[18][end,1])
 s3_1=floor(Int64,Ns[19][1,1])
 s3_2=floor(Int64,Ns[19][end,1])
 s4_1=floor(Int64,Ns[25][1,1])
 s4_2=floor(Int64,Ns[25][end,1])
 s5_1=floor(Int64,Ns[26][1,1])
 s5_2=floor(Int64,Ns[26][end,1])
 s6_1=floor(Int64,Ns[27][1,1])
 s6_2=floor(Int64,Ns[27][end,1])
 inrH_1=floor(Int64,Ns[22][1,1])
 inrH_2=floor(Int64,Ns[23][end,1])
 Mt=copy(M)
 Mm=copy(M)
 for i=inrH_1:inrH_2
 	Mm[i,7]=0.5
 end
 for i=1:744
 	@time begin
 	println("Timestep $i")
 	for j=t_e_ind1:t_e_ind2
 		Mt[j,7]=Tem[i]
 	end
 	for j=s1_1:s1_2
 		Mt[j,7]=soil3(Mt[j,4])
 	end
 	for j=s2_1:s2_2
 		Mt[j,7]=soil3(Mt[j,4])
 	end
 	for j=s3_1:s3_2
 		Mt[j,7]=soil3(Mt[j,4])
 	end
 	for j=s4_1:s4_2
 		Mt[j,7]=soil3(Mt[j,4])
 	end
 	for j=s5_1:s5_2
 		Mt[j,7]=soil3(Mt[j,4])
 	end
 	for j=s6_1:s6_2
 		Mt[j,7]=soil3(Mt[j,4])
 	end
 	global Spar=Kspar_t(Mt,Con,dl,dt)
 	global Ktem=Spar[1]
 	global fk=Spar[2]
 	global ft=init(x_t_in,Mt,dl,dt)
 	global ftem=fk+ft
 	global x_t=cg_lanczos(Ktem,ftem)[1]
 	global M2=[["x_coord" "y_coord"];Mt[1:(size(x_t)[1]),3:4]]
 	global Z0_vect=zeros(size(M2)[1]-1)
 	global Z0_vect=["z_coord";Z0_vect]
 	global xx=["temp";x_t]
 	#writedlm("results/transient/input_HM/t/t$i.csv",  [M2 Z0_vect xx], ',')
 	global x_t_in=copy(x_t)
 	global Mm=moist(Mm,x_t_in,x_m_in)
 	for j=t_e_ind1:t_e_ind2
 		Mm[j,7]=r_H[i]
 	end
 	for j=s1_1:s1_2
 		Mm[j,7]=0.95
 	end
 	for j=s2_1:s2_2
 		Mm[j,7]=0.95
 	end
 	for j=s3_1:s3_2
 		Mm[j,7]=0.80
 	end
 	for j=s4_1:s4_2
 		Mm[j,7]=0.95
 	end
 	for j=s5_1:s5_2
 		Mm[j,7]=0.95
 	end
 	for j=s6_1:s6_2
 		Mm[j,7]=0.80
 	end
 	global Spar2=Kspar_t(Mm,Con,dl,dt)
 	global Kmoi=Spar2[1]
 	global fkm=Spar2[2]
 	global ftm=init(x_m_in,Mm,dl,dt)
 	global fmoi=fkm+ftm
 	global x_m=cg_lanczos(Kmoi,fmoi)[1]
 	if i==1
 		global M2=[["x_coord" "y_coord"];Mm[1:(size(x_m)[1]),3:4]]
 		global xx=["temp";x_m]
 		writedlm("results/transient/input_HM/m/m$i.csv",  [M2 Z0_vect xx], ',')
 	end
 	if mod(i,24)==0
 		global M2=[["x_coord" "y_coord"];Mm[1:(size(x_m)[1]),3:4]]
 		global xx=["temp";x_m]
 		writedlm("results/transient/input_HM/m/m$i.csv",  [M2 Z0_vect xx], ',')
 	end
 	global x_m_in=copy(x_m)
 	end #time
 end
 for i=745:1464
 		@time begin
 		println("Timestep $i")
 		for j=t_e_ind1:t_e_ind2
 			Mt[j,7]=Tem[i]
 		end
 		for j=s1_1:s1_2
 			Mt[j,7]=soil4(Mt[j,4])
 		end
 		for j=s2_1:s2_2
 			Mt[j,7]=soil4(Mt[j,4])
 		end
 		for j=s3_1:s3_2
 			Mt[j,7]=soil4(Mt[j,4])
 		end
 		for j=s4_1:s4_2
 			Mt[j,7]=soil4(Mt[j,4])
 		end
 		for j=s5_1:s5_2
 			Mt[j,7]=soil4(Mt[j,4])
 		end
 		for j=s6_1:s6_2
 			Mt[j,7]=soil4(Mt[j,4])
 		end
 		global Spar=Kspar_t(Mt,Con,dl,dt)
 		global Ktem=Spar[1]
 		global fk=Spar[2]
 		global ft=init(x_t_in,Mt,dl,dt)
 		global ftem=fk+ft
 		global x_t=cg_lanczos(Ktem,ftem)[1]
 		global M2=[["x_coord" "y_coord"];Mt[1:(size(x_t)[1]),3:4]]
 		global Z0_vect=zeros(size(M2)[1]-1)
 		global Z0_vect=["z_coord";Z0_vect]
 		global xx=["temp";x_t]
 		#writedlm("results/transient/input_HM/t/t$i.csv",  [M2 Z0_vect xx], ',')
 		global x_t_in=copy(x_t)
 		global Mm=moist(Mm,x_t_in,x_m_in)
 		global Spar2=Kspar_t(Mm,Con,dl,dt)
 		global Kmoi=Spar2[1]
 		global fkm=Spar2[2]
 		global ftm=init(x_m_in,Mm,dl,dt)
 		global fmoi=fkm+ftm
 		global x_m=cg_lanczos(Kmoi,fmoi)[1]
 		if mod(i,24)==0
 			global M2=[["x_coord" "y_coord"];Mm[1:(size(x_m)[1]),3:4]]
 			global xx=["temp";x_m]
 			writedlm("results/transient/input_HM/m/m$i.csv",  [M2 Z0_vect xx], ',')
 		end
 		global x_m_in=copy(x_m)
 		end #time
 end
 for i=1465:2208
 		@time begin
 		println("Timestep $i")
 		for j=t_e_ind1:t_e_ind2
 			Mt[j,7]=Tem[i]
 		end
 		for j=s1_1:s1_2
 			Mt[j,7]=soil5(Mt[j,4])
 		end
 		for j=s2_1:s2_2
 			Mt[j,7]=soil5(Mt[j,4])
 		end
 		for j=s3_1:s3_2
 			Mt[j,7]=soil5(Mt[j,4])
 		end
 		for j=s4_1:s4_2
 			Mt[j,7]=soil5(Mt[j,4])
 		end
 		for j=s5_1:s5_2
 			Mt[j,7]=soil5(Mt[j,4])
 		end
 		for j=s6_1:s6_2
 			Mt[j,7]=soil5(Mt[j,4])
 		end
 		global Spar=Kspar_t(Mt,Con,dl,dt)
 		global Ktem=Spar[1]
 		global fk=Spar[2]
 		global ft=init(x_t_in,Mt,dl,dt)
 		global ftem=fk+ft
 		global x_t=cg_lanczos(Ktem,ftem)[1]
 		global M2=[["x_coord" "y_coord"];Mt[1:(size(x_t)[1]),3:4]]
 		global Z0_vect=zeros(size(M2)[1]-1)
 		global Z0_vect=["z_coord";Z0_vect]
 		global xx=["temp";x_t]
 		#writedlm("results/transient/input_HM/t/t$i.csv",  [M2 Z0_vect xx], ',')
 		global x_t_in=copy(x_t)
 		global Mm=moist(Mm,x_t_in,x_m_in)
 		global Spar2=Kspar_t(Mm,Con,dl,dt)
 		global Kmoi=Spar2[1]
 		global fkm=Spar2[2]
 		global ftm=init(x_m_in,Mm,dl,dt)
 		global fmoi=fkm+ftm
 		global x_m=cg_lanczos(Kmoi,fmoi)[1]
 		if mod(i,24)==0
 			global M2=[["x_coord" "y_coord"];Mm[1:(size(x_m)[1]),3:4]]
 			global xx=["temp";x_m]
 			writedlm("results/transient/input_HM/m/m$i.csv",  [M2 Z0_vect xx], ',')
 		end
 		global x_m_in=copy(x_m)
 		end #time
 end
 for i=2209:2919
 		@time begin
 		println("Timestep $i")
 		for j=t_e_ind1:t_e_ind2
 			Mt[j,7]=Tem[i]
 		end
 		for j=s1_1:s1_2
 			Mt[j,7]=soil6(Mt[j,4])
 		end
 		for j=s2_1:s2_2
 			Mt[j,7]=soil6(Mt[j,4])
 		end
 		for j=s3_1:s3_2
 			Mt[j,7]=soil6(Mt[j,4])
 		end
 		for j=s4_1:s4_2
 			Mt[j,7]=soil6(Mt[j,4])
 		end
 		for j=s5_1:s5_2
 			Mt[j,7]=soil6(Mt[j,4])
 		end
 		for j=s6_1:s6_2
 			Mt[j,7]=soil6(Mt[j,4])
 		end
 		global Spar=Kspar_t(Mt,Con,dl,dt)
 		global Ktem=Spar[1]
 		global fk=Spar[2]
 		global ft=init(x_t_in,Mt,dl,dt)
 		global ftem=fk+ft
 		global x_t=cg_lanczos(Ktem,ftem)[1]
 		global M2=[["x_coord" "y_coord"];Mt[1:(size(x_t)[1]),3:4]]
 		global Z0_vect=zeros(size(M2)[1]-1)
 		global Z0_vect=["z_coord";Z0_vect]
 		global xx=["temp";x_t]
 		#writedlm("results/transient/input_HM/t/t$i.csv",  [M2 Z0_vect xx], ',')
 		global x_t_in=copy(x_t)
 		global Mm=moist(Mm,x_t_in,x_m_in)
 		global Spar2=Kspar_t(Mm,Con,dl,dt)
 		global Kmoi=Spar2[1]
 		global fkm=Spar2[2]
 		global ftm=init(x_m_in,Mm,dl,dt)
 		global fmoi=fkm+ftm
 		global x_m=cg_lanczos(Kmoi,fmoi)[1]
 		if mod(i,24)==0
 			global M2=[["x_coord" "y_coord"];Mm[1:(size(x_m)[1]),3:4]]
 			global xx=["temp";x_m]
 			writedlm("results/transient/input_HM/m/m$i.csv",  [M2 Z0_vect xx], ',')
 		end
 		if i==2919
 			global M2=[["x_coord" "y_coord"];Mm[1:(size(x_m)[1]),3:4]]
 			global xx=["temp";x_m]
 			writedlm("results/transient/input_HM/m/m$i.csv",  [M2 Z0_vect xx], ',')
 		end
 		global x_m_in=copy(x_m)
 		end #time
end
println("End of calculation!")
end #time
