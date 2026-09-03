-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/chat/view/ChatCommonWidget.lua

local function adjustPos(view, targetView, direction, offset)
	targetView:setAnchorPoint(cc.p(0.5, 0.5))
	targetView:setIgnoreAnchorPointForPosition(false)

	local kUpMargin, kDownMargin, kLeftMargin, kRightMargin = 0, 0, 0, 0
	local viewSize = targetView:getContentSize()
	local viewBoundingBox = view:getBoundingBox()
	local worldPos = view:getParent():convertToWorldSpace(cc.p(viewBoundingBox.x, viewBoundingBox.y))
	local scene = cc.Director:getInstance():getRunningScene()
	local winSize = scene:getContentSize()

	direction = direction or worldPos.y + viewBoundingBox.height + viewSize.height + kUpMargin <= winSize.height - 30 and ItemTipsDirection.kUp or worldPos.x + viewBoundingBox.width * 0.5 < winSize.width * 0.5 and ItemTipsDirection.kRight or ItemTipsDirection.kLeft

	local iconBox = {
		x = worldPos.x,
		y = worldPos.y,
		width = view:getContentSize().width * view:getScale(),
		height = view:getContentSize().height * view:getScale()
	}
	local x, y

	if direction == ItemTipsDirection.kUp then
		x = iconBox.x + iconBox.width * 0.5
		y = iconBox.y + iconBox.height + viewSize.height * 0.5 + kUpMargin
	elseif direction == ItemTipsDirection.kDown then
		x = iconBox.x + iconBox.width * 0.5
		y = iconBox.y - viewSize.height * 0.5 - kDownMargin
	elseif direction == ItemTipsDirection.kLeft then
		x = iconBox.x - viewSize.width * 0.5 - kLeftMargin
		y = iconBox.y + iconBox.height - viewSize.height * 0.5
	elseif direction == ItemTipsDirection.kRight then
		x = iconBox.x + iconBox.width + viewSize.width * 0.5 + kRightMargin
		y = iconBox.y + iconBox.height - viewSize.height * 0.5
	end

	local nodePos = targetView:getParent():convertToWorldSpace(cc.p(0, 0))
	local kLeftMinMargin, kRightMinMargin, kUpMinMargin, kDownMinMargin = 0, 0, 0, 0

	if kLeftMinMargin >= x - viewSize.width * 0.5 then
		x = kLeftMinMargin + viewSize.width * 0.5
	elseif x + viewSize.width * 0.5 >= winSize.width - kRightMinMargin then
		x = winSize.width - kRightMinMargin - viewSize.width * 0.5
	end

	if kDownMinMargin > y - viewSize.height * 0.5 then
		y = kDownMinMargin + viewSize.height * 0.5
	elseif y + viewSize.height * 0.5 > winSize.height - kUpMinMargin then
		y = winSize.height - kUpMinMargin - viewSize.height * 0.5
	end

	local x = x - nodePos.x + offset.x
	local y = y - nodePos.y + offset.y

	targetView:setPosition(cc.p(x, y))
end

HeadTipWidget = class("HeadTipWidget", BaseWidget, _M)

function HeadTipWidget.class:createWidgetNode()
	local resFile = "asset/ui/ChatPlayerHeadClick.csb"

	return cc.CSLoader:createNode(resFile)
end

function HeadTipWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function HeadTipWidget:dispose()
	super.dispose(self)
end

function HeadTipWidget:initSubviews(view)
	self._tipPanel = self._view:getChildByName("tipPanel")

	self:addTouchLayer()
end

function HeadTipWidget:enterWithData(data)
	if not data then
		return
	end

	adjustPos(data.sender, self._tipPanel, ItemTipsDirection.kRight, {
		x = 8.5,
		y = 4
	})
	self:setHeadIcon(data.senderInfo)
	self:setTitle(data)
end

function HeadTipWidget:addTouchLayer()
	local touchPanel = self._view:getChildByName("touchPanel")

	touchPanel:setTouchEnabled(true)
	touchPanel:setSwallowTouches(false)

	local winSize = cc.Director:getInstance():getVisibleSize()

	touchPanel:setContentSize(winSize)
	touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:onClickMaskLayer()
		end
	end)
	touchPanel:setColor(cc.c3b(255, 0, 0))
end

function HeadTipWidget:onClickMaskLayer(sender, touchType)
	self:getView():removeFromParent()
end

function HeadTipWidget:setHeadIcon(info)
	local head, oldIcon = IconFactory:createPlayerIcon({
		frameStyle = 2,
		clipType = 4,
		headFrameScale = 0.4,
		id = info.headImg,
		size = cc.size(84, 84),
		headFrameId = info.headFrame
	})

	oldIcon:setScale(0.4)
	head:setScale(0.9)
	head:addTo(self._tipPanel)
	head:setPosition(-45, 117)

	local textlevel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 20)

	GameStyle:setCommonOutlineEffect(textlevel)
	textlevel:addTo(head)
	textlevel:setPosition(55, 18)
	textlevel:setHorizontalAlignment(2)

	local playerlevel = info.level

	textlevel:setString("lv." .. playerlevel)
end

function HeadTipWidget:setTitle(data)
	local msgTxt = self._tipPanel:getChildByFullName("msgBtn.text")

	self._shieldTxt = self._tipPanel:getChildByFullName("shieldBtn.text")

	local complaintTxt = self._tipPanel:getChildByFullName("complaintBtn.text")

	msgTxt:setString(Strings:get("Tips_PlayerInformation"))
	self._shieldTxt:setString(Strings:get("Tips_BannedPlayer"))
	complaintTxt:setString(Strings:get("Tips_ReportPlayer"))

	local function callFunc(sender, eventType)
		if data.callFuncMsg then
			data.callFuncMsg()
		end

		self:onClickMaskLayer()
	end

	mapButtonHandlerClick(nil, msgTxt, {
		func = callFunc
	})

	local function callFunc(sender, eventType)
		if data.callFuncShield then
			data.callFuncShield()
		end

		self:onClickMaskLayer()
	end

	mapButtonHandlerClick(nil, self._shieldTxt, {
		func = callFunc
	})

	local function callFunc(sender, eventType)
		if data.callFuncComplaint then
			data.callFuncComplaint()
		end

		self:onClickMaskLayer()
	end

	mapButtonHandlerClick(nil, complaintTxt, {
		func = callFunc
	})
end

function HeadTipWidget:updateTitle(shield)
	self._shieldTxt:setString(Strings:get((shield or nil) and "Tips_UnBannedPlayer"))
end

EmotionTipWidget = class("EmotionTipWidget", BaseWidget, _M)
KEmotionShowType = {
	KChat = "Chat",
	KFriend = "Friend"
}

local KVNUM = 6
local KHNUM = 2
local KPOINTIMG = {
	"emoji_bg_dian_1.png",
	"emoji_bg_dian_2.png"
}

function EmotionTipWidget.class:createWidgetNode()
	local resFile = "asset/ui/ChatEmotion.csb"

	return cc.CSLoader:createNode(resFile)
end

function EmotionTipWidget:initialize(view)
	super.initialize(self, view)
	self:initTabData()
	self:initSubviews(view)
end

function EmotionTipWidget:initTabData()
	local d = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Chat_Emoji_Tab", "content")

	self._tabIds = d[1]
	self._tabImgs = d[2]
	self._iconBtns = {}
	self._pointImgs = {}
end

function EmotionTipWidget:dispose()
	super.dispose(self)
end

function EmotionTipWidget:initSubviews(view)
	self._tipPanel = self._view:getChildByName("tipPanel")
	self._pointPanel = self._tipPanel:getChildByName("pointPanel")
	self._scrollView = self._view:getChildByFullName("tipPanel.scrollView")
	self._scrollPanel = self._view:getChildByFullName("tipPanel.scrollPanel")
	self._cloneCell = self._view:getChildByName("cellPanel")

	self._cloneCell:setVisible(false)

	self._iconBtn = self._view:getChildByFullName("iconBtn")

	self._iconBtn:setVisible(false)

	self._pointImg = self._view:getChildByFullName("pointImg")

	self._pointImg:setVisible(false)
	self:addTouchLayer()
end

function EmotionTipWidget:enterWithData(data)
	if not data then
		return
	end

	self._callFunc = data.callFunc or nil
	self._enterType = data.type or KEmotionShowType.KChat
	self._curSelectId = data.selectId and table.indexof(self._tabIds, data.selectId) or 1
	self._curSelectId = self._curSelectId or 1
	self._curSelectScrollIndex = self._curSelectScrollIndex or 1
	self._dataList = data.data

	local offsetx = self._enterType == KEmotionShowType.KChat and -4 or -14
	local offsety = self._enterType == KEmotionShowType.KChat and 25 or 27

	adjustPos(data.sender, self._tipPanel, ItemTipsDirection.kUp, {
		x = offsetx,
		y = offsety
	})
	self:setTabelView()
	self:setTabView()
	self:tabClick()
end

function EmotionTipWidget:getData()
	self._data = self._dataList[self._tabIds[self._curSelectId]]
end

function EmotionTipWidget:setTabView()
	for i = 1, #self._tabIds do
		local btn = self._iconBtn:clone()

		btn:setVisible(true)

		btn.tag = i

		btn:addTo(self._tipPanel):posite(70 + (i - 1) * 83, 217)

		local img = btn:getChildByFullName("img")

		if not self._tabImgs[i] then
			img:loadTexture(self._tabImgs[i] .. ".png", ccui.TextureResType.plistType)

			local function callFunc(sender, eventType)
				self:tabClick(sender)
			end

			mapButtonHandlerClick(nil, btn, {
				func = callFunc
			})

			self._iconBtns[i] = btn
		end
	end
end

function EmotionTipWidget:setPageView()
	self._pointPanel:removeAllChildren()

	local n = math.ceil(#self._data / (KVNUM * KHNUM))
	local px = 150 - n * 10

	for i = 1, n do
		local pointImg = self._pointImg:clone()

		pointImg:setVisible(true)

		pointImg.tag = i

		pointImg:addTo(self._pointPanel):posite(px + (i - 1) * 20, 10)

		self._pointImgs[i] = pointImg
	end

	self:changePageView()
end

function EmotionTipWidget:changePageView()
	local n = math.ceil(#self._data / (KVNUM * KHNUM))

	for i = 1, n do
		self._pointImgs[i]:getChildByFullName("img"):loadTexture((self._curSelectScrollIndex == i or nil) and (KPOINTIMG[2] or KPOINTIMG[1]), ccui.TextureResType.plistType)
	end
end

function EmotionTipWidget:setTabelView()
	local function numberOfCells(view)
		return math.ceil(#self._data / (KHNUM * KVNUM))
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return self._scrollPanel:getContentSize().width, self._scrollPanel:getContentSize().height
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		cell = cell or cc.TableViewCell:new()

		self:updataCell(cell, idx)

		return cell
	end

	local function scrollViewDidScroll(table)
		local offx = table:getContentOffset().x
		local idx = math.ceil(math.abs(offx) / (self._scrollPanel:getContentSize().width - 10))

		idx = idx == 0 and 1 or idx

		if idx ~= self._curSelectScrollIndex then
			self._curSelectScrollIndex = idx

			self:changePageView()
		end
	end

	local tableView = cc.TableView:create(self._scrollPanel:getContentSize())

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(0, 1)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._scrollPanel)
	tableView:setBounceable(false)

	self._tableView = tableView
end

function EmotionTipWidget:updataCell(cell, index)
	cell:removeAllChildren()

	local vindex = index * (KHNUM * KVNUM)

	for i = 1, KHNUM * KVNUM do
		local idx = vindex + i

		if idx <= #self._data then
			local node = self._cloneCell:clone()

			node:setVisible(true)
			cell:addChild(node)
			node:setAnchorPoint(cc.p(0, 0))
			node:setTag(idx)

			if i > KVNUM then
				if not (i - KVNUM) then
					local xi = i
					local y = self._cloneCell:getContentSize().height
					local y

					if i > KVNUM then
						y = 0
					end

					node:setPosition(cc.p((xi - 1) * self._cloneCell:getContentSize().width, y))

					node.data = self._data[idx]

					self:createEmotion(node, idx)
				end
			end
		end
	end
end

function EmotionTipWidget:createEmotion(node, index)
	if not node then
		return
	end

	local data = node.data
	local path = string.format("asset/emotion/%s.png", data.Icon)

	node:getChildByFullName("img"):loadTexture(path)
	node:setTouchEnabled(true)
	node:setSwallowTouches(false)

	local function callFunc(sender, eventType)
		local beganPos = sender:getTouchBeganPosition()
		local endPos = sender:getTouchEndPosition()

		if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
			if self._callFunc then
				self._callFunc(data)
			end

			self:onClickMaskLayer()
		end
	end

	mapButtonHandlerClick(nil, node, {
		func = callFunc
	})
end

function EmotionTipWidget:tabClick(sender)
	if sender then
		if self._curSelectId == sender.tag then
			return
		end

		self._curSelectId = sender.tag
		self._curSelectScrollIndex = 1
	end

	self:changeBtn()
	self:getData()
	self:setPageView()
	self._tableView:reloadData()
end

function EmotionTipWidget:changeBtn()
	for i = 1, #self._tabIds do
		local bg = self._iconBtns[i]:getChildByFullName("bg")
		local img = self._curSelectId == i and "lt_btn_01.png" or "lt_btn_02.png"

		bg:loadTexture(img, ccui.TextureResType.plistType)
	end
end

function EmotionTipWidget:addTouchLayer()
	local touchPanel = self._view:getChildByName("touchPanel")

	touchPanel:setTouchEnabled(true)
	touchPanel:setSwallowTouches(false)

	local winSize = cc.Director:getInstance():getVisibleSize()

	touchPanel:setContentSize(winSize)
	touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:onClickMaskLayer()
		end
	end)
	touchPanel:setColor(cc.c3b(255, 0, 0))
end

function EmotionTipWidget:onClickMaskLayer(sender, touchType)
	self:getView():removeFromParent()
end

function EmotionTipWidget:setViewPosition(view)
	local worldPos = view:convertToWorldSpace(cc.p(0.5, 0.5))
	local offsetx = self._enterType == KEmotionShowType.KChat and -6 or -16
	local offsety = self._enterType == KEmotionShowType.KChat and 29 or 31

	self._tipPanel:setPosition(cc.p(worldPos.x + view:getContentSize().width / 2 + offsetx, worldPos.y + self._tipPanel:getContentSize().height / 2 - view:getContentSize().height / 2 + offsety))
end

ChatBubbleWidget = class("ChatBubbleWidget", BaseWidget, _M)

ChatBubbleWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

local KVNUM = 4
local KHNUM = 2
local KPOINTIMG = {
	"emoji_bg_dian_1.png",
	"emoji_bg_dian_2.png"
}

function ChatBubbleWidget.class:createWidgetNode()
	local resFile = "asset/ui/ChatBubble.csb"

	return cc.CSLoader:createNode(resFile)
end

function ChatBubbleWidget:initialize(view)
	super.initialize(self, view)
	self:initSubviews(view)
end

function EmotionTipWidget:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function ChatBubbleWidget:initSubviews(view)
	self._pointPanel = self._view:getChildByName("pointPanel")
	self._cloneCell = self._view:getChildByName("cellPanel")

	self._cloneCell:setVisible(false)

	self._pointImg = self._view:getChildByFullName("pointImg")

	self._pointImg:setVisible(false)

	self._scrollPanel = self._view:getChildByName("scrollPanel")

	self:addTouchLayer()
end

function ChatBubbleWidget:enterWithData(data)
	if not data then
		return
	end

	self._dataList = data.list
	self._callFunc = data.callFunc or nil
	self._enterType = data.type or KEmotionShowType.KChat
	self._curSelectId = data.selectId or self._dataList[1]
	self._curSelectScrollIndex = self._curSelectScrollIndex or 1

	dump(self._dataList, "self._dataLis")

	local offsetx = self._enterType == KEmotionShowType.KChat and 0 or 0
	local offsety = self._enterType == KEmotionShowType.KChat and 0 or 0

	adjustPos(data.sender, self._view, ItemTipsDirection.kUp, {
		x = offsetx,
		y = offsety
	})
	self:createTableView()
	self:setPageView()
end

function ChatBubbleWidget:setPageView()
	self._pointPanel:removeAllChildren()

	self._pointImgs = {}

	local n = math.ceil(#self._dataList / (KVNUM * KHNUM))
	local px = 150 - n * 10

	for i = 1, n do
		local pointImg = self._pointImg:clone()

		pointImg:setVisible(true)

		pointImg.tag = i

		pointImg:addTo(self._pointPanel):posite(px + (i - 1) * 20, 10)

		self._pointImgs[i] = pointImg
	end

	self:changePageView()
end

function ChatBubbleWidget:changePageView()
	local n = math.ceil(#self._dataList / (KVNUM * KHNUM))

	for i = 1, n do
		self._pointImgs[i]:getChildByFullName("img"):loadTexture((self._curSelectScrollIndex == i or nil) and (KPOINTIMG[2] or KPOINTIMG[1]), ccui.TextureResType.plistType)
	end
end

function ChatBubbleWidget:createTableView()
	local size = self._scrollPanel:getContentSize()

	local function numberOfCells(view)
		return math.ceil(#self._dataList / (KHNUM * KVNUM))
	end

	local function cellTouched(table, cell)
		return
	end

	local function cellSize(table, idx)
		return size.width, size.height
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		cell = cell or cc.TableViewCell:new()

		self:updataCell(cell, idx)

		return cell
	end

	local function scrollViewDidScroll(table)
		local offx = table:getContentOffset().x
		local idx = math.ceil(math.abs(offx) / 550)

		idx = idx == 0 and 1 or idx

		if idx ~= self._curSelectScrollIndex then
			self._curSelectScrollIndex = idx

			self:changePageView()
		end
	end

	local tableView = cc.TableView:create(size)

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_HORIZONTAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:setAnchorPoint(0, 0)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellTouched, cc.TABLECELL_TOUCHED)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:addTo(self._scrollPanel):posite(0, 0)
	tableView:setBounceable(false)

	self._tableView = tableView

	self._tableView:reloadData()
end

function ChatBubbleWidget:updataCell(cell, index)
	cell:removeAllChildren()

	local vindex = index * (KHNUM * KVNUM)

	for i = 1, KHNUM * KVNUM do
		local idx = vindex + i

		if idx <= #self._dataList then
			local node = self._cloneCell:clone()

			node:setVisible(true)
			cell:addChild(node)
			node:setAnchorPoint(cc.p(0, 0))
			node:setTag(idx)

			if i > KVNUM then
				if not (i - KVNUM) then
					local xi = i
					local y = self._cloneCell:getContentSize().height
					local y

					if i > KVNUM then
						y = 0
					end

					node:setPosition(cc.p((xi - 1) * (self._cloneCell:getContentSize().width + 13), y))

					node.data = self._dataList[idx]

					self:createBubble(node, idx)
				end
			end
		end
	end
end

function ChatBubbleWidget:createBubble(node, index)
	if not node then
		return
	end

	local data = node.data
	local config = data.config
	local path = string.format("asset/ui/chatBubble/%s.png", config.Icon)
	local iconNode = node:getChildByFullName("img")

	iconNode:removeAllChildren()

	local img = ccui.ImageView:create(path)

	img:addTo(iconNode):center(iconNode:getContentSize())
	node:setTouchEnabled(true)
	node:setSwallowTouches(false)
	node:getChildByFullName("name"):setString(Strings:get(config.Name))

	local selectImg = node:getChildByName("img_select")
	local limitNode = node:getChildByName("limit")
	local lockImg = node:getChildByName("lock")

	limitNode:setVisible(data.isLimit and data.expireTime ~= nil)
	lockImg:setVisible(data.unlock == 0)
	selectImg:setVisible(data.id == self._curSelectId)

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if limitNode:isVisible() then
		self:refreshTimer(node, index)
	end

	local function callFunc(sender, eventType)
		self:onClickBubble(sender, data)
	end

	mapButtonHandlerClick(nil, node, {
		func = callFunc
	})
	node:setSwallowTouches(false)
end

function ChatBubbleWidget:refreshTimer(node, index)
	local data = node.data
	local timeText = node:getChildByFullName("limit.time")
	local gameServerAgent = self:getInjector():getInstance(GameServerAgent)

	local function checkTimeFunc()
		local curTime = gameServerAgent:remoteTimeMillis()
		local remainTime = data.expireTime - curTime
		local str = TimeUtil:formatTimeStr(remainTime * 0.001)

		timeText:setString(str)
	end

	self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()
end

function ChatBubbleWidget:onClickBubble(sender, data)
	local beganPos = sender:getTouchBeganPosition()
	local endPos = sender:getTouchEndPosition()
	local config = data.config

	if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
		if data.unlock == 0 then
			self:getEventDispatcher():dispatchEvent(ShowTipEvent({
				tip = Strings:get(config.UnlockDesc)
			}))
		else
			self._curSelectId = data.id

			local offset = self._tableView:getContentOffset()

			self._tableView:reloadData()
			self._tableView:setContentOffset(offset)
		end
	end
end

function ChatBubbleWidget:addTouchLayer()
	local touchPanel = self._view:getChildByName("touchPanel")

	touchPanel:setTouchEnabled(true)
	touchPanel:setSwallowTouches(false)

	local winSize = cc.Director:getInstance():getVisibleSize()

	touchPanel:setContentSize(winSize)
	touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.began then
			self:onClickMaskLayer()
		end
	end)
	touchPanel:setColor(cc.c3b(255, 0, 0))
end

function ChatBubbleWidget:onClickMaskLayer(sender, touchType)
	if self._callFunc then
		self._callFunc({
			selectId = self._curSelectId
		})
	end

	self:getView():removeFromParent()
end

function ChatBubbleWidget:setViewPosition(view)
	local worldPos = view:convertToWorldSpace(cc.p(0.5, 0.5))
	local offsetx = self._enterType == KEmotionShowType.KChat and -6 or -16
	local offsety = self._enterType == KEmotionShowType.KChat and 29 or 31

	self._tipPanel:setPosition(cc.p(worldPos.x + view:getContentSize().width / 2 + offsetx, worldPos.y + self._tipPanel:getContentSize().height / 2 - view:getContentSize().height / 2 + offsety))
end
