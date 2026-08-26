-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/EliminateChessItem2_7.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.EliminateChessItem2_7", package.seeall)

local EliminateChessItem2_7 = class("EliminateChessItem2_7", EliminateChessItem)
local animName = {
	store = "smoke",
	fire = "fire",
	idle = "idle",
	tip = "tips",
	die = "succees"
}
local tweenHelper = ZProj.TweenHelper
local UIDragListener = SLFramework.UGUI.UIDragListener

function EliminateChessItem2_7:init(go)
	self._go = go
	self._tr = go.transform
	self._select = false
	self._ani = go:GetComponent(gohelper.Type_Animator)

	if self._ani then
		self._ani.enabled = true
	end

	self._img_select = gohelper.findChild(self._go, "#img_select")
	self._img_chess = gohelper.findChildImage(self._go, "#img_sprite")
	self._btnClick = gohelper.findChildButtonWithAudio(self._go, "#btn_click")

	self._btnClick:AddClickListener(self.onClick, self)

	self._drag = UIDragListenerHelper.New()
	self._drag = UIDragListener.Get(self._btnClick.gameObject)
end

function EliminateChessItem2_7:initData(data)
	self._data = data

	self:updateInfo()
end

function EliminateChessItem2_7:getData()
	return self._data
end

function EliminateChessItem2_7:updateInfo()
	if self._data then
		local name = LengZhou6EliminateConfig.instance:getChessIconPath(self._data.id)
		local isActive = not string.nilorempty(name)

		recthelper.setSize(self._tr, EliminateEnum_2_7.ChessWidth, EliminateEnum_2_7.ChessHeight)

		if isActive then
			UISpriteSetMgr.instance:setHisSaBethSprite(self._img_chess, name, false)
		end

		gohelper.setActiveCanvasGroup(self._go, isActive)
		self:updatePos()
		self:_checkSpecialSkillState()
		self:setNormalAnimation()
		gohelper.setActive(self._go, isActive)
	end
end

function EliminateChessItem2_7:setNormalAnimation()
	if self._data == nil then
		return
	end

	local eliminateId = self._data:getEliminateID()

	if eliminateId ~= EliminateEnum_2_7.ChessType.stone then
		self:playAnimation(animName.idle)
	else
		self:playAnimation(animName.store)
	end
end

function EliminateChessItem2_7:updatePos()
	if self._data then
		local posX, posY = LocalEliminateChessUtils.instance.getChessPos(self._data.startX, self._data.startY)

		transformhelper.setLocalPosXY(self._tr, posX, posY)
	end
end

function EliminateChessItem2_7:onClick()
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.OnChessSelect, self._data.x, self._data.y, true)
end

function EliminateChessItem2_7:setSelect(isSelect)
	self._select = isSelect

	gohelper.setActiveCanvasGroup(self._img_select, self._select)
end

function EliminateChessItem2_7:toTip(active)
	if not active then
		self:setNormalAnimation()
	else
		self:playAnimation(animName.tip)
	end
end

function EliminateChessItem2_7:getGoPos()
	self._chessPosX, self._chessPosY = transformhelper.getPos(self._img_chess.transform)

	return self._chessPosX, self._chessPosY
end

function EliminateChessItem2_7:toDie(time, skillEffect)
	if skillEffect == nil or skillEffect == LengZhou6Enum.NormalEliminateEffect then
		self:playAnimation(animName.die)
	elseif skillEffect == LengZhou6Enum.SkillEffect.EliminationCross then
		self:playAnimation(animName.fire)
	else
		self:playAnimation(animName.die)
	end

	TaskDispatcher.runDelay(self.onDestroy, self, time)
end

function EliminateChessItem2_7:toMove(time, animType, cb, cbTarget)
	if self._data == nil then
		logNormal("EliminateChessItem2_7:toMove self._data == nil" .. self._go.name)
	end

	local x, y = LocalEliminateChessUtils.instance.getChessPos(self._data.x, self._data.y)

	self._tweenId = tweenHelper.DOLocalMove(self._tr, x, y, 0, time, self._onMoveEnd, self, {
		cb = cb,
		cbTarget = cbTarget,
		animType = animType
	}, EaseType.OutQuart)
end

function EliminateChessItem2_7:_onMoveEnd(data)
	if self._data ~= nil then
		self._data:setStartXY(self._data.x, self._data.y)
	end

	if data.cb then
		data.cb(data.cbTarget)
	end
end

function EliminateChessItem2_7:playAnimation(name)
	if self._ani then
		self._ani:Play(name, 0, 0)
	end
end

function EliminateChessItem2_7:clear()
	if self._go then
		LengZhou6EliminateChessItemController.instance:putChessItemGo(self._go)
	end

	self._img_select = nil
	self._img_chess = nil
	self._goClick = nil
	self._data = nil
	self._select = false
	self._drag = nil
end

function EliminateChessItem2_7:changeState(fromState, x, y)
	if self._data == nil then
		return
	end

	self:_checkFrostState(fromState, x, y)
	self:_checkSpecialSkillState(fromState)
end

function EliminateChessItem2_7:_checkFrostState(fromState, x, y)
	local isFrost = self._data:haveStatus(EliminateEnum_2_7.ChessState.Frost)

	if isFrost then
		if not LengZhou6Event.ShowEffect then
			local event = LengZhou6Event.HideEffect

			LengZhou6EliminateController.instance:dispatchEvent(event, x, y, EliminateEnum_2_7.ChessEffect.frost)
		end
	end
end

function EliminateChessItem2_7:_checkSpecialSkillState()
	local isSpecialSkill = self._data:haveStatus(EliminateEnum_2_7.ChessState.SpecialSkill)

	if isSpecialSkill then
		local eliminateId = self._data:getEliminateID()
		local imageName = EliminateEnum_2_7.SpecialChessImage[eliminateId]

		if not string.nilorempty(imageName) then
			UISpriteSetMgr.instance:setHisSaBethSprite(self._img_chess, imageName, false)
		end
	end
end

function EliminateChessItem2_7:onDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end

	if self._ani then
		self._ani = nil
	end

	self:clear()
	EliminateChessItem2_7.super.onDestroy(self)
end

return EliminateChessItem2_7
