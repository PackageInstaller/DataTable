-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatTableView.lua

module("logic.extensions.chat.view.ChatTableView", package.seeall)

local ChatTableView = class("ChatTableView", ViewComponent)
local CharacterLimit = 50
local ChatPrefabTag = {
	Sprite = 4,
	WordOther = 2,
	TimeStamp = 5,
	System = 3,
	SystemWithHead = 6,
	WordMy = 1
}

function ChatTableView:ctor()
	ChatTableView.super.ctor(self)

	self._notReadCount = 0
	self._resDict = {}
end

function ChatTableView:bindEventsNew()
	self._Input_Chat:AddOnValueChanged(self.onInputValueChange, self)
	self._Input_Chat:AddOnEndEdit(self.onInputEndEdit, self)
	self._Btn_Send:AddClickListener(self.onClickBtnSend, self)
	self._Btn_Emoji:AddClickListener(self.onClickEmoji, self)
	self._Btn_SpringToMax:AddClickListener(self.onClickSpringToMax, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMsgAdd, self.onMsgAdd, self)
	GlobalDispatcher:addListener(GlobalNotify.EmojiSelected, self.onEmojiSelected, self)
end

function ChatTableView:unbindEventsNew()
	self._Input_Chat:RemoveOnValueChanged()
	self._Input_Chat:RemoveOnEndEdit()
	self._Btn_Send:RemoveClickListener()
	self._Btn_Emoji:RemoveClickListener()
	self._Btn_SpringToMax:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.OnMsgAdd, self.onMsgAdd, self)
	GlobalDispatcher:removeListener(GlobalNotify.EmojiSelected, self.onEmojiSelected, self)
	self._tableview:RemoveScrollValueChanged()
end

function ChatTableView:buildUI()
	ChatTableView.super.buildUI(self)

	self._Btn_Send = self:getBtn("Nego_Chat/Nego_Bottom/Btn_Send")
	self._Input_Chat = self:getInput("Nego_Chat/Nego_Bottom/Input_Chat")
	self._Btn_Emoji = self:getBtn("Nego_Chat/Nego_Bottom/Btn_Emoji")
	self._Btn_SpringToMax = self:getBtn("Nego_Chat/Nego_Bottom/Btn_SpringToMax")
	self._TxtC_NotRead = goutil.findChildTextComponent(self._Btn_SpringToMax.btn.gameObject, "TxtC_NotRead")

	self._Input_Chat:SetCharacterLimit(CharacterLimit)

	self._tableview = self:getGo("Nego_Chat/Nego_Right/SrlC_Chat"):GetComponent("UITableview")
	self._tableSrollRect = self._tableview.gameObject:GetComponent(ComponentType.ScrollRect)
	self._tableCells = {}
	self._tableCells[ChatPrefabTag.WordMy] = self:getGo("Nego_Chat/Nego_Right/item_my")
	self._tableCells[ChatPrefabTag.WordOther] = self:getGo("Nego_Chat/Nego_Right/item_other")
	self._tableCells[ChatPrefabTag.System] = self:getGo("Nego_Chat/Nego_Right/item_system")
	self._tableCells[ChatPrefabTag.Sprite] = self:getGo("Nego_Chat/Nego_Right/item_sprite")
	self._tableCells[ChatPrefabTag.TimeStamp] = self:getGo("Nego_Chat/Nego_Right/item_time")
	self._tableCells[ChatPrefabTag.SystemWithHead] = self:getGo("Nego_Chat/Nego_Right/item_system_head")

	for _, v in pairs(self._tableCells) do
		goutil.setActive(v, true)

		local x, y, z = Framework.TransformUtil.GetLocalPos(v.transform, 0, 0, 0)

		Framework.TransformUtil.SetLocalPos(v.transform, x + 10000, y, z)
	end

	self._emojiPoint = self:getGo("emojiPoint")
	self._emptyGo = self:getGo("Nego_Chat/empty")
end

function ChatTableView:_numInView()
	if not self._curViewDatas then
		return 0
	end

	return #self._curViewDatas
end

function ChatTableView:destroyUI()
	return
end

function ChatTableView:onEnter()
	ChatTableView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.CopyTxtToChatViewInputText, self._onCopyTxtToChatViewInputText, self)
	self.addGEvent(self, GlobalNotify.CodeWordInputText, self._onCodeWordInputText, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableview:RegisterReloadFinishCallback(self._onReloadFinish)

	self._itemChatMap = {}

	self:bindEventsNew()
end

function ChatTableView:onEnterFinished()
	return
end

function ChatTableView:onExit()
	ChatTableView.super.onExit(self)

	for k, v in pairs(self._itemChatMap) do
		v:_onClear()
	end

	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = nil

	self:unbindEventsNew()
	removetimer(self.Refresh, self)
	self._tableview:UnRegisterAllCallbacks()
end

function ChatTableView:onExitFinished()
	return
end

function ChatTableView:_cellSize(view, index)
	return 474, self:getCellHeight(index + 1)
end

function ChatTableView:setSpriteAnim(spriteAnim, id)
	self._loadCallBacks = self._loadCallBacks or {}
	self._spriteAnimIds = self._spriteAnimIds or {}

	local lastId = self._spriteAnimIds[spriteAnim]
	local lastCallBack = self._loadCallBacks[spriteAnim]
	local image = spriteAnim:GetComponent("Image")

	if lastId ~= id then
		spriteAnim:Reset()
		Game.ImageUtil.SetImageAlpha(image, 0)

		if lastCallBack then
			NewChatController.instance:removeLoadEmojiPackCallback(lastId, lastCallBack)
		end

		local cfg = ChatConfig.instance:getEmojiCfg(id)

		if cfg then
			if cfg.length > 1 then
				local function callback(loader)
					Game.ImageUtil.SetImageAlpha(image, 1)

					local resources = loader:getResources()
					local urlList = loader._resPaths
					local len = #urlList

					if len > 0 then
						for i = 1, len do
							local path = urlList[i]
							local res = resources[path]
							local texture = res:GetMainAsset()

							spriteAnim:AddSprite(texture)

							if i == 1 then
								image.sprite = spriteAnim.spriteList[0]
							end
						end

						spriteAnim:Play()
					end
				end

				self._loadCallBacks[spriteAnim] = callback

				NewChatController.instance:loadEmojiPack(id, callback)
			elseif cfg.length == 1 then
				local groupCfg = ChatConfig.instance:getEmojiGroupCfg(cfg.groupId)
				local url = string.format("ui/emoji/%s/%s.png", groupCfg.groupPrefix, cfg.icon)

				uGuiUtil.setSpriteToImage(spriteAnim.gameObject, uGuiUtil.SpriteType.BigBg, url)
				Game.ImageUtil.SetImageAlpha(image, 1)
			end
		end

		self._spriteAnimIds[spriteAnim] = id
	end
end

function ChatTableView:_createItemChatNormal(data, go, tag)
	local item = self._itemChatMap[go.gameObject]

	if not item then
		item = ItemChatNormal.New(go.gameObject, tag)
		self._itemChatMap[go.gameObject] = item
	else
		item:buildUIWithTag(tag)
	end

	item:setEffectClip(self, self._tableSrollRect)
	item:Refresh(data, self._viewName, self._nowTime)

	return item
end

function ChatTableView:_cellAtIndex(view, idx)
	local data = self._curViewDatas[idx + 1]
	local tag = self:_getCellTag(data)
	local content = data:getContent()
	local cell = view:DequeueCellByTag(tag)

	cell = cell or view:AddChild(self._tableCells[tag], tag)

	local item

	if tag == 1 or tag == 2 or tag == 3 or tag == ChatPrefabTag.SystemWithHead then
		item = self:_createItemChatNormal(data, cell, tag)
	elseif tag == 4 then
		local container = goutil.findChild(cell.gameObject, "container")
		local spriteAnim = goutil.findChildComponent(container, "img", "UISpriteAnimEx")
		local imgIconChange = goutil.findChild(container, "Nego_Icon/ImgC_Icon")
		local txtNameMyGo = goutil.findChild(container, "TxtC_NameMy")
		local txtNameGo = goutil.findChild(container, "TxtC_Name")

		GameUtil.SetActive(txtNameMyGo, false)
		GameUtil.SetActive(txtNameGo, false)

		local txtNameMy = goutil.findChildTextComponent(container, "TxtC_NameMy")

		txtNameMy.text = data:getSenderName()

		local areaGoMy = goutil.findChild(container, "TxtC_NameMy/area")
		local txtAareaMy = goutil.findChildTextComponent(container, "TxtC_NameMy/area/txt")

		GameUtil.SetActive(areaGoMy, false)

		local txtName = goutil.findChildTextComponent(container, "TxtC_Name")

		txtName.text = data:getSenderName()

		local areaGo = goutil.findChild(container, "TxtC_Name/area")
		local txtAarea = goutil.findChildTextComponent(container, "TxtC_Name/area/txt")

		GameUtil.SetActive(areaGo, false)

		if data:getIsMe() then
			GameUtil.SetActive(txtNameMyGo, true)
			HeadItemController.instance:setMyHeadCell(imgIconChange)
		else
			GameUtil.SetActive(txtNameGo, true)
			HeadItemController.instance:setHeadCell(imgIconChange, data:getHeadIconId(), data:getHeadFrameId(), data.vipLv)

			if not string.nilorempty(data.areaName) then
				GameUtil.SetActive(areaGo, true)

				txtAarea.text = data.areaName
			end
		end

		local id = checknumber(content)

		self:setSpriteAnim(spriteAnim, id)

		local Nego_Icon = goutil.findChild(container, "Nego_Icon")
		local iconRectTrans = Nego_Icon:GetComponent("RectTransform")
		local spriteRectTrans = spriteAnim:GetComponent("RectTransform")

		if data:getIsMe() then
			local x, y = Framework.TransformUtil.GetAnchoredPos(iconRectTrans, 0, 0)

			Framework.TransformUtil.SetAnchoredPos(iconRectTrans, math.abs(x), y)

			x, y = Framework.TransformUtil.GetAnchoredPos(spriteRectTrans, 0, 0)

			Framework.TransformUtil.SetAnchoredPos(spriteRectTrans, math.abs(x), y)
		else
			local x, y = Framework.TransformUtil.GetAnchoredPos(iconRectTrans, 0, 0)

			Framework.TransformUtil.SetAnchoredPos(iconRectTrans, -math.abs(x), y)

			x, y = Framework.TransformUtil.GetAnchoredPos(spriteRectTrans, 0, 0)

			Framework.TransformUtil.SetAnchoredPos(spriteRectTrans, -math.abs(x), y)
		end

		local btnIcon = Framework.ButtonAdapter.Get(Nego_Icon)

		if btnIcon then
			btnIcon:RemoveClickListener()

			if not data:getIsMe() then
				btnIcon:AddClickListener(function()
					local userId = data:getSenderId()

					FriendController.instance:showInfoView(userId, Nego_Icon)
				end)
			end
		end
	elseif tag == 5 then
		local text = goutil.findChildTextComponent(cell.gameObject, "text")

		text.text = os.date("-  %Y/%m/%d  %H:%M:%S  -", checknumber(content))
	end

	return cell
end

function ChatTableView:_getCellTag(data)
	local msgType = data:getMsgType()

	return msgType == GameEnum.ChatType.Sprite and 4 or checknumber(data._senderId) > 0 and (data:getIsMe() and 1 or 2) or msgType == GameEnum.ChatType.TimeStamp and 5 or msgType == GameEnum.ChatType.System and checknumber(data._senderId) <= 0 and 2 or 3
end

function ChatTableView:_onReloadFinish()
	if self._isToMax then
		self._notReadCount = 0

		self._tableview:SetOffset(self._tableview:GetMaxOffset(), self._isSpring)
	end

	self:setNotRead()
	self._tableview:AddOnScrollValueChanged(self._onScrollValueChange, self)
end

function ChatTableView:_onScrollValueChange(value)
	if value.y <= 0 then
		self:onClickSpringToMax(false)
	end
end

function ChatTableView:setNotRead()
	self._Btn_SpringToMax.btn.gameObject:SetActive(self._notReadCount > 0)

	self._TxtC_NotRead.text = string.format("未读消息%s条", self._notReadCount)
end

function ChatTableView:_clearTableview(cell)
	local imgIconChange = goutil.findChild(cell, "container/Nego_Icon/ImgC_Icon")

	MaterialMgr.resetAll(imgIconChange)

	local headIcon = goutil.findChild(cell, "Nego_Icon/ImgC_Icon")

	MaterialMgr.resetAll(headIcon)

	local spriteAnim = goutil.findChildComponent(cell.gameObject, "container/img", "UISpriteAnimEx")

	self._loadCallBacks = self._loadCallBacks or {}
	self._spriteAnimIds = self._spriteAnimIds or {}

	local lastId = self._spriteAnimIds[spriteAnim]
	local lastCallBack = self._loadCallBacks[spriteAnim]

	if lastId and lastCallBack then
		NewChatController.instance:removeLoadEmojiPackCallback(lastId, lastCallBack)
	end
end

function ChatTableView:getCellHeight(index)
	local data = self._curViewDatas[index]
	local tag = self:_getCellTag(data)
	local content = data:getContent()

	if tag == ChatPrefabTag.Sprite then
		return 210
	elseif tag == ChatPrefabTag.TimeStamp then
		return 33
	else
		local cell = self._tableCells[tag]
		local imgContenBg = goutil.findChild(cell, "container/ImgC_ContentBg")
		local txtContent = goutil.findChildTextComponent(imgContenBg, "TxtC_Content")
		local height = NewChatFacade.instance:getChatTextPreferedHeight(txtContent, content, (tag == ChatPrefabTag.System or nil) and 432, imgContenBg)

		if tag == ChatPrefabTag.System then
			return height + 20
		else
			local isMe = data:getIsMe()
			local bubbleId = 1

			if isMe then
				bubbleId = NewChatModel.instance:getChatBubbleId()
			elseif data:getChannel() == 0 then
				local friendMo = FriendModel.instance:getFriendMo(data._senderId)

				if friendMo then
					bubbleId = friendMo:getValue("bubbleId")
				end
			elseif checknumber(data.bubbleId) > 0 then
				bubbleId = data.bubbleId
			end

			bubbleId = checknumber(bubbleId)

			local cfg = ChatConfig.instance:getChatBubbleCfgById(bubbleId)

			if cfg then
				return height + 48 - checknumber(cfg.offsetY)
			else
				return height + 48
			end
		end
	end
end

function ChatTableView:onInputValueChange()
	local len = string.utf8len(self._Input_Chat:GetText())

	if len >= CharacterLimit then
		FloatWordMgr.instance:show("消息太长啦！")
	end
end

function ChatTableView:onInputEndEdit()
	local startPos = self._Input_Chat.input.selectionAnchorPosition
	local endPos = self._Input_Chat.input.selectionFocusPosition

	self._caretPos = self._Input_Chat.input.caretPosition
	self._startPos = math.min(startPos, endPos)
	self._endPos = math.max(startPos, endPos)
end

function ChatTableView:onClickBtnSend(content, msgType)
	if self._channel ~= GameEnum.ChatChannel.Private and RoleController.instance:getIsRoleBaned() then
		RoleController.instance:showBanTips()

		return
	end

	local leftTime = self:getSendLeftTime()

	if leftTime > 0 then
		FloatWordMgr.instance:show(string.format("说话过于频繁，请%s秒后再发", math.ceil(leftTime)))

		return
	end

	if content == nil then
		content = self._Input_Chat:GetText()
	end

	if not content or #content == 0 then
		FloatWordMgr.instance:show("请输入聊天内容再发送")
	elseif self:checkChannelLimit() then
		if string.find(content, "\r") or string.find(content, "\n") then
			FloatWordMgr.instance:show("输入内容含有非法字符")

			return
		end

		content = string.gsub(content, "%s+", "")
		content = string.gsub(content, "<", "＜")
		content = string.gsub(content, ">", "＞")

		self:checkEnoughAndSendMsg(content, msgType)
	end
end

function ChatTableView:checkChannelLimit()
	return true
end

function ChatTableView:checkEnoughAndSendMsg(content, msgType)
	self:sendMsg(self._channel, content, msgType)
end

function ChatTableView:sendMsg(channel, content, msgType, isFree)
	local v = FriendConfig.instance:getCommonValue("NO_CHATTING_PERIOD")
	local times = string.split(v, "#")

	if #times == 2 and GameUtil.checkIsInTimePeriod(times[1], times[2]) then
		FloatWordMgr.instance:show("聊天系统正在进行技术维护，具体开放时间请留意公告！")

		return
	end

	self:setSendTime()
	self:checkSendCd()

	local cfgCodeWord = CodeWordConfig.instance:getCfgByText(content, channel)

	if cfgCodeWord then
		msgType = GameEnum.ChatType.CodeWord
		content = self:_getCodeWordContent(cfgCodeWord)
	end

	if msgType == nil then
		msgType = GameEnum.ChatType.Word
	end

	ViewMgr.instance:close(ViewName.ChatEmoji)
	ChatAgent.instance:sendSendMsgReq(channel, msgType, content, self._friendId, nil, function()
		if GameEnum.ChatChannel.Private then
			FriendModel.instance:updateChatTime(self._friendId)
		end

		self:_onSendMsgSuccess(isFree)
	end)
end

function ChatTableView:_onSendMsgSuccess(isFree)
	self._Input_Chat:SetText("")

	if isFree then
		print("free send Msg Success")

		local times = NewChatModel.instance:getUsedWorldChatFreeTimes()

		times = times + 1

		NewChatModel.instance:setUsedWorldChatFreeTimes(times)
	end
end

function ChatTableView:onClickEmoji()
	local x, y, _ = Framework.TransformUtil.GetPos(self._emojiPoint.transform, 0, 0, 0)

	UIStateManager.instance:open(ViewName.ChatEmoji, x, y)
end

function ChatTableView:onClickSpringToMax(setOffset)
	self._notReadCount = 0

	self:setNotRead()

	if setOffset == true or setOffset == nil then
		self._tableview:SetOffset(self._tableview:GetMaxOffset(), true)
	end
end

function ChatTableView:onMsgAdd(channel, friendId, msgCount, isMe)
	if not self._tableview.isReady or channel ~= self._channel then
		return
	end

	if channel == GameEnum.ChatChannel.Private and tostring(self._friendId) ~= tostring(friendId) then
		return
	end

	local curOffset = self._tableview:GetFinalOffset()
	local maxOffset = self._tableview:GetMaxOffset()

	self._isToMax = maxOffset - curOffset <= 20 or isMe
	self._isSpring = true
	self._notReadCount = not self._isToMax and self._notReadCount + msgCount or 0

	self:Refresh()
	NewChatModel.instance:SetMsgAllRead(channel, friendId)
end

function ChatTableView:onEmojiSelected(id)
	self:onClickBtnSend(tostring(id), GameEnum.ChatType.Sprite)
end

function ChatTableView:updateCaretPos()
	return
end

function ChatTableView:checkSendCd()
	local leftTime = self:getSendLeftTime()

	if leftTime > 0 then
		settimer(0.1, self.updateSendCd, self, true)
	end
end

function ChatTableView:updateSendCd()
	local leftTime = self:getSendLeftTime()

	if leftTime <= 0 then
		removetimer(self.updateSendCd, self)
	end
end

function ChatTableView:getSendLeftTime()
	return NewChatController.instance:getSendLeftTime(self._channel)
end

function ChatTableView:setSendTime()
	NewChatController.instance:setSendTime(self._channel)
end

function ChatTableView:initChatRoom(channel, param)
	self:ClearSelf()
	NewChatModel.instance:SetMsgAllRead(channel, param)
	print("self._channel = " .. channel .. "friendId = " .. tostring(param))

	self._channel = channel

	if param then
		self._friendId = param
	end

	self._isToMax = true
	self._isSpring = false

	self:Refresh()
	self:checkSendCd()

	local openParam = self._viewPresentor:getOpenParam()

	if openParam and not string.nilorempty(openParam[2]) then
		self._Input_Chat:SetText(openParam[2])

		openParam[2] = nil
	end
end

function ChatTableView:ClearSelf()
	self._channel = -1
	self._notReadCount = 0

	self._Input_Chat:SetText("")
end

function ChatTableView:Refresh()
	self._curViewDatas = NewChatModel.instance:GetMsgsByChannel(self._channel, self._friendId, true)

	local useChatWordEffect = ChatSettingModel.instance:GetEnableChatWordEffect()

	for i, v in ipairs(self._curViewDatas) do
		if v.__cname == "ChatMsgMo" and v:getIsMe() == true then
			v.enableChatWordEffect = useChatWordEffect
		end
	end

	self._nowTime = ServerTime.nowServerLook()

	for k, v in pairs(self._itemChatMap) do
		v:_onClear()
	end

	self._itemChatMap = {}

	self._tableview:ReloadData()
	self:_updateEmptyUI()
end

function ChatTableView:_updateEmptyUI()
	local isEmpty = not self._curViewDatas or #self._curViewDatas <= 0

	if self._channel == GameEnum.ChatChannel.League and FuncOpenModel.instance:getFuncIsOpen(60) then
		local hasFamily = FamilyController.instance:getFamilyLv() > 0

		if not hasFamily then
			isEmpty = false
		end
	end

	goutil.setActive(self._emptyGo, isEmpty)
end

function ChatTableView:_onCodeWordInputText(text)
	self._Input_Chat:SetText(text)
end

function ChatTableView:_getCodeWordContent(cfgCodeWord)
	local mo = {}

	mo.groupId = cfgCodeWord.groupId
	mo.id = cfgCodeWord.id

	return GameUtil.jsonToString(mo)
end

function ChatTableView:_getFilterContent()
	return
end

function ChatTableView:_onCopyTxtToChatViewInputText(content)
	if string.nilorempty(self._Input_Chat:GetText()) then
		self._Input_Chat:SetText(content)
	end
end

return ChatTableView
