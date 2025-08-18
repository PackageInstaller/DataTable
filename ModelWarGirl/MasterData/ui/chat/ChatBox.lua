-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ChatBox.lua

local ResUpperLimit = require("ClientData/ResUpperLimit")
local Circle = require("Common/Object/Circle")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResInfoNotice = require("ClientData/ResInfoNotice")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local ResItem = require("ClientData/ResItem")
local ResRoleHeadPendant = require("ClientData/ResRoleHeadPendant")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResGiftDrawMisc = require("ClientData/ResGiftDrawMisc")
local ResGiftDrawDetail = require("ClientData/ResGiftDrawDetail")
local ResMasterNotice = require("ClientData/ResMasterNotice")
local ResRoleChatBubble = require("ClientData/ResRoleChatBubble")
local strClassName = "ChatBox"
local ChatBox = Class(strClassName, UIControls.Panel)
local TOTAL_WIDTH
local VOCIE_AUDIO_WIDTH = 300
local VOCIE_AUDIO_HEIGHT = 45
local BG_WIDTH = 44
local BG_HEIGHT = 40
local BG_HEIGHT_LARGE_EMOJI = 20
local BG_TO_TOTAL_OFFSET = 60
local MAX_NAME_WIDTH = 240
local NORMAL_FONT_SIZE = 32
local LARGE_EMOJI_SIZE = 224
local SHARE_HEIGHT = 134.4
local RED_PACKET_HEIGHT = 204
local CIRCLE_SHAGE_HEIGHT = 219
local LARGE_EMOJI_HEIGHT = 170
local DYNAMIC_ICON_HEIGHT = 250
local ICON_PATH = "Atlas/FriendAtlas/FriendAtlas"
local HOUSE_SHARE_DEC_ID = 286
local MASTER_BG_HIGHT = 136
local RED_ICON_PATH = "Atlas/ChatAtlas/RedMoneyAtlas"

function ChatBox:ctor(parent, path, isSelf)
	self:initUI()

	self.isSelf = isSelf
end

function ChatBox:initUI()
	self.btnHead = UIControls.PlayerHeadGridChild(self, self.mPath .. "/GridPlayer", "System/Common/Grid/GridPlayerCommon")

	self.btnHead:hideLevel()

	self.labelName = UIControls.Label(self, self.mPath .. "/TextPlayerName")
	self.imgSex = UIControls.Image(self, self.mPath .. "/TextPlayerName/ImgSex")
	self.panelVip = UIControls.PanelPlayerVip(self, self.mPath .. "/TextPlayerName/VIPPanel")
	self.txtHonour = UIControls.Label(self, self.mPath .. "/TextPlayerName/EmojiText", true)
	self.imgMessageBg = UIControls.Image(self, self.mPath .. "/BgMessage")
	self.imgChatBubble = UIControls.Image(self, self.mPath .. "/BgMessage/ImgChatBubble")
	self.labelContext = UIControls.Label(self, self.mPath .. "/BgMessage/TextMessage", true)
	self.txtEmojiLarge = UIControls.Label(self, self.mPath .. "/TextEmojiLarge", true)
	self.bgrect = UIControls.Image(self, self.mPath .. "/BgMessage")
	self.labelVoiceLength = UIControls.Label(self, self.mPath .. "/VoiceAudio/Text")
	self.moveEmojiPanel = UIControls.Panel(self, self.mPath .. "/MoveEmoji")

	local battlePath = self.mPath .. "/BgMessageBattleShare"

	self.imgBattleShare = UIControls.Image(self, battlePath)
	self.imgBattleChatBubble = UIControls.Image(self, battlePath .. "/ImgChatBubble")
	self.imgBattleIcon = UIControls.Image(self, battlePath .. "/Icon")
	self.txtBattleTitle = UIControls.Label(self, battlePath .. "/TextBattle")
	self.txtBattleProgress = UIControls.Label(self, battlePath .. "/TextProgress")
	self.txtWatch2 = UIControls.Label(self, battlePath .. "/TextWatch2")
	self.btnBattleReplay = UIControls.Button(self, battlePath .. "/BtnGo")

	self.btnBattleReplay:addEventClick(self.onBtnBattleReplayClick)

	self.btnRedPacket = UIControls.Button(self, self.mPath .. "/BtnRedMoney")

	self.btnRedPacket:addEventClick(self.onBtnRedPacketClick)

	self.txtBlessing = UIControls.Label(self, self.mPath .. "/BtnRedMoney/TextBlessing")
	self.imgRedNml = UIControls.Image(self, self.mPath .. "/BtnRedMoney/ImgNml")
	self.txtRedNmlGet = UIControls.Label(self, self.mPath .. "/BtnRedMoney/ImgNml/TextGet")
	self.imgRedDis = UIControls.Image(self, self.mPath .. "/BtnRedMoney/ImgDis")
	self.txtNormalRed = UIControls.Label(self, self.mPath .. "/BtnRedMoney/TextType1")
	self.txtSuperRed = UIControls.Label(self, self.mPath .. "/BtnRedMoney/TextType2")
	self.imgCircleShareMessageBg = UIControls.Image(self, self.mPath .. "/BgMessageCircleShare")
	self.imgCircleShareChatBubble = UIControls.Image(self, self.mPath .. "/BgMessageCircleShare/ImgChatBubble")
	self.txtCircleName = UIControls.Label(self, self.mPath .. "/BgMessageCircleShare/TextName")
	self.txtCircleLv = UIControls.Label(self, self.mPath .. "/BgMessageCircleShare/TextLevelPanel/TextLevel")
	self.txtCircleActive = UIControls.Label(self, self.mPath .. "/BgMessageCircleShare/CircleActivePanel/Text")
	self.txtCircleShareContent = UIControls.Label(self, self.mPath .. "/BgMessageCircleShare/TextDes")
	self.btnCheckCircleShare = UIControls.Button(self, self.mPath .. "/BgMessageCircleShare/BtnGo")

	self.btnCheckCircleShare:addEventClick(self.onBtnCheckCircleShareClick)

	self.panelCircleShare = UIControls.Panel(self, self.mPath .. "/BgMessageCircleShare")
	self.imgMarkGridCircleMessageBg = UIControls.Image(self, self.mPath .. "/BgCircleSetFlag")
	self.imgMarkGridCircleChatBubble = UIControls.Image(self, self.mPath .. "/BgCircleSetFlag/ImgChatBubble")
	self.txtMarkGridCircleName = UIControls.Label(self, self.mPath .. "/BgCircleSetFlag/TextName")
	self.txtMarkGridCircleIcon = UIControls.Image(self, self.mPath .. "/BgCircleSetFlag/Icon")
	self.txtMarkGridCircleLevel = UIControls.Label(self, self.mPath .. "/BgCircleSetFlag/TextLevelPanel/TextLevel")
	self.txtMarkGridCircleDes = UIControls.Label(self, self.mPath .. "/BgCircleSetFlag/TextDes")
	self.btnCheckMarkGridCircle = UIControls.Button(self, self.mPath .. "/BgCircleSetFlag/BtnGo")

	self.btnCheckMarkGridCircle:addEventClick(self.onBtnMarkGridCircleClick)

	self.panelMarkGridCircle = UIControls.Panel(self, self.mPath .. "/BgCircleSetFlag")
	self.imgMarkGridCircle = UIControls.Image(self, self.mPath .. "/BgCircleSetFlag")
	self.imgHouseShareMessageBg = UIControls.Image(self, self.mPath .. "/BgMessageBackyardShare")
	self.imgHouseShareChatBubble = UIControls.Image(self, self.mPath .. "/BgMessageBackyardShare/ImgChatBubble")
	self.txtHouseShareName = UIControls.Label(self, self.mPath .. "/BgMessageBackyardShare/TextName")
	self.txtHouseShareFavor = UIControls.Label(self, self.mPath .. "/BgMessageBackyardShare/CircleActivePanel/Text")
	self.txtHouseShareContent = UIControls.Label(self, self.mPath .. "/BgMessageBackyardShare/TextDes")
	self.btnHouseShare = UIControls.Button(self, self.mPath .. "/BgMessageBackyardShare/BtnGo")

	self.btnHouseShare:addEventClick(self.onBtnHouseShareClick)

	self.panelHouseShare = UIControls.Panel(self, self.mPath .. "/BgMessageBackyardShare")
	self.imgHouseShare = UIControls.Image(self, self.mPath .. "/BgMessageBackyardShare")
	self.moveEmoji = nil
	self.imgValentineShareMessageBg = UIControls.Image(self, self.mPath .. "/BgMessageRecipeShare")
	self.imgValentineShareChatBubble = UIControls.Image(self, self.mPath .. "/BgMessageRecipeShare/ImgChatBubble")
	self.panelValentineShare = UIControls.Panel(self, self.mPath .. "/BgMessageRecipeShare")
	self.txtValentineShareName = UIControls.Label(self, self.mPath .. "/BgMessageRecipeShare/TextName")
	self.txtValentineShareContent = UIControls.Label(self, self.mPath .. "/BgMessageRecipeShare/TextDes")
	self.btnValentineShare = UIControls.Button(self, self.mPath .. "/BgMessageRecipeShare/BtnGo")

	self.btnValentineShare:addEventClick(self.onBtnValentineShareClick)

	self.imgPendant = UIControls.Image(self, self.mPath .. "/TextPlayerName/EmojiText/ImgPendant")
	self.efxPendant = UIControls.LazyEffectPlayer(self, self.mPath .. "/TextPlayerName/EmojiText/ImgPendant/Efx")
	self.imgGrouponShareMessageBg = UIControls.Image(self, self.mPath .. "/BgGrouponShare")
	self.imgGrouponShareChatBubble = UIControls.Image(self, self.mPath .. "/BgGrouponShare/ImgChatBubble")
	self.panelGrouponShare = UIControls.Panel(self, self.mPath .. "/BgGrouponShare")
	self.iconGrouponShare = UIControls.Image(self, self.mPath .. "/BgGrouponShare/Icon")
	self.txtNameGrouponShare = UIControls.Label(self, self.mPath .. "/BgGrouponShare/TextName")
	self.txtLevelGrouponShare = UIControls.Label(self, self.mPath .. "/BgGrouponShare/TextLevelPanel/TextLevel")
	self.txtDescGrouponShare = UIControls.Label(self, self.mPath .. "/BgGrouponShare/TextDes")
	self.btnGrouponShare = UIControls.Button(self, self.mPath .. "/BgGrouponShare/BtnGo")

	self.btnGrouponShare:addEventClick(self.onBtnGrouponShareClick)

	self.imgGrouponShare = UIControls.Image(self, self.mPath .. "/BgGrouponShare")
end

function ChatBox:setData(msgItem)
	self.msgItem = msgItem
	self.uid = msgItem.suid

	self:setPlayerUI()

	if msgItem.channel == Const.CHANNEL_PRIVATE then
		TOTAL_WIDTH = 405
	else
		TOTAL_WIDTH = 550
	end

	local h

	if msgItem.share == Const.CHAT_SHARE_TYPE.RED_PACKET then
		h = self:setRedPacketUI()
	elseif msgItem.share == Const.CHAT_SHARE_TYPE.REPLAY then
		h = self:setReplayUI()
	elseif msgItem.share == Const.CHAT_SHARE_TYPE.SPE_NOTICE then
		if msgItem.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.CIRCLE_SHARE then
			h = self:setCircleShareUI()
		elseif msgItem.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.HOUSE_SHARE then
			h = self:setHouseShareUI()
		elseif msgItem.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.VALENTINE_SHARE then
			h = self:setValentineShareUI()
		elseif msgItem.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.CIRCLE_BATTLE then
			h = self:setMarkGridShareUI()
		elseif msgItem.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.GIFT_DRAW then
			h = self:setGiftDrawShareUI()
		end
	end

	if h == nil then
		h = self:_normalMsg()
	end

	h = h + BG_TO_TOTAL_OFFSET

	self:setRectSize(0, h)

	return h
end

function ChatBox:_normalMsg()
	local h

	self.imgBattleShare:setVisible(false)
	self.bgrect:setVisible(true)

	if utils.isMoveEmoji(self.msgItem.content) then
		h = self:setMoveEmojiUI(self.msgItem.content)
	elseif utils.isLargeEmoji(self.msgItem.content) then
		h = self:setLargeEmojiUI()
	elseif utils.isPlayerEmoji(self.msgItem.content) then
		h = self:setPlayerEmojiUI()
	else
		h = self:setCommonMsgUI()
	end

	return h
end

function ChatBox:setRedPacketUI(...)
	self:_hideAllExceptOne(self.btnRedPacket)

	local content = CurAvatar:getMsgBlessingContent(self.msgItem)

	self.txtBlessing:setText(content)

	local isClaimed = CurAvatar:isRedPacketClaimed(self.msgItem.seq)

	self.imgRedNml:setVisible(not isClaimed)
	self.imgRedDis:setVisible(isClaimed)

	local item = ResItem[self.msgItem.share_content.specData.item_id]
	local showType = item.extend_args5 and item.extend_args5[1] or nil

	if showType and showType ~= 1 and ResRedPacketShow[showType] then
		RED_ICON_PATH = "Atlas/ChatAtlas/" .. ResRedPacketShow[showType].chat_image_path

		self.txtRedNmlGet:setText(ResRedPacketShow[showType].chat_str)
	end

	if MsgManager.isNormalRedPacket(self.msgItem) then
		self.txtNormalRed:setText(item.name)
		self.txtNormalRed:setVisible(true)
		self.txtSuperRed:setVisible(false)
		self.imgRedNml:setImage(RED_ICON_PATH, "BgTalkRedMoneyNormal")
		self.imgRedDis:setImage(RED_ICON_PATH, "BgTalkRedMoneyNormalDis")
	else
		self.txtSuperRed:setText(item.name)
		self.txtNormalRed:setVisible(false)
		self.txtSuperRed:setVisible(true)
		self.imgRedNml:setImage(RED_ICON_PATH, "BgTalkRedMoneyHigh")
		self.imgRedDis:setImage(RED_ICON_PATH, "BgTalkRedMoneyHighDis")
	end

	if showType == 2 then
		local ui = UIManager.getUI("redPacketFireWorkDlg", true)

		ui:playEffect()
	end

	return RED_PACKET_HEIGHT
end

function ChatBox:setMoveEmojiUI(...)
	self:_hideAllExceptOne(self.moveEmojiPanel)

	if not self.moveEmoji or self.moveEmoji.iconName ~= self.msgItem.content then
		if self.moveEmoji then
			self.moveEmoji:destroy()
		end

		local name = self.msgItem.content
		local prefabName = UIConst.EMOJI_MOVE_MAP[name].path

		self.moveEmoji = UIControls.Child(self, self.mPath .. "/MoveEmoji", "System/Chat/ChatMoveEmoji/" .. prefabName, 0, 0, true)
	end

	local h = DYNAMIC_ICON_HEIGHT + BG_HEIGHT_LARGE_EMOJI

	return h
end

function ChatBox:setPlayerUI(...)
	self.labelName:setText(self.msgItem.sattr.name)
	self.panelVip:setData(self.msgItem.sattr.vip, self.msgItem.sattr.vip_hide)
	self.btnHead:setEnable(not self.isSelf)

	if self.isSelf then
		self.labelContext:setAlign(UIConst.TXTALIGN_UR)
	else
		self.labelContext:setAlign(UIConst.TXTALIGN_UL)
	end

	local comm = self.msgItem.sattr

	self.btnHead:setCommInfo(comm, true, self)

	if comm.gender == Const.GENDER_MAN then
		self.imgSex:setImage(ICON_PATH, "IconMale")
	else
		self.imgSex:setImage(ICON_PATH, "IconFemale")
	end

	self.imgPendant:setVisible(false)

	if comm.head_pendant_id and comm.head_pendant_end_time then
		if comm.head_pendant_end_time < ClientUtils.getServerTime() then
			self.imgPendant:setVisible(false)
		else
			self.imgPendant:setVisible(true)

			if ResRoleHeadPendant[comm.head_pendant_id] then
				local pendantData = ResRoleHeadPendant[comm.head_pendant_id]

				self.imgPendant:setImage(pendantData.picture_path, pendantData.picture_name)

				if pendantData.effect_path then
					self.efxPendant:playEffectByPath(pendantData.effect_path)
					self.efxPendant:setVisible(true)
				else
					self.efxPendant:setVisible(false)
				end
			end
		end
	end

	local content = ""

	if comm.help_cnt then
		local icon = MsgManager.getRentEmoji(comm.help_cnt, comm.uid)

		if icon then
			content = content .. icon
		end
	end

	if self.msgItem.channel == Const.CHANNEL_GUILD then
		local preFix = MsgManager.getCirclePreFix(self.msgItem, comm.uid ~= CurAvatar.uid)

		if preFix then
			content = content .. preFix
		end
	end

	self.txtHonour:setVisible(true)
	self.txtHonour:setText(content)
end

function ChatBox:refreshChatBubble(imgMessageBg, imgChatBubble)
	local comm = self.msgItem.sattr
	local bubbleId = comm.chat_bubble_id
	local bubbleConfig

	if bubbleId and ResRoleChatBubble[bubbleId] then
		local endTime = comm.chat_bubble_end_time
		local checkTime = not endTime or endTime == 0 or endTime > ClientUtils.getServerTime()

		if checkTime then
			bubbleConfig = ResRoleChatBubble[bubbleId]
		end
	end

	imgMessageBg:setObjEnabled(bubbleConfig == nil)
	imgChatBubble:setVisible(bubbleConfig ~= nil)

	if bubbleConfig then
		imgChatBubble:setImage("Atlas/ChatAtlas/" .. bubbleConfig.picture_path, bubbleConfig.picture_name)

		if self.bubbleChild then
			self.bubbleChild:destroy()

			self.bubbleChild = nil
		end

		if bubbleConfig.effect_path then
			self.bubbleChild = UIControls.Child(self, self.mPath .. "/BgMessage/ImgChatBubble", bubbleConfig.effect_path)

			self.bubbleChild:setVisible(true)
		end
	end
end

function ChatBox:setReplayUI(...)
	self:_hideAllExceptOne(self.imgBattleShare)
	self:refreshChatBubble(self.imgBattleShare, self.imgBattleChatBubble)

	local battleType = self.msgItem.share_content.battle_type
	local value = self.msgItem.share_content.param
	local specData = self.msgItem.share_content.specData
	local info = UIConst.getBattleShareInfo(battleType, value, specData)

	if info and info.icon then
		self.imgBattleIcon:setImage("Atlas/ChatAtlas/ChatAtlas1", info.icon)
		self.txtBattleTitle:setText(info.name or "")
		self.txtBattleProgress:setText(info.desc or "")

		if info.watchDesc and info.watchDesc ~= "" then
			self.txtWatch2:setText(info.watchDesc)
		else
			self.txtWatch2:setText(Lang.get(736))
		end
	end

	local h = self.txtWatch2:getHeight()
	local hOffset = 0

	if h > 42 then
		hOffset = h - 28

		local size = self.imgBattleShare:getSize()

		self.imgBattleShare:setSize(size.width, 148 + hOffset)
	end

	return SHARE_HEIGHT + hOffset
end

function ChatBox:setLargeEmojiUI(...)
	self:_hideAllExceptOne(self.txtEmojiLarge)
	self.txtEmojiLarge:setText(self.msgItem.content)

	local h = LARGE_EMOJI_HEIGHT + BG_HEIGHT_LARGE_EMOJI

	self.txtEmojiLarge:setVisible(true)
	self.bgrect:setVisible(false)

	return h
end

function ChatBox:setPlayerEmojiUI()
	self:_hideAllExceptOne(self.txtEmojiLarge)
	self.txtEmojiLarge:setText(self.msgItem.content)

	local h = LARGE_EMOJI_HEIGHT + BG_HEIGHT_LARGE_EMOJI

	self.txtEmojiLarge:setVisible(true)
	self.bgrect:setVisible(false)

	return h
end

function ChatBox:setCommonMsgUI(...)
	self:_hideAllExceptOne(self.bgrect)
	self:refreshChatBubble(self.imgMessageBg, self.imgChatBubble)

	local format = MsgManager.getMsgColorFormatByMsg(self.msgItem)

	if format then
		self.labelContext:setText(string.format(format, self.msgItem.content))
	else
		self.labelContext:setText(self.msgItem.content)
	end

	local width = self.labelContext:getWidth()
	local w = math.min(width, TOTAL_WIDTH)

	if w ~= width then
		self.labelContext:setAlign(UIConst.TXTALIGN_UL)
	end

	self.labelContext:setSize(TOTAL_WIDTH, self.labelContext:getHeight())

	local h = self.labelContext:getHeight() + BG_HEIGHT

	w = w + BG_WIDTH

	if self.imgChatBubble:getVisible() then
		w = w + 20
	end

	self.bgrect:setVisible(true)
	self.txtEmojiLarge:setVisible(false)
	self.bgrect:setSize(w, h)

	return h
end

function ChatBox:setCircleShareUI(...)
	self:_hideAllExceptOne(self.panelCircleShare)
	self:refreshChatBubble(self.imgCircleShareMessageBg, self.imgCircleShareChatBubble)

	if not self.gridCircle then
		self.gridCircle = UIControls.GridCircleCommonChild(self, self.mPath .. "/BgMessageCircleShare/CircleHeadPanel", "System/Common/Grid/GridCircleCommon", 0, 0, true)
		self.gridCircle.mEnableTips = false
	end

	local data = self.msgItem.share_content.specData

	self.gridCircle:setCircle(Circle(data.base, true))
	self.txtCircleName:setText(data.base.clanname)
	self.txtCircleLv:setText(data.base.level)
	self.txtCircleActive:setText(data.base.weekfeat)
	self.txtCircleShareContent:setText(data.content)

	return CIRCLE_SHAGE_HEIGHT
end

function ChatBox:setHouseShareUI(...)
	self:_hideAllExceptOne(self.panelHouseShare)
	self:refreshChatBubble(self.imgHouseShareMessageBg, self.imgHouseShareChatBubble)

	local data = self.msgItem.share_content.specData
	local houseName = string.format(Lang.get(61548), self.msgItem.sattr.name)
	local houseFavor = data.favor or 0
	local shareContent = ResInfoNotice[HOUSE_SHARE_DEC_ID].content

	self.txtHouseShareName:setText(houseName)
	self.txtHouseShareFavor:setText(houseFavor)
	self.txtHouseShareContent:setText(shareContent)

	local h = self.txtHouseShareContent:getHeight()
	local hOffset = 0

	if h > 42 then
		hOffset = h - 28

		local size = self.imgHouseShare:getSize()

		self.imgHouseShare:setSize(size.width, 219 + hOffset)
	end

	return CIRCLE_SHAGE_HEIGHT + hOffset
end

function ChatBox:setGiftDrawShareUI()
	self:_hideAllExceptOne(self.panelGrouponShare)
	self:refreshChatBubble(self.imgGrouponShareMessageBg, self.imgGrouponShareChatBubble)

	local data = self.msgItem.share_content.specData
	local actId = data.act_id
	local lackNum = data.lack_num
	local levelId = data.level
	local resMiscData = ResGiftDrawMisc[actId]

	if resMiscData then
		local content = utils.format(resMiscData.share_content or "%1s", lackNum)

		self.txtDescGrouponShare:setText(content)
		self.txtNameGrouponShare:setText(resMiscData.share_title)

		local priceTitle = ""

		for i, v in pairs(ResGiftDrawDetail[actId]) do
			if v.level_id == levelId then
				priceTitle = v.price_title
			end
		end

		self.txtLevelGrouponShare:setText(priceTitle)

		if resMiscData.share_icon_path and resMiscData.share_icon then
			self.iconGrouponShare:setImage(resMiscData.share_icon_path, resMiscData.share_icon)
		end
	end

	local h = self.txtDescGrouponShare:getHeight()
	local hOffset = 0

	if h > 42 then
		hOffset = h - 28

		local size = self.imgGrouponShare:getSize()

		self.imgGrouponShare:setSize(size.width, 219 + hOffset)
	end

	return CIRCLE_SHAGE_HEIGHT + hOffset
end

function ChatBox:setValentineShareUI(...)
	self:_hideAllExceptOne(self.panelValentineShare)
	self:refreshChatBubble(self.imgValentineShareMessageBg, self.imgValentineShareChatBubble)
	self.txtValentineShareName:setText(string.format(Lang.get(66178), self.msgItem.sattr.name))

	local data = self.msgItem.share_content.specData

	self.txtValentineShareContent:setText(ClientUtils.getValentineShareContent(data.template_id, data.gift_id) or "")

	local clientItem = BaseObject.GetObject(data.gift_id, 1)

	if not self.valenShareGrid then
		self.valenShareGrid = UIControls.getGridChild(clientItem, self, self.mPath .. "/BgMessageRecipeShare/ItemNode")

		self.valenShareGrid:setVisible(true)
	end

	self.valenShareGrid:setObj(clientItem)

	return 220
end

function ChatBox:setMarkGridShareUI(...)
	self:_hideAllExceptOne(self.panelMarkGridCircle)
	self:refreshChatBubble(self.imgMarkGridCircleMessageBg, self.imgMarkGridCircleChatBubble)

	local data = self.msgItem.share_content.specData

	self.txtMarkGridCircleDes:setText(self.msgItem.content)
	self.txtMarkGridCircleLevel:setText(string.format(Lang.get(74319), data.param1))

	local h = self.txtMarkGridCircleDes:getHeight()
	local hOffset = 0

	if h > 42 then
		hOffset = h - 28

		local size = self.imgMarkGridCircle:getSize()

		self.imgMarkGridCircle:setSize(size.width, CIRCLE_SHAGE_HEIGHT + hOffset)
	end

	return CIRCLE_SHAGE_HEIGHT + hOffset
end

function ChatBox:onBtnMarkGridCircleClick()
	local data = self.msgItem.share_content.specData

	if not data or not data.param1 or not data.param2 then
		MsgManager.notice(Lang.get(74320))
	else
		CurAvatar:enterClanBattle(data.param1, data.param2 + 1, self.jumpCallBack)
	end
end

function ChatBox.jumpCallBack()
	UIManager.tryHideUI("chatDlg")
end

function ChatBox:_hideAllExceptOne(oneUI)
	self.btnRedPacket:setVisible(self.btnRedPacket == oneUI)
	self.imgBattleShare:setVisible(self.imgBattleShare == oneUI)
	self.bgrect:setVisible(self.bgrect == oneUI)
	self.txtEmojiLarge:setVisible(self.txtEmojiLarge == oneUI)
	self.moveEmojiPanel:setVisible(self.moveEmojiPanel == oneUI)
	self.panelCircleShare:setVisible(self.panelCircleShare == oneUI)
	self.panelHouseShare:setVisible(self.panelHouseShare == oneUI)
	self.panelValentineShare:setVisible(self.panelValentineShare == oneUI)
	self.panelMarkGridCircle:setVisible(self.panelMarkGridCircle == oneUI)
	self.panelGrouponShare:setVisible(self.panelGrouponShare == oneUI)
end

function ChatBox:onBtnCheckCircleShareClick(...)
	if self.msgItem.share == Const.CHAT_SHARE_TYPE.SPE_NOTICE and self.msgItem.share_content.specData.notice_type == Const.CHAT_SPEC_NOTICE_TYPE.CIRCLE_SHARE then
		local clanGid = self.msgItem.share_content.specData.base.clangid

		CurAvatar:openShowCircle(clanGid)
	end
end

function ChatBox:onBtnBattleReplayClick(...)
	if ConditionLimitManager.inLimitState(83) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(83)

		MsgManager.notice(unlockDesc)

		return
	end

	local replayId = self.msgItem.share_content.replay_id

	local function yesFunc(...)
		CHATRPC.sharePull(replayId)
	end

	local msgContent = ClientUtils.getClientNotice(302)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, nil)
end

function ChatBox:onBtnRedPacketClick(...)
	if ConditionLimitManager.inLimitState(88) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(88)

		MsgManager.notice(unlockDesc or "")

		return
	end

	if CurAvatar.redPacketData then
		local item = ResItem[self.msgItem.share_content.specData.item_id]
		local showType = item.extend_args5 and item.extend_args5[1] or nil
		local upLimitId = 665
		local claimedId = 664

		if showType and ResRedPacketShow[showType] then
			upLimitId = ResRedPacketShow[showType].uplimit_id
			claimedId = ResRedPacketShow[showType].clamied_id
		end

		if CurAvatar.redPacketData.day_get >= ResUpperLimit[1].red_package_diamond then
			MsgManager.clientNotice(upLimitId)

			return
		end

		local claimed = CurAvatar:isRedPacketClaimed(self.msgItem.seq)

		if claimed then
			MsgManager.clientNotice(claimedId)

			return
		end

		CurAvatar:recordRedPacketClaimInfo(self.msgItem.seq, self.msgItem, claimed)

		local specData = self.msgItem.share_content.specData
		local data = {}

		data.comm = self.msgItem.sattr
		data.blessingContent = self.txtBlessing:getText()

		RPC.redPacketGetAward(specData.item_id, self.msgItem.seq, CurAvatar.redPacketData.day_get)
	end
end

function ChatBox:onBtnHouseShareClick(...)
	local uid = self.msgItem.suid

	local function yesFunc(...)
		CurAvatar:checkHouseVisitReq(uid, true)
	end

	if uid == CurAvatar.uid then
		MsgManager.notice(Lang.get(61041))

		return
	end

	local curUid = CurAvatar.curRearHouseVisitUid

	if uid ~= curUid then
		local msgContent = Lang.get(61042)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, nil)
	else
		MsgManager.notice(Lang.get(61043))
	end
end

function ChatBox:onBtnGrouponShareClick()
	local data = self.msgItem.share_content.specData
	local actId = data.act_id
	local levelId = data.level
	local actObj = CurAvatar:getActivityObj(actId)

	if actObj then
		if actObj:inFreeze() then
			MsgManager.notice(Lang.get(32793))
		else
			CurAvatar:jumpToShowActivity(actId, {
				levelId
			})
			self.mWindow:setVisible(false)
		end
	else
		MsgManager.notice(Lang.get(32785))
	end
end

function ChatBox:onBtnValentineShareClick()
	local data = self.msgItem.share_content.specData
	local actId = data.template_id
	local itemId = data.gift_id

	CurAvatar:jumpToShowActivity(actId, {
		0,
		itemId
	})
	self.mWindow:setVisible(false)
end

return ChatBox
