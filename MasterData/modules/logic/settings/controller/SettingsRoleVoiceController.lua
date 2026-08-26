-- chunkname: @modules/logic/settings/controller/SettingsRoleVoiceController.lua

module("modules.logic.settings.controller.SettingsRoleVoiceController", package.seeall)

local SettingsRoleVoiceController = class("SettingsRoleVoiceController", BaseController)

function SettingsRoleVoiceController:onInit()
	return
end

function SettingsRoleVoiceController:onInitFinish()
	return
end

function SettingsRoleVoiceController:addConstEvents()
	return
end

function SettingsRoleVoiceController:reInit()
	return
end

function SettingsRoleVoiceController:openSettingRoleVoiceView()
	ViewMgr.instance:openView(ViewName.SettingsRoleVoiceView)
end

function SettingsRoleVoiceController:setCharVoiceLangPrefValue(charMoList, langValue)
	for _, charMo in ipairs(charMoList) do
		SettingsRoleVoiceModel.instance:setCharVoiceLangPrefValue(langValue, charMo.heroId)
	end

	GameFacade.showToast(ToastEnum.SettingCharVoiceLang)
	self:dispatchEvent(SettingsEvent.OnCharVoiceTypeChanged, charMoList)
end

SettingsRoleVoiceController.instance = SettingsRoleVoiceController.New()

return SettingsRoleVoiceController
