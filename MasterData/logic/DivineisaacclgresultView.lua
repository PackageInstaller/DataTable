-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineisaacclg/view/DivineisaacclgresultView.lua

module("logic.extensions.divineisaacclg.view.DivineisaacclgresultView", package.seeall)

local DivineisaacclgresultView = class("DivineisaacclgresultView", ViewComponent)

function DivineisaacclgresultView:ctor()
	DivineisaacclgresultView.super.ctor(self)
end

function DivineisaacclgresultView:unbindEvents()
	DivineisaacclgresultView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineisaacclgresultView:bindEvents()
	DivineisaacclgresultView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DivineisaacclgresultView:buildUI()
	DivineisaacclgresultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._enemyAttrIconChange = self:getGo("enemyAttrIcon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._txtCondition = self:getTxt("metal/txtCondition")
	self._txtNum = self:getTxt("metal/txtNum")
	self._metalItemGo = self:getGo("metal/item")
	self._duiGo = self:getGo("metal/dui")
	self._cuoGo = self:getGo("metal/cuo")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineisaacclgresultView:onExit()
	DivineisaacclgresultView.super.onExit(self)
	self._scrollerList:dispose()
	MaterialMgr.resetAll(self._metalItemGo)
end

function DivineisaacclgresultView:onEnter()
	DivineisaacclgresultView.super.onEnter(self)

	self._finishMsg = self:getFirstParam()
	self._stageCfg = DivineisaacclgConfig.instance:getStageCfg(self._finishMsg.activityId, self._finishMsg.phaseId, self._finishMsg.stageId)

	self:_updateUI()
end

function DivineisaacclgresultView:_onClickbtnClose()
	BattleFacade.instance:endBattle()
end

function DivineisaacclgresultView:_updateUI()
	self._enemyAttrIconChange:SetState(GameEnum.Races[self._stageCfg.enemyAttr] - 1)

	self._txtNum.text = self._finishMsg.metalNum

	local metalCfg = DivineisaacclgConfig.instance:getMetalResCfg(self._stageCfg.metalId)

	MaterialMgr.setCellByCfg(metalCfg.clientMatStr, self._metalItemGo)

	local isPass = self._finishMsg.metalNum >= self._stageCfg.needMetalNum
	local isWin = self._finishMsg.isWin

	self._txtCondition.text = string.format("x%s（<color=%s>%s</color>/%s）", self._stageCfg.needMetalNum, isPass and "green" or "red", self._finishMsg.metalNum, self._stageCfg.needMetalNum)

	goutil.setActive(self._duiGo, isPass and isWin)
	goutil.setActive(self._cuoGo, not isPass or not isWin)
	self._scrollerList:reloadData(self._finishMsg.buffIdAndNum)
end

function DivineisaacclgresultView:_updateCell(view, cell, data, tag)
	local imgChangeIcon = goutil.findChild(cell.gameObject, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local buff2attrCfg = DivineisaacclgConfig.instance:buff2AttrCfg(data.left)

	txtNum.text = data.right

	imgChangeIcon:SetState(GameEnum.Races[buff2attrCfg.attr] - 1)
end

function DivineisaacclgresultView:_clearCell(cell)
	return
end

return DivineisaacclgresultView
