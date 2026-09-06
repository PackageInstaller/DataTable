-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalkingsignin/model/SurvivalKingSignInModel.lua

module("logic.extensions.survivalkingsignin.model.SurvivalKingSignInModel", package.seeall)

local SurvivalKingSignInModel = class("SurvivalKingSignInModel", BaseModel)

function SurvivalKingSignInModel:onInit()
	self:onReset()
end

function SurvivalKingSignInModel:onReset()
	self._baseInfoMap = {}
end

function SurvivalKingSignInModel:getBaseInfo(activityId)
	local baseInfo = self._baseInfoMap[activityId]

	if not baseInfo then
		print(string.format("生存之王签到数据未初始化：%s", activityId))
	end

	return baseInfo
end

function SurvivalKingSignInModel:onGetInfo(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId

	self._baseInfoMap[activityId] = info
end

function SurvivalKingSignInModel:onSignIn(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		baseInfo.dailySignIn = true

		if not baseInfo.zoneIds then
			table.insert(baseInfo.zoneIds, info.zoneId)

			baseInfo.zoneIds = baseInfo.zoneIds
		end
	end
end

function SurvivalKingSignInModel:onGainPrize(msg)
	local info = GameUtil.pbToTable(msg)
	local activityId = info.activityId
	local baseInfo = self:getBaseInfo(activityId)

	if baseInfo then
		baseInfo.gainedPrize = true
	end
end

SurvivalKingSignInModel.instance = SurvivalKingSignInModel.New()

return SurvivalKingSignInModel
