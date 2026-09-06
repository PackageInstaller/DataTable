-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgResultView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgResultView", package.seeall)

local NuoYaSisterClgResultView = class("NuoYaSisterClgResultView", ViewComponent)

function NuoYaSisterClgResultView:ctor()
	NuoYaSisterClgResultView.super.ctor(self)
end

function NuoYaSisterClgResultView:unbindEvents()
	NuoYaSisterClgResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
end

function NuoYaSisterClgResultView:bindEvents()
	NuoYaSisterClgResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
end

function NuoYaSisterClgResultView:buildUI()
	NuoYaSisterClgResultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._tabelList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tabelList:setCenterMode(true)
end

function NuoYaSisterClgResultView:onExit()
	NuoYaSisterClgResultView.super.onExit(self)
end

function NuoYaSisterClgResultView:onEnter()
	NuoYaSisterClgResultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])
	self._typeId = checknumber(params[3])
	self._hpInfo = params[4]

	self._tabelList:reloadData(self._hpInfo)
	self.addGEvent(self, GlobalNotify.PM_NotifyNuoYaSisterExtremeClgFinishRes, self._handleNotifyNuoYaSisterExtremeClgFinishRes, self)
end

function NuoYaSisterClgResultView:_handleNotifyNuoYaSisterExtremeClgFinishRes(status)
	if status == 0 then
		local activityId = self._activityId
		local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(activityId)

		if isAoqiGodProcessType then
			local activityType = NuoYaSisterClgController.instance:getActivityType()

			AoqiGodController.instance:doHandleChallengeFinishReady(activityType, activityId)
		end
	end

	self:close()
	BattleController.instance:endBattle()
end

function NuoYaSisterClgResultView:_refreshView()
	self._tabelList:reloadData(self._hpInfo)
end

function NuoYaSisterClgResultView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txt = goutil.findChildTextComponent(go, "txt")
	local txtColorChange = goutil.findChildComponent(go, "txt", "UITextColorChange")
	local petId = data.id
	local rate = data.hpRate * 100
	local proxy = MaterialMgr.setCellByGId(MatType.Pet, petId, con)

	if proxy then
		proxy.binder:setClickCallBack(function()
			CommonTipsMgr.instance:openMaterialTips(con, MatType.Pet, petId)
		end)
	end

	if rate > 0 then
		txtColorChange:SetState(0)
	else
		txtColorChange:SetState(1)
	end

	txt.text = langPara("%d", math.ceil(checknumber(rate))) .. "%"
end

function NuoYaSisterClgResultView:_clearCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function NuoYaSisterClgResultView:_onClickSure()
	NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterExtremeClgResultConfirmReq(self._activityId, self._stageId, self._typeId, true)
end

function NuoYaSisterClgResultView:_onClickCancel(...)
	NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterExtremeClgResultConfirmReq(self._activityId, self._stageId, self._typeId, false)
end

return NuoYaSisterClgResultView
