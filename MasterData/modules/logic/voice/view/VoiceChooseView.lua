-- chunkname: @modules/logic/voice/view/VoiceChooseView.lua

module("modules.logic.voice.view.VoiceChooseView", package.seeall)

local VoiceChooseView = class("VoiceChooseView", BaseView)

function VoiceChooseView:onInitView()
	self._btnConfirm = gohelper.findChildButton(self.viewGO, "#btn_confirm")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_leftbg")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_rightbg")

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function VoiceChooseView:addEvents()
	self._btnConfirm:AddClickListener(self._onClickConfirm, self)
end

function VoiceChooseView:removeEvents()
	self._btnConfirm:RemoveClickListener()
end

function VoiceChooseView:_onClickConfirm()
	local chooseLang = VoiceChooseModel.instance:getChoose()

	PlayerPrefsHelper.setString(PlayerPrefsKey.SettingsVoiceShortcut, chooseLang)
	logNormal("selectLang = " .. chooseLang)
	SettingsVoicePackageController.instance:switchVoiceType(chooseLang, "after_download")
	self:closeThis()

	if self._callback then
		self._callback(self._callbackObj)
	end
end

function VoiceChooseView:onOpen()
	self._callback = self.viewParam.callback
	self._callbackObj = self.viewParam.callbackObj

	UpdateBeat:Add(self._onFrame, self)
end

function VoiceChooseView:onClose()
	UpdateBeat:Remove(self._onFrame, self)
end

function VoiceChooseView:_onFrame()
	if UnityEngine.Input.GetKeyUp(UnityEngine.KeyCode.Escape) then
		SDKMgr.instance:exitSdk()

		return
	end
end

function VoiceChooseView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return VoiceChooseView
