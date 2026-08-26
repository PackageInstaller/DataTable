-- chunkname: @modules/logic/versionactivity3_3/arcade/model/ArcadeOutSizeModel.lua

module("modules.logic.versionactivity3_3.arcade.model.ArcadeOutSizeModel", package.seeall)

local ArcadeOutSizeModel = class("ArcadeOutSizeModel", BaseModel)

function ArcadeOutSizeModel:onInit()
	self:reInit()
end

function ArcadeOutSizeModel:reInit()
	if self._rewardModel then
		self._rewardModel:clear()

		self._rewardModel = nil
	end

	self._attrValues = {}
	self._finishLevelCount = {}
end

function ArcadeOutSizeModel:refreshInfo(info)
	self._score = info.prop.score

	self:_refreshRewardInfo(info.prop.gain)
	self:_refreshHeroInfo(info.prop.unlockRoleIds)
	self:_refreshUnlockLevelInfo(info.prop.unlockDifficultyIds)
	ArcadeHeroModel.instance:refreshInfo(info.player, info.talentInfo)
	ArcadeHandBookModel.instance:refreshInfo(info.bookInfo)
	self:refreshAttribute(info.attrContainer.attrValues)
	self:refreshHotfixInfo(info.prop.hotfix)
	self:refreshReturnRewardData(info.prop.returnRewardData)
end

function ArcadeOutSizeModel:refreshHotfixInfo(hotfix)
	self._finishLevelCount = {}

	if hotfix and not string.nilorempty(hotfix[1]) then
		local split = GameUtil.splitString2(hotfix[1], true, "|", "#")

		for _, v in ipairs(split) do
			self._finishLevelCount[v[1]] = v[2]
		end
	end
end

function ArcadeOutSizeModel:refreshAttribute(attrValues)
	local list = {}

	for i = 1, #attrValues do
		local info = attrValues[i]

		list[info.id] = {
			base = info.base,
			rate = info.rate
		}
	end

	for _, attrId in pairs(ArcadeEnum.AttributeConst) do
		self._attrValues[attrId] = list[attrId]
	end
end

function ArcadeOutSizeModel:refreshReturnRewardData(strReturnRewardData)
	self._strReturnRewardData = strReturnRewardData
end

function ArcadeOutSizeModel:_refreshRewardInfo(gain)
	local list = {}

	if gain then
		for i = 1, #gain do
			list[gain[i]] = true
		end
	end

	for _, mo in ipairs(self:getRewardList()) do
		mo:onGain(list[mo.id])
	end
end

function ArcadeOutSizeModel:getRewardModel()
	if not self._rewardModel then
		self._rewardModel = BaseModel.New()

		local actId = ArcadeModel.instance:getAct222Id()

		for _, co in ipairs(lua_arcade_reward.configList) do
			if co.activityId == actId then
				local mo = ArcadeRewardMO.New(co)

				self._rewardModel:addAtLast(mo)
			end
		end
	end

	return self._rewardModel
end

function ArcadeOutSizeModel:getRewardList()
	local model = self:getRewardModel()

	return model:getList()
end

function ArcadeOutSizeModel:onFinishReward()
	for _, mo in ipairs(self:getRewardList()) do
		if mo:getRewardState() == ArcadeEnum.RewardItemStatus.CanGet then
			mo:onGain(true)
		end
	end
end

function ArcadeOutSizeModel:getScore()
	return self._score or 0
end

function ArcadeOutSizeModel:hasRewardReddot()
	local param = ArcadeHallEnum.HallInteractiveParams[ArcadeHallEnum.HallInteractiveId.Task]

	return RedDotModel.instance:isDotShow(param.Reddot, 0)
end

function ArcadeOutSizeModel:_refreshHeroInfo(unlockRoleIds)
	local list = {}

	if unlockRoleIds then
		for i = 1, #unlockRoleIds do
			list[unlockRoleIds[i]] = true
		end
	end

	local moList = ArcadeHandBookModel.instance:getMoListByType(ArcadeEnum.HandBookType.Character)

	for _, mo in pairs(moList) do
		local id = mo:getEleId()

		mo:setLock(not list[id])
	end
end

function ArcadeOutSizeModel:_refreshUnlockLevelInfo(unlockDifficultyIds)
	self._unlockLevel = {}

	if unlockDifficultyIds then
		for i = 1, #unlockDifficultyIds do
			self._unlockLevel[unlockDifficultyIds[i]] = true
		end
	end
end

function ArcadeOutSizeModel:isUnlockLevel(level)
	return self._unlockLevel and self._unlockLevel[level]
end

function ArcadeOutSizeModel:getPlayerPrefsValue(pref, key, defalutValue, isNumber)
	key = key or ""

	local _key = self:getPlayerPrefsKey(pref, key)

	if isNumber then
		return GameUtil.playerPrefsGetNumberByUserId(_key, defalutValue)
	end

	return GameUtil.playerPrefsGetStringByUserId(_key, defalutValue)
end

function ArcadeOutSizeModel:setPlayerPrefsValue(pref, key, value, isNumber)
	key = key or ""

	local _key = self:getPlayerPrefsKey(pref, key)

	if isNumber then
		GameUtil.playerPrefsSetNumberByUserId(_key, value)

		return
	end

	GameUtil.playerPrefsSetStringByUserId(_key, value)
end

function ArcadeOutSizeModel:getPlayerPrefsKey(pref, key)
	local actId = ArcadeModel.instance:getAct222Id()

	return string.format("ArcadeOutSizeModel_%s_%s_%s", pref, actId, key)
end

function ArcadeOutSizeModel:getAttrValues(attrId)
	local value = self._attrValues[attrId]

	return (value or nil) and (value.base or 0)
end

function ArcadeOutSizeModel:getStrReturnRewardData()
	return self._strReturnRewardData
end

function ArcadeOutSizeModel:clearAllPrefs()
	self:setPlayerPrefsValue(ArcadeEnum.PlayerPrefsKey.HallNPCFirst, ArcadeHallEnum.HallInteractiveId.NPC, 0, true)

	for _, type in pairs(ArcadeEnum.HandBookType) do
		local moList = ArcadeHandBookModel.instance:getMoListByType(type)

		if moList then
			for _, mo in pairs(moList) do
				mo:setNew(true)
				mo:saveNew(true)
			end
		end
	end

	for _, mo in ipairs(ArcadeHeroModel.instance:getHeroMoList()) do
		local prefsKey1, key1 = mo:getReddotKey()
		local prefsKey2, key2 = mo:getPlayUnlockAnimKey()

		self:setPlayerPrefsValue(prefsKey1, key1, 0, true)
		self:setPlayerPrefsValue(prefsKey2, key2, 0, true)
	end
end

function ArcadeOutSizeModel:getFinishLevelCount(level)
	return (self._finishLevelCount or nil) and (self._finishLevelCount[level] or 0)
end

ArcadeOutSizeModel.instance = ArcadeOutSizeModel.New()

return ArcadeOutSizeModel
