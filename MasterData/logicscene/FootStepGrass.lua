-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/footstep/FootStepGrass.lua

module("logicscene.scene.unit.component.footstep.FootStepGrass", package.seeall)

local FootStepGrass = class("FootStepGrass", FootStepBase)

function FootStepGrass:ctor(unit)
	FootStepGrass.super.ctor(self, GameEnum.FootStep.GRASS, unit)
end

function FootStepGrass:update(deltaTime)
	if self._footStep and self._stepTime > 0 then
		self._stepTime = self._stepTime - deltaTime

		if self._stepTime <= 0 then
			self:recycle()

			return true
		end
	end
end

function FootStepGrass:showOneFootStep(x, y, rot, idx, bridgeId, isUnderBridge, bridgeZPos)
	FootStepGrass.super.showOneFootStep(self, x, y, rot, idx, bridgeId, isUnderBridge, bridgeZPos)

	self._stepTime = 1
end

return FootStepGrass
