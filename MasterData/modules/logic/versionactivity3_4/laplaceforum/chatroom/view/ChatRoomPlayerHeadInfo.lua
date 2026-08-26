-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomPlayerHeadInfo.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomPlayerHeadInfo", package.seeall)

local ChatRoomPlayerHeadInfo = class("ChatRoomPlayerHeadInfo", ListScrollCellExtend)

function ChatRoomPlayerHeadInfo:onInitView()
	self._goinfoContent = gohelper.findChild(self.viewGO, "infoContent")
	self._goemoji = gohelper.findChild(self.viewGO, "infoContent/emoji")
	self._simageemoji = gohelper.findChildSingleImage(self.viewGO, "infoContent/emoji/#simage_emoji")
	self._gotitle = gohelper.findChild(self.viewGO, "infoContent/#go_title")
	self._imagetitleBg = gohelper.findChildImage(self.viewGO, "infoContent/#go_title/#image_titleBg")
	self._txttitle = gohelper.findChildText(self.viewGO, "infoContent/#go_title/#txt_title")
	self._imagenameBg = gohelper.findChildImage(self.viewGO, "infoContent/#go_name/bg1/#image_nameBg")
	self._goname = gohelper.findChild(self.viewGO, "infoContent/#go_name")
	self._txtname = gohelper.findChildText(self.viewGO, "infoContent/#go_name/bg1/#txt_name")
	self._goSelect = gohelper.findChild(self.viewGO, "infoContent/#go_name/bg1/#image_select")

	if self._editableInitView then
		self:_editableInitView()
	end

	self.showChatTime = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.ShowChatTime, true)
end

function ChatRoomPlayerHeadInfo:addEvents()
	ChatRoomController.instance:registerCallback(ChatRoomEvent.OnShowNpcPlayerType, self.showSelect, self)
end

function ChatRoomPlayerHeadInfo:removeEvents()
	ChatRoomController.instance:unregisterCallback(ChatRoomEvent.OnShowNpcPlayerType, self.showSelect, self)
end

function ChatRoomPlayerHeadInfo:_editableInitView()
	self.emojiAnim = self._goemoji:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goemoji, false)
	gohelper.setActive(self._txtname, false)
end

function ChatRoomPlayerHeadInfo:onUpdateMO(mo)
	self._mo = mo
	self._txtname.text = self._mo.name

	local titleCo = TitleAppointmentConfig.instance:getTitleCo(self._mo.titleId)

	if titleCo then
		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagetitleBg, titleCo.titleBackground)

		self._txttitle.text = titleCo.titleName
	end

	gohelper.setActive(self._txtname, true)
	gohelper.setActive(self._gotitle, self._mo.titleId > 0 and titleCo)
end

function ChatRoomPlayerHeadInfo:setNameBg(isMainPlayer)
	if isMainPlayer then
		local imageIcon = string.format("v3a4_party_chatroom_namebg" .. (ChatRoomEnum.NameBgType.MainPlayer or ChatRoomEnum.NameBgType.OtherPlayer))

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagenameBg, imageIcon)
	end
end

function ChatRoomPlayerHeadInfo:showEmoji(emoji)
	if not emoji or emoji <= 0 then
		return
	end

	gohelper.setActive(self._goemoji, true)

	local emojiConfig = Activity225Config.instance:getMemeConfig(emoji)

	self._simageemoji:LoadImage(emojiConfig.icon)
	TaskDispatcher.cancelTask(self._delayHideEmoji, self)
	TaskDispatcher.runDelay(self._delayHideEmoji, self, self.showChatTime)
end

function ChatRoomPlayerHeadInfo:_delayHideEmoji()
	self.emojiAnim:Play("out", 0, 0)
	self.emojiAnim:Update(0)
	TaskDispatcher.runDelay(self.hideEmoji, self, 0.167)
end

function ChatRoomPlayerHeadInfo:hideEmoji()
	gohelper.setActive(self._goemoji, false)
end

function ChatRoomPlayerHeadInfo:bindPlayerGo(entity)
	if self._uiFollower then
		return
	end

	self._uiFollower = gohelper.onceAddComponent(self._goinfoContent, typeof(ZProj.UIFollower))

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform
	local headPosGO = UnityEngine.GameObject.New("headPos")

	gohelper.addChild(entity, headPosGO)
	transformhelper.setLocalPos(headPosGO.transform, 0, 3, 0)
	self._uiFollower:Set(mainCamera, uiCamera, plane, headPosGO.transform, 0, 0, 0, 0, 0)
	self._uiFollower:ForceUpdate()
	self._uiFollower:SetBillboardRoot(entity.transform)
	self._uiFollower:SetUseBillboard(true)
	self._uiFollower:SetEnable(true)
end

function ChatRoomPlayerHeadInfo:showSelect(roleInfo)
	gohelper.setActive(self._goSelect, roleInfo and roleInfo.roleType == ChatRoomEnum.NpcType.Player and roleInfo.roleId == self._mo.userId)
end

function ChatRoomPlayerHeadInfo:onDestroyView()
	TaskDispatcher.cancelTask(self._delayHideEmoji, self)
	TaskDispatcher.cancelTask(self.hideEmoji, self)
end

return ChatRoomPlayerHeadInfo
