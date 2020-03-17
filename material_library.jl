#-------------------------------------------------------------------------------------------------------#
#    The library contains material characteristics needed for heat and moisture transfer calculation    #
#                                                                                                       #
#    Characteristics are stored in material characteristics functions accesed with the material key     #
#-------------------------------------------------------------------------------------------------------#

#----------------------------------------------------------------------#
#    Moisture storage function (relative humidity to water content)    #

# RHwc(ϕ,a=0) -> "m" is relative humidity (RH) and "a" is a material key #

function RHwc(ϕ,a=0)

    if a==0
        println("ERROR! Please specify ϕaterial key a in function RHwc(ϕ,a)!")

    #Lime-cement mortar, fine
    elseif a==10
        if ϕ>=0&&ϕ<0.30
            12.79/0.3*ϕ
        elseif ϕ>=0.30&&ϕ<0.50
            12.79+3.09/0.2*(ϕ-0.3)
        elseif ϕ>=0.50&&ϕ<0.70
            15.88+5.09/0.2*(ϕ-0.5)
        elseif ϕ>=0.70&&ϕ<0.80
            20.98+4.68/0.1*(ϕ-0.7)
        elseif ϕ>=0.80&&ϕ<=0.90
            25.66+9.62/0.1*(ϕ-0.8)
        elseif ϕ>=0.90&&ϕ<=0.95
            35.28+11.65/0.05*(ϕ-0.9)
        else
            println("ERROR! Relative humidity greater than 95 %!")
        end

    #Mineral wool
    elseif a==11
        if ϕ>=0&&ϕ<0.50
            0.461/0.5*ϕ
        elseif ϕ>=0.50&&ϕ<0.60
            0.461+0.226/0.1*(ϕ-0.5)
        elseif ϕ>=0.60&&ϕ<0.70
            0.687+0.373/0.1*(ϕ-0.6)
        elseif ϕ>=0.70&&ϕ<0.80
            1.06+0.73/0.1*(ϕ-0.7)
        elseif ϕ>=0.80&&ϕ<0.85
            1.79+0.7/0.05*(ϕ-0.8)
        elseif ϕ>=0.85&&ϕ<0.90
            2.49+1.34/0.05*(ϕ-0.85)
        elseif ϕ>=0.90&&ϕ<0.91
            3.83+0.43/0.01*(ϕ-0.9)
        elseif ϕ>=0.91&&ϕ<0.92
            4.26+0.52/0.01*(ϕ-0.91)
        elseif ϕ>=0.92&&ϕ<0.93
            4.78+0.65/0.01*(ϕ-0.92)
        elseif ϕ>=0.93&&ϕ<0.94
            5.43+0.84/0.01*(ϕ-0.93)
        elseif ϕ>=0.94&&ϕ<0.95
            6.27+1.11/0.01*(ϕ-0.94)
        elseif ϕ>=0.95&&ϕ<0.96
            7.38+1.56/0.01*(ϕ-0.95)
        elseif ϕ>=0.96&&ϕ<0.97
            8.94+2.36/0.01*(ϕ-0.96)
        elseif ϕ>=0.97&&ϕ<0.98
            11.3+3.8/0.01*(ϕ-0.97)
        elseif ϕ>=0.98&&ϕ<0.99
            15.1+7.6/0.01*(ϕ-0.98)
        elseif ϕ>=0.99&&ϕ<0.995
            22.7+7.32/0.005*(ϕ-0.99)
        elseif ϕ>=0.995&&ϕ<=100
            30.2+14.6/0.005*(ϕ-0.995)
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Concrete
    elseif a==12
        if ϕ>=0&&ϕ<0.35
            27/0.35*ϕ
        elseif ϕ>=0.35&&ϕ<0.50
            27+7/0.15*(ϕ-0.35)
        elseif ϕ>=0.50&&ϕ<0.70
            34+15.5/0.2*(ϕ-0.5)
        elseif ϕ>=0.70&&ϕ<0.80
            49.5+14.5/0.1*(ϕ-0.7)
        elseif ϕ>=0.80&&ϕ<0.90
            64+24.5/0.1*(ϕ-0.8)
        elseif ϕ>=0.90&&ϕ<0.95
            88.5+20.5/0.05*(ϕ-0.9)
        elseif ϕ>=0.95&&ϕ<0.96
            109+5.5/0.01*(ϕ-0.95)
        elseif ϕ>=0.96&&ϕ<0.97
            114.5+10/0.01*(ϕ-0.96)
        elseif ϕ>=0.97&&ϕ<0.976
            124.5+5.5/0.006*(ϕ-0.97)
        elseif ϕ>=0.976&&ϕ<=1
            130+10/0.024*(ϕ-0.976)
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Reinforced concrete
    elseif a==13
        if ϕ>=0&&ϕ<0.35
            27/0.35*ϕ/100
        elseif ϕ>=0.35&&ϕ<0.50
            27+7/0.15*(ϕ-0.35)
        elseif ϕ>=0.50&&ϕ<0.70
            34+15.5/0.2*(ϕ-0.5)
        elseif ϕ>=0.70&&ϕ<0.80
            49.5+14.5/0.1*(ϕ-0.7)
        elseif ϕ>=0.80&&ϕ<0.90
            64+24.5/0.1*(ϕ-0.8)
        elseif ϕ>=0.90&&ϕ<0.95
            88.5+20.5/0.05*(ϕ-0.9)
        elseif ϕ>=0.95&&ϕ<0.96
            109+5.5/0.01*(ϕ-0.95)
        elseif ϕ>=0.96&&ϕ<0.97
            114.5+10/0.01*(ϕ-0.96)
        elseif ϕ>=0.97&&ϕ<0.976
            124.5+5.5/0.006*(ϕ-0.97)
        elseif ϕ>=0.976&&ϕ<=1
            130+10/0.024*(ϕ-0.976)
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Extruded polystyrene
    elseif a==14
            if ϕ>=0&&ϕ<0.10
                0.009/0.1*ϕ
            elseif ϕ>=0.10&&ϕ<0.50
                0.009+0.071/0.4*(ϕ-0.1)
            elseif ϕ>=0.50&&ϕ<0.80
                0.08+0.23/0.3*(ϕ-0.5)
            elseif ϕ>=0.80&&ϕ<0.90
                0.31+0.35/0.1*(ϕ-0.8)
            elseif ϕ>=0.90&&ϕ<0.97
                0.66+1.29/0.07*(ϕ-0.9)
            else
                println("ERROR! Relative humidity greater than 100 %!")
            end

    #PVC hydro membrane
    elseif a==15
            if ϕ>=0&&ϕ<0.5
                0.000485/0.5*ϕ
            elseif ϕ>=0.5&&ϕ<0.6
                0.000485+0.000239/0.1*(ϕ-0.5)
            elseif ϕ>=0.60&&ϕ<0.70
                0.000724+0.000396/0.1*(ϕ-0.6)
            elseif ϕ>=0.70&&ϕ<0.80
                0.00112+0.00076/0.1*(ϕ-0.7)
            elseif ϕ>=0.80&&ϕ<0.85
                0.00188+0.0074/0.05*(ϕ-0.8)
            elseif ϕ>=0.85&&ϕ<0.9
                0.00262+0.00141/0.05*(ϕ-0.85)
            elseif ϕ>=0.9&&ϕ<0.91
                0.00403+0.00045/0.01*(ϕ-0.9)
            elseif ϕ>=0.91&&ϕ<0.92
                0.00448+0.00055/0.01*(ϕ-0.91)
            elseif ϕ>=0.92&&ϕ<0.93
                0.00503+0.00069/0.01*(ϕ-0.92)
            elseif ϕ>=0.93&&ϕ<0.94
                0.00572+0.00088/0.01*(ϕ-0.93)
            elseif ϕ>=0.94&&ϕ<0.95
                0.0066+0.00117/0.01*(ϕ-0.94)
            elseif ϕ>=0.95&&ϕ<0.96
                0.00777+0.00164/0.01*(ϕ-0.95)
            elseif ϕ>=0.96&&ϕ<0.97
                0.00941+0.00249/0.01*(ϕ-0.96)
            elseif ϕ>=0.97&&ϕ<0.98
                0.0119+0.004/0.01*(ϕ-0.97)
            elseif ϕ>=0.98&&ϕ<0.99
                0.0159+0.008/0.01*(ϕ-0.98)
            elseif ϕ>=0.99&&ϕ<0.995
                0.0239+0.0079/0.005*(ϕ-0.99)
            elseif ϕ>=0.995&&ϕ<1
                0.0318+0.0153/0.005*(ϕ-0.995)
            else
                println("ERROR! Relative humidity greater than 100 %!")
            end

        #Cement screed
        elseif a==16
            if ϕ>=0&&ϕ<0.35
                82.5/0.35*ϕ
            elseif ϕ>=0.35&&ϕ<0.50
                82.5+25/0.15*(ϕ-0.35)
            elseif ϕ>=0.50&&ϕ<0.7
                107.5+47.5/0.2*(ϕ-0.5)
            elseif ϕ>=0.7&&ϕ<0.8
                155+45/0.1*(ϕ-0.7)
            elseif ϕ>=0.8&&ϕ<0.9
                200+77.5/0.1*(ϕ-0.8)
            elseif ϕ>=0.9&&ϕ<0.95
                277.5+62.5/0.05*(ϕ-0.9)
            elseif ϕ>=0.95&&ϕ<0.96
                340+17.5/0.01*(ϕ-0.95)
            elseif ϕ>=0.96&&ϕ<0.97
                357.5+30/0.01*(ϕ-0.96)
            elseif ϕ>=0.97&&ϕ<0.976
                387.5+22.5/0.006*(ϕ-0.97)
            elseif ϕ>=0.976&&ϕ<1
                410+70/0.024*(ϕ-0.976)
            else
                println("ERROR! Relative humidity greater than 100 %!")
            end

# add new material above! #
    else
        println("ERROR! Material is not in the database!")
    end
end

#----------------------------------------------------------------------#
#    Moisture storage function (water content to relative humidity)    #

# wcRH(m,a=0) -> "m" is water content in kg/m^3 and "a" is a material key #

function wcRH(m,a=0)

    if a==0
        println("ERROR! Please specify material key a in function wcRH(m,a)!")

    #Lime-cement mortar, fine
    elseif a==10
        if m>=0&&m<12.79
            0.3/12.79*m
        elseif m>=12.79&&m<15.88
            0.3+0.2/3.09*(m-12.79)
        elseif m>=15.88&&m<20.98
            0.5+0.2/5.1*(m-15.88)
        elseif m>=20.98&&m<25.66
            0.7+0.1/4.68*(m-20.98)
        elseif m>=25.66&&m<=35.28
            0.8+0.1/9.62*(m-25.66)
        elseif m>=35.28&&m<=46.93
            0.9+0.05/11.65*(m-35.28)
        else
            println("ERROR! Moisture content greater than 46.93 kg/m^3!")
        end

    #Mineral wool
    elseif a==11
        if m>=0&&m<0.461
            0.5/0.461*m
        elseif m>=0.461&&m<0.687
            0.5+0.1/0.226+(m-0.461)
        elseif m>=0.687&&m<1.06
            0.6+0.1/0.373*(m-0.687)
        elseif m>=1.06&&m<1.79
            0.7+0.1/0.73*(m-1.06)
        elseif m>=1.79&&m<2.49
            0.8+0.05/0.7*(m-1.79)
        elseif m>=2.49&&m<3.83
            0.85+0.05/1.34*(m-2.49)
        elseif m>=3.83&&m<4.26
            0.9+0.01/0.43*(m-3.83)
        elseif m>=4.26&&m<4.78
            0.91+0.01/0.52*(m-4.26)
        elseif m>=4.78&&m<5.43
            0.92+0.01/0.65*(m-4.78)
        elseif m>=5.43&&m<6.27
            0.93+0.01/0.84*(m-5.43)
        elseif m>=6.27&&m<7.38
            0.94+0.01/1.11*(m-6.27)
        elseif m>=7.38&&m<8.94
            0.95+0.01/1.56*(m-7.38)
        elseif m>=8.94&&m<11.3
            0.96+0.01/2.36*(m-8.94)
        elseif m>=11.3&&m<15.1
            0.97+0.01/3.8*(m-11.3)
        elseif m>=15.1&&m<22.7
            0.98+0.01/7.6*(m-15.1)
        elseif m>=22.7&&m<30.2
            0.99+0.005/7.5*(m-22.7)
        elseif m>=30.2&&m<=44.8
            0.995+0.005/14.6*(m-30.2)
        else
            println("ERROR! Moisture content greater than 44,8 kg/m^3!")
        end

    #Concrete
    elseif a==12
        if m>=0&&m<27
            0.35/27*m
        elseif m>=27&&m<34
            0.35+0.15/7*(m-27)
        elseif m>=34&&m<49.5
            0.5+0.2/15.5*(m-34)
        elseif m>=49.5&&m<64
            0.7+0.1/14.5*(m-49.5)
        elseif m>=64&&m<88.5
            0.8+0.1/24.5*(m-64)
        elseif m>=88.5&&m<109
            0.9+0.05/20.5*(m-88.5)
        elseif m>=109&&m<114.5
            0.95+0.01/5.5*(m-109)
        elseif m>=114.5&&m<124.5
            0.96+0.1/10*(m-114.5)
        elseif m>=124.5&&m<130
            0.97+0.006/5.5*(m-124.5)
        elseif m>=130&&m<=140
            0.976+0.024/10*(m-130)
        else
            println("ERROR! Moisture content greater than 140 kg/m^3!")
        end

    #Reinforced concrete
    elseif a==13
        if m>=0&&m<27
            0.35/27*m
        elseif m>=27&&m<34
            0.35+0.15/7*(m-27)
        elseif m>=34&&m<49.5
            0.5+0.2/15.5*(m-34)
        elseif m>=49.5&&m<64
            0.7+0.1/14.5*(m-49.5)
        elseif m>=64&&m<88.5
            0.8+0.1/24.5*(m-64)
        elseif m>=88.5&&m<109
            0.9+0.05/20.5*(m-88.5)
        elseif m>=109&&m<114.5
            0.95+0.01/5.5*(m-109)
        elseif m>=114.5&&m<124.5
            0.96+0.1/10*(m-114.5)
        elseif m>=124.5&&m<130
            0.97+0.006/5.5*(m-124.5)
        elseif m>=130&&m<=140
            0.976+0.024/10*(m-130)
        else
            println("ERROR! Moisture content greater than 140 kg/m^3!")
        end

    #Extruded polystyrene
    elseif a==14
        if m>=0&&m<0.009
            0.1/0.009*m
        elseif m>=0.009&&m<0.08
            0.1+0.4/0.071*(m-0.009)
        elseif m>=0.08&&m<0.31
            0.5+0.3/0.23*(m-0.08)
        elseif m>=0.31&&m<0.66
            0.8+0.1/0.35*(m-0.31)
        elseif m>=0.66&&m<1.95
            0.9+0.07/1.29*(m-0.66)
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #PVC hydro membrane
    elseif a==15
        if m>=0&&m<0.000485
            0.5/0.000485*m
        elseif m>=0.000485&&m<0.000724
            0.5+0.1/0.000239*(m-0.000485)
        elseif m>=0.000724&&m<0.00112
            0.6+0.1/0.000396*(m-0.000724)
        elseif m>=0.00112&&m<0.00188
            0.7+0.1/0.00076*(m-0.0011)
        elseif m>=0.00188&&m<0.00262
            0.8+0.05/0.0074*(m-0.00112)
        elseif m>=0.00262&&m<0.00403
            0.85+0.05/0.00141*(m-0.00262)
        elseif m>=0.00403&&m<0.00448
            0.9+0.01/0.00045*(m-0.00403)
        elseif m>=0.00448&&m<0.00503
            0.91+0.01/0.00055*(m-0.00448)
        elseif m>=0.00503&&m<0.00572
            0.92+0.01/0.00069*(m-0.00503)
        elseif m>=0.00572&&m<0.0066
            0.93+0.01/0.00088*(m-0.00572)
        elseif m>=0.0066&&m<0.00777
            0.94+0.01/0.00117*(m-0.0066)
        elseif m>=0.00777&&m<0.00941
            0.95+0.01/0.00164*(m-0.00777)
        elseif m>=0.00941&&m<0.0119
            0.96+0.01/0.00249*(m-0.00941)
        elseif m>=0.0119&&m<0.0159
            0.97+0.01/0.004*(m-0.0119)
        elseif m>=0.0159&&m<0.0239
            0.98+0.01/0.008*(m-0.0159)
        elseif m>=0.0239&&m<0.0318
            0.99+0.005/0.0079*(m-0.0239)
        elseif m>=0.0318&&m<0.0471
            0.995+0.005/0.0153*(m-0.0318)
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Cement screed
    elseif a==16
        if m>=0&&m<82.5
            0.35/82.5*m
        elseif m>=82.5&&m<107.5
            0.35+0.15/25*(m-82.5)
        elseif m>=107.5&&m<155
            0.5+0.2/47.5*(m-107.5)
        elseif m>=155&&m<200
            0.7+0.1/45*(m-155)
        elseif m>=200&&m<277.5
            0.8+0.1/77.5*(m-200)
        elseif m>=277.5&&m<340
            0.9+0.05/62.5*(m-277.5)
        elseif m>=340&&m<357.5
            0.95+0.01/17.5*(m-340)
        elseif m>=357.5&&m<387.5
            0.96+0.01/30*(m-357.5)
        elseif m>=387.5&&m<410
            0.97+0.006/22.5*(m-387.5)
        elseif m>=410&&m<480
            0.976+0.024/70*(m-410)
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

# add new material above! #
    else
        println("ERROR! Material is not in the database!")
    end
end

#---------------------------------------#
#    Moisture dependent conductivity    #

# λ_m(m,a=0) -> "m" is relative humidity [%] and "a" is a material key #

# function λ_m(m,a=0)
#
#     if a==0
#             println("ERROR! Please specify material key a in function λ_m(m,a)!")
#
#     #Lime-cement mortar, fine
#     elseif a==10
#         if m>=0&&RHwc(m,a)<=210
#             0.6+0.69/210*RHwc(m,a)
#         else
#             println("ERROR! Relative humidity greater than 100 %!")
#         end
#
#     #Mineral wool
#     elseif a==11
#         if m>=0&&RHwc(m,a)<10
#             0.04
#         elseif RHwc(m,a)>=10&&RHwc(m,a)<20
#             0.04+0.001/10*(RHwc(m,a)-10)
#         elseif RHwc(m,a)>=20&&RHwc(m,a)<=50
#             0.041+0.002/30*(RHwc(m,a)-20)
#         else
#             println("ERROR! Relative humidity greater than 100 %!")
#         end
#
#     #Concrete
#     elseif a==12
#         if m>=0&&m<=100
#             1.7
#         else
#             println("ERROR! Relative humidity greater than 100 %!")
#         end
#
#
# # add new material above! #
#     else
#         println("ERROR! Material is not in the database!")
#     end
# end

#---------------------------------------------------------------------#
#    Moisture dependent water vapour diffusion resistance factor μ    #

# μ_m(m,a=0) -> "m" is relative humidity [%] and "a" is a material key #

function μ_m(ϕ,a=0)

    if a==0
            println("ERROR! Please specify material key a in function μ_m(ϕ,a)!")

    #Lime-cement mortar, fine
    elseif a==10
        10
        # if ϕ>=0&&ϕ<0.50
        #     147
        # elseif ϕ>=0.50&&ϕ<0.70
        #     147-28/0.20*(ϕ-0.50)
        # elseif ϕ>=0.70&&ϕ<0.80
        #     119-59.5/0.10*(ϕ-0.70)
        # elseif ϕ>=0.80&&ϕ<0.90
        #     59.5-40.3/0.10*(ϕ-0.80)
        # elseif ϕ>=0.90&&ϕ<0.95
        #     19.2-15.03/0.5*(ϕ-0.90)
        # elseif ϕ>=0.95&&ϕ<0.96
        #     4.17-0.6/0.01*(ϕ-0.95)
        # elseif ϕ>=0.96&&ϕ<0.97
        #     3.57-1.65/0.01*(ϕ-0.96)
        # elseif ϕ>=0.97&&ϕ<0.976
        #     1.92-0.67/0.06*(ϕ-0.97)
        # elseif ϕ>=0.976#&&ϕ<=1
        #     1.25
        # else
        #     println("ERROR! Relative humidity greater than 100 %!")
        # end

    #Mineral wool
    elseif a==11
        #if ϕ>=0#&&ϕ<1
            1.2
        # else
        #     println("ERROR! Relative humidity greater than 100 %!")
        # end

    #Concrete
    elseif a==12
        130
        # if ϕ>=0&&ϕ<0.50
        #     50-8.38/0.50*ϕ
        # elseif ϕ>=0.50&&ϕ<0.70
        #     41.62-7.84/0.20*(ϕ-50)
        # elseif ϕ>=0.70&&ϕ<0.80
        #     33.78-8.83/0.10*(ϕ-0.70)
        # elseif ϕ>=0.80&&ϕ<0.90
        #     24.95-14.37/0.10*(ϕ-0.80)
        # elseif ϕ>=0.90&&ϕ<0.95
        #     10.58-7.31/0.5*(ϕ-0.90)
        # elseif ϕ>=0.95#&&ϕ<=1
        #     3.27
        # else
        #     println("ERROR! Relative humidity greater than 100 %!")
        # end

    #Reinforced concrete
    elseif a==13
        130
        # if ϕ>=0&&ϕ<0.50
        #     50-8.38/0.50*ϕ
        # elseif ϕ>=0.50&&ϕ<0.70
        #     41.62-7.84/0.20*(ϕ-0.50)
        # elseif ϕ>=0.70&&ϕ<0.80
        #     33.78-8.83/0.10*(ϕ-0.70)
        # elseif ϕ>=0.80&&ϕ<0.90
        #     24.95-14.37/0.10*(ϕ-0.80)
        # elseif ϕ>=0.90&&ϕ<0.95
        #     10.58-7.31/0.5*(ϕ-0.90)
        # elseif ϕ>=0.95#&&ϕ<=1
        #     3.27
        # else
        #     println("ERROR! Relative humidity greater than 100 %!")
        # end

    #Extruded polystyrene
    elseif a==14
        200
        # if ϕ>=0#&&ϕ<1
        #     170.56
        # end

    #PVC hydro membrane
    elseif a==15
        100000
        # if ϕ>=0#&&ϕ<1
        #     10761
        # end

    #Cement screed
    elseif a==16
        50
        # if ϕ>=0&&ϕ<0.7
        #     25/0.7*ϕ
        # elseif ϕ>=0.7&&ϕ<0.8
        #     25-5/0.1*(ϕ-0.7)
        # elseif ϕ>=0.8&&ϕ<0.9
        #     20-13.75/0.1*(ϕ-0.8)
        # elseif ϕ>=0.9&&ϕ<0.95
        #     6.25-3.12/0.05*(ϕ-0.9)
        # elseif ϕ>=0.95&&ϕ<0.96
        #     3.13-0.62/0.01*(ϕ-0.95)
        # elseif ϕ>=0.96&&ϕ<0.97
        #     2.5-0.71/0.01*(ϕ-0.96)
        # elseif ϕ>=0.97&&ϕ<0.976
        #     1.79-0.32/0.006*(ϕ-0.97)
        # elseif ϕ>=0.976#&&ϕ<1
        #     1.47-0.17/0.024*(ϕ-0.976)
        # end

# add new material above! #
    else
        println("ERROR! Material is not in the database!")
    end
end

### Moisture storage function -- capacity ###

# dw_dϕ(ϕ,a=0)

function dw_dϕ(ϕ,a=0)

    if a==0
        println("ERROR! Please specify ϕaterial key a in function RHwc(ϕ,a)!")

    #Lime-cement mortar, fine
    elseif a==10
        if ϕ>=0&&ϕ<0.30
            12.79/30
        elseif ϕ>=0.30&&ϕ<0.50
            3.09/20
        elseif ϕ>=0.50&&ϕ<0.70
            5.09/20
        elseif ϕ>=0.70&&ϕ<0.80
            4.68/10
        elseif ϕ>=0.80&&ϕ<=0.90
            9.62/10
        elseif ϕ>=0.90#&&ϕ<=1#&&ϕ<=0.95
            11.65/5
        else
            println("ERROR! Relative humidity greater than 95 %!")
        end

    #Mineral wool
    elseif a==11
        if ϕ>=0&&ϕ<0.50
            0.461/50
        elseif ϕ>=0.50&&ϕ<0.60
            0.226/10
        elseif ϕ>=0.60&&ϕ<0.70
            0.373/10
        elseif ϕ>=0.70&&ϕ<0.80
            0.73/10
        elseif ϕ>=0.80&&ϕ<0.85
            0.7/5
        elseif ϕ>=0.85&&ϕ<0.90
            1.34/5
        elseif ϕ>=0.90&&ϕ<0.91
            0.43/1
        elseif ϕ>=0.91&&ϕ<0.92
            0.52/1
        elseif ϕ>=0.92&&ϕ<0.93
            0.65/1
        elseif ϕ>=0.93&&ϕ<0.94
            0.84/1
        elseif ϕ>=0.94&&ϕ<0.95
            1.11/1
        elseif ϕ>=0.95&&ϕ<0.96
            1.56/1
        elseif ϕ>=0.96&&ϕ<0.97
            2.36/1
        elseif ϕ>=0.97&&ϕ<0.98
            3.8/1
        elseif ϕ>=0.98&&ϕ<0.99
            7.6/1
        elseif ϕ>=0.99&&ϕ<0.995
            7.32/0.5
        elseif ϕ>=0.995#&&ϕ<=1
            14.6/0.5
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Concrete
    elseif a==12
        if ϕ>=0&&ϕ<0.35
            27/35
        elseif ϕ>=0.35&&ϕ<0.50
            7/15
        elseif ϕ>=0.50&&ϕ<0.70
            15.5/20
        elseif ϕ>=0.70&&ϕ<0.80
            14.5/10
        elseif ϕ>=0.80&&ϕ<0.90
            24.5/10
        elseif ϕ>=0.90&&ϕ<0.95
            20.5/5
        elseif ϕ>=0.95&&ϕ<0.96
            5.5/1
        elseif ϕ>=0.96&&ϕ<0.97
            10/1
        elseif ϕ>=0.97&&ϕ<0.976
            5.5/0.6
        elseif ϕ>=0.976#&&ϕ<=1
            10/2.4
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Reinforced concrete
    elseif a==13
        if ϕ>=0&&ϕ<0.35
            27/35
        elseif ϕ>=0.35&&ϕ<0.50
            7/15
        elseif ϕ>=0.50&&ϕ<0.70
            15.5/20
        elseif ϕ>=0.70&&ϕ<0.80
            14.5/10
        elseif ϕ>=0.80&&ϕ<0.90
            24.5/10
        elseif ϕ>=0.90&&ϕ<0.95
            20.5/5
        elseif ϕ>=0.95&&ϕ<0.96
            5.5/1
        elseif ϕ>=0.96&&ϕ<0.97
            10/1
        elseif ϕ>=0.97&&ϕ<0.976
            5.5/0.6
        elseif ϕ>=0.976#&&ϕ<=1
            10/2.4
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Extruded polystyrene
    elseif a==14
        if ϕ>=0&&ϕ<0.10
            0.009/10
        elseif ϕ>=0.10&&ϕ<0.50
            0.071/40
        elseif ϕ>=0.50&&ϕ<0.80
            0.23/30
        elseif ϕ>=0.80&&ϕ<0.90
            0.35/10
        elseif ϕ>=0.90#&&ϕ<=1#ϕ<0.97
            1.29/7
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #PVC hydro membrane
    elseif a==15
        if ϕ>=0&&ϕ<0.5
            0.000485/50
        elseif ϕ>=0.5&&ϕ<0.6
            0.000239/10
        elseif ϕ>=0.60&&ϕ<0.70
            0.000396/10
        elseif ϕ>=0.70&&ϕ<0.80
            0.00076/10
        elseif ϕ>=0.80&&ϕ<0.85
            0.0074/5
        elseif ϕ>=0.85&&ϕ<0.9
            0.00141/5
        elseif ϕ>=0.9&&ϕ<0.91
            0.00045/1
        elseif ϕ>=0.91&&ϕ<0.92
            0.00055/1
        elseif ϕ>=0.92&&ϕ<0.93
            0.00069/1
        elseif ϕ>=0.93&&ϕ<0.94
            0.00088/1
        elseif ϕ>=0.94&&ϕ<0.95
            0.00117/1
        elseif ϕ>=0.95&&ϕ<0.96
            0.00164/1
        elseif ϕ>=0.96&&ϕ<0.97
            0.00249/1
        elseif ϕ>=0.97&&ϕ<0.98
            0.004/1
        elseif ϕ>=0.98&&ϕ<0.99
            0.008/1
        elseif ϕ>=0.99&&ϕ<0.995
            0.0079/0.5
        elseif ϕ>=0.995#&&ϕ<1
            0.0153/0.5
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

    #Cement screed
    elseif a==16
        if ϕ>=0&&ϕ<0.35
            82.5/35
        elseif ϕ>=0.35&&ϕ<0.50
            25/15
        elseif ϕ>=0.50&&ϕ<0.7
            47.5/20
        elseif ϕ>=0.7&&ϕ<0.8
            45/10
        elseif ϕ>=0.8&&ϕ<0.9
            77.5/10
        elseif ϕ>=0.9&&ϕ<0.95
            62.5/5
        elseif ϕ>=0.95&&ϕ<0.96
            17.5/1
        elseif ϕ>=0.96&&ϕ<0.97
            30/1
        elseif ϕ>=0.97&&ϕ<0.976
            22.5/0.6
        elseif ϕ>=0.976#&&ϕ<1
            70/2.4
        else
            println("ERROR! Relative humidity greater than 100 %!")
        end

# add new material above! #
    else
        println("ERROR! Material is not in the database!")
    end
end
