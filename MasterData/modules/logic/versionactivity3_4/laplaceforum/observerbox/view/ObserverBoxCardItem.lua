-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/view/ObserverBoxCardItem.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.view.ObserverBoxCardItem", package.seeall)

local ObserverBoxCardItem = class("ObserverBoxCardItem", LuaCompBase)

function ObserverBoxCardItem:init(go)
	self.go = go
	self._gooptional = gohelper.findChild(self.go, "go_optional")
	self._imagerare = gohelper.findChildImage(self.go, "go_optional/image_rare")
	self._goitem = gohelper.findChild(self.go, "go_optional/go_item")
	self._txtitemnum = gohelper.findChildText(self.go, "go_optional/itemnumbg/txt_itemnum")
	self._gonotget = gohelper.findChild(self.go, "go_notget")
	self._notgetAnim = self._gonotget:GetComponent(typeof(UnityEngine.Animator))
	self._gocanget = gohelper.findChild(self.go, "go_canget")
	self._goget = gohelper.findChild(self.go, "go_get")
	self._btnitemClick = gohelper.getClick(self._gonotget)

	self:_addEvents()
end

function ObserverBoxCardItem:_addEvents()
	ObserverBoxController.instance:registerCallback(ObserverBoxEvent.RewardBonusGet, self._onBonusGetDone, self)
	self._btnitemClick:AddClickListener(self._onItemClick, self)
end

function ObserverBoxCardItem:_removeEvents()
	ObserverBoxController.instance:unregisterCallback(ObserverBoxEvent.RewardBonusGet, self._onBonusGetDone, self)
	self._btnitemClick:RemoveClickListener()
end

function ObserverBoxCardItem:_onBonusGetDone(pos)
	if self._cardIndex ~= pos then
		self:refresh(self._cardIndex, self._pageId)

		return
	end

	gohelper.setActive(self._gocanget, false)
	gohelper.setActive(self._gonotget, false)
	gohelper.setActive(self._goget, true)

	local bonusId = ObserverBoxModel.instance:getCardBonusId(self._pageId, self._cardIndex)
	local itemCos = string.splitToNumber(ObserverBoxConfig.instance:getBoxListPageCo(bonusId, self._pageId).bonus, "#")

	self._item = self._item or IconMgr.instance:getCommonItemIcon(self._goitem)

	self._item:setMOValue(itemCos[1], itemCos[2], itemCos[3])
	self._item:isShowQuality(false)
	self._item:isShowCount(false)

	self._txtitemnum.text = itemCos[3]

	local rare = self._item:getRare()

	UISpriteSetMgr.instance:setUiFBSprite(self._imagerare, "bg_pinjidi_" .. rare)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_trap_dispel)
	TaskDispatcher.runDelay(self._ongetfinished, self, 0.84)
end

function ObserverBoxCardItem:_ongetfinished()
	UIBlockMgr.instance:endBlock("getBonus")
	gohelper.setActive(self._gonotget, false)
	gohelper.setActive(self._goget, false)

	local bonusId = ObserverBoxModel.instance:getCardBonusId(self._pageId, self._cardIndex)
	local itemCos = string.splitToNumber(ObserverBoxConfig.instance:getBoxListPageCo(bonusId, self._pageId).bonus, "#")
	local dataList = {}
	local materialData = MaterialDataMO.New()

	materialData:initValue(itemCos[1], itemCos[2], itemCos[3])
	table.insert(dataList, materialData)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, dataList)
	ObserverBoxController.instance:dispatchEvent(ObserverBoxEvent.RewardBonusGetFinished)
end

function ObserverBoxCardItem:_onItemClick()
	local bonusId = ObserverBoxModel.instance:getCardBonusId(self._pageId, self._cardIndex)
	local rewardGet = bonusId > 0

	if rewardGet then
		return
	end

	local couldGet = ObserverBoxModel.instance:isCardRewardCouldGet(self._pageId, self._cardIndex)

	if not couldGet then
		GameFacade.showToast(ToastEnum.ObserverBoxLock)

		return
	end

	local actId = VersionActivity3_4Enum.ActivityId.LaplaceObserverBox

	UIBlockMgr.instance:startBlock("getBonus")
	Activity226Rpc.instance:sendReceiveAct226BonusRequest(actId, self._cardIndex)
end

function ObserverBoxCardItem:refresh(rewardId, pageId)
	gohelper.setActive(self.go, true)

	self._cardIndex = rewardId
	self._pageId = pageId

	local bonusId = ObserverBoxModel.instance:getCardBonusId(self._pageId, self._cardIndex)
	local rewardGet = bonusId > 0
	local couldGet = ObserverBoxModel.instance:isCardRewardCouldGet(self._pageId, self._cardIndex)

	gohelper.setActive(self._gonotget, not rewardGet)
	gohelper.setActive(self._gocanget, couldGet and not rewardGet)
	gohelper.setActive(self._goget, false)

	if rewardGet then
		local itemCos = string.splitToNumber(ObserverBoxConfig.instance:getBoxListPageCo(bonusId, self._pageId).bonus, "#")

		self._item = self._item or IconMgr.instance:getCommonItemIcon(self._goitem)

		self._item:setMOValue(itemCos[1], itemCos[2], itemCos[3])
		self._item:isShowQuality(false)
		self._item:isShowCount(false)

		self._txtitemnum.text = itemCos[3]

		local rare = self._item:getRare()

		UISpriteSetMgr.instance:setUiFBSprite(self._imagerare, "bg_pinjidi_" .. rare)
	end
end

function ObserverBoxCardItem:hide()
	gohelper.setActive(self.go, false)
end

function ObserverBoxCardItem:destroy()
	UIBlockMgr.instance:endBlock("getBonus")
	self:_removeEvents()
end

return ObserverBoxCardItem
