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

dl=0.005#defined in m


########################
#Geometry and materials#
########################

#Elements -- matrix of vectors E_1=[material_key,x_0,y_0,x_1,y_1] to E_n

ne=27 #number of elements

E=zeros(Float64,ne,9) #Geometry and material matrix + boundary conditions

#Element 1 (Concrete)
E[1,1]=12
E[1,2]=0
E[1,3]=0
E[1,4]=0.76
E[1,5]=0.08
E[1,6]=1
E[1,7]=2.6
E[1,8]=2500
E[1,9]=1000

#Element 2 (XPS)
E[2,1]=14
E[2,2]=0
E[2,3]=0.08
E[2,4]=0.08
E[2,5]=1
E[2,6]=2
E[2,7]=0.04
E[2,8]=30
E[2,9]=840

#Element 3 (Reinforced concrete)
E[3,1]=13
E[3,2]=0.08
E[3,3]=0.08
E[3,4]=0.68
E[3,5]=1
E[3,6]=3
E[3,7]=2.6
E[3,8]=2500
E[3,9]=1000

#Element 4 (Reinforced concrete)
E[4,1]=13
E[4,2]=0.16
E[4,3]=1
E[4,4]=0.68
E[4,5]=1.08
E[4,6]=4
E[4,7]=2.6
E[4,8]=2500
E[4,9]=1000

#Element 5 (XPS)
E[5,1]=14
E[5,2]=0
E[5,3]=1
E[5,4]=0.08
E[5,5]=1.08
E[5,6]=5
E[5,7]=0.04
E[5,8]=30
E[5,9]=840

#Element 6 (XPS)
E[6,1]=14
E[6,2]=0.08
E[6,3]=1.01
E[6,4]=0.15
E[6,5]=1.08
E[6,6]=6
E[6,7]=0.04
E[6,8]=30
E[6,9]=840

#Element 7 (PVC hydroinsulation)
E[7,1]=15
E[7,2]=0.08
E[7,3]=1
E[7,4]=0.16
E[7,5]=1.01
E[7,6]=7
E[7,7]=0.14
E[7,8]=1200
E[7,9]=1000

#Element 8 (PVC hydroinsulation)
E[8,1]=15
E[8,2]=0.15
E[8,3]=1.01
E[8,4]=0.16
E[8,5]=1.77
E[8,6]=8
E[8,7]=0.14
E[8,8]=1200
E[8,9]=1000

#Element 9 (XPS)
E[9,1]=14
E[9,2]=0.68
E[9,3]=0.08
E[9,4]=0.76
E[9,5]=1.08
E[9,6]=9
E[9,7]=0.04
E[9,8]=30
E[9,9]=840

#Element 10 (Concrete)
E[10,1]=12
E[10,2]=0.76
E[10,3]=1
E[10,4]=1.45
E[10,5]=1.08
E[10,6]=10
E[10,7]=2.6
E[10,8]=2500
E[10,9]=1000

#Element 11 (XPS)
E[11,1]=14
E[11,2]=0.07
E[11,3]=1.08
E[11,4]=0.15
E[11,5]=1.77
E[11,6]=11
E[11,7]=0.04
E[11,8]=30
E[11,9]=840

#Element 12 (Reinforced concrete)
E[12,1]=13
E[12,2]=0.16
E[12,3]=1.08
E[12,4]=0.36
E[12,5]=1.77
E[12,6]=12
E[12,7]=2.6
E[12,8]=2500
E[12,9]=1000

#Element 13 (PVC hydroinsulation)
E[13,1]=15
E[13,2]=0.36
E[13,3]=1.08
E[13,4]=0.37
E[13,5]=1.27
E[13,6]=13
E[13,7]=0.14
E[13,8]=1200
E[13,9]=1000

#Element 14 (PVC hydroinsulation)
E[14,1]=15
E[14,2]=0.37
E[14,3]=1.08
E[14,4]=1.45
E[14,5]=1.09
E[14,6]=14
E[14,7]=0.14
E[14,8]=1200
E[14,9]=1000

#Element 15 (Mineral wool)
E[15,1]=11
E[15,2]=0.37
E[15,3]=1.09
E[15,4]=1.45
E[15,5]=1.19
E[15,6]=15
E[15,7]=0.035
E[15,8]=100
E[15,9]=1030

#Element 16 (Cement screed)
E[16,1]=16
E[16,2]=0.37
E[16,3]=1.19
E[16,4]=1.45
E[16,5]=1.27
E[16,6]=16
E[16,7]=1.6
E[16,8]=2000
E[16,9]=1100

##############################
#Boundary condition materials#
##############################

#Element 17 (Constant temperature soil)
E[17,1]=100
E[17,2]=0
E[17,3]=-dl
E[17,4]=0.76
E[17,5]=0
E[17,6]=17
E[17,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[17,8]=0
E[17,9]=1

#Element 18 (Variable temperature soil 0-108 cm)
E[18,1]=101
E[18,2]=-dl
E[18,3]=0
E[18,4]=0
E[18,5]=1.08
E[18,6]=18
E[18,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[18,8]=0
E[18,9]=1

#Element 19 (Variable temperature soil 108-123 cm)
E[19,1]=102
E[19,2]=0.07-dl
E[19,3]=1.08
E[19,4]=0.07
E[19,5]=1.23
E[19,6]=19
E[19,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[19,8]=0
E[19,9]=1

#Element 20 (Environmental conditions)
E[20,1]=103
E[20,2]=0.07-dl
E[20,3]=1.23
E[20,4]=0.07
E[20,5]=1.77
E[20,6]=20
E[20,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[20,8]=0
E[20,9]=1

#Element 21 (Adiabatic boundary conditions)
E[21,1]=104
E[21,2]=0.07
E[21,3]=1.77
E[21,4]=0.36
E[21,5]=1.77+dl
E[21,6]=21
E[21,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[21,8]=1
E[21,9]=-1 #Adiabatic BC key --> -1

#Element 22 (Internal conditions)
E[22,1]=105
E[22,2]=0.36
E[22,3]=1.27
E[22,4]=0.36+dl
E[22,5]=1.77
E[22,6]=22
E[22,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[22,8]=20
E[22,9]=1

#Element 23 (Internal conditions)
E[23,1]=106
E[23,2]=0.36+dl
E[23,3]=1.27
E[23,4]=1.45
E[23,5]=1.27+dl
E[23,6]=23
E[23,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[23,8]=20
E[23,9]=1

#Element 24 (Adiabatic boundary conditions)
E[24,1]=107
E[24,2]=1.45
E[24,3]=1
E[24,4]=1.45+dl
E[24,5]=1.27
E[24,6]=24
E[24,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[24,8]=1
E[24,9]=-1 #Adiabatic BC key --> -1

#Element 25 (Constant temperature soil)
E[25,1]=108
E[25,2]=0.76+dl
E[25,3]=1-dl
E[25,4]=1.45
E[25,5]=1
E[25,6]=25
E[25,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[25,8]=0
E[25,9]=1

#Element 26 (Variable temperature soil 0-100 cm)
E[26,1]=109
E[26,2]=0.76
E[26,3]=0
E[26,4]=0.76+dl
E[26,5]=1
E[26,6]=26
E[26,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[26,8]=0
E[26,9]=1

#Element 27 (Constant temperature soil)
E[27,1]=110
E[27,2]=0
E[27,3]=1.08
E[27,4]=0.07-dl
E[27,5]=1.08+dl
E[27,6]=27
E[27,7]=(0.1)*dl/2 #Assign as (h)*dl/2 if h is convection coef.
E[27,8]=0
E[27,9]=1
