-- chunkname: @IQIGame\\Module\\BehaviorTree\\BehaviorTreeUtility_WoldMapRPG.lua

function BehaviorTreeUtility.EnterArea(areaId)
	if StoryModule.isDebugMod then
		return
	end

	WorldMapModule.EnterArea(areaId, false)
end

function BehaviorTreeUtility.EnterRoom(roomId)
	if StoryModule.isDebugMod then
		return
	end

	WorldMapModule.EnterRoom(roomId, false, "", true)
end

function BehaviorTreeUtility.TriggerRPGAction(actionCid)
	WorldMapModule.TriggerAction(actionCid, 0)
end

function BehaviorTreeUtility.RemoveFinishAction(actionCid)
	WorldMapModule.TriggerAction(actionCid, -1)
end
