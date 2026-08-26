-- chunkname: @modules/logic/summon/view/SummonPoolPogressRewardView.lua

module("modules.logic.summon.view.SummonPoolPogressRewardView", package.seeall)

local SummonPoolPogressRewardView = class("SummonPoolPogressRewardView", BaseView)
local RewardState = {
	Canget = 2,
	HasGet = 3,
	Normal = 1
}

function SummonPoolPogressRewardView:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/#btn_close")
	self._simagepanelMask1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/BG/#simage_panelMask1")
	self._simagepanelMask2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/BG/#simage_panelMask2")
	self._simagepanelBG1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/BG/#simage_panelBG1")
	self._simagepanelBG2 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/BG/#simage_panelBG2")
	self._txttotalTimes = gohelper.findChildText(self.viewGO, "#go_ui/current/summonTimes/#txt_totalTimes")
	self._txtcurTimes = gohelper.findChildText(self.viewGO, "#go_ui/current/summonTimes/#txt_curTimes")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "#go_ui/current/progress/#slider_progress")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/current/#btn_confirm")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_ui/current/#btn_confirm/#txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolPogressRewardView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SummonPoolPogressRewardView:removeEvents()
	self._btnconfirm:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function SummonPoolPogressRewardView:_btnconfirmOnClick()
	local param = {
		heroId = self._heroId
	}

	if not HeroModel.instance:getByHeroId(self._heroId) then
		param.showAttributeOption = CharacterEnum.showAttributeOption.ShowMin
	end

	CharacterController.instance:openCharacterExSkillView(param)
end

function SummonPoolPogressRewardView:_btncloseOnClick()
	self:closeThis()
end

function SummonPoolPogressRewardView:_editableInitView()
	self._itemTbList = {}
	self._goitem = gohelper.findChild(self.viewGO, "#go_ui/current/progress/go_item")

	local goprogress = gohelper.findChild(self.viewGO, "#go_ui/current/progress")

	self._progressWidth = recthelper.getWidth(goprogress.transform)

	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._txtTips, false)
end

function SummonPoolPogressRewardView:onUpdateParam()
	self:_updateParamByPoolId(self.viewParam and self.viewParam.poolId)
	self:_refreshUI()
end

function SummonPoolPogressRewardView:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshUI, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonProgressRewards, self._refreshProgressRewards, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshHeroUI, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._startWaritCloseViewEvent, self)
	self:_updateParamByPoolId(self.viewParam and self.viewParam.poolId)
	self:_refreshUI()
end

function SummonPoolPogressRewardView:onClose()
	if self._isHasRunRefreshViewTask then
		self._isHasRunRefreshViewTask = nil

		TaskDispatcher.cancelTask(self._onRunRefreshView, self)
	end
end

function SummonPoolPogressRewardView:onDestroyView()
	for i, itemTb in ipairs(self._itemTbList) do
		itemTb.btnclaim:RemoveClickListener()
	end
end

function SummonPoolPogressRewardView:_updateParamByPoolId(poolId)
	self._poolId = poolId

	local poolMO = SummonMainModel.instance:getPoolServerMO(self._poolId)

	if poolMO then
		self._summonCount = poolMO.summonCount or 0
	end

	self._rewardCount = poolMO and poolMO.customPickMO and poolMO.customPickMO:getRewardCount() or 0
	self._reawrdDataList = self:_createRewardDataListById(self._poolId)

	local rewardData = self._reawrdDataList[#self._reawrdDataList]

	if rewardData then
		self._maxCount = rewardData.count or 0
	end

	if rewardData then
		self._heroId = rewardData.heroId or 0
	end

	self._heroCfg = HeroConfig.instance:getHeroCO(self._heroId)
end

function SummonPoolPogressRewardView:_createRewardDataListById(poolId)
	local poolCfg = SummonConfig.instance:getSummonPool(poolId)
	local dataList = {}

	if poolCfg and not string.nilorempty(poolCfg.progressRewards) then
		local numsList = GameUtil.splitString2(poolCfg.progressRewards, true)

		if numsList and #numsList > 0 then
			for i, nums in ipairs(numsList) do
				local count = nums[1]
				local heroId = nums[2]

				table.insert(dataList, {
					heroId = heroId,
					count = count
				})
			end
		end
	end

	if #dataList > 1 then
		table.sort(dataList, SummonPoolPogressRewardView._rewardDataSort)
	end

	return dataList
end

function SummonPoolPogressRewardView:_refreshProgressRewards()
	self:_updateParamByPoolId(self._poolId)
	self:_refreshUI()
end

function SummonPoolPogressRewardView:_startWaritCloseViewEvent()
	if self._isLockHeroRefresh then
		TaskDispatcher.cancelTask(self._onRunRefreshView, self)
		TaskDispatcher.runDelay(self._onRunRefreshView, self, 0.1)
	end
end

function SummonPoolPogressRewardView:_onRunRefreshView()
	if self._isLockHeroRefresh and ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self._isLockHeroRefresh = nil

		self:_refreshHeroUI()
	end
end

function SummonPoolPogressRewardView._rewardDataSort(a, b)
	if a.count ~= b.count then
		return a.count < b.count
	end
end

function SummonPoolPogressRewardView:_refreshUI()
	self._txttotalTimes.text = tostring(self._summonCount)
	self._txtcurTimes.text = tostring(self._maxCount)

	if self._maxCount > 0 then
		self._sliderprogress:SetValue(self._summonCount / self._maxCount)
	end

	self:_refreshItemUI()
	self:_refreshHeroUI()
end

function SummonPoolPogressRewardView:_refreshHeroUI()
	if self._isLockHeroRefresh then
		return
	end

	local haveCount = self:_getSkillItemCount()

	haveCount = haveCount or 0
	self._isHeroUIIsShow = haveCount > 0

	gohelper.setActive(self._btnconfirm, self._isHeroUIIsShow)
end

function SummonPoolPogressRewardView:_getSkillItemCount()
	local count = 0
	local exCfg = SkillConfig.instance:getherolevelexskillCO(self._heroId, 1)

	if exCfg and not string.nilorempty(exCfg.consume) then
		local itemco = string.splitToNumber(exCfg.consume, "#")

		if itemco then
			count = ItemModel.instance:getItemQuantity(itemco[1], itemco[2])
		end
	end

	return count
end

function SummonPoolPogressRewardView:_refreshItemUI()
	for i, data in ipairs(self._reawrdDataList) do
		local itemTb = self._itemTbList[i]

		if itemTb == nil then
			itemTb = self:_createItemTB(gohelper.cloneInPlace(self._goitem))

			table.insert(self._itemTbList, itemTb)
		end

		if self._maxCount > 0 then
			local anchorX = data.count * self._progressWidth / self._maxCount

			recthelper.setAnchorX(itemTb.goTrs, anchorX)
		end

		local state = self:_getRewardState(i, data.count)

		if itemTb.rewardState ~= state then
			itemTb.rewardState = state

			gohelper.setActive(itemTb.gonormal, state == RewardState.Normal)
			gohelper.setActive(itemTb.gocanget, state == RewardState.Canget)
			gohelper.setActive(itemTb.gohasget, state == RewardState.HasGet)
		end

		itemTb.txtcount.text = tostring(data.count)
	end

	for i, itemTb in ipairs(self._itemTbList) do
		gohelper.setActive(itemTb.go, i <= #self._reawrdDataList)
	end
end

function SummonPoolPogressRewardView:_getRewardState(index, count)
	if index <= self._rewardCount then
		return RewardState.HasGet
	end

	if count <= self._summonCount then
		return RewardState.Canget
	end

	return RewardState.Normal
end

function SummonPoolPogressRewardView:_createItemTB(go)
	local tb = self:getUserDataTb_()

	tb.go = go
	tb.goTrs = go.transform
	tb.gonormal = gohelper.findChild(go, "normal")
	tb.gocanget = gohelper.findChild(go, "canget")
	tb.gohasget = gohelper.findChild(go, "hasget")
	tb.btnclaim = gohelper.findChildButtonWithAudio(go, "canget/btn_claim")
	tb.txtcount = gohelper.findChildText(go, "txt_count")

	tb.btnclaim:AddClickListener(self._itemBtnclaimOnClick, self)

	return tb
end

function SummonPoolPogressRewardView:_itemBtnclaimOnClick()
	self._nextRewardsRequestTime = self._nextRewardsRequestTime or 0

	if self._poolId and self._nextRewardsRequestTime <= Time.time then
		self._nextRewardsRequestTime = Time.time + 0.3

		SummonRpc.instance:sendGetSummonProgressRewardsRequest(self._poolId)

		if not self._isLockHeroRefresh and self:_getSkillItemCount() <= 0 then
			self._isLockHeroRefresh = true
		end
	end
end

return SummonPoolPogressRewardView
