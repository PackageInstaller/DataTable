-- chunkname: @modules/logic/mainsceneswitch/controller/MainSceneSwitchDisplayController.lua

module("modules.logic.mainsceneswitch.controller.MainSceneSwitchDisplayController", package.seeall)

local MainSceneSwitchDisplayController = class("MainSceneSwitchDisplayController", BaseController)

function MainSceneSwitchDisplayController:onInit()
	self:reInit()
end

function MainSceneSwitchDisplayController:onInitFinish()
	return
end

function MainSceneSwitchDisplayController:addConstEvents()
	return
end

function MainSceneSwitchDisplayController:reInit()
	return
end

function MainSceneSwitchDisplayController:clear()
	if self._loaderMap then
		for k, v in pairs(self._loaderMap) do
			v:dispose()
		end

		tabletool.clear(self._loaderMap)
	end

	if self._weatherCompMap then
		for k, v in pairs(self._weatherCompMap) do
			for _, comp in ipairs(v) do
				comp:onSceneClose()
			end
		end

		tabletool.clear(self._weatherCompMap)
	end

	if self._sceneNameMap then
		for k, v in pairs(self._sceneNameMap) do
			gohelper.destroy(v)
		end

		tabletool.clear(self._sceneNameMap)
	end

	self._sceneRoot = nil
	self._callback = nil
	self._callbackTarget = nil
	self._curSceneId = nil
end

function MainSceneSwitchDisplayController:hasSceneRoot()
	return self._sceneRoot ~= nil
end

function MainSceneSwitchDisplayController:removeScene(sceneId, dispose)
	local _, instName = self:_getSceneConfig(sceneId)

	if dispose then
		local go = self._sceneNameMap[instName]

		gohelper.destroy(go)
		gohelper.setActive(go, false)

		local loader = self._loaderMap[instName]

		if loader then
			loader:dispose()

			self._loaderMap[instName] = nil
		end
	end

	self._sceneNameMap[instName] = nil

	local compList = self._weatherCompMap[instName]

	if compList then
		for i, v in ipairs(compList) do
			v:onSceneClose()
		end

		self._weatherCompMap[instName] = nil
	end
end

function MainSceneSwitchDisplayController:initMaps()
	self._loaderMap = {}
	self._sceneNameMap = {}
	self._weatherCompMap = {}
end

function MainSceneSwitchDisplayController:setSceneRoot(root)
	self._sceneRoot = root

	local transform = self._sceneRoot.transform
	local childCount = transform.childCount

	for i = childCount - 1, 0, -1 do
		local scene = transform:GetChild(i)

		self._sceneNameMap[scene.name] = scene.gameObject
	end
end

function MainSceneSwitchDisplayController:hideScene()
	self._isShowScene = false

	if self._weatherCompMap then
		for k, list in pairs(self._weatherCompMap) do
			for _, v in pairs(list) do
				if v.onSceneHide then
					v:onSceneHide()
				end
			end
		end
	end
end

function MainSceneSwitchDisplayController:showCurScene()
	if not self._curSceneId then
		return
	end

	self:showScene(self._curSceneId, self._callback, self._calbackTarget)
end

local blockKey = "MainSceneSwitchDisplayController_showScene"

function MainSceneSwitchDisplayController:showScene(sceneId, callback, callbackTarget, params)
	self._curSceneId = sceneId
	self._isShowScene = true
	self._callback = callback
	self._callbackTarget = callbackTarget

	local resPath, instName = self:_getSceneConfig(sceneId)

	if self._sceneNameMap[instName] then
		self:_showScene(instName)

		return
	end

	local loader = self._loaderMap[instName]

	if not loader then
		UIBlockHelper.instance:startBlock(blockKey, 1)

		loader = MultiAbLoader.New()
		self._loaderMap[instName] = loader
		loader._sceneId = sceneId
		loader._sceneParams = params

		loader:addPath(resPath)
		loader:startLoad(self._loadSceneFinish, self)
	end
end

function MainSceneSwitchDisplayController:_loadSceneFinish(loader)
	UIBlockHelper.instance:endBlock(blockKey)

	local sceneId = loader._sceneId
	local params = loader._sceneParams
	local resPath, instName, resName = self:_getSceneConfig(sceneId)
	local assetItem = loader:getFirstAssetItem()
	local sceneGo = gohelper.clone(assetItem:GetResource(resPath), self._sceneRoot)

	self._sceneNameMap[instName] = sceneGo

	transformhelper.setLocalPosXY(sceneGo.transform, 10000, 0)

	if MainSceneSwitchEnum.getCustomSceneInfo[sceneId] then
		self:_showScene(instName)

		return
	end

	local yearComp = WeatherYearAnimationComp.New()
	local frameComp = WeatherFrameComp.New()
	local weatherComp = WeatherComp.New()
	local switchComp = WeatherSwitchComp.New()
	local eggContainerComp = WeatherEggContainerComp.New()
	local weatherEffectComp = WeatherSceneEffectComp.New()

	self._weatherCompMap[instName] = {
		weatherComp,
		yearComp,
		frameComp,
		switchComp,
		eggContainerComp,
		weatherEffectComp
	}

	switchComp:onInit(sceneId, weatherComp, params and params.reportId)
	eggContainerComp:onInit(sceneId)
	eggContainerComp:initSceneGo(sceneGo)
	weatherEffectComp:onInit(sceneId)
	weatherEffectComp:initSceneGo(sceneGo)
	yearComp:onInit()
	yearComp:initSceneGo(sceneGo)
	frameComp:onInit(sceneId)
	frameComp:initSceneGo(sceneGo)
	weatherComp:addRoleBlendCallback(self._onRoleBlendCallback, {
		frameComp,
		weatherEffectComp
	})
	weatherComp:setSceneResName(resName)
	weatherComp:onInit()
	weatherComp:setSceneId(sceneId)
	weatherComp.initSceneGo(weatherComp, sceneGo, function()
		self:_showScene(instName)
	end, weatherComp)
	weatherComp:addChangeReportCallback(eggContainerComp.onReportChange, eggContainerComp, true)
end

function MainSceneSwitchDisplayController._onRoleBlendCallback(targeComps, weatherComp, value, isEnd)
	for i, v in ipairs(targeComps) do
		v:onRoleBlend(weatherComp, value, isEnd)
	end
end

function MainSceneSwitchDisplayController:setSwitchCompContinue(sceneId, isContinue)
	local comp = self:getSwitchComp(sceneId)

	if not comp then
		return
	end

	if isContinue then
		comp:continue()
	else
		comp:pause()
	end
end

function MainSceneSwitchDisplayController:getSwitchComp(sceneId)
	local resPath, instName, resName = self:_getSceneConfig(sceneId)
	local map = self._weatherCompMap[instName]

	return map and map[4]
end

function MainSceneSwitchDisplayController:_getSceneConfig(sceneId)
	local sceneConfig = lua_scene_switch.configDict[sceneId]

	if not sceneConfig then
		local customSceneInfo = MainSceneSwitchEnum.getCustomSceneInfo[sceneId]

		return customSceneInfo[1], customSceneInfo[2], customSceneInfo[3]
	end

	local resName = sceneConfig.resName
	local resPath = ResUrl.getSceneRes(resName)
	local instName = resName .. "_p(Clone)"

	return resPath, instName, resName
end

function MainSceneSwitchDisplayController:getSceneGo(name)
	return self._sceneNameMap and self._sceneNameMap[name]
end

function MainSceneSwitchDisplayController:_showScene(name)
	for k, v in pairs(self._sceneNameMap) do
		local show = k == name

		if show then
			transformhelper.setLocalPosXY(v.transform, 0, 0)
		end
	end

	local showList

	for k, list in pairs(self._weatherCompMap) do
		local show = k == name and self._isShowScene

		if show then
			showList = list
		else
			for _, v in pairs(list) do
				if v.onSceneHide then
					v:onSceneHide()
				end
			end
		end
	end

	if showList then
		for _, v in pairs(showList) do
			if v.onSceneShow then
				v:onSceneShow()
			end
		end
	end

	local callback = self._callback
	local callbackTarget = self._callbackTarget

	if callback then
		self._callback(callbackTarget)
	end

	self._callback = nil
	self._callbackTarget = nil
end

MainSceneSwitchDisplayController.instance = MainSceneSwitchDisplayController.New()

return MainSceneSwitchDisplayController
