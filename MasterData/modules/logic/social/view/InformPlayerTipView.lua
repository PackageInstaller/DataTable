-- chunkname: @modules/logic/social/view/InformPlayerTipView.lua

module("modules.logic.social.view.InformPlayerTipView", package.seeall)

local InformPlayerTipView = class("InformPlayerTipView", BaseView)

function InformPlayerTipView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_leftbg")
	self._txtinfotarget = gohelper.findChildText(self.viewGO, "inform/#txt_infotarget")
	self._goinformContent = gohelper.findChild(self.viewGO, "scroll_inform/Viewport/#go_informContent")
	self._goinformItem = gohelper.findChild(self.viewGO, "scroll_inform/Viewport/#go_informContent/#go_informItem")
	self._inputinformReason = gohelper.findChildTextMeshInputField(self.viewGO, "informreason/#input_informReason")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_close")
	self._btninform = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_inform")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InformPlayerTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btninform:AddClickListener(self._btninformOnClick, self)
end

function InformPlayerTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btninform:RemoveClickListener()
end

function InformPlayerTipView:_btncloseOnClick()
	self:closeThis()
end

function InformPlayerTipView:_btninformOnClick()
	if self.informIng then
		return
	end

	local reportId = ReportTypeListModel.instance:getSelectReportId()

	if not reportId then
		GameFacade.showToast(ToastEnum.ClickInformPlayer)

		return
	end

	self.informIng = true

	ChatRpc.instance:sendReportRequest(self.socialPlayerMO.userId, reportId, self._inputinformReason:GetText())
end

function InformPlayerTipView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._inputinformReason:AddOnValueChanged(self.onReasonTextValueChanged, self)
end

function InformPlayerTipView:onReasonTextValueChanged(text)
	local len = GameUtil.utf8len(text)

	if len > CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen) then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)
		self._inputinformReason:SetText(GameUtil.utf8sub(text, 1, CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen)))
	end
end

function InformPlayerTipView:onUpdateParam()
	return
end

function InformPlayerTipView:onOpen()
	self.socialPlayerMO = self.viewParam
	self._txtinfotarget.text = self.socialPlayerMO.name

	self:refreshReportType()
	self.addEventCb(self, SocialController.instance, SocialEvent.InformSuccessReply, self.onInformSuccess, self)
	self.addEventCb(self, SocialController.instance, SocialEvent.InformFailReply, self.onInformFail, self)
end

function InformPlayerTipView:refreshReportType()
	ReportTypeListModel.instance:refreshData()
end

function InformPlayerTipView:onInformSuccess()
	GameFacade.showToast(ToastEnum.OnInformSuccess)
	self:onInformFail()
end

function InformPlayerTipView:onInformFail()
	self.informIng = false

	self:closeThis()
end

function InformPlayerTipView:onClose()
	ReportTypeListModel.instance:clearSelectReportItem()
end

function InformPlayerTipView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._inputinformReason:RemoveOnValueChanged()
end

return InformPlayerTipView
