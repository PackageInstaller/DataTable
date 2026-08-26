-- chunkname: @modules/logic/settings/model/SettingsShowHelper.lua

module("modules.logic.settings.model.SettingsShowHelper", package.seeall)

local SettingsShowHelper = class("SettingsShowHelper")

function SettingsShowHelper:ctor()
	self._handlerMap = {
		[SettingsEnum.ShowType.RecordVideo] = SettingsShowHelper.canShowRecordVideo,
		[SettingsEnum.ShowType.KeyMap] = SettingsShowHelper.canShowKeySetting,
		[SettingsEnum.ShowType.Push] = SettingsShowHelper.canShowPush,
		[SettingsEnum.ShowType.Udimo] = SettingsShowHelper.canShowUdimo
	}
end

function SettingsShowHelper:canShow(settingsType)
	if not self._handlerMap[settingsType] then
		return true
	end

	return self._handlerMap[settingsType]()
end

function SettingsShowHelper.canShowRecordVideo()
	return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SettingsRecordVideo) and SDKMgr.isSupportRecord ~= nil and SDKMgr.instance:isSupportRecord()
end

function SettingsShowHelper.canShowKeySetting()
	return PCInputController.instance:getIsUse()
end

function SettingsShowHelper.canShowPush()
	return not BootNativeUtil.isWindows()
end

function SettingsShowHelper.canShowUdimo()
	return UdimoModel.instance:isOpenUdimoFunc()
end

return SettingsShowHelper
