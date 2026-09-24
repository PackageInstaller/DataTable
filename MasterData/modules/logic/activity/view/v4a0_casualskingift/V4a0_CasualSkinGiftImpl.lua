-- chunkname: @modules/logic/activity/view/v4a0_casualskingift/V4a0_CasualSkinGiftImpl.lua

module("modules.logic.activity.view.v4a0_casualskingift.V4a0_CasualSkinGiftImpl", package.seeall)

local V4a0_CasualSkinGiftImpl = class("V4a0_CasualSkinGiftImpl", BaseView)

function V4a0_CasualSkinGiftImpl:ctor()
	V4a0_CasualSkinGiftImpl.super.ctor(self)

	self._itemList = {}
	self._rewardItemList = {}
end

function V4a0_CasualSkinGiftImpl:_getSelectedDay()
	return 1
end

function V4a0_CasualSkinGiftImpl:_sendGet101BonusRequest(cb, cbObj)
	return self.viewContainer:sendGet101BonusRequest(self:_getSelectedDay(), cb, cbObj)
end

function V4a0_CasualSkinGiftImpl:_isType101RewardCouldGet()
	return self.viewContainer:isType101RewardCouldGet(self:_getSelectedDay())
end

function V4a0_CasualSkinGiftImpl:_isType101RewardGet()
	return self.viewContainer:isType101RewardGet(self:_getSelectedDay())
end

function V4a0_CasualSkinGiftImpl:_isDayOpen()
	return self.viewContainer:isDayOpen(self:_getSelectedDay())
end

function V4a0_CasualSkinGiftImpl:_btncheckOnClick()
	return
end

function V4a0_CasualSkinGiftImpl:_btncheck2OnClick()
	return
end

function V4a0_CasualSkinGiftImpl:_btncheck1OnClick()
	return
end

function V4a0_CasualSkinGiftImpl:_btnclaimOnClick()
	local isClaimable = self:_isType101RewardCouldGet()

	if isClaimable then
		self._sendGet101BonusRequest(self, self._onClaimCb, self)

		return
	end
end

function V4a0_CasualSkinGiftImpl:_btnchangeOnClick()
	local jumpId = self.viewContainer:getJumpId()

	if GameFacade.jump(jumpId) then
		-- block empty
	end
end

function V4a0_CasualSkinGiftImpl:_btnbuyOnClick()
	local lua_store_charge_goods_id = self.viewContainer:getSixStarGiftStoreChargeId()

	PayController.instance:startPay(lua_store_charge_goods_id)
end

function V4a0_CasualSkinGiftImpl:_btnGotoOnClick()
	local jumpId = self.viewContainer:getJumpId()

	if GameFacade.jump(jumpId) then
		-- block empty
	end
end

function V4a0_CasualSkinGiftImpl:_onClaimCb()
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")

	self._frameTimer = FrameTimerController.instance:register(function()
		if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.RoomBlockPackageGetView) then
			FrameTimerController.onDestroyViewMember(self, "_frameTimer")
			self:_playAnim_hasget()
		end
	end, nil, 6, 6)

	self._frameTimer:Start()
end

function V4a0_CasualSkinGiftImpl:_playAnim_hasget()
	for _, item in ipairs(self._rewardItemList or {}) do
		item:playAnim_hasget()
	end
end

function V4a0_CasualSkinGiftImpl:_btnCloseOnClick()
	self:closeThis()
end

function V4a0_CasualSkinGiftImpl:_btncloseOnClick()
	self:closeThis()
end

function V4a0_CasualSkinGiftImpl:_onRefreshNorSignActivity()
	self:_refreshRewardList()
end

function V4a0_CasualSkinGiftImpl:_refresh()
	self:_refreshRewardList()
end

function V4a0_CasualSkinGiftImpl:onUpdateParam()
	self:_refresh()
	self:_refreshTimeTick()
end

function V4a0_CasualSkinGiftImpl:onOpen()
	self._txtLimitTime.text = ""

	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)

	if self.viewParam.parent then
		gohelper.addChild(self.viewParam.parent, self.viewGO)
	end

	self:onUpdateParam()
	self:_refreshItemList()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
end

function V4a0_CasualSkinGiftImpl:onClose()
	ActivityController.instance:unregisterCallback(ActivityEvent.RefreshNorSignActivity, self._onRefreshNorSignActivity, self)
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V4a0_CasualSkinGiftImpl:onDestroyView()
	FrameTimerController.onDestroyViewMember(self, "_frameTimer")
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	GameUtil.onDestroyViewMemberList(self, "_rewardItemList")
	GameUtil.onDestroyViewMemberList(self, "_itemList")
end

function V4a0_CasualSkinGiftImpl:_refreshItemList()
	local infos = self.viewContainer:getPreviewSkinInfoList()
	local maxCount = #infos

	for i = 1, maxCount do
		local item = self._itemList[i]

		if not item then
			if isDebugBuild then
				logError("present item count out of range! index:" .. i)
			end

			break
		end

		local mo = infos[i]

		item:onUpdateMO(mo)
		item:setActive(true)
	end

	for i = maxCount + 1, #self._itemList do
		local item = self._itemList[i]

		item:setActive(false)
	end
end

function V4a0_CasualSkinGiftImpl:_refreshRewardList(day)
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

	self:_refreshBtnState()
end

function V4a0_CasualSkinGiftImpl:_refreshBtnState()
	local bClaimable = self:_isType101RewardCouldGet()
	local bClaimed = self:_isType101RewardGet()

	self:_setActive_btnclaim(bClaimable)
	self:_setActive_gohasget(bClaimed)
end

function V4a0_CasualSkinGiftImpl:_refreshTimeTick()
	self._txtLimitTime.text = self.viewContainer:getRemainTimeStr()
end

function V4a0_CasualSkinGiftImpl:_create_V4a0_CasualSkinGiftItem(srcGo, index)
	local item = V4a0_CasualSkinGiftItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a0_CasualSkinGiftImpl:_create_V4a0_CasualSkinGiftRewardItem(srcGo, index)
	local item = V4a0_CasualSkinGiftRewardItem.New({
		parent = self,
		baseViewContainer = self.viewContainer
	})

	item:setIndex(index)
	item:init(srcGo)

	return item
end

function V4a0_CasualSkinGiftImpl:onPresentBtnClick(item)
	local mo = item._mo
	local skinId = mo[1]

	CharacterController.instance:openCharacterNormalSkinView({
		skinId = skinId
	})
end

function V4a0_CasualSkinGiftImpl:onRewardItemClick(item)
	local mo = item._mo

	if not mo then
		return
	end

	local isClaimable = self:_isType101RewardCouldGet()

	if isClaimable then
		self._sendGet101BonusRequest(self, self._onClaimCb, self)

		return
	end

	local itemType = mo[1]
	local itemId = mo[2]

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

function V4a0_CasualSkinGiftImpl:_setActive_gohasget(bActive)
	gohelper.setActive(self._gohasget, bActive)
end

function V4a0_CasualSkinGiftImpl:_setActive_btnclaim(bActive)
	gohelper.setActive(self._btnclaim, bActive)
end

function V4a0_CasualSkinGiftImpl:_editableInitView()
	self:_setActive_gohasget(false)
	self:_setActive_btnclaim(false)
	self:_editableInitView_itemList()
	self:_editableInitView_rewardItemList()
end

function V4a0_CasualSkinGiftImpl:_editableInitView_itemList()
	self._itemList = {}

	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("Root/rolename/role%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a0_CasualSkinGiftItem(go, i)

			table.insert(self._itemList, item)
		end

		i = i + 1
	until isNil
end

function V4a0_CasualSkinGiftImpl:_editableInitView_rewardItemList()
	local i = 1

	repeat
		local go = gohelper.findChild(self.viewGO, string.format("Root/Right/go_reward/#btn_check%s", i))
		local isNil = gohelper.isNil(go)

		if not isNil then
			local item = self:_create_V4a0_CasualSkinGiftRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		elseif i == 1 then
			local go = gohelper.findChild(self.viewGO, string.format("Root/Right/go_reward/#btn_check"))
			local item = self:_create_V4a0_CasualSkinGiftRewardItem(go, i)

			table.insert(self._rewardItemList, item)
		end

		i = i + 1
	until isNil
end

return V4a0_CasualSkinGiftImpl
