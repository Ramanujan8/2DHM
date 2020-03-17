###Functions used for heat and moisture transfer calculation####

function mesh(E,dl)	#Asigning a material key to certain point
	id=1
	dim=Array{Int64}(undef,size(E)[1],2)
	for i=1:size(E)[1]
		xmin=minimum([minimum(E[i,2]),minimum(E[i,4])])
		xmax=maximum([maximum(E[i,2]),maximum(E[i,4])])
		ymin=minimum([minimum(E[i,3]),minimum(E[i,5])])
		ymax=maximum([maximum(E[i,3]),maximum(E[i,5])])
		x=xmin
		y=ymin
		eps=10e-7
		xd=(xmax-xmin)
		yd=(ymax-ymin)
		nx=xd/dl
		nx=round(nx)
		if abs(nx-round(nx))>eps
			println("ERROR! Incorrect subdivision!") #Subdivision is constant and divisible with element's xd and yd
			break
		end
		nx=floor(Int64,nx)
		ny=yd/dl
		ny=round(ny)
		if abs(ny-round(ny))>eps
			println("ERROR! Incorrect subdivision!")
			break
		end
		ny=floor(Int64,ny)
		dim[i,1]=nx
		dim[i,2]=ny
		y=ymin+dl/2
		Md=zeros(nx*ny,8)
		for j=1:ny
			x=xmin+dl/2
			for k=1:nx
				#Md=[Md;round(x,digits=3) round(y,digits=3) E[i,1]]
				Md[(j-1)*nx+k,1]=id
				Md[(j-1)*nx+k,2]=(j-1)*nx+k
				Md[(j-1)*nx+k,3]=x
				Md[(j-1)*nx+k,4]=y
				Md[(j-1)*nx+k,5]=E[i,1]
				Md[(j-1)*nx+k,6]=E[i,7]
				Md[(j-1)*nx+k,7]=E[i,8]
				Md[(j-1)*nx+k,8]=E[i,9]
				x=x+dl
				id=id+1
			end
			y=y+dl
		end
		writedlm("mesh/mesh$i.csv",  Md, ',')
	end
	M2=readdlm("mesh/mesh1.csv",',')
	for i=2:size(E)[1]
		m2=readdlm("mesh/mesh$i.csv",',')
		M2=[M2;m2]
	end
	writedlm("mesh/mesh.csv",  M2, ',')
	#for i=1:16
		#rm("mesh/mesh$i.csv", recursive=true)
	#end
	Md=copy(M2)
	Md=[["id_glob" "id_loc" "x_coord" "y_coord" "material" "lambda" "rho" "cp"];Md]
	Z0_vect=zeros((size(Md)[1]-1))
	Z0_vect=["z_coord";Z0_vect]
	writedlm("mesh/paraview_mesh.csv",  [Md Z0_vect], ',')
	writedlm("mesh/dim.csv",  dim, ',')
	M2=M2
end
####End of function mesh(E,dl)####
function nsort(E,M,dl)
	M_ele=Vector{Any}(undef,size(E)[1])
	for i=1:size(E)[1]
		M_ele[i,1]=readdlm("mesh/mesh$i.csv",',')
	end
	#for i=1:size(E)[1]
		#rm("mesh/mesh$i.csv", recursive=true)
	#end
	Nsort=M_ele
end
####End of function nsort(E,M,dl)####
function mappoint(E,Ns,x1,y1)	#Connection between nodes
	ind1=[1]
	for k=1:size(E)[1]
		if E[k,1]>99
			ind1[1]=k
			break
		end
	end
	ind1=ind1[1]#-1
	k=floor(Int64,ind1)
	el_id=[1]
	p=[x1 y1]
	for i=1:k
		for j=1:size(E)[1]
			if j!=i
				if (p[1]>E[j,2])&(p[1]<E[j,4])&(p[2]>E[j,3])&(p[2]<E[j,5])
					el_id[1]=j
				elseif (p[1]>E[j,2])&(p[1]<E[j,4])&(p[2]>E[j,3])&(p[2]<E[j,5])
					el_id[1]=j
				elseif (p[1]>E[j,2])&(p[1]<E[j,4])&(p[2]>E[j,3])&(p[2]<E[j,5])
					el_id[1]=j
				elseif (p[1]>E[j,2])&(p[1]<E[j,4])&(p[2]>E[j,3])&(p[2]<E[j,5])
					el_id[1]=j
				end
			end
		end
	end
	el_id=floor(Int64,el_id[1])
end
####End of function con2(E,M,dl,Ns)####
function elecon(xp,yp,E,Ns,dl,neig,mat)#(idp,E,Ns,dl,neig,mat)
	#xp=mat[idp,3]
	#yp=mat[idp,4]
	eps=10e-6
	glob_id=[1]
	dim=readdlm("mesh/dim.csv",',')
	#left neighbour
	if neig==2
		xl=xp-dl
		yl=yp
		el_id=mappoint(E,Ns,xl,yl)
		mat2=Ns[el_id]
		nx=floor(Int64,dim[el_id,1])
		ny=floor(Int64,dim[el_id,2])
		for zz=1:ny
			if (abs(xl-mat2[zz*nx,3])<eps)&(abs(yl-mat2[zz*nx,4])<eps)
				glob_id[1]=mat2[zz*nx,1]
			end
		end
	end
	#right
	if neig==3
		xr=xp+dl
		yr=yp
		el_id=mappoint(E,Ns,xr,yr)
		mat2=Ns[el_id]
		nx=floor(Int64,dim[el_id,1])
		ny=floor(Int64,dim[el_id,2])
		for zz=1:ny
			if (abs(xr-mat2[(zz-1)*nx+1,3])<eps)&(abs(yr-mat2[(zz-1)*nx+1,4])<eps)
				glob_id[1]=mat2[(zz-1)*nx+1,1]
			end
		end
	end
	#down
	if neig==4
		xd=xp
		yd=yp-dl
		el_id=mappoint(E,Ns,xd,yd)
		mat2=Ns[el_id]
		nx=floor(Int64,dim[el_id,1])
		ny=floor(Int64,dim[el_id,2])
		for zz=1:nx
			if (abs(xd-mat2[(ny-1)*nx+zz,3])<eps)&(abs(yd-mat2[(ny-1)*nx+zz,4])<eps)
				glob_id[1]=mat2[(ny-1)*nx+zz,1]
			end
		end
	end
	#up
	if neig==5
		xu=xp
		yu=yp+dl
		el_id=mappoint(E,Ns,xu,yu)
		mat2=Ns[el_id]
		nx=floor(Int64,dim[el_id,1])
		ny=floor(Int64,dim[el_id,2])
		for zz=1:nx
			if (abs(xu-mat2[zz,3])<eps)&(abs(yu-mat2[zz,4])<eps)
				glob_id[1]=mat2[zz,1]
			end
		end
	end
	glob_id=floor(Int64,glob_id[1])
end
####End of function elecon(x,y,M,mat)####
function con1(E,M,dl,Ns)	#Connection between nodes
	ind1=[1 1]
	for k=1:size(E)[1]
		if E[k,1]>99
			ind1[1]=Ns[k][1,1]-1
			ind1[2]=k
			break
		end
	end
	ind=floor(Int64,ind1[1])
	k=floor(Int64,ind1[2]-1)
	C=Array{Int64}(undef,ind,5)
	dim=readdlm("mesh/dim.csv",',')
	C[:,1]=M[1:ind,1]
	for i=1:k
		mat=Ns[i]
		nx=floor(Int64,dim[i,1])
		ny=floor(Int64,dim[i,2])
		for j=1:nx*ny
			if mod((j-1),nx)==0
				left=2
				C[floor(Int64,mat[j,1]),2]=elecon(mat[j,3],mat[j,4],E,Ns,dl,left,mat)
				C[floor(Int64,mat[j,1]),3]=M[floor(Int64,mat[j,1])+1,1]
				if j>1
					C[floor(Int64,mat[j,1]),4]=M[floor(Int64,mat[j,1])-nx,1]
				end
				if j<nx*ny#(nx*ny-1)
					C[floor(Int64,mat[j,1]),5]=M[floor(Int64,mat[j,1])+nx-1,1]+1
				end
			elseif mod(j,nx)==0
				right=3
				C[floor(Int64,mat[j,1]),3]=elecon(mat[j,3],mat[j,4],E,Ns,dl,right,mat)
				C[floor(Int64,mat[j,1]),2]=M[floor(Int64,mat[j,1])-1,1]
				if j<nx*ny
					C[floor(Int64,mat[j,1]),5]=M[floor(Int64,mat[j,1])+nx,1]
				end
				if j>nx
					C[floor(Int64,mat[j,1]),4]=M[floor(Int64,mat[j,1])-nx,1]
				end
			end
			if j<=nx
				down=4
				C[floor(Int64,mat[j,1]),4]=elecon(mat[j,3],mat[j,4],E,Ns,dl,down,mat)
			elseif j>=ny*nx-nx+1
				up=5
				C[floor(Int64,mat[j,1]),5]=elecon(mat[j,3],mat[j,4],E,Ns,dl,up,mat)
			end
			if (mod((j-1),nx)!=0)&(mod(j,nx)!=0)&(j>nx)&(j<ny*nx-nx)
				C[floor(Int64,mat[j,1]),2]=M[floor(Int64,mat[j,1])-1,1]
				C[floor(Int64,mat[j,1]),3]=M[floor(Int64,mat[j,1])+1,1]
				C[floor(Int64,mat[j,1]),4]=M[floor(Int64,mat[j,1])-nx,1]
				C[floor(Int64,mat[j,1]),5]=M[nx+floor(Int64,mat[j,1]),1]
			end
			if (j>1)&(j<nx)
				C[floor(Int64,mat[j,1]),2]=M[floor(Int64,mat[j,1])-1,1]
				C[floor(Int64,mat[j,1]),3]=M[floor(Int64,mat[j,1])+1,1]
				C[floor(Int64,mat[j,1]),5]=M[nx+floor(Int64,mat[j,1]),1]
			elseif (j>(ny*nx-nx+1))&(j<nx*ny)
				C[floor(Int64,mat[j,1]),2]=M[floor(Int64,mat[j,1])-1,1]
				C[floor(Int64,mat[j,1]),3]=M[floor(Int64,mat[j,1])+1,1]
				C[floor(Int64,mat[j,1]),4]=M[floor(Int64,mat[j,1])-nx,1]
			end
		end
	end
	#writedlm("mesh/Con.csv",  C, ',')
	C=C
end
####End of function con1(E,M,dl,Ns)####
function Kmat(M,C,dl,dt=0) 	#Conductivity matrix
	ind=Con[end,1]
	#K=Array{Any}(ind,5)
	K=Matrix{Any}(undef,ind,5)
	f=Matrix{Any}(undef,ind,2)
	if dt!=0
		for i=1:ind
			j=1
			if M[C[i,2],8]<0
				Kl=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kl=1/(1/(2*M[C[i,2],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,3],8]<0
				Kr=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kr=1/(1/(2*M[C[i,3],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,4],8]<0
				Kd=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kd=1/(1/(2*M[C[i,4],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,5],8]<0
				Ku=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Ku=1/(1/(2*M[C[i,5],6])+1/(2*M[C[i,1],6]))
			end
			a=M[C[i,1],7]*M[C[i,1],8]
			K[i,1]=[Con[i,1] a*dl^2/dt+Kl+Kr+Kd+Ku]
			f[i,1]=[1 0]
			f[i,2]=[1 0]
			if C[i,2]<=ind
				K[i,2]=[C[i,2] -Kl]
			else
				K[i,2]=[1 0]
				f[i,j]=[C[i,2] Kl]
				j=j+1
			end
			if C[i,3]<=ind
				K[i,3]=[C[i,3] -Kr]
			else
				K[i,3]=[1 0]
				f[i,j]=[C[i,3] Kr]
				j=j+1
			end
			if C[i,4]<=ind
				K[i,4]=[C[i,4] -Kd]
			else
				K[i,4]=[1 0]
				f[i,j]=[C[i,4] Kd]
				j=j+1
			end
			if C[i,5]<=ind
				K[i,5]=[C[i,5] -Ku]
			else
				K[i,5]=[1 0]
				f[i,j]=[C[i,5] Ku]
			end
		end
		K=[K f]
	else
		for i=1:ind
			j=1
			if M[C[i,2],8]<0
				Kl=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kl=1/(1/(2*M[C[i,2],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,3],8]<0
				Kr=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kr=1/(1/(2*M[C[i,3],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,4],8]<0
				Kd=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kd=1/(1/(2*M[C[i,4],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,5],8]<0
				Ku=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Ku=1/(1/(2*M[C[i,5],6])+1/(2*M[C[i,1],6]))
			end
			K[i,1]=[Con[i,1] (Kl+Kr+Kd+Ku)]
			f[i,1]=[1 0]
			f[i,2]=[1 0]
			if C[i,2]<=ind
				K[i,2]=[C[i,2] -Kl]
			else
				K[i,2]=[1 0]
				f[i,j]=[C[i,2] Kl]
				j=j+1
			end
			if C[i,3]<=ind
				K[i,3]=[C[i,3] -Kr]
			else
				K[i,3]=[1 0]
				f[i,j]=[C[i,3] Kr]
				j=j+1
			end
			if C[i,4]<=ind
				K[i,4]=[C[i,4] -Kd]
			else
				K[i,4]=[1 0]
				f[i,j]=[C[i,4] Kd]
				j=j+1
			end
			if C[i,5]<=ind
				K[i,5]=[C[i,5] -Ku]
			else
				K[i,5]=[1 0]
				f[i,j]=[C[i,5] Ku]
			end
		end
		K=[K f]
	end
	#writedlm("mesh/K.csv",  K, ',')
	#writedlm("mesh/f.csv",  f, ',')
	K=K
end
####End of function Kmat(M,con,dl)####
function modconjgrad(Km,M,dt=0,dl=0,x=0,in_con=0)
    if in_con==0
        b2=zeros(size(Km)[1],1)
	else
		b2=init(in_con,M,dl,dt)
    end
    if x==0
        x=ones(size(Km)[1],1)#rand(0:20,size(Km)[1],1)#ones(size(Km)[1],1)
    end
    b1=bcf(Km,M)
	b=b1+b2
    r=b-mult(Km,x)
    p=r
    rsold=(r'*r)[1]
	iter=1000#size(Km)[1] #iterations
	i=1
	j=1
    while i<iter#for i=1:10000#size(b)[1]
		@time begin
        Ap=mult(Km,p)
		#end
		#@time begin
        alpha=rsold/(p'*Ap)[1]
		#end
		#@time begin
        x=x+alpha*p
		#end
		#@time begin
		zz=mult(Km,p)
		#end
		#@time begin
		r=r-alpha*zz
		#end
		#@time begin
        rsnew=(r'*r)[1]
		println(sqrt(rsnew))
        if sqrt(rsnew)<1e-7
			println("Convergence 1e-7 achieved -- Number of iterations: $((j-1)*(iter-1)+i)")
			#M2=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]#M2=[["x_coord" "y_coord"];M[:,3:4]]#M=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]
			#Z0_vect=zeros(size(M2)[1]-1)#Z0_vect=zeros(size(M)[1])
			#Z0_vect=["z_coord";Z0_vect]#Z0_vect=["z_coord";Z0_vect]
			#x1=["temp";x]#x1=["temp";x;M[size(x)[1]+1:end,7]]
			#writedlm("results/paraview_results_Case2.csv",  [M2 Z0_vect x1], ',')#writedlm("results/paraview_results.csv",  [M2 Z0_vect x1], ',')
        	break
        end
        p=r+(rsnew/rsold)*p
        rsold=rsnew
		println(i)
		end
		x=x
		i=i+1
		if (i==(iter-1))&(sqrt(rsnew)<0.1)
			#x=x+rand(-5:5,size(Km)[1],1)
			i=1
			j=j+1
		end
		if i==iter#9999#size(b)[1]
			println("Convergence not achieved! Starting again!")
			i=1
			x=ones(size(Km)[1],1)
			b1=bcf(Km,M,const_bc,BC)
    		b=b1+b2
    		r=b-mult(Km,x)
    		p=r
    		rsold=(r'*r)[1]
			j=j+1
			#M=copy(M)
			#M=[["x_coord" "y_coord"];M[1:(size(x)[1]),3:4]]
			#Z0_vect=zeros((size(M)[1]-1))
			#Z0_vect=["z_coord";Z0_vect]
			#x1=["temp";x]
			#writedlm("results/paraview_results.csv",  [M Z0_vect x1], ',')
		end
		if j>20
			println("ERROR! Convergence was not achieved after $(j-1) iterations of $iter trials!")
			x=Array{Any}(undef,size(Km)[1],1)
			break
		end
    end
    x=x
	#writedlm("results/x.csv",  x, ',')
end
####End of function modconjgrad(Km,fm,x=0,in_con=0)####
function bcf(K,M)
	f=zeros(size(K)[1],1)
	pm=zeros(size(K)[1],5)

	for i=1:size(f)[1]
		#if floor(Int64,K[i,6][1])!=0
			pm[i,1]=i
			pm[i,2]=M[floor(Int64,K[i,6][1]),7]
			pm[i,3]=K[i,6][2]
		#end
		#if floor(Int64,K[i,7][1])!=0
			#pm[i,1]=i
			pm[i,4]=M[floor(Int64,K[i,7][1]),7]
			pm[i,5]=K[i,7][2]
		#end
	end
	for i in pm[:,1]
		#if i>0
			qq=floor(Int64,i)
			f[qq,1]=pm[qq,2]*pm[qq,3]+pm[qq,4]*pm[qq,5]
		#end
	end
	f=f
end
####End of function bcf(fm)####
function mult2(K,x)
	xres=zeros(size(K)[1],1)
	for i=1:size(xres)[1]
			if floor(Int64,K[i,1][1])!=0
				xres[i,1]=x[floor(Int64,K[i,1][1]),1]*K[i,1][2]
			end
			if floor(Int64,K[i,2][1])!=0
				xres[i,1]=xres[i,1]+x[floor(Int64,K[i,2][1]),1]*K[i,2][2]
			end
			if floor(Int64,K[i,3][1])!=0
				xres[i,1]=xres[i,1]+x[floor(Int64,K[i,3][1]),1]*K[i,3][2]
			end
			if floor(Int64,K[i,4][1])!=0
				xres[i,1]=xres[i,1]+x[floor(Int64,K[i,4][1]),1]*K[i,4][2]
			end
			if floor(Int64,K[i,5][1])!=0
				xres[i,1]=xres[i,1]+x[floor(Int64,K[i,5][1]),1]*K[i,5][2]
			end
	end
	xres=xres
end
####End of function mult(Km,p)####
###For defined vector b### !!!for max 5 interrelations!!! -->
function modconjgrad2(K,f,x=0,tol=1e-10)#M,x=0,in_con=0,const_bc=1,BC=0)
    if x==0
        x1=zeros(size(K)[1],1)
    end
    #b1=bcf(Km,M,const_bc,BC)
    #b=in_con+b1
    r=f-K*x1
	#println("r0=",r)
    p=copy(r)
    rsold=(r'*r)[1]
	@time begin
    for i=1:10000#size(b)[1]
		@time begin
		Ap=K*p
        alpha=rsold/(p'*Ap)[1]
		#println("Alpha=",alpha)
        x1=x1+alpha*p
		#println("x1=",x)
        r=r-alpha*(K*p)
		#println("r$i=",r)
        rsnew=(r'*r)[1]
		if sqrt(rsnew)<tol
			println("Number of iterations: $i")
            break
        end
        p=r+(rsnew/rsold)*p
		#println("p$i=",p)
        rsold=rsnew
		#println(i)
		if i==10000
			println("Convergence not achieved!")
		end
		end
	end
    end
    x1=x1
	#writedlm("results/x.csv",  x, ',')
end
####End of function modconjgrad(Km,fm,x=0,in_con=0)####
function mult(K,x)
	xres=zeros(size(K)[1],1)
	ind=size(xres)[1]
	KK=K[:,1:5]
	Threads.@threads for i=1:ind
		xres[i]=xres[i]+x[floor(Int64,K[i,1][1]),1]*K[i,1][2]
		xres[i]=xres[i]+x[floor(Int64,K[i,2][1]),1]*K[i,2][2]
		xres[i]=xres[i]+x[floor(Int64,K[i,3][1]),1]*K[i,3][2]
		xres[i]=xres[i]+x[floor(Int64,K[i,4][1]),1]*K[i,4][2]
		xres[i]=xres[i]+x[floor(Int64,K[i,5][1]),1]*K[i,5][2]
		# for j=1:5
		# 	xres[i]=xres[i]+x[floor(Int64,K[i,j][1]),1]*K[i,j][2]
		# end
	end
	xres=xres
end
####End of function mult(Km,p)####
function eqpla(x1,y1,z1,x2,y2,z2,x3,y3,z3,x4,y4,z4,x=9999,y=9999)
	zz=[z1,z2,z3,z4]
	p=0
	if x4>998
		p1=Vector([x1,y1,z1])
		p2=Vector([x2,y2,z2])
		p3=Vector([x3,y3,z3])
		v1=p3-p1
		v2=p2-p1
		cp=cross(v1,v2)
		a=cp[1]
		b=cp[2]
		c=cp[3]
		d=dot(cp,p3)
		if (x!=9999)&(y!=9999)
			zx=-(-a*x-b*y+d)/c
			#println("zx = $zx")
		end
		zx=zx
	end
	if 11111 in zz
		k=0
		for i=1:4
			if (zz[i]!=11111)&(zz[i]!=999)
				#println(zz)
				p=p+zz[i]
				k=k+1
			end
		end
		if (x!=9999)&(y!=9999)
			zx=p/k
			#println("zx = $zx")
		end
		zx=zx
	else
		p11=Vector([x1,y1,z1])
		p21=Vector([x2,y2,z2])
		p31=Vector([x3,y3,z3])
		v11=p31-p11
		v21=p21-p11
		cp1=cross(v11,v21)
		a1=cp1[1]
		b1=cp1[2]
		c1=cp1[3]
		d1=dot(cp1,p31)
		p12=Vector([x2,y2,z2])
		p22=Vector([x3,y3,z3])
		p32=Vector([x4,y4,z4])
		v12=p32-p12
		v22=p22-p12
		cp2=cross(v12,v22)
		a2=cp2[1]
		b2=cp2[2]
		c2=cp2[3]
		d2=dot(cp2,p32)
		p13=Vector([x3,y3,z3])
		p23=Vector([x4,y4,z4])
		p33=Vector([x1,y1,z1])
		v13=p33-p13
		v23=p23-p13
		cp3=cross(v13,v23)
		a3=cp3[1]
		b3=cp3[2]
		c3=cp3[3]
		d3=dot(cp3,p33)
		p14=Vector([x4,y4,z4])
		p24=Vector([x1,y1,z1])
		p34=Vector([x2,y2,z2])
		v14=p34-p14
		v24=p24-p14
		cp4=cross(v14,v24)
		a4=cp4[1]
		b4=cp4[2]
		c4=cp4[3]
		d4=dot(cp4,p34)
		a=0.25*(abs(a1)+abs(a2)+abs(a3)+abs(a4))
		b=0.25*(abs(b1)+abs(b2)+abs(b3)+abs(b4))
		c=0.25*(abs(c1)+abs(c2)+abs(c3)+abs(c4))
		d=0.25*(abs(d1)+abs(d2)+abs(d3)+abs(d4))
		#println("equation of plane is: $a x + $b y + $c z  $d = 0 ")
		if (x!=9999)&(y!=9999)
			zx=-(-a*x-b*y+d)/c
			#println("zx = $zx")
		end
		zx=zx
	end
end
####End of function eqpla(x1,y1,z1,x2,y2,z2,x3,y3,z3)####
function res(X,M,Con,dl,xp,yp)
	eps=1e-5
	temp=[9999.]
	j=1
	x=[999. 999. 999. 999.]
	y=[999. 999. 999. 999.]
	z=[999. 999. 999. 999.]
	if (xp>maximum(M[:,3]))|(xp<minimum(M[:,3]))|(yp>maximum(M[:,4]))|(yp<minimum(M[:,4]))
		println("ERROR! Check if the coordinates ($xp, $yp) are inside the domain!")
		return
	end
	for i=1:size(X)[1]
		if (abs(xp-M[i,3])<eps)&(abs(yp-M[i,4])<eps)
			temp[1]=X[i,1]
			zx=temp[1]
			println("Temperature of coordinate ($xp, $yp) is $zx")
			break
		end
		if ((sqrt((xp-M[i,3])^2+(yp-M[i,4])^2))<(dl*sqrt(2)))&((abs(xp-M[i,3])<dl)&(abs(yp-M[i,4])<dl))
			if i<=size(Con)[1]
				if (M[Con[i,1],8]==-1)|(M[Con[i,2],8]==-1)|(M[Con[i,3],8]==-1)|(M[Con[i,4],8]==-1)|(M[Con[i,5],8]==-1)
					x[j]=M[i,3]
					y[j]=M[i,4]
					z[j]=11111. #Key for adiabatic BC
					#println(z) ##
					j=j+1
					# temp[1]=eqpla(x[1],y[1],z[1],x[2],y[2],z[2],x[3],y[3],z[3],x[4],y[4],z[4],xp,yp)
					# zx=temp[1]
					# println("Temperature of coordinate ($xp, $yp) is $zx")
				else #If coordinate is not at adiabatic BC
					#println(M[i,:])
					x[j]=M[i,3]
					y[j]=M[i,4]
					z[j]=X[i,1]
					j=j+1
				end
			else
				#println(M[i,:])
				if M[i,8]==-1
					bb=1
					while bb<=size(Con)[1]
						if i==Con[bb,2]
							z[j]=X[bb,1]
							j=j+1
							#println(z)
						end
						bb=bb+1
					end
					bb=1
					while bb<=size(Con)[1]
						if i==Con[bb,3]
							z[j]=X[bb,1]
							j=j+1
							#println(z)
						end
						bb=bb+1
					end
					bb=1
					while bb<=size(Con)[1]
						if i==Con[bb,4]
							z[j]=X[bb,1]
							j=j+1
							#println(z)
						end
						bb=bb+1
					end
					bb=1
					while bb<=size(Con)[1]
						if i==Con[bb,5]
							z[j]=X[bb,1]
							j=j+1
							#println(z)
						end
						bb=bb+1
					end
				else
				x[j]=M[i,3]
				y[j]=M[i,4]
				z[j]=X[i,1]
				#println(M[i,1])
				#println(z)
				j=j+1
				end
			end
		end
	end
	if temp[1]>9998
		#println(z)
		temp[1]=eqpla(x[1],y[1],z[1],x[2],y[2],z[2],x[3],y[3],z[3],x[4],y[4],z[4],xp,yp)
		zx=temp[1]
		#println("Temperature of coordinate ($xp, $yp) is $zx")
	end
	zx=zx
end
####End of function results(X,xp,yp)####
function init(in_con,M,dl,dt)
	incon=zeros(size(in_con)[1])
	for i=1:size(incon)[1]
		incon[i]=in_con[i]*dl^2*M[i,7]*M[i,8]/dt
	end
	incon=Vector(incon)
end
####End of function init(in_con,M,dl,dt)
function Kspar_ss(M,C,dl) 	#Conductivity matrix
	ind=Con[end,1]
	I=ones(Int64, 5*ind)
	J=ones(Int64, 5*ind)
	V=zeros(Float64, 5*ind)
	f=zeros(Float64, ind)
	j=0
		for i=1:ind
			if M[C[i,2],8]<0
				Kl=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kl=1/(1/(2*M[C[i,2],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,3],8]<0
				Kr=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kr=1/(1/(2*M[C[i,3],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,4],8]<0
				Kd=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kd=1/(1/(2*M[C[i,4],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,5],8]<0
				Ku=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Ku=1/(1/(2*M[C[i,5],6])+1/(2*M[C[i,1],6]))
			end
			I[i+j]=i
			J[i+j]=Con[i,1]
			V[i+j]=Kl+Kr+Kd+Ku
			if C[i,2]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,2]
				V[i+j]=-Kl
			else
				f[i]=f[i]+Kl*M[C[i,2],7]
			end
			if C[i,3]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,3]
				V[i+j]=-Kr
			else
				f[i]=f[i]+Kr*M[C[i,3],7]
			end
			if C[i,4]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,4]
				V[i+j]=-Kd
			else
				f[i]=f[i]+Kd*M[C[i,4],7]
			end
			if C[i,5]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,5]
				V[i+j]=-Ku
			else
				f[i]=f[i]+Ku*M[C[i,5],7]
			end
		end
		# println(I)
		# println(J)
		# println(V)
		# println(find)
		# println(fval)
		K=sparse(I,J,V)
		f=sparsevec(f)
		Sind=[K,f]

	#writedlm("mesh/K.csv",  K, ',')
	#writedlm("mesh/f.csv",  f, ',')
	Sind=Sind
end
####End of function Kspar_ss(M,C,dl)
function Kspar_t(M,C,dl,dt) 	#Conductivity matrix
	ind=Con[end,1]
	I=ones(Int64, 5*ind)
	J=ones(Int64, 5*ind)
	V=zeros(Float64, 5*ind)
	f=zeros(Float64, ind)
	j=0
		for i=1:ind
			if M[C[i,2],8]<0
				Kl=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kl=1/(1/(2*M[C[i,2],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,3],8]<0
				Kr=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kr=1/(1/(2*M[C[i,3],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,4],8]<0
				Kd=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Kd=1/(1/(2*M[C[i,4],6])+1/(2*M[C[i,1],6]))
			end
			if M[C[i,5],8]<0
				Ku=1e-10#dl/2*(1/(M[C[i,1],6]))
			else
				Ku=1/(1/(2*M[C[i,5],6])+1/(2*M[C[i,1],6]))
			end
			a=M[C[i,1],7]*M[C[i,1],8]
			I[i+j]=i
			J[i+j]=Con[i,1]
			V[i+j]=a*dl^2/dt+Kl+Kr+Kd+Ku
			if C[i,2]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,2]
				V[i+j]=-Kl
			else
				f[i]=f[i]+Kl*M[C[i,2],7]
			end
			if C[i,3]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,3]
				V[i+j]=-Kr
			else
				f[i]=f[i]+Kr*M[C[i,3],7]
			end
			if C[i,4]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,4]
				V[i+j]=-Kd
			else
				f[i]=f[i]+Kd*M[C[i,4],7]
			end
			if C[i,5]<=ind
				j=j+1
				I[i+j]=i
				J[i+j]=Con[i,5]
				V[i+j]=-Ku
			else
				f[i]=f[i]+Ku*M[C[i,5],7]
			end
		end
		# println(I)
		# println(J)
		# println(V)
		# println(find)
		# println(fval)
		K=sparse(I,J,V)
		f=sparsevec(f)
		Sind=[K,f]

	#writedlm("mesh/K.csv",  K, ',')
	#writedlm("mesh/f.csv",  f, ',')
	Sind=Sind
end
####End of function Kspar_t(M,C,dl,dt)

function moist(M,x_t,x_m)
	δ=1.85e-10
	Mm=copy(M)
	for i=1:size(x_t)[1]
		if x_t[i]<0
			a=22.544
			θ=272.44
			psat=611*exp((a*x_t[i])/(θ-x_t[i]))
			μm=μ_m(x_m[i],M[i,5])
			Mm[i,6]=psat*δ/μm
			Mm[i,7]=dw_dϕ(x_m[i],M[i,5])
			Mm[i,8]=1
		else
			a=17.08
			θ=234.18
			psat=611*exp((a*x_t[i])/(θ-x_t[i]))
			μm=μ_m(x_m[i],M[i,5])
			Mm[i,6]=psat*δ/μm
			Mm[i,7]=dw_dϕ(x_m[i],M[i,5])
			Mm[i,8]=1
		end
	end
	for i=(size(x_t)[1]+1):floor(Int64,M[end,1])
		Mm[i,6]=1e-3
	end
	Mm=Mm
end
####End of function moist(M,x_t,x_m)
