-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyEmojiView.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyEmojiView", package.seeall)

local PartyGameLobbyEmojiView = class("PartyGameLobbyEmojiView", BaseView)

function PartyGameLobbyEmojiView:onInitView()
	self._btnemoji = gohelper.findChildButtonWithAudio(self.viewGO, "root/emoji/#btn_emoji")
	self._gonormalEmoji = gohelper.findChild(self.viewGO, "root/emoji/#btn_emoji/#go_normalEmoji")
	self._goselectEmoji = gohelper.findChild(self.viewGO, "root/emoji/#btn_emoji/#go_selectEmoji")
	self._goemojiCD = gohelper.findChild(self.viewGO, "root/emoji/#btn_emoji/#go_emojiCD")
	self._imageemojiCD = gohelper.findChildImage(self.viewGO, "root/emoji/#btn_emoji/#go_emojiCD")
	self._goemojiTips = gohelper.findChild(self.viewGO, "root/emoji/#go_emojiTips")
	self._btncloseEmoji = gohelper.findChildButtonWithAudio(self.viewGO, "root/emoji/#go_emojiTips/#btn_closeEmoji")
	self._scrollemoji = gohelper.findChildScrollRect(self.viewGO, "root/emoji/#go_emojiTips/#scroll_emoji")
	self._goemojiContent = gohelper.findChild(self.viewGO, "root/emoji/#go_emojiTips/#scroll_emoji/Viewport/#go_emojiContent")
	self._goemojiItem = gohelper.findChild(self.viewGO, "root/emoji/#go_emojiTips/#scroll_emoji/Viewport/#go_emojiContent/#go_emojiItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyGameLobbyEmojiView:addEvents()
	self._btnemoji:AddClickListener(self._btnemojiOnClick, self)
	self._btncloseEmoji:AddClickListener(self._btncloseEmojiOnClick, self)
end

function PartyGameLobbyEmojiView:removeEvents()
	self._btnemoji:RemoveClickListener()
	self._btncloseEmoji:RemoveClickListener()
end

function PartyGameLobbyEmojiView:_btncloseEmojiOnClick()
	self.isShowEmoji = false

	self:refreshEmojiTipsState()
end

function PartyGameLobbyEmojiView:_btnemojiOnClick()
	if self.isInEmojiCD then
		GameFacade.showToast(ToastEnum.ChatRoomEmojiInCD)

		return
	end

	self.isShowEmoji = true

	self:refreshEmojiTipsState()
end

function PartyGameLobbyEmojiView:_btnemojiItemOnClick(emojiItem)
	PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.SendEmoji, emojiItem.config.id)
	self:sendEmojiFinish()
	PartyGameStatHelper.instance:partyGameMeme(emojiItem.config.id)
end

function PartyGameLobbyEmojiView:sendEmojiFinish()
	self.isInEmojiCD = true

	self:_btncloseEmojiOnClick()
end

function PartyGameLobbyEmojiView:_editableInitView()
	self.emojiItemList = {}

	gohelper.setActive(self._goemojiItem, false)

	self.isShowEmoji = false
	self.isInEmojiCD = false
	self.emojiCD = Activity225Config.instance:getConstValue(ChatRoomEnum.ConstId.SendEmojiCD, true) / 1000
	self.emojiAnim = gohelper.findChild(self.viewGO, "root/emoji"):GetComponent(typeof(UnityEngine.Animator))
end

function PartyGameLobbyEmojiView:onOpen()
	self.activityId = ChatRoomModel.instance:getCurActivityId()

	self:refreshEmojiList()
	self:refreshEmojiTipsState()
end

function PartyGameLobbyEmojiView:refreshEmojiList()
	local emojiConfigList = Activity225Config.instance:getMemeConfigList()

	for index, emojiConfig in ipairs(emojiConfigList) do
		local emojiItem = self.emojiItemList[index]

		if not emojiItem then
			emojiItem = {
				config = emojiConfig,
				go = gohelper.clone(self._goemojiItem, self._goemojiContent, "emoji" .. emojiConfig.id)
			}
			emojiItem.simageIcon = gohelper.findChildSingleImage(emojiItem.go, "imgae_icon")
			emojiItem.txtName = gohelper.findChildText(emojiItem.go, "txt_name")
			emojiItem.golock = gohelper.findChild(emojiItem.go, "go_lock")
			emojiItem.btnClick = gohelper.findChildButtonWithAudio(emojiItem.go, "btn_click")

			emojiItem.btnClick:AddClickListener(self._btnemojiItemOnClick, self, emojiItem)

			self.emojiItemList[index] = emojiItem
		end

		gohelper.setActive(emojiItem.go, true)
		gohelper.setActive(emojiItem.golock, false)

		emojiItem.txtName.text = emojiConfig.name

		emojiItem.simageIcon:LoadImage(emojiConfig.icon)
	end
end

function PartyGameLobbyEmojiView:refreshEmojiTipsState()
	gohelper.setActive(self._goemojiTips, self.isShowEmoji)
	gohelper.setActive(self._gonormalEmoji, true)
	gohelper.setActive(self._goselectEmoji, self.isShowEmoji and not self.isInEmojiCD)
	gohelper.setActive(self._goemojiCD, not self.isShowEmoji and self.isInEmojiCD)

	if self.isShowEmoji then
		self.emojiAnim:Play("select2", 0, 0)
		self.emojiAnim:Update(0)
	else
		self.emojiAnim:Play("idle", 0, 0)
		self.emojiAnim:Update(0)
	end

	if not self.isShowEmoji and self.isInEmojiCD then
		self.emojiCdTween = ZProj.TweenHelper.DOTweenFloat(1, 0, self.emojiCD, self.doSetEmojiCDProgress, self.doSetEmojiCDProgressFinish, self)
	end
end

function PartyGameLobbyEmojiView:doSetEmojiCDProgress(value)
	self._imageemojiCD.fillAmount = value
end

function PartyGameLobbyEmojiView:doSetEmojiCDProgressFinish()
	self.isInEmojiCD = false

	self:refreshEmojiTipsState()
end

function PartyGameLobbyEmojiView:onClose()
	if self.emojiCdTween then
		ZProj.TweenHelper.KillById(self.emojiCdTween)

		self.emojiCdTween = nil
	end
end

function PartyGameLobbyEmojiView:onDestroyView()
	for index, emojiItem in ipairs(self.emojiItemList) do
		emojiItem.btnClick:RemoveClickListener()
		emojiItem.simageIcon:UnLoadImage()
	end
end

return PartyGameLobbyEmojiView
