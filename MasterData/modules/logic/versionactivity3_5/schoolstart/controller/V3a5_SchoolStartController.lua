-- chunkname: @modules/logic/versionactivity3_5/schoolstart/controller/V3a5_SchoolStartController.lua

module("modules.logic.versionactivity3_5.schoolstart.controller.V3a5_SchoolStartController", package.seeall)

local V3a5_SchoolStartController = class("V3a5_SchoolStartController", BaseController)

function V3a5_SchoolStartController:onInit()
	self._cachePopupViewList = {}
end

function V3a5_SchoolStartController:onInitFinish()
	return
end

function V3a5_SchoolStartController:addConstEvents()
	return
end

function V3a5_SchoolStartController:reInit()
	return
end

function V3a5_SchoolStartController:setRummageReward(viewName, param)
	self._cachePopupViewList = {}

	local list = {}

	for _, v in ipairs(param) do
		local o = MaterialDataMO.New()

		o:initValue(v.materilType, v.materilId, v.quantity, nil, nil, nil)
		table.insert(list, o)
	end

	table.insert(self._cachePopupViewList, 1, {
		viewName = viewName,
		param = list
	})
end

function V3a5_SchoolStartController:popupRewardView()
	for _, cacheTbl in ipairs(self._cachePopupViewList) do
		if cacheTbl.viewName == ViewName.CommonPropView then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, cacheTbl.viewName, cacheTbl.param)
		end
	end

	tabletool.clear(self._cachePopupViewList)
end

V3a5_SchoolStartController.instance = V3a5_SchoolStartController.New()

return V3a5_SchoolStartController
