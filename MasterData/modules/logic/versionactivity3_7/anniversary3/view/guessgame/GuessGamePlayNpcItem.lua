-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayNpcItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayNpcItem", package.seeall)

local GuessGamePlayNpcItem = class("GuessGamePlayNpcItem", LuaCompBase)

function GuessGamePlayNpcItem:init(rootgo, posGo, go)
	self.rootGo = rootgo
	self.posGo = posGo

	gohelper.setActive(posGo, false)

	self._gogift = gohelper.findChild(self.rootGo, "gift")

	if go then
		self.go = go
		self._goselect = gohelper.findChild(self.go, "root/go_selectMask")
		self._gonormal = gohelper.findChild(self.go, "root/go_normal")
		self._imagechess = gohelper.findChildImage(self.go, "root/go_normal/image_chess")
		self._txtname = gohelper.findChildText(self.go, "root/go_normal/namebg/txt_name")
		self._goselecttip = gohelper.findChild(self.go, "root/go_select")
		self._btnclick = gohelper.findChildButtonWithAudio(self.go, "root/btn_click")

		gohelper.setActive(self.go, true)

		self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	end

	self._giftItems = self:getUserDataTb_()

	self:_addEvents()
end

function GuessGamePlayNpcItem:_btnclickOnClick()
	return
end

function GuessGamePlayNpcItem:_addEvents()
	if self._btnclick then
		self._btnclick:AddClickListener(self._btnclickOnClick, self)
	end
end

function GuessGamePlayNpcItem:_removeEvents()
	if self._btnclick then
		self._btnclick:RemoveClickListener()
	end
end

function GuessGamePlayNpcItem:refresh(index)
	self._index = index

	local npcId = GuessGameModel.instance:getGameRoleByIndex(self._index)
	local npcCo = Activity234Config.instance:getNpcCo(npcId)

	if npcCo then
		self._txtname.text = npcCo.name

		UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imagechess, npcCo.icon)
	end
end

function GuessGamePlayNpcItem:showGift(giftList)
	gohelper.setActive(self._gogift, true)

	if not giftList or #giftList <= 0 then
		return
	end

	if #self._giftItems <= 0 then
		for i = 1, #giftList do
			if not self._giftItems[i] then
				self._giftItems[i] = GuessGamePlayGiftItem.New()

				local go = gohelper.clone(self.posGo, self._gogift)

				self._giftItems[i]:init(go, i)
			end

			self._giftItems[i]:refresh(giftList[i])
		end
	end

	for _, giftItem in pairs(self._giftItems) do
		giftItem:showItem(true)
	end
end

function GuessGamePlayNpcItem:showGifts(show)
	gohelper.setActive(self._gogift, show)
end

function GuessGamePlayNpcItem:hideGift(giftList)
	if not giftList or #giftList <= 0 then
		return
	end

	for i = 1, #giftList do
		local index = giftList[i]

		if self._giftItems[index] then
			self._giftItems[index]:playAnim("unopen_out")
		end
	end

	self._hideGifts = giftList

	gohelper.setActive(self._gogift, true)
	TaskDispatcher.runDelay(self._onOutFinished, self, 0.2)
end

function GuessGamePlayNpcItem:_onOutFinished()
	for i = 1, #self._hideGifts do
		local index = self._hideGifts[i]

		if self._giftItems[index] then
			self._giftItems[index]:showItem(false)
		end
	end
end

function GuessGamePlayNpcItem:showSelectByIndexs(indexList)
	if not self._giftItems then
		return
	end

	for _, index in pairs(indexList) do
		if self._giftItems[index] then
			self._giftItems[index]:showSelect(true)
		end
	end
end

function GuessGamePlayNpcItem:showNpcSelect(show)
	local animName = show and "select" or "normal"

	if show then
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_choose)
	end

	if self._anim then
		self._anim:Play(animName, 0, 0)
	end
end

function GuessGamePlayNpcItem:showNpc(show)
	gohelper.setActive(self.rootGo, show)
end

function GuessGamePlayNpcItem:showGiftOpen(lock)
	if self._giftItems then
		for _, item in pairs(self._giftItems) do
			item:showOpen(lock)
		end
	end
end

function GuessGamePlayNpcItem:destroy()
	TaskDispatcher.cancelTask(self._onOutFinished, self)

	if self._giftItems then
		for _, item in pairs(self._giftItems) do
			item:destroy()
		end

		self._giftItems = nil
	end

	self:_removeEvents()
end

return GuessGamePlayNpcItem
