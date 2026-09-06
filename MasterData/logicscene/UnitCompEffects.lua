-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompEffects.lua

module("logicscene.scene.unit.component.UnitCompEffects", package.seeall)

local UnitCompEffects = class("UnitCompEffects", UnitComponentBase)
local json = require("cjson")

function UnitCompEffects:ctor(unit)
	UnitCompEffects.super.ctor(self, unit)

	self._effectList = nil
end

function UnitCompEffects:onInit()
	return
end

function UnitCompEffects:onDestroy()
	if self._effectList then
		for i = 1, #self._effectList do
			self._effectList[i]:destroyEffect()
		end

		self._effectList = nil
	end
end

function UnitCompEffects:onUnitVisible(go)
	if self._effectList then
		for i = 1, #self._effectList do
			self._effectList[i]:createEffect()
		end
	end
end

function UnitCompEffects:buildEffects(npc_effects)
	if string.nilorempty(npc_effects) then
		return
	end

	local json = require("cjson")
	local effects = json.decode(npc_effects)

	for i = 1, #effects do
		local eff = SceneNpcEffect.New()

		eff.dateTime = effects[i].dateTime
		eff.effectPath = effects[i].fx
		eff.unit = self._unit
		eff.hagPoint = self._unit:getMountPoint(effects[i].mountPoint or 0)

		if string.nilorempty(effects[i].dateTime) then
			eff.startTimeStamp = 0
			eff.endTimeStamp = math.huge
		else
			local dates = string.split(effects[i].dateTime, "#")

			eff.startTimeStamp = GameUtil.string2time(dates[1])
			eff.endTimeStamp = string.nilorempty(dates[2]) and math.huge or GameUtil.string2time(dates[2])
		end

		self._effectList = self._effectList or {}

		table.insert(self._effectList, eff)
	end
end

function UnitCompEffects:update(deltaTime)
	if not self._effectList then
		return
	end

	local nowTime = ServerTime.now()

	for i = 1, #self._effectList do
		local eff = self._effectList[i]

		if nowTime >= eff.startTimeStamp and nowTime < eff.endTimeStamp then
			eff:createEffect()
		else
			eff:destroyEffect()
		end
	end
end

function UnitCompEffects:onUnitInVisible(go)
	if self._effectList then
		for i = 1, #self._effectList do
			self._effectList[i]:destroyEffect()
		end
	end
end

function UnitCompEffects:setActive(visible)
	if self._effectList then
		for i = 1, #self._effectList do
			self._effectList[i]:setActive(visible)
		end
	end
end

return UnitCompEffects
