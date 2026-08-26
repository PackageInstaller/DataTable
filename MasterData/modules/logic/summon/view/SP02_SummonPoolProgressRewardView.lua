-- chunkname: @modules/logic/summon/view/SP02_SummonPoolProgressRewardView.lua

module("modules.logic.summon.view.SP02_SummonPoolProgressRewardView", package.seeall)

local SP02_SummonPoolProgressRewardView = class("SP02_SummonPoolProgressRewardView", BaseView)

function SP02_SummonPoolProgressRewardView:onInitView()
	self._btnfullclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_fullclosebtn")
	self._btnsmallclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_smallclose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SP02_SummonPoolProgressRewardView:addEvents()
	self._btnfullclosebtn:AddClickListener(self._btnfullclosebtnOnClick, self)
	self._btnsmallclose:AddClickListener(self._btnsmallcloseOnClick, self)
	self._btnReward:AddClickListener(self._btnRewardOnClick, self)
	self._btnRole:AddClickListener(self._btnRoleOnClick, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self.onGetReward, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self._onGetRewardHistory, self)
end

function SP02_SummonPoolProgressRewardView:removeEvents()
	self._btnfullclosebtn:RemoveClickListener()
	self._btnsmallclose:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnRole:RemoveClickListener()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self.onGetReward, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self._onGetRewardHistory, self)
end

function SP02_SummonPoolProgressRewardView:_btnfullclosebtnOnClick()
	self:closeThis()
end

function SP02_SummonPoolProgressRewardView:_btnsmallcloseOnClick()
	self:closeThis()
end

local heroId = 3149
local itemId = 823852

function SP02_SummonPoolProgressRewardView:_btnRewardOnClick()
	GiftController.instance:GiftMultipleInspirationHeroPreviewView({
		itemId = itemId
	})
end

function SP02_SummonPoolProgressRewardView:_btnRoleOnClick()
	AudioMgr.instance:trigger(AudioEnum3_10.SummonProgress.play_ui_langchao_role_open)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = heroId
	})
end

function SP02_SummonPoolProgressRewardView:_editableInitView()
	self._gotaskitem = gohelper.findChild(self.viewGO, "root/reward_list/#go_rewarditem")

	gohelper.setActive(self._gotaskitem, false)

	self._taskItemList = self:getUserDataTb_()
	self._btnReward = gohelper.findChildButton(self.viewGO, "root/left/#btn_icon")
	self._btnRole = gohelper.findChildButton(self.viewGO, "root/left/#btn_role")
	self._imageProgress = gohelper.findChildImage(self.viewGO, "root/img_gray/#go_fill")
	self._txttips = gohelper.findChildTextMesh(self.viewGO, "root/#txt_tips")
end

function SP02_SummonPoolProgressRewardView:onUpdateParam()
	return
end

function SP02_SummonPoolProgressRewardView:onOpen()
	self:checkParam()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum3_10.SummonProgress.play_ui_langchao_popup_reward)
end

function SP02_SummonPoolProgressRewardView:checkParam()
	if not self.viewParam or not self.viewParam.poolId then
		return
	end

	self._poolId = self.viewParam.poolId

	local poolMO = SummonMainModel.instance:getPoolServerMO(self._poolId)

	if poolMO then
		self._summonCount = poolMO.summonCount or 0
	end

	self._rewardCount = poolMO and poolMO.customPickMO and poolMO.customPickMO:getOptionalRewardCount() or 0
	self._rewardDataList = SummonConfig.instance:getOptionalProgressRewardByPoolId(self._poolId)

	local totalRewardCount = #self._rewardDataList
	local nextRewardIndex = totalRewardCount

	for i = totalRewardCount, 1, -1 do
		local rewardParam = self._rewardDataList[i]
		local rewardCount = rewardParam[1]

		if rewardCount >= self._summonCount then
			nextRewardIndex = i
		end
	end

	self._nextRewardIndex = nextRewardIndex
	self._maxProgressCount = self._rewardDataList[totalRewardCount][1]
	self._maxRewardCount = totalRewardCount
end

function SP02_SummonPoolProgressRewardView:refreshUI()
	self:refreshReward()
	self:refreshRewardState()
end

local default_fill_value = 0.1

function SP02_SummonPoolProgressRewardView:refreshProgress()
	local summonCount = self._summonCount
	local maxRewardCount = 0
	local canRewardCount = 0
	local nextRwardCount, curRewardItemList
	local numsList = self._rewardDataList

	if numsList and next(numsList) then
		local default_fill_max = numsList[1][1]

		self._imageProgress.fillAmount = summonCount <= default_fill_max and summonCount / default_fill_max * default_fill_value or (summonCount - default_fill_max) / (self._maxProgressCount - default_fill_max) * (1 - default_fill_value) + default_fill_value
		maxRewardCount = #numsList

		for i, nums in ipairs(numsList) do
			local count = nums[1]
			local rewardParamList = nums[2]

			if count <= summonCount then
				canRewardCount = canRewardCount + 1
			elseif not nextRwardCount or count < nextRwardCount then
				nextRwardCount = count
				curRewardItemList = rewardParamList
			end
		end
	end

	self._txttips.text = canRewardCount > self._rewardCount and luaLang("sp02_summon_progress_rewards_can_get_tip") or nextRwardCount and summonCount < nextRwardCount and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_summon_progress_rewards_tip"), nextRwardCount - summonCount) or luaLang("sp02_summon_progress_rewards_full_tip")
end

function SP02_SummonPoolProgressRewardView:refreshReward()
	gohelper.CreateObjList(self, self.onGetTaskItem, self._rewardDataList, nil, self._gotaskitem, nil, nil, nil, 4)
end

function SP02_SummonPoolProgressRewardView:onGetTaskItem(itemGo, data, index)
	local item

	if not self._taskItemList[index] then
		item = self:initTaskItem(itemGo, index)
		self._taskItemList[index] = item
	else
		item = self._taskItemList[index]
	end

	gohelper.setActive(itemGo, true)
	gohelper.setActive(item.goItem, false)

	local summonCount = data[1]
	local rewardParam = data[2]

	item.txtFinish.text = tostring(summonCount)
	item.txtNoFinish.text = tostring(summonCount)

	self:refreshSingleReward(item.simageReward1, rewardParam[1])
	self:refreshSingleReward(item.simageReward2, rewardParam[2])
end

function SP02_SummonPoolProgressRewardView:initTaskItem(itemGo, index)
	local item = self:getUserDataTb_()

	item.simageReward1 = gohelper.findChildSingleImage(itemGo, "#simage_reward01")
	item.imageReward1 = gohelper.findChildImage(itemGo, "#simage_reward01")
	item.simageReward2 = gohelper.findChildSingleImage(itemGo, "#simage_reward02")
	item.imageReward2 = gohelper.findChildImage(itemGo, "#simage_reward02")
	item.goFinish1 = gohelper.findChild(itemGo, "#simage_reward01/#go_finish")
	item.goFinish2 = gohelper.findChild(itemGo, "#simage_reward02/#go_finish")
	item.txtFinish = gohelper.findChildTextMesh(itemGo, "#txt_light")
	item.txtNoFinish = gohelper.findChildTextMesh(itemGo, "#txt_gray")
	item.goPointFinish = gohelper.findChild(itemGo, "point/#go_finish")
	item.goPointUnlock = gohelper.findChild(itemGo, "point/#go_doing")
	item.goPointLock = gohelper.findChild(itemGo, "point/#go_gray")
	item.goClaim = gohelper.findChild(itemGo, "#btn_claim")
	item.btnClick = gohelper.findChildButton(itemGo, "#btn_claim/#btn_claim")
	item.btnDetail1 = gohelper.findChildButton(itemGo, "#btn_detail1")
	item.btnDetail2 = gohelper.findChildButton(itemGo, "#btn_detail2")

	local param = {}

	param.target = self
	param.index = index

	item.btnClick:AddClickListener(self.onClickTaskItem, param)

	local rewardParam1 = {}

	rewardParam1.target = self
	rewardParam1.index = index
	rewardParam1.subIndex = 1

	item.btnDetail1:AddClickListener(self.onClickRewardItem, rewardParam1)

	local rewardParam2 = {}

	rewardParam2.target = self
	rewardParam2.index = index
	rewardParam2.subIndex = 2

	gohelper.addUIClickAudio(item.btnClick.gameObject, AudioEnum.UI.UI_Common_Click)
	item.btnDetail2:AddClickListener(self.onClickRewardItem, rewardParam2)

	return item
end

function SP02_SummonPoolProgressRewardView.onClickRewardItem(param)
	local target = param.target
	local index = param.index
	local subIndex = param.subIndex

	target:clickRewardItem(index, subIndex)
end

function SP02_SummonPoolProgressRewardView:clickRewardItem(index, subIndex)
	local data = self._rewardDataList[index]
	local rewardParam = data[2]
	local singleRewardParam = rewardParam[subIndex]

	if singleRewardParam then
		local type = singleRewardParam[1]
		local id = singleRewardParam[2]
		local config = ItemConfig.instance:getItemConfig(type, id)

		if config.subType == ItemEnum.SubType.InspirationBox then
			GiftController.instance:GiftMultipleInspirationHeroPreviewView({
				itemId = id
			})
		else
			AudioMgr.instance:trigger(AudioEnum3_10.SummonProgress.play_ui_langchao_role_open)
			MaterialTipController.instance:showMaterialInfo(type, id)
		end
	end
end

function SP02_SummonPoolProgressRewardView.onClickTaskItem(param)
	local target = param.target
	local index = param.index

	target:clickTaskItem(index)
end

function SP02_SummonPoolProgressRewardView:clickTaskItem(index)
	local data = self._rewardDataList[index]
	local summonCount = data[1]
	local curPoolInfo = SummonMainModel.instance:getPoolServerMO(self._poolId)

	if curPoolInfo then
		::label_20_0::

		local var_20_0 = curPoolInfo.customPickMO

		if curPoolInfo.customPickMO then
			local isGet = curPoolInfo.customPickMO:isOptionalRewardGet(summonCount)
			local isFinish = summonCount <= self._summonCount
			local isUnlock = index <= self._nextRewardIndex

			if not isUnlock or isGet then
				return
			end

			if isFinish then
				local param = {}
				local poolInfoMo = SummonMainModel.instance:getPoolServerMO(self._poolId)
				local poolConfig = SummonConfig.instance:getSummonPool(poolInfoMo.id)

				param.groupId = tonumber(poolConfig.progressChooseGroupId)
				param.progressId = summonCount

				ViewMgr.instance:openView(ViewName.SP02_SummonPoolProgressRewardSelectView, param)
			end
		end
	end
end

function SP02_SummonPoolProgressRewardView:refreshSingleReward(simage, reward)
	return
end

function SP02_SummonPoolProgressRewardView:onGetReward()
	self:checkParam()
	self:refreshRewardState()
end

function SP02_SummonPoolProgressRewardView:refreshRewardState()
	local summonPoolInfo = SummonMainModel.instance:getPoolServerMO(self._poolId)

	for index, item in ipairs(self._taskItemList) do
		local data = self._rewardDataList[index]
		local summonCount = data[1]

		if summonPoolInfo then
			::label_23_0::

			local var_23_0 = summonPoolInfo.customPickMO

			if summonPoolInfo.customPickMO then
				local isGet = summonPoolInfo.customPickMO:isOptionalRewardGet(summonCount)

				if summonPoolInfo then
					::label_23_1::

					local var_23_1 = summonPoolInfo.customPickMO

					if summonPoolInfo.customPickMO then
						local selectIndex = summonPoolInfo.customPickMO:getOptionalRewardSelect(summonCount)
						local isFinish = summonCount <= self._summonCount
						local isUnlock = index <= self._nextRewardIndex

						gohelper.setActive(item.goFinish1, isGet and selectIndex == 1)
						gohelper.setActive(item.goFinish2, isGet and selectIndex ~= 1)
						gohelper.setActive(item.goClaim, not isGet and isFinish and isUnlock)
						gohelper.setActive(item.goPointFinish, isFinish)
						gohelper.setActive(item.goPointUnlock, isFinish and not isGet)
						gohelper.setActive(item.goPointLock, not isFinish)
						gohelper.setActive(item.txtNoFinish, not isFinish)
						gohelper.setActive(item.txtFinish, isFinish)
						gohelper.setActive(item.btnClick, isUnlock and not isGet)
						ZProj.UGUIHelper.SetGrayscale(item.imageReward1.gameObject, isGet)
						ZProj.UGUIHelper.SetGrayscale(item.imageReward2.gameObject, isGet)
					end
				end
			end
		end
	end

	self:refreshProgress()
end

function SP02_SummonPoolProgressRewardView:_onGetRewardHistory(msg)
	if msg then
		local poolCfg = SummonConfig.instance:getSummonPool(msg.poolId)
		local cfg = SummonConfig.instance:getProgressChooseConfig(tonumber(poolCfg and poolCfg.progressChooseGroupId), msg.progress)

		if cfg and not string.nilorempty(cfg.chooseRewards) then
			local bounsList = GameUtil.splitString2(cfg.chooseRewards, true)
			local bouns = bounsList and bounsList[msg.chooseIndex]

			if bouns and #bouns >= 2 and bouns[1] == MaterialEnum.MaterialType.Hero then
				self._getHeroDic = self._getHeroDic or {}
				self._getHeroDic[bouns[2]] = true
			end
		end
	end
end

function SP02_SummonPoolProgressRewardView:onClose()
	for index, item in ipairs(self._taskItemList) do
		item.btnClick:RemoveClickListener()
		item.btnDetail1:RemoveClickListener()
		item.btnDetail2:RemoveClickListener()
	end
end

function SP02_SummonPoolProgressRewardView:onDestroyView()
	if self._getHeroDic then
		SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolPackageProp, self._getHeroDic)

		self._getHeroDic = nil
	end
end

return SP02_SummonPoolProgressRewardView
