-- chunkname: @modules/logic/summonuiswitch/controller/SummonUISkinSwitchDisplayController.lua

module("modules.logic.summonuiswitch.controller.SummonUISkinSwitchDisplayController", package.seeall)

local SummonUISkinSwitchDisplayController = class("SummonUISkinSwitchDisplayController", BaseController)

function SummonUISkinSwitchDisplayController:onInit()
	self:reInit()
end

function SummonUISkinSwitchDisplayController:onInitFinish()
	return
end

function SummonUISkinSwitchDisplayController:addConstEvents()
	return
end

function SummonUISkinSwitchDisplayController:reInit()
	return
end

function SummonUISkinSwitchDisplayController:clear()
	if self._loaderMap then
		for k, v in pairs(self._loaderMap) do
			v:dispose()
		end

		tabletool.clear(self._loaderMap)
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

function SummonUISkinSwitchDisplayController:hasSceneRoot()
	return self._sceneRoot ~= nil
end

function SummonUISkinSwitchDisplayController:removeScene(sceneId, dispose)
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
end

function SummonUISkinSwitchDisplayController:initMaps()
	self._loaderMap = {}
	self._sceneNameMap = {}
end

function SummonUISkinSwitchDisplayController:setSceneRoot(root)
	self._sceneRoot = root

	local transform = self._sceneRoot.transform
	local childCount = transform.childCount

	for i = childCount - 1, 0, -1 do
		local scene = transform:GetChild(i)

		self._sceneNameMap[scene.name] = scene.gameObject
	end
end

function SummonUISkinSwitchDisplayController:hideScene()
	self._isShowScene = false
end

function SummonUISkinSwitchDisplayController:showCurScene()
	if not self._curSceneId then
		return
	end

	self:showScene(self._curSceneId, self._callback, self._callbackTarget)
end

local blockKey = "SummonUISkinSwitchDisplayController_showScene"

function SummonUISkinSwitchDisplayController:showScene(sceneId, callback, callbackTarget)
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

		loader:addPath(resPath)
		loader:startLoad(self._loadSceneFinish, self)
	end
end

function SummonUISkinSwitchDisplayController:_loadSceneFinish(loader)
	UIBlockHelper.instance:endBlock(blockKey)

	local sceneId = loader._sceneId
	local resPath, instName = self:_getSceneConfig(sceneId)
	local assetItem = loader:getFirstAssetItem()
	local sceneGo = gohelper.clone(assetItem:GetResource(resPath), self._sceneRoot)

	self._sceneNameMap[instName] = sceneGo

	local anim = gohelper.findChildComponent(sceneGo, "anim", gohelper.Type_Animator)

	anim.enabled = false

	transformhelper.setLocalPosXY(sceneGo.transform, 10000, 0)
	self:_showScene(instName)
end

function SummonUISkinSwitchDisplayController._onRoleBlendCallback(targeComps, weatherComp, value, isEnd)
	for i, v in ipairs(targeComps) do
		v:onRoleBlend(weatherComp, value, isEnd)
	end
end

function SummonUISkinSwitchDisplayController:_getSceneConfig(sceneId)
	local summonConfig = SummonUISwitchConfig.instance:getSummonSwitchConfig(sceneId)
	local resPath = summonConfig.resName
	local instName = "summonScene_" .. summonConfig.id

	return resPath, instName
end

function SummonUISkinSwitchDisplayController:getSceneGo(name)
	return self._sceneNameMap and self._sceneNameMap[name]
end

function SummonUISkinSwitchDisplayController:_showScene(name)
	logNormal("showScene name = ", name)

	for k, v in pairs(self._sceneNameMap) do
		local show = k == name

		gohelper.setActive(v, show)

		if show then
			transformhelper.setLocalPosXY(v.transform, 0, 0)
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

SummonUISkinSwitchDisplayController.instance = SummonUISkinSwitchDisplayController.New()

return SummonUISkinSwitchDisplayController
