forkliftanimation = function()
	local moveleft = Transformation.move_slow(forklift, .3, -5, 0, 0)
	local turnright = Rotation.rotate(forkliftmatrix, "y", -90, 40)
	local moveback = Transformation.move_slow(forklift, .3, 0, 0, -5)
	local turnleft90 = Rotation.rotate(forkliftmatrix, "y", 90, 40)
	local moveleft2 = Transformation.move_slow(forklift, .3, -2, 0, 0)
	local turnaround = Rotation.rotate(forkliftmatrix, "y", 180, 40)
	local reverseleft2 = Transformation.move_slow(forklift, .3, 2, 0, 0)
	local reverseturnleft90 = Rotation.rotate(forkliftmatrix, "y", -90, 40)
	local reversemoveback = Transformation.move_slow(forklift, .3, 0, 0, 5)
	local reverseturnright = Rotation.rotate(forkliftmatrix, "y", 90, 40)
	local reversemoveright = Transformation.move_slow(forklift, .3, 5, 0, 0)
	local reverseturnaround = Rotation.rotate(forkliftmatrix, "y", -180, 40)
	do
		moveleft()
		turnright()
		moveback()
		turnleft()
		moveleft2()
		turnaround()
		reverseleft2()
		turnright()
		reversemoveback()
		reverseturnright()
		reverseturnaround()
	end
end