-- chunkname: @modules/common/preload/ConstResLoader.lua

module("modules.common.preload.ConstResLoader", package.seeall)

local ConstResLoader = class("ConstResLoader")

function ConstResLoader:ctor()
	self._loadFuncList = {
		self._initLive2d,
		self._loadConstAb,
		self._loadIconPrefab,
		self._loadAvProPrefab,
		self._loadVideoPlayerPrefab,
		self._loadUIBlockAnim,
		self._loadLoadingUIBg
	}
	self._loadIndex = nil
	self._finishCb = nil
	self._finishCbObj = nil
end

function ConstResLoader:startLoad(cb, cbObj)
	self._loadIndex = 0
	self._finishCb = cb
	self._finishCbObj = cbObj

	self:_loadShader()
end

function ConstResLoader:_loadShader()
	ShaderCache.instance:init(self._onShaderLoadFinish, self)
end

function ConstResLoader:_onShaderLoadFinish()
	BootLoadingView.instance:show(0.6, booterLang("loading_res"))
	self:_startLoadOthers()
end

function ConstResLoader:_startLoadOthers()
	for _, func in ipairs(self._loadFuncList) do
		func(self)

		self._loadIndex = self._loadIndex + 1
	end
end

function ConstResLoader:_onLoadFinish()
	local loadingCount = #self._loadFuncList
	local percent = 0.25 * (loadingCount - self._loadIndex) / loadingCount

	BootLoadingView.instance:show(0.6 + percent, booterLang("loading_res"))

	self._loadIndex = self._loadIndex - 1

	if self._loadIndex == 0 then
		self._finishCb(self._finishCbObj)
	end
end

function ConstResLoader:_initLive2d()
	if GameResMgr.IsFromEditorDir then
		self:_onLoadFinish()
	else
		ZProj.Live2dHelper.Init(self._onLoadFinish, self)
	end
end

function ConstResLoader:_loadConstAb()
	ConstAbCache.instance:startLoad(self._onLoadFinish, self)
end

function ConstResLoader:_loadIconPrefab()
	IconMgr.instance:preload(self._onLoadFinish, self)
end

function ConstResLoader:_loadAvProPrefab()
	AvProMgr.instance:preload(self._onLoadFinish, self)
end

function ConstResLoader:_loadVideoPlayerPrefab()
	VideoPlayerMgr.instance:preload(self._onLoadFinish, self)
end

function ConstResLoader:_loadUIBlockAnim()
	UIBlockMgrExtend.preload(self._onLoadFinish, self)
end

ConstResLoader.instance = ConstResLoader.New()

return ConstResLoader
