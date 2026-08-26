-- chunkname: @modules/logic/versionactivity3_1/nationalgift/view/NationalGiftFullBonusItem.lua

module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftFullBonusItem", package.seeall)

local NationalGiftFullBonusItem = class("NationalGiftFullBonusItem", LuaCompBase)

function NationalGiftFullBonusItem:init(go, co)
	self.go = go
	self._config = co
	self._goreward1 = gohelper.findChild(self.go, "group/go_reward1")
	self._goreward2 = gohelper.findChild(self.go, "group/go_reward2")
	self._gounget = gohelper.findChild(self.go, "go_unget")
	self._gohasget = gohelper.findChild(self.go, "go_hasget")
	self._gocanget = gohelper.findChild(self.go, "go_canget")
	self._gonextday = gohelper.findChild(self.go, "go_nextday")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")

	self:_initItem()
end

function NationalGiftFullBonusItem:_initItem()
	self._rewardItems = {}

	local rewards = string.split(self._config.bonus, "|")

	for index, reward in ipairs(rewards) do
		if not self._rewardItems[index] then
			local item = {}

			item.go = self["_goreward" .. index]
			item.txtnum = gohelper.findChildText(item.go, "txt_num")
			item.btnclick = gohelper.findChildButtonWithAudio(item.go, "click")

			item.btnclick:AddClickListener(self._onItemClick, self, index)

			self._rewardItems[index] = item
		end

		local rewards = string.splitToNumber(reward, "#")

		self._rewardItems[index].txtnum.text = rewards[3]
	end

	if self._btnClick then
		self._btnClick:AddClickListener(self._btnClickOnClick, self)
	end
end

function NationalGiftFullBonusItem:_onItemClick(index)
	local rewardCos = string.split(self._config.bonus, "|")
	local itemCo = string.splitToNumber(rewardCos[index], "#")

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function NationalGiftFullBonusItem:_btnClickOnClick()
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	if not isGiftHasBuy then
		return
	end

	local isCouldGet = NationalGiftModel.instance:isBonusCouldGet(self._config.id)

	if not isCouldGet then
		return
	end

	Activity212Rpc.instance:sendAct212ReceiveBonusRequest(NationalGiftModel.instance:getCurVersionActId(), self._config.id)
end

function NationalGiftFullBonusItem:refresh()
	local isGet = NationalGiftModel.instance:isBonusGet(self._config.id)
	local isCouldGet = NationalGiftModel.instance:isBonusCouldGet(self._config.id)
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	if self._gounget then
		local showUnget = self._config.id == 1 and not isGiftHasBuy

		gohelper.setActive(self._gounget, showUnget)
	end

	if self._gohasget then
		local showHasGet = isGiftHasBuy and isGet

		gohelper.setActive(self._gohasget, showHasGet)
	end

	if self._gocanget then
		local showCanGet = isGiftHasBuy and isCouldGet

		gohelper.setActive(self._gocanget, showCanGet)
	end

	if self._btnClick then
		gohelper.setActive(self._btnClick.gameObject, isCouldGet)
	end

	if self._gonextday then
		local curDay = NationalGiftModel.instance:getCurRewardDay()
		local showNext = isGiftHasBuy and curDay + 1 == self._config.id

		gohelper.setActive(self._gonextday, showNext)
	end
end

function NationalGiftFullBonusItem:destroy()
	if self._rewardItems then
		for _, item in pairs(self._rewardItems) do
			item.btnclick:RemoveClickListener()
		end

		self._rewardItems = nil
	end

	if self._btnClick then
		self._btnClick:RemoveClickListener()
	end
end

return NationalGiftFullBonusItem
