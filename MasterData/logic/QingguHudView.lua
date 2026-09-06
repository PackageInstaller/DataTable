-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/qingguhud/view/QingguHudView.lua

module("logic.extensions.qingguhud.view.QingguHudView", package.seeall)

local QingguHudView = class("QingguHudView", ActivityGrandSummaryView)

function QingguHudView:buildUI()
	QingguHudView.super.buildUI(self)

	self._btnStory = self:getBtn("btnStory")
	self._btnStoryRedPoint = self:getGo("btnStory/redpoint")
	self._txtStory = self:getTxt("btnStory/Text")
	self._con = self:getGo("con")
	self._btnPetInfo = self:getBtn("petInfo/btnSkill")
end

function QingguHudView:bindEvents()
	QingguHudView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnStory, self._onClickStory, self)
	GameUtil.addClickHandler(self._btnPetInfo, self._onClickPetInfo, self)
end

function QingguHudView:unbindEvents()
	QingguHudView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStory)
	GameUtil.rmClickHandler(self._btnPetInfo)
end

function QingguHudView:onEnter()
	QingguHudView.super.onEnter(self)
end

function QingguHudView:onExit()
	QingguHudView.super.onExit(self)

	if self._role then
		RoleObjectPool.instance:removeRole(v)
	end
end

function QingguHudView:_onClickStory()
	local cfg = QingguHudConfig.instance:getHudCfg(7)

	if cfg and not string.nilorempty(cfg.gotoFunc) then
		if cfg.reportBehavior > 0 then
			SurveyController.instance:reportBehavior(cfg.reportBehavior)
		end

		GotoMgr.gotoByString(cfg.gotoFunc)
	end
end

function QingguHudView:_onClickPetInfo()
	PetbookController.instance:previewBattle(13005)
end

function QingguHudView:onClickActivityCell(cell, data)
	QingguHudView.super.onClickActivityCell(self, cell, data)

	if data.id == 279 then
		RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_QINGGUHUD_ENTER_EXCHENGE, true)
	end
end

function QingguHudView:_getSumActivityId()
	return 17059
end

return QingguHudView
