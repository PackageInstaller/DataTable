-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/controller/MakingMoonCakeController.lua

module("logic.extensions.makingmooncake.controller.MakingMoonCakeController", package.seeall)

local MakingMoonCakeController = class("MakingMoonCakeController", BaseController)

MakingMoonCakeController.PM_MakingMoonCakeInfoRes = "MakingMoonCakeController.PM_MakingMoonCakeInfoRes"
MakingMoonCakeController.PM_MakingMoonCakeStartGameRes = "MakingMoonCakeController.PM_MakingMoonCakeStartGameRes"
MakingMoonCakeController.PM_MakingMoonCakeReceiveCumulativePrizeRes = "MakingMoonCakeController.PM_MakingMoonCakeReceiveCumulativePrizeRes"
MakingMoonCakeController.PM_MakingMoonCakeEndGameRes = "MakingMoonCakeController.PM_MakingMoonCakeEndGameRes"
MakingMoonCakeController.PM_MakingMoonCakeBuyTimesRes = "MakingMoonCakeController.PM_MakingMoonCakeBuyTimesRes"
MakingMoonCakeController.PM_MakingMoonCakeReceiveAllPrizeRes = "MakingMoonCakeController.PM_MakingMoonCakeReceiveAllPrizeRes"
MakingMoonCakeController.PM_MakingMoonCakeGainRoleProgressPrizeRes = "MakingMoonCakeController.PM_MakingMoonCakeGainRoleProgressPrizeRes"

function MakingMoonCakeController:ctor()
	MakingMoonCakeController.super.ctor(self)
end

function MakingMoonCakeController:onInit()
	MakingMoonCakeController.super.onInit(self)
end

function MakingMoonCakeController:onReset()
	MakingMoonCakeController.super.onReset(self)
end

function MakingMoonCakeController:handlePM_MakingMoonCakeInfoRes(msg)
	MakingMoonCakeModel.instance:setSurplusTimes(msg.surplusTimes)
	MakingMoonCakeModel.instance:setCurCumulativeScore(msg.curCumulativeScore)
	MakingMoonCakeModel.instance:setReceivedCumulativePrizeIds(msg.receivedCumulativePrizeIds)
	MakingMoonCakeModel.instance:setBuyTimes(msg.buyTimes)
	MakingMoonCakeModel.instance:setWeekScore(msg.weekScore)
	MakingMoonCakeModel.instance:setRoles(msg.roles)
	GlobalDispatcher:dispatch(MakingMoonCakeController.PM_MakingMoonCakeInfoRes)
end

function MakingMoonCakeController:handlePM_MakingMoonCakeStartGameRes(msg)
	MakingMoonCakeModel.instance:setClientKey(msg.clientKey)
	MakingMoonCakeModel.instance:setMixedKey(msg.mixedKey)
	GlobalDispatcher:dispatch(MakingMoonCakeController.PM_MakingMoonCakeStartGameRes)
end

function MakingMoonCakeController:handlePM_MakingMoonCakeEndGameRes(msg)
	MakingMoonCakeModel.instance:setSurplusTimes(msg.surplusTimes)
	MakingMoonCakeModel.instance:setCurCumulativeScore(msg.curCumulativeScore)
	MakingMoonCakeModel.instance:setWeekScore(msg.weekScore)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	GlobalDispatcher:dispatch(MakingMoonCakeController.PM_MakingMoonCakeEndGameRes)
end

function MakingMoonCakeController:handlePM_MakingMoonCakeBuyTimesRes(msg)
	MakingMoonCakeModel.instance:setSurplusTimes(msg.surplusTimes)
	MakingMoonCakeModel.instance:setBuyTimes(MakingMoonCakeModel.instance:getBuyTimes() + 1)
	GlobalDispatcher:dispatch(MakingMoonCakeController.PM_MakingMoonCakeBuyTimesRes)
end

function MakingMoonCakeController:handlePM_MakingMoonCakeReceiveCumulativePrizeRes(msg)
	MakingMoonCakeModel.instance:setReceivedCumulativePrizeIds(msg.receivedCumulativePrizeIds)
	GlobalDispatcher:dispatch(MakingMoonCakeController.PM_MakingMoonCakeReceiveCumulativePrizeRes)
end

function MakingMoonCakeController:handlePM_MakingMoonCakeReceiveAllPrizeRes(msg)
	MakingMoonCakeModel.instance:handlePM_MakingMoonCakeReceiveAllPrizeRes(msg)
	GlobalDispatcher:dispatch(MakingMoonCakeController.PM_MakingMoonCakeReceiveAllPrizeRes, msg)
end

function MakingMoonCakeController:handlePM_MakingMoonCakeGainRoleProgressPrizeRes(msg)
	MakingMoonCakeModel.instance:handlePM_MakingMoonCakeGainRoleProgressPrizeRes(msg)
	GlobalDispatcher:dispatch(MakingMoonCakeController.PM_MakingMoonCakeGainRoleProgressPrizeRes, msg)
end

function MakingMoonCakeController:getActivityInfo()
	local activity = MakingMoonCakeConfig.instance:getActivity()

	for i, activityCfg in ipairs(activity) do
		if ActivityDefineController.instance:isInActivityTimeById(68, activityCfg.activityId) then
			local activityInfo = clone(activityCfg)
			local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(68, activityInfo.activityId)

			activityInfo.startTime = startTime
			activityInfo.endTime = endTime

			return activityInfo
		end
	end
end

function MakingMoonCakeController:createMakeInfo()
	local moonCakes = MakingMoonCakeConfig.instance:getInfo()
	local moonCake = moonCakes[math.random(1, #moonCakes)]
	local makeInfo = {
		data = moonCake,
		materials = {},
		selectMaterials = {}
	}
	local materialsCfg = MakingMoonCakeConfig.instance:getMaterial()

	for i, id in ipairs(moonCake.materials) do
		table.insert(makeInfo.materials, materialsCfg[id])
	end

	if not moonCake.randMaterials then
		local randMaterials = {}
		local maxMaterialNum = tonumber(MakingMoonCakeConfig.instance:getParamByKey("MAX_MATERIAL_NUM"))
		local randMaterialNum = math.random(0, math.min(#randMaterials, maxMaterialNum - #moonCake.materials))

		for i = 1, randMaterialNum do
			table.insert(makeInfo.materials, MakingMoonCakeConfig.instance:getMaterialById(table.remove(randMaterials, math.random(1, #randMaterials))))
		end

		for i, value in ipairs(makeInfo.materials) do
			table.insert(makeInfo.selectMaterials, value)
		end

		for i = #makeInfo.selectMaterials + 1, 12 do
			table.insert(makeInfo.selectMaterials, materialsCfg[math.random(1, #materialsCfg)])
		end

		MathUtil.randArray(makeInfo.selectMaterials)

		return makeInfo
	end
end

function MakingMoonCakeController:getText(key, ...)
	local params = {
		...
	}

	if #params > 0 then
		return string.format(MakingMoonCakeConfig.instance:getTextByKey(key), ...)
	else
		return MakingMoonCakeConfig.instance:getTextByKey(key)
	end
end

function MakingMoonCakeController:numberFormatChange(num)
	if num >= 10000 and num < 10000000 then
		num = num / 1000

		local intNum, floatNum = math.modf(num)

		return intNum / 10 .. "w"
	elseif num >= 10000000 and num < 100000000 then
		num = num / 1000000

		local intNum, floatNum = math.modf(num)

		return intNum / 10 .. "kw"
	else
		return num
	end
end

MakingMoonCakeController.instance = MakingMoonCakeController.New()

return MakingMoonCakeController
