-- chunkname: @modules/logic/handbook/view/HandbookWeekWalkSceneView.lua

module("modules.logic.handbook.view.HandbookWeekWalkSceneView", package.seeall)

local HandbookWeekWalkSceneView = class("HandbookWeekWalkSceneView", BaseView)

function HandbookWeekWalkSceneView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookWeekWalkSceneView:addEvents()
	return
end

function HandbookWeekWalkSceneView:removeEvents()
	return
end

function HandbookWeekWalkSceneView:_editableInitView()
	return
end

function HandbookWeekWalkSceneView:onUpdateParam()
	return
end

function HandbookWeekWalkSceneView:onOpen()
	self.mapId = self.viewParam.id
	self.mapCo = WeekWalkConfig.instance:getMapConfig(self.mapId)
	self.mapBranchCoList = WeekWalkConfig.instance:getMapBranchCoList(1)
	self.elementList = self:getUserDataTb_()
	self.handbookElementList = self:getUserDataTb_()

	self:createSceneMapNode()
	self:loadMap()
	MainCameraMgr.instance:addView(ViewName.HandbookWeekWalkView, self.initCamera, nil, self)
end

function HandbookWeekWalkSceneView:createSceneMapNode()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("WeekWalkMap")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	gohelper.addChild(sceneRoot, self._sceneRoot)
end

function HandbookWeekWalkSceneView:loadMap()
	self._mapLoader = MultiAbLoader.New()

	self._mapLoader:addPath(self.mapCo.map)

	self._canvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"

	self._mapLoader:addPath(self._canvasUrl)
	self._mapLoader:startLoad(self.loadMapCallback, self)
end

function HandbookWeekWalkSceneView:loadMapCallback()
	local assetItem = self._mapLoader:getAssetItem(self.mapCo.map)
	local mainPrefab = assetItem:GetResource(self.mapCo.map)

	self._sceneGo = gohelper.clone(mainPrefab, self._sceneRoot, tostring(self.mapCo.id))

	gohelper.setActive(self._sceneGo, true)

	self._sceneTrans = self._sceneGo.transform
	self._diffuseGo = gohelper.findChild(self._sceneGo, "Obj-Plant/all/diffuse")
	self._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(self._sceneGo, self._elementRoot)
	self:refreshScene(1)
end

function HandbookWeekWalkSceneView:refreshScene(branchIndex)
	self.elementIdList = {}
	self.handbookElementIdList = {}

	for _, elementId in ipairs(string.splitToNumber(self.mapBranchCoList[branchIndex].handbookPath)) do
		table.insert(self.handbookElementIdList, elementId)
	end

	for _, elementId in ipairs(string.splitToNumber(self.mapBranchCoList[branchIndex].nodePath)) do
		table.insert(self.elementIdList, elementId)
	end

	self:loadElements()
end

function HandbookWeekWalkSceneView:loadElements()
	local elementComp

	for _, elementId in ipairs(self.elementIdList) do
		elementComp = self.elementList[elementId]

		if not self.elementList[elementId] then
			elementComp = self:createElementComp(elementId)
			self.elementList[elementId] = elementComp
		end

		elementComp:updateInfo(elementId)
		elementComp:refresh()
	end
end

function HandbookWeekWalkSceneView:createElementComp(elementId)
	local go = UnityEngine.GameObject.New(tostring(elementId))

	gohelper.addChild(self._elementRoot, go)

	return MonoHelper.addLuaComOnceToGo(go, HandbookWeekWalkMapElement, {
		parentView = self,
		diffuseGo = self._diffuseGo
	})
end

function HandbookWeekWalkSceneView:loadHandbookElements()
	return
end

function HandbookWeekWalkSceneView:initCamera()
	local camera = CameraMgr.instance:getMainCamera()

	camera.orthographic = true

	transformhelper.setLocalRotation(camera.transform, 0, 0, 0)

	local scale = GameUtil.getAdapterScale()

	camera.orthographicSize = WeekWalkEnum.orthographicSize * scale
end

function HandbookWeekWalkSceneView:onClose()
	return
end

function HandbookWeekWalkSceneView:onDestroyView()
	return
end

return HandbookWeekWalkSceneView
