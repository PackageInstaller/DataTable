-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/stage/ElementSparkSceneStage.lua

module("logicscene.scene.component.stage.ElementSparkSceneStage", package.seeall)

local ElementSparkSceneStage = class("ElementSparkSceneStage", SceneCityStage)

function ElementSparkSceneStage:load(sceneId, loadListener, loadListenerObj)
	self._loadListener = loadListener
	self._loadListenerObj = loadListenerObj
	self._sceneBgResUrls = "scene/elementspark/scenebg.prefab"

	local planId = ElementSparkController.instance:getMapPlanId()

	self._stageResUrls = {
		string.format("scene/configs/elementspark/element_spark_%s.txt", planId)
	}

	local assetsList = {}

	table.insert(assetsList, self._sceneBgResUrls)
	table.insertto(assetsList, self._stageResUrls)

	self._resLoader = MultiResLoader.New()

	self._resLoader:setResPaths(assetsList)
	self._resLoader:load(self._onStageResourceLoaded, nil, self)
	GlobalDispatcher:dispatch(GlobalNotify.SceneStartLoaded)
end

function ElementSparkSceneStage:unload()
	ElementSparkSceneStage.super.unload(self)
	self:_unloadBg()
end

function ElementSparkSceneStage:getCameraSize()
	local scale = self:_getCameraSizeScale()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()
	local camSizeH = mainCam.orthographicSize * 2
	local camSizeW = mainCam.aspect * camSizeH
	local camDetSizeW = camSizeW * scale
	local camDetSizeH = camSizeH * scale

	self.wholeScene:SetDetector(mainCam.gameObject, camDetSizeW, camDetSizeH)
	self.wholeScene:SetTerrainDetector(mainCam.gameObject, camDetSizeW * 2, camDetSizeH * 2, camDetSizeW, camDetSizeH)

	return camSizeH, camSizeW, camDetSizeW, camDetSizeH
end

function ElementSparkSceneStage:_onStageResourceLoaded()
	self:_buildSceneBg()
	ElementSparkSceneStage.super._onStageResourceLoaded(self)
end

function ElementSparkSceneStage:_buildSceneBg()
	local res = rescache:GetResourceNoLoadIfNotExists(self._sceneBgResUrls)

	if res then
		local asset = res:GetMainAsset()

		if asset then
			self._bgGo = goutil.clone(asset, "elementSparkSceneBg")

			GoUtil.SetSortingOrder(self._bgGo, -5000)

			local ltx, lty, lbx, lby, rtx, rty, rbx, rby = ElementSparkSceneController.instance:getVectexPos()
			local x = (rtx - lbx) / 2
			local y = (lty - rby) / 2
			local scale = x * 2 / 12.8 + 2

			Framework.TransformUtil.SetLocalScale(self._bgGo.transform, 16 * scale, 7.2 * scale, 1)
			Framework.TransformUtil.SetPos(self._bgGo.transform, x, y, 0)
		end
	end
end

function ElementSparkSceneStage:_unloadBg()
	if self._bgGo then
		goutil.destroy(self._bgGo)
	end

	self._bgGo = nil
end

return ElementSparkSceneStage
