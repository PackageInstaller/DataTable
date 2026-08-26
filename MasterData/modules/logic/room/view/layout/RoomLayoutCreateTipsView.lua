-- chunkname: @modules/logic/room/view/layout/RoomLayoutCreateTipsView.lua

module("modules.logic.room.view.layout.RoomLayoutCreateTipsView", package.seeall)

local RoomLayoutCreateTipsView = class("RoomLayoutCreateTipsView", BaseView)

function RoomLayoutCreateTipsView:onInitView()
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_select")
	self._goselect = gohelper.findChild(self.viewGO, "#btn_select/txt_desc/#go_select")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_cancel")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_sure")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutCreateTipsView:addEvents()
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
end

function RoomLayoutCreateTipsView:removeEvents()
	self._btnselect:RemoveClickListener()
	self._btncancel:RemoveClickListener()
	self._btnsure:RemoveClickListener()
end

function RoomLayoutCreateTipsView:_btnselectOnClick()
	self:_setSelect(self._isSelect == false)
end

function RoomLayoutCreateTipsView:_btncancelOnClick()
	self:closeThis()
	self:_closeInvokeCallback()
end

function RoomLayoutCreateTipsView:_btnsureOnClick()
	self:closeThis()
	self:_closeInvokeCallback(true)
end

function RoomLayoutCreateTipsView:_editableInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "txt_desc")

	self:_setSelect(true)
	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))

	self._txtdescTrs = self._txtdesc.transform
	self._descX, self._descY = transformhelper.getLocalPos(self._txtdescTrs)

	local bgX, bgY = transformhelper.getLocalPos(self._simagetipbg.transform)

	self._hidY = bgY
end

function RoomLayoutCreateTipsView:onUpdateParam()
	self:_refreshInitUI()
end

function RoomLayoutCreateTipsView:onOpen()
	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onEscape, self)
	end

	self:_refreshInitUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function RoomLayoutCreateTipsView:_onEscape()
	self:_btncancelOnClick()
end

function RoomLayoutCreateTipsView:onClose()
	return
end

function RoomLayoutCreateTipsView:onDestroyView()
	self._simagetipbg:UnLoadImage()
end

function RoomLayoutCreateTipsView:_refreshInitUI()
	if self.viewParam then
		if self.viewParam.isSelect ~= nil then
			self:_setSelect(self.viewParam.isSelect)
		end

		if self.viewParam.titleStr ~= nil then
			self._txtdesc.text = self.viewParam.titleStr
		end

		if self.viewParam.isShowSetlect ~= nil then
			self:_setShowSelect(self.viewParam.isShowSetlect)
		end
	end
end

function RoomLayoutCreateTipsView:_closeInvokeCallback(isYes)
	if isYes then
		if self.viewParam.yesCallback then
			local isSelect = not not self._isSelect

			if self.viewParam.callbockObj then
				self.viewParam.yesCallback(self.viewParam.callbockObj, isSelect)
			else
				self.viewParam.yesCallback(isSelect)
			end
		end
	elseif self.viewParam.noCallback then
		self.viewParam.noCallback(self.viewParam.noCallbackObj)
	end
end

function RoomLayoutCreateTipsView:_setSelect(isSelect)
	self._isSelect = not not isSelect

	gohelper.setActive(self._goselect, self._isSelect)
end

function RoomLayoutCreateTipsView:_setShowSelect(isShow)
	gohelper.setActive(self._btnselect, isShow)
	transformhelper.setLocalPosXY(self._txtdescTrs, self._descX, (isShow or nil) and (self._descY or self._hidY))
end

return RoomLayoutCreateTipsView
