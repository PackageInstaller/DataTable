-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudText.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudText", package.seeall)

local BattleHudText = class("BattleHudText", BattleHudBase)

function BattleHudText:ctor(go, pool)
	BattleHudText.super.ctor(self, go, pool)

	self._time = 0
	self._duration = 1.3
	self.sprite = nil
	self._node = goutil.findChild(self.go, "txtNum").transform

	local imageGo = goutil.findChild(self.go, "txtNum/txtNum")

	self._imageCompState = imageGo:GetComponent("UIImageSpriteChange")
	self._imageComp = imageGo:GetComponent("Image")
	self._hudText = imageGo:GetComponent("HUDText")

	local posx, posy, posz = Framework.TransformUtil.GetLocalPos(self._node, nil, nil, nil)

	self._posX = posx
	self._posY = posy
	self._posZ = posz
end

function BattleHudText:start()
	self._imageCompState:ChangeStateNow(self.sprite)
	self._imageComp:SetNativeSize()

	self._time = 0

	local posx = self._posX + (self.offsetX or 0)
	local posy = self._posY + ((not self.offsetY or nil) and 0)
	local posz = self._posZ

	if self.unit:getDirection() == UnitSpineDir.Left then
		Framework.TransformUtil.SetLocalPos(self._node, posx, posy, posz)
	else
		Framework.TransformUtil.SetLocalPos(self._node, -posx, posy, posz)
	end

	BattleHudMovingMgr.movingUpCritical(self._hudText)
	self.go:SetActive(true)
end

function BattleHudText:update(deltaTime)
	self._time = self._time + deltaTime
end

function BattleHudText:isFadingIn()
	return self._time < 1
end

function BattleHudText:isDone()
	return self._time >= self._duration
end

function BattleHudText:finish()
	return
end

return BattleHudText
