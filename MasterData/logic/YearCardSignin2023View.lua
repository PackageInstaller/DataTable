-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2023/main/YearCardSignin2023View.lua

module("logic.extensions.yearcard.view.yearcard2023.main.YearCardSignin2023View", package.seeall)

local YearCardSignin2023View = class("YearCardSignin2023View", YearCardSignInView)

function YearCardSignin2023View:ctor()
	YearCardSignin2023View.super.ctor(self)

	self.skinId = 16010
end

function YearCardSignin2023View:buildUI()
	YearCardSignin2023View.super.buildUI(self)

	self._rare = self:getGo("petInfo/rare")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._txtName = self:getTxt("petInfo/txtName")
end

function YearCardSignin2023View:bindEvents()
	YearCardSignin2023View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function YearCardSignin2023View:unbindEvents()
	YearCardSignin2023View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
end

function YearCardSignin2023View:onEnter()
	YearCardSignin2023View.super.onEnter(self)
	MaterialMgr.setCell(MatType.Rare, self.skinId, self._rare)

	local skinCfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	self._txtName.text = skinCfg.name
end

function YearCardSignin2023View:onExit()
	YearCardSignin2023View.super.onExit(self)
	MaterialMgr.resetAll(self._rare)
end

function YearCardSignin2023View:_onClickInfo()
	PetbookController.instance:openPetinfoView(self.skinId)
end

function YearCardSignin2023View:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

return YearCardSignin2023View
