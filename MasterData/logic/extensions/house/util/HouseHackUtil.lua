-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/util/HouseHackUtil.lua

module("logic.extensions.house.util.HouseHackUtil", package.seeall)

local HouseHackUtil = {}

function HouseHackUtil.createPlayerUnit(posX, posY, posZ)
	local curScene = SceneMgr.instance:getCurScene()
	local unit = curScene.unitFactory:createUnit(UnitTag.Player, {
		bornZoneId = 1211,
		entityCode = 2000011,
		x = posX,
		y = posY,
		z = posZ
	})

	unit.ai:destroyCurrentAI()
	unit.performCtrl:setForbid("hack", true)

	return unit
end

function HouseHackUtil.testAvoidance(v1, v2)
	local unit1 = HouseHackUtil.createPlayerUnit(v1.x, v1.y, v1.z)
	local unit2 = HouseHackUtil.createPlayerUnit(v2.x, v2.y, v2.z)

	unit1.navMesh:setAvoidancePriority(50)
	unit2.navMesh:setAvoidancePriority(51)
	unit1.navMesh:setDestination(v2)
	unit2.navMesh:setDestination(v1)

	local count = 1

	settimer(10, function()
		count = count + 1

		if math.fmod(count, 2) == 0 then
			unit1.navMesh:setDestination(v1)
			unit2.navMesh:setDestination(v2)
		else
			unit1.navMesh:setDestination(v2)
			unit2.navMesh:setDestination(v1)
		end
	end, nil, true)

	return {
		unit1,
		unit2
	}
end

return HouseHackUtil
