-- chunkname: @modules/logic/versionactivity3_2/dungeon/view/map/scene/VersionActivity3_2DungeonMapSceneElements.lua

module("modules.logic.versionactivity3_2.dungeon.view.map.scene.VersionActivity3_2DungeonMapSceneElements", package.seeall)

local VersionActivity3_2DungeonMapSceneElements = class("VersionActivity3_2DungeonMapSceneElements", VersionActivityFixedDungeonMapSceneElements)

function VersionActivity3_2DungeonMapSceneElements:_editableInitView()
	VersionActivity3_2DungeonMapSceneElements.super._editableInitView(self)

	self._flyGo = gohelper.findChild(self.viewGO, "#fly")
	self._flyScript = self._flyGo:GetComponent(typeof(UnityEngine.UI.UIFlying))
	self._noteGo = gohelper.findChild(self.viewGO, "#go_topright/#btn_note")

	self.addEventCb(self, VersionActivityFixedDungeonController.instance, VersionActivity3_2DungeonEvent.V3a2TimelineChange, self._onTimelineChange, self)
end

function VersionActivity3_2DungeonMapSceneElements:_onTimelineChange(showMap)
	self._showMap = showMap

	self:recycleAllElements()
	self:showElements()
end

function VersionActivity3_2DungeonMapSceneElements:_addElement(elementConfig)
	if self._elementCompDict[elementConfig.id] then
		return
	end

	local elementComp = self._elementCompPoolDict[elementConfig.id]

	if elementComp then
		self._elementCompPoolDict[elementConfig.id] = nil

		gohelper.addChild(self._elementRoot, elementComp._go)
		elementComp:updatePos()
	else
		local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

		gohelper.addChild(self._elementRoot, go)

		local _comp = VersionActivityFixedHelper.getVersionActivityDungeonMapElement(self._bigVersion, self._smallVersion)

		elementComp = MonoHelper.addLuaComOnceToGo(go, _comp, {
			elementConfig,
			self
		})
	end

	self._elementCompDict[elementConfig.id] = elementComp

	elementComp:setScale(self._showMap and 1.5 or 1)
	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnAddOneElement, elementComp)
end

function VersionActivity3_2DungeonMapSceneElements:showElements()
	if not self._mapCfg then
		return
	end

	if self.activityDungeonMo:isHardMode() then
		self:recycleAllElements()

		for _, v in pairs(self._arrowList) do
			v.arrowClick:RemoveClickListener()
			gohelper.destroy(v.go)
		end

		self._arrowList = self:getUserDataTb_()

		return
	end

	local animElements = {}
	local normalElements = {}
	local newElements = DungeonMapModel.instance:getNewElements()

	if self._showMap then
		local var_4_0 = VersionActivity3_2DungeonMapSceneElements.getAllElementCoList()

		if not var_4_0 then
			var_4_0 = VersionActivityFixedDungeonModel.instance:getElementCoList(self._mapCfg.id)

			local elementCoList = var_4_0

			for _, elementCo in ipairs(elementCoList) do
				local isNew = newElements and tabletool.indexOf(newElements, elementCo.id)

				if isNew and elementCo.showCamera == 1 then
					table.insert(animElements, elementCo.id)
				else
					table.insert(normalElements, elementCo)
				end
			end

			self:_showElementAnim(animElements, normalElements)
			DungeonMapModel.instance:clearNewElements()

			if self._initClickElementId then
				self:manualClickElement(self._initClickElementId)

				self._initClickElementId = nil
			end
		end
	end
end

function VersionActivity3_2DungeonMapSceneElements.getAllElementCoList()
	local normalElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = elementCo and lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion).DungeonChapterId.Story then
			table.insert(normalElementCoList, elementCo)
		end
	end

	return normalElementCoList
end

function VersionActivity3_2DungeonMapSceneElements:loadSceneFinish(param)
	VersionActivity3_2DungeonMapSceneElements.super.loadSceneFinish(self, param)

	local elementRoot = self._elementRoot

	transformhelper.setLocalPos(elementRoot.transform, 0, 0, ViewMgr.instance:isOpen(ViewName.VersionActivity3_2DungeonMapLevelView) and 1000 or 0)
end

function VersionActivity3_2DungeonMapSceneElements:_removeElement(id)
	local elementComp = self._elementCompDict[id]

	if elementComp then
		local config = elementComp:getConfig()

		if config.type == DungeonEnum.ElementType.V3a2Note then
			local elementTrans = elementComp:getTransform()
			local camera = CameraMgr.instance:getMainCamera()
			local worldPos = elementTrans.position
			local posX, posY = recthelper.worldPosToScreenPoint(camera, worldPos.x, worldPos.y, worldPos.z)

			posX, posY = recthelper.screenPosToAnchorPos2(Vector2(posX, posY), self.viewGO.transform)
			self._flyScript.startPosition = Vector2(posX, posY)
			self._flyScript.endPosition = recthelper.rectToRelativeAnchorPos(self._noteGo.transform.position, self.viewGO.transform)

			gohelper.setActive(self._flyGo, true)
			self._flyScript:StartFlying()
		end
	end

	VersionActivity3_2DungeonMapSceneElements.super._removeElement(self, id)
end

return VersionActivity3_2DungeonMapSceneElements
