-- chunkname: @modules/common/preload/ShaderCache.lua

module("modules.common.preload.ShaderCache", package.seeall)

local ShaderCache = class("ShaderCache")

function ShaderCache:ctor()
	self._resPath = "shaders"
	self._shaderVCs = {}
	self._hasWarmup = false
	self._curIdx = 1
end

function ShaderCache:init(initCb, initCbObj)
	self._initCb = initCb
	self._initCbObj = initCbObj

	if GameResMgr.IsFromEditorDir then
		self:_triggerFinishCb()

		return
	end

	loadAbAsset(self._resPath, false, self._onLoadOne, self)

	if isDebugBuild then
		SLFramework.TimeWatch.Instance:Start()
	end
end

function ShaderCache:_onLoadOne(assetItem)
	if isDebugBuild then
		logNormal("ShaderCache 加载AB耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
		SLFramework.TimeWatch.Instance:Start()
	end

	if assetItem.IsLoadSuccess then
		assetItem:Retain()

		local shaders = assetItem:GetAllResources()

		if isDebugBuild then
			logNormal("ShaderCache 加载shader及变体耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
		end

		for idx = 0, shaders.Length - 1 do
			local shaderObj = shaders[idx]

			if typeof(UnityEngine.ShaderVariantCollection) == shaderObj:GetType() then
				table.insert(self._shaderVCs, shaderObj)
			else
				ZProj.ShaderLib.Add(shaderObj)
			end
		end

		if HotUpdateMgr.instance.shouldHotUpdate then
			self:_warmupShaders()
		else
			self:_triggerFinishCb()

			if isDebugBuild then
				logNormal("ShaderCache 无热更新，跳过shader变体预热")
			end
		end

		return
	end

	logError("ShaderCache shader加载失败！")
end

function ShaderCache:_warmupShaders()
	if self._hasWarmup then
		return
	end

	self:_warmupOneShader()
end

function ShaderCache:_warmupOneShader()
	if isDebugBuild then
		SLFramework.TimeWatch.Instance:Start()
	end

	local shaderVC = self._shaderVCs[self._curIdx]

	shaderVC:WarmUp()
	BootLoadingView.instance:show(0.2 + self._curIdx / #self._shaderVCs * 0.4, booterLang("loading_res"))

	if isDebugBuild then
		logNormal("ShaderCache shader变体: " .. shaderVC.name .. " 预热耗时:" .. SLFramework.TimeWatch.Instance:Watch() .. " s!")
	end

	self._curIdx = self._curIdx + 1

	if self._curIdx <= #self._shaderVCs then
		TaskDispatcher.runDelay(self._warmupOneShader, self, 0.01)
	else
		self._hasWarmup = true

		self:_triggerFinishCb()
	end
end

function ShaderCache:_triggerFinishCb()
	if self._initCb then
		self._initCb(self._initCbObj)

		self._initCb = nil
		self._initCbObj = nil
	end
end

ShaderCache.instance = ShaderCache.New()

return ShaderCache
