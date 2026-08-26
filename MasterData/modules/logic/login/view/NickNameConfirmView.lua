-- chunkname: @modules/logic/login/view/NickNameConfirmView.lua

module("modules.logic.login.view.NickNameConfirmView", package.seeall)

local NickNameConfirmView = class("NickNameConfirmView", BaseView)

function NickNameConfirmView:onInitView()
	self._simageinputnamebg = gohelper.findChildSingleImage(self.viewGO, "#simage_inputnamebg")
	self._simageconfirmbg = gohelper.findChildSingleImage(self.viewGO, "#simage_confirmbg")
	self._txtname = gohelper.findChildText(self.viewGO, "#simage_inputnamebg/#txt_name")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "go/#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "go/#btn_no")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NickNameConfirmView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
end

function NickNameConfirmView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
end

function NickNameConfirmView:_btnyesOnClick()
	PlayerRpc.instance:sendRenameRequest(self.sendRenameParam.name, self.sendRenameParam.guideId, self.sendRenameParam.stepId)
	PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmYes)
end

function NickNameConfirmView:_btnnoOnClick()
	self:closeThis()
	PlayerController.instance:dispatchEvent(PlayerEvent.NickNameConfirmNo)
end

function NickNameConfirmView:_editableInitView()
	self._simageinputnamebg:LoadImage(ResUrl.getNickNameIcon("mingmingzi_001"))
	self._simageconfirmbg:LoadImage(ResUrl.getNickNameIcon("shifouquerendi_003"))
	self.addEventCb(self, PlayerController.instance, PlayerEvent.ChangePlayerName, self.closeThis, self)
	self.addEventCb(self, PlayerController.instance, PlayerEvent.RenameReplyFail, self._btnnoOnClick, self)
	gohelper.addUIClickAudio(self._btnyes.gameObject, AudioEnum.UI.Play_UI_Universal_Click)
	gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.Play_UI_OperaHouse)
end

function NickNameConfirmView:onUpdateParam()
	return
end

function NickNameConfirmView:onOpen()
	PostProcessingMgr.instance:setBlurWeight(1)

	self.sendRenameParam = self.viewParam
	self._txtname.text = self.sendRenameParam.name

	NavigateMgr.instance:addEscape(ViewName.NicknameConfirmView, self._btnnoOnClick, self)
end

function NickNameConfirmView:onClose()
	self._simageconfirmbg:UnLoadImage()
	self._simageinputnamebg:UnLoadImage()
end

function NickNameConfirmView:onDestroyView()
	PostProcessingMgr.instance:setBlurWeight(0)
end

return NickNameConfirmView
