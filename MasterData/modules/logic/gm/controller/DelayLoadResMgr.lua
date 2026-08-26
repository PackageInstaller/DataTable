-- chunkname: @modules/logic/gm/controller/DelayLoadResMgr.lua

module("modules.logic.gm.controller.DelayLoadResMgr", package.seeall)

local ResObj = class("ResObj")

ResObj.Stage = {
	Using = 2,
	Callbacking = 3,
	InPool = 4,
	Init = 1
}

function ResObj:ctor()
	self.stage = ResObj.Stage.Init
	self.resUrl = nil
	self.startLoadTime = nil
	self.startLoadFrame = nil
	self.realLoadedTime = nil
	self.delayTime = nil
	self.assetItem = nil
	self.callbackList = {}
end

function ResObj:init(resUrl, startLoadTime, startLoadFrame)
	self.stage = ResObj.Stage.Using
	self.resUrl = resUrl
	self.startLoadTime = startLoadTime
	self.startLoadFrame = startLoadFrame
end

function ResObj:addCallback(cb, cbObj)
	if self.stage ~= ResObj.Stage.Using then
		logError("【add】 callback error, cur stage : " .. self.stage)

		return
	end

	local resCallbackObj = DelayLoadResMgr.instance:getResCallbackObj(cb, cbObj)

	table.insert(self.callbackList, resCallbackObj)
end

function ResObj:removeCallback(cb, cbObj)
	if self.stage ~= ResObj.Stage.Using then
		logError("【remove】 callback error, cur stage : " .. self.stage)

		return
	end

	for i = #self.callbackList, 1, -1 do
		local resCallbackObj = self.callbackList[i]

		if resCallbackObj.callback == cb and resCallbackObj.callbackObj == cbObj then
			DelayLoadResMgr.instance:recycleResCallbackObj(resCallbackObj)
			table.remove(self.callbackList, i)
		end
	end
end

function ResObj:hadAnyOneCallback()
	return #self.callbackList > 0
end

function ResObj:doCallbackAddRecycle()
	self.stage = ResObj.Stage.Callbacking

	for _, resCallbackObj in ipairs(self.callbackList) do
		::label_6_1::
	end

	DelayLoadResMgr.instance:recycleResObj(self)
end

function ResObj:setAssetItem(assetItem)
	local oldAsstet = assetItem

	self.assetItem = assetItem

	if assetItem then
		assetItem:Retain()
	end

	if oldAsstet then
		oldAsstet:Release()
	end
end

function ResObj:reset()
	self.stage = ResObj.Stage.InPool
	self.resUrl = nil
	self.startLoadTime = nil
	self.startLoadFrame = nil
	self.realLoadedTime = nil
	self.delayTime = nil

	if self.assetItem then
		self.assetItem:Release()
	end

	self.assetItem = nil

	for _, resCallbackObj in ipairs(self.callbackList) do
		DelayLoadResMgr.instance:recycleResCallbackObj(resCallbackObj)
	end

	tabletool.clear(self.callbackList)
end

local DelayLoadResMgr = class("DelayLoadResMgr")

DelayLoadResMgr.DelayStrategyEnum = {
	Multiple = 1,
	Fixed = 2
}
DelayLoadResMgr.DelayStrategyName = {
	[DelayLoadResMgr.DelayStrategyEnum.Multiple] = "延长倍数",
	[DelayLoadResMgr.DelayStrategyEnum.Fixed] = "延长固定时间"
}

function DelayLoadResMgr:ctor()
	self.srcLoadAbAsset = loadAbAsset
	self.srcLoadNonAbAsset = loadNonAbAsset
	self.srcLoadPersistentRes = loadPersistentRes
	self.srcRemoveAssetLoadCb = removeAssetLoadCb
	self.loadingResDict = {}
	self.loadedResDict = {}
	self.doingCallbackList = {}
	self.resPool = {}
	self.callbackObjPool = {}
	self.enablePatternList = {}
	self.disablePatternList = {
		"ui/viewres/"
	}
	self.strategy = DelayLoadResMgr.DelayStrategyEnum.Multiple
	self.strategyValue = 2
	self.frameHandle = UpdateBeat:CreateListener(self._onFrame, self)
end

function DelayLoadResMgr:setDelayStrategy(strategy)
	self.strategy = strategy
end

function DelayLoadResMgr:getDelayStrategy()
	return self.strategy
end

function DelayLoadResMgr:setDelayStrategyValue(value)
	self.strategyValue = value
end

function DelayLoadResMgr:getDelayStrategyValue()
	return self.strategyValue
end

function DelayLoadResMgr:setEnablePatternList(list)
	tabletool.clear(self.enablePatternList)

	for _, value in ipairs(list) do
		if not string.nilorempty(value) then
			self.enablePatternList[#self.enablePatternList + 1] = value
		end
	end
end

function DelayLoadResMgr:setDisablePatternList(list)
	tabletool.clear(self.disablePatternList)

	for _, value in ipairs(list) do
		if not string.nilorempty(value) then
			self.disablePatternList[#self.disablePatternList + 1] = value
		end
	end
end

function DelayLoadResMgr:getEnablePatternList()
	return self.enablePatternList
end

function DelayLoadResMgr:getDisablePatternList()
	return self.disablePatternList
end

function DelayLoadResMgr:startDelayLoad()
	self.start = true

	setGlobal("loadAbAsset", DelayLoadResMgr.LoadAbAssetWrap)
	setGlobal("loadNonAbAsset", DelayLoadResMgr.LoadNonAbAssetWrap)
	setGlobal("loadPersistentRes", DelayLoadResMgr.LoadPersistentResWrap)
	setGlobal("removeAssetLoadCb", DelayLoadResMgr.RemoveAssetLoadCbWrap)
	UpdateBeat:AddListener(self.frameHandle)
end

function DelayLoadResMgr:stopDelayLoad()
	for _, resObj in pairs(self.loadingResDict) do
		self:recycleResObj(resObj)
	end

	for _, resObj in pairs(self.loadedResDict) do
		self:recycleResObj(resObj)
	end

	for _, resObj in ipairs(self.doingCallbackList) do
		self:recycleResObj(resObj)
	end

	tabletool.clear(self.loadingResDict)
	tabletool.clear(self.loadedResDict)
	tabletool.clear(self.doingCallbackList)

	self.start = false

	setGlobal("loadAbAsset", self.srcLoadAbAsset)
	setGlobal("loadNonAbAsset", self.srcLoadNonAbAsset)
	setGlobal("loadPersistentRes", self.srcLoadPersistentRes)
	setGlobal("removeAssetLoadCb", self.srcRemoveAssetLoadCb)
	UpdateBeat:RemoveListener(self.frameHandle)
end

function DelayLoadResMgr:getResObj()
	if #self.resPool > 0 then
		return table.remove(self.resPool)
	end

	return ResObj.New()
end

function DelayLoadResMgr:recycleResObj(obj)
	obj:reset()
	table.insert(self.resPool, obj)
end

function DelayLoadResMgr:recycleResCallbackObj(resCallbackObj)
	tabletool.clear(resCallbackObj)
	table.insert(self.callbackObjPool, resCallbackObj)
end

function DelayLoadResMgr:getResCallbackObj(callback, callbackObj)
	local resCallbackObj = #self.callbackObjPool > 0 and table.remove(self.callbackObjPool) or {}

	resCallbackObj.callback = callback
	resCallbackObj.callbackObj = callbackObj

	return resCallbackObj
end

function DelayLoadResMgr:isStartDelayLoad()
	return self.start
end

function DelayLoadResMgr:getLoadingResObj(resUrl)
	return self.loadingResDict[resUrl]
end

function DelayLoadResMgr:addLoadingResObj(resObj)
	self.loadingResDict[resObj.resUrl] = resObj
end

function DelayLoadResMgr:removeLoadingResObj(resObj)
	self.loadingResDict[resObj.resUrl] = nil
end

function DelayLoadResMgr:getLoadedResObj(resUrl)
	return self.loadedResDict[resUrl]
end

function DelayLoadResMgr:addLoadedResObj(resObj)
	self.loadedResDict[resObj.resUrl] = resObj
end

function DelayLoadResMgr:removeLoadedResObj(resObj)
	self.loadedResDict[resObj.resUrl] = nil
end

function DelayLoadResMgr:checkNeedDelay(assetUrl)
	if not self.start then
		return false
	end

	if self:checkIsDisableFile(assetUrl) then
		return false
	end

	if #self.enablePatternList <= 0 then
		return true
	end

	for _, pattern in ipairs(self.enablePatternList) do
		if string.match(assetUrl, pattern) then
			return true
		end
	end

	return false
end

function DelayLoadResMgr:checkIsDisableFile(assetUrl)
	for _, pattern in ipairs(self.disablePatternList) do
		if string.match(assetUrl, pattern) then
			return true
		end
	end

	return false
end

function DelayLoadResMgr:getDelayTime(resObj)
	if not self.start then
		return 0
	end

	if self.strategy == DelayLoadResMgr.DelayStrategyEnum.Fixed then
		return self.strategyValue
	else
		return (resObj.realLoadedTime - resObj.startLoadTime) * self.strategyValue
	end
end

function DelayLoadResMgr:_onFrame()
	local curTime = UnityEngine.Time.time

	tabletool.clear(self.doingCallbackList)

	for _, resObj in pairs(self.loadedResDict) do
		if resObj.realLoadedTime and curTime - resObj.realLoadedTime >= resObj.delayTime then
			table.insert(self.doingCallbackList, resObj)
		end
	end

	for _, resObj in ipairs(self.doingCallbackList) do
		self:removeLoadedResObj(resObj)
		resObj:doCallbackAddRecycle()
	end
end

function DelayLoadResMgr:loadAssetBase(assetUrl, loadedCb, loadedObj)
	DelayLoadResMgr.log("load Asset Base : " .. assetUrl)

	local resObj = self:getLoadingResObj(assetUrl)
	local hadResObj = resObj ~= nil

	if not hadResObj then
		resObj = self:getResObj()

		resObj:init(assetUrl, UnityEngine.Time.time, UnityEngine.Time.frameCount)
		self:addLoadingResObj(resObj)
	end

	resObj:addCallback(loadedCb, loadedObj)

	return hadResObj
end

function DelayLoadResMgr.LoadAbAssetWrap(assetUrl, needPreload, loadedCb, loadedObj)
	local hadResObj = DelayLoadResMgr.instance:loadAssetBase(assetUrl, loadedCb, loadedObj)

	if not hadResObj then
		DelayLoadResMgr.instance.srcLoadAbAsset(assetUrl, needPreload, DelayLoadResMgr.onLoadAssetDone)
	end
end

function DelayLoadResMgr.LoadNonAbAssetWrap(assetUrl, assetType, loadedCb, loadedObj)
	local hadResObj = DelayLoadResMgr.instance:loadAssetBase(assetUrl, loadedCb, loadedObj)

	if not hadResObj then
		DelayLoadResMgr.instance.srcLoadNonAbAsset(assetUrl, assetType, DelayLoadResMgr.onLoadAssetDone)
	end
end

function DelayLoadResMgr.LoadPersistentResWrap(fullUrl, assetType, loadedCb, loadedObj)
	local hadResObj = DelayLoadResMgr.instance:loadAssetBase(fullUrl, loadedCb, loadedObj)

	if not hadResObj then
		DelayLoadResMgr.instance.srcLoadPersistentRes(fullUrl, assetType, DelayLoadResMgr.onLoadAssetDone)
	end
end

function DelayLoadResMgr.RemoveAssetLoadCbWrap(assetUrl, loadedCb, loadedObj)
	local resObj = DelayLoadResMgr.instance:getLoadedResObj(assetUrl)

	if resObj then
		DelayLoadResMgr.log("remove asset load : " .. assetUrl)
		resObj:removeCallback(loadedCb, loadedObj)
		DelayLoadResMgr.instance:tryRecycleResObj(resObj)
	end

	resObj = DelayLoadResMgr.instance:getLoadingResObj(assetUrl)

	if resObj then
		DelayLoadResMgr.log("remove asset load : " .. assetUrl)
		resObj:removeCallback(loadedCb, loadedObj)
		DelayLoadResMgr.instance:tryRecycleResObj(resObj)
	end
end

function DelayLoadResMgr:tryRecycleResObj(resObj)
	if not resObj:hadAnyOneCallback() then
		DelayLoadResMgr.instance:removeLoadingResObj(resObj)
		DelayLoadResMgr.instance:recycleResObj(resObj)
		DelayLoadResMgr.instance.srcRemoveAssetLoadCb(resObj.resUrl, DelayLoadResMgr.onLoadAssetDone)
	end
end

function DelayLoadResMgr.onLoadAssetDone(assetItem)
	local resPath = assetItem.ResPath
	local resObj = DelayLoadResMgr.instance:getLoadingResObj(resPath)

	if not resObj then
		return
	end

	resObj:setAssetItem(assetItem)
	DelayLoadResMgr.instance:removeLoadingResObj(resObj)

	local curFrameCount = UnityEngine.Time.frameCount

	if curFrameCount == resObj.startLoadFrame then
		DelayLoadResMgr.log(string.format("%s 在同一帧加载完", resPath))
		resObj:doCallbackAddRecycle()

		return
	end

	if not DelayLoadResMgr.instance:checkNeedDelay(resPath) then
		DelayLoadResMgr.log(string.format("%s 不需要延迟", resPath))
		resObj:doCallbackAddRecycle()

		return
	end

	DelayLoadResMgr.instance:addLoadedResObj(resObj)

	resObj.realLoadedTime = UnityEngine.Time.time
	resObj.delayTime = DelayLoadResMgr.instance:getDelayTime(resObj)

	DelayLoadResMgr.log(string.format("%s 延迟了 %s 秒", resPath, resObj.delayTime))
end

function DelayLoadResMgr.log(text)
	logNormal("[DelayLoadResMgr] " .. (text or "") .. "\n" .. debug.traceback())
end

DelayLoadResMgr.instance = DelayLoadResMgr.New()

return DelayLoadResMgr
