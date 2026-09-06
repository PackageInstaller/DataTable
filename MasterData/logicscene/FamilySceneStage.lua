-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/FamilySceneStage.lua

module("logicscene.scene.component.stage.FamilySceneStage", package.seeall)

local FamilySceneStage = class("FamilySceneStage", SceneCityStage)

function FamilySceneStage:load(sceneId, loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj
	self._terrainResUrls = "scene/battle/jzcjdj/jzcjdj.prefab"
	self._stageResUrls = {
		"scene/configs/family/family.txt"
	}

	local assetsList = {}

	table.insert(assetsList, self._terrainResUrls)

	for i, v in ipairs(self._stageResUrls) do
		table.insert(assetsList, v)
	end

	self._resLoader = MultiResLoader.New()

	self._resLoader:setResPaths(assetsList)
	self._resLoader:load(self._onAllResourceLoaded, nil, self)
	GlobalDispatcher:dispatch(GlobalNotify.SceneStartLoaded)
end

function FamilySceneStage:unload()
	FamilySceneStage.super.unload(self)

	self._terrainResUrls = nil

	if not goutil.isNil(self._stageInst) then
		goutil.destroy(self._stageInst)

		self._stageInst = nil
	end
end

function FamilySceneStage:getStageIns()
	return self._stageInst
end

function FamilySceneStage:_onAllResourceLoaded()
	self:_onStageResourceLoaded()

	if self._loadListener then
		if self._loadListenerObj then
			self._loadListener(self._loadListenerObj, 1, true)
		else
			self._loadListener(1, true)
		end
	end

	if not self._loadListener then
		self:loadingDone()
	end
end

function FamilySceneStage:_onStageResourceLoaded()
	self.wholeScene = self:_createWholeScele()

	self.wholeScene:RegisterOnPlayerHandler(self._scene._onPlayerVisible, self._scene._onPlayerCreate, self._scene._onPlayerDestroy, self._scene._onPlayerQualityCull, self._scene)
	self.wholeScene:BuildScene()

	self._terrainResReady = true
end

function FamilySceneStage:loadingDone()
	self:_createStage()
	FamilySceneMainPlayer.instance:updateVariablesView()
	SceneMgr.instance:onEnterFinished()
	GlobalDispatcher:dispatch(SceneNotify.StageLoaded)
	self:_updateObstacles()
end

function FamilySceneStage:_createStage()
	local res = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists(self._terrainResUrls)

	if res then
		local mainAssert = res:GetMainAsset()

		if not goutil.isNil(mainAssert) then
			self._stageInst = goutil.clone(mainAssert)

			if not goutil.isNil(self._stageInst) then
				goutil.addChildToParent(self._stageInst, self._scene:getContainer())

				self._stageInst.transform.position = FamilyScene.SceneStageRootPos
			end
		else
			self._stageInst = nil
		end
	end
end

function FamilySceneStage:onEnterScene(sceneId)
	FamilySceneStage.super.onEnterScene(self, sceneId)
	GlobalDispatcher:addListener(GlobalNotify.FamilyPartyNotifyPartyBeginRes, self._onPartyBeginRes, self)
	GlobalDispatcher:addListener(GlobalNotify.FamilyPartyNotifyPartyEndRes, self._onPartyEndRes, self)
end

function FamilySceneStage:onExitScene()
	FamilySceneStage.super.onExitScene(self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyPartyNotifyPartyBeginRes, self._onPartyBeginRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.FamilyPartyNotifyPartyEndRes, self._onPartyEndRes, self)
end

function FamilySceneStage:_onPartyBeginRes()
	self:_updateObstacles()
end

function FamilySceneStage:_onPartyEndRes()
	self:_updateObstacles()
end

function FamilySceneStage:_updateObstacles()
	local sceneParentGo = self:getStageIns()

	if sceneParentGo then
		local obstacles = goutil.findChild(sceneParentGo, "obstacles")
		local element = goutil.findChild(sceneParentGo, "element")
		local isOpening = FamilyPartyModel.instance:isPartyOpening()

		GameUtil.SetActive(obstacles, isOpening)
		GameUtil.SetActive(element, isOpening)
	end
end

return FamilySceneStage
