#--------------------------------------------------------------------#
#     Input data used for heat and moisture transfer calculation     #
#--------------------------------------------------------------------#

#DODATI RUBNE UVJETE


#########
#Timestep if necessary#
##########

#dt=1        #Timestep in h
#T=8760      #Time domain

###########
#Mesh size#
###########

dl=0.005 #defined in m


########################
#Geometry and materials#
########################

#Elements -- matrix of vectors E_1=[material_key,x_0,y_0,x_1,y_1] to E_n

ne=5 #number of elements

E=zeros(Float64,ne,9) #Geometry and material matrix + boundary conditions

#Element 1 (Concrete)
E[1,1]=12
E[1,2]=0
E[1,3]=0
E[1,4]=0.4
E[1,5]=0.8
E[1,6]=1
E[1,7]=1
E[1,8]=1
E[1,9]=1

##############################
#Boundary condition materials#
##############################

#Element 17 (dolje)
E[2,1]=100
E[2,2]=0
E[2,3]=-dl
E[2,4]=0.4
E[2,5]=0
E[2,6]=17
E[2,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[2,8]=0
E[2,9]=1

#Element 18 (lijevo)
E[3,1]=101
E[3,2]=-dl
E[3,3]=0
E[3,4]=0
E[3,5]=0.8
E[3,6]=18
E[3,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[3,8]=0
E[3,9]=1

#Element 19 (gore)
E[4,1]=102
E[4,2]=0
E[4,3]=0.8
E[4,4]=0.4
E[4,5]=0.8+dl
E[4,6]=19
E[4,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[4,8]=20
E[4,9]=1

#Element 20 (desno)
E[5,1]=103
E[5,2]=0.4
E[5,3]=0
E[5,4]=0.4+dl
E[5,5]=0.8
E[5,6]=20
E[5,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[5,8]=20
E[5,9]=-1
