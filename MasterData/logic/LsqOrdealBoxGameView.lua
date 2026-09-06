-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealBoxGameView.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealBoxGameView", package.seeall)

local LsqOrdealBoxGameView = class("LsqOrdealBoxGameView", ViewComponent)
local EnumGameState = {
	BeforeStart = 1,
	ResetStart = 3,
	End = 4,
	Playing = 2
}

function LsqOrdealBoxGameView:ctor()
	LsqOrdealBoxGameView.super.ctor(self)
end

function LsqOrdealBoxGameView:buildUI()
	LsqOrdealBoxGameView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._gameTipGo = self:getGo("gameTip")
	self._defaultGo = self:getGo("default")
	self._successGo = self:getGo("success")
	self._btnGameTip = self:getBtn("gameTip")
	self._txtTip = self:getTxt("gameTip/txtTip")
	self._btnSuccess = self:getBtn("success/btnBox")
	self._recordPos = self:getGo("dragRoot"):GetComponent(typeof(TestRecordPos))
	self._txtTime = self:getTxt("countdown/txtTime")
	self._boxEffectGo = self:getGo("success/effect")
	self._dragCells = {}

	for i = 1, 4 do
		local go = self:getGo("dragRoot/dragCell" .. i)

		BeginDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onBeginDragCell(_go, eventData)
		end)
		DragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onDragingCell(_go, eventData)
		end)
		EndDragHandler.Get(go):AddLuaHandler(function(_go, eventData)
			self:_onEndDragCell(_go, eventData)
		end)
		table.insert(self._dragCells, go)
	end

	self._dropArea = self:getGo("dropArea")

	DropHandler.Get(self._dropArea):AddLuaHandler(function(_go, eventData)
		self:_onDropCell(_go, eventData)
	end)
end

function LsqOrdealBoxGameView:bindEvents()
	LsqOrdealBoxGameView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnGameTip:AddClickListener(self._onClickGameTip, self)
	self._btnSuccess:AddClickListener(self._onClickSuccess, self)
end

function LsqOrdealBoxGameView:unbindEvents()
	LsqOrdealBoxGameView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGameTip:RemoveClickListener()
	self._btnSuccess:RemoveClickListener()
end

function LsqOrdealBoxGameView:onEnter()
	LsqOrdealBoxGameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayOpenGiftRes, self._onOpenGiftRes, self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayChangeActivity, self._onChangeActivity, self)
	LuoShiQiOrdealModel.instance:setChangeSetId(nil)

	self._activityId = self:getFirstParam()
	self._dragingGo = nil
	self._recordInitPos = Vector3.New(0, 0, 0)
	self._totalTime = 60
	self._gameState = EnumGameState.BeforeStart

	self:_showGameTip(lang("lsqordeal_desc16"))
	self:_initGameState()
	self:_loadBoxEffect()
	settimer(1, self._onSecond, self)
end

function LsqOrdealBoxGameView:onExit()
	LsqOrdealBoxGameView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayOpenGiftRes, self._onOpenGiftRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayChangeActivity, self._onChangeActivity, self)
	removetimer(self._onSecond, self)
	self:_removeBoxEffect()
end

function LsqOrdealBoxGameView:_onClickClose()
	self:close()
end

function LsqOrdealBoxGameView:_onClickGameTip()
	goutil.setActive(self._gameTipGo, false)

	if self._gameState == EnumGameState.BeforeStart then
		self._isPlaying = true
	elseif self._gameState == EnumGameState.ResetStart then
		self:_initGameState()

		self._gameState = EnumGameState.Playing
		self._isPlaying = true

		goutil.setActive(self._gameTipGo, false)
	elseif self._gameState == EnumGameState.End then
		LuoShiQiOrdealController.instance:showRewards()
		self:_onClickClose()
	end
end

function LsqOrdealBoxGameView:_onClickSuccess()
	XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayOpenGiftReq(self._activityId)
end

function LsqOrdealBoxGameView:_onOpenGiftRes()
	self._gameState = EnumGameState.End

	self:_showGameTip(lang("lsqordeal_desc17"))
end

function LsqOrdealBoxGameView:_onChangeActivity()
	self._isPlaying = false
end

function LsqOrdealBoxGameView:_onBeginDragCell(go, eventData)
	if not self._isPlaying then
		return
	end

	if self._dragingGo then
		return
	end

	self._pointerId = eventData.pointerId
	self._dragingGo = go
	self._initPos = self._dragingGo.transform.position
	self._dragingGo:GetComponent(ComponentType.RawImage).raycastTarget = false
end

function LsqOrdealBoxGameView:_onDragingCell(go, eventData)
	if not self._isPlaying then
		return
	end

	if not self._dragingGo then
		return
	end

	if self._pointerId == nil or self._pointerId ~= eventData.pointerId then
		return
	end

	self._dragingGo.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function LsqOrdealBoxGameView:_onDropCell(go, eventData)
	if not self._isPlaying then
		return
	end

	if not self._dragingGo then
		return
	end

	if self._pointerId == nil or self._pointerId ~= eventData.pointerId then
		return
	end

	goutil.setActive(self._dragingGo, false)

	self._dragingGo = nil
	self._curCellCount = self._curCellCount + 1

	if self._curCellCount >= self._maxCellCount then
		self:_onGameOver(true)
	end
end

function LsqOrdealBoxGameView:_onEndDragCell(go, eventData)
	if not self._isPlaying then
		return
	end

	if not self._dragingGo then
		return
	end

	if self._pointerId == nil or self._pointerId ~= eventData.pointerId then
		return
	end

	self._pointerId = nil
	self._dragingGo.transform.position = self._initPos
	self._dragingGo:GetComponent(ComponentType.RawImage).raycastTarget = true
	self._dragingGo = nil
end

function LsqOrdealBoxGameView:_onSecond()
	if self._isPlaying then
		if self._curTime >= 0 then
			self._txtTime.text = string.format("%d%s", self._curTime, lang("tip_second"))
			self._curTime = self._curTime - 1
		else
			self:_onGameOver(false)
		end
	end
end

function LsqOrdealBoxGameView:_initGameState()
	for i, go in ipairs(self._dragCells) do
		goutil.setActive(go, true)

		go:GetComponent(ComponentType.RawImage).raycastTarget = true
	end

	goutil.setActive(self._gameTipGo, true)
	goutil.setActive(self._successGo, false)
	goutil.setActive(self._defaultGo, true)
	self._recordPos:LoadPlan(0)

	self._curTime = self._totalTime
	self._isPlaying = false
	self._dragingGo = nil
	self._pointerId = nil
	self._maxCellCount = #self._dragCells
	self._curCellCount = 0
	self._txtTime.text = string.format("%d%s", self._curTime, lang("tip_second"))
end

function LsqOrdealBoxGameView:_onGameOver(isSuccess)
	self._isPlaying = false

	if isSuccess then
		goutil.setActive(self._successGo, true)
		goutil.setActive(self._defaultGo, false)
	else
		self._gameState = EnumGameState.ResetStart

		self:_showGameTip(lang("lsqordeal_desc18"))
	end
end

function LsqOrdealBoxGameView:_showGameTip(tip)
	goutil.setActive(self._gameTipGo, true)

	self._txtTip.text = tip
end

function LsqOrdealBoxGameView:_loadBoxEffect()
	self:_removeBoxEffect()

	local effName = LsqOrdealBoxGameViewPresentor.Effect1

	self._uiBoxEffect = UIEffectManager.instance:playEffect(self, effName, self._boxEffectGo.transform, 0, 0, true, false)

	self._uiBoxEffect:setLocalPos(0, 0, 0)
	self._uiBoxEffect:setScale(1)
	self._uiBoxEffect:setParent(self._boxEffectGo.transform)
end

function LsqOrdealBoxGameView:_removeBoxEffect()
	if self._uiBoxEffect then
		UIEffectManager.instance:stopEffect(self._uiBoxEffect)

		self._uiBoxEffect = nil
	end
end

return LsqOrdealBoxGameView
