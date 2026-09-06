-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineempress/view/DivineEmpressExtreCardView.lua

module("logic.extensions.divineempress.view.DivineEmpressExtreCardView", package.seeall)

local DivineEmpressExtreCardView = class("DivineEmpressExtreCardView", ViewComponent)

function DivineEmpressExtreCardView:ctor()
	DivineEmpressExtreCardView.super.ctor(self)
end

function DivineEmpressExtreCardView:unbindEvents()
	DivineEmpressExtreCardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnDebuff)
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivineEmpressExtreCardView:bindEvents()
	DivineEmpressExtreCardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnDebuff, self._onClickDebuff, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function DivineEmpressExtreCardView:buildUI()
	DivineEmpressExtreCardView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnDebuff = self:getGo("btnDebuff")
	self._changeDebuff = self._btnDebuff:GetComponent(ComponentType.UIChangeGroup)
	self._btnBuff = self:getGo("btnBuff")
	self._changeBuff = self._btnBuff:GetComponent(ComponentType.UIChangeGroup)
	self._buffTableCell = self:getGo("buffTableCell")
	self._buffTableView = self:getGo("buffTableView")
	self._buffTableList = ScrollerList.create(self._buffTableView, self._buffTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineEmpressExtreCardView:onExit()
	DivineEmpressExtreCardView.super.onExit(self)
end

function DivineEmpressExtreCardView:onEnter()
	DivineEmpressExtreCardView.super.onEnter(self)

	self._activityId = self:getFirstParam()
	self._isBuff = true

	self:_refreshView()
end

function DivineEmpressExtreCardView:_refreshView()
	local buffCfgs

	if self._isBuff == true then
		buffCfgs = DivineEmpressConfig.instance:getBuffCfgs(self._activityId)

		self._changeBuff:SetState(0)
		self._changeDebuff:SetState(1)
	else
		buffCfgs = DivineEmpressConfig.instance:getDebuffCfgs(self._activityId)

		self._changeBuff:SetState(1)
		self._changeDebuff:SetState(0)
	end

	self._buffTableList:reloadData(buffCfgs)
end

function DivineEmpressExtreCardView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtBuffScore = goutil.findChildTextComponent(go, "txtBuffNumber")
	local txtDebuffScore = goutil.findChildTextComponent(go, "txtDebuffNumber")
	local txDesc = goutil.findChildTextComponent(go, "txtDesc")
	local useTag = goutil.findChild(go, "useTag")
	local txtUseTag = goutil.findChildTextComponent(go, "useTag/txt")
	local imgChangeCard = goutil.findChildComponent(go, "imgCard", ComponentType.UIImageSpriteChange)
	local useByStageId = 0

	if self._isBuff == true then
		imgChangeCard:SetState(0)

		useByStageId = DivineEmpressModel.instance:getBuffUseBy(self._activityId, data.buffId)
	else
		imgChangeCard:SetState(1)

		useByStageId = DivineEmpressModel.instance:getDebuffUseBy(self._activityId, data.buffId)
	end

	GameUtil.SetActive(useTag, useByStageId ~= 0)
	GameUtil.SetActive(txtBuffScore, self._isBuff == true)
	GameUtil.SetActive(txtDebuffScore, not self._isBuff)

	txtDebuffScore.text = data.buffScore
	txtBuffScore.text = data.buffScore
	txDesc.text = data.desc

	if useByStageId ~= 0 then
		local extremeCfg = DivineEmpressConfig.instance:getExtraStageCfg(self._activityId, useByStageId)

		txtUseTag.text = langPara("%s已使用", extremeCfg.name)
	end
end

function DivineEmpressExtreCardView:_clearCell(cell)
	return
end

function DivineEmpressExtreCardView:_onClickBuff()
	self._isBuff = true

	self:_refreshView()
end

function DivineEmpressExtreCardView:_onClickDebuff()
	self._isBuff = false

	self:_refreshView()
end

return DivineEmpressExtreCardView
