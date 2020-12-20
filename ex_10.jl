#ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров
#РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток

NUM = 0

function thermometer!(r::Robot) #Вспомогательная функция.
    global NUM
    if ismarker == true
        NUM += 1
        return temperature(r)
    else
        return 0
    end
end

function row_temp!(r::Robot, side::HorizonSide) #Вспомогательная функция.
    t = 0
    while isborder(r, side) == false
        t += thermometer(r)
        move!(r, side)
    end
    t += thermometer(r)
    return t
end

function the definition of temperature!(r::Robot) #Основная функция.
    global NUM = 0
    count_temp = 0
    side = Ost #Задаем начальное направление.
    while isborder(r, Nord) == false
        count_temp += row_temp(r, side)
        move!(r, Nord)
        side = inverse(side)
    end
    count_temp += row_temp(r, side)
    temp = count_temp / NUM
    return temp
end

inverse(side::HorizonSide)=HorizonSide(mod(Int(side)+2,4))