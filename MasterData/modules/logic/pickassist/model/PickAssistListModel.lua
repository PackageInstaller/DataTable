-- chunkname: @modules/logic/pickassist/model/PickAssistListModel.lua

module("modules.logic.pickassist.model.PickAssistListModel", package.seeall)

local PickAssistListModel = class("PickAssistListModel", ListScrollModel)
local DEFAULT_CAREER = CharacterEnum.CareerType.Yan
local ActId2PickAssistViewName = {}
local assistType2PickAssistViewName = {
	[PickAssistEnum.Type.Rouge] = "RougePickAssistView",
	[PickAssistEnum.Type.Survival] = "SurvivalPickAssistView",
	[PickAssistEnum.Type.TowerCompose1] = "TowerComposePickAssistView",
	[PickAssistEnum.Type.TowerCompose2] = "TowerComposePickAssistView",
	[PickAssistEnum.Type.Activity128General] = "PickAssistView",
	[PickAssistEnum.Type.BossRushActMode] = "V3a9_BossRush_AssistView"
}

local function createPickAssistHeroMO(dungeonAssistHeroMo)
	if not dungeonAssistHeroMo then
		return
	end

	local heroInfo = dungeonAssistHeroMo:getHeroInfo()
	local mo = PickAssistHeroMO.New()

	mo:init(heroInfo)

	return mo
end

function PickAssistListModel:onInit()
	self:clearData()
end

function PickAssistListModel:reInit()
	self:onInit()
end

function PickAssistListModel:clearData()
	self.activityId = nil
	self.career = nil
	self.selectMO = nil
end

function PickAssistListModel:onCloseView()
	self:clear()
	self:clearData()
end

function PickAssistListModel:init(actId, assistType, selectedHeroUid, notNeedCareer)
	self.activityId = actId
	self._assistType = assistType
	self._notNeedCareer = notNeedCareer

	if not self.career and not notNeedCareer then
		self:setCareer(DEFAULT_CAREER)
	end

	self:initSelectedMO(selectedHeroUid)
	self:updateDatas()
end

function PickAssistListModel:initSelectedMO(selectedHeroUid)
	self:setHeroSelect()

	local assistType = self:getAssistType()
	local dungeonAssistList = DungeonAssistModel.instance:getAssistList(assistType)

	if not dungeonAssistList then
		return
	end

	for _, dungeonAssistHeroMo in ipairs(dungeonAssistList) do
		local assistUid = dungeonAssistHeroMo:getHeroUid()

		if assistUid == selectedHeroUid then
			local mo = createPickAssistHeroMO(dungeonAssistHeroMo)

			self:setHeroSelect(mo, true)

			break
		end
	end
end

function PickAssistListModel:updateDatas()
	if not self.activityId or not self.career and not self._notNeedCareer then
		return
	end

	self:setListByCareer()
end

function PickAssistListModel:setListByCareer()
	local list = {}
	local lastSelectMO = self:getSelectedMO()

	self:setHeroSelect()

	local assistType = self:getAssistType()
	local dungeonAssistList = DungeonAssistModel.instance:getAssistList(assistType, self.career)

	if dungeonAssistList then
		for _, dungeonAssistHeroMo in ipairs(dungeonAssistList) do
			local mo = createPickAssistHeroMO(dungeonAssistHeroMo)

			if mo then
				local career = mo:getCareer()
				local isCareer = career == self.career or self._notNeedCareer

				if not isCareer then
					local careerList = FightConfig.instance:getCareerList(career)

					if careerList and LuaUtil.tableContains(careerList, self.career) then
						isCareer = true
					end
				end

				if isCareer then
					table.insert(list, mo)

					if lastSelectMO and lastSelectMO:isSameHero(mo) then
						self:setHeroSelect(mo, true)
					end
				end
			end
		end
	end

	self:setList(list)
	PickAssistController.instance:dispatchEvent(PickAssistEvent.SetCareer)
end

function PickAssistListModel:setListByCareerAndBattleTags()
	local list = {}
	local lastSelectMO = self:getSelectedMO()

	self:setHeroSelect()

	local assistType = self:getAssistType()
	local dungeonAssistList = DungeonAssistModel.instance:getAssistList(assistType, self.career)
	local selectTags = CharacterSearchFilterModel.instance:getSelectLocalTags()

	if dungeonAssistList then
		for _, dungeonAssistHeroMo in ipairs(dungeonAssistList) do
			local mo = createPickAssistHeroMO(dungeonAssistHeroMo)

			if mo then
				local career = mo:getCareer()
				local isCareer = career == self.career or self._notNeedCareer

				if not isCareer then
					local careerList = FightConfig.instance:getCareerList(career)

					if careerList and LuaUtil.tableContains(careerList, self.career) then
						isCareer = true
					end
				end

				if isCareer then
					local isFilterTag = selectTags and self:_isFilterTag(selectTags, mo)

					if isFilterTag then
						table.insert(list, mo)
					end

					if lastSelectMO and lastSelectMO:isSameHero(mo) then
						self:setHeroSelect(mo, true)
					end
				end
			end
		end
	end

	self:setList(list)
	PickAssistController.instance:dispatchEvent(PickAssistEvent.SetCareer)
end

function PickAssistListModel:_isFilterTag(selectTags, mo)
	if not mo or not mo.heroMO then
		return
	end

	local battleTag = mo.heroMO:getHeroBattleTag()

	return CharacterModel.instance:isFilterTagByBattleTags(selectTags, battleTag, mo.heroMO.heroId)
end

function PickAssistListModel:getPickAssistViewName()
	local result = ViewName.PickAssistView

	result = self.activityId and ActId2PickAssistViewName[self.activityId] or result
	result = self._assistType and assistType2PickAssistViewName[self._assistType] or result

	return result
end

function PickAssistListModel:getCareer()
	return self.career
end

function PickAssistListModel:getSelectedMO()
	return self.selectMO
end

function PickAssistListModel:isHeroSelected(assistMO)
	local selectMO = self:getSelectedMO()

	return (selectMO or nil) and selectMO:isSameHero(assistMO)
end

function PickAssistListModel:isHasAssistList()
	local assistList = self:getList()

	return (assistList or nil) and #assistList > 0
end

function PickAssistListModel:getAssistType()
	if not self._assistType then
		logError("PickAssistListModel:getAssistType error, not set assistType")
	end

	return self._assistType
end

function PickAssistListModel:setCareer(career)
	if self.career ~= career then
		self.career = career

		self:updateDatas()
	end
end

function PickAssistListModel:setHeroSelect(assistMO, value)
	self.selectMO = value and assistMO or nil

	PickAssistController.instance:dispatchEvent(PickAssistEvent.RefreshSelectAssistHero)
end

PickAssistListModel.instance = PickAssistListModel.New()

return PickAssistListModel
