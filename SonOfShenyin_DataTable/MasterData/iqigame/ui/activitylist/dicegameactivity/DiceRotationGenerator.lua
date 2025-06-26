-- chunkname: @IQIGame\\UI\\ActivityList\\DiceGameActivity\\DiceRotationGenerator.lua

local m = {
	ROTATIONS = {
		{
			{
				0,
				3
			},
			{
				1,
				1
			},
			{
				3,
				3
			}
		},
		{
			{
				0,
				3
			},
			{
				1,
				1
			},
			{
				0,
				0
			}
		},
		{
			{
				0,
				0
			},
			{
				0,
				0
			},
			{
				0,
				3
			}
		},
		{
			{
				0,
				3
			},
			{
				3,
				3
			},
			{
				0,
				0
			}
		},
		{
			{
				0,
				0
			},
			{
				2,
				2
			},
			{
				0,
				3
			}
		},
		{
			{
				0,
				3
			},
			{
				1,
				1
			},
			{
				1,
				1
			}
		}
	}
}

function m.GetEulerByNum(value)
	local range = m.ROTATIONS[value]
	local x = math.random(range[1][1], range[1][2])
	local y = math.random(range[2][1], range[2][2])
	local z = math.random(range[3][1], range[3][2])

	return x * 90, y * 90, z * 90
end

return m
