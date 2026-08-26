-- chunkname: @modules/logic/versionactivity/view/VersionActivityDungeonMapSceneElements.lua

module("modules.logic.versionactivity.view.VersionActivityDungeonMapSceneElements", package.seeall)

local VersionActivityDungeonMapSceneElements = class("VersionActivityDungeonMapSceneElements", DungeonMapSceneElements)

function VersionActivityDungeonMapSceneElements:_editableInitView()
	VersionActivityDungeonMapSceneElements.super._editableInitView(self)

	self.finishElementList = {}
end

function VersionActivityDungeonMapSceneElements:onOpen()
	self.activityDungeonMo = self.viewContainer.versionActivityDungeonBaseMo

	VersionActivityDungeonMapSceneElements.super.onOpen(self)
	self.addEventCb(self, VersionActivityDungeonBaseController.instance, VersionActivityDungeonEvent.OnModeChange, self.onModeChange, self, LuaEventSystem.Low)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self._initElements, self)
end

function VersionActivityDungeonMapSceneElements:onModeChange()
	local showElement = self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Story

	for _, elementComp in pairs(self._elementList) do
		if showElement then
			elementComp:show()
		else
			elementComp:hide()
		end
	end

	for _, elementComp in pairs(self.finishElementList) do
		if showElement then
			elementComp:show()
		else
			elementComp:hide()
		end
	end
end

function VersionActivityDungeonMapSceneElements:_removeElement(id)
	local elementCo = DungeonConfig.instance:getChapterMapElement(id)

	if not self:canShow(elementCo) then
		VersionActivityDungeonMapSceneElements.super._removeElement(self, id)

		return
	end

	local elementComp = self._elementList[id]
	local existGo = elementComp._go

	elementComp:setFinishAndDotDestroy()

	self._elementList[id] = nil

	local arrowItem = self._arrowList[id]

	if arrowItem then
		arrowItem.arrowClick:RemoveClickListener()

		self._arrowList[id] = nil

		gohelper.destroy(arrowItem.go)
	end

	self:addFinishElement(DungeonConfig.instance:getChapterMapElement(id), existGo)
end

function VersionActivityDungeonMapSceneElements:_showElements(mapId)
	if self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return
	end

	if not DungeonModel.instance:hasPassLevelAndStory(self.activityDungeonMo.episodeId) then
		return
	end

	VersionActivityDungeonMapSceneElements.super._showElements(self, mapId)

	local elementsList = DungeonMapModel.instance:getElements(mapId)
	local mapAllElementList = DungeonConfig.instance:getMapElements(mapId)

	if mapAllElementList then
		for _, elementCo in ipairs(mapAllElementList) do
			if self:canShow(elementCo) and not self:inNotFinishElementList(elementCo.id, elementsList) then
				self:addFinishElement(elementCo)
			end
		end
	end
end

function VersionActivityDungeonMapSceneElements:inNotFinishElementList(elementId, notFinishElementsList)
	for _, elementCo in ipairs(notFinishElementsList) do
		if elementCo.id == elementId then
			return true
		end
	end

	return false
end

function VersionActivityDungeonMapSceneElements:addFinishElement(elementCo, existGo)
	if self.finishElementList[elementCo.id] then
		return
	end

	local go = existGo

	if not go then
		go = UnityEngine.GameObject.New(tostring(elementCo.id))

		gohelper.addChild(self._elementRoot, go)
	end

	self.finishElementList[elementCo.id] = MonoHelper.addLuaComOnceToGo(go, DungeonMapFinishElement, {
		elementCo,
		self._mapScene,
		self,
		existGo
	})
end

function VersionActivityDungeonMapSceneElements:canShow(elementCo)
	return elementCo.type == DungeonEnum.ElementType.PuzzleGame or elementCo.type == DungeonEnum.ElementType.None
end

function VersionActivityDungeonMapSceneElements:_disposeScene()
	VersionActivityDungeonMapSceneElements.super._disposeScene(self)
	self:disposeFinishElements()
end

function VersionActivityDungeonMapSceneElements:_disposeOldMap()
	VersionActivityDungeonMapSceneElements.super._disposeOldMap(self)
	self:disposeFinishElements()
end

function VersionActivityDungeonMapSceneElements:disposeFinishElements()
	for k, v in pairs(self.finishElementList) do
		v:onDestroy()
	end

	self.finishElementList = {}
end

return VersionActivityDungeonMapSceneElements
