-- chunkname: @modules/logic/seasonver/act123/model/Season123PickAssistListModel.lua

module("modules.logic.seasonver.act123.model.Season123PickAssistListModel", package.seeall)

local Season123PickAssistListModel = class("Season123PickAssistListModel", ListScrollModel)
local DEFAULT_CAREER = CharacterEnum.CareerType.Yan

function Season123PickAssistListModel:onInit()
	self:setCareer()
end

function Season123PickAssistListModel:reInit()
	self:setCareer()
end

function Season123PickAssistListModel:release()
	self:clear()

	self.activityId = nil

	self:setHeroSelect()
end

function Season123PickAssistListModel:init(actId, selectedHeroUid)
	self.activityId = actId

	if not self.career then
		self:setCareer(DEFAULT_CAREER)
	end

	self:initSelectedMO(selectedHeroUid)
	self:updateDatas()
end

function Season123PickAssistListModel:initSelectedMO(selectedHeroUid)
	self:setHeroSelect()

	local dungeonAssistList = DungeonAssistModel.instance:getAssistList(DungeonEnum.AssistType.Season123)

	if dungeonAssistList then
		for _, dungeonAssistHeroMo in ipairs(dungeonAssistList) do
			local assistUid = dungeonAssistHeroMo:getHeroUid()

			if assistUid == selectedHeroUid then
				local mo = Season123HeroUtils.createSeasonPickAssistMO(dungeonAssistHeroMo)

				self:setHeroSelect(mo, true)
			end
		end
	end
end

function Season123PickAssistListModel:updateDatas()
	if not self.activityId or not self.career then
		return
	end

	self:setListByCareer()
end

function Season123PickAssistListModel:setListByCareer()
	local list = {}
	local lastSelectMO = self:getSelectedMO()

	self:setHeroSelect()

	local dungeonAssistList = DungeonAssistModel.instance:getAssistList(DungeonEnum.AssistType.Season123, self.career)

	if dungeonAssistList then
		for _, dungeonAssistHeroMo in ipairs(dungeonAssistList) do
			local mo = Season123HeroUtils.createSeasonPickAssistMO(dungeonAssistHeroMo)

			if mo and mo.heroMO and mo.heroMO.config and mo.heroMO.config.career == self.career then
				table.insert(list, mo)

				if lastSelectMO and lastSelectMO:isSameHero(mo) then
					self:setHeroSelect(mo, true)
				end
			end
		end
	end

	self:setList(list)
	Season123Controller.instance:dispatchEvent(Season123Event.SetCareer)
end

function Season123PickAssistListModel:getCareer()
	return self.career
end

function Season123PickAssistListModel:getSelectedMO()
	return self.selectMO
end

function Season123PickAssistListModel:isHeroSelected(assistMO)
	local selectMO = self:getSelectedMO()

	return (selectMO or nil) and selectMO:isSameHero(assistMO)
end

function Season123PickAssistListModel:isHasAssistList()
	local assistList = self:getList()

	return (assistList or nil) and #assistList > 0
end

function Season123PickAssistListModel:setCareer(career)
	if self.career ~= career then
		self.career = career

		self:updateDatas()
	end
end

function Season123PickAssistListModel:setHeroSelect(assistMO, value)
	self.selectMO = value and assistMO or nil

	Season123Controller.instance:dispatchEvent(Season123Event.RefreshSelectAssistHero)
end

Season123PickAssistListModel.instance = Season123PickAssistListModel.New()

return Season123PickAssistListModel
