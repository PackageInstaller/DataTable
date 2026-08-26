-- chunkname: @modules/logic/room/view/RoomInformPlayerView.lua

module("modules.logic.room.view.RoomInformPlayerView", package.seeall)

local RoomInformPlayerView = class("RoomInformPlayerView", BaseView)

function RoomInformPlayerView:onInitView()
	self._txtinfotarget = gohelper.findChildText(self.viewGO, "object/inform/#txt_infotarget")
	self._goinformContent = gohelper.findChild(self.viewGO, "object/scroll_inform/Viewport/#go_informContent")
	self._goinformItem = gohelper.findChild(self.viewGO, "object/scroll_inform/Viewport/#go_informContent/#go_informItem")
	self._inputinformReason = gohelper.findChildTextMeshInputField(self.viewGO, "object/informreason/#input_informReason")
	self._gominimap = gohelper.findChild(self.viewGO, "object/informreason/#go_minimap")
	self._btninform = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_inform")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomInformPlayerView:addEvents()
	self._btninform:AddClickListener(self._btninformOnClick, self)
end

function RoomInformPlayerView:removeEvents()
	self._btninform:RemoveClickListener()
end

function RoomInformPlayerView:_btncloseOnClick()
	self:closeThis()
end

function RoomInformPlayerView:_btninformOnClick()
	local reportId = RoomReportTypeListModel.instance:getSelectId()
	local mo = RoomReportTypeListModel.instance:getById(reportId)

	if not reportId or not mo then
		GameFacade.showToast(ToastEnum.ClickInformPlayer)

		return
	end

	local content = self._inputinformReason:GetText()

	RoomInformController.instance:sendReportRoom(self.socialPlayerMO.userId, mo.desc, content, self._shareCode)
end

function RoomInformPlayerView:_editableInitView()
	self._rawImageMap = gohelper.onceAddComponent(self._gominimap, gohelper.Type_RawImage)

	self._inputinformReason:AddOnValueChanged(self.onReasonTextValueChanged, self)
end

function RoomInformPlayerView:onReasonTextValueChanged(text)
	local len = GameUtil.utf8len(text)

	if len > CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen) then
		GameFacade.showToast(ToastEnum.InformPlayerCharLen)
		self._inputinformReason:SetText(GameUtil.utf8sub(text, 1, CommonConfig.instance:getConstNum(ConstEnum.InformPlayerCharLen)))
	end
end

function RoomInformPlayerView:onUpdateParam()
	return
end

function RoomInformPlayerView:onOpen()
	self.socialPlayerMO = self.viewParam.playerMO
	self._shareCode = self.viewParam.shareCode
	self._txtinfotarget.text = self.socialPlayerMO.name
	self._texture = self.viewParam.texture2d
	self.viewParam.texture2d = nil
	self._rawImageMap.texture = self._texture

	if self._texture then
		local texWidth = self._texture.width

		if texWidth ~= 0 then
			local texHeight = self._texture.height
			local imageTrs = self._rawImageMap.transform
			local width = recthelper.getWidth(imageTrs)
			local height = width * texHeight / texWidth

			recthelper.setHeight(imageTrs, height)
		end
	end

	self:refreshReportType()
	self.addEventCb(self, RoomController.instance, RoomEvent.InformSuccessReply, self._onInformSuccess, self)
end

function RoomInformPlayerView:refreshReportType()
	return
end

function RoomInformPlayerView:_onInformSuccess(token)
	GameFacade.showToast(ToastEnum.OnInformSuccess)

	if not string.nilorempty(token) and self._texture then
		RoomInformController.instance:uploadImage(self._texture, token)
	end

	self:closeThis()
end

function RoomInformPlayerView:onClose()
	RoomReportTypeListModel.instance:clearSelect()
end

function RoomInformPlayerView:onDestroyView()
	self._inputinformReason:RemoveOnValueChanged()

	self._texture = nil
end

return RoomInformPlayerView
