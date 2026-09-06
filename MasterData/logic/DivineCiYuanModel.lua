-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/model/DivineCiYuanModel.lua

module("logic.extensions.divineciyuan.model.DivineCiYuanModel", package.seeall)

local DivineCiYuanModel = class("DivineCiYuanModel", BaseModel)

function DivineCiYuanModel:ctor()
	return
end

function DivineCiYuanModel:onInit()
	self:onReset()
end

function DivineCiYuanModel:onReset()
	self.ciyuanInfo = {}
	self.universalInfo = {}
	self.extremeInfo = {}
	self.NationalTabId = 1
	self.NationalStageId = 0
	self.ExtremeTabId = 1
	self.ExtremeStageId = 1
	self._dcyNationalFmtMo = nil
	self._dcyExtremeFmtMo = nil
end

function DivineCiYuanModel:setCiYuanInfo(msg)
	GameUtil.pbToTable(msg, self.ciyuanInfo)

	self.extremeInfo = self.ciyuanInfo.extremeInfo
	self.universalInfo = self.ciyuanInfo.universalInfo
end

function DivineCiYuanModel:getUniversalInfo()
	return self.universalInfo
end

function DivineCiYuanModel:isGainUniversalPrize()
	return checkbool(self.universalInfo.gainPrize)
end

function DivineCiYuanModel:setNationalIds(tabId, stageId)
	self.NationalTabId = tabId
	self.NationalStageId = stageId
end

function DivineCiYuanModel:resetNationalIds()
	self.NationalTabId = 1
	self.NationalStageId = 0
end

function DivineCiYuanModel:getNationalIds()
	return self.NationalTabId, self.NationalStageId
end

function DivineCiYuanModel:getTodayChallengeTimes(tabId)
	local tabInfos = self.universalInfo.tabInfos

	for _, info in ipairs(tabInfos) do
		if info.tabId == tabId then
			return info.todayChallengeTimes
		end
	end

	return 0
end

function DivineCiYuanModel:getBossBlood()
	local tabInfos = self.universalInfo.tabInfos
	local hpRate = 0

	for _, info in ipairs(tabInfos) do
		for _, boss in ipairs(info.bossInfos) do
			hpRate = hpRate + Mathf.Clamp(checknumber(boss.leftHp / boss.bossHp * 100), 0, 100)
			hpRate = math.ceil(hpRate)
		end
	end

	return math.ceil(hpRate)
end

function DivineCiYuanModel:getBossInfoById(tabId, bossId)
	local tabInfos = self.universalInfo.tabInfos
	local isOneKey = self:getIsOneKeyPass()

	for _, info in ipairs(tabInfos) do
		if info.tabId == tabId then
			for _, boss in ipairs(info.bossInfos) do
				if boss.bossId == bossId then
					local info = {}

					info.bossHp = boss.bossHp
					info.bossId = boss.bossId
					info.leftHp = isOneKey and 0 or boss.leftHp

					return info
				end
			end
		end
	end

	return {}
end

function DivineCiYuanModel:getIsOneKeyPass()
	return checkbool(self.universalInfo.oneKeyPass)
end

function DivineCiYuanModel:getExtremeInfo()
	return self.extremeInfo or {}
end

function DivineCiYuanModel:getExtremeStageIds(tabId)
	if TableUtil.isTableEmpty(self.extremeInfo.tabInfos) then
		return 1
	end

	for _, tabInfo in ipairs(self.extremeInfo.tabInfos) do
		if tabInfo.tabId == tabId then
			local activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineCiYuan)
			local stageCfg = DivineCiYuanConfig.instance:getExtremeStageCfg(activityId, tabId)
			local maxStageCount = #stageCfg

			return Mathf.Clamp(tabInfo.passedStageId + 1, 1, maxStageCount)
		end
	end

	return 1
end

function DivineCiYuanModel:getExtremePetIds(tabId, stageId)
	if TableUtil.isTableEmpty(self.extremeInfo.tabInfos) then
		return {}
	end

	local lockPetIds = {}

	for _, tabInfo in ipairs(self.extremeInfo.tabInfos) do
		if tabInfo.tabId == tabId then
			if TableUtil.isTableEmpty(tabInfo.teamInfos) then
				return {}
			end

			for _, teamInfo in ipairs(tabInfo.teamInfos) do
				TableUtil.AddTable(lockPetIds, teamInfo.petIds)
			end
		end
	end

	return lockPetIds
end

function DivineCiYuanModel:isGainExtremePrize()
	return checkbool(self.extremeInfo.gainPrize)
end

function DivineCiYuanModel:getSelectBuffId(tabId)
	if TableUtil.isTableEmpty(self.extremeInfo.tabInfos) then
		return 0
	end

	for _, v in ipairs(self.extremeInfo.tabInfos) do
		if v.tabId == tabId then
			return v.selectBuffId
		end
	end

	return 0
end

function DivineCiYuanModel:getHasOneKeySignIn()
	return self.ciyuanInfo.universalInfo.oneKeySignIn
end

function DivineCiYuanModel:getNationalChallengeFmtMo(activityId, tabId, bossId)
	if self._dcyNationalFmtMo == nil then
		self._dcyNationalFmtMo = DivineCiYuanNationalFmtMo.New()
	end

	self._dcyNationalFmtMo:initParams(activityId, tabId, bossId)

	return self._dcyNationalFmtMo
end

function DivineCiYuanModel:getExtremeChallengeFmtMo(activityId, tabId, stageId, teamIndex)
	if self._dcyExtremeFmtMo == nil then
		self._dcyExtremeFmtMo = {}
	end

	if self._dcyExtremeFmtMo[tabId] == nil then
		self._dcyExtremeFmtMo[tabId] = DivineCiYuanExtremeFmtMo.New()
	end

	self._dcyExtremeFmtMo[tabId]:initParams(activityId, tabId, stageId, teamIndex)

	return self._dcyExtremeFmtMo[tabId]
end

DivineCiYuanModel.instance = DivineCiYuanModel.New()

return DivineCiYuanModel
