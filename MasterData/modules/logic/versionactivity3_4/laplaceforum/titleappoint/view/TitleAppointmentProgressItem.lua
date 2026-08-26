-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/titleappoint/view/TitleAppointmentProgressItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.titleappoint.view.TitleAppointmentProgressItem", package.seeall)

local TitleAppointmentProgressItem = class("TitleAppointmentProgressItem", LuaCompBase)

function TitleAppointmentProgressItem:init(go)
	self.go = go
	self._gospecial = gohelper.findChild(self.go, "go_special")
	self._gosplockbg = gohelper.findChild(self.go, "go_special/go_lockbg")
	self._gospunlockbg = gohelper.findChild(self.go, "go_special/go_unlockbg")
	self._gosplockpoint = gohelper.findChild(self.go, "go_special/go_lockpoint")
	self._gospunlockpoint = gohelper.findChild(self.go, "go_special/go_unlockpoint")
	self._gonormal = gohelper.findChild(self.go, "go_normal")
	self._gonorlockpoint = gohelper.findChild(self.go, "go_normal/go_lockpoint")
	self._gonorunlockpoint = gohelper.findChild(self.go, "go_normal/go_unlockpoint")
	self._txtindex = gohelper.findChildText(self.go, "txt_index")
	self._txtscore = gohelper.findChildText(self.go, "txt_score")
	self._goitem = gohelper.findChild(self.go, "go_item")
	self._gorewarditem = gohelper.findChild(self.go, "go_item/go_rewarditem")
	self._imagebg = gohelper.findChildImage(self.go, "go_item/go_rewarditem/bg")
	self._gorewardicon = gohelper.findChild(self.go, "go_item/go_rewarditem/go_rewardicon")
	self._gohasget = gohelper.findChild(self.go, "go_item/go_rewarditem/go_hasget")
	self._gocanget = gohelper.findChild(self.go, "go_item/go_rewarditem/go_canget")
	self._txtrewardcount = gohelper.findChildText(self.go, "go_item/go_rewarditem/txt_rewardcount")
	self._btnitemClick = gohelper.findChildButtonWithAudio(self.go, "go_item/go_rewarditem/btn_click")
	self._gotag = gohelper.findChild(self.go, "go_tag")
	self._imagetagbg = gohelper.findChildImage(self.go, "go_tag/titlebg")
	self._txttitletag = gohelper.findChildText(self.go, "go_tag/txt_tag")

	self:_addEvents()
end

function TitleAppointmentProgressItem:_addEvents()
	if self._btnitemClick then
		self._btnitemClick:AddClickListener(self._onItemClick, self)
	end
end

function TitleAppointmentProgressItem:_removeEvents()
	if self._btnitemClick then
		self._btnitemClick:RemoveClickListener()
	end
end

function TitleAppointmentProgressItem:_onItemClick()
	local curIndex = TitleAppointmentModel.instance:getCurRewardIndex()
	local isCouldGet = false

	if self._bonusCo.isLoopBonus then
		local itemCount = TitleAppointmentModel.instance:getPopularValueCount()
		local getCount = math.floor((itemCount - self._bonusCo.coinNum) / self._bonusCo.loopBonusIntervalNum)
		local hasCount = TitleAppointmentModel.instance:getLoopRewardCount()

		isCouldGet = hasCount <= getCount
	else
		isCouldGet = curIndex >= self._bonusCo.id
	end

	if not isCouldGet then
		return
	end

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint

	Activity224Rpc.instance:sendReceiveAct224BonusRequest(actId)
end

function TitleAppointmentProgressItem:setGuideBonus(isGuide, bonusId)
	self._isGuideBonus = isGuide
end

function TitleAppointmentProgressItem:refresh(co)
	gohelper.setActive(self.go, true)

	self._bonusCo = co

	gohelper.setActive(self._goitem, true)

	self._item = self._item or IconMgr.instance:getCommonItemIcon(self._gorewardicon)

	local itemCos = string.splitToNumber(self._bonusCo.bonus, "#")

	self._item:setMOValue(itemCos[1], itemCos[2], itemCos[3])
	self._item:isShowQuality(false)
	self._item:isShowCount(false)

	self._txtrewardcount.text = luaLang("multiple") .. itemCos[3]

	local rare = self._item:getRare()

	UISpriteSetMgr.instance:setUiFBSprite(self._imagebg, "bg_pinjidi_" .. rare)

	if self._isGuideBonus then
		self:_refreshGuideRewardItem()

		return
	end

	if self._bonusCo.isLoopBonus then
		self:_refreshLoopRewardItem()

		return
	end

	self:_refreshUnloopRewardItem()
end

function TitleAppointmentProgressItem:_refreshGuideRewardItem()
	local curIndex = TitleAppointmentModel.instance:getCurRewardIndex()
	local showUnlock = curIndex >= self._bonusCo.id
	local colorValue = showUnlock and "#DB7D29" or "#838383"

	self._txtscore.text = string.format("<color=%s>%s</color>", colorValue, self._bonusCo.coinNum)
	self._txtindex.text = string.format("%02d", self._bonusCo.id)

	gohelper.setActive(self._gospunlockbg, showUnlock)
	gohelper.setActive(self._gosplockbg, not showUnlock)
	gohelper.setActive(self._gospunlockpoint, showUnlock)
	gohelper.setActive(self._gosplockpoint, not showUnlock)
	gohelper.setActive(self._gotag, self._bonusCo.titleId > 0)

	if self._bonusCo.titleId > 0 then
		local titleCo = TitleAppointmentConfig.instance:getTitleCo(self._bonusCo.titleId)

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagetagbg, titleCo.titleBackground)

		self._txttitletag.text = titleCo.titleName
	end
end

function TitleAppointmentProgressItem:_refreshUnloopRewardItem()
	local isCouldGet = TitleAppointmentModel.instance:isRewardCouldGet(self._bonusCo.id)
	local isHasGet = TitleAppointmentModel.instance:isRewardHasGet(self._bonusCo.id)

	gohelper.setActive(self._gocanget, isCouldGet)

	if self._btnitemClick then
		gohelper.setActive(self._btnitemClick.gameObject, isCouldGet)
	end

	gohelper.setActive(self._gohasget, isHasGet)

	local curIndex = TitleAppointmentModel.instance:getCurRewardIndex()
	local showUnlock = curIndex >= self._bonusCo.id
	local colorValue = showUnlock and "#DB7D29" or "#838383"

	self._txtscore.text = string.format("<color=%s>%s</color>", colorValue, self._bonusCo.coinNum)
	self._txtindex.text = string.format("%02d", self._bonusCo.id)

	gohelper.setActive(self._gospecial, self._bonusCo.isSpBonus)
	gohelper.setActive(self._gonormal, not self._bonusCo.isSpBonus)

	if self._bonusCo.isSpBonus then
		gohelper.setActive(self._gospunlockbg, showUnlock)
		gohelper.setActive(self._gosplockbg, not showUnlock)
		gohelper.setActive(self._gospunlockpoint, showUnlock)
		gohelper.setActive(self._gosplockpoint, not showUnlock)
	else
		gohelper.setActive(self._gonorunlockpoint, showUnlock)
		gohelper.setActive(self._gonorlockpoint, not showUnlock)
	end

	gohelper.setActive(self._gotag, self._bonusCo.titleId > 0)

	if self._bonusCo.titleId > 0 then
		local titleCo = TitleAppointmentConfig.instance:getTitleCo(self._bonusCo.titleId)

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagetagbg, titleCo.titleBackground)

		self._txttitletag.text = titleCo.titleName
	end
end

function TitleAppointmentProgressItem:_refreshLoopRewardItem()
	local curIndex = TitleAppointmentModel.instance:getCurRewardIndex()
	local itemCount = TitleAppointmentModel.instance:getPopularValueCount()
	local maxCount = tonumber(TitleAppointmentConfig.instance:getConstCO(2).value)
	local getCount = math.floor((itemCount - self._bonusCo.coinNum) / self._bonusCo.loopBonusIntervalNum)
	local hasCount = TitleAppointmentModel.instance:getLoopRewardCount()
	local scoreValue = self._bonusCo.coinNum + hasCount * self._bonusCo.loopBonusIntervalNum
	local isMaxRewardIndex = curIndex >= self._bonusCo.id
	local isTop = maxCount <= hasCount
	local isCouldGet = false

	if isMaxRewardIndex and not isTop then
		isCouldGet = hasCount <= getCount
	end

	gohelper.setActive(self._gotag, false)
	gohelper.setActive(self._gospecial, false)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._gohasget, isTop)
	gohelper.setActive(self._gocanget, isCouldGet)

	if self._btnitemClick then
		gohelper.setActive(self._btnitemClick.gameObject, isCouldGet)
	end

	local showUnlock = isCouldGet or isTop

	if self._bonusCo.isSpBonus then
		gohelper.setActive(self._gospunlockbg, showUnlock)
		gohelper.setActive(self._gosplockbg, not showUnlock)
		gohelper.setActive(self._gospunlockpoint, showUnlock)
		gohelper.setActive(self._gosplockpoint, not showUnlock)
	else
		gohelper.setActive(self._gonorunlockpoint, showUnlock)
		gohelper.setActive(self._gonorlockpoint, not showUnlock)
	end

	local colorValue = showUnlock and "#DB7D29" or "#838383"

	self._txtscore.text = string.format("<color=%s>%s</color>", colorValue, scoreValue)
	self._txtindex.text = "∞"
end

function TitleAppointmentProgressItem:hide()
	gohelper.setActive(self.go, false)
end

function TitleAppointmentProgressItem:destroy()
	self:_removeEvents()
end

return TitleAppointmentProgressItem
