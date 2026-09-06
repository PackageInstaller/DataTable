-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgbuffdescView.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgbuffdescView", package.seeall)

local DivineisaacclgbuffdescView = class("DivineisaacclgbuffdescView", ViewComponent)

function DivineisaacclgbuffdescView:ctor()
	DivineisaacclgbuffdescView.super.ctor(self)
end

function DivineisaacclgbuffdescView:unbindEvents()
	DivineisaacclgbuffdescView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineisaacclgbuffdescView:bindEvents()
	DivineisaacclgbuffdescView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DivineisaacclgbuffdescView:buildUI()
	DivineisaacclgbuffdescView.super.buildUI(self)

	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineisaacclgbuffdescView:onExit()
	DivineisaacclgbuffdescView.super.onExit(self)
	self._scrollerList:dispose()
end

function DivineisaacclgbuffdescView:onEnter()
	DivineisaacclgbuffdescView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]
	self._phaseId = params[2]
	self._puppetNumCfgs = DivineisaacclgConfig.instance:getPuppetNumCfgs(self._activityId, self._phaseId)

	self._scrollerList:reloadData(self._puppetNumCfgs)
end

function DivineisaacclgbuffdescView:_onClickbtnClose()
	self:close()
end

function DivineisaacclgbuffdescView:_updateCell(view, cell, data, tag)
	local bgGo = goutil.findChild(cell.gameObject, "bg")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")

	goutil.setActive(bgGo, cell.data % 2 == 0)

	txtNum.text = data.puppetNum
	txtDesc.text = data.buffDesc
end

function DivineisaacclgbuffdescView:_clearCell(cell)
	return
end

return DivineisaacclgbuffdescView
