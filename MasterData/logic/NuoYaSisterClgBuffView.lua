-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgBuffView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgBuffView", package.seeall)

local NuoYaSisterClgBuffView = class("NuoYaSisterClgBuffView", ViewComponent)

function NuoYaSisterClgBuffView:ctor()
	NuoYaSisterClgBuffView.super.ctor(self)
end

function NuoYaSisterClgBuffView:unbindEvents()
	NuoYaSisterClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NuoYaSisterClgBuffView:bindEvents()
	NuoYaSisterClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NuoYaSisterClgBuffView:buildUI()
	NuoYaSisterClgBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tableview_left = self:getGo("tableview_left")
	self._tableview_right = self:getGo("tableview_right")
	self._tablecell = self:getGo("tablecell")
	self._tableLeftList = ScrollerList.create(self._tableview_left, self._tablecell, GameUtil.handler(self._updateLeftCell, self), GameUtil.handler(self._clearCell, self))
	self._tableRightList = ScrollerList.create(self._tableview_right, self._tablecell, GameUtil.handler(self._updateRightCell, self), GameUtil.handler(self._clearCell, self))
end

function NuoYaSisterClgBuffView:onExit()
	NuoYaSisterClgBuffView.super.onExit(self)
end

function NuoYaSisterClgBuffView:onEnter()
	NuoYaSisterClgBuffView.super.onEnter(self)

	self._activityId = self:getFirstParam()

	local leftTeamInfo = NuoYaSisterClgModel.instance:getTeamInfo(self._activityId, 1)
	local rightTeamInfo = NuoYaSisterClgModel.instance:getTeamInfo(self._activityId, 2)

	self._leftActiveBuff = leftTeamInfo.stageNum or 0
	self._rightActiveBuff = rightTeamInfo.stageNum or 0

	local leftBuffCfgs = NuoYaSisterClgConfig.instance:getBuffCfg(self._activityId, 1)

	if #leftBuffCfgs < self._leftActiveBuff then
		self._leftActiveBuff = #leftBuffCfgs
	end

	local rightBuffCfgs = NuoYaSisterClgConfig.instance:getBuffCfg(self._activityId, 2)

	if #rightBuffCfgs < self._rightActiveBuff then
		self._rightActiveBuff = #rightBuffCfgs
	end

	self._tableLeftList:reloadData(leftBuffCfgs)
	self._tableRightList:reloadData(rightBuffCfgs)
end

function NuoYaSisterClgBuffView:_updateLeftCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local activeBuffGo = goutil.findChild(go, "activeBuff")

	txtLevel.text = data.number
	txtDesc.text = data.buffDesc

	GameUtil.SetActive(activeBuffGo, data.number == self._leftActiveBuff)
end

function NuoYaSisterClgBuffView:_updateRightCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local activeBuffGo = goutil.findChild(go, "activeBuff")

	txtLevel.text = data.number
	txtDesc.text = data.buffDesc

	GameUtil.SetActive(activeBuffGo, data.number == self._rightActiveBuff)
end

function NuoYaSisterClgBuffView:_clearCell(cell)
	return
end

return NuoYaSisterClgBuffView
