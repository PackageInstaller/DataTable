-- chunkname: @modules/logic/explore/map/unit/ExplorePipeMemoryUnit.lua

module("modules.logic.explore.map.unit.ExplorePipeMemoryUnit", package.seeall)

local ExplorePipeMemoryUnit = class("ExplorePipeMemoryUnit", ExplorePipeUnit)

function ExplorePipeMemoryUnit:onResLoaded()
	ExplorePipeMemoryUnit.super.onResLoaded(self)

	local effectRoot = gohelper.findChild(self._displayGo, "#go_rotate/effect2/root")

	if effectRoot then
		local needColor = self.mo:getNeedColor()

		if needColor == ExploreEnum.PipeColor.None then
			gohelper.setActive(effectRoot, false)
		else
			local particles = effectRoot:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true)

			for i = 0, particles.Length - 1 do
				local color = ExploreEnum.PipeColorDef[self.mo:getNeedColor()]

				ZProj.ParticleSystemHelper.SetStartColor(particles[i], color.r, color.g, color.b, 1)
			end
		end
	end
end

function ExplorePipeMemoryUnit:initComponents()
	ExplorePipeMemoryUnit.super.initComponents(self)
	self:addComp("pipeComp", ExplorePipeComp)
end

function ExplorePipeMemoryUnit:setupMO()
	ExplorePipeMemoryUnit.super.setupMO(self)
	self.pipeComp:initData()
end

function ExplorePipeMemoryUnit:onStatus2Change(preStatuInfo, nowStatuInfo)
	self.mo:setCacheColor(nowStatuInfo.color or ExploreEnum.PipeColor.None)
end

function ExplorePipeMemoryUnit:processMapIcon(icon)
	local iconArr = GameUtil.splitString2(icon)

	for _, arr in pairs(iconArr) do
		if tonumber(arr[1]) == self.mo:getNeedColor() then
			return arr[2]
		end
	end

	return nil
end

return ExplorePipeMemoryUnit
