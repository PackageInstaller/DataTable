-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawandguess/view/DrawandguessmatchsuccesView.lua

module("logic.extensions.drawandguess.view.DrawandguessmatchsuccesView", package.seeall)

local DrawandguessmatchsuccesView = class("DrawandguessmatchsuccesView", ViewComponent)

function DrawandguessmatchsuccesView:ctor()
	DrawandguessmatchsuccesView.super.ctor(self)
end

function DrawandguessmatchsuccesView:unbindEvents()
	DrawandguessmatchsuccesView.super.unbindEvents(self)
end

function DrawandguessmatchsuccesView:bindEvents()
	DrawandguessmatchsuccesView.super.bindEvents(self)
end

function DrawandguessmatchsuccesView:buildUI()
	DrawandguessmatchsuccesView.super.buildUI(self)

	self._btnCancel = self:getBtn("btnCancel")
	self._effectGo = self:getGo("effect")
	self._tablecellGo = self:getGo("successcon/tablecell")
	self._successconGo = self:getGo("successcon")
	self._tableviewGo = self:getGo("successcon/tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DrawandguessmatchsuccesView:onExit()
	DrawandguessmatchsuccesView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._tickTime, self)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function DrawandguessmatchsuccesView:onEnter()
	DrawandguessmatchsuccesView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessDrawStartRes, self.close, self)
	self.addGEvent(self, GlobalNotify.NotifyDrawAndGuessGameStartRes, self._enterSelectQuestionView, self)
	self:_setEffect()

	self._activityId = self:getFirstParam()

	local msg = DrawandguessModel.instance:getGameStartMsg()

	self._scrollerList:reloadData(msg.players)
	settimer(2, self._tickTime, self, false)
end

function DrawandguessmatchsuccesView:_tickTime()
	removetimer(self._tickTime, self)
	self:_enterSelectQuestionView()
end

function DrawandguessmatchsuccesView:_enterSelectQuestionView()
	if DrawandguessModel.instance:isMeDraw() then
		UIStateManager.instance:push(ViewName.DrawandguessselectView, self._activityId)
	end

	self:close()
end

function DrawandguessmatchsuccesView:_setEffect()
	local effName = "20230428/honglianzhanchang/fx_ui_honglianzhanchang_pipeizhong.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

function DrawandguessmatchsuccesView:_updateCell(view, cell, player, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local goTag = goutil.findChild(cell.gameObject, "tag")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local outlineEx = goutil.findChild(cell.gameObject, "txtName"):GetComponent(ComponentType.OutlineEx)
	local isMe = checknumber(player.headInfo.userId) == checknumber(RoleModel.instance:getUserId())

	HeadItemController.instance:setHeadCellByInfo(goCon, player.headInfo)

	txtName.text = player.headInfo.userName

	goutil.setActive(goTag, isMe)

	if isMe then
		outlineEx:SetColorRGB(0.2, 0.6745098039215687, 0.4549019607843137)
	else
		outlineEx:SetColorRGB(0, 0, 0)
	end
end

function DrawandguessmatchsuccesView:_clearCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	HeadItemController.instance:resetHeadCell(goCon)
end

return DrawandguessmatchsuccesView
