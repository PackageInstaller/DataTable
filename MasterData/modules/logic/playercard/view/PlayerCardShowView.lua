-- chunkname: @modules/logic/playercard/view/PlayerCardShowView.lua

module("modules.logic.playercard.view.PlayerCardShowView", package.seeall)

local PlayerCardShowView = class("PlayerCardShowView", BaseView)

function PlayerCardShowView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self.txtNum = gohelper.findChildTextMesh(self.viewGO, "#go_bottom/#txt_num")
end

function PlayerCardShowView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addClickCb(self, self.btnConfirm, self.onClickBtnConfirm, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SelectNumChange, self._onNumChange, self)
end

function PlayerCardShowView:removeEvents()
	return
end

function PlayerCardShowView:onClickBtnClose()
	self:closeThis()
end

function PlayerCardShowView:onClickBtnConfirm()
	PlayerCardProgressModel.instance:confirmData()
	self:closeThis()
end

function PlayerCardShowView:onOpen()
	self:_updateParam()

	local info = self:getCardInfo()

	PlayerCardProgressModel.instance:initSelectData(info)
	self:refreshView()
end

function PlayerCardShowView:onUpdateParam()
	self:_updateParam()
	self:refreshView()
end

function PlayerCardShowView:_updateParam()
	self.userId = PlayerModel.instance:getMyUserId()
end

function PlayerCardShowView:getCardInfo()
	return PlayerCardModel.instance:getCardInfo(self.userId)
end

function PlayerCardShowView:refreshView()
	PlayerCardProgressModel.instance:refreshList()
	self:refreshNum()
end

function PlayerCardShowView:_onNumChange()
	self:refreshNum()
end

function PlayerCardShowView:refreshNum()
	local selectNum = PlayerCardProgressModel.instance:getSelectNum()
	local maxNum = PlayerCardEnum.MaxCardNum

	self.txtNum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		selectNum,
		maxNum
	})
end

function PlayerCardShowView:onClose()
	return
end

return PlayerCardShowView
