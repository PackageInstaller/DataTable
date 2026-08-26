-- chunkname: @modules/logic/playercard/view/PlayerCardBaseInfoView.lua

module("modules.logic.playercard.view.PlayerCardBaseInfoView", package.seeall)

local PlayerCardBaseInfoView = class("PlayerCardBaseInfoView", BaseView)

function PlayerCardBaseInfoView:onInitView()
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tips")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._btntipsclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_close")
	self._txtchoose = gohelper.findChildText(self.viewGO, "#btn_confirm/#txt_choose")
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._tipopen = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardBaseInfoView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btntipsclose:AddClickListener(self._btntipsOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SelectNumChange, self._onNumChange, self)
end

function PlayerCardBaseInfoView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self._btntipsclose:RemoveClickListener()
end

function PlayerCardBaseInfoView:_btnconfirmOnClick()
	PlayerCardBaseInfoModel.instance:confirmData()
	self:closeThis()
end

function PlayerCardBaseInfoView:_btntipsOnClick()
	self._tipopen = not self._tipopen

	gohelper.setActive(self._gotips, self._tipopen)
end

function PlayerCardBaseInfoView:_btncloseOnClick()
	self.viewContainer:checkCloseFunc()
end

function PlayerCardBaseInfoView:_editableInitView()
	return
end

function PlayerCardBaseInfoView:onUpdateParam()
	return
end

function PlayerCardBaseInfoView:onOpen()
	self.playercardinfo = self.viewParam

	self.animator:Play("open")
	PlayerCardBaseInfoModel.instance:initSelectData(self.playercardinfo)
	self:refreshView()
	self:refreshNum()
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_leimi_unlock)
end

function PlayerCardBaseInfoView:refreshView()
	PlayerCardBaseInfoModel.instance:refreshList()
end

function PlayerCardBaseInfoView:_onNumChange()
	self:refreshNum()
end

function PlayerCardBaseInfoView:refreshNum()
	local selectNum = PlayerCardBaseInfoModel.instance:getSelectNum()
	local maxNum = PlayerCardEnum.MaxBaseInfoNum

	self._txtchoose.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectNum,
		maxNum
	})
end

function PlayerCardBaseInfoView:onClose()
	self.animator:Play("close")
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.OnCloseBaseInfoView)
end

function PlayerCardBaseInfoView:onDestroyView()
	return
end

return PlayerCardBaseInfoView
