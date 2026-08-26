-- chunkname: @modules/logic/activity/view/goldenmilletpresent/GoldenMilletPresentImpl.lua

module("modules.logic.activity.view.goldenmilletpresent.GoldenMilletPresentImpl", package.seeall)

local GoldenMilletPresentImpl = class("GoldenMilletPresentImpl", BaseView)

function GoldenMilletPresentImpl:ctor()
	GoldenMilletPresentImpl.super.ctor(self)

	self._itemList = {}
	self._rewardItemList = {}
end

function GoldenMilletPresentImpl:_getSelectedDay()
	return 1
end

function GoldenMilletPresentImpl:_sendGet101BonusRequest(cb, cbObj)
	return self.viewContainer:sendGet101BonusRequest(self:_getSelectedDay(), cb, cbObj)
end

function GoldenMilletPresentImpl:_isType101RewardCouldGet()
	return self.viewContainer:isType101RewardCouldGet(self:_getSelectedDay())
end

function GoldenMilletPresentImpl:_isType101RewardGet()
	return self.viewContainer:isType101RewardGet(self:_getSelectedDay())
end

function GoldenMilletPresentImpl:_isDayOpen()
	return self.viewContainer:isDayOpen(self:_getSelectedDay())
end

function GoldenMilletPresentImpl:_btnGotoOnClick()
	local jumpId = self.viewContainer:getJumpId()

	if GameFacade.jump(jumpId) then
		-- block empty
	end
end

function GoldenMilletPresentImpl:_onClaimCb()
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")

	self._frameTimer = FrameTimerController.instance:register(function()
		if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
			FrameTimerController.onDestroyViewMember(self, "_frameTimer")
			self:_playAnim_hasget()
		end
	end, nil, 6, 6)

	self._frameTimer:Start()
end

function GoldenMilletPresentImpl:_onCloseView(viewName)
	if (viewName == ViewName.CommonPropView or viewName == ViewName.RoomBlockPackageGetView) and ViewMgr.instance:isOpen(ViewName.StoreView) then
		self:closeThis()
	end
end

function GoldenMilletPresentImpl:_playAnim_hasget()
	for _, item in ipairs(self._rewardItemList or {}) do
		item:playAnim_hasget()
	end
end

function GoldenMilletPresentImpl:_btnCloseOnClick()
	self:closeThis()
end

function GoldenMilletPresentImpl:_onRefreshNorSignActivity()
	self:_refreshRewardList()
end

function GoldenMilletPresentImpl:_refresh()
	self:_refreshRewardList()
end

function GoldenMilletPresentImpl:onUpdateParam()
	self:_refresh()
	self:_refreshTimeTick()
end

function GoldenMilletPresentImpl:onOpen()
	self._txtremainTime.text = ""

	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	if self.viewParam.parent then
		gohelper.addChild(self.viewParam.parent, self.viewGO)
	end

	self:onUpdateParam()
	self:_refreshItemList()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
end

function GoldenMilletPresentImpl:onClose()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	self:_tryRefreshStoreView()
end

function GoldenMilletPresentImpl:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function GoldenMilletPresentImpl:_refreshItemList()
	local curSelectedDay = self:_getSelectedDay()
	local skinGoodsIdList = self.viewContainer:getSkinGoodsIdList()
	local maxCount = #skinGoodsIdList

	for i = 1, maxCount do
		local item = self._itemList[i]

		if not item then
			if isDebugBuild then
				logError("present item count out of range! index:" .. i)
			end

			break
		end

		local mo = skinGoodsIdList[i]

		item:onUpdateMO(mo)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._itemList do
		local item = self._itemList[i]

		item:setActive(false)
	end
end

function GoldenMilletPresentImpl:_refreshRewardList(day)
	day = day or self:_getSelectedDay()

	local dayBonusList = self.viewContainer:getDayBonusList(day)
	local maxCount = #dayBonusList

	for i = 1, maxCount do
		local item = self._rewardItemList[i]
		local itemCO = dayBonusList[i]

		if not item then
			if isDebugBuild then
				logError("reward item count out of range! index:" .. i)
			end

			break
		end

		item:onUpdateMO(itemCO)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._rewardItemList do
		local item = self._rewardItemList[i]

		item:setActive(false)
	end
end

function GoldenMilletPresentImpl:_refreshTimeTick()
	self._txtremainTime.text = self.viewContainer:getRemainTimeStr()
end

function GoldenMilletPresentImpl:_create_GoldenMilletPresentItem(srcGo, index)
	local item = GoldenMilletPresentItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function GoldenMilletPresentImpl:_create_GoldenMilletPresentRewardItem(srcGo, index)
	local item = GoldenMilletPresentRewardItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function GoldenMilletPresentImpl:onPresentBtnClick(item)
	local mo = item._mo
	local skinId = mo[1]
	local goodsId = mo[2]
	local isOpen = self.viewContainer:isGoldenMilletPresentOpen(true)

	if not isOpen then
		return
	end

	if goodsId and goodsId ~= 0 then
		local goodsMO = StoreModel.instance:getGoodsMO(goodsId)

		if goodsMO then
			ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
				isShowHomeBtn = false,
				goodsMO = goodsMO
			})

			return
		end
	end

	CharacterController.instance:openCharacterSkinTipView({
		isShowHomeBtn = false,
		skinId = skinId
	})
end

function GoldenMilletPresentImpl:onRewardItemClick(item)
	local mo = item._mo

	if not mo then
		return
	end

	local isClaimable = self:_isType101RewardCouldGet()

	if isClaimable then
		self._bRefreshStoreView = true

		self._sendGet101BonusRequest(self, self._onClaimCb, self)

		return
	end

	local itemType = mo[1]
	local itemId = mo[2]

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

function GoldenMilletPresentImpl:_editableInitView()
	self:_editableInitView_itemList()
	self:_editableInitView_rewardItemList()
end

function GoldenMilletPresentImpl:_editableInitView_itemList()
	self._itemList = {}

	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("present%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_GoldenMilletPresentItem(go, i)

			table.insert(self._itemList, item)
		end

		i = i + 1
	until isNil
end

function GoldenMilletPresentImpl:_editableInitView_rewardItemList()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("#scroll_Reward/Viewport/Content/#go_rewarditem%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_GoldenMilletPresentRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		end

		i = i + 1
	until isNil
end

function GoldenMilletPresentImpl:_tryRefreshStoreView()
	if not self._bRefreshStoreView then
		return
	end

	self._bRefreshStoreView = nil

	local kViewName = ViewName.StoreView
	local c = ViewMgr.instance:getContainer(kViewName)

	if not c then
		return
	end

	if not ViewMgr.instance:isOpen(kViewName) then
		return
	end

	c:doFlowFromGoldenMilletPresent()
end

return GoldenMilletPresentImpl
