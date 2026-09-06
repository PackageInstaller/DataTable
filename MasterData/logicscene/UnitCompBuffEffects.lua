-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/UnitCompBuffEffects.lua

module("logicscene.scene.unit.component.battle.UnitCompBuffEffects", package.seeall)

local UnitCompBuffEffects = class("UnitCompBuffEffects", UnitComponentBase)

function UnitCompBuffEffects:ctor(unit)
	UnitCompBuffEffects.super.ctor(self, unit)

	self._effects = {}
	self._currEffects = {}
	self._currEffTime = {}
	self._tempEffTimes = {}
end

function UnitCompBuffEffects:update(deltaTime)
	if not self._currEffTime then
		return
	end

	table.merge(self._tempEffTimes, self._currEffTime)

	for k, v in pairs(self._tempEffTimes) do
		if self._currEffects[k] then
			local effects = self._effects[k]

			if effects and #effects > 0 then
				v = v + deltaTime
				self._currEffTime[k] = v

				if v >= 2 then
					self:_pushEffect(self._currEffects[k])

					self._currEffects[k] = nil

					local eff = self:_popEffect(k)

					if eff then
						self:_showEffect(eff)
					end
				end
			end
		else
			local eff = self:_popEffect(k)

			if eff then
				self:_showEffect(eff)
			end
		end
	end

	table.clear(self._tempEffTimes)
end

function UnitCompBuffEffects:onDestroy()
	self._effects = nil
	self._currEffects = nil
	self._currEffTime = nil
	self._tempEffTimes = nil
end

function UnitCompBuffEffects:isShowing(eff)
	if not eff.turningShow then
		return true
	end

	if self._currEffects then
		local hagPoint = eff.effectCo.hagPoint

		return self._currEffects[hagPoint] == eff
	end
end

function UnitCompBuffEffects:addEffect(eff)
	if not eff.turningShow then
		return
	end

	local hagPoint = eff.effectCo.hagPoint
	local currEff = self._currEffects[hagPoint]

	if currEff then
		self:_pushEffect(currEff)
	end

	self:_showEffect(eff)
end

function UnitCompBuffEffects:_pushEffect(eff)
	local hagPoint = eff.effectCo.hagPoint
	local effects = self._effects[hagPoint]

	if not effects then
		effects = {}
		self._effects[hagPoint] = effects
	end

	table.insert(effects, eff)
end

function UnitCompBuffEffects:_popEffect(hagPoint)
	local effects = self._effects[hagPoint]

	if effects then
		local eff = effects[1]

		if eff then
			table.remove(effects, 1)

			return eff
		end
	end
end

function UnitCompBuffEffects:_showEffect(eff)
	local hagPoint = eff.effectCo.hagPoint

	self._currEffects[hagPoint] = eff
	self._currEffTime[hagPoint] = 0
end

function UnitCompBuffEffects:removeEffect(eff)
	if not eff.turningShow then
		return
	end

	local hagPoint = eff.effectCo.hagPoint

	if self._currEffects[hagPoint] == eff then
		self._currEffects[hagPoint] = nil

		local eff = self:_popEffect(hagPoint)

		if eff then
			self:_showEffect(eff)
		end

		return
	end

	local effects = self._effects[hagPoint]

	if effects then
		local cnt = #effects

		for i = 1, cnt do
			if effects[i] == eff then
				table.remove(effects, i)

				break
			end
		end
	end
end

return UnitCompBuffEffects
