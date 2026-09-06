-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/CutePetSceneStage.lua

module("logicscene.scene.component.stage.CutePetSceneStage", package.seeall)

local CutePetSceneStage = class("CutePetSceneStage", SceneCityStage)

function CutePetSceneStage:load(sceneId, loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj
	self._terrainResUrls = "scene/battle/cw01/cwy_p.prefab"
	self._stageResUrls = {
		"scene/configs/cutepet/cute_pet.txt"
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

function CutePetSceneStage:unload()
	CutePetSceneStage.super.unload(self)

	self._terrainResUrls = nil

	if not goutil.isNil(self._stageInst) then
		goutil.destroy(self._stageInst)

		self._stageInst = nil
	end
end

function CutePetSceneStage:getStageIns()
	return self._stageInst
end

function CutePetSceneStage:_onAllResourceLoaded()
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

function CutePetSceneStage:_onStageResourceLoaded()
	self.wholeScene = self:_createWholeScele()

	self.wholeScene:BuildScene()

	self._terrainResReady = true
end

function CutePetSceneStage:loadingDone()
	self:_createStage()
	SceneMgr.instance:onEnterFinished()
	self:dispatch(SceneNotify.StageLoaded)
end

function CutePetSceneStage:_createStage()
	local res = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists(self._terrainResUrls)

	if res then
		local mainAssert = res:GetMainAsset()

		if not goutil.isNil(mainAssert) then
			self._stageInst = goutil.clone(mainAssert)

			if not goutil.isNil(self._stageInst) then
				goutil.addChildToParent(self._stageInst, self._scene:getContainer())
			end
		else
			self._stageInst = nil
		end
	end
end

return CutePetSceneStage
