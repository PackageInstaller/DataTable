-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/impl/BattleGroupTerrainCell.lua

module("logic.battle.unit.impl.BattleGroupTerrainCell", package.seeall)

local M = class("BattleGroupTerrainCell", IBattleReusable)

function M:ctor()
	self._position = Vector3.New()
end

function M:buildUI(terrainGo)
	goutil.setActive(terrainGo, true)

	self._terrainGo = terrainGo
	self._animation = goutil.addComponentOnce(terrainGo, typeof(Astral.GUITimelineAniLua))
	self._lineGo = goutil.findChild(terrainGo, "line")
	self._playingAnimationName = false

	Astral.TransformUtil.SetPos(self._terrainGo.transform, self._position:Get())
end

function M:reset()
	goutil.destroy(self._terrainGo)

	self._terrainGo = nil
	self._animation = nil
	self._lineGo = nil
	self._animDoneCallFunc = false
	self._animDoneCallHandle = false
	self._playingAnimationName = false
end

function M:destroy()
	self:reset()
end

function M:playBornAnimation()
	self:setLinePos()

	if self._animation then
		self._playingAnimationName = "start"

		self._animation:StopTimelineAni()
		self._animation:AddListener(self._animationDoneListener, self)
		self._animation:PlayAniByName("start")
	end
end

function M:onEnable()
	if self._playingAnimationName and self._animation then
		self._animation:StopTimelineAni()
		self._animation:PlayAniByName(self._playingAnimationName)
	end
end

function M:setVisible(state)
	goutil.setActive(self._terrainGo, state)
end

function M:setAnimDoneListnener(func, handler)
	self._animDoneCallFunc = func
	self._animDoneCallHandle = handler
end

function M:setPosAndIndexUnion(unionIndex)
	self._unionIndex = unionIndex
end

function M:getPosAndIndexUnion()
	return self._unionIndex
end

function M:setRemoveState(state)
	self._removeState = state
end

function M:getRemoveState()
	return self._removeState
end

function M:playClearAnimation()
	if self._animation then
		self._playingAnimationName = "end"

		self._animation:StopTimelineAni()
		self._animation:AddListener(self._animationDoneListener, self)

		if not self._animation:PlayAniByName("end") then
			self:_animationDoneListener("end")
		end
	else
		self:_animationDoneListener("end")
	end
end

function M:setPos(x, y, z)
	self._position:Set(x, y, z)

	if self._terrainGo then
		Astral.TransformUtil.SetPos(self._terrainGo.transform, x, y, z)
	end
end

function M:setLinePos()
	if not self._lineGo then
		return
	end

	local index = self._unionIndex % 10
	local rotationY = 0
	local x = 0
	local z = 0
	local halfSideLength = SpaceX.CheckBoardSetting.GetHalfSideLength()

	if index == 1 then
		x = halfSideLength
		rotationY = -90
	elseif index == 2 then
		z = halfSideLength
		rotationY = 180
	elseif index == 3 then
		x = -halfSideLength
		rotationY = 90
	elseif index == 4 then
		z = -halfSideLength
		rotationY = 0
	end

	Astral.TransformUtil.SetLocalPos(self._lineGo.transform, x, 0, z)
	Astral.TransformUtil.SetLocalRotation(self._lineGo.transform, 0, rotationY, 0)
end

function M:_animationDoneListener(animName)
	if animName == "end" and self._animDoneCallFunc then
		self._animDoneCallFunc(self._animDoneCallHandle, animName, self._unionIndex)
		self:returnSelf()
	end

	self._playingAnimationName = false
end

return M
