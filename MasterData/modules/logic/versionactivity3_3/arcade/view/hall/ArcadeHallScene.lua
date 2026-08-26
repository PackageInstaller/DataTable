-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallScene.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallScene", package.seeall)

local ArcadeHallScene = class("ArcadeHallScene", BaseView)

function ArcadeHallScene:onInitView()
	self._gotipview = gohelper.findChild(self.viewGO, "#go_tipview")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHallScene:_editableInitView()
	self._levelsceneItems = self:getUserDataTb_()

	self:_clearComps()
	self:_clearScene()
	self:createScene()
end

function ArcadeHallScene:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeHallScene:removeEvents()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeHallScene:_onOpenView(viewName)
	if viewName == ViewName.EquipView then
		self:showScene(false)
	end
end

function ArcadeHallScene:_onCloseView(viewName)
	if viewName == ViewName.EquipView then
		self:showScene(true)
	end

	for _, param in pairs(ArcadeHallEnum.HallInteractiveParams) do
		if viewName == param.ViewName then
			self:showScene(true)
		end
	end
end

function ArcadeHallScene:onOpen()
	for _, comp in ipairs(self._compList) do
		if comp.onOpen then
			comp:onOpen()
		end
	end

	if self._goScene and self._animPlayer then
		ArcadeController.instance:dispatchEvent(ArcadeEvent.OnLoadFinishHallScene)
		self._animPlayer:Play(UIAnimationName.Open, nil, nil)
	end
end

function ArcadeHallScene:_addComp(compName, compClass, useNewGO)
	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo((useNewGO or nil) and gohelper.create3d(self._sceneRoot, compName), compClass, {
		scene = self,
		compName = compName
	})

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeHallScene:getCharacterMO()
	return ArcadeHallModel.instance:getEquipedCharacterMO()
end

function ArcadeHallScene:getInteractiveMOs()
	return ArcadeHallModel.instance:getInteractiveMOs()
end

function ArcadeHallScene:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			local compName = comp:getCompName()

			self[compName] = nil

			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeHallScene:createScene()
	local root = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = gohelper.create3d(root, ArcadeHallEnum.GameSceneName)

	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local _, y, _ = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)
	self:_disposeSceneLoader()

	if not string.nilorempty(ArcadeHallEnum.SceneUrl) then
		UIBlockMgr.instance:startBlock(ArcadeEnum.BlockKey.LoadHallScene)

		self._sceneLoader = PrefabInstantiate.Create(self._sceneRoot)

		self._sceneLoader:startLoad(ArcadeHallEnum.SceneUrl, self._onLoadSceneFinish, self)
	end
end

function ArcadeHallScene:_onLoadSceneFinish()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.LoadHallScene)

	if not self._sceneLoader then
		return
	end

	self._goScene = self._sceneLoader:getInstGO()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self._goScene.gameObject)

	self._animPlayer:Play(UIAnimationName.Open, nil, nil)
	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnLoadFinishHallScene)

	local root = gohelper.findChild(self._goScene, "Obj-Plant/switch")

	for id, param in pairs(ArcadeHallEnum.LevelScene) do
		local go = gohelper.findChild(root, param.LockObj)

		self._levelsceneItems[id] = self:getUserDataTb_()
		self._levelsceneItems[id].lockObj = go
	end

	self:_initScene()
	self:refreshLevelScene()
end

function ArcadeHallScene:refreshLevelScene()
	for id, item in pairs(self._levelsceneItems) do
		local param = ArcadeHallEnum.LevelScene[id]
		local isUnlock = ArcadeOutSizeModel.instance:isUnlockLevel(param.Level)

		gohelper.setActive(item.lockObj, not isUnlock)
	end
end

function ArcadeHallScene:onTransformPoint(x, y)
	return (self._sceneRoot.transform:TransformPoint(x, y, 0))
end

function ArcadeHallScene:onInverseTransformPoint(worldPos)
	return (self._sceneRoot.transform:InverseTransformPoint(worldPos.x, worldPos.y, 0))
end

function ArcadeHallScene:getSceneRoot()
	return self._sceneRoot
end

function ArcadeHallScene:_initScene()
	self:_addComp("loader", ArcadeLoader)
	self:_addComp("interactiveUI", ArcadeHallInteractiveUIMgr)
	self:_addComp("entity", ArcadeHallEntityMgr, true)
end

function ArcadeHallScene:_disposeSceneLoader()
	if self._sceneLoader then
		self._sceneLoader:dispose()
	end

	self._sceneLoader = nil
end

function ArcadeHallScene:_clearScene()
	if self._goScene then
		gohelper.destroy(self._goScene)
	end

	self._goScene = nil

	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)
	end

	self._sceneRoot = nil
end

function ArcadeHallScene:showScene(isShow)
	if self._sceneRoot then
		gohelper.setActive(self._sceneRoot, isShow)
	end
end

function ArcadeHallScene:playerActOnDirection(direction)
	if not self.entity then
		return
	end

	self.entity:playerActOnDirection(direction)
end

function ArcadeHallScene:onExitHall()
	self:_disposeSceneLoader()
	self:_clearComps()
	self:_clearScene()
	UIBlockMgr.instance:endBlock(ArcadeEnum.BlockKey.LoadHallScene)
end

function ArcadeHallScene:isCanMove()
	if not self.entity then
		return
	end

	local isOpenRefundTipView = ViewMgr.instance:isOpen(ViewName.ArcadeRefundTipView)

	if isOpenRefundTipView then
		return
	end

	local container = ViewMgr.instance:getContainer(ViewName.ArcadeQuitTipView)

	if container and container:isOpen() then
		return
	end

	return self.entity:isCanMove()
end

function ArcadeHallScene:getCharacterEntity()
	if not self.entity then
		return
	end

	return self.entity:getCharacterEntity()
end

function ArcadeHallScene:openBuildingTipView(buildingId)
	local anchor = {
		x = 654,
		y = 263
	}
	local param = {
		buildingId = buildingId,
		root = self._gotipview,
		AnchorPos = anchor,
		orignViewName = self.viewName
	}

	ArcadeController.instance:openTipView(ArcadeEnum.TipType.Building, param)
end

function ArcadeHallScene:onClose()
	self:onExitHall()

	for _, comp in ipairs(self._compList) do
		if comp.onClose then
			comp:onClose()
		end
	end
end

function ArcadeHallScene:onDestroyView()
	self:onExitHall()
end

function ArcadeHallScene:onClear()
	return
end

return ArcadeHallScene
