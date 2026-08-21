-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Load\\DoLoadScene.lua

local LoaderFactory = Framework.Resource.LoaderFactory
local DoLoadBase = require("System/Load/DoLoadBase")
local EventConst = require("EventConst")
local PerformanceMonitor = require("SDK/Plugin/PerformanceMonitor")
local strClassName = "DoLoadScene"
local DoLoadScene = Class(strClassName, DoLoadBase)

function DoLoadScene:ctor(mgr, scenePath)
	self._mgr = mgr
	self._path = scenePath
	self.mIsLoad = true
	self.mSceneID = nil
	self.mLoadedAndUnload = false
	self._slot4Loaded = Slot(self.onLoadComplete, self)
	self._slot4Unloaded = Slot(self.onUnloadComplete, self)
end

function DoLoadScene:start()
	self.mCurRate = 0

	self._mgr.onDoSceneStart(self)

	if self.mIsLoad then
		if self._loader == nil then
			self._loader = LoaderFactory.LoadScene(self._path, Framework.Resource.LoaderMode.Async, self._slot4Loaded)
		else
			self:onLoadComplete()
		end

		if RegionUtils.isJP() then
			PerformanceMonitor.LogSceneStart(self._path)
		end
	else
		EventCenter.sendEvent(EventConst.SCENE_UNLOAD, self.mSceneID)
		LoaderFactory.UnloadSceneAsync(self._loader, self._slot4Unloaded)

		self._loader = nil

		if RegionUtils.isJP() then
			PerformanceMonitor.LogSceneEnd()
		end
	end
end

function DoLoadScene:checkRate()
	if self.mIsLoad and self.mCurRate < 1 then
		self.mCurRate = math.min(self._loader.Progress, 1) * 0.9
	end
end

function DoLoadScene:onLoadComplete()
	if self.mLoadedAndUnload then
		self.mLoadedAndUnload = false

		if self._loader then
			self.mIsLoad = false

			LoaderFactory.UnloadSceneAsync(self._loader, self._slot4Unloaded)

			self._loader = nil
		end

		return
	end

	self.mCurRate = 1

	SceneManager.initArenaRank()
	SceneManager.initTopPvpRank()
	self._mgr.onDoSceneEnd(self)

	if RegionUtils.isJP() then
		PerformanceMonitor.LogSceneLoaded()
	end
end

function DoLoadScene:onUnloadComplete()
	self.mCurRate = 1

	self._mgr.onDoSceneEnd(self)
end

return DoLoadScene
