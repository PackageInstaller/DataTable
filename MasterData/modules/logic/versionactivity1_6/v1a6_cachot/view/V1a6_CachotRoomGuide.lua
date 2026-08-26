-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRoomGuide.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomGuide", package.seeall)

local V1a6_CachotRoomGuide = class("V1a6_CachotRoomGuide", BaseView)

function V1a6_CachotRoomGuide:onInitView()
	return
end

function V1a6_CachotRoomGuide:addEvents()
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.CheckGuideEnterLayerRoom, self._checkGuideEnterLayerRoom, self)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.CheckPlayStory, self._onRoomViewOpenAnimEnd, self, LuaEventSystem.Low)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.GuideMoveCollection, self._onGuideMoveCollection, self)
	self.addEventCb(self, GuideController.instance, GuideEvent.FinishGuide, self._onFinishGuide, self)
end

function V1a6_CachotRoomGuide:removeEvents()
	return
end

function V1a6_CachotRoomGuide:onOpen()
	self._heartNum = V1a6_CachotController.instance.heartNum
	V1a6_CachotController.instance.heartNum = nil
end

function V1a6_CachotRoomGuide:onClose()
	TaskDispatcher.cancelTask(self._guideEnterLayerRoom, self)
end

function V1a6_CachotRoomGuide:_onFinishGuide(guideId)
	if guideId == 16508 then
		self:_guideEnterLayerRoom()
	end
end

function V1a6_CachotRoomGuide:_onGuideMoveCollection()
	V1a6_CachotCollectionBagController.instance.guideMoveCollection = true
end

function V1a6_CachotRoomGuide:_checkGuideEnterLayerRoom()
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	TaskDispatcher.cancelTask(self._guideEnterLayerRoom, self)
	TaskDispatcher.runDelay(self._guideEnterLayerRoom, self, 0.5)
end

function V1a6_CachotRoomGuide:_guideEnterLayerRoom()
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not self._rogueInfo then
		return
	end

	local layer = self._rogueInfo.layer
	local roomIndex, total = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(self._rogueInfo.room)
	local heartNum = self._rogueInfo.heart
	local oldHeartNum = self._heartNum

	self._heartNum = heartNum

	if layer ~= 1 or roomIndex >= 3 then
		if oldHeartNum and oldHeartNum ~= heartNum then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideHeartChange)
		end

		if V1a6_CachotCollectionHelper.isCollectionBagCanEnchant() then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideCanEnchant)
		end
	end

	if layer == 3 and roomIndex == 3 then
		local collectionMap = self._rogueInfo.collectionCfgMap
		local collectionList = collectionMap and collectionMap[V1a6_CachotEnum.SpecialCollection]
		local hasCollection = collectionList and #collectionList > 0

		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideEnterLayerRoom, string.format("%s_%s_%s", layer, roomIndex, hasCollection and 1 or 0))

		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideEnterLayerRoom, string.format("%s_%s", layer, roomIndex))
end

function V1a6_CachotRoomGuide:_onRoomViewOpenAnimEnd()
	self:_guideEnterLayerRoom()
end

function V1a6_CachotRoomGuide:_onCloseViewFinish(viewName)
	if viewName == ViewName.StoryBackgroundView or string.find(viewName, "V1a6_CachotCollection") then
		self:_guideEnterLayerRoom()
	end
end

return V1a6_CachotRoomGuide
