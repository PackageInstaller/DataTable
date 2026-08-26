-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseGlobalTaskProgressItem.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseGlobalTaskProgressItem", package.seeall)

local CruiseGlobalTaskProgressItem = class("CruiseGlobalTaskProgressItem", LuaCompBase)
local waitOpenTime = 0.2

function CruiseGlobalTaskProgressItem:init(go, index)
	self.go = go
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._index = index
	self._gospecial = gohelper.findChild(go, "go_special")
	self._goitem = gohelper.findChild(go, "go_item")
	self._gorewarditem = gohelper.findChild(go, "go_item/go_rewarditem")
	self._gounlock = gohelper.findChild(go, "indexbg")
	self._txtindex = gohelper.findChildText(go, "indexbg/txt_index")
	self._golock = gohelper.findChild(go, "indexgray")
	self._txtgrayindex = gohelper.findChildText(go, "indexgray/txt_index")
	self._rewardItem = {}

	self:_initRewardItem()
	gohelper.setActive(self.go, false)

	local delayTime = waitOpenTime + 0.03 * self._index

	TaskDispatcher.runDelay(self._onInFinished, self, delayTime)
	self:addEvents()
end

function CruiseGlobalTaskProgressItem:_onInFinished()
	gohelper.setActive(self.go, true)
	self._anim:Play("open", 0, 0)
end

function CruiseGlobalTaskProgressItem:addEvents()
	return
end

function CruiseGlobalTaskProgressItem:removeEvents()
	return
end

function CruiseGlobalTaskProgressItem:_initRewardItem()
	self._rewardItem.go = self._gorewarditem
	self._rewardItem.imageRare = gohelper.findChildImage(self._rewardItem.go, "bg")
	self._rewardItem.itemRoot = gohelper.findChild(self._rewardItem.go, "goreward")
	self._rewardItem.gohasget = gohelper.findChild(self._rewardItem.go, "go_hasget")
	self._rewardItem.gocanget = gohelper.findChild(self._rewardItem.go, "go_canget")
	self._rewardItem.txtrewardcount = gohelper.findChildText(self._rewardItem.go, "rewardcountbg/txt_rewardcount")
	self._rewardItem.btnclick = gohelper.findChildButtonWithAudio(self._rewardItem.go, "btn_click")
end

function CruiseGlobalTaskProgressItem:refresh(co)
	self._config = co

	gohelper.setActive(self._gospecial, self._config.isSpBonus)
	self:_refreshReward()

	local isUnlock = self:_isRewardCanGet() or self:_isRewardHasGet()

	gohelper.setActive(self._golock, not isUnlock)
	gohelper.setActive(self._gounlock, isUnlock)

	self._txtindex.text = self._config.coinNum
	self._txtgrayindex.text = self._config.coinNum
end

function CruiseGlobalTaskProgressItem:_refreshReward()
	gohelper.setActive(self._rewardItem.go, false)

	local rewards = string.split(self._config.bonus, "|")

	if not rewards or #rewards ~= 1 then
		logError("Please check bonus config and ensure only one bonus!")

		return
	end

	gohelper.setActive(self._rewardItem.go, true)

	local rewardCo = string.splitToNumber(rewards[1], "#")
	local itemCfg, _ = ItemModel.instance:getItemConfigAndIcon(rewardCo[1], rewardCo[2])

	UISpriteSetMgr.instance:setV3a2CruiseSprite(self._rewardItem.imageRare, "goldschedule_rare_" .. itemCfg.rare)

	self._rewardItem.item = self._rewardItem.item or IconMgr.instance:getCommonPropItemIcon(self._rewardItem.itemRoot)

	self._rewardItem.item:setMOValue(rewardCo[1], rewardCo[2], rewardCo[3])
	self._rewardItem.item:isShowQuality(false)
	self._rewardItem.item:isShowEquipAndItemCount(false)
	self._rewardItem.item:setHideLvAndBreakFlag(true)

	local showHasGet = self:_isRewardHasGet()

	gohelper.setActive(self._rewardItem.gohasget, showHasGet)

	local showCanGet = self:_isRewardCanGet()

	gohelper.setActive(self._rewardItem.gocanget, showCanGet)

	self._rewardItem.txtrewardcount.text = rewardCo[3]

	self._rewardItem.btnclick:AddClickListener(self._rewardBtnClick, self)
	gohelper.setActive(self._rewardItem.btnclick.gameObject, showCanGet)
end

function CruiseGlobalTaskProgressItem:_isRewardHasGet()
	local curRewardId = Activity215Model.instance:getAcceptedRewardId()

	return curRewardId >= self._index
end

function CruiseGlobalTaskProgressItem:_isRewardCanGet()
	local curRewardId = Activity215Model.instance:getAcceptedRewardId()
	local maxRewardId = Activity215Model.instance:getMaxCanGetRewardId()

	return curRewardId < self._index and maxRewardId >= self._index
end

function CruiseGlobalTaskProgressItem:_rewardBtnClick()
	local currentMainStage = Activity215Model.instance:getCurrentMainStage()

	if currentMainStage < 1 then
		return
	end

	local isRewardCanGet = self:_isRewardCanGet()

	if not isRewardCanGet then
		return
	end

	Activity215Rpc.instance:sendGetAct215MilestoneBonusRequest(VersionActivity3_2Enum.ActivityId.CruiseGlobalTask)
end

function CruiseGlobalTaskProgressItem:destroy()
	TaskDispatcher.cancelTask(self._onInFinished, self)

	if self._rewardItem then
		self._rewardItem.btnclick:RemoveClickListener()

		self._rewardItem = nil
	end

	self:removeEvents()
end

return CruiseGlobalTaskProgressItem
