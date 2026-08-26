-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LogItem.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LogItem", package.seeall)

local Activity131LogItem = class("Activity131LogItem", MixScrollCell)
local UIHelper = SLFramework.UGUI.GuiHelper

function Activity131LogItem:init(go)
	self.viewGO = go
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._goname = gohelper.findChild(self.viewGO, "#go_normal/#go_name")
	self._goplayicon = gohelper.findChild(self.viewGO, "#go_normal/#go_playicon")
	self._gostopicon = gohelper.findChild(self.viewGO, "#go_normal/#go_stopicon")
	self._goicon = gohelper.findChild(self.viewGO, "#go_normal/#go_name/#go_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_normal/#go_name/#txt_name")
	self._txtcontent = gohelper.findChildText(self.viewGO, "#go_normal/#txt_content")
	self._gonorole = gohelper.findChild(self.viewGO, "#go_normal/#go_norole")
	self._btnplay = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_play")
	self._btnstop = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_stop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131LogItem:addEvents()
	return
end

function Activity131LogItem:removeEvents()
	return
end

function Activity131LogItem:_editableInitView()
	self._btnplay:AddClickListener(self._onPlayClick, self)
	self._btnstop:AddClickListener(self._onStopClick, self)
	Activity131Controller.instance:registerCallback(Activity131Event.LogSelected, self._onItemSelected, self)
	Activity131Controller.instance:registerCallback(Activity131Event.LogAudioFinished, self._onItemAudioFinished, self)
end

function Activity131LogItem:_editableAddEvents()
	return
end

function Activity131LogItem:_editableRemoveEvents()
	return
end

function Activity131LogItem:_onItemAudioFinished()
	if not self._audioId or self._audioId == 0 then
		return
	end

	if not self._mo or type(self._mo.info) ~= "number" then
		return
	end

	if self._audioId == Activity131LogListModel.instance:getPlayingLogAudioId() then
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._goplayicon, true)
		gohelper.setActive(self._btnplay.gameObject, true)
		gohelper.setActive(self._btnstop.gameObject, false)

		if self:_isPlayerSpeech() then
			UIHelper.SetColor(self._txtname, "#CCAD8F")
			UIHelper.SetColor(self._txtcontent, "#CCAD8F")
			self:_setSpriteMeshColor("#CCAD8F")
		else
			UIHelper.SetColor(self._txtname, "#EEF1E8")
			UIHelper.SetColor(self._txtcontent, "#EEF1E8")
			self:_setSpriteMeshColor("#EEF1E8")
			UIHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
		end
	end
end

function Activity131LogItem:_onItemSelected(audioId)
	if not audioId or audioId == 0 or not self._audioId or self._audioId == 0 then
		return
	end

	if self._audioId == audioId then
		return
	end

	if self._audioId ~= 0 then
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
		gohelper.setActive(self._goplayicon, true)
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._btnplay.gameObject, true)
		gohelper.setActive(self._btnstop.gameObject, false)
	else
		gohelper.setActive(self._goplayicon, false)
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._btnplay.gameObject, false)
		gohelper.setActive(self._btnstop.gameObject, false)
	end
end

function Activity131LogItem:_onPlayClick()
	gohelper.setActive(self._gostopicon, true)
	gohelper.setActive(self._goplayicon, false)
	gohelper.setActive(self._btnplay.gameObject, false)
	gohelper.setActive(self._btnstop.gameObject, true)
	UIHelper.SetColor(self._txtname, "#D56B39")
	UIHelper.SetColor(self._txtcontent, "#D56B39")
	self:_setSpriteMeshColor("#D56B39")
	UIHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")

	if self._audioId ~= 0 and Activity131LogListModel.instance:getPlayingLogAudioId() ~= self._audioId then
		AudioEffectMgr.instance:stopAudio(Activity131LogListModel.instance:getPlayingLogAudioId(), 0)
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
	end

	local param = {}

	param.loopNum = 1
	param.fadeInTime = 0
	param.fadeOutTime = 0
	param.volume = 100
	param.callback = self._onAudioFinished
	param.callbackTarget = self

	AudioEffectMgr.instance:playAudio(self._audioId, param)
	Activity131LogListModel.instance:setPlayingLogAudio(self._audioId)
	Activity131Controller.instance:dispatchEvent(Activity131Event.LogSelected, self._audioId)
end

function Activity131LogItem:_onStopClick()
	gohelper.setActive(self._gostopicon, false)
	gohelper.setActive(self._goplayicon, true)
	gohelper.setActive(self._btnplay.gameObject, true)
	gohelper.setActive(self._btnstop.gameObject, false)

	if self:_isPlayerSpeech() then
		UIHelper.SetColor(self._txtname, "#CCAD8F")
		UIHelper.SetColor(self._txtcontent, "#CCAD8F")
		self:_setSpriteMeshColor("#CCAD8F")
	else
		UIHelper.SetColor(self._txtname, "#EEF1E8")
		UIHelper.SetColor(self._txtcontent, "#EEF1E8")
		self:_setSpriteMeshColor("#EEF1E8")
		UIHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end

	Activity131LogListModel.instance:setPlayingLogAudioFinished(self._audioId)
	AudioEffectMgr.instance:stopAudio(self._audioId, 0)
end

function Activity131LogItem:_onAudioFinished()
	Activity131Controller.instance:dispatchEvent(Activity131Event.LogAudioFinished)

	if self._audioId ~= Activity131LogListModel.instance:getPlayingLogAudioId() then
		Activity131LogListModel.instance:setPlayingLogAudio(0)
	end

	if self._audioId == 0 then
		return
	end

	Activity131LogListModel.instance:setPlayingLogAudioFinished(self._audioId)
	gohelper.setActive(self._gostopicon, false)
	gohelper.setActive(self._goplayicon, true)
	gohelper.setActive(self._btnplay.gameObject, true)
	gohelper.setActive(self._btnstop.gameObject, false)

	if self:_isPlayerSpeech() then
		UIHelper.SetColor(self._txtname, "#CCAD8F")
		UIHelper.SetColor(self._txtcontent, "#CCAD8F")
		self:_setSpriteMeshColor("#CCAD8F")
	else
		UIHelper.SetColor(self._txtname, "#EEF1E8")
		UIHelper.SetColor(self._txtcontent, "#EEF1E8")
		self:_setSpriteMeshColor("#EEF1E8")
		UIHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")
	end
end

function Activity131LogItem:onUpdateMO(mo, mixType)
	if not mo then
		return
	end

	self._mo = mo

	UIHelper.SetColor(self._txtname, "#EEF1E8")
	UIHelper.SetColor(self._txtcontent, "#EEF1E8")
	self:_setSpriteMeshColor("#EEF1E8")
	UIHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#DFE2D9")

	self._txtcontent.text = mo:getSpeech()
	self._audioId = mo:getAudioId()

	gohelper.setActive(self._gonorole, false)

	if string.nilorempty(mo:getSpeaker()) or mixType == 1 then
		gohelper.setActive(self._goname, false)
	else
		self._txtname.text = string.format("%s:", mo:getSpeaker())

		gohelper.setActive(self._goname, true)
	end

	self:_refreshAudioStatus()

	if self:_isPlayerSpeech() then
		gohelper.setActive(self._goicon, true)
		UIHelper.SetColor(self._txtname, "#CCAD8F")
		UIHelper.SetColor(self._txtcontent, "#CCAD8F")
		self:_setSpriteMeshColor("#CCAD8F")
	else
		gohelper.setActive(self._goicon, false)
	end
end

function Activity131LogItem:_refreshAudioStatus()
	if self._audioId ~= 0 then
		local isPlaying = self._audioId == Activity131LogListModel.instance:getPlayingLogAudioId()

		gohelper.setActive(self._gostopicon, isPlaying)
		gohelper.setActive(self._goplayicon, not isPlaying)
		gohelper.setActive(self._btnplay.gameObject, not isPlaying)
		gohelper.setActive(self._btnstop.gameObject, isPlaying)

		if isPlaying then
			UIHelper.SetColor(self._txtname, "#D56B39")
			UIHelper.SetColor(self._txtcontent, "#D56B39")
			self:_setSpriteMeshColor("#D56B39")
			UIHelper.SetColor(self._gonorole:GetComponent(gohelper.Type_Image), "#BD5C2F")
		end
	else
		gohelper.setActive(self._gostopicon, false)
		gohelper.setActive(self._goplayicon, false)
		gohelper.setActive(self._btnplay.gameObject, false)
		gohelper.setActive(self._btnstop.gameObject, false)
	end
end

function Activity131LogItem:_setSpriteMeshColor(color)
	TaskDispatcher.runDelay(function()
		if not self._txtcontent then
			return
		end

		local meshs = {}
		local subMeshs = self._txtcontent.gameObject:GetComponentsInChildren(typeof(TMPro.TMP_SubMeshUI), true)

		if subMeshs then
			local iter = subMeshs:GetEnumerator()

			while iter:MoveNext() do
				local subMesh = iter.Current.gameObject:GetComponent(typeof(TMPro.TMP_SubMeshUI))

				table.insert(meshs, subMesh)
			end
		end

		local matColor = GameUtil.parseColor(color .. "FF")

		for _, v in pairs(meshs) do
			if v.materialForRendering then
				v.materialForRendering:EnableKeyword("_GRADUAL_ON")
				v.materialForRendering:SetColor("_Color", matColor)
			end
		end
	end, nil, 0.01)
end

function Activity131LogItem:_isPlayerSpeech()
	return
end

function Activity131LogItem:onSelect(isSelect)
	return
end

function Activity131LogItem:onDestroy()
	if self._audioId ~= 0 then
		Activity131LogListModel.instance:setPlayingLogAudioFinished(self._audioId)
		AudioEffectMgr.instance:stopAudio(self._audioId, 0)
	end

	self._btnplay:RemoveClickListener()
	self._btnstop:RemoveClickListener()
	Activity131Controller.instance:unregisterCallback(Activity131Event.LogSelected, self._onItemSelected, self)
	Activity131Controller.instance:unregisterCallback(Activity131Event.LogAudioFinished, self._onItemAudioFinished, self)
end

return Activity131LogItem
