-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicstarter/starter/preload/CommonPreloader.lua

module("logicstarter.starter.preload.CommonPreloader", package.seeall)

local CommonPreloader = class("CommonPreloader")

function CommonPreloader:ctor()
	self._resDict = {}
	self._preloading = false
	self._basicLoader = MultiResLoader.New()
	self._baiscResPaths = {}
	self._additionalLoader = MultiResLoader.New()
	self._additionalResPaths = {}
	self._basicFinishCallback = nil
	self._basicFinishObj = nil
	self._additionalFinishCallback = nil
	self._additionalFinishObj = nil
	self._skinLibAssetsCache = {}
end

function CommonPreloader:loadBasic(finishCallback, finishObj)
	self._basicFinishCallback = finishCallback
	self._basicFinishObj = finishObj

	local preLoadFlags

	if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		table.insertto(self._baiscResPaths, CommonResPath.skinlib)
		table.insertto(self._baiscResPaths, CommonResPath.config)
		table.insert(self._baiscResPaths, CommonResPath.MainPlayerShadow)
	else
		local basicForAb = CommonResPath.basicForAb

		table.insertto(self._baiscResPaths, basicForAb)

		preLoadFlags = {}

		for i = 1, #basicForAb do
			table.insert(preLoadFlags, false)
		end
	end

	table.insertto(self._baiscResPaths, CommonResPath.basic)
	table.insertto(self._baiscResPaths, CommonResPath.loginviewAssets)
	table.insertto(self._baiscResPaths, CommonResPath.sceneMisc)
	BootstrapLoadingView.startLoadingProgress(BootstrapLanguage.a13 .. "%d%%", self._onLoadingUIFinish, self)
	self._basicLoader:setResPaths(self._baiscResPaths, preLoadFlags)
	self._basicLoader:load(self._onAllBasicLoaded, self._onBasicLoaded, self)
end

function CommonPreloader:_onBasicLoaded(res)
	local progress = self._basicLoader.loadedCount / self._basicLoader.totalCount

	BootstrapLoadingView.setProgressPersentVal(progress)

	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res

		if res.ResPath == "shaders" then
			for _, path in ipairs(CommonResPath.shaders) do
				local shader = res:GetAsset(path, nil)

				if shader then
					Framework.ShaderCache.AddShader(shader)
				end
			end
		elseif res.ResPath == "skillconfig" or res.ResPath == "storyconfig" then
			AMPlayer.PrepareTakeResources(res)
		end
	end
end

function CommonPreloader:_onLoadingUIFinish()
	self._loadingUIFinished = true

	self:_checkAllBasicLoaded()
end

function CommonPreloader:_onAllBasicLoaded(loader)
	self._basicLoader:clear()

	self._isAllBasicLoaded = true

	self:_checkAllBasicLoaded()
end

function CommonPreloader:_checkAllBasicLoaded()
	if not self._isAllBasicLoaded or not self._loadingUIFinished then
		return
	end

	if self._basicFinishCallback then
		self._basicFinishCallback(self._basicFinishObj)
	end

	self._basicFinishCallback = nil
	self._basicFinishObj = nil
end

function CommonPreloader:loadAdditional(finishCallback, finishObj)
	self._additionalFinishCallback = finishCallback
	self._additionalFinishObj = finishObj

	table.insertto(self._additionalResPaths, CommonResPath.additional)

	if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		table.insert(self._additionalResPaths, CommonResPath.BattleStartAnim)
	end

	table.insertto(self._additionalResPaths, CommonResPath.battle)
	table.insertto(self._additionalResPaths, CommonResPath.sceneHuds)
	table.insertto(self._additionalResPaths, CommonResPath.airwalls)
	self._additionalLoader:setResPaths(self._additionalResPaths)
	self._additionalLoader:load(self._onAllAdditionalLoaded, self._onAdditionalLoaded, self)
end

function CommonPreloader:setAdditionalCallback(finishCallback, finishObj)
	self._additionalFinishCallback = finishCallback
	self._additionalFinishObj = finishObj
end

function CommonPreloader:isAllAdditionalLoaded()
	return self._isAllAdditionalLoaded
end

function CommonPreloader:_onAdditionalLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function CommonPreloader:_onAllAdditionalLoaded(loader)
	self._additionalLoader:clear()

	self._isAllAdditionalLoaded = true

	if self._additionalFinishCallback then
		self._additionalFinishCallback(self._additionalFinishObj)
	end

	self._additionalFinishCallback = nil
	self._additionalFinishObj = nil
end

function CommonPreloader:isPreLoading()
	return self._preloading
end

function CommonPreloader:setPreCreateFrequentViewsDone(_viewName)
	if not self._preloadViews then
		return
	end

	if self:isViewPreLoadDone(_viewName) then
		return
	end

	local index = table.indexof(CommonResPath.frequentViews, _viewName)

	if index then
		self._preloadViews[_viewName] = nil

		if table.nums(self._preloadViews) == 0 then
			self._preloading = false
		end
	end
end

function CommonPreloader:isViewPreLoadDone(_viewName)
	return not self._preloadViews or not self._preloadViews[_viewName]
end

function CommonPreloader:preCreateFrequentViews()
	self._preloading = true
	self._preloadViews = {}

	local views = CommonResPath.frequentViews

	for i = 1, #views do
		self._preloadViews[views[i]] = true

		ViewMgr.instance:preCreate(views[i], nil, function(_viewName)
			self:setPreCreateFrequentViewsDone(_viewName)
		end)
	end
end

function CommonPreloader:removeLoginAnimAssets()
	if self._removeLoginAnimAssets then
		return
	end

	self._removeLoginAnimAssets = true

	for i = 1, #CommonResPath.loginviewAssets do
		self:removeRes(CommonResPath.loginviewAssets[i])
	end
end

function CommonPreloader:removeRes(resPath)
	local res = self._resDict[resPath]

	if res then
		res:Release()

		self._resDict[resPath] = nil
	end
end

function CommonPreloader:getRes(resPath)
	return self._resDict[resPath]
end

function CommonPreloader:getAsset(resPath)
	local asset
	local res = self._resDict[resPath]

	return (res or nil) and res:GetAsset(nil, nil)
end

function CommonPreloader:getSkinlibAsset(resPath)
	local res, asset

	if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		res = self._resDict[resPath]
		asset = self._resDict[resPath]:GetAsset(nil, nil)
	else
		asset = self._skinLibAssetsCache[resPath]

		if not self._skinLibAssetsCache[resPath] then
			asset = self._resDict["ui/skinlib"]:GetAsset(resPath, nil)
			self._skinLibAssetsCache[resPath] = asset
		end
	end

	return asset
end

function CommonPreloader:getConfigAsset(resPath)
	local res, asset

	if rescache.resLoadMode == Framework.ResourceLoadMode.Direct then
		res = self._resDict[resPath]
		asset = self._resDict[resPath]:GetAsset(nil, nil)
	else
		asset = self._resDict.config:GetAsset(resPath, nil)
	end

	return asset
end

function CommonPreloader:clearResPathData()
	return
end

CommonPreloader.instance = CommonPreloader.New()

return CommonPreloader
