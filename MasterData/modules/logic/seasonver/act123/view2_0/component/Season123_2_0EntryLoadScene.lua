-- chunkname: @modules/logic/seasonver/act123/view2_0/component/Season123_2_0EntryLoadScene.lua

module("modules.logic.seasonver.act123.view2_0.component.Season123_2_0EntryLoadScene", package.seeall)

local Season123_2_0EntryLoadScene = class("Season123_2_0EntryLoadScene", UserDataDispose)

function Season123_2_0EntryLoadScene:init()
	self:__onInit()

	self._prefabDict = {}
	self._containerDict = self:getUserDataTb_()
	self._retailPrefabDict = {}
	self._retailContainerDict = self:getUserDataTb_()
	self._retailPosXDict = {}
	self._retailPosYDict = {}
	self._animDict = self:getUserDataTb_()
end

function Season123_2_0EntryLoadScene:dispose()
	self:__onDispose()
	self:releaseRes()
end

function Season123_2_0EntryLoadScene:createSceneRoot()
	local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
	local sceneRoot = CameraMgr.instance:getSceneRoot()

	self._sceneRoot = UnityEngine.GameObject.New("Season123_2_0EntryScene")

	local x, y, z = transformhelper.getLocalPos(mainTrans)

	transformhelper.setLocalPos(self._sceneRoot.transform, 0, y, 0)

	self._sceneOffsetY = y

	gohelper.addChild(sceneRoot, self._sceneRoot)

	return self._sceneRoot
end

function Season123_2_0EntryLoadScene:disposeSceneRoot()
	if self._sceneRoot then
		gohelper.destroy(self._sceneRoot)

		self._sceneRoot = nil
	end
end

Season123_2_0EntryLoadScene.BLOCK_LOAD_RES_KEY = "Season123_2_0EntrySceneLoadRes"

function Season123_2_0EntryLoadScene:loadRes(callback, callbackObj)
	self._callback = callback
	self._callbackObj = callbackObj

	UIBlockMgr.instance:startBlock(Season123_2_0EntryLoadScene.BLOCK_LOAD_RES_KEY)

	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getSceneBackgroundUrl())
	self._loader:startLoad(self.onLoadResCompleted, self)
end

function Season123_2_0EntryLoadScene:releaseRes()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	UIBlockMgr.instance:endBlock(Season123_2_0EntryLoadScene.BLOCK_LOAD_RES_KEY)

	if self._prefabDict then
		for _, inst in pairs(self._prefabDict) do
			inst:dispose()
		end

		self._prefabDict = nil
	end

	if self._retailPrefabDict then
		for _, inst in pairs(self._retailPrefabDict) do
			inst:dispose()
		end

		self._retailPrefabDict = nil
	end
end

function Season123_2_0EntryLoadScene:getSceneBackgroundUrl()
	local sceneFolderPath = self:getSceneFolderPath()
	local defaultBackgroundPrefab = self:getDefaultBackgroundPrefab()

	return ResUrl.getSeason123Scene(sceneFolderPath, defaultBackgroundPrefab)
end

function Season123_2_0EntryLoadScene:onLoadResCompleted(loader)
	if not self._loader then
		return
	end

	local assetItem = loader:getAssetItem(self:getSceneBackgroundUrl())

	if assetItem then
		self._sceneGo = gohelper.clone(assetItem:GetResource(), self._sceneRoot, "scene")
		self._sceneRetailRoot = gohelper.findChild(self._sceneGo, "root")
	end

	UIBlockMgr.instance:endBlock(Season123_2_0EntryLoadScene.BLOCK_LOAD_RES_KEY)

	if self._callback then
		if self._callbackObj then
			self._callback(self._callbackObj, self._sceneGo)
		else
			self._callback(self._sceneGo)
		end
	end
end

function Season123_2_0EntryLoadScene:showStageRes(targetStage, isOpen)
	local actId = Season123EntryModel.instance.activityId
	local stageCO = Season123Config.instance:getStageCo(actId, targetStage)

	if not stageCO then
		return
	end

	for stageId, containerGO in pairs(self._containerDict) do
		gohelper.setActive(containerGO, stageId == targetStage)
	end

	if not self._containerDict[targetStage] then
		self:createPrefabInst(targetStage, stageCO, isOpen)
	elseif isOpen then
		self:playAnim(targetStage, Activity123Enum.StageSceneAnim.Open)
	end
end

function Season123_2_0EntryLoadScene:hideAllStage()
	for stageId, containerGO in pairs(self._containerDict) do
		gohelper.setActive(containerGO, false)
	end
end

function Season123_2_0EntryLoadScene:showRetailRes(retailSceneId)
	local rndIndex, _ = Season123EntryModel.getRandomRetailRes(retailSceneId)

	for index, containerGO in pairs(self._retailContainerDict) do
		gohelper.setActive(containerGO, index == rndIndex)
	end

	if not self._retailContainerDict[rndIndex] then
		self:createRetailPrefabInst(retailSceneId)
	end
end

function Season123_2_0EntryLoadScene:hideAllRetail()
	for index, containerGO in pairs(self._retailContainerDict) do
		gohelper.setActive(containerGO, false)
	end
end

function Season123_2_0EntryLoadScene:createPrefabInst(stage, stageCO, isOpen)
	if string.nilorempty(stageCO.res) then
		return
	end

	local containerGO = UnityEngine.GameObject.New("stage_" .. tostring(stage))

	gohelper.addChild(self._sceneRoot, containerGO)

	self._containerDict[stage] = containerGO

	local posStr = stageCO.initPos

	if not string.nilorempty(posStr) then
		local posXY = string.splitToNumber(posStr, "#")

		transformhelper.setLocalPos(containerGO.transform, posXY[1], posXY[2], 0)
	else
		transformhelper.setLocalPos(containerGO.transform, 0, 0, 0)
	end

	local scaleStr = stageCO.initScale

	if not string.nilorempty(scaleStr) then
		local scaleXY = string.splitToNumber(scaleStr, "#")

		transformhelper.setLocalScale(containerGO.transform, scaleXY[1], scaleXY[2], 1)
	else
		transformhelper.setLocalScale(containerGO.transform, 1, 1, 1)
	end

	local inst = PrefabInstantiate.Create(containerGO)

	self._prefabDict[stage] = inst
	self.tempStage = stage
	self.isOpen = isOpen

	inst:startLoad(ResUrl.getSeason123Scene(self:getSceneFolderPath(), stageCO.res), self.loadCallback, self)
end

function Season123_2_0EntryLoadScene:loadCallback(inst)
	if self.tempStage then
		local go = inst:getInstGO()

		self._animDict[self.tempStage] = go:GetComponent(gohelper.Type_Animator)

		if self.isOpen then
			self:playAnim(self.tempStage, Activity123Enum.StageSceneAnim.Open)

			self.isOpen = nil
		end

		self.tempStage = nil
	end
end

function Season123_2_0EntryLoadScene:createRetailPrefabInst(retailSceneId)
	local rndIndex, prefabPath = Season123EntryModel.getRandomRetailRes(retailSceneId)
	local versionPrefabPath = string.format("%s%s", Activity123Enum.SeasonResourcePrefix[Season123EntryModel.instance.activityId], prefabPath)
	local containerGO = UnityEngine.GameObject.New("retail_" .. tostring(rndIndex))

	gohelper.addChild(self._sceneRetailRoot, containerGO)
	transformhelper.setLocalPos(containerGO.transform, 0, 0, 0)
	transformhelper.setLocalScale(containerGO.transform, 1, 1, 1)

	local inst = PrefabInstantiate.Create(containerGO)

	self._retailContainerDict[rndIndex] = containerGO
	self._retailPrefabDict[rndIndex] = inst

	inst:startLoad(ResUrl.getSeason123RetailPrefab(self:getSceneFolderPath(), versionPrefabPath), self.onLoadRetailCompleted, self)
end

function Season123_2_0EntryLoadScene:onLoadRetailCompleted(loader)
	local index = self:getIndexByRetailInst(loader)

	if index then
		local loaderGO = loader:getInstGO()

		if loaderGO then
			local contentTf = loaderGO.transform:GetChild(0)

			if contentTf then
				local x, y = transformhelper.getLocalPos(contentTf)

				self._retailPosXDict[index] = -x
				self._retailPosYDict[index] = -y

				Season123EntryController.instance:dispatchEvent(Season123Event.RetailObjLoaded, index)
			end
		end
	end
end

function Season123_2_0EntryLoadScene:getIndexByRetailInst(loader)
	if not self._retailPrefabDict then
		return
	end

	for index, inst in pairs(self._retailPrefabDict) do
		if inst == loader then
			return index
		end
	end
end

function Season123_2_0EntryLoadScene:getRetailPosByIndex(index)
	return self._retailPosXDict[index], self._retailPosYDict[index]
end

function Season123_2_0EntryLoadScene:playAnim(stage, animName)
	if not self._animDict[stage] then
		return
	end

	self._animDict[stage]:Play(animName, 0, 0)
end

function Season123_2_0EntryLoadScene:tweenStage(stage, isEnter)
	if not self._containerDict[stage] then
		logError("gameObject is empty:stage" .. stage)

		return
	end

	local stageTrs = self._containerDict[stage].transform
	local stageCO = Season123Config.instance:getStageCo(Season123EntryModel.instance.activityId, stage)
	local posStr, scaleStr

	if isEnter then
		posStr = stageCO.finalPos
		scaleStr = stageCO.finalScale
	else
		posStr = stageCO.initPos
		scaleStr = stageCO.initScale
	end

	AudioMgr.instance:trigger(AudioEnum.UI.season123_map_scale)

	local posXY = string.splitToNumber(posStr, "#")

	ZProj.TweenHelper.DOLocalMove(stageTrs, posXY[1], posXY[2], 0, 0.7)

	local scaleXY = string.splitToNumber(scaleStr, "#")

	ZProj.TweenHelper.DOScale(stageTrs, scaleXY[1], scaleXY[2], 1, 0.7)
end

function Season123_2_0EntryLoadScene:getSceneFolderPath()
	if not Season123EntryModel.instance.activityId then
		local actId = Season123Model.instance:getCurSeasonId()
		local version = Activity123Enum.SeasonResourcePrefix[actId]

		return (string.format("%s%s", version, Activity123Enum.SceneFolderPath))
	end
end

function Season123_2_0EntryLoadScene:getDefaultBackgroundPrefab()
	if not Season123EntryModel.instance.activityId then
		local actId = Season123Model.instance:getCurSeasonId()
		local version = Activity123Enum.SeasonResourcePrefix[actId]

		return (string.format("%s%s", version, Activity123Enum.DefaultBackgroundPrefab))
	end
end

return Season123_2_0EntryLoadScene
