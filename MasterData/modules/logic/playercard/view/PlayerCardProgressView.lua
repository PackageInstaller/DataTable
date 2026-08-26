-- chunkname: @modules/logic/playercard/view/PlayerCardProgressView.lua

module("modules.logic.playercard.view.PlayerCardProgressView", package.seeall)

local PlayerCardProgressView = class("PlayerCardProgressView", BaseView)

function PlayerCardProgressView:onInitView()
	self._simagetop = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_top")
	self._simagebottom = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bottom")
	self._scrollprogress = gohelper.findChildScrollRect(self.viewGO, "#scroll_progress")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._txtchoose = gohelper.findChildText(self.viewGO, "#btn_confirm/#txt_choose")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardProgressView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SelectNumChange, self._onNumChange, self)
end

function PlayerCardProgressView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function PlayerCardProgressView:_btnconfirmOnClick()
	PlayerCardProgressModel.instance:confirmData()
	self:closeThis()
end

function PlayerCardProgressView:_btncloseOnClick()
	self.viewContainer:checkCloseFunc()
end

function PlayerCardProgressView:_editableInitView()
	return
end

function PlayerCardProgressView:onUpdateParam()
	return
end

function PlayerCardProgressView:onOpen()
	self.playercardinfo = self.viewParam

	self.animator:Play("open")
	PlayerCardProgressModel.instance:initSelectData(self.playercardinfo)
	self:refreshView()
	self:refreshNum()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)
end

function PlayerCardProgressView:refreshView()
	PlayerCardProgressModel.instance:refreshList()
end

function PlayerCardProgressView:_onNumChange()
	self:refreshNum()
end

function PlayerCardProgressView:refreshNum()
	local selectNum = PlayerCardProgressModel.instance:getSelectNum()
	local maxNum = PlayerCardEnum.MaxProgressCardNum

	self._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectNum,
		maxNum
	})
end

function PlayerCardProgressView:onClose()
	self.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseProgressView)
end

function PlayerCardProgressView:onDestroyView()
	return
end

return PlayerCardProgressView
