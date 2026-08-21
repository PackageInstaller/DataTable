-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/user/controller/UserUtil.lua

module("logic.extensions.user.controller.UserUtil", package.seeall)

local json = require("cjson")

function UserUtil.uploadGuideBuryPoint(guideMO, isBegin, guideFinishType, lastStepId)
	if not guideMO then
		return
	end

	local keys = CommEnum.BuryPointGuideKey
	local guideCO = guideMO:getGuideCO()

	guideCO = guideCO or GuideConfig:getGuideCO(guideMO.id)

	if not guideCO then
		return
	end

	local guideLastStepId = lastStepId and lastStepId or guideMO:getFinishClientStep()
	local guideFinishType = guideFinishType == 1 and "正常结束" or "跳过"

	guideLastStepId = tostring(guideLastStepId)

	if isBegin then
		guideFinishType = ""
		guideLastStepId = ""
	end

	local info = {
		[keys.GuideId] = tostring(guideMO.id),
		[keys.GuideType] = tostring(guideCO.triggerType),
		[keys.GuideState] = isBegin and "引导开始" or "引导结束",
		[keys.GuideFinishType] = guideFinishType,
		[keys.GuideLastStepId] = guideLastStepId
	}
	local jsStr = json.encode(info)

	UserAgent.instance:sendUploadStatsRequest(CommEnum.BuryPointType.Guide, jsStr)
end

function UserUtil.uploadStoryBuryPoint(storyId, storySkip, storyTime)
	storySkip = storySkip or false

	local storyFbId = DungeonConfig.instance:getDungeonIdByStoryId(storyId)
	local keys = CommEnum.BuryPointStoryKey
	local info = {
		[keys.StoryId] = storyId,
		[keys.StoryFbId] = storyFbId,
		[keys.StorySkip] = tostring(storySkip),
		[keys.StoryTime] = storyTime
	}
	local jsStr = json.encode(info)

	UserAgent.instance:sendUploadStatsRequest(CommEnum.BuryPointType.Story, jsStr)
end

function UserUtil.uploadStoreTaPoint(storeTabNme)
	local keys = CommEnum.BuryPointMallOpenKey
	local info = {
		[keys.OpenTagName] = storeTabNme
	}
	local jsStr = json.encode(info)

	UserAgent.instance:sendUploadStatsRequest(CommEnum.BuryPointType.MallOpen, jsStr)
end

UserUtil.firstRechargeTime = 0

function UserUtil.uploadFirstRechargePoint(stayTime, rechargeJump)
	local keys = CommEnum.BuryPointFirstRechargeKey
	local info = {
		[keys.StayTime] = stayTime,
		[keys.RechargeJump] = rechargeJump
	}
	local jsStr = json.encode(info)

	UserAgent.instance:sendUploadStatsRequest(CommEnum.BuryPointType.FirstRecharge, jsStr)
end

UserUtil.activityFirstTabName = ""
UserUtil.activitySecondTabName = ""

function UserUtil.uploadActivityTabBuryPoint(firstTabName, secondTabName, btnName)
	local keys = CommEnum.ActivityTabClickKey
	local info = {
		[keys.firstTabName] = firstTabName or "",
		[keys.secondTabName] = secondTabName or "",
		[keys.btnName] = btnName or ""
	}
	local jsStr = json.encode(info)

	UserAgent.instance:sendUploadStatsRequest(CommEnum.BuryPointType.ActivityTabClick, jsStr)
end

return UserUtil
