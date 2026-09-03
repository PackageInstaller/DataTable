-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/model/HeroStoryPoint.lua

HeroStoryPoint = class("HeroStoryPoint")

HeroStoryPoint:has("_pointId", {
	is = "rw"
})
HeroStoryPoint:has("_owner", {
	is = "rw"
})
HeroStoryPoint:has("_index", {
	is = "rw"
})
HeroStoryPoint:has("_starState", {
	is = "rw"
})
HeroStoryPoint:has("_starCount", {
	is = "rw"
})
HeroStoryPoint:has("_challengeTimes", {
	is = "rw"
})

function HeroStoryPoint:initialize(pointId)
	self._pointId = pointId
	self._starState = {}
	self._starCount = 0
	self._isPass = false
	self._config = ConfigReader:getRecordById("HeroStoryPoint", pointId)
	self._challengeTimes = self._config.LimitAmount
end

function HeroStoryPoint:sync(data)
	if data.isPass then
		self._isPass = data.isPass
	end

	if data.star then
		self:setStarState(data.star)
	end

	if data.heroStoryNum then
		self._challengeTimes = data.heroStoryNum.value
	end
end

function HeroStoryPoint:setStarState(stars)
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

function HeroStoryPoint:isPass()
	return self._isPass
end

function HeroStoryPoint:isUnlock(heroInfo)
	if self:isPass() then
		return true
	end

	local heroLove = heroInfo.heroLove
	local heroQuality = heroInfo.heroQuality
	local heroStar = heroInfo.heroStar
	local unlockCondition = self._config.Condition
	local condition = true
	local conditionNum = 0

	for k, v in pairs(unlockCondition) do
		if k == "HeroLove" and heroLove < tonumber(v) then
			condition = false
			conditionNum = tonumber(v)

			break
		end

		if k == "Quality" and heroQuality < tonumber(v) then
			condition = false
			conditionNum = Strings:get("QualityDesc_" .. tonumber(v))

			break
		end

		if k == "HeroStar" and heroStar < tonumber(v) then
			condition = false
			conditionNum = tonumber(v)

			break
		end
	end

	if condition then
		local prePoint = self._config.OpenPoint
		local _point = self._owner:getHeroStoryPointById(prePoint)

		if not _point or _point:isPass() then
			return true
		else
			return false, Strings:get("Lock2")
		end
	else
		return false, Strings:get(self._config.UnlockTip, {
			Hero = heroInfo.heroName,
			HeroLove = conditionNum,
			HeroQuality = conditionNum
		})
	end
end

function HeroStoryPoint:getChallengeTimes()
	return self._challengeTimes
end

function HeroStoryPoint:getName()
	return self._config.Name
end

function HeroStoryPoint:isBoss()
	return self._config.PointType == "BOSS"
end

function HeroStoryPoint:getMaxChallengeTimes()
	return self._config.LimitAmount
end

function HeroStoryPoint:getShowFirstKillReward()
	local rewardId = self._config.FirstKillReward

	return (ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content"))
end

function HeroStoryPoint:getShowRewards()
	local rewardId = self._config.ShowItem

	return (ConfigReader:getDataByNameIdAndKey("Reward", rewardId, "Content"))
end

function HeroStoryPoint:getStarCondition()
	return self._config.StarCondition
end

function HeroStoryPoint:getConfig()
	return self._config
end

function HeroStoryPoint:getMainShowItem()
	return self._config.MainShowItem
end
