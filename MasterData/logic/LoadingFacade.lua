-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/loading/facade/LoadingFacade.lua

module(..., package.seeall)

local LoadingFacade = class("LoadingFacade", BaseFacade)

function LoadingFacade:ctor()
	self._loadingViewCls = {}
	self._loadingViewCache = {}
	self._curLoadingView = nil
	self._isLoading = false
	self._loadFinishListener = nil
	self._loadFinishListenerObj = nil

	self:_initViewCls()
end

function LoadingFacade:setLoadingListener(listener, listenerObj)
	self._loadFinishListener = listener
	self._loadFinishListenerObj = listenerObj
end

function LoadingFacade:invokeLoadingListener()
	local loadFinishListener = self._loadFinishListener
	local listenerObj = self._loadFinishListenerObj

	self._loadFinishListener = nil
	self._loadFinishListenerObj = nil

	if loadFinishListener then
		if listenerObj then
			self._loadFinishListener(listenerObj)
		else
			loadFinishListener()
		end
	end
end

function LoadingFacade:_initViewCls()
	self:_registerView(LoadingType.Scene, LoadingView)
end

function LoadingFacade:isLoading()
	return self._isLoading
end

function LoadingFacade:setAutoRandomTipsEnum(randomTipsEnum)
	if not self._curLoadingView then
		return
	end

	self._curLoadingView.autoRandomTips:setLoadingTipsType(randomTipsEnum)
end

function LoadingFacade:showLoading(loadingType, isClear)
	if self._isLoading == true then
		printWarn("正在Loading中........................")

		return
	end

	local loadingView = self._loadingViewCache[loadingType]

	if not loadingView then
		loadingView = self:_createView(loadingType)
		self._loadingViewCache[loadingType] = loadingView
	end

	if self._curLoadingView and self._curLoadingView ~= loadingView then
		self._curLoadingView:close()
	end

	isClear = isClear or false

	loadingView:show(isClear)

	self._curLoadingView = loadingView
	self._isLoading = true
end

function LoadingFacade:hideLoading()
	if not self._curLoadingView then
		return
	end

	self._curLoadingView:hide()

	self._isLoading = false
end

function LoadingFacade:closeLoading()
	if not self._curLoadingView then
		return
	end

	self._curLoadingView:close()

	self._isLoading = false
end

function LoadingFacade:setTargetProgress(value)
	if not self._curLoadingView then
		printError("self._curLoadingView is nil.")

		return
	end

	self._curLoadingView:setTargetProgress(value)
end

function LoadingFacade:setLoadingTips(tips)
	if not self._curLoadingView then
		return
	end

	self._curLoadingView:setLoadingTips(tips)
end

function LoadingFacade:_createView(loadingType)
	local viewCls = self._loadingViewCls[loadingType]
	local viewGo = viewCls.createMainView(loadingType)
	local root = ViewMgr.instance:getRoot(ViewRootType.TopMost)

	goutil.addChildToParent(viewGo, root)

	return Framework.LuaComponentContainer.Add(viewGo, viewCls)
end

function LoadingFacade:_registerView(loadingType, viewCls)
	self._loadingViewCls[loadingType] = viewCls
end

LoadingFacade.instance = LoadingFacade.New()

return LoadingFacade
