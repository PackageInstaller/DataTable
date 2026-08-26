-- chunkname: @modules/logic/versionactivity2_5/challenge/model/Act183HeroMO.lua

module("modules.logic.versionactivity2_5.challenge.model.Act183HeroMO", package.seeall)

local Act183HeroMO = pureTable("Act183HeroMO")

function Act183HeroMO:init(info)
	self._heroId = tonumber(info.heroId)
	self._trialId = tonumber(info.trialId)

	if self._heroId and self._heroId ~= 0 then
		self._heroType = Act183Enum.HeroType.Normal
		self._heroMo = HeroModel.instance:getByHeroId(self._heroId)
	elseif self._trialId and self._trialId ~= 0 then
		self._heroType = Act183Enum.HeroType.Trial
		self._heroMo = HeroMo.New()

		self._heroMo:initFromTrial(self._trialId)
	else
		logError("角色唯一id和试用id都为0")
	end

	if not self._heroMo then
		logError(string.format("角色数据不存在 heroId = %s, trialId = %s", self._heroId, self._trialId))
	end

	self._config = self._heroMo and self._heroMo.config
	self._type = info.type
end

function Act183HeroMO:getHeroMo()
	return self._heroMo
end

function Act183HeroMO:getHeroType()
	return self._heroType
end

function Act183HeroMO:getHeroIconUrl()
	if self._heroType == Act183Enum.HeroType.Normal then
		return ResUrl.getHeadIconSmall(self._heroMo.skin)
	elseif self._heroType == Act183Enum.HeroType.Trial then
		return ResUrl.getHeadIconSmall(self._heroMo.skin)
	else
		logError("GetHeroIconUrl error")
	end
end

function Act183HeroMO:getHeroCarrer()
	return self._config.career
end

function Act183HeroMO:getHeroId()
	return self._heroMo and self._heroMo.heroId
end

function Act183HeroMO:isTeamLeader()
	return self._type == 1
end

return Act183HeroMO
