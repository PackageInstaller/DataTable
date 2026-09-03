-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/StagePoint.lua

StagePoint = class("StagePoint")

StagePoint:has("_id", {
	is = "r"
})
StagePoint:has("_index", {
	is = "rw"
})
StagePoint:has("_starCount", {
	is = "rw"
})
StagePoint:has("_box", {
	is = "rw"
})
StagePoint:has("_runBoxList", {
	is = "rw"
})
StagePoint:has("_owner", {
	is = "rw"
})
StagePoint:has("_starState", {
	is = "r"
})
StagePoint:has("_oldStar", {
	is = "r"
})
StagePoint:has("_prePracPoint", {
	is = "rw"
})
StagePoint:has("_isDailyFirstEnter", {
	is = "rw"
})

function StagePoint:initialize(pointId)
	assert(pointId ~= nil, "error:pointId=nil")
	super.initialize(self)

	self._id = pointId
	self._starCount = 0
	self._isPass = false
	self._boxState = StageBoxState.kCannotReceive
	self._config = ConfigReader:getRecordById(self:getConfigName(), pointId)
	self._isDailyFirstEnter = true

	local replaceConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "NewPlayer_StageShowReward", "content")
	local rewardId = self._config.FirstKillReward
	local rewards = ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content")

	self._firstReward = {}

	for k, v in pairs(replaceConfig) do
		if pointId == k then
			local replaceRewards = ConfigReader:getDataByNameIdAndKey("Reward", v, "Content")

			table.copy(replaceRewards, self._firstReward)

			break
		end
	end

	for i = 1, #rewards do
		self._firstReward[#self._firstReward + 1] = rewards[i]
	end
end

function StagePoint:getConfigName()
	return "BlockPoint"
end

function StagePoint:sync(data)
	if data.isPass then
		self._isPass = data.isPass
	end

	if data.stars then
		self:setStarState(data.stars)
	end
end

function StagePoint:setStarState(stars)
	self._starState = {}

	for i = 1, 3 do
		self._starState[i] = false
	end

	self._starCount = 0

	for k, v in pairs(stars) do
		self._starState[v] = true
		self._starCount = self._starCount + 1
	end
end

function StagePoint:recordOldStar()
	self._oldStar = self._starState or {}
end

function StagePoint:_getConfig()
	return self._config
end

function StagePoint:getPlayer()
	return self:getOwner():getPlayer()
end

function StagePoint:isUnlock()
	if not self._owner:isUnlock() then
		return false
	end

	local prePoints = self._config.OpenPoint
	local preStoryPoints = self._config.PreStoryPoint
	local prePracPoint = self:getPrePracPoint()

	if prePoints[1] then
		local _point = self._owner:getPointById(prePoints[1])

		if _point and not _point:isPass() then
			return false
		end
	end

	if preStoryPoints[1] then
		local _point = self._owner:getStoryPointById(preStoryPoints[1])

		if _point and not _point:isPass() then
			return false
		end
	end

	if prePracPoint then
		local _point = self._owner:getPracticePointById(prePracPoint)

		if _point and not _point:isPass() then
			return false
		end
	end

	local openLevel = self:getOpenLevel()
	local level = self:getPlayer():getLevel()

	if level < openLevel then
		return false
	end

	return true
end

function StagePoint:isPass()
	return self._isPass
end

function StagePoint:getName()
	return Strings:get(self._config.Name)
end

function StagePoint:getHeadId()
	return self._config.PointHead
end

function StagePoint:getOpenLevel()
	return self._config.OpenLevel
end

function StagePoint:getRecommendCombat()
	return self._config.CombatValue
end

function StagePoint:getBackground()
	return self._config.Background
end

function StagePoint:getPointElement()
	return self._config.Element
end

function StagePoint:isBoss()
	return self._config.PointType == StagePointType.kBoss
end

function StagePoint:getBubbleString()
	local bubbleStringConfig = self._config.BlockBubble

	return Strings:get(bubbleStringConfig)
end

function StagePoint:getDesc()
	return Strings:get(self._config.BlockDesc)
end

function StagePoint:getMapTitle()
	return self._owner:getName()
end

function StagePoint:getShowRewards()
	local rewardId = self._config.ShowItem

	return (ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content"))
end

function StagePoint:getCostEnergy()
	return self._config.StaminaCost
end

function StagePoint:getMainItemId()
	return self._config.MainShowItem
end

function StagePoint:getDetailBgPic()
	return self._config.Banner
end

function StagePoint:getType()
	return self._config.Type
end

function StagePoint:getRecommendCombat()
	return self._config.CombatValue
end

function StagePoint:getSpRuleBubbleDesc()
	return self._config.SpRuleBubble
end

function StagePoint:getNPCData()
	return self._config.NPC
end

function StagePoint:getTotalStarCount()
	local starConditions = self:getStarCondition()

	return (starConditions or nil) and (#starConditions or 0)
end

function StagePoint:getStarCondition()
	return self._config.StarCondition
end

function StagePoint:getTarget()
	return self._config.BlockPrompt
end

function StagePoint:getLoadingList()
	return self._config.LoadingBorad
end

function StagePoint:getPointBoard()
	return self._config.PointBoard
end

function StagePoint:getGuideDesc()
	return self._config.SpecialRuleShow
end

function StagePoint:getBublingTips()
	if self._config.UnlockBubble == "" then
		return false
	end

	return Strings:get(self._config.UnlockBubble)
end

function StagePoint:getBlockDetailAuto()
	return self._config.BlockDetailAuto
end

function StagePoint:getShowFirstKillReward()
	return self._firstReward
end
