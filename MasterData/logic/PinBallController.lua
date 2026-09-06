-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pinball/controller/PinBallController.lua

module("logic.extensions.pinball.controller.PinBallController", package.seeall)

local PinBallController = class("PinBallController", BaseController)

function PinBallController:onInit()
	self:onReset()
end

function PinBallController:onReset()
	self._activityId = 554001
end

function PinBallController:setActId(activityId)
	self._activityId = activityId
end

function PinBallController:getActId(activityId)
	return self._activityId
end

function PinBallController:sendPM_PinBallGetInfoReq(activityId)
	PinBallAgent.instance:sendPM_PinBallGetInfoReq(activityId)
end

function PinBallController:handlePM_PinBallGetInfoRes(status, msg)
	if status == 0 then
		PinBallModel.instance:handlePM_PinBallGetInfoRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PinBallGetInfoRes)
end

function PinBallController:sendPM_PinBallStartGameReq(activityId, stageId)
	local clientKey = PinBallModel.instance:getClientKey(activityId, stageId)

	PinBallAgent.instance:sendPM_PinBallStartGameReq(activityId, stageId, clientKey)
end

function PinBallController:handlePM_PinBallStartGameRes(status, msg)
	if status == 0 then
		PinBallModel.instance:handlePM_PinBallStartGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PinBallStartGameRes)
end

function PinBallController:sendPM_PinBallEndGameReq(activityId, stageId, score, extPrizeCount)
	local encryptedKey = PinBallModel.instance:getEncryptedKey(activityId, stageId, score, extPrizeCount)

	PinBallAgent.instance:sendPM_PinBallEndGameReq(activityId, stageId, score, encryptedKey, extPrizeCount)
end

function PinBallController:handlePM_PinBallEndGameRes(status, msg)
	if status == 0 then
		PinBallModel.instance:handlePM_PinBallEndGameRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PinBallEndGameRes)
end

function PinBallController:sendPM_PinBallGainPrizeReq(activityId, prizeIds)
	PinBallAgent.instance:sendPM_PinBallGainPrizeReq(activityId, prizeIds)
end

function PinBallController:handlePM_PinBallGainPrizeRes(status, msg)
	if status == 0 then
		PinBallModel.instance:handlePM_PinBallGainPrizeRes(msg)
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_PinBallGainPrizeRes)
end

function PinBallController:getTotalPrizeNum(activityId)
	local totalNum = 0
	local prizeCfgs = PinBallConfig.instance:getExtPrizeCfgs(activityId)
	local prizeMap = PinBallPropMgr.instance:getCollectPrizeMap()

	for prizeId, num in ipairs(prizeMap) do
		local cfg = prizeCfgs[prizeId]

		if cfg then
			totalNum = totalNum + cfg.limit
		end
	end

	return totalNum
end

function PinBallController:getCurPrizeNum(activityId)
	local curNum = 0
	local prizeCfgs = PinBallConfig.instance:getExtPrizeCfgs(activityId)
	local prizeMap = PinBallPropMgr.instance:getCollectPrizeMap()
	local curCollectPrizeMap = PinBallPropMgr.instance:getCurCollectPrizeMap()

	for prizeId, num in ipairs(prizeMap) do
		local cfg = prizeCfgs[prizeId]

		if cfg then
			local prizeStr = cfg.prize
			local maxNum = cfg.limit
			local matName = MaterialMgr.getMaterialsNameByCfg(prizeStr)

			if curCollectPrizeMap then
				if not curCollectPrizeMap[prizeId] then
					local curCollectNum = 0

					curCollectNum = math.min(curCollectNum, maxNum)
					curNum = curNum + curCollectNum
				end
			end
		end
	end

	return curNum
end

function PinBallController:getPrizeDescList(activityId)
	local prizeCfgs = PinBallConfig.instance:getExtPrizeCfgs(activityId)
	local prizeMap = PinBallPropMgr.instance:getCollectPrizeMap()
	local curCollectPrizeMap = PinBallPropMgr.instance:getCurCollectPrizeMap()
	local descList = {}

	for prizeId, num in ipairs(prizeMap) do
		local cfg = prizeCfgs[prizeId]

		if cfg then
			local prizeStr = cfg.prize
			local maxNum = cfg.limit
			local matName = MaterialMgr.getMaterialsNameByCfg(prizeStr)

			if curCollectPrizeMap then
				if not curCollectPrizeMap[prizeId] then
					local curCollectNum = 0

					curCollectNum = math.min(curCollectNum, maxNum)

					local desc = string.format("%s: %d/%d", matName, curCollectNum, maxNum)

					table.insert(descList, desc)
				end
			end
		end
	end

	return descList
end

function PinBallController:getCurGainExtPrizeList(activityId)
	local prizeCfgs = PinBallConfig.instance:getExtPrizeCfgs(activityId)
	local curCollectPrizeMap = PinBallPropMgr.instance:getCurCollectPrizeMap()
	local gainPrizeList = {}
	local maxPrizeId = 0

	for prizeId, num in pairs(curCollectPrizeMap) do
		if maxPrizeId < prizeId then
			maxPrizeId = prizeId
		end
	end

	for i = 1, maxPrizeId do
		local cfg = prizeCfgs[i]
		local gainNum = curCollectPrizeMap and checknumber(curCollectPrizeMap[i]) or 0

		if cfg then
			gainNum = math.min(gainNum, cfg.limit)
		end

		table.insert(gainPrizeList, gainNum)
	end

	return gainPrizeList
end

function PinBallController:getMaptotalExtPrizeNum(activityId, stageId)
	local stageCfg = PinBallConfig.instance:getStageCfgById(activityId, stageId)
	local totalPrizeNum = 0

	for _, propStr in ipairs(stageCfg.propParam) do
		local propArr = string.split(propStr, "#")

		if propArr and checknumber(propArr[2]) == PinBallEnum.PropType.GetPrize then
			local str = propArr[3]
			local arr = string.split(str, "_")
			local canGetNum = checknumber(arr[2])

			totalPrizeNum = totalPrizeNum + canGetNum
		end
	end

	return totalPrizeNum
end

function PinBallController:onSweepRes(msg)
	PinBallModel.instance:onSweepRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PinBallSweepRes)
end

PinBallController.instance = PinBallController.New()

return PinBallController
