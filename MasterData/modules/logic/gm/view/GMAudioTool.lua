-- chunkname: @modules/logic/gm/view/GMAudioTool.lua

module("modules.logic.gm.view.GMAudioTool", package.seeall)

local GMAudioTool = class("GMAudioTool", BaseView)

function GMAudioTool:onInitView()
	self._inpAudio = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/playAudioById/inpAudioId")
	self._btnAudioPlay = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/playAudioById/btnPlay"))
	self._btnAudioStop = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/playAudioById/btnStop"))
	self._autoStopToggle = gohelper.findChildToggle(self.viewGO, "viewport/content/audioTool/autoStopAudioToggle")
	self._showLogToggle = gohelper.findChildToggle(self.viewGO, "viewport/content/audioTool/showLogToggle")
	self._inpEvent = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/playAudioByEventName/inpAudioEventName")
	self._inpBank = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/playAudioByEventName/inpAudioBankName")
	self._btnPlayEvent = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/playAudioByEventName/btnPlay"))
	self._btnStopEvent = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/playAudioByEventName/btnStop"))
	self._langDrop = gohelper.findChildDropdown(self.viewGO, "viewport/content/audioLanguage/audioLanguageDropdown")
	self._inpRtpcName = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/rtpcItem/inpRtpcName")
	self._inpRtpcValue = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/rtpcItem/inpRtpcValue")
	self._btnSetRtpc = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/rtpcItem/btnSetRtpc"))
	self._inpSwitchName = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/switchItem/inpSwitchGroup")
	self._inpSwitchValue = gohelper.findChildTextMeshInputField(self.viewGO, "viewport/content/switchItem/inpSwitchValue")
	self._btnSwitch = gohelper.getClick(gohelper.findChild(self.viewGO, "viewport/content/switchItem/btnSetSwitch"))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GMAudioTool:addEvents()
	self._btnAudioPlay:AddClickListener(self._onClickAudioPlay, self)
	self._btnAudioStop:AddClickListener(self._onClickAudioStop, self)
	self._btnPlayEvent:AddClickListener(self._onClickEventPlay, self)
	self._btnStopEvent:AddClickListener(self._onClickEventStop, self)
	self._btnSetRtpc:AddClickListener(self._onClickSetRtpc, self)
	self._btnSwitch:AddClickListener(self._onClickSwitch, self)
	self._autoStopToggle:AddOnValueChanged(self._onAutoStopChange, self)
	self._showLogToggle:AddOnValueChanged(self._onShowLogChange, self)
	self._langDrop:AddOnValueChanged(self._onLangDropChange, self)
end

function GMAudioTool:removeEvents()
	self._btnAudioPlay:RemoveClickListener()
	self._btnAudioStop:RemoveClickListener()
	self._btnPlayEvent:RemoveClickListener()
	self._btnStopEvent:RemoveClickListener()
	self._btnSetRtpc:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	self._autoStopToggle:RemoveOnValueChanged()
	self._showLogToggle:RemoveOnValueChanged()
	self._langDrop:RemoveOnValueChanged()
end

function GMAudioTool:initLangDrop()
	self.langList = {}

	local cSharpArr = GameConfig:GetSupportedVoiceShortcuts()
	local length = cSharpArr.Length
	local selectIndex = 0

	for i = 0, length - 1 do
		local lang = cSharpArr[i]

		table.insert(self.langList, lang)

		if lang == self.curLang then
			selectIndex = i
		end
	end

	self._langDrop:ClearOptions()
	self._langDrop:AddOptions(self.langList)
	self._langDrop:SetValue(selectIndex)
end

function GMAudioTool:_editableInitView()
	self.autoStopPrePlayingId = true
	self.prePlayingId = 0
	self.curLang = GameConfig:GetCurVoiceShortcut()
	self._showLogToggle.isOn = GMController.instance:getShowAudioLog()
	self._autoStopToggle.isOn = self.autoStopPrePlayingId

	self:initLangDrop()
end

function GMAudioTool:_onClickAudioPlay()
	local input = self._inpAudio:GetText()

	if not string.nilorempty(input) then
		local audioId = tonumber(input)

		if audioId then
			if self.autoStopPrePlayingId then
				self:stopPlayingID()
			end

			self.prePlayingId = AudioMgr.instance:trigger(audioId)
		end
	end
end

function GMAudioTool:_onClickAudioStop()
	self:stopPlayingID()
end

function GMAudioTool:_onClickEventPlay()
	local eventName = self._inpEvent:GetText()
	local bankName = self._inpBank:GetText()

	if string.nilorempty(eventName) then
		return
	end

	if string.nilorempty(bankName) then
		return
	end

	self:initAudioEditorTool()

	if self.autoStopPrePlayingId then
		self:stopPlayingID()
	end

	self.prePlayingId = self.audioTool:PlayEvent(eventName, bankName)
end

function GMAudioTool:_onClickEventStop()
	self:stopPlayingID()
end

function GMAudioTool:_onAutoStopChange(param, isOn)
	self.autoStopPrePlayingId = isOn
end

function GMAudioTool:_onShowLogChange(param, isOn)
	if GMController.instance:getShowAudioLog() == isOn then
		return
	end

	AudioMgr.GMOpenLog = isOn
	ZProj.AudioManager.Instance.gmOpenLog = isOn

	GMController.instance:setShowAudioLog(isOn)
end

function GMAudioTool:_onLangDropChange(index)
	local lang = self.langList[index + 1]

	if lang == self.curLang then
		return
	end

	self.curLang = lang

	self:stopPlayingID()
	self:initAudioEditorTool()
	self.audioTool:SetLanguage(self.curLang)
end

function GMAudioTool:_onClickSetRtpc()
	local rtpcName = self._inpRtpcName:GetText()
	local rtpcValue = self._inpRtpcValue:GetText()

	if string.nilorempty(rtpcName) then
		return
	end

	if string.nilorempty(rtpcValue) then
		return
	end

	rtpcValue = tonumber(rtpcValue)

	if not rtpcValue then
		return
	end

	self:initAudioEditorTool()
	self.audioTool:SetRtpc(rtpcName, rtpcValue)
end

function GMAudioTool:_onClickSwitch()
	local switchName = self._inpSwitchName:GetText()
	local switchValue = self._inpSwitchValue:GetText()

	if string.nilorempty(switchName) then
		return
	end

	if string.nilorempty(switchValue) then
		return
	end

	self:initAudioEditorTool()
	self.audioTool:SetSwitch(switchName, switchValue)
end

function GMAudioTool:stopPlayingID()
	AudioMgr.instance:stopPlayingID(self.prePlayingId)
end

function GMAudioTool:initAudioEditorTool()
	self.audioTool = self.audioTool or ZProj.AudioEditorTool.Instance
end

function GMAudioTool:onClose()
	self:stopPlayingID()
end

function GMAudioTool:onDestroyView()
	self.audioTool = nil
end

return GMAudioTool
