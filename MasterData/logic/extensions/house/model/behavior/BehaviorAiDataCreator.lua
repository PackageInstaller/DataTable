-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/behavior/BehaviorAiDataCreator.lua

module("logic.extensions.house.model.behavior.BehaviorAiDataCreator", package.seeall)

function setAiData_0(data, unit)
	return true
end

function setAiData_90000(data, unit)
	return true
end

function setAiData_90001(data, unit)
	return true
end

function setAiData_90002(data, unit)
	return true
end

function setAiData_90003(data, unit)
	return true
end

function setAiData_10001(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_10002(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_10003(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_10004(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_20001(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_20002(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_20003(data, unit)
	data.targetRoomId = HouseSceneUtil.findRestRoomId(unit.heroId)
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_31001(data, unit)
	data.targetRoomId = HouseEnum.SUPERVISOR_ROOM_ID
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_31002(data, unit)
	data.targetRoomId = HouseEnum.SUPERVISOR_ROOM_ID
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_32001(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_32002(data, unit)
	data.targetRoomId = HouseEnum.TRADING_ROOM_ID
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_32003(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_32004(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_33001(data, unit)
	data.targetRoomId = HouseEnum.MANUFACTURE_ROOM_ID
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_33002(data, unit)
	data.targetRoomId = HouseEnum.MANUFACTURE_ROOM_ID
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_34001(data, unit)
	data.targetRoomId = unit.scheduleModel:getScheduleTargetRoomId()
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_34002(data, unit)
	data.targetRoomId = unit.scheduleModel:getScheduleTargetRoomId()
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end

function setAiData_34003(data, unit)
	local roomId = unit.scheduleModel:getScheduleTargetRoomId()
	local navMO = HouseNavigationModel.instance:getMOByZoneId(roomId)
	local goodsPos = navMO:getCreateGoodsPos()

	data.targetRoomId = roomId

	if goodsPos then
		data.targetPos = Vector3.New(goodsPos.x - 1, goodsPos.y - 1, goodsPos.z - 0.5)
		data.useRandomPos = false

		return true
	end

	return false
end

function setAiData_40001(data, unit)
	data.targetRoomId = unit.navMesh:getCurZoneId()

	return true
end

function setAiData_40002(data, unit)
	data.targetRoomId = HouseSceneUtil.findRestRoomId(unit.heroId)
	data.targetPos = HouseSceneUtil.getRandomRoomPos(data.targetRoomId)

	return true
end
