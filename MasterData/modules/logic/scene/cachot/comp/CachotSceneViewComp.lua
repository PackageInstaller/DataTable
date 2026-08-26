-- chunkname: @modules/logic/scene/cachot/comp/CachotSceneViewComp.lua

module("modules.logic.scene.cachot.comp.CachotSceneViewComp", package.seeall)

local CachotSceneViewComp = class("CachotSceneViewComp", BaseSceneComp)

function CachotSceneViewComp:onScenePrepared(sceneId, levelId)
	if not V1a6_CachotModel.instance:isInRogue() then
		ViewMgr.instance:openView(ViewName.V1a6_CachotMainView)

		local rogueEndingInfo = V1a6_CachotModel.instance:getRogueEndingInfo()

		if rogueEndingInfo then
			V1a6_CachotController.instance:openV1a6_CachotFinishView()
		end
	else
		ViewMgr.instance:openView(ViewName.V1a6_CachotRoomView)

		local topEventMo = V1a6_CachotRoomModel.instance:getNowTopEventMo()

		if topEventMo then
			local eventCo = lua_rogue_event.configDict[topEventMo.eventId]

			if not eventCo or eventCo.type == V1a6_CachotEnum.EventType.Battle and not topEventMo:isBattleSuccess() then
				return
			end

			local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

			for _, eventMo in ipairs(rogueInfo.selectedEvents) do
				V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, eventMo)
			end
		end
	end
end

function CachotSceneViewComp:getRoot()
	return self._uiRoot
end

function CachotSceneViewComp:setActive(isActive)
	gohelper.setActive(self._uiRoot, isActive)
end

function CachotSceneViewComp:onSceneClose(sceneId, levelId)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotMainView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotRoomView)
end

return CachotSceneViewComp
