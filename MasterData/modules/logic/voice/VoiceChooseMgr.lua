-- chunkname: @modules/logic/voice/VoiceChooseMgr.lua

module("modules.logic.voice.VoiceChooseMgr", package.seeall)

local VoiceChooseMgr = class("VoiceChooseMgr")

function VoiceChooseMgr:start(callback, callbackObj)
	if VersionValidator.instance:isInReviewing() then
		callback(callbackObj)
	elseif GameResMgr.IsFromEditorDir and not HotUpdateVoiceMgr.EnableEditorDebug then
		callback(callbackObj)
	elseif PlayerPrefsHelper.hasKey(PlayerPrefsKey.SettingsVoiceShortcut) then
		callback(callbackObj)
	elseif not GameConfig.CanHotUpdate then
		callback(callbackObj)
	else
		local defaultChoose = GameConfig:GetDefaultVoiceShortcut()

		VoiceChooseModel.instance:initModel(defaultChoose)

		if VoiceChooseModel.instance:getCount() > 1 then
			BootLoadingView.instance:hide()
			ViewMgr.instance:openView(ViewName.VoiceChooseView, {
				callback = callback,
				callbackObj = callbackObj
			})
		else
			local defaultLang = GameConfig:GetDefaultVoiceShortcut()

			logNormal("没有下载可选语音，跳过选择语音界面，默认选择 " .. defaultLang)
			PlayerPrefsHelper.setString(PlayerPrefsKey.SettingsVoiceShortcut, defaultLang)
			callback(callbackObj)
		end
	end
end

VoiceChooseMgr.instance = VoiceChooseMgr.New()

return VoiceChooseMgr
