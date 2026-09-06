-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/PreferentialGoto1View.lua

module("logic.extensions.bonus.view.PreferentialGoto1View", package.seeall)

local PreferentialGoto1View = class("PreferentialGoto1View", ViewComponent)

function PreferentialGoto1View:ctor()
	PreferentialGoto1View.super.ctor(self)

	self._redpointId = RedPointModel.ID_PREFERENTIAL_RECOMMEND_JUMP_WEEKLY_1
end

function PreferentialGoto1View:buildUI()
	PreferentialGoto1View.super.buildUI(self)

	self._btnGoto = self:getGo("btnGoto")
end

function PreferentialGoto1View:bindEvents()
	PreferentialGoto1View.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function PreferentialGoto1View:unbindEvents()
	PreferentialGoto1View.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGoto)
end

function PreferentialGoto1View:onEnter()
	PreferentialGoto1View.super.onEnter(self)
	BonusController.instance:setRDInfo(self._redpointId, BonusController.UserDataSaveType.Weekly)
end

function PreferentialGoto1View:_onClickGoto()
	local param = self:getFirstParam()

	if not string.nilorempty(param) then
		GotoMgr.gotoByString(param)
	else
		print("传参为空，检查福利界面的配置")
	end
end

return PreferentialGoto1View
