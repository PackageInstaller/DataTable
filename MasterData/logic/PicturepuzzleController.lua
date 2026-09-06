-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/controller/PicturepuzzleController.lua

module("logic.extensions.picturepuzzle.controller.PicturepuzzleController", package.seeall)

local PicturepuzzleController = class("PicturepuzzleController", BaseController)

PicturepuzzleController.PM_PuzzleJigsawGetInfoRes = "PicturepuzzleController_PM_PuzzleJigsawGetInfoRes"
PicturepuzzleController.PM_PuzzleJigsawStartGameRes = "PicturepuzzleController_PM_PuzzleJigsawStartGameRes"
PicturepuzzleController.PM_PuzzleJigsawEndGameRes = "PicturepuzzleController_PM_PuzzleJigsawEndGameRes"
PicturepuzzleController.PM_PuzzleJigsawGainPrizeRes = "PicturepuzzleController_PM_PuzzleJigsawGainPrizeRes"
PicturepuzzleController.PM_PuzzleJigsawGainFinalPrizeRes = "PicturepuzzleController_PM_PuzzleJigsawGainFinalPrizeRes"

function PicturepuzzleController:ctor()
	return
end

function PicturepuzzleController:onInit()
	PicturepuzzleController.super.onInit(self)

	self._sendParam = {}
end

function PicturepuzzleController:onReset()
	PicturepuzzleController.super.onReset(self)

	self._sendParam = {}
	self._tempChipData = nil
end

function PicturepuzzleController:handlePM_PuzzleJigsawGetInfoRes(msg)
	GlobalDispatcher:dispatch(PicturepuzzleController.PM_PuzzleJigsawGetInfoRes, msg)
end

function PicturepuzzleController:handlePM_PuzzleJigsawStartGameRes(msg)
	GlobalDispatcher:dispatch(PicturepuzzleController.PM_PuzzleJigsawStartGameRes, msg)
end

function PicturepuzzleController:sendPM_PuzzleJigsawEndGameReq(isPass, clientEncryptedKey)
	self._sendParam[PicturepuzzleController.PM_PuzzleJigsawEndGameRes] = {
		isPass = isPass
	}

	PuzzleJigsawAgent.instance:sendPM_PuzzleJigsawEndGameReq(isPass, clientEncryptedKey)
end

function PicturepuzzleController:handlePM_PuzzleJigsawEndGameRes()
	local activityInfo = self:getOpenInfo()

	PuzzleJigsawAgent.instance:sendPM_PuzzleJigsawGetInfoReq(activityInfo.id)
end

function PicturepuzzleController:sendPM_PuzzleJigsawGainPrizeReq(actId, jigsawId)
	self._sendParam[PicturepuzzleController.PM_PuzzleJigsawGainPrizeRes] = {
		actId = actId,
		jigsawId = jigsawId
	}

	PuzzleJigsawAgent.instance:sendPM_PuzzleJigsawGainPrizeReq(actId, jigsawId)
end

function PicturepuzzleController:handlePM_PuzzleJigsawGainFinalPrizeRes(msg)
	local activityInfo = self:getOpenInfo()

	PuzzleJigsawAgent.instance:sendPM_PuzzleJigsawGetInfoReq(activityInfo.id)
	GlobalDispatcher:dispatch(PicturepuzzleController.PM_PuzzleJigsawGainFinalPrizeRes, msg)
end

function PicturepuzzleController:getOpenInfo()
	local activityCfgs, result = PicturepuzzleConfig.instance:getActivity(), {}

	for i, activity in ipairs(activityCfgs) do
		local defineCfgs = PicturepuzzleConfig.instance:getDefineById(activity.jigsawPlanId)

		for k, value in pairs(defineCfgs) do
			table.insert(result, {
				planId = value.jigsawId,
				icon = value.icon,
				openDay = value.openDay,
				prize = value.prize,
				grayIcon = value.grayIcon,
				baseIcon = value.baseIcon,
				shareIcon = value.shareIcon,
				shareId = value.shareId
			})
		end

		table.sort(result, function(a, b)
			return a.openDay < b.openDay
		end)

		local jigsawPrizeCfg = PicturepuzzleConfig.instance:getPrizeById(activity.prizePlanId)

		result.id = activity.id
		result.gainDay = jigsawPrizeCfg.gainDay
		result.finalPrize = jigsawPrizeCfg.finalPrize
		result.startTime, result.endTime = ActivityDefineController.instance:getStartTimeAndEndTime(56, activity.id)

		return result
	end
end

function PicturepuzzleController:randomChip(chipList, goList, planId)
	local result = {}

	if self._tempChipData then
		for i, chip in ipairs(chipList) do
			if not self._tempChipData or self._tempChipData[i] then
				table.insert(result, {
					icon = chip.icon,
					tarId = i,
					target = goList[i]
				})
			end
		end

		for i = #result, 1, -1 do
			local newIdx = math.random(1, i)

			result[i] = result[newIdx]
			result[newIdx] = result[i]
		end

		return result
	end
end

function PicturepuzzleController:saveSuspendData(planId, data)
	self._tempChipData = self._tempChipData or {}

	if #data == 0 then
		self._tempChipData[planId] = nil
	else
		local result = {}

		for i, value in ipairs(data) do
			result[value.tarId] = true
		end

		self._tempChipData[planId] = result
	end
end

function PicturepuzzleController:getSuspendData(planId)
	if self._tempChipData then
		return self._tempChipData[planId]
	end
end

PicturepuzzleController.instance = PicturepuzzleController.New()

return PicturepuzzleController
