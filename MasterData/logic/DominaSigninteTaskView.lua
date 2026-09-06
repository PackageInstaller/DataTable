-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominaSigninteTaskView.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominaSigninteTaskView", package.seeall)

local DominaSigninteTaskView = class("DominaSigninteTaskView", ViewComponent)

function DominaSigninteTaskView:ctor()
	DominaSigninteTaskView.super.ctor(self)
end

function DominaSigninteTaskView:unbindEvents()
	DominaSigninteTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function DominaSigninteTaskView:bindEvents()
	DominaSigninteTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		self:close()
	end)
end

function DominaSigninteTaskView:buildUI()
	DominaSigninteTaskView.super.buildUI(self)

	self._tabCell = self:getGo("cell")
	self._tableView = self:getGo("tableview")
	self._closeBtn = self:getBtn("btnClose")
	self._tabList = ScrollerList.create(self._tableView, self._tabCell, GameUtil.handler(self._updateItem, self), GameUtil.handler(self._clearItemCell, self))
end

function DominaSigninteTaskView:onEnter()
	DominaSigninteTaskView.super.onEnter(self)

	self._challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()

	self:_updateTabList()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeLoginTaskRes, self._refreshTabList, self)
end

function DominaSigninteTaskView:onExit()
	DominaSigninteTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.KDChallengeLoginTaskRes, self._refreshTabList, self)
end

function DominaSigninteTaskView:_updateItem(view, cell, data)
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local icon = goutil.findChild(cell, "icon")
	local pass = goutil.findChild(cell, "pass")
	local noPass = goutil.findChild(cell, "noPass")
	local btnGet = goutil.findChild(cell, "btnGet")

	txtName.text = data.name
	txtDesc.text = data.desc

	goutil.setActive(pass, data.state == 3)
	goutil.setActive(btnGet, data.state == 1)
	goutil.setActive(noPass, data.state == 2)
	MaterialMgr.resetAll(icon)
	MaterialMgr.setCellByCfg(data.prize, icon)
	GameUtil.asBtn(btnGet):RemoveClickListener()
	GameUtil.asBtn(btnGet):AddClickListener(function()
		KdChallengeController.instance:sendPM_TQKingDragonGetLoginTaskPrizeReq(self._challengeId, data.days)
	end)
end

function DominaSigninteTaskView:_clearItemCell(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnGet = goutil.findChild(cell, "btnGet")

	MaterialMgr.resetAll(icon)
	GameUtil.asBtn(btnGet):RemoveClickListener()
end

function DominaSigninteTaskView:_updateTabList()
	local taskList = KdChallengeModel.instance:getLoginTaskList()

	self._tabList:reloadData(taskList)
end

function DominaSigninteTaskView:_refreshTabList()
	local taskList = KdChallengeModel.instance:getLoginTaskList()

	self._tabList:refresh(taskList)
end

return DominaSigninteTaskView
