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

dl=0.0005 #defined in m


########################
#Geometry and materials#
########################

#Elements -- matrix of vectors E_1=[material_key,x_0,y_0,x_1,y_1] to E_n

ne=12 #number of elements

E=zeros(Float64,ne,9) #Geometry and material matrix + boundary conditions

#Element 1
E[1,1]=12
E[1,2]=0
E[1,3]=0
E[1,4]=0.5
E[1,5]=0.0015
E[1,6]=1
E[1,7]=230
E[1,8]=1
E[1,9]=1

#Element 2
E[2,1]=12
E[2,2]=0
E[2,3]=0.0015
E[2,4]=0.0015
E[2,5]=0.0365
E[2,6]=2
E[2,7]=230
E[2,8]=1
E[2,9]=1

#Element 3
E[3,1]=12
E[3,2]=0.0015
E[3,3]=0.0015
E[3,4]=0.5
E[3,5]=0.035
E[3,6]=3
E[3,7]=0.029
E[3,8]=1
E[3,9]=1

#Element 4
E[4,1]=12
E[4,2]=0
E[4,3]=0.035
E[4,4]=0.015
E[4,5]=0.0365
E[4,6]=4
E[4,7]=230
E[4,8]=1
E[4,9]=1

#Element 5
E[5,1]=12
E[5,2]=0.015
E[5,3]=0.035
E[5,4]=0.5
E[5,5]=0.0365
E[5,6]=5
E[5,7]=0.029
E[5,8]=1
E[5,9]=1

#Element 6
E[6,1]=12
E[6,2]=0
E[6,3]=0.0365
E[6,4]=0.015
E[6,5]=0.0415
E[6,6]=6
E[6,7]=0.12
E[6,8]=1
E[6,9]=1

#Element 7
E[7,1]=12
E[7,2]=0.015
E[7,3]=0.0365
E[7,4]=0.5
E[7,5]=0.0415
E[7,6]=7
E[7,7]=0.029
E[7,8]=1
E[7,9]=1

#Element 8
E[8,1]=12
E[8,2]=0
E[8,3]=0.0415
E[8,4]=0.5
E[8,5]=0.0475
E[8,6]=8
E[8,7]=1.15
E[8,8]=1
E[8,9]=1

##############################
#Boundary condition materials#
##############################

#Element 17 (dolje)
E[9,1]=100
E[9,2]=0
E[9,3]=-dl
E[9,4]=0.5
E[9,5]=0
E[9,6]=17
E[9,7]=(9.09)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[9,8]=20
E[9,9]=1

#Element 18 (lijevo)
E[10,1]=101
E[10,2]=-dl
E[10,3]=0
E[10,4]=0
E[10,5]=0.0475
E[10,6]=18
E[10,7]=(1)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[10,8]=0
E[10,9]=-1

#Element 19 (gore)
E[11,1]=102
E[11,2]=0
E[11,3]=0.0475
E[11,4]=0.5
E[11,5]=0.0475+dl
E[11,6]=19
E[11,7]=(16.67)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[11,8]=0
E[11,9]=1

#Element 20 (desno)
E[12,1]=103
E[12,2]=0.5
E[12,3]=0
E[12,4]=0.5+dl
E[12,5]=0.0475
E[12,6]=20
E[12,7]=(1)*2/dl #Assign as (h)*dl/2 if h is convection coef.
E[12,8]=20
E[12,9]=-1
