-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonMapSceneElement.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapSceneElement", package.seeall)

local VersionActivity1_2DungeonMapSceneElement = class("VersionActivity1_2DungeonMapSceneElement", DungeonMapSceneElements)
local SetFlagGuideIds = {
	12101,
	12102,
	12104,
	12105
}
local ForceShowElementIds = {
	12101011
}

function VersionActivity1_2DungeonMapSceneElement:addEvents()
	VersionActivity1_2DungeonMapSceneElement.super.addEvents(self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveAct116InfoUpdatePush, self._onReceiveAct116InfoUpdatePush, self)
end

function VersionActivity1_2DungeonMapSceneElement:_OnRemoveElement(id)
	if not self._elementList then
		return
	end

	if not self._elementList[id] then
		return
	end

	VersionActivity1_2DungeonMapSceneElement.super._OnRemoveElement(self, id)
end

function VersionActivity1_2DungeonMapSceneElement:_addElement(elementConfig)
	if elementConfig.id == 12101091 then
		return
	end

	if self._elementList[elementConfig.id] then
		return
	end

	local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

	gohelper.setActive(go, self:_checkShowDailyElement(elementConfig.id))
	gohelper.addChild(self._elementRoot, go)

	local elementComp = MonoHelper.addLuaComOnceToGo(go, VersionActivity1_2DungeonMapElement, {
		elementConfig,
		self._mapScene,
		self
	})

	self._elementList[elementConfig.id] = elementComp

	if elementComp:showArrow() then
		local itemPath = self.viewContainer:getSetting().otherRes[5]
		local itemGo = self:getResInst(itemPath, self._goarrow)
		local rotationGo = gohelper.findChild(itemGo, "mesh")
		local rx, ry, rz = transformhelper.getLocalRotation(rotationGo.transform)
		local arrowClick = gohelper.getClick(gohelper.findChild(itemGo, "click"))

		arrowClick:AddClickListener(self._arrowClick, self, elementConfig.id)

		self._arrowList[elementConfig.id] = {
			go = itemGo,
			rotationTrans = rotationGo.transform,
			initRotation = {
				rx,
				ry,
				rz
			},
			arrowClick = arrowClick
		}

		self:_updateArrow(elementComp)
	end
end

function VersionActivity1_2DungeonMapSceneElement:_onReceiveAct116InfoUpdatePush()
	if self._elementList then
		for i, v in ipairs(self._elementList) do
			gohelper.setActive(v._go, self:_checkShowDailyElement(v._config.id))
		end
	end

	self.viewContainer.mapScene:_showDailyBtn()
end

function VersionActivity1_2DungeonMapSceneElement:_showElements(mapId)
	if not self._sceneGo or self._lockShowElementAnim then
		return
	end

	local elementsList = DungeonMapModel.instance:getElements(mapId)

	for i, v in ipairs(elementsList) do
		if v.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
			local buildingData = VersionActivity1_2DungeonModel.instance:getElementData(v.id)

			if not buildingData then
				Activity116Rpc.instance:sendGet116InfosRequest()

				break
			end
		end
	end

	local newElements = DungeonMapModel.instance:getNewElements()
	local animElements = {}
	local normalElements = {}

	for i, config in ipairs(elementsList) do
		if config.showCamera == 1 and not self._skipShowElementAnim and (newElements and tabletool.indexOf(newElements, config.id) or self._forceShowElementAnim) then
			table.insert(animElements, config.id)
		else
			table.insert(normalElements, config)
		end
	end

	self:_showElementAnim(animElements, normalElements)
	DungeonMapModel.instance:clearNewElements()
end

function VersionActivity1_2DungeonMapSceneElement:_checkShowDailyElement(elementId)
	local elementConfig = lua_chapter_map_element.configDict[elementId]

	if elementConfig.type == DungeonEnum.ElementType.DailyEpisode then
		return VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(elementId)
	end

	return true
end

function VersionActivity1_2DungeonMapSceneElement:setElementDown(item)
	if not gohelper.isNil(self._mapScene._uiGo) then
		return
	end

	self.curSelectId = item._config.id
	self._elementMouseDown = item
end

function VersionActivity1_2DungeonMapSceneElement:_onFinishGuide(guideId)
	if (self._lockShowElementAnim or self._forceShowElementId ~= nil and tabletool.indexOf(ForceShowElementIds, self._forceShowElementId)) and tabletool.indexOf(SetFlagGuideIds, guideId) then
		self._lockShowElementAnim = nil
		self._forceShowElementId = nil

		GuideModel.instance:clearFlagByGuideId(guideId)
		self:_initElements()
	end
end

return VersionActivity1_2DungeonMapSceneElement
