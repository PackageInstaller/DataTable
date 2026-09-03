-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/view/ChatMessageWidget.lua

local kMaxPlayerContentWidth = 450
local kMaxSystemContentWidth = 668
local kDefaultBubbleWidth = 80
local kDefaultBubbleHeight = 66

local function openUrlView(url, injector, extraData, param)
	if url then
		local context = injector:instantiate(URLContext)
		local entry, params = UrlEntryManage.resolveUrlWithUserData(url)

		if entry then
			params.extraData = param

			entry:response(context, params)
		end
	end
end

PlayerMessageWidget = class("PlayerMessageWidget", BaseWidget, _M)

PlayerMessageWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
PlayerMessageWidget:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")

function PlayerMessageWidget:initialize(view)
	super.initialize(self, view)

	self._main = view:getChildByFullName("main")
	self._mainPanel = self._main:getChildByName("Text_panel")

	self._mainPanel:setSwallowTouches(false)
end

function PlayerMessageWidget:dispose()
	super.dispose(self)
end

function PlayerMessageWidget:isRichText(string)
	local str = "<font"
	local count = string:find(str)

	if count ~= nil then
		return true
	else
		return false
	end
end

function PlayerMessageWidget:decorateView(message, senderInfo, parent)
	self._message = message
	self._parentMediator = parent

	local bubble = self._main:getChildByFullName("Text_panel.bubble")
	local contentRect = self._main:getChildByFullName("Text_panel.bubble.content_rect")
	local initBubble = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Bubble_Init", "content")
	local bubbleWidth = kDefaultBubbleWidth
	local bubbleheight = kDefaultBubbleHeight

	if senderInfo.chatBubble and senderInfo.chatBubble ~= "" then
		local config = ConfigReader:getRecordById("ChatBubble", senderInfo.chatBubble)
		local path = "asset/ui/chatBubble/" .. config.Icon .. ".png"
		local parent = bubble:getParent()
		local x, y = bubble:getPosition()
		local ch = bubble:getAnchorPoint()

		contentRect:removeFromParent()
		bubble:removeFromParent()

		bubble = ccui.ImageView:create(path)

		bubble:addTo(parent):posite(x, y):setName("bubble")
		bubble:setAnchorPoint(ch)

		bubbleWidth = bubble:getContentSize().width
		bubbleheight = bubble:getContentSize().height

		contentRect:addTo(bubble):setName("content_rect")
	end

	bubble:setScale9Enabled(true)
	bubble:setCapInsets(cc.rect(45, 37, 1, 1))

	local content = message:getContent()
	local contentText = self._main:getChildByFullName("content_text")

	if self:isRichText(content) then
		if contentText == nil then
			contentText = ccui.RichText:createWithXML(content, {})

			contentText:setTouchEnabled(true)
			contentText:setSwallowTouches(false)
			contentText:setWrapMode(1)
			contentText:setAnchorPoint(contentRect:getAnchorPoint())
			contentText:addTo(contentRect:getParent()):posite(contentRect:getPosition()):offset(6, 0):setName("content_text")
			contentText:setOpenUrlHandler(function(url)
				openUrlView(url, self:getInjector(), message:getExtraData(), message:getParams())
			end)
			contentText:setFontSize(18)
			contentText:setFontColor("#343434")
		else
			contentText:setString(content)
		end

		contentText:renderContent()

		local size = contentText:getContentSize()
		local realWidth = math.min(size.width, kMaxPlayerContentWidth)

		contentText:renderContent(realWidth, 0, true)

		self._contentText = contentText
	else
		if contentText == nil then
			contentText = cc.Label:createWithTTF(xmlUnescape(content), TTF_FONT_FZYH_R, 18)

			contentText:setAnchorPoint(contentRect:getAnchorPoint())
			contentText:addTo(contentRect:getParent()):posite(contentRect:getPosition()):offset(7, 0):setName("content_text")
			contentText:setColor(cc.c3b(52, 52, 52))
			contentText:setOverflow(cc.LabelOverflow.CLAMP)
		else
			contentText:setString(content)
		end

		local size = contentText:getContentSize()
		local realWidth = math.min(size.width, kMaxPlayerContentWidth)

		if size.width > kMaxPlayerContentWidth then
			contentText:setDimensions(realWidth, 0)
		end

		self._contentText = contentText
	end

	local realSize = self._contentText:getContentSize()

	if bubbleWidth < realSize.width + 40 then
		if not (realSize.width + 40) then
			local setBubbleSizeX = bubbleWidth

			if bubbleheight < realSize.height + 40 then
				if not (realSize.height + 40) then
					local setBubbleSizeY = bubbleheight

					bubble:setContentSize(setBubbleSizeX, setBubbleSizeY)
					contentText:setPositionY(setBubbleSizeY * 0.5)

					if senderInfo then
						self:setSenderView(message, senderInfo)
					end

					local mainSize = self._main:getContentSize()
					local msgLine = math.modf(realSize.height / 24)

					self._view:setContentSize(mainSize.width, setBubbleSizeY + 35)
					self._main:posite(0, self._view:getContentSize().height)
					self:createEmotionView(message, senderInfo, parent)
				end
			end
		end
	end
end

function PlayerMessageWidget:setSenderView(message, senderInfo)
	self._senderInfo = senderInfo

	local headRect = self._main:getChildByFullName("head_rect")
	local head, oldIcon = IconFactory:createPlayerIcon({
		headFrameScale = 0.4,
		id = senderInfo.headImg,
		size = cc.size(82, 82),
		headFrameId = senderInfo.headFrame
	})

	oldIcon:setScale(0.4)

	if head then
		head:setScale(0.9)
		head:addTo(headRect):center(headRect:getContentSize())
		head:setTouchEnabled(true)
		head:setSwallowTouches(false)

		local function callFunc(sender, eventType)
			self:onClickHead(senderInfo, sender)
		end

		mapButtonHandlerClick(nil, head, {
			func = callFunc
		})
	end

	local textlevel = self._main:getChildByFullName("text_lv")
	local playerlevel = senderInfo.level

	textlevel:setString("lv." .. playerlevel)
	textlevel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local nameText = self._main:getChildByFullName("Text_panel.name_text")

	nameText:setString(senderInfo.nickname or "")
	nameText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local textPanel = self._main:getChildByName("Text_panel")
	local titleIcon = textPanel:getChildByName("title")

	if titleIcon then
		titleIcon:removeFromParent()
	end

	local title = senderInfo.title

	if title ~= nil and title ~= "" then
		titleIcon = IconFactory:createTitleIcon({
			id = title
		})

		titleIcon:addTo(textPanel):setName("title")
		titleIcon:setScale(0.57)

		if self:getChatSystem():isMySend(message) then
			titleIcon:posite(nameText:getPositionX() - nameText:getContentSize().width - 38, nameText:getPositionY() + 15)
		else
			titleIcon:posite(nameText:getPositionX() + nameText:getContentSize().width + 42, nameText:getPositionY() + 15)
		end
	end

	local vipNode = self._main:getChildByFullName("Text_panel.vipnode")

	if not senderInfo.vipLevel then
		local vipLevel = 0

		self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidget:new(vipNode))

		self._playerVipWidget:updateView(vipLevel)

		local nameTextX = nameText:getPositionX()
		local nameTextWidth = nameText:getContentSize().width
		local widthTrim = vipLevel > 9 and 85 or 75

		if nameTextX > 0 then
			if not (328 - nameTextWidth - widthTrim) then
				local setX = nameTextWidth

				vipNode:setPositionX(setX)
			end
		end
	end
end

function PlayerMessageWidget:createEmotionView(message, senderInfo, parent)
	local bubble = self._main:getChildByFullName("Text_panel.bubble")
	local emotion = self._main:getChildByFullName("Text_panel.emotion")

	bubble:setVisible(true)
	emotion:setVisible(false)

	if message.getEmotionId and message:getEmotionId() then
		if self._chatSystem.getEmotionDataById and self._chatSystem:getEmotionDataById(message:getEmotionId()) then
			bubble:setVisible(false)
			emotion:setVisible(true)

			local d = self._chatSystem:getEmotionDataById(message:getEmotionId())
			local path = string.format("asset/emotion/%s.png", d.Icon)

			emotion:getChildByFullName("img"):loadTexture(path)
			self._view:setContentSize(self._view:getContentSize().width, self._view:getContentSize().height + 50)
			self._main:posite(0, self._view:getContentSize().height)
		else
			self._contentText:setString(Strings:get("Emoji_NoFind"))
		end
	end
end

function PlayerMessageWidget:onClickHead(senderInfo, sender)
	local function callFuncMsg()
		local friendSystem = self:getInjector():getInstance(FriendSystem)

		local function gotoView(response)
			local record = BaseRankRecord:new()

			record:synchronize({
				headImage = senderInfo.headImg,
				headFrame = senderInfo.headFrame,
				rid = senderInfo.id,
				level = senderInfo.level,
				nickname = senderInfo.nickname,
				vipLevel = senderInfo.vipLevel,
				combat = senderInfo.combat,
				slogan = senderInfo.slogan,
				master = senderInfo.master,
				heroes = senderInfo.heroes,
				clubName = senderInfo.clubName,
				online = senderInfo.online,
				offlineTime = senderInfo.offlineTime,
				isFriend = response.isFriend,
				close = response.close,
				gender = senderInfo.gender,
				city = senderInfo.city,
				birthday = senderInfo.birthday,
				tags = senderInfo.tags,
				block = response.block,
				leadStageId = senderInfo.leadStageId,
				leadStageLevel = senderInfo.leadStageLevel,
				title = senderInfo.title
			})
			friendSystem:showFriendPlayerInfoView(record:getRid(), record)
		end

		friendSystem:requestSimpleFriendInfo(senderInfo.id, function(response)
			gotoView(response)
		end)
	end

	callFuncMsg()
end

PlayerWordPeaceMessageWidget = class("PlayerWordPeaceMessageWidget", PlayerMessageWidget, _M)

function PlayerWordPeaceMessageWidget:setSenderView(message, senderInfo)
	self._senderInfo = senderInfo

	local headRect = self._main:getChildByFullName("head_rect")
	local head, oldIcon = IconFactory:createPlayerIcon({
		headFrameScale = 0.4,
		id = senderInfo.headImg,
		size = cc.size(82, 82),
		headFrameId = senderInfo.headFrame
	})

	oldIcon:setScale(0.4)

	if head then
		head:setScale(0.9)
		head:addTo(headRect):center(headRect:getContentSize())
		head:setTouchEnabled(true)
		head:setSwallowTouches(false)

		local function callFunc(sender, eventType)
			self:onClickHead(senderInfo, sender)
		end

		mapButtonHandlerClick(nil, head, {
			ignoreClickAudio = true,
			func = callFunc
		})
	end

	local textlevel = self._main:getChildByFullName("text_lv")
	local playerlevel = senderInfo.level

	textlevel:setString(Strings:get("Common_LV_Text") .. playerlevel)

	local sender = self._chatSystem:getChat():getSender(senderInfo.id)
	local titleText = self._main:getChildByFullName("Text_panel.title_text")
	local titleStr, colorStr = GameStyle:getTitleStr(sender.titleId)
	local nameText = self._main:getChildByFullName("Text_panel.name_text")
	local clubText = self._main:getChildByFullName("Text_panel.ClubName")

	if not (senderInfo.nickname .. titleStr) then
		nameText:setString(senderInfo.nickname)
		nameText:setTextColor(cc.c3b(255, 255, 255))
		nameText:setPositionY(kDefaultBubbleHeight)
		titleText:setString(titleStr)
		titleText:setPositionY(kDefaultBubbleHeight - 2)

		if titleText:getPositionX() < nameText:getPositionX() then
			titleText:setPositionX(nameText:getPositionX() - nameText:getContentSize().width - 5)
		else
			titleText:setPositionX(nameText:getPositionX() + nameText:getContentSize().width + 5)
		end

		if message:getExtra() then
			local camp = message:getExtra().camp
			local officerIcon = message:getExtra().officerIcon
			local clubName = message:getExtra().clubName
			local colorCamp = {
				"#fd62ff",
				"#ffe26e",
				"#81cdff"
			}

			if camp then
				color = colorCamp[camp]

				if head then
					head.camp = true
				end
			end

			local officer = self._main:getChildByFullName("Text_panel.officer")

			officer:setVisible(false)

			if clubName and clubName ~= "" then
				clubText:setString("[" .. clubName .. "]")
				clubText:setTextColor(GameStyle:stringToColor(color))
				clubText:offset(0, 18)

				local posx = nameText:getPositionX() - nameText:getContentSize().width

				if titleText:getPositionX() < nameText:getPositionX() then
					clubText:setPositionX(titleText:getPositionX() - titleText:getContentSize().width - 3)
				else
					clubText:setPositionX(titleText:getPositionX() + titleText:getContentSize().width + 3)
				end
			end
		end

		local vipNode = self._main:getChildByFullName("Text_panel.vipnode")

		if not senderInfo.vipLevel then
			local vipLevel = 2

			vipLevel = 3
			self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidget:new(vipNode))

			self._playerVipWidget:updateView(vipLevel)

			local nameTextX = nameText:getPositionX()
			local nameTextWidth = nameText:getContentSize().width
			local widthTrim = vipLevel > 9 and 85 or 75

			if nameTextX > 0 then
				if not (328 - nameTextWidth - widthTrim) then
					local setX = nameTextWidth

					vipNode:setPositionX(setX)
				end
			end
		end
	end
end

SystemMsgLabelType = {
	kSelf = 2,
	kWordPeace = 9,
	kEmperor = 7,
	kMogul = 6,
	kUnion = 4,
	kSystem = 1,
	kTeam = 3,
	kFight = 8,
	kWorld = 5
}
SystemMsgLabelMap = {
	[SystemMsgLabelType.kSystem] = {
		rtColor = "FFE1C9",
		pic = "liaotian_bg_xt.png",
		text = Strings:get("Chat_Label_System"),
		color = cc.c4b(227, 76, 76, 255),
		titleColor = cc.c4b(255, 225, 201, 255)
	},
	[SystemMsgLabelType.kSelf] = {
		rtColor = "cdeb93",
		pic = "liaotian_bg_gr.png",
		text = Strings:get("Chat_Label_Self"),
		color = cc.c4b(111, 210, 98, 255),
		titleColor = cc.c4b(205, 235, 147, 255)
	},
	[SystemMsgLabelType.kTeam] = {
		rtColor = "EEBEBE",
		pic = "liaotian_bg_dw.png",
		text = Strings:get("Chat_Label_Team"),
		color = cc.c4b(95, 181, 247, 255),
		titleColor = cc.c4b(238, 190, 190, 255)
	},
	[SystemMsgLabelType.kUnion] = {
		rtColor = "EDEEBE",
		pic = "liaotian_bg_gh.png",
		text = Strings:get("Chat_Label_Union"),
		color = cc.c4b(248, 209, 105, 255),
		titleColor = cc.c4b(237, 238, 190, 255)
	},
	[SystemMsgLabelType.kWorld] = {
		rtColor = "BED4EE",
		pic = "liaotian_bg_sj.png",
		text = Strings:get("Chat_Label_World"),
		color = cc.c4b(188, 95, 247, 255),
		titleColor = cc.c4b(190, 212, 238, 255)
	},
	[SystemMsgLabelType.kMogul] = {
		text = Strings:get("Chat_Label_Mogul"),
		titleColor = cc.c4b(255, 35, 149, 255)
	},
	[SystemMsgLabelType.kEmperor] = {
		text = Strings:get("Chat_Label_Emperor"),
		titleColor = cc.c4b(174, 0, 255, 255)
	},
	[SystemMsgLabelType.kFight] = {
		text = Strings:get("Chat_Label_Fight"),
		titleColor = cc.c4b(134, 194, 255, 255)
	},
	[SystemMsgLabelType.kWordPeace] = {
		fontType = "FontSJText",
		text = Strings:get("Chat_Label_Scramble")
	}
}
SystemMessageWidget = class("SystemMessageWidget", BaseWidget, _M)

function SystemMessageWidget:initialize(view)
	super.initialize(self, view)

	self._main = self:getView():getChildByName("main")
end

function SystemMessageWidget:dispose()
	super.dispose(self)
end

function SystemMessageWidget:decorateView(message)
	local labelType = message:getLabelType()
	local titleStr = SystemMsgLabelMap[labelType].text
	local titleText = self._main:getChildByFullName("bg.Text_who")

	titleText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	titleText:setTextColor(SystemMsgLabelMap[labelType].titleColor)

	if titleStr then
		titleText:setString(titleStr)
	end

	local contentRect = self._main:getChildByFullName("content.content_rect")

	contentRect:setString("")

	local content = message:getContent()
	local contentText = self._main:getChildByFullName("content_text")

	if contentText == nil then
		local t = TextTemplate:new(content)
		local str = t:stringify({
			size = 20,
			fontName = TTF_FONT_FZYH_M
		})

		contentText = ccui.RichText:createWithXML(str, {})

		contentText:setTouchEnabled(true)
		contentText:setSwallowTouches(false)
		contentText:setWrapMode(1)

		local anchor = contentRect:getAnchorPoint()
		local pos = contentRect:getPosition()

		contentText:setAnchorPoint(anchor)
		contentText:setName("content_text"):posite(90, 20):addTo(contentRect:getParent())
		contentText:setOpenUrlHandler(function(url)
			openUrlView(url, self:getInjector(), message:getExtraData(), message:getParams())
		end)
	else
		contentText:setString(content)
	end

	contentText:renderContent()

	local size = contentText:getContentSize()
	local realWidth = math.min(size.width, kMaxSystemContentWidth)

	contentText:renderContent(realWidth, 0, true)

	local realSize = contentText:getContentSize()
	local kDefaultSystemBubbleHeight = 43
	local bg = self._main:getChildByFullName("bg")

	if realSize.width + 28 > kDefaultBubbleWidth then
		if not (realSize.width + 28) then
			if kDefaultSystemBubbleHeight < realSize.height + 14 then
				if not (realSize.height + 14) then
					local setBubbleSizeY = kDefaultSystemBubbleHeight

					bg:setContentSize(796, setBubbleSizeY)

					local contentPanel = self._main:getChildByFullName("content")

					contentPanel:setContentSize(10, setBubbleSizeY)
					contentText:setPositionY(setBubbleSizeY * 0.5)
					titleText:setPositionY(setBubbleSizeY * 0.5)

					local minSize = self._main:getContentSize()

					self._view:setContentSize(minSize.width, setBubbleSizeY + 14)
					self._main:posite(0, self._view:getContentSize().height + 7)
				end
			end
		end
	end
end

WorldPeaceSystemMessageWidget = class("WorldPeaceSystemMessageWidget", BaseWidget, _M)

function WorldPeaceSystemMessageWidget:initialize(view)
	super.initialize(self, view)

	self._main = self:getView():getChildByName("main")
end

function WorldPeaceSystemMessageWidget:dispose()
	super.dispose(self)
end

function WorldPeaceSystemMessageWidget:decorateView(message)
	local labelType = message:getLabelType()
	local titleStr = SystemMsgLabelMap[labelType].text
	local titleText = self._main:getChildByFullName("bg.Text_who")

	titleText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	titleText:setTextColor(SystemMsgLabelMap[labelType].titleColor)

	if titleStr then
		titleText:setString(titleStr)
	end

	local content = message:getContent()
	local messageView = self:getView()
	local contentRect = messageView:getChildByFullName("main.content.content_rect")

	contentRect:setString("")

	local t = TextTemplate:new(content)
	local str = t:stringify({
		size = 20,
		fontName = TTF_FONT_FZYH_M
	})
	local contentText = messageView:getChildByFullName("content_text")
	local contentText = ccui.RichText:createWithXML(str, {})

	contentText:setTouchEnabled(true)
	contentText:setSwallowTouches(false)

	local anchor = contentRect:getAnchorPoint()
	local pos = contentRect:getPosition()

	contentText:setAnchorPoint(anchor)

	local bg = messageView:getChildByFullName("main.bg")

	bg:getChildByName("Text_who"):setString(Strings:get("Chat_Label_System"))

	local disignW = 30
	local disignW = bg:getChildByName("Text_who"):getContentSize().width - disignW

	contentText:setName("content_text"):posite(70 + disignW, 20):addTo(contentRect:getParent())
	contentText:renderContent()

	local size = contentText:getContentSize()
	local maxWidth = 250

	contentText:renderContent(270 - disignW, 0, true)

	local realSize = contentText:getContentSize()

	bg:setContentSize(maxWidth + 90, realSize.height + 20)

	local setBubbleSizeY = 0
	local contentPanel = messageView:getChildByFullName("main.content")

	contentPanel:setContentSize(10, setBubbleSizeY)
	contentText:setPositionY(setBubbleSizeY * 0.5)
	messageView:setContentSize(cc.size(500, realSize.height + 30))

	local tureHei = contentText:getContentSize().height
	local designhei = 85.5 - tureHei

	messageView:getChildByName("main"):setPositionY(60)
	contentPanel:offset(0, 0 - designhei)
	bg:setPositionY(realSize.height + 50)
	bg:getChildByName("Text_who"):setPositionY(bg:getContentSize().height - 30)
end

PrivateMessageWidget = class("PrivateMessageWidget", BaseWidget, _M)

PrivateMessageWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
PrivateMessageWidget:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")

function PrivateMessageWidget:initialize(view)
	super.initialize(self, view)

	self._main = view:getChildByFullName("main")
end

function PrivateMessageWidget:dispose()
	super.dispose(self)
end

function PrivateMessageWidget:decorateView(message, senderInfo, parent)
	self._message = message
	self._senderInfo = senderInfo
	self._parentMediator = parent

	local headRect = self._main:getChildByFullName("head_rect")
	local head, oldIcon = IconFactory:createPlayerIcon({
		headFrameScale = 0.4,
		id = senderInfo.headImg,
		size = cc.size(82, 82),
		headFrameId = senderInfo.headFrame
	})

	oldIcon:setScale(0.4)

	if head then
		head:setScale(0.8)
		head:addTo(headRect):center(headRect:getContentSize())
		head:setTouchEnabled(true)
		head:setSwallowTouches(false)

		local function callFunc(sender, eventType)
			self:onClickHead(senderInfo, sender)
		end

		mapButtonHandlerClick(nil, head, {
			func = callFunc
		})
	end

	local textlevel = self._main:getChildByFullName("text_lv")
	local playerlevel = senderInfo.level

	textlevel:setString("lv." .. playerlevel)
	textlevel:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local nameText = self._main:getChildByFullName("name_text")

	nameText:setString(senderInfo.nickname or "")
	nameText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local bubble = self._main:getChildByFullName("bubble")
	local contentRect = self._main:getChildByFullName("bubble.content_rect")
	local initBubble = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Bubble_Init", "content")
	local bubbleWidth = kDefaultBubbleWidth
	local bubbleheight = kDefaultBubbleHeight

	if senderInfo.chatBubble and senderInfo.chatBubble ~= "" and senderInfo.chatBubble ~= initBubble then
		local config = ConfigReader:getRecordById("ChatBubble", senderInfo.chatBubble)
		local path = "asset/ui/chatBubble/" .. config.Icon .. ".png"
		local parent = bubble:getParent()
		local x, y = bubble:getPosition()
		local ch = bubble:getAnchorPoint()

		contentRect:removeFromParent()
		bubble:removeFromParent()

		bubble = ccui.ImageView:create(path)

		bubble:addTo(parent):posite(x, y):setName("bubble")
		bubble:setAnchorPoint(ch)

		bubbleWidth = bubble:getContentSize().width
		bubbleheight = bubble:getContentSize().height

		contentRect:addTo(bubble):setName("content_rect")
	end

	bubble:setScale9Enabled(true)
	bubble:setCapInsets(cc.rect(46, 35, 1, 1))

	local content = message:getContent()
	local contentText = self._main:getChildByFullName("content_text")

	if contentText == nil then
		contentText = ccui.RichText:createWithXML(content, {})

		contentText:setFontFace(TTF_FONT_FZYH_R)
		contentText:setFontColor("#503214")
		contentText:setFontSize(20)
		contentText:setTouchEnabled(true)
		contentText:setSwallowTouches(false)
		contentText:setWrapMode(1)
		contentText:setAnchorPoint(contentRect:getAnchorPoint())
		contentText:addTo(contentRect:getParent()):posite(contentRect:getPosition()):offset(6, 0):setName("content_text")
		contentText:setOpenUrlHandler(function(url)
			openUrlView(url, self:getInjector(), message:getExtraData(), message:getParams())
		end)
	else
		contentText:setString(content)
	end

	contentText:renderContent()

	local size = contentText:getContentSize()
	local realWidth = math.min(size.width, kMaxPlayerContentWidth)

	contentText:renderContent(realWidth, 0, true)

	local realSize = contentText:getContentSize()

	if realSize.width + 20 > kDefaultBubbleWidth then
		if not (realSize.width + 20) then
			local setBubbleSizeX = kDefaultBubbleWidth

			if realSize.height + 26 > kDefaultBubbleHeight then
				if not (realSize.height + 26) then
					local setBubbleSizeY = kDefaultBubbleHeight

					bubble:setContentSize(setBubbleSizeX, setBubbleSizeY)
					contentText:setPositionY(setBubbleSizeY * 0.5)

					local mainSize = self._main:getContentSize()

					self._view:setContentSize(mainSize.width, setBubbleSizeY + 35)
					self._main:posite(0, setBubbleSizeY + 30)
					self:createEmotionView(message, senderInfo, parent)
				end
			end
		end
	end
end

function PrivateMessageWidget:onClickHead(senderInfo, sender)
	local function callFuncMsg()
		local friendSystem = self:getInjector():getInstance(FriendSystem)

		local function gotoView(response)
			local record = BaseRankRecord:new()

			record:synchronize({
				headImage = senderInfo.headImg,
				headFrame = senderInfo.headFrame,
				rid = senderInfo.id,
				level = senderInfo.level,
				nickname = senderInfo.nickname,
				vipLevel = senderInfo.vipLevel,
				combat = senderInfo.combat,
				slogan = senderInfo.slogan,
				master = senderInfo.master,
				heroes = senderInfo.heroes,
				clubName = senderInfo.clubName,
				online = senderInfo.online,
				offlineTime = senderInfo.offlineTime,
				isFriend = response.isFriend,
				close = response.close,
				gender = senderInfo.gender,
				city = senderInfo.city,
				birthday = senderInfo.birthday,
				tags = senderInfo.tags,
				block = response.block,
				leadStageId = senderInfo.leadStageId,
				leadStageLevel = senderInfo.leadStageLevel
			})
			friendSystem:showFriendPlayerInfoView(record:getRid(), record)
		end

		friendSystem:requestSimpleFriendInfo(senderInfo.id, function(response)
			gotoView(response)
		end)
	end

	callFuncMsg()
end

function PrivateMessageWidget:createEmotionView(message, senderInfo, parent)
	local bubble = self._main:getChildByFullName("bubble")
	local emotion = self._main:getChildByFullName("emotion")

	bubble:setVisible(true)
	emotion:setVisible(false)

	if message.getEmotionId and message:getEmotionId() then
		if self._chatSystem.getEmotionDataById and self._chatSystem:getEmotionDataById(message:getEmotionId()) then
			bubble:setVisible(false)
			emotion:setVisible(true)

			local d = self._chatSystem:getEmotionDataById(message:getEmotionId())
			local path = string.format("asset/emotion/%s.png", d.Icon)

			emotion:getChildByFullName("img"):loadTexture(path)
			self._view:setContentSize(self._view:getContentSize().width, self._view:getContentSize().height + 50)
			self._main:posite(0, self._view:getContentSize().height)
		else
			self._contentText:setString(Strings:get("Emoji_NoFind"))
		end
	end
end

function html2Text(htmlStr)
	if htmlStr == nil then
		return ""
	end

	htmlStr = string.gsub(htmlStr, "<[^>]+>", "")
	htmlStr = string.gsub(htmlStr, "\\s*|\t|\r|\n", "")

	return htmlStr
end

SimpleMessageWidget = class("SimpleMessageWidget", BaseWidget, _M)

SimpleMessageWidget:has("_chatSystem", {
	is = "r"
}):injectWith("ChatSystem")

function SimpleMessageWidget.class:createWidgetNode()
	local resFile = "asset/ui/SimpleMessage.csb"
	local view = ccui.Layout:create()

	view:setAnchorPoint(cc.p(0, 1))
	view:setCascadeOpacityEnabled(true)

	local node = cc.CSLoader:createNode(resFile)

	node:setAnchorPoint(cc.p(0, 1))
	node:addTo(view):setName("main")

	return view
end

function SimpleMessageWidget:initialize(view)
	super.initialize(self, view)

	self._main = view:getChildByFullName("main")
end

function SimpleMessageWidget:dispose()
	local view = self._view

	if view then
		view:removeFromParent()

		self._view = nil
	end

	super.dispose(self)
end

function SimpleMessageWidget:decorateView(message, senderInfo)
	local labelName, labelColor
	local messageType = message:getType()
	local labelColorFF

	if messageType == MessageType.kPlayer then
		labelName = ""
		labelColor = cc.c4b(195, 195, 195, 255)
		labelColorFF = "a76936"
	elseif messageType == MessageType.kSystem then
		local labelType = message:getLabelType()

		labelName = SystemMsgLabelMap[labelType] and SystemMsgLabelMap[labelType].text
		labelColor = SystemMsgLabelMap[labelType] and SystemMsgLabelMap[labelType].titleColor
		labelColorFF = SystemMsgLabelMap[labelType] and SystemMsgLabelMap[labelType].rtColor
	end

	local title = self._main:getChildByName("content_rect")

	title:setString(labelName)
	title:setTextColor(labelColor)
	title:removeAllChildren()

	local titleSize = title:getContentSize()
	local content = message:getContent()
	local str

	if messageType == MessageType.kPlayer then
		local nickname = senderInfo and senderInfo.nickname

		content = html2Text(content)

		local emotionId = message:getEmotionId()

		if emotionId then
			local chatSystem = DmGame:getInstance()._injector:getInstance("ChatSystem")

			content = "[" .. Strings:get(chatSystem:getEmotionDataById(emotionId).Name) .. "]"
			content = string.format("<font face='asset/font/CustomFont_FZYH_M.TTF' size='16' color='#33E90B'>%s</font>", content)
		end

		local var_37_0 = {
			fontName = TTF_FONT_FZYH_M
		}

		if nickname then
			var_37_0.label = nickname .. " " or ""
		end

		if labelColorFF then
			var_37_0.color = "#" .. labelColorFF or "#ffffff"
		end

		var_37_0.factor = content
		str = Strings:get("Chat_Label_Style", var_37_0)
	else
		str = content
	end

	local contentText = ccui.RichText:createWithXML(str, {})

	contentText:ignoreContentAdaptWithSize(true)
	contentText:rebuildElements()
	contentText:formatText()
	contentText:setAnchorPoint(cc.p(0, 1))
	contentText:renderContent(335 - (titleSize.width + 3), 0)

	local contentTextSize = contentText:getContentSize()

	contentText:setPosition(cc.p(titleSize.width + 3, titleSize.height))
	contentText:addTo(title)

	local width = titleSize.width + 3 + contentTextSize.width
	local height = math.max(contentTextSize.height, titleSize.height)

	self._main:setPosition(0, height)
	self._view:setContentSize(width, height)
end

FlowMessageWidget = class("FlowMessageWidget", BaseWidget, _M)

function FlowMessageWidget:setupView()
	local view = ccui.Layout:create()

	view:setCascadeOpacityEnabled(true)

	return view
end

function FlowMessageWidget:initialize()
	local view = self:setupView()

	super.initialize(self, view)
end

function FlowMessageWidget:dispose()
	local view = self._view

	if view then
		view:removeFromParent()

		self._view = nil
	end

	super.dispose(self)
end

function FlowMessageWidget:decorateView(message, senderInfo)
	local content = message:getContent()
	local contentText = ccui.RichText:createWithXML(content, {})

	contentText:setWrapMode(1)
	contentText:setAnchorPoint(0, 0)
	contentText:addTo(self:getView()):setName("content_text")
	contentText:renderContent()
	self:getView():setContentSize(contentText:getContentSize())
end

local kMaxWordPeaceSwearBossContentWidth = 220

WordPeaceSwearBossMessageWidget = class("WordPeaceSwearBossMessageWidget", BaseWidget, _M)

WordPeaceSwearBossMessageWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
WordPeaceSwearBossMessageWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function WordPeaceSwearBossMessageWidget:initialize(view, config)
	super.initialize(self, view)

	self._main = view:getChildByFullName("main")
	self._mainPanel = self._main:getChildByName("Text_panel")
	self._bubble = self._mainPanel:getChildByName("bubble")

	self._mainPanel:setSwallowTouches(false)

	self._configSize = config or {}
end

function WordPeaceSwearBossMessageWidget:dispose()
	super.dispose(self)
end

function WordPeaceSwearBossMessageWidget:isRichText(string)
	local str = "<font"
	local count = string:find(str)

	if count ~= nil then
		return true
	else
		return false
	end
end

function WordPeaceSwearBossMessageWidget:decorateView(message, senderInfo, parent)
	self._message = message
	self._parentMediator = parent

	local contentRect = self._main:getChildByFullName("Text_panel.bubble.content_rect")
	local content = Strings:get(message.bossChatId)
	local contentText = self._bubble:getChildByFullName("content_text")
	local realSize
	local translateNode = self._mainPanel:getChildByFullName("translate")

	if translateNode then
		translateNode:setVisible(false)

		local opacity = CommonUtils.GetSwitch("fn_gp_translate") and 255 or 0

		translateNode:setOpacity(opacity)
	end

	local line = self._mainPanel:getChildByFullName("bubble.line")

	if self:isRichText(content) then
		if translateNode then
			translateNode:setVisible(false)
			translateNode:removeFromParent()
			line:setVisible(false)
			line:removeFromParent()
		end

		if contentText == nil then
			contentText = ccui.RichText:createWithXML(content, {})

			contentText:setTouchEnabled(true)
			contentText:setSwallowTouches(false)
			contentText:setAnchorPoint(contentRect:getAnchorPoint())
			contentText:addTo(contentRect:getParent()):posite(contentRect:getPosition()):setName("content_text")
			contentText:setOpenUrlHandler(function(url)
				openUrlView(url, self:getInjector(), message:getExtraData(), message:getParams())
			end)
			contentText:setFontSize(18)
			contentText:setFontColor("#ffffff")
		else
			contentText:setString(content)
		end

		contentText:renderContent()

		local size = contentText:getContentSize()
		local realWidth = math.min(size.width, (self._configSize.maxWidth or nil) and self._configSize.maxWidth)

		contentText:renderContent(realWidth, 0, true)

		self._contentText = contentText
		realSize = self._contentText:getContentSize()

		local bubble = self._main:getChildByFullName("Text_panel.bubble")

		if realSize.width + 28 > kDefaultBubbleWidth then
			if not (realSize.width + 28) then
				local setBubbleSizeX = kDefaultBubbleWidth

				if realSize.height + 25 > kDefaultBubbleHeight then
					if not (realSize.height + 25) then
						local setBubbleSizeY = kDefaultBubbleHeight

						bubble:setContentSize(setBubbleSizeX, setBubbleSizeY)
						contentText:setPositionY(setBubbleSizeY * 0.5)
					end
				end
			end
		end
	else
		if contentText == nil then
			contentText = ccui.Text:create(xmlUnescape(content), TTF_FONT_FZYH_M, 20)

			contentText:setAnchorPoint(contentRect:getAnchorPoint())
			contentText:addTo(contentRect:getParent()):posite(contentRect:getPosition()):setName("content_text")
		else
			contentText:setString(content)
		end

		setTextWithFontStyle(contentText, "FontTipsText")

		local size = contentText:getContentSize()
		local maxWidth = kMaxWordPeaceSwearBossContentWidth

		if self._configSize.maxWidth then
			maxWidth = self._configSize.maxWidth
		end

		local realWidth = math.min(size.width, maxWidth)

		if CommonUtils.GetSwitch("fn_gp_translate") and translateNode and maxWidth <= realWidth then
			realWidth = realWidth - 80
		end

		contentText:getVirtualRenderer():setDimensions(realWidth, 0)

		realSize = contentText:getVirtualRenderer():getContentSize()
		self._contentText = contentText

		if translateNode then
			line:setVisible(false)

			local contentTrans = self._main:getChildByFullName("Text_panel.bubble.content_trans")

			contentTrans:setVisible(false)

			if self._message:getTranState() == MessageTransStatus.kSuccess or self._message:getTranState() == MessageTransStatus.kTrans then
				line:setVisible(true)
				contentTrans:setVisible(true)

				local transStr = message:getTranStr()
				local transText = self._bubble:getChildByFullName("content_trans_text")

				if transText == nil then
					transText = ccui.Text:create(xmlUnescape(transStr), nil, 18)

					transText:setAnchorPoint(contentTrans:getAnchorPoint())
					transText:addTo(contentTrans:getParent()):posite(contentRect:getPosition()):setName("content_trans_text")
					transText:setColor(cc.c3b(52, 52, 52))
				else
					transText:setString(transStr)
				end

				local transSize = transText:getContentSize()
				local maxWidth = kMaxPlayerContentWidth

				if self._configSize.maxWidth then
					maxWidth = self._configSize.maxWidth
				end

				local transWidth = math.min(transSize.width, maxWidth)

				if CommonUtils.GetSwitch("fn_gp_translate") and translateNode and maxWidth <= transWidth then
					transWidth = transWidth - 80
				end

				realWidth = math.max(transWidth, realWidth)

				transText:getVirtualRenderer():setDimensions(realWidth, 0)
				transText:setPositionY(-transSize.height)

				self._transLine = line
				self._transText = transText
				transSize = self._transText:getVirtualRenderer():getContentSize()
				realSize = cc.size(realWidth, realSize.height + transSize.height + 20)
			end

			translateNode:setVisible(CommonUtils.GetSwitch("fn_gp_translate"))
			translateNode:getChildByFullName("refresh"):addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:onClickTranslate(content)
				end
			end)
			translateNode:getChildByFullName("failed"):addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:onClickTranslate(content)
				end
			end)
			self:onRefreshTranslate()
		end

		local bubble = self._main:getChildByFullName("Text_panel.bubble")

		if realSize.width + 28 > kDefaultBubbleWidth then
			if not (realSize.width + 28) then
				local setBubbleSizeX = kDefaultBubbleWidth

				if realSize.height + 25 > kDefaultBubbleHeight then
					if not (realSize.height + 25) then
						local setBubbleSizeY = kDefaultBubbleHeight

						bubble:setContentSize(setBubbleSizeX, setBubbleSizeY)
						contentText:setPositionY(setBubbleSizeY * 0.5)

						if translateNode then
							translateNode:setPosition(cc.p(bubble:getPositionX() + setBubbleSizeX + 5, bubble:getPositionY() - setBubbleSizeY * 0.5))

							if self._message:getTranState() == MessageTransStatus.kSuccess or self._message:getTranState() == MessageTransStatus.kTrans then
								if self._transLine then
									self._transLine:setContentSize(setBubbleSizeX - 40, 1)
								end

								local tranSize = self._transText:getVirtualRenderer():getContentSize()
								local textPosY = 0

								if self._transText then
									self._transText:setPositionY(tranSize.height * 0.5 + 15)

									textPosY = textPosY + tranSize.height + 25
								end

								local contentSize = self._contentText:getVirtualRenderer():getContentSize()

								if self._transLine then
									self._transLine:setPositionY(textPosY)

									textPosY = textPosY + contentSize.height * 0.5 + 5
								end

								if self._contentText then
									self._contentText:setPositionY(textPosY)
								end
							end
						end
					end
				end
			end
		end
	end

	self:setSenderView(message, senderInfo)

	local mainSize = self._main:getContentSize()
	local msgLine = math.modf(realSize.height / 24)

	self._view:setContentSize(mainSize.width, mainSize.height + 24 * msgLine)
	self._main:posite(0, self._view:getContentSize().height)
end

function WordPeaceSwearBossMessageWidget:setSenderView(message, senderInfo)
	self._senderInfo = senderInfo

	local headRect = self._main:getChildByFullName("head_rect")
	local head, oldIcon = IconFactory:createPlayerIcon({
		headFrameScale = 0.4,
		id = senderInfo.headId,
		size = cc.size(82, 82),
		headFrameId = senderInfo.frameId
	})

	oldIcon:setScale(0.4)

	if head then
		head:setScale(0.9)
		head:addTo(headRect):center(headRect:getContentSize())
	end

	local textlevel = self._main:getChildByFullName("text_lv")

	textlevel:setString("")

	local nameText = self._main:getChildByFullName("Text_panel.num_text")

	nameText:setString("+" .. senderInfo.pointNum)
end

local kMaxWordPeaceSwearSelfContentWidth = 220

WordPeaceSwearSelfMessageWidget = class("WordPeaceSwearSelfMessageWidget", BaseWidget, _M)

WordPeaceSwearSelfMessageWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")
WordPeaceSwearSelfMessageWidget:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function WordPeaceSwearSelfMessageWidget:initialize(view, config)
	super.initialize(self, view)

	self._main = view:getChildByFullName("main")
	self._mainPanel = self._main:getChildByName("Text_panel")
	self._bubble = self._mainPanel:getChildByName("bubble")

	self._mainPanel:setSwallowTouches(false)

	self._configSize = config or {}
end

function WordPeaceSwearSelfMessageWidget:dispose()
	super.dispose(self)
end

function WordPeaceSwearSelfMessageWidget:isRichText(string)
	local str = "<font"
	local count = string:find(str)

	if count ~= nil then
		return true
	else
		return false
	end
end

function WordPeaceSwearSelfMessageWidget:decorateView(message, senderInfo, parent)
	self._message = message
	self._parentMediator = parent

	local contentRect = self._main:getChildByFullName("Text_panel.bubble.content_rect")
	local content = Strings:get(message.playerChatId)
	local contentText = self._bubble:getChildByFullName("content_text")
	local realSize
	local translateNode = self._mainPanel:getChildByFullName("translate")

	if translateNode then
		translateNode:setVisible(false)

		local opacity = CommonUtils.GetSwitch("fn_gp_translate") and 255 or 0

		translateNode:setOpacity(opacity)
	end

	local line = self._mainPanel:getChildByFullName("bubble.line")

	if self:isRichText(content) then
		if translateNode then
			translateNode:setVisible(false)
			translateNode:removeFromParent()
			line:setVisible(false)
			line:removeFromParent()
		end

		if contentText == nil then
			contentText = ccui.RichText:createWithXML(content, {})

			contentText:setTouchEnabled(true)
			contentText:setSwallowTouches(false)
			contentText:setAnchorPoint(contentRect:getAnchorPoint())
			contentText:addTo(contentRect:getParent()):posite(contentRect:getPosition()):setName("content_text")
			contentText:setOpenUrlHandler(function(url)
				openUrlView(url, self:getInjector(), message:getExtraData(), message:getParams())
			end)
			contentText:setFontSize(18)
			contentText:setFontColor("#ffffff")
		else
			contentText:setString(content)
		end

		contentText:renderContent()

		local size = contentText:getContentSize()
		local realWidth = math.min(size.width, (self._configSize.maxWidth or nil) and self._configSize.maxWidth)

		contentText:renderContent(realWidth, 0, true)

		self._contentText = contentText
		realSize = self._contentText:getContentSize()

		local bubble = self._main:getChildByFullName("Text_panel.bubble")

		if realSize.width + 28 > kDefaultBubbleWidth then
			if not (realSize.width + 28) then
				local setBubbleSizeX = kDefaultBubbleWidth

				if realSize.height + 25 > kDefaultBubbleHeight then
					if not (realSize.height + 25) then
						local setBubbleSizeY = kDefaultBubbleHeight

						bubble:setContentSize(setBubbleSizeX, setBubbleSizeY)
						contentText:setPositionY(setBubbleSizeY * 0.5)
					end
				end
			end
		end
	else
		if contentText == nil then
			contentText = ccui.Text:create(xmlUnescape(content), TTF_FONT_FZYH_M, 20)

			contentText:setAnchorPoint(contentRect:getAnchorPoint())
			contentText:addTo(contentRect:getParent()):posite(contentRect:getPosition()):setName("content_text")
		else
			contentText:setString(content)
		end

		local size = contentText:getContentSize()

		setTextWithFontStyle(contentText, "FontTipsText")

		local maxWidth = kMaxWordPeaceSwearSelfContentWidth

		if self._configSize.maxWidth then
			maxWidth = self._configSize.maxWidth
		end

		local realWidth = math.min(size.width, maxWidth)

		if CommonUtils.GetSwitch("fn_gp_translate") and translateNode and maxWidth <= realWidth then
			realWidth = realWidth - 80
		end

		contentText:getVirtualRenderer():setDimensions(realWidth, 0)

		realSize = contentText:getVirtualRenderer():getContentSize()
		self._contentText = contentText

		if translateNode then
			line:setVisible(false)

			local contentTrans = self._main:getChildByFullName("Text_panel.bubble.content_trans")

			contentTrans:setVisible(false)

			if self._message:getTranState() == MessageTransStatus.kSuccess or self._message:getTranState() == MessageTransStatus.kTrans then
				line:setVisible(true)
				contentTrans:setVisible(true)

				local transStr = message:getTranStr()
				local transText = self._bubble:getChildByFullName("content_trans_text")

				if transText == nil then
					transText = ccui.Text:create(xmlUnescape(transStr), nil, 18)

					transText:setAnchorPoint(contentTrans:getAnchorPoint())
					transText:addTo(contentTrans:getParent()):posite(contentRect:getPosition()):setName("content_trans_text")
					transText:setColor(cc.c3b(52, 52, 52))
				else
					transText:setString(transStr)
				end

				local transSize = transText:getContentSize()
				local maxWidth = kMaxPlayerContentWidth

				if self._configSize.maxWidth then
					maxWidth = self._configSize.maxWidth
				end

				local transWidth = math.min(transSize.width, maxWidth)

				if CommonUtils.GetSwitch("fn_gp_translate") and translateNode and maxWidth <= transWidth then
					transWidth = transWidth - 80
				end

				realWidth = math.max(transWidth, realWidth)

				transText:getVirtualRenderer():setDimensions(realWidth, 0)
				transText:setPositionY(-transSize.height)

				self._transLine = line
				self._transText = transText
				transSize = self._transText:getVirtualRenderer():getContentSize()
				realSize = cc.size(realWidth, realSize.height + transSize.height + 20)
			end

			translateNode:setVisible(CommonUtils.GetSwitch("fn_gp_translate"))
			translateNode:getChildByFullName("refresh"):addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:onClickTranslate(content)
				end
			end)
			translateNode:getChildByFullName("failed"):addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					self:onClickTranslate(content)
				end
			end)
			self:onRefreshTranslate()
		end

		local bubble = self._main:getChildByFullName("Text_panel.bubble")

		if realSize.width + 28 > kDefaultBubbleWidth then
			if not (realSize.width + 28) then
				local setBubbleSizeX = kDefaultBubbleWidth

				if realSize.height + 25 > kDefaultBubbleHeight then
					if not (realSize.height + 25) then
						local setBubbleSizeY = kDefaultBubbleHeight

						bubble:setContentSize(setBubbleSizeX, setBubbleSizeY)
						contentText:setPositionY(setBubbleSizeY * 0.5)

						if translateNode then
							translateNode:setPosition(cc.p(bubble:getPositionX() + setBubbleSizeX + 5, bubble:getPositionY() - setBubbleSizeY * 0.5))

							if self._message:getTranState() == MessageTransStatus.kSuccess or self._message:getTranState() == MessageTransStatus.kTrans then
								if self._transLine then
									self._transLine:setContentSize(setBubbleSizeX - 40, 1)
								end

								local tranSize = self._transText:getVirtualRenderer():getContentSize()
								local textPosY = 0

								if self._transText then
									self._transText:setPositionY(tranSize.height * 0.5 + 15)

									textPosY = textPosY + tranSize.height + 25
								end

								local contentSize = self._contentText:getVirtualRenderer():getContentSize()

								if self._transLine then
									self._transLine:setPositionY(textPosY)

									textPosY = textPosY + contentSize.height * 0.5 + 5
								end

								if self._contentText then
									self._contentText:setPositionY(textPosY)
								end
							end
						end
					end
				end
			end
		end
	end

	self:setSenderView(message, senderInfo)

	local mainSize = self._main:getContentSize()
	local msgLine = math.modf(realSize.height / 24)

	self._view:setContentSize(mainSize.width, mainSize.height + 24 * msgLine)
	self._main:posite(0, self._view:getContentSize().height)
end

function WordPeaceSwearSelfMessageWidget:setSenderView(message, senderInfo)
	self._senderInfo = senderInfo

	local headRect = self._main:getChildByFullName("head_rect")
	local head, oldIcon = IconFactory:createPlayerIcon({
		headFrameScale = 0.4,
		id = senderInfo.headId,
		size = cc.size(82, 82),
		headFrameId = senderInfo.frameId
	})

	oldIcon:setScale(0.4)

	if head then
		head:setScale(0.9)
		head:addTo(headRect):center(headRect:getContentSize())
	end

	local textlevel = self._main:getChildByFullName("text_lv")
	local playerlevel = senderInfo.lv

	textlevel:setString(Strings:get("Common_LV_Text") .. playerlevel)

	local titleText = self._main:getChildByFullName("Text_panel.title_text")
	local nameText = self._main:getChildByFullName("Text_panel.name_text")

	nameText:setString(senderInfo.name)

	local officer = self._main:getChildByFullName("Text_panel.officer")

	officer:setVisible(false)
	titleText:setString(senderInfo.rank)

	if titleText:getPositionX() < nameText:getPositionX() then
		titleText:setPositionX(nameText:getPositionX() - nameText:getContentSize().width - 5)
	else
		titleText:setPositionX(nameText:getPositionX() + nameText:getContentSize().width + 5)
	end
end
