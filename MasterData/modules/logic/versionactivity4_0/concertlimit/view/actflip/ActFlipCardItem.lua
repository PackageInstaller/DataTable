-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/actflip/ActFlipCardItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.actflip.ActFlipCardItem", package.seeall)

local ActFlipCardItem = class("ActFlipCardItem", LuaCompBase)

function ActFlipCardItem:init(go)
	self.go = go
	self._gosmall = gohelper.findChild(self.go, "go_small")
	self._gosmalloptional = gohelper.findChild(self._gosmall, "go_optional")
	self._imagesmallrare = gohelper.findChildImage(self._gosmalloptional, "image_rare")
	self._gosmallitem = gohelper.findChild(self._gosmalloptional, "go_item")
	self._txtitemnum = gohelper.findChildText(self._gosmalloptional, "itemnumbg/txt_itemnum")
	self._btnsmallget = gohelper.findChildButtonWithAudio(self._gosmall, "btn_get")
	self._gosmallcanget = gohelper.findChild(self._gosmall, "go_canget")
	self._gosmallget1 = gohelper.findChild(self._gosmall, "go_get1")
	self._gosmallget2 = gohelper.findChild(self._gosmall, "go_get2")
	self._gosmallget3 = gohelper.findChild(self._gosmall, "go_get3")
	self._gosmallclick = gohelper.findChild(self._gosmall, "go_click")
	self._gobig = gohelper.findChild(self.go, "go_big")
	self._gobigoptional = gohelper.findChild(self._gobig, "go_optional")
	self._imagebigrare = gohelper.findChildImage(self._gobigoptional, "image_rare")
	self._gobigitem = gohelper.findChild(self._gobigoptional, "go_item")
	self._txtbigitemnum = gohelper.findChildText(self._gobigoptional, "itemnumbg/txt_itemnum")
	self._btnbigget = gohelper.findChildButtonWithAudio(self._gobig, "btn_get")
	self._gobigcanget = gohelper.findChild(self._gobig, "go_canget")
	self._gobigget1 = gohelper.findChild(self._gobig, "go_get1")
	self._gobigget2 = gohelper.findChild(self._gobig, "go_get2")
	self._gobigget3 = gohelper.findChild(self._gobig, "go_get3")
	self._gobigclick = gohelper.findChild(self._gobig, "go_click")

	self:_initItem()
	self:_addEvents()
end

function ActFlipCardItem:_initItem()
	self._smallAnim = self._gosmall:GetComponent(typeof(UnityEngine.Animator))
	self._bigAnim = self._gobig:GetComponent(typeof(UnityEngine.Animator))
	self._bigClickAnim = self._gobigclick:GetComponent(typeof(UnityEngine.Animation))

	gohelper.setActive(self._gosmall, false)
	gohelper.setActive(self._gobig, false)

	local curCardIndex = ActFlipModel.instance:getCurCardIndex()

	self._hasAllGet = ActFlipModel.instance:isCardRewardAllGet(curCardIndex)
end

function ActFlipCardItem:_addEvents()
	ActFlipController.instance:registerCallback(ActFlipEvent.RewardBonusGet, self._onBonusGetDone, self)
	ActFlipController.instance:registerCallback(ActFlipEvent.ShowOtherBlockGetBigRewardGet, self._showOtherBlockGetBigRewardGet, self)
	self._btnsmallget:AddClickListener(self._onItemClick, self)
	self._btnbigget:AddClickListener(self._onItemClick, self)
end

function ActFlipCardItem:_removeEvents()
	ActFlipController.instance:unregisterCallback(ActFlipEvent.RewardBonusGet, self._onBonusGetDone, self)
	ActFlipController.instance:unregisterCallback(ActFlipEvent.ShowOtherBlockGetBigRewardGet, self._showOtherBlockGetBigRewardGet, self)
	self._btnsmallget:RemoveClickListener()
	self._btnbigget:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function ActFlipCardItem:_showOtherBlockGetBigRewardGet(itemIndex)
	if self._itemIndex ~= itemIndex then
		return
	end

	gohelper.setActive(self._gobig, true)
	gohelper.setActive(self._gosmall, false)
	self:_refreshBig()

	self._bigClickAnim.enabled = false

	self._bigAnim:Play("get_big", 0, 0.2)
end

function ActFlipCardItem:_onBonusGetDone()
	local itemIndex = ActFlipModel.instance:getCurBlockIndex()

	if self._itemIndex ~= itemIndex then
		return
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("showCardGet")

	local isBigRewardBlock, targetItemIndex = ActFlipModel.instance:isBigRewardBlock(self._cardId, self._itemIndex)

	if isBigRewardBlock then
		AudioMgr.instance:trigger(AudioEnum4_0.ConcertLimit.play_ui_yingmeng4_0huoyue_reward)

		if targetItemIndex ~= self._itemIndex then
			gohelper.setActive(self._gobig, false)
			gohelper.setActive(self._gosmall, true)
			self._smallAnim:Play("get_big", 0, 0)
			TaskDispatcher.runDelay(self._showBigRewardAnim, self, 0.5)
		else
			self:_refreshBig()
			self._bigAnim:Play("get_big", 0, 0)
			gohelper.setActive(self._gobig, true)
			gohelper.setActive(self._gosmall, false)
		end

		TaskDispatcher.runDelay(self._onWaitShowAutoChangeCard, self, 1.8)
	else
		self:_refreshSmall()
		AudioMgr.instance:trigger(AudioEnum4_0.ConcertLimit.play_ui_shengyan_yishi_rewards)
		self._smallAnim:Play("get_small" .. self._cardId, 0, 0)
		TaskDispatcher.runDelay(self._showGetFinished, self, 1.5)
	end
end

function ActFlipCardItem:_showBigRewardAnim()
	gohelper.setActive(self._gobig, false)
	gohelper.setActive(self._gosmall, false)

	local _, targetItemIndex = ActFlipModel.instance:isBigRewardBlock(self._cardId, self._itemIndex)
	local itemIndex = targetItemIndex or self._itemIndex

	ActFlipController.instance:dispatchEvent(ActFlipEvent.ShowOtherBlockGetBigRewardGet, itemIndex)
end

function ActFlipCardItem:_onWaitShowAutoChangeCard()
	if self._cardId == 1 then
		self._cardChanged = true
	end

	self:_showGetFinished()
end

function ActFlipCardItem:_showGetFinished()
	UIBlockMgr.instance:endBlock("showCardGet")
	ActFlipController.instance:dispatchEvent(ActFlipEvent.RewardBonusGetShowFinished)

	local curCardIndex = self._cardChanged and 1 or self._cardId
	local blockInfo = ActFlipModel.instance:getBlockInfo(curCardIndex, self._itemIndex)
	local isBigRewardBlock, targetItemIndex = ActFlipModel.instance:isBigRewardBlock(curCardIndex, self._itemIndex)

	blockInfo = isBigRewardBlock and targetItemIndex and ActFlipModel.instance:getBlockInfo(curCardIndex, targetItemIndex) or ActFlipModel.instance:getBlockInfo(curCardIndex, self._itemIndex)

	if not blockInfo then
		return
	end

	local rewardCo = ActFlipConfig.instance:getRewardCo(blockInfo.rewardId)
	local params = string.splitToNumber(rewardCo.reward, "#")
	local mo = MaterialDataMO.New()

	mo:initValue(params[1], params[2], params[3])

	local materialDataMOList = {
		mo
	}

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, materialDataMOList)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)
end

function ActFlipCardItem:_onCloseView(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	local curCardIndex = ActFlipModel.instance:getCurCardIndex()
	local hasAllGet = ActFlipModel.instance:isCardRewardAllGet(curCardIndex)

	if curCardIndex == 1 and hasAllGet and not self._hasAllGet then
		ActFlipController.instance:dispatchEvent(ActFlipEvent.ShowAutoChangeCard)
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseView, self)

	if not self._cardChanged then
		return
	end

	self._cardChanged = false

	ActFlipController.instance:dispatchEvent(ActFlipEvent.ShowAutoChangeCard)
end

function ActFlipCardItem:_onItemClick()
	local isBigRewardBlock = ActFlipModel.instance:isBigRewardBlock(self._cardId, self._itemIndex)

	if isBigRewardBlock then
		return
	end

	local couldGet = ActFlipModel.instance:isBlockRewardCouldGet(self._cardId, self._itemIndex)

	if not couldGet then
		local blockInfo = ActFlipModel.instance:getBlockInfo(self._cardId, self._itemIndex)

		if not blockInfo then
			return
		end

		local rewardCo = ActFlipConfig.instance:getRewardCo(blockInfo.rewardId)
		local params = string.splitToNumber(rewardCo.reward, "#")

		MaterialTipController.instance:showMaterialInfo(params[1], params[2])

		return
	end

	local curCardIndex = ActFlipModel.instance:getCurCardIndex()
	local couldGetCount = ActFlipModel.instance:couldGetCardCount(curCardIndex)

	if couldGetCount <= 0 then
		GameFacade.showToast(ToastEnum.ActFlipCardNotEnoughItem)

		return
	end

	ActFlipModel.instance:setCurBlockIndex(self._itemIndex)

	local actId = VersionActivity4_0Enum.ActivityId.ConcertActFlip

	Activity246Rpc.instance:sendAct246ScratchRequest(actId, self._cardId, self._itemIndex)
end

function ActFlipCardItem:refresh(itemIndex, cardId)
	gohelper.setActive(self.go, true)

	self._itemIndex = itemIndex
	self._cardId = cardId

	self:_refreshItem()
end

function ActFlipCardItem:_isItemBig(itemIndex)
	itemIndex = itemIndex or self._itemIndex

	local blockInfo = ActFlipModel.instance:getBlockInfo(self._cardId, itemIndex)

	if not blockInfo then
		return false
	end

	return (ActFlipModel.instance:isBigReward(blockInfo.rewardId))
end

function ActFlipCardItem:_refreshItem()
	self._isBig = self:_isItemBig()

	if self._isBig then
		self:_refreshBig()
	else
		self:_refreshSmall()
	end
end

function ActFlipCardItem:_refreshSmall()
	local blockInfo = ActFlipModel.instance:getBlockInfo(self._cardId, self._itemIndex)

	if blockInfo then
		gohelper.setActive(self._gosmall, true)
		gohelper.setActive(self._gobig, false)

		local rewardCo = ActFlipConfig.instance:getRewardCo(blockInfo.rewardId)
		local itemCos = string.splitToNumber(rewardCo.reward, "#")

		self._item = self._item or IconMgr.instance:getCommonItemIcon(self._gosmallitem)

		self._item:setMOValue(itemCos[1], itemCos[2], itemCos[3])
		self._item:isShowQuality(false)
		self._item:isShowCount(false)

		self._txtitemnum.text = itemCos[3]

		self._smallAnim:Play("optional", 0, 0)

		local config = ItemModel.instance:getItemConfig(itemCos[1], itemCos[2])

		if not config.rare then
			UISpriteSetMgr.instance:setV4a0ConcertSprite(self._imagesmallrare, "v4a0_observerbox_item_quality_" .. tostring(config.rare))
		end
	else
		local isBigRewardBlock = ActFlipModel.instance:isBigRewardBlock(self._cardId, self._itemIndex)

		if isBigRewardBlock then
			gohelper.setActive(self._gosmall, false)
			gohelper.setActive(self._gobig, false)
		else
			gohelper.setActive(self._gosmall, true)
			gohelper.setActive(self._gobig, false)

			local couldGetCount = ActFlipModel.instance:couldGetCardCount(self._cardId)
			local animName = couldGetCount > 0 and "canget" or "notget"

			self._smallAnim:Play(animName, 0, 0)
		end
	end
end

function ActFlipCardItem:_refreshBig()
	local blockInfo = ActFlipModel.instance:getBlockInfo(self._cardId, self._itemIndex)

	if not blockInfo then
		return
	end

	local rewardCo = ActFlipConfig.instance:getRewardCo(blockInfo.rewardId)

	gohelper.setActive(self._gobig, true)
	gohelper.setActive(self._btnbigget.gameObject, false)
	self._bigAnim:Play("optional", 0, 0)
	gohelper.setActive(self._gosmall, false)

	self._bigItem = self._bigItem or IconMgr.instance:getCommonItemIcon(self._gobigitem)

	local itemCos = string.splitToNumber(rewardCo.reward, "#")
	local config = ItemModel.instance:getItemConfig(itemCos[1], itemCos[2])

	if not config.rare then
		UISpriteSetMgr.instance:setV4a0ConcertSprite(self._imagebigrare, "v4a0_observerbox_bigitem_quality_" .. tostring(config.rare))

		local itemCos = string.splitToNumber(rewardCo.reward, "#")

		self._bigItem:setMOValue(itemCos[1], itemCos[2], itemCos[3])
		self._bigItem:isShowQuality(false)
		self._bigItem:isShowCount(false)

		if not LuaUtil.isEmptyStr(rewardCo.rewardicon) then
			local resPath = ResUrl.getPropItemIcon(rewardCo.rewardicon)

			self._bigItem:setSpecificIcon(resPath)
		end

		self._txtbigitemnum.text = itemCos[3]
	end
end

function ActFlipCardItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function ActFlipCardItem:destroy()
	UIBlockMgr.instance:endBlock("showCardGet")
	TaskDispatcher.cancelTask(self._showGetFinished, self)
	self:_removeEvents()
end

return ActFlipCardItem
