-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionOpenCommonPropView.lua

module("modules.logic.guide.controller.action.impl.GuideActionOpenCommonPropView", package.seeall)

local GuideActionOpenCommonPropView = class("GuideActionOpenCommonPropView", BaseGuideAction)

function GuideActionOpenCommonPropView:ctor(guideId, stepId, actionParam)
	GuideActionOpenCommonPropView.super.ctor(self, guideId, stepId, actionParam)
end

function GuideActionOpenCommonPropView:onStart(context)
	GuideActionOpenCommonPropView.super.onStart(self, context)

	local rewardStr = self.actionParam
	local list = GameUtil.splitString2(rewardStr, false, "$", ",")
	local dataList = {}

	for i, v in ipairs(list) do
		local materialData = MaterialDataMO.New()

		materialData:initValue(v[1], v[2], v[3])
		table.insert(dataList, materialData)
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, dataList)
	self:onDone(true)
end

return GuideActionOpenCommonPropView
