-- chunkname: @modules/logic/activity/view/V2a8_DragonBoat_RewardItem.lua

module("modules.logic.activity.view.V2a8_DragonBoat_RewardItem", package.seeall)

local V2a8_DragonBoat_RewardItem = class("V2a8_DragonBoat_RewardItem", Activity101SignViewItemBase)

function V2a8_DragonBoat_RewardItem:onInitView()
	self._simageitembg = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_itembg")
	self._txttitle = gohelper.findChildText(self.viewGO, "Root/#txt_title")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/unlock/#scroll_ItemList")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/lock/#txt_LimitTime")
	self._goreward1 = gohelper.findChild(self.viewGO, "Root/#go_reward1")
	self._goreward2 = gohelper.findChild(self.viewGO, "Root/#go_reward2")
	self._goepisode = gohelper.findChild(self.viewGO, "#go_episode")
	self._txtepisode = gohelper.findChildText(self.viewGO, "#go_episode/#txt_episode")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a8_DragonBoat_RewardItem:addEvents()
	return
end

function V2a8_DragonBoat_RewardItem:removeEvents()
	return
end

local splitToNumber = string.splitToNumber
local split = string.split
local csAnimatorPlayer = SLFramework.AnimatorPlayer

function V2a8_DragonBoat_RewardItem:_editableInitView()
	self._unlockGo = gohelper.findChild(self.viewGO, "Root/unlock")
	self._lockGo = gohelper.findChild(self.viewGO, "Root/lock")
	self._txt_unlockTips = gohelper.findChildText(self.viewGO, "Root/lock/txt_unlockTips")
	self._txt_unlockTipsGo = self._txt_unlockTips.gameObject
	self._txtLimitTimeGo = self._txtLimitTime.gameObject
	self._unlock_scrollItemListGo = gohelper.findChild(self.viewGO, "Root/unlock/#scroll_ItemList")
	self._contentGo = gohelper.findChild(self._unlock_scrollItemListGo, "Viewport/Content")
	self._txtdec = gohelper.findChildText(self.viewGO, "Root/unlock/#scroll_ItemList/Viewport/Content")
	self._animPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._anim = self._animPlayer.animator
	self._itemList = {}

	for i = 1, 5 do
		local go = self["_goreward" .. i]

		if not go then
			break
		end

		self._itemList[i] = self:_create_V2a8_DragonBoat_RewardItemItem(i, go)
	end

	self:_setActive_lockGo(false)
	self:_setActive_unlockGo(false)
end

function V2a8_DragonBoat_RewardItem:onRefresh()
	if not self.__isSetScrollparentGameObject then
		self:setScrollparentGameObject(self._unlock_scrollItemListGo)

		self.__isSetScrollparentGameObject = true
	end

	local actId = self:actId()
	local index = self._index
	local dayCO = self:_getDayCO()
	local rewardGet = self:_isHasGet()
	local couldGet = self:_isCanGet()
	local totalday = ActivityType101Model.instance:getType101LoginCount(actId)
	local isShowDesc = rewardGet or couldGet
	local isShowUnlockDayTips = totalday < index

	self:_onRefresh_rewardList(rewardGet, couldGet)

	if dayCO then
		self._txttitle.text = dayCO.titile or ""
	end

	if dayCO then
		self._txtdec.text = dayCO.desc or ""
	end

	self._txtLimitTime.text = formatLuaLang("V2a8_DragonBoat_RewardItem_txt_unlockTips", index - totalday)

	gohelper.setActive(self._txt_unlockTipsGo, not isShowUnlockDayTips)
	gohelper.setActive(self._txtLimitTimeGo, isShowUnlockDayTips)
	self:_setActive_lockGo(not isShowDesc)
	self:_setActive_unlockGo(isShowDesc)
end

function V2a8_DragonBoat_RewardItem:actId()
	return self._mo.data[1]
end

function V2a8_DragonBoat_RewardItem:_onRefresh_rewardList(rewardGet, couldGet)
	local actId = self:actId()
	local index = self._index
	local co = ActivityConfig.instance:getNorSignActivityCo(actId, index)
	local rewards = split(co.bonus, "|") or {}

	for i, rewardStr in ipairs(rewards) do
		local itemCo = splitToNumber(rewardStr, "#")
		local item = self._itemList[i]

		if not item then
			item = self:_create_V2a8_DragonBoat_RewardItemItem(i)

			table.insert(self._itemList, item)
		end

		item:setActive(true)
		item:onUpdateMO(itemCo)
		item:setActive_hasgetGo(rewardGet)
		item:setActive_cangetGo(couldGet)
	end

	for i = #rewards + 1, #self._itemList do
		local item = self._itemList[i]

		item:setActive(false)
	end
end

function V2a8_DragonBoat_RewardItem:_isCanGet()
	local actId = self:actId()
	local index = self._index
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, index)

	if not couldGet then
		return false
	end

	local c = self:viewContainer()

	return c:isStateDone(index)
end

function V2a8_DragonBoat_RewardItem:_getDayCO()
	local c = self:viewContainer()

	return c:getDayCO(self._index)
end

function V2a8_DragonBoat_RewardItem:_isHasGet()
	local actId = self:actId()
	local index = self._index

	return ActivityType101Model.instance:isType101RewardGet(actId, index)
end

function V2a8_DragonBoat_RewardItem:onItemClick()
	local actId = self:actId()
	local index = self._index

	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if not ActivityModel.instance:isActOnLine(actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return true
	end

	local couldGet = self:_isCanGet()

	if couldGet then
		local viewContainer = self:viewContainer()

		viewContainer:setOnceGotRewardFetch101Infos(true)
		Activity101Rpc.instance:sendGet101BonusRequest(actId, index)

		return true
	end

	return false
end

function V2a8_DragonBoat_RewardItem:_create_V2a8_DragonBoat_RewardItemItem(index, go)
	go = go or gohelper.cloneInPlace(self._goreward1)

	local item = V2a8_DragonBoat_RewardItemItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(go)

	return item
end

function V2a8_DragonBoat_RewardItem:_setActive_lockGo(isActive)
	gohelper.setActive(self._lockGo, isActive)
end

function V2a8_DragonBoat_RewardItem:_setActive_unlockGo(isActive)
	gohelper.setActive(self._unlockGo, isActive)
end

function V2a8_DragonBoat_RewardItem:_playAnim(name, cb, cbObj)
	self._anim.enabled = true

	self._animPlayer:Play(name, cb or function()
		return
	end, cbObj)
end

function V2a8_DragonBoat_RewardItem:playAnim_unlock(cb, cbObj)
	self:_setActive_unlockGo(true)
	self:_setActive_lockGo(false)
	self:_playAnim(UIAnimationName.Unlock, function()
		if cb then
			cb(cbObj)
		end

		self:_onRefresh_rewardList(false, true)
	end)
end

return V2a8_DragonBoat_RewardItem
