-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudPool.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudPool", package.seeall)

local BattleHudPool = class("BattleHudPool")

function BattleHudPool:ctor(mainAsset, hudType, capacity)
	self.hudType = hudType
	self._mainAsset = mainAsset
	self._capacity = capacity
	self._isClear = nil
	self._hudCache = {}
end

function BattleHudPool:getHud()
	local hud

	if self._hudCache then
		hud = self._hudCache[1]

		if self._hudCache[1] then
			table.remove(self._hudCache, 1)
		end
	end

	hud = hud or self:_createHud()

	return hud
end

function BattleHudPool:recycleHud(hud)
	if self._isClear then
		UnityEngine.GameObject.Destroy(hud.go)
	else
		self._hudCache = self._hudCache or {}

		if #self._hudCache >= self._capacity then
			UnityEngine.GameObject.Destroy(hud.go)
		else
			hud.go:SetActive(false)
			table.insert(self._hudCache, hud)
		end
	end
end

function BattleHudPool:clear()
	self._isClear = true

	local cnt = #self._hudCache

	for i = 1, cnt do
		UnityEngine.GameObject.Destroy(self._hudCache[i].go)
	end

	self._hudCache = nil
end

function BattleHudPool:_createHud()
	return
end

return BattleHudPool
