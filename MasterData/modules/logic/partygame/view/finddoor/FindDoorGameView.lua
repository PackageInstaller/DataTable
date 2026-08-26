-- chunkname: @modules/logic/partygame/view/finddoor/FindDoorGameView.lua

module("modules.logic.partygame.view.finddoor.FindDoorGameView", package.seeall)

local FindDoorGameView = class("FindDoorGameView", SceneGameCommonView)

FindDoorGameView.CameraMoveDelay = 0.6
FindDoorGameView.CameraMoveTime = 0.6

function FindDoorGameView:onInitView()
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_enter")
	self._btnEnter.canMultTouch = true
	self._cameraRootTrans = CameraMgr.instance:getCameraTraceGO().transform

	local dict = GameUtil.splitString2(PartyGameConfig.instance:getConstValue(130002), true)

	transformhelper.setLocalPos(self._cameraRootTrans, dict[1][1], dict[1][2], dict[1][3])
	transformhelper.setLocalRotation(self._cameraRootTrans, dict[2][1], dict[2][2], dict[2][3])
	FindDoorGameView.super.onInitView(self)
end

function FindDoorGameView:addEvents()
	self._btnEnter:AddClickListener(self._onEnterClick, self)
	FindDoorGameView.super.addEvents(self)
end

function FindDoorGameView:removeEvents()
	self._btnEnter:RemoveClickListener()
	FindDoorGameView.super.removeEvents(self)
end

function FindDoorGameView:onOpen()
	gohelper.setActive(self._btnEnter, false)
	gohelper.setActive(self._gofinish, false)

	FindDoorGameView.CameraMoveDelay = tonumber(PartyGameConfig.instance:getConstValue(130003)) or FindDoorGameView.CameraMoveDelay
	FindDoorGameView.CameraMoveTime = tonumber(PartyGameConfig.instance:getConstValue(130004)) or FindDoorGameView.CameraMoveTime
	self._enterDoorCount = 0
	self._cameraTween = nil
	self._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.viewGO, FindDoorEffectComp)

	FindDoorGameView.super.onOpen(self)
end

local cameraOffset = Vector3(-0.3348703, 21.22, -33.58772)
local heroOffset = Vector3(0.055, 16, -19.56)
local v3 = Vector3()

function FindDoorGameView:viewUpdate(logicFrame)
	local canEnterDoorIndex = PartyGameCSDefine.FindDoorGameInterfaceCs.GetCanEnterDoorIndex()

	gohelper.setActive(self._btnEnter, canEnterDoorIndex >= 0)

	local playerUid = PartyGameController.instance:getCurPartyGame():getMainPlayerUid()
	local enterDoorCount = PartyGameCSDefine.FindDoorGameInterfaceCs.GetPlayerEnterDoorCount(playerUid)
	local layer, angle = PartyGameCSDefine.FindDoorGameInterfaceCs.GetPlayerLayerAndAngle(0, 0)
	local indexArr = {
		PartyGameCSDefine.FindDoorGameInterfaceCs.GetCorrectDoorIndex(0, 0, 0, 0, 0, 0, 0, 0)
	}

	for i, v in ipairs(indexArr) do
		local layer_light = i

		if layer_light > 4 then
			layer_light = layer_light - 4
		end

		if v >= 0 then
			self._effectComp:setLightStatus(layer_light, v + 1, 3)
		end
	end

	if self._cameraTween then
		return
	elseif layer >= 5 then
		if not self._isFinish then
			self._effectComp:setNearDoor()
			self:killTween()
			gohelper.setActive(self._gofinish, true)

			self._isFinish = true

			local duration = tonumber(PartyGameConfig.instance:getConstValue(130001))
			local dict = GameUtil.splitString2(PartyGameConfig.instance:getConstValue(130002), true)

			ZProj.TweenHelper.DOLocalMove(self._cameraRootTrans, dict[1][1], dict[1][2], dict[1][3], duration)
			ZProj.TweenHelper.DOLocalRotate(self._cameraRootTrans, dict[2][1], dict[2][2], dict[2][3], duration)
			TaskDispatcher.runDelay(self._delaySetPos, self, FindDoorGameView.CameraMoveDelay)
		end
	elseif self._enterDoorCount ~= enterDoorCount then
		self:killTween()
		self._effectComp:setLightStatus(self._lastLayer, self._lastDoorIndex + 1, 999)

		self._cameraTween = true
		self._enterDoorCount = enterDoorCount
		self._toAngle = angle
		self._toLayer = layer

		self._effectComp:openDoor(self._lastLayer, self._lastDoorIndex + 1)

		self._lastLayer = layer
		self._lastDoorIndex = Mathf.Round((angle + 84.7) / 11.25333 + 1)

		self._effectComp:setLightStatus(layer, self._lastDoorIndex, 999)
		TaskDispatcher.runDelay(self._delayMoveCamera, self, FindDoorGameView.CameraMoveDelay)

		return
	else
		self._fromAngle = angle
		self._fromLayer = layer

		if not self._initCameraTween then
			local finalPos = self:getFinalPos(angle, layer)

			self:killTween()

			self._cameraTween = true
			self._initCameraTween = true

			ZProj.TweenHelper.DOLocalMove(self._cameraRootTrans, finalPos.x, finalPos.y, finalPos.z, 2)
			ZProj.TweenHelper.DOLocalRotate(self._cameraRootTrans, 10, -angle, 0, 2)
			TaskDispatcher.runDelay(self._onInitTweenEnd, self, 2)
			self:initPlayerTrans()

			finalPos = self:getFinalPos(angle, self._fromLayer, true)

			transformhelper.setLocalPos(self._playerTrans, finalPos.x, finalPos.y, finalPos.z)
			transformhelper.setLocalRotation(self._playerTrans, 10, -angle, 0)
		else
			if self._cameraTween2 then
				ZProj.TweenHelper.KillById(self._cameraTween2, true)

				self._cameraTween2 = nil
			end

			if self._curLerpAngle then
				self._cameraTween2 = ZProj.TweenHelper.DOTweenFloat(self._curLerpAngle, angle, 0.2, self._onTween2, nil, self, nil, EaseType.Linear)
			else
				self:_onTween2(angle)
			end
		end
	end

	if canEnterDoorIndex >= 0 then
		self._lastLayer = layer
		self._lastDoorIndex = canEnterDoorIndex

		self._effectComp:setNearDoor(layer, canEnterDoorIndex + 1)
	else
		self._effectComp:setNearDoor()
	end
end

function FindDoorGameView:_delaySetPos()
	local game = PartyGameController.instance:getCurPartyGame()
	local co = game:getGameConfig()
	local mo = PartyGameModel.instance:getMainPlayerMo()
	local dict = GameUtil.splitString2(co.playerPos, true)

	self:initPlayerTrans()
	transformhelper.setLocalPos(self._playerTrans, dict[mo.index][1], dict[mo.index][2], dict[mo.index][3])
end

function FindDoorGameView:_onInitTweenEnd()
	self._cameraTween = nil
	self._curLerpAngle = nil
end

function FindDoorGameView:_onTween2(value)
	self._curLerpAngle = value

	local finalPos = self:getFinalPos(value, self._fromLayer)

	transformhelper.setLocalPos(self._cameraRootTrans, finalPos.x, finalPos.y, finalPos.z)
	transformhelper.setLocalRotation(self._cameraRootTrans, 10, -value, 0)
	self:initPlayerTrans()

	finalPos = self:getFinalPos(value, self._fromLayer, true)

	transformhelper.setLocalPos(self._playerTrans, finalPos.x, finalPos.y, finalPos.z)
	transformhelper.setLocalRotation(self._playerTrans, 10, -value, 0)
end

function FindDoorGameView:initPlayerTrans()
	if not self._playerTrans then
		local playerUid = PartyGameController.instance:getCurPartyGame():getMainPlayerUid()

		self._playerTrans = PartyGame.Runtime.GameLogic.GameInterfaceBase.GetPlayerTransform(playerUid)
	end
end

function FindDoorGameView:_onTween(value)
	local angle = Mathf.Lerp(self._fromAngle, self._toAngle, value)
	local layer = Mathf.Lerp(self._fromLayer, self._toLayer, value)
	local finalPos = self:getFinalPos(angle, layer)

	transformhelper.setLocalPos(self._cameraRootTrans, finalPos.x, finalPos.y, finalPos.z)
	transformhelper.setLocalRotation(self._cameraRootTrans, 10, -angle, 0)
end

function FindDoorGameView:getFinalPos(angle, layer, isHero)
	local q = Quaternion.Euler(0, -angle, 0)

	v3:Set(-12.665, -4.55 + 7.33 * layer, 18.74)

	if isHero then
		if not heroOffset then
			local offset = cameraOffset

			return ((q * offset):Add(v3))
		end
	end
end

function FindDoorGameView:_onTweenEnd()
	self._cameraTween = nil
	self._curLerpAngle = nil

	AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.game13_door_close)
end

function FindDoorGameView:_delayMoveCamera()
	self._effectComp:closeDoor(self._lastLayer, self._lastDoorIndex)

	self._cameraTween = ZProj.TweenHelper.DOTweenFloat(0, 1, FindDoorGameView.CameraMoveTime, self._onTween, self._onTweenEnd, self)
end

function FindDoorGameView:killTween()
	TaskDispatcher.cancelTask(self._delayMoveCamera, self)

	if self._cameraTween == true then
		self._cameraTween = nil

		return
	end

	if self._cameraTween then
		ZProj.TweenHelper.KillById(self._cameraTween, true)

		self._cameraTween = nil
	end

	if self._cameraTween2 then
		ZProj.TweenHelper.KillById(self._cameraTween2, true)

		self._cameraTween2 = nil
	end
end

function FindDoorGameView:_onEnterClick()
	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId.button1)
end

function FindDoorGameView:onClose()
	TaskDispatcher.cancelTask(self._onInitTweenEnd, self)
	TaskDispatcher.cancelTask(self._delaySetPos, self)
	self:killTween()
	ZProj.TweenHelper.KillByObj(self._cameraRootTrans)
	FindDoorGameView.super.onClose(self)
end

return FindDoorGameView
