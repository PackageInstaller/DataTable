-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/view/DivineSKLieXinClgBuffView.lua

module("logic.extensions.divineskliexinclg.view.DivineSKLieXinClgBuffView", package.seeall)

local DivineSKLieXinClgBuffView = class("DivineSKLieXinClgBuffView", ViewComponent)

function DivineSKLieXinClgBuffView:ctor()
	DivineSKLieXinClgBuffView.super.ctor(self)
end

function DivineSKLieXinClgBuffView:unbindEvents()
	DivineSKLieXinClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineSKLieXinClgBuffView:bindEvents()
	DivineSKLieXinClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineSKLieXinClgBuffView:buildUI()
	DivineSKLieXinClgBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tablecell = self:getGo("tablecell")
	self._tableview = self:getGo("tableview")
	self._tableList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineSKLieXinClgBuffView:onExit()
	DivineSKLieXinClgBuffView.super.onExit(self)
end

function DivineSKLieXinClgBuffView:onEnter()
	DivineSKLieXinClgBuffView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(self._activityId)
	local buffCfgs = DivineSKLieXinClgConfig.instance:getBuffCfgList(activityCfg.collectBuffPlanId)

	self._tableList:reloadData(buffCfgs)
end

function DivineSKLieXinClgBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtCollect = goutil.findChildTextComponent(go, "txtName")
	local txtBuff = goutil.findChildTextComponent(go, "txtDesc")

	txtCollect.text = data.collectDesc
	txtBuff.text = data.desc
end

function DivineSKLieXinClgBuffView:_clearCell(cell)
	return
end

return DivineSKLieXinClgBuffView
