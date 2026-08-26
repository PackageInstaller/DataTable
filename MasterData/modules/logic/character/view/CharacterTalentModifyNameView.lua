-- chunkname: @modules/logic/character/view/CharacterTalentModifyNameView.lua

module("modules.logic.character.view.CharacterTalentModifyNameView", package.seeall)

local CharacterTalentModifyNameView = class("CharacterTalentModifyNameView", BaseView)

function CharacterTalentModifyNameView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnSure = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_sure")
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "message/#input_signature")
	self._btncleanname = gohelper.findChildButtonWithAudio(self.viewGO, "message/#btn_cleanname")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_leftbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentModifyNameView:addEvents()
	self._btnClose:AddClickListener(self._onBtnClose, self)
	self._btnSure:AddClickListener(self._onBtnSure, self)
	self._btncleanname:AddClickListener(self._onBtnClean, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, self._onRenameTalentTemplateReply, self)
	self._input:AddOnValueChanged(self._onValueChanged, self)
end

function CharacterTalentModifyNameView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btncleanname:RemoveClickListener()
	self._input:RemoveOnValueChanged()
end

function CharacterTalentModifyNameView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function CharacterTalentModifyNameView:onRefreshViewParam()
	return
end

function CharacterTalentModifyNameView:_onRenameTalentTemplateReply()
	self:_onBtnClose()
	GameFacade.showToast(ToastEnum.PlayerModifyChangeName)
end

function CharacterTalentModifyNameView:_onBtnClose()
	self:closeThis()
end

function CharacterTalentModifyNameView:_onBtnClean()
	self._input:SetText("")
end

function CharacterTalentModifyNameView:_onBtnSure()
	local str = self._input:GetText()

	if string.nilorempty(str) then
		return
	end

	if GameUtil.utf8len(str) > 6 then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)

		return
	end

	str = GameUtil.trimInput(str)

	HeroRpc.instance:RenameTalentTemplateRequest(self._heroId, self._templateId, str)
end

function CharacterTalentModifyNameView:_onValueChanged()
	local inputValue = self._input:GetText()

	gohelper.setActive(self._btncleanname, not string.nilorempty(inputValue))
end

function CharacterTalentModifyNameView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_petrus_exchange_element_get)

	self._heroId = self.viewParam[1]
	self._templateId = self.viewParam[2]
	self._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.35, self._onFrame, self._onFinish, self, nil, EaseType.Linear)

	gohelper.setActive(self._btncleanname, false)
end

function CharacterTalentModifyNameView:_onFrame(value)
	PostProcessingMgr.instance:setBlurWeight(value)
end

function CharacterTalentModifyNameView:_onFinish()
	PostProcessingMgr.instance:setBlurWeight(1)
end

function CharacterTalentModifyNameView:onClose()
	if self._blurTweenId then
		PostProcessingMgr.instance:setBlurWeight(1)
		ZProj.TweenHelper.KillById(self._blurTweenId)

		self._blurTweenId = nil
	end
end

function CharacterTalentModifyNameView:onDestroyView()
	self._simagerightbg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
end

return CharacterTalentModifyNameView
