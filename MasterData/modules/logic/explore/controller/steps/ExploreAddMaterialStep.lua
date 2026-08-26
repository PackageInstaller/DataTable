-- chunkname: @modules/logic/explore/controller/steps/ExploreAddMaterialStep.lua

module("modules.logic.explore.controller.steps.ExploreAddMaterialStep", package.seeall)

local ExploreAddMaterialStep = class("ExploreAddMaterialStep", ExploreStepBase)

function ExploreAddMaterialStep:onStart()
	local dataList = {}

	for i = 1, #self._data.materialData do
		dataList[i] = cjson.decode(self._data.materialData[i])
	end

	ExploreController.instance:addItem(dataList)

	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
	else
		self:onDone()
	end
end

function ExploreAddMaterialStep:checkHavePopup()
	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		-- block empty
	else
		self:onDone()
	end
end

function ExploreAddMaterialStep:onDestory()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.checkHavePopup, self)
	ExploreAddMaterialStep.super.onDestory(self)
end

return ExploreAddMaterialStep
