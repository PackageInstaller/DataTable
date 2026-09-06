-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/CreateRoleSceneStage.lua

module("logicscene.scene.component.stage.CreateRoleSceneStage", package.seeall)

local CreateRoleSceneStage = class("CreateRoleSceneStage", SceneStageBase)

function CreateRoleSceneStage:onEnterScene(sceneId)
	return
end

function CreateRoleSceneStage:onExitScene()
	return
end

function CreateRoleSceneStage:load(sceneId, loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj
	self._stageResUrls = "scene/createrole/createrolescene.prefab"
	self._resLoader = MultiResLoader.New()

	local assetsList = {}

	table.insert(assetsList, self._stageResUrls)

	local avatarMo1 = DressModel.instance:getDefaultAvatarMo(DressModel.defaultFemaleSkelId)
	local avatarMo2 = DressModel.instance:getDefaultAvatarMo(DressModel.defaultMaleSkelId)
	local assets1 = avatarMo1:getAssetsList(AvatarType.UI)
	local assets2 = avatarMo2:getAssetsList(AvatarType.UI)

	for j = 1, #assets1 do
		table.insert(assetsList, assets1[j])
	end

	for j = 1, #assets2 do
		table.insert(assetsList, assets2[j])
	end

	self._resLoader:setResPaths(assetsList)
	self._resLoader:load(self._onAllResourceLoaded, nil, self)
	GlobalDispatcher:dispatch(GlobalNotify.SceneStartLoaded)
end

function CreateRoleSceneStage:unload()
	GameUtil.unloadMultiResLoaderResource(self._resLoader)

	self._resLoader = nil
	self._stageResUrls = nil

	if not goutil.isNil(self._stageInst) then
		goutil.destroy(self._stageInst)

		self._stageInst = nil
	end
end

function CreateRoleSceneStage:getStageIns()
	return self._stageInst
end

function CreateRoleSceneStage:_onAllResourceLoaded()
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

function CreateRoleSceneStage:loadingDone()
	self:_createStage()
	SceneMgr.instance:onEnterFinished()
	self:dispatch(SceneNotify.StageLoaded)
end

function CreateRoleSceneStage:_createStage()
	local res = Framework.ResourceCache.Instance:GetResourceNoLoadIfNotExists(self._stageResUrls)

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

return CreateRoleSceneStage
