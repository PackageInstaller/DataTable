-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/footstep/FootStepRoad.lua

module("logicscene.scene.unit.component.footstep.FootStepRoad", package.seeall)

local FootStepRoad = class("FootStepRoad", FootStepBase)

function FootStepRoad:ctor(unit)
	FootStepRoad.super.ctor(self, GameEnum.FootStep.ROAD, unit)

	self._footStepAlpha = 0
end

function FootStepRoad:update(deltaTime)
	if self._footStep and self._footStepAlpha > 0 then
		local alpha = self._footStepAlpha - deltaTime * 0.88

		if alpha < 0 then
			alpha = 0
		end

		self._footStepAlpha = alpha

		if self._footStep.go then
			GoUtil.SetColorRGBAByName(self._footStep.go, "_Color", 1, 1, 1, alpha)
		end

		if self._footStepAlpha == 0 then
			self:recycle()

			return true
		end
	end
end

function FootStepRoad:showOneFootStep(x, y, rot, idx, bridgeId, isUnderBridge, bridgeZPos)
	FootStepRoad.super.showOneFootStep(self, x, y, rot, idx, bridgeId, isUnderBridge, bridgeZPos)

	self._footStepAlpha = 1

	self._footStep:setRotation(0, 0, rot)

	if idx % 2 == 0 then
		self._footStep:setScale(-0.3, 0.4, 0.4)
	else
		self._footStep:setScale(0.3, 0.4, 0.4)
	end

	if self._footStep.go then
		GoUtil.SetColorRGBAByName(self._footStep.go, "_Color", 1, 1, 1, 1)
	end
end

return FootStepRoad
