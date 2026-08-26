-- chunkname: @modules/logic/versionactivity1_4/act129/model/Activity129Model.lua

module("modules.logic.versionactivity1_4.act129.model.Activity129Model", package.seeall)

local Activity129Model = class("Activity129Model", BaseModel)

function Activity129Model:onInit()
	return
end

function Activity129Model:reInit()
	self.selectPoolId = nil
end

function Activity129Model:setInfo(info)
	local mo = self:getActivityMo(info.activityId)

	mo:init(info)
end

function Activity129Model:onLotterySuccess(info)
	local rewards = info.rewards
	local list = {}
	local spceialList = {}
	local normalList = {}

	for i = 1, #rewards do
		local reward = rewards[i]
		local co = Activity129Config.instance:getRewardConfig(info.poolId, reward.rare, reward.rewardType, reward.rewardId)
		local poolCfg = Activity129Config.instance:getPoolConfig(info.activityId, info.poolId)

		for rewardIndex = 1, reward.num do
			if reward.rare == 5 then
				if poolCfg.type ~= Activity129Enum.PoolType.Unlimite then
					table.insert(spceialList, co)
				end

				table.insert(list, co)
			else
				table.insert(normalList, co)
			end
		end
	end

	tabletool.addValues(list, normalList)
	Activity129Controller.instance:dispatchEvent(Activity129Event.OnShowSpecialReward, spceialList, list)

	local mo = self:getActivityMo(info.activityId)

	mo:onLotterySuccess(info)
end

function Activity129Model:getActivityMo(activityId)
	local mo = self:getById(activityId)

	if not mo then
		mo = Activity129Mo.New(activityId)

		self:addAtLast(mo)
	end

	return mo
end

function Activity129Model:getShopVoiceConfig(heroId, type, verifyCallback, targetSkinId)
	local result = {}
	local voice = self:getHeroShopVoice(heroId, targetSkinId)

	if not voice or not next(voice) then
		return result
	end

	for _, v in pairs(voice) do
		if v.type == type and (not verifyCallback or verifyCallback(v)) then
			table.insert(result, v)
		end
	end

	return result
end

function Activity129Model:getHeroShopVoice(heroId, targetSkinId)
	local voiceList = {}
	local colist = CharacterDataConfig.instance:getCharacterShopVoicesCo(heroId)

	if not colist then
		return voiceList
	end

	for _, config in pairs(colist) do
		if self:_checkSkin(config, targetSkinId) then
			local audio = config.audio

			voiceList[audio] = config
		end
	end

	return voiceList
end

function Activity129Model:_checkSkin(config, targetSkinId)
	if not config then
		return false
	end

	if string.nilorempty(config.skins) or not targetSkinId then
		return true
	end

	return string.find(config.skins, targetSkinId)
end

function Activity129Model:setSelectPoolId(poolId, noEvent)
	self.selectPoolId = poolId

	if not noEvent then
		Activity129Controller.instance:dispatchEvent(Activity129Event.OnEnterPool)
	end
end

function Activity129Model:getSelectPoolId()
	return self.selectPoolId
end

function Activity129Model:checkPoolIsEmpty(activityId, poolId)
	local mo = self:getActivityMo(activityId)

	return mo:checkPoolIsEmpty(poolId)
end

Activity129Model.instance = Activity129Model.New()

return Activity129Model
