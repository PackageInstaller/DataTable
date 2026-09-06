-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/view/RunechangeapplyView.lua

module("logic.extensions.rune.view.RunechangeapplyView", package.seeall)

local RunechangeapplyView = class("RunechangeapplyView", ViewComponent)

function RunechangeapplyView:ctor()
	RunechangeapplyView.super.ctor(self)
end

function RunechangeapplyView:buildUI()
	RunechangeapplyView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnCancel = self:getGo("btnCancel")
	self.btnSure = self:getGo("btnSure")
	self.txtTip = self:getTxt("txtTip")
	self.Gird = self:getGo("Gird")
	self.cell = self:getGo("cell")
	self.tableView = ScrollerList.create(self.Gird, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function RunechangeapplyView:bindEvents()
	RunechangeapplyView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnCancel, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self.onOkClick, self)
end

function RunechangeapplyView:unbindEvents()
	RunechangeapplyView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnCancel)
	GameUtil.rmClickHandler(self.btnSure)
end

function RunechangeapplyView:destroyUI()
	RunechangeapplyView.super.destroyUI(self)
end

function RunechangeapplyView:onEnter()
	RunechangeapplyView.super.onEnter(self)

	local param = self:getOpenParam()
	local suitId = checknumber(param[1])
	local list = param[2]

	self.callBack = param[3]

	self.tableView:reloadData(list)

	local cfg = MaterialMgr.getMatCfg(MatType.Rune_Suit, suitId)

	self.txtTip.text = langPara("是否确定将如下精灵修改为应用 <color=#1177CEFF><size=28>%s</size></color> ？", cfg.name)
end

function RunechangeapplyView:onEnterFinished()
	RunechangeapplyView.super.onEnterFinished(self)
end

function RunechangeapplyView:onExit()
	RunechangeapplyView.super.onExit(self)
	self.tableView:dispose()
end

function RunechangeapplyView:onExitFinished()
	RunechangeapplyView.super.onExitFinished(self)
end

function RunechangeapplyView:onOkClick()
	GameUtil.callBack(self.callBack)
	self:close()
end

function RunechangeapplyView:_updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.setCellByGId(MatType.Pet, data, con)
end

function RunechangeapplyView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

return RunechangeapplyView
