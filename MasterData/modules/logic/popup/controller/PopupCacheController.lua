-- chunkname: @modules/logic/popup/controller/PopupCacheController.lua

module("modules.logic.popup.controller.PopupCacheController", package.seeall)

local PopupCacheController = class("PopupCacheController", BaseController)

function PopupCacheController:onInit()
	return
end

function PopupCacheController:reInit()
	return
end

function PopupCacheController:addConstEvents()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._viewChangeCheckIsInMainView, self)
end

function PopupCacheController:_onOpenViewFinish(viewName)
	if viewName ~= ViewName.MainView then
		return
	end

	self:_viewChangeCheckIsInMainView()
end

function PopupCacheController:_viewChangeCheckIsInMainView()
	local cacheCount = PopupCacheModel.instance:getCount()

	if not cacheCount or cacheCount <= 0 then
		return
	end

	local isInMainView = MainController.instance:isInMainView()

	if not isInMainView then
		return
	end

	local isInGuide = PopupHelper.checkInGuide()

	if isInGuide then
		return
	end

	self:showCachePopupView()
end

function PopupCacheController:showCachePopupView()
	local popupParam = PopupCacheModel.instance:popNextPopupParam()

	if not popupParam then
		return
	end

	local customPopupFunc = popupParam.customPopupFunc

	if customPopupFunc then
		popupParam:customPopupFunc()
	else
		self:defaultShowCommonPropView(popupParam)
	end
end

function PopupCacheController:defaultShowCommonPropView(param)
	local co = param and param.materialDataMOList

	if not co then
		return
	end

	RoomController.instance:popUpRoomBlockPackageView(co)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
end

function PopupCacheController:tryCacheGetPropView(getApproach, param)
	if type(param) ~= "table" then
		logError(string.format("PopupCacheController:tryCacheGetPropView error, need table param"))

		return false
	end

	local result = false

	if getApproach then
		if not PopupEnum.CheckCacheGetApproach[getApproach] then
			local checkList = {}

			for _, cacheType in ipairs(checkList) do
				local checkHandler = PopupEnum.CheckCacheHandler[cacheType]
				local needCache = checkHandler and checkHandler() or false

				if needCache then
					param.cacheType = cacheType

					PopupCacheModel.instance:recordCachePopupParam(param)

					result = true

					break
				end
			end

			return result
		end
	end
end

PopupCacheController.instance = PopupCacheController.New()

return PopupCacheController
