-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/component/ElevatorStatus.lua

module("logic.scene.unit.elevator.component.ElevatorStatus", package.seeall)

local M = class("ElevatorStatus", UnitComponentBase)
local ElevatorAnim = SceneEnum.ElevatorAnim
local ElevatorMoveStatus = SceneEnum.ElevatorMoveStatus
local kButtonNum = 2
local kBaseTexID = UnityEngine.Shader.PropertyToID("_BaseColor")
local vec3Temp = Vector3.New()

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._upBtnMatSetter = nil
	self._downBtnMatSetter = nil
	self._upBtnTrigger = nil
	self._downBtnTrigger = nil
	self._showList = nil
	self._isUpBtnOn = false
	self._isDownBtnOn = false
	self._flashBtnTimer = SchedulerCtrl.New(self.refreshButtonStatus, self)
end

function M:onInit()
	self:_initGO()
end

function M:_initGO()
	local upBtnGO = goutil.findChild(self._unit.go, "button/sx-s201_obj_liftbutton_up")

	if upBtnGO then
		self._upBtnMatSetter = MaterialSetter.Get(upBtnGO)

		self._upBtnMatSetter:SetGameObject(upBtnGO)
	end

	local downBtnGO = goutil.findChild(self._unit.go, "button/sx-s201_obj_liftbutton_down")

	if downBtnGO then
		self._downBtnMatSetter = MaterialSetter.Get(downBtnGO)

		self._downBtnMatSetter:SetGameObject(downBtnGO)
	end

	self._upBtnTrigger = goutil.findChild(self._unit.go, "liftdoor_button_up_1")
	self._downBtnTrigger = goutil.findChild(self._unit.go, "liftdoor_button_down_2")

	local showGO = goutil.findChild(self._unit.go, "show/sx-s201_fx")

	self._showPlayerDirector = showGO:GetComponent(ComponentType.PlayableDirector)

	local upShow = goutil.findChild(showGO, "sx-s201_obj_liftshow_down")

	goutil.setActive(upShow, false)

	local downShow = goutil.findChild(showGO, "sx-s201_obj_liftshow_up")

	goutil.setActive(downShow, false)

	self._showList = {
		upShow,
		downShow
	}
end

function M:clear()
	self._flashBtnTimer:clear()

	self._flashBtnTimer = nil
	self._upBtnMatSetter = nil
	self._downBtnMatSetter = nil
	self._upBtnTrigger = nil
	self._downBtnTrigger = nil
	self._showList = nil
	self._showPlayerDirector = nil
	self._isUpBtnOn = false
	self._isDownBtnOn = false
end

function M:getUpBtnTriggerPos()
	vec3Temp:Set(Astral.TransformUtil.GetPos(self._upBtnTrigger.transform, 0, 0, 0))

	return vec3Temp
end

function M:getDownBtnTriggerPos()
	vec3Temp:Set(Astral.TransformUtil.GetPos(self._downBtnTrigger.transform, 0, 0, 0))

	return vec3Temp
end

function M:hasBtnOn()
	return self._isUpBtnOn or self._isDownBtnOn
end

function M:isBtnOn(isUp)
	if isUp then
		return self._isUpBtnOn
	end

	return self._isDownBtnOn
end

function M:setUpBtnOn(isOn)
	if not self._unit:isTop() then
		self._isUpBtnOn = isOn

		self:refreshButtonStatus()
	end
end

function M:setDownBtnOn(isOn)
	if not self._unit:isBottom() then
		self._isDownBtnOn = isOn

		self:refreshButtonStatus()
	end
end

function M:refreshButtonStatus()
	local upColor = self._isUpBtnOn and "#FFE7BA" or "#FFFFFF"

	self._upBtnMatSetter:SetColor(kBaseTexID, upColor)

	local downColor = self._isDownBtnOn and "#FFE7BA" or "#FFFFFF"

	self._downBtnMatSetter:SetColor(kBaseTexID, downColor)
end

function M:flashButton(isUp)
	local btnMatSetter = isUp and self._upBtnMatSetter or self._downBtnMatSetter

	btnMatSetter:SetColor(kBaseTexID, "#FFE7BA")
	self._flashBtnTimer:restart(0.3, false)
end

function M:refreshShowStatus()
	local lobbyUnit = self._unit:getLobbyUnit()
	local moveDir = lobbyUnit.mover:getMoveDirection()

	goutil.setActive(self._showList[1], moveDir == ElevatorMoveStatus.Up)
	goutil.setActive(self._showList[2], moveDir == ElevatorMoveStatus.Down)
end

function M:pauseShowStatus()
	self._showPlayerDirector:Pause()

	self._showPlayerDirector.time = 0
end

function M:resumeShowStatus()
	self._showPlayerDirector:Resume()
end

return M
