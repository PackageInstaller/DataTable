-- chunkname: @IQIGame\\Scene\\Survival\\Input\\SurvivalFlyGameInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnDrag(state, deltaX, deltaY)
	if FlyGameModule.isGameOver then
		return
	end

	if FlyGameModule.survivalFlyGameScene and FlyGameModule.survivalFlyGameScene.gamePlayer then
		FlyGameModule.survivalFlyGameScene.gamePlayer:OnMovePos(Vector2.New(deltaX * 0.06, deltaY * 0.06))
	end
end

return m
