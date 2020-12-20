#ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)
#РЕЗУЛЬТАТ: Робот - в исходном положении и в углах поля стоят маркеры

function moves!(r::Robot,side::HorizonSide) #Вспомогательная функция.
    s = 0
    while isborder(r, side) == false
        move!(r, side)
        s += 1
    end
    return s
end

function moves!(r, side, s) #Вспомогательная функция.
	for _ in 1:s 
		move!(r, side) 
end

function angles!(r::Robot) #Основная функция.
    s = []
    while ((isborder(r, Sud)) && (isborder(r, West))) == false
        push!(s, moves!(r, West))
        push!(s, moves!(r, Sud))
    end
    for side in (Nord, Ost, Sud, West)
        moves!(r, side)
        putmarker!(r)
    end
    for (i, n) in enumerate(s)
        side = isodd(i) ? Ost : Nord
        moves!(r, side, n)
    end
end

next(side::HorizonSide)=HorizonSide(mod(Int(side)+3,4))