-- chunkname: @IQIGame\\Scene\\Home\\Actor\\ModelActor.lua

local RoomPartActor = require("IQIGame/Scene/Home/Actor/RoomPartActor")
local ModelActor = Clone(RoomPartActor)

function ModelActor:__OnInitPrefab()
	self:__OnModelActor_OnInitPrefab()
	self:__OnActorPrepareReady()
end

function ModelActor:__OnModelActor_OnInitPrefab()
	setGameObjectLayers(self.gameObject.transform, "StoryNPC")
end

function ModelActor:AddActorComponent(actorType)
	self.actorComponent = self.gameObject:AddComponent(typeof(IQIGame.Onigao.Game.Home.HomeActor))

	self.actorComponent:InitActorData(actorType, self.actorCid)
end

return ModelActor
