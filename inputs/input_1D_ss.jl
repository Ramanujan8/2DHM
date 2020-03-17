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

ne=6 #number of elements

E=zeros(Float64,ne,9) #Geometry and material matrix + boundary conditions

#Element 1 (XPS)
E[1,1]=14
E[1,2]=0
E[1,3]=0
E[1,4]=0.08
E[1,5]=1
E[1,6]=1
E[1,7]=0.035
E[1,8]=50
E[1,9]=1015

#Element 1 (Reinforced concrete)
E[2,1]=13
E[2,2]=0.08
E[2,3]=0
E[2,4]=0.28
E[2,5]=1
E[2,6]=2
E[2,7]=2.6
E[2,8]=2500
E[2,9]=1000

##############################
#Boundary condition materials#
##############################

#Element 17 (dolje)
E[3,1]=100
E[3,2]=0
E[3,3]=-dl
E[3,4]=0.28
E[3,5]=0
E[3,6]=3
E[3,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[3,8]=1
E[3,9]=-1

#Element 18 (lijevo)
E[4,1]=101
E[4,2]=-dl
E[4,3]=0
E[4,4]=0
E[4,5]=1
E[4,6]=4
E[4,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[4,8]=0
E[4,9]=1

#Element 19 (gore)
E[5,1]=102
E[5,2]=0
E[5,3]=1
E[5,4]=0.28
E[5,5]=1+dl
E[5,6]=5
E[5,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[5,8]=20
E[5,9]=-1

#Element 20 (desno)
E[6,1]=103
E[6,2]=0.28
E[6,3]=0
E[6,4]=0.28+dl
E[6,5]=1
E[6,6]=6
E[6,7]=(10000)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[6,8]=22
E[6,9]=1
