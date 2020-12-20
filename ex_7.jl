#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок)
#РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке

function robot_back!(r::Robot) #Вспомогательная функция.
    while isborder(r, West) == false
        move!(r, West) 
    end
    while isborder(r, Sud) == false
        move!(r, Sud)
    end        
end

function marker_chess!(r::Robot, side::HorizonSide, count::Int)
    s = 0
    while isborder(r, side) == false
        if mod(s, 2) == mod(count, 2)
            putmarker!(r)
        end
        move!(r, side)
        s += 1
    end
    return s
    s += 1 
    if mod(s, 2) == mod(count, 2)
        putmarker!(r)
    end
end

function chess!(r::Robot) #Основная функция.
	
	west = robot_go_to!(r, West) #Робот идет до западной границы
	sud = robot_go_to!(r, Sud) #Робот идет до южной границы
	
	while isborder(r, Nord) == false
        move!(r, Nord)
        if isborder(r, Ost) == false
            marker_chess!(r, Ost, 2)
        else
            marker_chess!(r, West, 2)
        end
    end
   
    moves!(r, West)
    moves!(r, Sud)
	robot_back!(r, Ost, west)
    robot_back!(r, Nord, sud)
end