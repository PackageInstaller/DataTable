-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatMsgItemCell.lua

module("logic.extensions.chat.view.ChatMsgItemCell", package.seeall)

local M = class("ChatMsgItemCell")

function M:ctor(go)
	self._go = go
	self._tipsPosGo = nil

	self:_buildUI()
end

function M:_buildUI()
	self._contentHightGo = goutil.findChild(self._go, "contentHight")
	self._txtTimeContentGo = goutil.findChild(self._go, "contentHight/txtTimeContent")
	self._txtTime = goutil.findChildTextComponent(self._go, "contentHight/txtTimeContent/txtTime")
	self._imgHeadIcon = goutil.findChildImageComponent(self._go, "contentHight/other/cell/head_item/mask/headIcon")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "contentHight/other/cell/head_item/click"))
	self._txtName = goutil.findChildTextComponent(self._go, "contentHight/other/txtContent/txtName")
	self._txtRemark = goutil.findChildTextComponent(self._go, "contentHight/other/txtContent/txtRemark")
	self._qiPaoGo = goutil.findChild(self._go, "contentHight/other/lay/qiPao")
	self._txtChat = goutil.findChildTextComponent(self._go, "contentHight/other/lay/qiPao/txtChat")
	self._emojiContentGo = goutil.findChild(self._go, "contentHight/other/emojiContent")
	self._imgEmoji = goutil.findChildImageComponent(self._go, "contentHight/other/emojiContent/imgEmoji")

	local headLockGo = goutil.findChild(self._go, "contentHight/other/cell/head_item/lock")

	headLockGo:SetActive(false)
	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickBtnClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:updateData(data)
	self._data = data

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(data:getPortrait())

	IconLoader.setSprite(self._imgHeadIcon, IconType.HeadIcon, itemCo.icon)

	local alias = data:getShowAlias()

	self._txtName.text = data:getShowNickName()
	self._txtRemark.text = alias

	if not string.nilorempty(alias) then
		goutil.setActive(self._txtName.gameObject, false)
		goutil.setActive(self._txtRemark.gameObject, true)
	else
		goutil.setActive(self._txtName.gameObject, true)
		goutil.setActive(self._txtRemark.gameObject, false)
	end

	local msgType = data:getMessageType()

	self._qiPaoGo:SetActive(msgType == GameEnum.MessageTypeEnum.Text)
	self._emojiContentGo:SetActive(msgType == GameEnum.MessageTypeEnum.Emoji)

	if msgType == GameEnum.MessageTypeEnum.Text then
		self._txtChat.text = data:getContent()

		local width = math.min(self._txtChat.preferredWidth + 40, 458)

		RectTransformUtils.SetWidth(self._qiPaoGo.transform, width)

		if not data:isSendByMe() then
			self._txtChat.alignment = UnityEngine.TextAnchor.UpperLeft
		elseif self._txtChat.preferredWidth + 40 >= 458 then
			self._txtChat.alignment = UnityEngine.TextAnchor.UpperLeft
		else
			self._txtChat.alignment = UnityEngine.TextAnchor.UpperRight
		end
	end

	if msgType == GameEnum.MessageTypeEnum.Emoji then
		local emojiId = tonumber(data:getContent())
		local emojiCfg = ChatConfig.instance:getEmojiCfg(emojiId)

		IconLoader.setSprite(self._imgEmoji, IconType.ChatEmoji, emojiCfg.icon)
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

function M:setTipsPosGo(go)
	self._tipsPosGo = go
end

function M:_onClickBtnClick()
	if self._data:isSendByMe() then
		return
	end

	local userId = self._data:getSenderId()
	local relationType = GameEnum.RelationTypeEnum.Friend
	local friendMo = FriendModel.instance:getUser(relationType, userId)

	if not friendMo then
		relationType = GameEnum.RelationTypeEnum.Block
		friendMo = FriendModel.instance:getUser(relationType, userId)
	end

	if friendMo then
		local info = ToolTipsUtil.createFriendTipsData({
			friendMo = friendMo,
			msgMo = self._data
		}, self._tipsPosGo, false)

		ToolTipsMgr.showTips(ViewName.FriendTips, info)
	end
end

function M:setTimeVisible(visible)
	self._txtTimeContentGo:SetActive(visible)
	RectTransformUtils.ForceRebuildLayoutImmediate(self._contentHightGo.transform)
	goutil.setHeight(self._go.transform, goutil.getHeight(self._contentHightGo.transform))

	if visible then
		self._txtTime.text = TimeUtil.instance:stampToDateStr(self._data:getTime() / 1000)
	end
end

return M
