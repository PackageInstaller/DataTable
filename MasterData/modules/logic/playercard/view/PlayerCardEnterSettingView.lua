-- chunkname: @modules/logic/playercard/view/PlayerCardEnterSettingView.lua

module("modules.logic.playercard.view.PlayerCardEnterSettingView", package.seeall)

local PlayerCardEnterSettingView = class("PlayerCardEnterSettingView", BaseView)

function PlayerCardEnterSettingView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_leftbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._goselected = gohelper.findChild(self.viewGO, "#go_changing")

	local gomask = gohelper.findChild(self.viewGO, "mask")

	self._btnmask = gohelper.getClick(gomask)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardEnterSettingView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnmask:AddClickListener(self._btncloseOnClick, self)
end

function PlayerCardEnterSettingView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btnmask:RemoveClickListener()
end

function PlayerCardEnterSettingView:_btnselectOnClick(index)
	if self._selectIndex == index then
		return
	end

	self._selectIndex = index

	self:_refreshSelect(index)
end

function PlayerCardEnterSettingView:_btncloseOnClick()
	self:closeThis()
end

function PlayerCardEnterSettingView:_btnconfirmOnClick()
	self._playercardinfo:setShowEnterAnimType(self._skinId, self._selectIndex)

	self._curEnterAnimType = self._playercardinfo:getShowEnterAnimType(self._skinId)

	self:_refreshCur()
	self:_refreshBtn()
	ToastController.instance:showToast(ToastEnum.SwitchPlayerCardEnterAnim)
	self:closeThis()
end

function PlayerCardEnterSettingView:onClickModalMask()
	self:closeThis()
end

function PlayerCardEnterSettingView:_editableInitView()
	self._cardItem = self:getUserDataTb_()

	require("tolua.reflection")
	tolua.loadassembly("Coffee.SoftMaskForUGUI")

	local type = tolua.findtype("Coffee.UISoftMask.SoftMaskable")

	for i = 1, 2 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "img_card" .. i)
		item.gocur = gohelper.findChild(item.go, "#go_icon")
		item.goselect = gohelper.findChild(item.go, "#go_select")
		item.videoroot = gohelper.findChild(item.go, "mask/videoroot")
		item.btnselect = gohelper.findChildButtonWithAudio(item.go, "#btn_select")

		item.btnselect:AddClickListener(self._btnselectOnClick, self, i)

		local width = recthelper.getWidth(item.videoroot.transform)
		local height = recthelper.getHeight(item.videoroot.transform)

		item.videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(item.videoroot, nil, true, width, height)

		gohelper.onceAddComponent(item.videoPlayer._videoGo, type)

		self._cardItem[i] = item
	end
end

function PlayerCardEnterSettingView:onUpdateParam()
	return
end

function PlayerCardEnterSettingView:onOpen()
	self:_initCard()
end

function PlayerCardEnterSettingView:_initCard()
	self._playercardinfo = self.viewParam.playercardinfo or PlayerCardModel.instance:getCardInfo()
	self._skinId = self.viewParam.SkinId or self._playercardinfo:getThemeId()
	self._curEnterAnimType = self._playercardinfo:getShowEnterAnimType(self._skinId)
	self._selectIndex = self._curEnterAnimType

	local enterAnim = PlayerCardEnum.Theme[self._skinId].EnterAnim

	for i, item in ipairs(self._cardItem) do
		gohelper.setActive(item.gocur, self._curEnterAnimType == i)
		gohelper.setActive(item.goselect, self._curEnterAnimType == i)
		gohelper.setActive(item.videoroot, self._curEnterAnimType == i)

		item.videoName = enterAnim[i].videoName

		if not string.nilorempty(item.videoName) then
			item.videoPlayer:loadMedia(item.videoName)
		end
	end

	local selectItem = self._cardItem[self._curEnterAnimType]

	if selectItem then
		selectItem.videoPlayer:play(selectItem.videoName, true)
	end

	self:_refreshBtn()
end

function PlayerCardEnterSettingView:_refreshBtn()
	gohelper.setActive(self._btnconfirm.gameObject, self._selectIndex ~= self._curEnterAnimType)
	gohelper.setActive(self._goselected.gameObject, self._selectIndex == self._curEnterAnimType)
end

function PlayerCardEnterSettingView:_refreshSelect()
	for i, item in ipairs(self._cardItem) do
		gohelper.setActive(item.goselect, self._selectIndex == i)
		gohelper.setActive(item.videoroot, self._selectIndex == i)

		if not string.nilorempty(item.videoName) then
			if self._selectIndex == i then
				item.videoPlayer:play(item.videoName, true)
			else
				item.videoPlayer:stop()
			end
		end
	end

	self:_refreshBtn()
end

function PlayerCardEnterSettingView:_refreshCur()
	for i, item in ipairs(self._cardItem) do
		gohelper.setActive(item.gocur, self._curEnterAnimType == i)
	end
end

function PlayerCardEnterSettingView:onClose()
	for _, item in ipairs(self._cardItem) do
		item.btnselect:RemoveClickListener()

		if item.videoPlayer then
			item.videoPlayer:stop()
			item.videoPlayer:clear()

			item.videoPlayer = nil
		end
	end
end

function PlayerCardEnterSettingView:onDestroyView()
	return
end

return PlayerCardEnterSettingView
