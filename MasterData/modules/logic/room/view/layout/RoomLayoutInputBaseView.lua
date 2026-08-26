-- chunkname: @modules/logic/room/view/layout/RoomLayoutInputBaseView.lua

module("modules.logic.room.view.layout.RoomLayoutInputBaseView", package.seeall)

local RoomLayoutInputBaseView = class("RoomLayoutInputBaseView", BaseView)

function RoomLayoutInputBaseView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "window/#simage_leftbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_close")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_sure")
	self._txtdes = gohelper.findChildText(self.viewGO, "message/#txt_des")
	self._inputsignature = gohelper.findChildTextMeshInputField(self.viewGO, "message/#input_signature")
	self._txttext = gohelper.findChildText(self.viewGO, "message/#input_signature/textarea/#txt_text")
	self._btncleanname = gohelper.findChildButtonWithAudio(self.viewGO, "message/#input_signature/#btn_cleanname")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutInputBaseView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._btncleanname:AddClickListener(self._btncleannameOnClick, self)
	self._inputsignature:AddOnEndEdit(self._onInputNameEndEdit, self)
	self._inputsignature:AddOnValueChanged(self._onInputNameValueChange, self)
end

function RoomLayoutInputBaseView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsure:RemoveClickListener()
	self._btncleanname:RemoveClickListener()
	self._inputsignature:RemoveOnEndEdit()
	self._inputsignature:RemoveOnValueChanged()
end

function RoomLayoutInputBaseView:_btncloseOnClick()
	self:closeThis()
	self:_closeInvokeCallback(false)
end

function RoomLayoutInputBaseView:_btnsureOnClick()
	local inputStr = self._inputsignature:GetText()

	if string.nilorempty(inputStr) then
		-- block empty
	else
		self:closeThis()
		self:_closeInvokeCallback(true, inputStr)
	end
end

function RoomLayoutInputBaseView:_btncleannameOnClick()
	self._inputsignature:SetText("")
end

function RoomLayoutInputBaseView:_onInputNameEndEdit()
	self:_checkLimit()
end

function RoomLayoutInputBaseView:_onInputNameValueChange()
	if not BootNativeUtil.isIOS() then
		self:_checkLimit()
	end
end

function RoomLayoutInputBaseView:_checkLimit()
	local inputValue = self._inputsignature:GetText()
	local limit = self:_getInputLimit()
	local newInput = GameUtil.utf8sub(inputValue, 1, math.min(GameUtil.utf8len(inputValue), limit))

	if newInput ~= inputValue then
		self._inputsignature:SetText(newInput)
	end
end

function RoomLayoutInputBaseView:_getInputLimit()
	return CommonConfig.instance:getConstNum(ConstEnum.CharacterNameLimit)
end

function RoomLayoutInputBaseView:_editableInitView()
	self._txttitlecn = gohelper.findChildText(self.viewGO, "titlecn")
	self._txttitleen = gohelper.findChildText(self.viewGO, "titlecn/titleen")
	self._txtbtnsurecn = gohelper.findChildText(self.viewGO, "bottom/#btn_sure/text")
	self._txtbtnsureed = gohelper.findChildText(self.viewGO, "bottom/#btn_sure/texten")
	self._txtinputlang = gohelper.findChildText(self.viewGO, "message/#input_signature/textarea/lang_txt")

	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
end

function RoomLayoutInputBaseView:onUpdateParam()
	self:_refreshInitUI()
end

function RoomLayoutInputBaseView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onEscape, self)
	end

	self:_refreshInitUI()
end

function RoomLayoutInputBaseView:_onEscape()
	self:_btncloseOnClick()
end

function RoomLayoutInputBaseView:_refreshInitUI()
	if self.viewParam then
		local defaultName = self.viewParam.defaultName

		if string.nilorempty(defaultName) then
			self._inputsignature:SetText("")
		else
			self._inputsignature:SetText(defaultName)
		end
	end
end

function RoomLayoutInputBaseView:_closeInvokeCallback(isYes, contentStr)
	if not self.viewParam then
		return
	end

	if isYes then
		if self.viewParam.yesCallback then
			if self.viewParam.callbockObj then
				self.viewParam.yesCallback(self.viewParam.callbockObj, contentStr)
			else
				self.viewParam.yesCallback(contentStr)
			end
		end
	elseif self.viewParam.noCallback then
		self.viewParam.noCallback(self.viewParam.noCallbackObj)
	end
end

function RoomLayoutInputBaseView:onClose()
	return
end

function RoomLayoutInputBaseView:onDestroyView()
	self._simagerightbg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
end

return RoomLayoutInputBaseView
