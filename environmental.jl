#--------------------------------------------#
#    Environmental conditions rH and temperature    #
#--------------------------------------------#

using PlotlyJS
using DelimitedFiles
using LinearAlgebra
using Distributed
using DistributedArrays
using SparseArrays
using Krylov
# using ArrayFire
# using CUDAdrv, CUDAnative, CuArrays
Env=readdlm("inputs/environmental_year.csv",',')
Tem=Vector(undef,2919)	#hourly values from 3rd to 6th month (location Zagreb, year 2018... -9 h in final month)
r_H=Vector(undef,2919)	#hourly values from 3rd to 6th month (location Zagreb, year 2018... -9 h in final month)
j=1
for i=1:size(Env)[1]
	if (mod(Env[i,1],60)<=5)
		global j=j+1
	end
end
Env2=Array{Float64}(undef,j-1,3)
j=1
for i=1:size(Env)[1]
	if (mod(Env[i,1],60)<=5)
		Env2[j,1]=Env[i,1]
		Env2[j,2]=Env[i,2]
		Env2[j,3]=Env[i,3]
		global j=j+1
	end
end
j=1
for i=2:size(Env2)[1]
	if ~((Env2[i,1]-Env2[i-1,1])<=5)
		global j=j+1
	end
end
Env=Array{Float64}(undef,j-1,3)
j=1
for i=2:size(Env2)[1]
	if ~((Env2[i,1]-Env2[i-1,1])<=5)
		Env[j,1]=Env2[i,1]
		Env[j,2]=Env2[i,2]
		Env[j,3]=Env2[i,3]
		global j=j+1
	end
end
j=1
for i=2:size(Env)[1]
	if ~((Env[i,1]-Env[i-1,1])==60)
		global j=j+1
	end
end
Tem=Env[:,2]
r_H=Env[:,3]
function soil3(H)
	h=1.23-H
	if h<0.02
		7.8
	elseif h>=0.02&&h<0.05
		7.8-0.1/0.03*(h-0.02)
	elseif h>=0.05&&h<=0.1
		7.7+0.6/0.05*(h-0.05)
	elseif h>=0.1&&h<=0.2
		8.3-0.8/0.1*(h-0.1)
	elseif h>=0.2&&h<=0.3
		7.5-0.3/0.1*(h-0.2)
	elseif h>=0.3&&h<=0.5
		7.2-0.1/0.2*(h-0.3)
	elseif h>=0.5
		7.1
	end
end
function soil4(H)
	h=1.23-H
	if h<0.02
		13.1
	elseif h>=0.02&&h<0.05
		13.1-0.1/0.03*(h-0.02)
	elseif h>=0.05&&h<=0.1
		13.0+0.5/0.05*(h-0.05)
	elseif h>=0.1&&h<=0.2
		13.5-1.3/0.1*(h-0.1)
	elseif h>=0.2&&h<=0.3
		12.2-0.6/0.1*(h-0.2)
	elseif h>=0.3&&h<=0.5
		11.6-0.5/0.2*(h-0.3)
	elseif h>=0.5
		11.1-1.5/0.5*(h-0.5)
	end
end
function soil5(H)
	h=1.23-H
	if h<0.02
		20.5
	elseif h>=0.02&&h<0.05
		20.5-0.2/0.03*(h-0.02)
	elseif h>=0.05&&h<=0.1
		20.3+0.3/0.05*(h-0.05)
	elseif h>=0.1&&h<=0.2
		20.6-2/0.1*(h-0.1)
	elseif h>=0.2&&h<=0.3
		18.6-0.7/0.1*(h-0.2)
	elseif h>=0.3&&h<=0.5
		17.9-0.9/0.2*(h-0.3)
	elseif h>=0.5
		16.8-3/0.5*(h-0.5)
	end
end
function soil6(H)
	h=1.23-H
	if h<0.02
		24.8
	elseif h>=0.02&&h<0.05
		24.8-0.3/0.03*(h-0.02)
	elseif h>=0.05&&h<=0.1
		24.5+0.2/0.05*(h-0.05)
	elseif h>=0.1&&h<=0.2
		24.7-1.9/0.1*(h-0.1)
	elseif h>=0.2&&h<=0.3
		22.8-0.8/0.1*(h-0.2)
	elseif h>=0.3&&h<=0.5
		22-1.3/0.2*(h-0.3)
	elseif h>=0.5
		20.7-3.4/0.5*(h-0.5)
	end
end
