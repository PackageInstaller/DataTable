-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudBase.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudBase", package.seeall)

local BattleHudBase = class("BattleHudBase")

function BattleHudBase:ctor(go, pool)
	self.go = go
	self.pool = pool
	self.unit = nil

	self.go:SetActive(false)
end

function BattleHudBase:start()
	return
end

function BattleHudBase:update(deltaTime)
	return
end

function BattleHudBase:isDone()
	return
end

function BattleHudBase:finish()
	return
end

function BattleHudBase:isFadingIn()
	return
end

function BattleHudBase:recycle()
	self.unit = nil

	if self.pool then
		self.pool:recycleHud(self)
	elseif self.go then
		UnityEngine.GameObject.Destroy(self.go)

		self.go = nil
	end
end

return BattleHudBase
