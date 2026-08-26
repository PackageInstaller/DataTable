-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_DiceCheckResInfoMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_DiceCheckResInfoMO", package.seeall)

local Rouge2_DiceCheckResInfoMO = class("Rouge2_DiceCheckResInfoMO")

function Rouge2_DiceCheckResInfoMO:init(info)
	self.checkId = info.checkId
	self.checkDiceRes = GameUtil.splitString2(info.checkDiceRes, true)
	self.checkRes = info.checkRes
	self.resRate = info.checkResRate
	self.fixValue = info.checkFixValue
	self.checkCo = Rouge2_CareerConfig.instance:getDiceCheckConfig(self.checkId, self.checkRes)

	self:_parseParams(info.checkParam)

	self.checkReRollTimes = info.checkReRollTimes
	self.fromType = info.fromType
end

function Rouge2_DiceCheckResInfoMO:_parseParams(param)
	self.param = param

	if string.nilorempty(self.param) then
		return
	end

	local paramList = string.split(param, ",")

	for _, paramStr in ipairs(paramList) do
		self:_runParamHandleFunc(paramStr)
	end
end

function Rouge2_DiceCheckResInfoMO:_runParamHandleFunc(paramStr)
	local paramList = string.split(paramStr, ":") or {}
	local paramType = paramList and paramList[1]
	local handleFunc = Rouge2_DiceCheckResInfoMO._paramType2HandleFuncMap[paramType]

	if not handleFunc then
		logError(string.format("肉鸽检定参数缺少处理方法 paramType = %s", paramType))
	end

	table.remove(paramList, 1)
	handleFunc(self, paramList)
end

function Rouge2_DiceCheckResInfoMO:getCheckId()
	return self.checkId
end

function Rouge2_DiceCheckResInfoMO:getCheckRes()
	return self.checkRes
end

function Rouge2_DiceCheckResInfoMO:getResRate()
	return self.resRate
end

function Rouge2_DiceCheckResInfoMO:getFixValue()
	return self.fixValue
end

function Rouge2_DiceCheckResInfoMO:getItemCheckResList()
	return self.itemCheckResList
end

function Rouge2_DiceCheckResInfoMO:getCheckDiceRes()
	return self.checkDiceRes
end

function Rouge2_DiceCheckResInfoMO:getNodeId()
	return self.nodeId
end

function Rouge2_DiceCheckResInfoMO:getCheckConfig()
	return self.checkCo
end

function Rouge2_DiceCheckResInfoMO:getCheckReRollTimes()
	return self.checkReRollTimes
end

function Rouge2_DiceCheckResInfoMO:getFromType()
	return self.fromType
end

function Rouge2_DiceCheckResInfoMO:_paramHanleFunc_ItemFixPointMap(paramList)
	local itemCheckResStr = paramList and paramList[1]

	self.itemCheckResList = GameUtil.splitString2(itemCheckResStr, true)
end

function Rouge2_DiceCheckResInfoMO:_paramHanleFunc_nodeId(paramList)
	self.nodeId = paramList and tonumber(paramList[1]) or 0
end

Rouge2_DiceCheckResInfoMO._paramType2HandleFuncMap = {
	itemFixPointMap = Rouge2_DiceCheckResInfoMO._paramHanleFunc_ItemFixPointMap,
	nodeId = Rouge2_DiceCheckResInfoMO._paramHanleFunc_nodeId
}

return Rouge2_DiceCheckResInfoMO
