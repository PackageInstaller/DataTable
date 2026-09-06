-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/controller/DragonpoolController.lua

module("logic.extensions.dragonpool.controller.DragonpoolController", package.seeall)

local DragonpoolController = class("DragonpoolController", BaseController)

DragonpoolController.MoodType = {
	Chat = 2,
	Weed = 3,
	Touch = 1
}

function DragonpoolController:ctor()
	return
end

function DragonpoolController:onInit()
	self:onReset()
end

function DragonpoolController:onReset()
	return
end

function DragonpoolController:addMood(activityId, moodType)
	local addMood = 0
	local cfg = DragonpoolConfig.instance:getActivityCfg(activityId)

	if moodType == DragonpoolController.MoodType.Touch then
		addMood = cfg.touchIncMood
	elseif moodType == DragonpoolController.MoodType.Chat then
		addMood = cfg.chatIncMood
	elseif moodType == DragonpoolController.MoodType.Weed then
		addMood = cfg.weedIncMood
	end

	FloatWordMgr.instance:show(string.format("心情值+%s", addMood))
end

function DragonpoolController:checkRedPoint()
	local info = DragonpoolModel.instance:getInfo()
	local isRed = false

	if info then
		local cfgs = DragonpoolConfig.instance:getPrizeCfgs(info.actId)
		local progress = DragonpoolModel.instance:getEggProgress()

		for i, cfg in ipairs(cfgs) do
			local isGain = DragonpoolModel.instance:isGainPrize(cfg.prizeId)
			local isCanGain = not isGain and progress >= cfg.progress

			if isCanGain then
				isRed = true

				break
			end
		end
	end

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_DRAGONPOOL_REWARD, isRed)
end

function DragonpoolController:onGainPrize(prizeId)
	DragonpoolModel.instance:onGainPrize(prizeId)
	self:checkRedPoint()
end

DragonpoolController.instance = DragonpoolController.New()

return DragonpoolController
