-- chunkname: @IQIGame\\Scene\\Home\\Actor\\UIActor.lua

local RoomPartActor = require("IQIGame/Scene/Home/Actor/RoomPartActor")
local UIActor = Clone(RoomPartActor)

function UIActor:__OnInitPrefab()
	LuaCodeInterface.SetCanvasEventCamera(self.gameObject, UnityEngine.Camera.main)
	self:__OnActorPrepareReady()
end

return UIActor
