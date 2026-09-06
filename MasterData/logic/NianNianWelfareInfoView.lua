-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/view/NianNianWelfareInfoView.lua

module("logic.extensions.niannianwelfare.view.NianNianWelfareInfoView", package.seeall)

local NianNianWelfareInfoView = class("NianNianWelfareInfoView", ViewComponent)

function NianNianWelfareInfoView:unbindEvents()
	NianNianWelfareInfoView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
end

function NianNianWelfareInfoView:bindEvents()
	NianNianWelfareInfoView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSure, self)
end

function NianNianWelfareInfoView:buildUI()
	NianNianWelfareInfoView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._name = self:getTxt("txtName")
	self._desc = self:getTxt("tableview/Viewport/Content/txtDesc")
	self._level = self:getTxt("txtLevel")
	self._cost = self:getTxt("txtCost")
	self._costIcon = self:getGo("txtCost/icon")
	self._sureBtn = self:getBtn("btnSure")
end

function NianNianWelfareInfoView:onExit()
	NianNianWelfareInfoView.super.onExit(self)
	MaterialMgr.clearIcon(self._costIcon)
	GlobalDispatcher:removeListener(NianNianWelfareController.PM_NianNianBenefitsUpgradeRes, self._handlePM_NianNianBenefitsUpgradeRes, self)
end

function NianNianWelfareInfoView:onEnter()
	NianNianWelfareInfoView.super.onEnter(self)

	local openParam = self:getOpenParam()
	local info = openParam[1]

	self._partsId = info.partsId
	self._actId = openParam[2]
	self._name.text = info.name
	self._level.text = "Lv." .. info.level
	self._desc.text = info.describe

	goutil.setActive(self._cost.gameObject, info.level < info.maxLevel)
	goutil.setActive(self._sureBtn.gameObject, info.level < info.maxLevel)

	local matType, id, num = MaterialMgr.getMatParams(info.upgradeCost)

	self._costMatType = matType
	self._costId = id
	self._cost.text = num

	MaterialMgr.setIcon(self._costIcon, matType, id)
	GlobalDispatcher:addListener(NianNianWelfareController.PM_NianNianBenefitsUpgradeRes, self._handlePM_NianNianBenefitsUpgradeRes, self)
end

function NianNianWelfareInfoView:_handlePM_NianNianBenefitsUpgradeRes()
	local info = NianNianWelfareModel.instance:getPartInfoById(self._partsId)

	self._level.text = "Lv." .. info.level

	goutil.setActive(self._cost.gameObject, info.level < info.maxLevel)
	goutil.setActive(self._sureBtn.gameObject, info.level < info.maxLevel)
	uGuiUtil.setGoGrayState(self._sureBtn.gameObject, tonumber(self._cost.text) > MaterialFacade.instance:getMatNumber(self._costMatType, self._costId))
end

function NianNianWelfareInfoView:_onClickSure()
	if tonumber(self._cost.text) <= MaterialFacade.instance:getMatNumber(self._costMatType, self._costId) then
		NianNianWelfareController.instance:sendPM_NianNianBenefitsUpgradeReq(self._actId, self._partsId)
	else
		FloatWordMgr.instance:show(lang("nian_welfare_part_tip"))
	end
end

return NianNianWelfareInfoView
