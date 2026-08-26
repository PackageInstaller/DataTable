-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcInfoComp.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcInfoComp", package.seeall)

local ChatRoomNpcInfoComp = class("ChatRoomNpcInfoComp", LuaCompBase)

function ChatRoomNpcInfoComp:ctor(npcInfoData)
	self.npcInfoData = npcInfoData
	self.config = npcInfoData.npcConfig
end

function ChatRoomNpcInfoComp:init(go)
	self.go = go
	self.trans = go.transform
	self._goInfoContent = gohelper.findChild(self.go, "#go_infoContent")
	self._gobubbleTips = gohelper.findChild(self.go, "#go_infoContent/#go_bubbletips")
	self._goTitle = gohelper.findChild(self.go, "#go_infoContent/#go_title")
	self._txtTitle = gohelper.findChildText(self.go, "#go_infoContent/#go_title/#txt_title")
	self._imagetitleBg = gohelper.findChildImage(self.go, "#go_infoContent/#go_title/#image_titleBg")
	self._goName = gohelper.findChild(self.go, "#go_infoContent/#go_name")
	self._imagenameBg = gohelper.findChildImage(self.go, "#go_infoContent/#go_name/#image_nameBg")
	self._txtName = gohelper.findChildText(self.go, "#go_infoContent/#go_name/#txt_name")
	self._goSelect = gohelper.findChild(self.go, "#go_infoContent/#go_name/#image_select")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#go_infoContent/#btn_click")

	local uiRoot = ViewMgr.instance:getUIRoot().transform

	self.screenWidth = recthelper.getWidth(uiRoot)
	self.screenHeight = recthelper.getHeight(uiRoot)
	self.maxWidth = 0.5 * self.screenWidth
	self.minWidth = -self.maxWidth
	self.maxHeight = 0.5 * self.screenHeight
	self.minHeight = -self.maxHeight

	gohelper.setActive(self._goInfoContent, false)
	gohelper.setActive(self._gobubbleTips, false)
	TaskDispatcher.runRepeat(self.checkBubbleTipShow, self, 0)

	self.bubbleGOMap = {}

	for npcType = ChatRoomEnum.NpcType.QAndA, ChatRoomEnum.NpcType.EasterEgg do
		self.bubbleGOMap[npcType] = gohelper.findChild(self.go, "#go_infoContent/#go_bubbletips/#go_bubble" .. npcType)
	end

	self._goQAndAReddot = gohelper.findChild(self.go, "#go_infoContent/#go_bubbletips/#go_bubble1/#go_reddot1")
	self._goFingerGameReddot = gohelper.findChild(self.go, "#go_infoContent/#go_bubbletips/#go_bubble2/#go_reddot2")

	RedDotController.instance:addRedDot(self._goQAndAReddot, RedDotEnum.DotNode.V3a4LaplaceChatRoomQAndA)
	RedDotController.instance:addRedDot(self._goFingerGameReddot, RedDotEnum.DotNode.V3a4LaplaceChatRoomRSP)
	self:addEventListeners()
end

function ChatRoomNpcInfoComp:addEventListeners()
	ChatRoomController.instance:registerCallback(ChatRoomEvent.OnNpcLoadFinish, self.onNpcLoadFinish, self)
	ChatRoomController.instance:registerCallback(ChatRoomEvent.OnShowNpcPlayerType, self.showSelect, self)
	self._btnClick:AddClickListener(self.onClick, self)
end

function ChatRoomNpcInfoComp:removeEventListeners()
	ChatRoomController.instance:unregisterCallback(ChatRoomEvent.OnNpcLoadFinish, self.onNpcLoadFinish, self)
	ChatRoomController.instance:unregisterCallback(ChatRoomEvent.OnShowNpcPlayerType, self.showSelect, self)
	self._btnClick:RemoveClickListener()
end

function ChatRoomNpcInfoComp:onClick()
	if self.npcInfoData.npcType == ChatRoomEnum.NpcType.QAndA then
		local questionId = ChatRoomModel.instance:getCurQuestionId()

		if questionId and questionId > 0 then
			ChatRoomController.instance:openNpcQAndAView(questionId)
		end
	elseif self.npcInfoData.npcType == ChatRoomEnum.NpcType.FingerGame then
		ChatRoomController.instance:openChatRoomFingerGameView()
	elseif self.npcInfoData.npcType == ChatRoomEnum.NpcType.EasterEgg then
		ChatRoomController.instance:openNpcEasterEggView(self.config.npcId)
	end
end

function ChatRoomNpcInfoComp:onNpcLoadFinish(npcId)
	if npcId == self.config.npcId then
		gohelper.setActive(self._goInfoContent, true)
	end
end

function ChatRoomNpcInfoComp:checkBubbleTipShow()
	local posX, posY = recthelper.getAnchor(self._goInfoContent.transform)
	local canShowInfo = posX >= self.minWidth and posX <= self.maxWidth and posY >= self.minHeight and posY <= self.maxHeight

	gohelper.setActive(self._gobubbleTips, canShowInfo)
end

function ChatRoomNpcInfoComp:refresh()
	gohelper.setActive(self._goTitle, self.config.titleId > 0)

	if self.config.titleId > 0 then
		local titleCo = TitleAppointmentConfig.instance:getTitleCo(self.config.titleId)

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagetitleBg, titleCo.titleBackground)

		if titleCo then
			self._txtTitle.text = titleCo.titleName or ""
		end
	end

	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagenameBg, "v3a4_party_chatroom_namebg" .. ChatRoomEnum.NameBgType.Npc)

	self._txtName.text = self.config.npcName

	for npcType, goBubble in pairs(self.bubbleGOMap) do
		gohelper.setActive(goBubble, npcType == self.npcInfoData.npcType)
	end
end

function ChatRoomNpcInfoComp:bindNpcInfoGo(npcGO)
	if self._uiFollower then
		return
	end

	self._uiFollower = gohelper.onceAddComponent(self._goInfoContent, typeof(ZProj.UIFollower))

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform
	local headPosGO = UnityEngine.GameObject.New("headPos")

	gohelper.addChild(npcGO, headPosGO)

	local headOffsetY = self.npcInfoData.npcType == ChatRoomEnum.NpcType.EasterEgg and 3 or 2

	transformhelper.setLocalPos(headPosGO.transform, 0, headOffsetY, 0)
	self._uiFollower:Set(mainCamera, uiCamera, plane, headPosGO.transform, 0, 0, 0, 0, 0)
	self._uiFollower:ForceUpdate()
	self._uiFollower:SetBillboardRoot(npcGO.transform)
	self._uiFollower:SetUseBillboard(true)
	self._uiFollower:SetEnable(true)
end

function ChatRoomNpcInfoComp:showSelect(roleInfo)
	gohelper.setActive(self._goSelect, roleInfo and roleInfo.roleType ~= ChatRoomEnum.NpcType.Player and roleInfo.roleId == self.config.npcId)
end

function ChatRoomNpcInfoComp:onDestroy()
	TaskDispatcher.cancelTask(self.checkBubbleTipShow, self)
end

return ChatRoomNpcInfoComp
