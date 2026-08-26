-- chunkname: @modules/logic/versionactivity2_8/act197/controller/Activity197Controller.lua

module("modules.logic.versionactivity2_8.act197.controller.Activity197Controller", package.seeall)

local Activity197Controller = class("Activity197Controller", BaseController)

function Activity197Controller:onInit()
	self._cachePopupViewList = {}
end

function Activity197Controller:onInitFinish()
	return
end

function Activity197Controller:openView()
	return
end

function Activity197Controller:addConstEvents()
	return
end

function Activity197Controller:reInit()
	self:onInit()
end

function Activity197Controller:setRummageReward(viewName, param)
	table.insert(self._cachePopupViewList, 1, {
		viewName = viewName,
		param = param
	})
end

function Activity197Controller:popupRewardView()
	for _, cacheTbl in ipairs(self._cachePopupViewList) do
		if cacheTbl.viewName == ViewName.CommonPropView then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, cacheTbl.viewName, cacheTbl.param)
		end
	end

	tabletool.clear(self._cachePopupViewList)
end

Activity197Controller.instance = Activity197Controller.New()

return Activity197Controller
