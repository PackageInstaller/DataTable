-- chunkname: @modules/logic/settings/view/SettingsFightView.lua

module("modules.logic.settings.view.SettingsFightView", package.seeall)

local SettingsFightView = class("SettingsFightView", BaseView)

function SettingsFightView:onInitView()
	self.btnCardDetail = gohelper.findChildButtonWithAudio(self.viewGO, "graphicsScroll/Viewport/Content/go_cardDetail/switch/btn")
	self.goCardDetailOn = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/go_cardDetail/switch/btn/on")
	self.goCardDetailOff = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/go_cardDetail/switch/btn/off")
	self.goCardDetailOffOption = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/go_cardDetail/option/option_1")
	self.goCardDetailOffOptionSelect = gohelper.findChild(self.goCardDetailOffOption, "selected")
	self.goCardDetailOffOptionUnselect = gohelper.findChild(self.goCardDetailOffOption, "unselect")
	self.goCardDetailOnOption = gohelper.findChild(self.viewGO, "graphicsScroll/Viewport/Content/go_cardDetail/option/option_2")
	self.goCardDetailOnOptionSelect = gohelper.findChild(self.goCardDetailOnOption, "selected")
	self.goCardDetailOnOptionUnselect = gohelper.findChild(self.goCardDetailOnOption, "unselect")
end

function SettingsFightView:addEvents()
	self.btnCardDetail:AddClickListener(self.onClickBtnCardDetail, self)
end

function SettingsFightView:removeEvents()
	self.btnCardDetail:RemoveClickListener()
end

function SettingsFightView:onClickBtnCardDetail()
	local isOn = SettingsModel.instance:getFightCardDetail()

	SettingsModel.instance:setFightCardDetail(not isOn)
	self:refreshCardDetailUI()
end

function SettingsFightView:onUpdateParam()
	self:refreshUI()
end

function SettingsFightView:onOpen()
	self:refreshUI()
end

function SettingsFightView:refreshUI()
	self:refreshCardDetailUI()
end

function SettingsFightView:refreshCardDetailUI()
	local isOn = SettingsModel.instance:getFightCardDetail()

	gohelper.setActive(self.goCardDetailOn, isOn)
	gohelper.setActive(self.goCardDetailOff, not isOn)
	gohelper.setActive(self.goCardDetailOffOptionUnselect, isOn)
	gohelper.setActive(self.goCardDetailOnOptionSelect, isOn)
	gohelper.setActive(self.goCardDetailOffOptionSelect, not isOn)
	gohelper.setActive(self.goCardDetailOnOptionUnselect, not isOn)
end

function SettingsFightView:onClose()
	return
end

function SettingsFightView:onDestroyView()
	return
end

return SettingsFightView
