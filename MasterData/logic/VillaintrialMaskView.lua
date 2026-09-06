-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/villaintrial/view/VillaintrialMaskView.lua

module("logic.extensions.villaintrial.view.VillaintrialMaskView", package.seeall)

local VillaintrialMaskView = class("VillaintrialMaskView", ViewComponent)

function VillaintrialMaskView:ctor()
	VillaintrialMaskView.super.ctor(self)
end

function VillaintrialMaskView:unbindEvents()
	VillaintrialMaskView.super.unbindEvents(self)
	self._switchEquip:RemoveClickListener()
end

function VillaintrialMaskView:bindEvents()
	VillaintrialMaskView.super.bindEvents(self)
	self._switchEquip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.VillaintrialEquipView)
	end)
end

function VillaintrialMaskView:onExit()
	VillaintrialMaskView.super.onExit(self)
	VillaintrialController.instance:clearEffect(self._effect)
end

function VillaintrialMaskView:buildUI()
	VillaintrialMaskView.super.buildUI(self)

	self._switchEquip = self:getBtn("switchequip")
	self._mask = self:getGo("Nego_Right")
end

function VillaintrialMaskView:onEnter()
	VillaintrialMaskView.super.onEnter(self)

	local isShow = VillaintrialModel.instance:isAboveThreeLevel()

	goutil.setActive(self._mask, not isShow)
	self:_setEffect()
end

function VillaintrialMaskView:_setEffect()
	local level = VillaintrialModel.instance:getCurStageId()

	if GameUtil.getUserDayData("VillaintrialEquipView" .. level) == nil then
		self._effect = VillaintrialController.instance:playEffect(self._switchEquip, self, self._tableView, "common/fx_ui_anniu_tongyong.prefab", 0.6)
	end
end

return VillaintrialMaskView
