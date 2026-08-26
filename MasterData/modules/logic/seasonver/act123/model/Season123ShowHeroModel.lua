-- chunkname: @modules/logic/seasonver/act123/model/Season123ShowHeroModel.lua

module("modules.logic.seasonver.act123.model.Season123ShowHeroModel", package.seeall)

local Season123ShowHeroModel = class("Season123ShowHeroModel", ListScrollModel)

function Season123ShowHeroModel:release()
	self:clear()
end

function Season123ShowHeroModel:init(actId, stage, layer)
	self.activityId = actId
	self.stage = stage
	self.layer = layer

	self:initHeroList()
end

function Season123ShowHeroModel:initHeroList()
	local result = {}
	local list = HeroModel.instance:getList()

	self:initLayerHeroList(result, self.layer)
	logNormal("hero list count : " .. tostring(#result))
	self:setList(result)
end

function Season123ShowHeroModel:initLayerHeroList(result, layer)
	local seasonMO = Season123Model.instance:getActInfo(self.activityId)

	if not seasonMO then
		return
	end

	local stageMO = seasonMO.stageMap[self.stage]

	if not stageMO then
		return
	end

	local episodeMO = stageMO.episodeMap[layer]

	if not episodeMO then
		return
	end

	local heroList = episodeMO.heroes

	for _, season123HeroMO in ipairs(heroList) do
		local heroMO = HeroModel.instance:getById(season123HeroMO.heroUid)

		if not heroMO then
			local assistHeroMO, assistMO = Season123Model.instance:getAssistData(self.activityId, self.stage)

			if assistMO and assistMO.heroUid == season123HeroMO.heroUid then
				local mo = Season123ShowHeroMO.New()

				mo:init(assistHeroMO, assistMO.heroUid, assistMO.heroId, assistMO.skin, season123HeroMO.hpRate, true)
				table.insert(result, mo)
			end
		else
			local mo = Season123ShowHeroMO.New()

			mo:init(heroMO, heroMO.uid, heroMO.heroId, heroMO.skin, season123HeroMO.hpRate, false)
			table.insert(result, mo)
		end
	end
end

function Season123ShowHeroModel:isFirstPlayHeroDieAnim(heroId)
	local key = self:getPlayHeroDieAnimPrefKey(self.stage)
	local value = PlayerPrefsHelper.getString(key, "")
	local heroList = string.split(value, "|")

	if heroList and not LuaUtil.tableContains(heroList, heroId) then
		return true
	end
end

function Season123ShowHeroModel:setPlayedHeroDieAnim(heroId)
	local key = self:getPlayHeroDieAnimPrefKey(self.stage)
	local value = PlayerPrefsHelper.getString(key, "")

	if string.nilorempty(value) then
		value = heroId
	else
		local heroList = string.split(value, "|")

		if heroList and not LuaUtil.tableContains(heroList, heroId) then
			value = value .. "|" .. heroId
		end
	end

	PlayerPrefsHelper.setString(key, value)
end

function Season123ShowHeroModel:clearPlayHeroDieAnim(stage)
	local key = self:getPlayHeroDieAnimPrefKey(stage)

	PlayerPrefsHelper.setString(key, "")
end

function Season123ShowHeroModel:getPlayHeroDieAnimPrefKey(stage)
	return "Season123ShowHeroModel_PlayHeroDieAnim_" .. stage
end

Season123ShowHeroModel.instance = Season123ShowHeroModel.New()

return Season123ShowHeroModel
