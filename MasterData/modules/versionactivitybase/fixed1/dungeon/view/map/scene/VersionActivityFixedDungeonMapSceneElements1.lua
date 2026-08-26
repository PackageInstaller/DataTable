-- chunkname: @modules/versionactivitybase/fixed1/dungeon/view/map/scene/VersionActivityFixedDungeonMapSceneElements1.lua

module("modules.versionactivitybase.fixed1.dungeon.view.map.scene.VersionActivityFixedDungeonMapSceneElements1", package.seeall)

local VersionActivityFixedDungeonMapSceneElements1 = class("VersionActivityFixedDungeonMapSceneElements1", VersionActivityFixedDungeonMapSceneElements)

function VersionActivityFixedDungeonMapSceneElements1:_editableInitView()
	VersionActivityFixedDungeonMapSceneElements1.super._editableInitView(self)

	self._flyGo = gohelper.findChild(self.viewGO, "#fly")
	self._flyScript = self._flyGo:GetComponent(typeof(UnityEngine.UI.UIFlying))
	self._noteGo = gohelper.findChild(self.viewGO, "#go_topright/#btn_note")
end

function VersionActivityFixedDungeonMapSceneElements1:recycleAllElements()
	if self._elementCompDict then
		for _, elementComp in pairs(self._elementCompDict) do
			local elementId = elementComp:getElementId()

			self._elementCompPoolDict[elementId] = elementComp

			gohelper.addChild(self.elementPoolRoot, elementComp._go)
		end

		tabletool.clear(self._elementCompDict)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnRecycleAllElement)
end

function VersionActivityFixedDungeonMapSceneElements1:_addElement(elementConfig)
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

		local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(self._bigVersion, self._smallVersion)
		local _comp = VersionActivityFixedHelper.getVersionActivityDungeonMapElement(self._bigVersion, self._smallVersion, scriptSuffix)

		elementComp = MonoHelper.addLuaComOnceToGo(go, _comp, {
			elementConfig,
			self
		})
	end

	self._elementCompDict[elementConfig.id] = elementComp

	elementComp:setScale(1)

	local hasArrow = elementComp:isConfigShowArrow()

	if hasArrow then
		local itemPath = self.viewContainer:getSetting().otherRes[3]
		local itemGo = self:getResInst(itemPath, self._goarrow)
		local rotationGo = gohelper.findChild(itemGo, "mesh")
		local rx, ry, rz = transformhelper.getLocalRotation(rotationGo.transform)
		local arrowClick = gohelper.getClick(gohelper.findChild(itemGo, "click"))

		arrowClick:AddClickListener(self._arrowClick, self, elementConfig.id)

		local arrowItem = self:getUserDataTb_()

		arrowItem.go = itemGo
		arrowItem.rotationTrans = rotationGo.transform
		arrowItem.initRotation = {
			rx,
			ry,
			rz
		}
		arrowItem.arrowClick = arrowClick
		self._arrowList[elementConfig.id] = arrowItem

		self:_updateArrow(elementComp)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnAddOneElement, elementComp)
end

function VersionActivityFixedDungeonMapSceneElements1:showElements()
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
		local var_4_0 = VersionActivityFixedDungeonMapSceneElements1.getAllElementCoList()

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

function VersionActivityFixedDungeonMapSceneElements1.getAllElementCoList()
	local normalElementCoList = {}
	local allElements = DungeonMapModel.instance:getAllElements()
	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local dungeonEnum = VersionActivityFixedHelper.getVersionActivityDungeonEnum(bigVersion, smallVersion)

	for _, elementId in pairs(allElements) do
		local elementCo = DungeonConfig.instance:getChapterMapElement(elementId)
		local mapCo = elementCo and lua_chapter_map.configDict[elementCo.mapId]

		if mapCo and mapCo.chapterId == dungeonEnum.DungeonChapterId.Story then
			table.insert(normalElementCoList, elementCo)
		end
	end

	return normalElementCoList
end

function VersionActivityFixedDungeonMapSceneElements1:loadSceneFinish(param)
	VersionActivityFixedDungeonMapSceneElements1.super.loadSceneFinish(self, param)

	local bigVersion, smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
	local scriptSuffix = VersionActivityFixedHelper.getVersionActivityScriptSuffix(bigVersion, smallVersion)
	local dungeonMapLevelView = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelView(bigVersion, smallVersion, scriptSuffix)
	local elementRoot = self._elementRoot

	transformhelper.setLocalPos(elementRoot.transform, 0, 0, ViewMgr.instance:isOpen(dungeonMapLevelView) and 1000 or 0)
end

return VersionActivityFixedDungeonMapSceneElements1
