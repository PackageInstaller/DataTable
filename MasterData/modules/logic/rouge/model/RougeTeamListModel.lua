-- chunkname: @modules/logic/rouge/model/RougeTeamListModel.lua

module("modules.logic.rouge.model.RougeTeamListModel", package.seeall)

local RougeTeamListModel = class("RougeTeamListModel", ListScrollModel)

function RougeTeamListModel:getHp(mo)
	local id = mo.heroId
	local hpInfo = self._heroLifeMap[id]

	return (hpInfo or nil) and (hpInfo.life or 0)
end

function RougeTeamListModel:isInTeam(mo)
	return self._teamInfo:inTeam(mo.heroId)
end

function RougeTeamListModel:isAssit(mo)
	return self._teamInfo:inTeamAssist(mo.heroId)
end

function RougeTeamListModel:getTeamType()
	return self._teamType
end

function RougeTeamListModel:getSelectedHeroMap()
	return self._selectedHeroMap
end

function RougeTeamListModel:getSelectedHeroList()
	local list = {}

	for k, v in pairs(self._selectedHeroMap) do
		table.insert(list, k)
	end

	table.sort(list, function(a, b)
		return self._selectedHeroMap[a] < self._selectedHeroMap[b]
	end)

	for i, v in ipairs(list) do
		list[i] = v.heroId
	end

	return list
end

function RougeTeamListModel:isHeroSelected(mo)
	return self._selectedHeroMap[mo] ~= nil
end

function RougeTeamListModel:selectHero(mo)
	if self._selectedHeroMap[mo] then
		self._selectedHeroMap[mo] = nil

		return
	end

	if tabletool.len(self._selectedHeroMap) >= self._heroNum then
		GameFacade.showToast(ToastEnum.RougeTeamSelectedFull)

		return
	end

	self._selectedHeroMap[mo] = UnityEngine.Time.frameCount
end

function RougeTeamListModel:initList(teamType, heroNum)
	local teamInfo = RougeModel.instance:getTeamInfo()
	local heroLifeList = teamInfo.heroLifeList

	self._heroLifeMap = teamInfo.heroLifeMap
	self._teamInfo = teamInfo
	self._teamType = teamType
	self._heroNum = heroNum
	self._selectedHeroMap = {}

	local list = {}

	if teamType == RougeEnum.TeamType.View then
		self:_getViewList(heroLifeList, list)
	elseif teamType == RougeEnum.TeamType.Treat then
		self:_getTreatList(heroLifeList, list)
	elseif teamType == RougeEnum.TeamType.Revive then
		self:_getReviveList(heroLifeList, list)
	elseif teamType == RougeEnum.TeamType.Assignment then
		self:_getAssignmentList(heroLifeList, list)
	end

	self:setList(list)
end

function RougeTeamListModel:_getViewList(heroLifeList, list)
	for i = #heroLifeList, 1, -1 do
		local v = heroLifeList[i]
		local heroMo = self:getByHeroId(v.heroId)

		if v.life > 0 then
			table.insert(list, 1, heroMo)
		else
			table.insert(list, heroMo)
		end
	end
end

function RougeTeamListModel:_getTreatList(heroLifeList, list)
	for i, v in ipairs(heroLifeList) do
		if v.life > 0 then
			local heroMo = self:getByHeroId(v.heroId)

			table.insert(list, heroMo)
		end
	end
end

function RougeTeamListModel:_getReviveList(heroLifeList, list)
	for i, v in ipairs(heroLifeList) do
		if v.life <= 0 then
			local heroMo = self:getByHeroId(v.heroId)

			table.insert(list, heroMo)
		end
	end
end

function RougeTeamListModel:_getAssignmentList(heroLifeList, list)
	for i, v in ipairs(heroLifeList) do
		if v.life > 0 then
			local heroMo = self:getByHeroId(v.heroId)

			table.insert(list, heroMo)
		end
	end
end

function RougeTeamListModel:getByHeroId(heroId)
	return HeroModel.instance:getByHeroId(heroId)
end

function RougeTeamListModel.addAssistHook()
	HeroModel.instance:addHookGetHeroId(RougeTeamListModel.addHookGetHeroId)
	HeroModel.instance:addHookGetHeroUid(RougeTeamListModel.addHookGetHeroUid)
end

function RougeTeamListModel.removeAssistHook()
	HeroModel.instance:removeHookGetHeroId(RougeTeamListModel.addHookGetHeroId)
	HeroModel.instance:removeHookGetHeroUid(RougeTeamListModel.addHookGetHeroUid)
end

function RougeTeamListModel.addHookGetHeroId(heroId)
	local teamInfo = RougeModel.instance:getTeamInfo()

	return (teamInfo:getAssistHeroMo(heroId))
end

function RougeTeamListModel.addHookGetHeroUid(uid)
	local teamInfo = RougeModel.instance:getTeamInfo()

	return (teamInfo:getAssistHeroMoByUid(uid))
end

RougeTeamListModel.instance = RougeTeamListModel.New()

return RougeTeamListModel
