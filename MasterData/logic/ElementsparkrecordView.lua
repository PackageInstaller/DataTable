-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkrecordView.lua

module("logic.extensions.elementspark.view.ElementsparkrecordView", package.seeall)

local ElementsparkrecordView = class("ElementsparkrecordView", ViewComponent)

function ElementsparkrecordView:ctor()
	ElementsparkrecordView.super.ctor(self)
end

function ElementsparkrecordView:unbindEvents()
	ElementsparkrecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function ElementsparkrecordView:bindEvents()
	ElementsparkrecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function ElementsparkrecordView:buildUI()
	ElementsparkrecordView.super.buildUI(self)

	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._noReportGo = self:getGo("noReport")
	self._btnClose = self:getBtn("btnClose")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ElementsparkrecordView:onExit()
	ElementsparkrecordView.super.onExit(self)
	self._scrollerList:dispose()
end

function ElementsparkrecordView:onEnter()
	ElementsparkrecordView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.ElementSparkGetGuardRecordInfo, self._onElementSparkGetGuardRecordInfo, self)

	self._chunkId = self:getFirstParam()
	self._activityId = ElementSparkController.instance:getActivityId()

	self:_updateDefautlUI()
	ElementSparkController.instance:sendPM_EleSparkGetGuardRecordReq(self._activityId, self._chunkId)
end

function ElementsparkrecordView:_updateDefautlUI()
	self._scrollerList:reloadData(nil)
	goutil.setActive(self._noReportGo, true)
end

function ElementsparkrecordView:_onElementSparkGetGuardRecordInfo(guardRecords)
	self._scrollerList:reloadData(guardRecords)
	goutil.setActive(self._noReportGo, not guardRecords or #guardRecords <= 0)
end

function ElementsparkrecordView:_updateCell(view, cell, data, tag)
	local goLeft = goutil.findChild(cell.gameObject, "left")
	local goRight = goutil.findChild(cell.gameObject, "right")
	local nodeLeft = self:_getNode(goLeft)
	local nodeRight = self:_getNode(goRight)

	HeadItemController.instance:setHeadCellByInfo(nodeLeft.goHead, data.defender)
	HeadItemController.instance:setHeadCellByInfo(nodeRight.goHead, data.attacker)

	local defenderCampName = ElementSparkController.instance:getCampNameById(data.defenderCampId)
	local attackerCampName = ElementSparkController.instance:getCampNameById(data.attackerCampId)

	nodeLeft.txtPower.text = data.defenderZdl
	nodeRight.txtPower.text = data.attackerZdl
	nodeLeft.txtCamp.text = defenderCampName .. "阵营"
	nodeRight.txtCamp.text = attackerCampName .. "阵营"
	nodeLeft.txtName.text = data.defender.userName
	nodeRight.txtName.text = data.attacker.userName
	nodeLeft.txtWin.text = data.attackSuc and "败" or "胜"
	nodeRight.txtWin.text = data.attackSuc and "胜" or "败"

	nodeLeft.winChange:SetState(data.attackSuc and 1 or 0)
	nodeRight.winChange:SetState(data.attackSuc and 0 or 1)
end

function ElementsparkrecordView:_getNode(root)
	local var_10_0 = {
		goHead = goutil.findChild(root, "head"),
		txtName = goutil.findChildTextComponent(root, "txtName"),
		txtCamp = goutil.findChildTextComponent(root, "txtCamp"),
		txtPower = goutil.findChildTextComponent(root, "txtPower")
	}

	var_10_0.winChange = goutil.findChild(root, "win"):GetComponent("UIImageSpriteChange")
	var_10_0.txtWin = goutil.findChildTextComponent(root, "win/txtWin")

	return var_10_0
end

function ElementsparkrecordView:_clearCell(cell)
	return
end

return ElementsparkrecordView
