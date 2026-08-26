-- chunkname: @modules/logic/explore/map/unit/ExplorePipeSensorUnit.lua

module("modules.logic.explore.map.unit.ExplorePipeSensorUnit", package.seeall)

local ExplorePipeSensorUnit = class("ExplorePipeSensorUnit", ExplorePipeUnit)

function ExplorePipeSensorUnit:onResLoaded()
	ExplorePipeSensorUnit.super.onResLoaded(self)

	local effectRoot = gohelper.findChild(self._displayGo, "#go_rotate/effect2/root")

	if effectRoot then
		local particles = effectRoot:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true)

		for i = 0, particles.Length - 1 do
			local color = ExploreEnum.PipeColorDef[self.mo:getNeedColor()]

			ZProj.ParticleSystemHelper.SetStartColor(particles[i], color.r, color.g, color.b, 1)
		end
	end
end

function ExplorePipeSensorUnit:initComponents()
	ExplorePipeSensorUnit.super.initComponents(self)
	self:addComp("pipeComp", ExplorePipeComp)
end

function ExplorePipeSensorUnit:setupMO()
	ExplorePipeSensorUnit.super.setupMO(self)
	self.pipeComp:initData()
end

function ExplorePipeSensorUnit:processMapIcon(icon)
	local iconArr = GameUtil.splitString2(icon)

	for _, arr in pairs(iconArr) do
		if tonumber(arr[1]) == self.mo:getNeedColor() then
			return arr[2]
		end
	end

	return nil
end

return ExplorePipeSensorUnit
