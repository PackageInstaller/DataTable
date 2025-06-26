-- chunkname: @IQIGame\\Scene\\FlightChallenge\\Input\\FlightGameInputManager.lua

local m = {}

m = extend(InputManager, m)

function m.New()
	local obj = Clone(m)

	obj:Init()

	return obj
end

function m:OnDrag(state, deltaX, deltaY)
	if FlightGameModule.isGameOver then
		return
	end

	if FlightGameModule.flightGameScene and FlightGameModule.flightGameScene.gamePlayer then
		FlightGameModule.flightGameScene.gamePlayer:OnMovePos(Vector2.New(deltaX * 0.08, deltaY * 0.08))
	end
end

return m
