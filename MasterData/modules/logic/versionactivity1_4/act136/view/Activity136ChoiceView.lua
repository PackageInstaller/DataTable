-- chunkname: @modules/logic/versionactivity1_4/act136/view/Activity136ChoiceView.lua

module("modules.logic.versionactivity1_4.act136.view.Activity136ChoiceView", package.seeall)

local Activity136ChoiceView = class("Activity136ChoiceView", BaseView)

function Activity136ChoiceView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg2")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_item")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_ok")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity136ChoiceView:addEvents()
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, Activity136Controller.instance, Activity136Event.SelectCharacter, self._onSelectCharacter, self)
end

function Activity136ChoiceView:removeEvents()
	self._btnok:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, Activity136Controller.instance, Activity136Event.SelectCharacter, self._onSelectCharacter, self)
end

function Activity136ChoiceView:_btnokOnClick()
	Activity136Controller.instance:receiveCharacter(self._selectCharacterId)
end

function Activity136ChoiceView:_btncloseOnClick()
	self:closeThis()
end

function Activity136ChoiceView:_onSelectCharacter(selectedCharacterId)
	self._selectCharacterId = selectedCharacterId

	self:refreshReceiveBtn()
end

function Activity136ChoiceView:_editableInitView()
	self._selectCharacterId = nil
end

function Activity136ChoiceView:onUpdateParam()
	return
end

function Activity136ChoiceView:onOpen()
	self:refreshReceiveBtn()
	Activity136ChoiceViewListModel.instance:setSelfSelectedCharacterList()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_culture_open)
end

function Activity136ChoiceView:refreshReceiveBtn()
	local hasReceive = Activity136Model.instance:hasReceivedCharacter()

	ZProj.UGUIHelper.SetGrayscale(self._btnok.gameObject, (not hasReceive or nil) and not self._selectCharacterId)
end

function Activity136ChoiceView:onClose()
	self._selectCharacterId = nil
end

function Activity136ChoiceView:onDestroyView()
	return
end

return Activity136ChoiceView
