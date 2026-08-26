-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateChessItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessItem", package.seeall)

local EliminateChessItem = class("EliminateChessItem", LuaCompBase)
local tweenHelper = ZProj.TweenHelper
local UIDragListener = SLFramework.UGUI.UIDragListener

function EliminateChessItem:init(go)
	self._go = go
	self._tr = go.transform
	self._select = false
	self._ani = go:GetComponent(typeof(UnityEngine.Animator))

	if self._ani then
		self._ani.enabled = true
	end

	self._img_select = gohelper.findChild(self._go, "#img_select")
	self._img_chess = gohelper.findChildImage(self._go, "#img_sprite")
	self._btnClick = gohelper.findChildButtonWithAudio(self._go, "#btn_click")

	self._btnClick:AddClickListener(self.onClick, self)

	self._drag = UIDragListenerHelper.New()
	self._drag = UIDragListener.Get(self._btnClick.gameObject)

	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
end

function EliminateChessItem:initData(data)
	self._data = data

	self:updateInfo()
end

function EliminateChessItem:getData()
	return self._data
end

function EliminateChessItem:updateInfo()
	if self._data then
		local name = EliminateConfig.instance:getChessIconPath(self._data.id)
		local isActive = not string.nilorempty(name)

		recthelper.setSize(self._tr, EliminateEnum.ChessWidth, EliminateEnum.ChessHeight)

		if isActive then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(self._img_chess, name, false)
		end

		gohelper.setActiveCanvasGroup(self._go, isActive)
		self:updatePos()
	end
end

function EliminateChessItem:updatePos()
	if self._data then
		local x = (self._data.startX - 1) * EliminateEnum.ChessWidth
		local y = (self._data.startY - 1) * EliminateEnum.ChessHeight

		transformhelper.setLocalPosXY(self._tr, x, y)
	end
end

function EliminateChessItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_switch)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, self._data.x, self._data.y, true)
end

function EliminateChessItem:_onDragBegin(_, eventData)
	self._beginDragX = eventData.position.x
	self._beginDragY = eventData.position.y

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, self._data.x, self._data.y, false)
end

local function calculateAngle(x1, y1, x2, y2)
	local deltaX = x2 - x1
	local deltaY = y2 - y1

	return math.deg(math.atan2(deltaY, deltaX))
end

function EliminateChessItem:getEndXYByAngle(angle, threshold)
	local x = self._data.x
	local y = self._data.y

	if threshold >= math.abs(angle) then
		return x + 1, y
	elseif threshold >= math.abs(angle - 180) or threshold >= math.abs(angle + 180) then
		return x - 1, y
	elseif math.abs(angle - 90) <= 90 - threshold then
		return x, y + 1
	elseif math.abs(angle + 90) <= 90 - threshold then
		return x, y - 1
	end

	return x, y
end

function EliminateChessItem:_onDragEnd(_, eventData)
	local endX = eventData.position.x
	local endY = eventData.position.y
	local angle = calculateAngle(self._beginDragX, self._beginDragY, endX, endY)
	local x, y = self:getEndXYByAngle(angle, EliminateEnum.ChessDropAngleThreshold)

	if EliminateChessModel.instance:posIsValid(x, y) then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, x, y, false)
	end
end

function EliminateChessItem:setSelect(isSelect)
	self._select = isSelect

	gohelper.setActiveCanvasGroup(self._img_select, self._select)
end

function EliminateChessItem:toTip(active)
	if not active then
		self:playAnimation("idle")
	else
		self:playAnimation("hint")
	end
end

function EliminateChessItem:getGoPos()
	self._chessPosX, self._chessPosY = transformhelper.getPos(self._img_chess.transform)

	return self._chessPosX, self._chessPosY
end

function EliminateChessItem:toDie(time, source)
	if source == 1 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sufubi_skill)
		self:playAnimation("skill_sufubi")
	else
		self:playAnimation("disappear")
	end

	self:getGoPos()
	TaskDispatcher.runDelay(self.onDestroy, self, time)
end

function EliminateChessItem:toFlyResource(resourceIds)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffect, resourceIds, self._chessPosX, self._chessPosY)
end

function EliminateChessItem:toMove(time, animType, cb, cbTarget)
	local x = (self._data.x - 1) * EliminateEnum.ChessWidth
	local y = (self._data.y - 1) * EliminateEnum.ChessHeight

	tweenHelper.DOLocalMove(self._tr, x, y, 0, time, self._onMoveEnd, self, {
		cb = cb,
		cbTarget = cbTarget,
		animType = animType
	}, EaseType.OutQuart)
end

function EliminateChessItem:_onMoveEnd(data)
	local animType = data.animType

	if animType and animType == EliminateEnum.AnimType.init then
		self:playAnimation("in")
	end

	if animType and animType == EliminateEnum.AnimType.drop then
		self:playAnimation("add")
	end

	if data.cb then
		data.cb(data.cbTarget)
	end
end

function EliminateChessItem:playAnimation(name)
	if self._ani then
		self._ani:Play(name, 0, 0)
	end
end

function EliminateChessItem:clear()
	if self._go then
		EliminateChessItemController.instance:putChessItemGo(self._go)
	end

	self._img_select = nil
	self._img_chess = nil
	self._goClick = nil
	self._data = nil
	self._select = false
	self._drag = nil
end

function EliminateChessItem:onDestroy(data)
	TaskDispatcher.cancelTask(self.onDestroy, self)

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	if self._drag then
		self._drag:RemoveDragEndListener()
		self._drag:RemoveDragBeginListener()

		self._drag = nil
	end

	if self._ani then
		self._ani = nil
	end

	self:clear()

	if data and data.cb then
		data.cb(data.cbTarget)
	end

	EliminateChessItem.super.onDestroy(self)
end

return EliminateChessItem
