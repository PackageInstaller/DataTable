-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/facade/LoadingFacade.lua

module("logic.extensions.loading.facade.LoadingFacade", package.seeall)

local LoadingFacade = class("LoadingFacade", BaseFacade)
local kLoadingViewName = ViewName.LoadingView
local kLoadingBlackViewName = ViewName.LoadingBlackView
local kWaitingViewName = "waiting_view"

function LoadingFacade:init()
	ViewMgr.instance:preCreate(kLoadingViewName)
	ViewMgr.instance:preCreate(kWaitingViewName)
	ViewMgr.instance:preCreate(kLoadingBlackViewName)
	MarqueeFacade.instance:init()
	SecretFacade.instance:init()
	GlobalDispatcher:addEventListener(EventType.FW_VIEW_CLOSE_EVENT, self._handleViewCloseEvent, self, 100)

	self._waitingSignal = SignalAmount.New()
	self._resLoader = MultiResLoader.New()
	self._isLoading = false
	self._resDict = {}

	self:prepareLoadingImages()
end

function LoadingFacade:prepareLoadingImages()
	local allConfig = LoadingConfig.instance:getAllLoadingConfig()
	local resPaths = {}

	for k, v in pairs(allConfig) do
		table.insert(resPaths, GameUrl.getBigBgUrlByPrefix("loading", v.bgName))
	end

	local resLoader = self._resLoader

	resLoader:setResPaths(resPaths)
	resLoader:load(self._onAllImageLoaded, self._onImageLoaded, self)
end

function LoadingFacade:_onImageLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._resDict[res.ResPath] = res
	end
end

function LoadingFacade:_onAllImageLoaded(loader)
	self._resLoader:clear()
end

function LoadingFacade:getRes(resPath)
	return self._resDict[resPath]
end

function LoadingFacade:getAsset(resPath)
	return self:getRes(resPath):GetAsset(nil, nil)
end

function LoadingFacade:clear()
	self._waitingSignal:clear()
	self._resLoader:clear()
end

function LoadingFacade:isLoading()
	return self._isLoading
end

function LoadingFacade:isLoadingSignActive()
	return self._visibleSign
end

function LoadingFacade:_setLoadingSign(add)
	self._visibleSign = add
end

function LoadingFacade:_setIsLoading(isLoading)
	self._isLoading = isLoading
end

function LoadingFacade:_handleViewCloseEvent(e, viewName, opTyp)
	if not self:isLoading() then
		return
	end

	if viewName == kLoadingViewName or viewName == kLoadingBlackViewName then
		self:_setIsLoading(false)
	end
end

function LoadingFacade:showLoading(isShowBlack)
	if self:isLoadingSignActive() then
		return
	end

	self:_setIsLoading(true)
	self:_setLoadingSign(true)

	if isShowBlack then
		ViewMgr.instance:openSpecialView(kLoadingBlackViewName)
	else
		local info = LoadingConfig.instance:getRandomLoadingConfig()

		ViewMgr.instance:openSpecialView(kLoadingViewName, info)
	end
end

function LoadingFacade:showLoadingById(configId)
	if self:isLoadingSignActive() then
		return
	end

	self:_setIsLoading(true)
	self:_setLoadingSign(true)

	local info = LoadingConfig.instance:getLoadingConfigById(configId)

	ViewMgr.instance:openSpecialView(kLoadingViewName, info)
end

function LoadingFacade:showLoadingByInfo(info, param)
	if not info then
		return
	end

	if self:isLoadingSignActive() then
		return
	end

	self:_setIsLoading(true)
	self:_setLoadingSign(true)
	ViewMgr.instance:openSpecialView(kLoadingViewName, info, param)
end

function LoadingFacade:hideLoading()
	if ViewMgr.instance:isOpen(kLoadingViewName) then
		ViewMgr.instance:close(kLoadingViewName, false, WindowType.WindowCloseReasonType.NormalCloseType, false)
	elseif ViewMgr.instance:isOpen(kLoadingBlackViewName) then
		ViewMgr.instance:close(kLoadingBlackViewName, false, WindowType.WindowCloseReasonType.NormalCloseType, false)
	end

	self:_setLoadingSign(false)
end

function LoadingFacade:showWaiting(key, showImmediately)
	self._waitingSignal:addUnique(key or kWaitingViewName)

	if self._waitingSignal:isActive() then
		ViewMgr.instance:open(kWaitingViewName, showImmediately)
	end
end

function LoadingFacade:hideWaiting(key)
	self._waitingSignal:remove(key or kWaitingViewName)

	if not self._waitingSignal:isActive() then
		ViewMgr.instance:close(kWaitingViewName)
	end
end

LoadingFacade.instance = LoadingFacade.New()

return LoadingFacade
