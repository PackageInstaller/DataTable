-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardPerWeek2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardPerWeek2023View", package.seeall)

local YearCardPerWeek2023View = class("YearCardPerWeek2023View", YearCardPerWeek2022View)

function YearCardPerWeek2023View:ctor()
	YearCardPerWeek2023View.super.ctor(self)

	self._curPrizeNum = 7
end

function YearCardPerWeek2023View:buildUI()
	YearCardPerWeek2023View.super.buildUI(self)

	self.skinId = 16010
	self._rare = self:getGo("petInfo/rare")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
end

function YearCardPerWeek2023View:bindEvents()
	YearCardPerWeek2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function YearCardPerWeek2023View:unbindEvents()
	YearCardPerWeek2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function YearCardPerWeek2023View:onEnter()
	YearCardPerWeek2023View.super.onEnter(self)
	MaterialMgr.setCell(MatType.Rare, self.skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	self._txtName.text = skinCfg.name
end

function YearCardPerWeek2023View:onExit()
	YearCardPerWeek2023View.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
end

function YearCardPerWeek2023View:_onClickInfo()
	PetbookController.instance:openPetinfoView(self.skinId)
end

function YearCardPerWeek2023View:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

return YearCardPerWeek2023View
