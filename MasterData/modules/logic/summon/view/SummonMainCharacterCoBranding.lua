-- chunkname: @modules/logic/summon/view/SummonMainCharacterCoBranding.lua

module("modules.logic.summon.view.SummonMainCharacterCoBranding", package.seeall)

local SummonMainCharacterCoBranding = class("SummonMainCharacterCoBranding", SummonMainCharacterProbUp)

function SummonMainCharacterCoBranding:onInitView()
	self._goui = gohelper.findChild(self.viewGO, "#go_ui")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#simage_bg")
	self._simagerole1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/node1/#simage_role1")
	self._simagetitle1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_title1")
	self._simagelogo = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/title/#simage_logo")
	self._gocharacteritem1 = gohelper.findChild(self.viewGO, "#go_ui/current/right/#go_characteritem1")
	self._txtgoto = gohelper.findChildText(self.viewGO, "#go_ui/current/right/#go_characteritem1/btn_goto/#txt_goto")
	self._txttimes = gohelper.findChildText(self.viewGO, "#go_ui/current/first/#txt_times")
	self._txtdeadline = gohelper.findChildText(self.viewGO, "#go_ui/current/#txt_deadline")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "#go_ui/current/#txt_deadline/#simage_line")
	self._btnsummon1 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon1/#btn_summon1")
	self._simagecurrency1 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon1/currency/#simage_currency1")
	self._txtcurrency11 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_1")
	self._txtcurrency12 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon1/currency/#txt_currency1_2")
	self._btnsummon10 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/summonbtns/summon10/#btn_summon10")
	self._simagecurrency10 = gohelper.findChildSingleImage(self.viewGO, "#go_ui/summonbtns/summon10/currency/#simage_currency10")
	self._txtcurrency101 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_1")
	self._txtcurrency102 = gohelper.findChildText(self.viewGO, "#go_ui/summonbtns/summon10/currency/#txt_currency10_2")
	self._btngift = gohelper.findChildButtonWithAudio(self.viewGO, "#go_ui/#btn_gift")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_ui/#go_lefttop")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_ui/#go_righttop")
	self._txtpreferential = gohelper.findChildText(self.viewGO, "#go_ui/current/first/#txt_times")
	self._gopreferential = gohelper.findChild(self.viewGO, "#go_ui/current/first")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainCharacterCoBranding:addEvents()
	self._btnsummon1:AddClickListener(self._btnsummon1OnClick, self)
	self._btnsummon10:AddClickListener(self._btnsummon10OnClick, self)
	self._btnDetail:AddClickListener(self._btndetailOnClick, self)
	self._btnclaim:AddClickListener(self._btndetailOnClick, self)
end

function SummonMainCharacterCoBranding:removeEvents()
	self._btnsummon1:RemoveClickListener()
	self._btnsummon10:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	self._btnclaim:RemoveClickListener()
end

function SummonMainCharacterCoBranding:_btnsummon1OnClick()
	SummonMainCharacterCoBranding.super._btnsummon1OnClick(self)
end

function SummonMainCharacterCoBranding:_btnsummon10OnClick()
	SummonMainCharacterCoBranding.super._btnsummon10OnClick(self)
end

function SummonMainCharacterCoBranding:_btndetailOnClick()
	self:openDetailView()
end

function SummonMainCharacterCoBranding.onClickRewardItem(param)
	local target = param.target
	local rewardParam = param.rewardParam

	target:onClickReward(rewardParam)
end

function SummonMainCharacterCoBranding:onClickReward(rewardParam)
	MaterialTipController.instance:showMaterialInfo(rewardParam[1], rewardParam[2])
end

function SummonMainCharacterCoBranding:_onClickDetailByIndex(index)
	if not self._characteritems then
		return
	end

	local characteritem = self._characteritems[index]

	if characteritem then
		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
			id = characteritem.characterDetailId
		})
		AudioMgr.instance:trigger(AudioEnum3_10.SummonProgress.play_ui_langchao_role_open)
	end
end

local showRewardCount = 2

function SummonMainCharacterCoBranding:_editableInitView()
	SummonMainCharacterCoBranding.super._editableInitView(self)

	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "#go_ui/#go_rewardlayout/#txt_tips")
	self._goTips = gohelper.findChild(self.viewGO, "#go_ui/#go_rewardlayout/rewardpart/#go_tips")
	self._btnDetail = gohelper.findChildButton(self.viewGO, "#go_ui/#go_rewardlayout/#btn_detail")
	self._goRewardItemList = {}

	for i = 1, showRewardCount do
		local itemGo = gohelper.findChild(self.viewGO, "#go_ui/#go_rewardlayout/rewardpart/#simage_reward" .. tostring(i))
		local item = self:getUserDataTb_()

		item.simageIcon = gohelper.findChildSingleImage(itemGo, "")
		item.goGet = gohelper.findChild(itemGo, "#go_isget")
		item.btnclick = SLFramework.UGUI.UIClickListener.Get(itemGo)

		item.btnclick:AddClickListener(self.onClickRewardItem, self)
		table.insert(self._goRewardItemList, item)
	end

	gohelper.setActive(self._goTips, false)

	self._goclaim = gohelper.findChild(self.viewGO, "#go_ui/#go_rewardlayout/#go_claim")
	self._goallget = gohelper.findChild(self.viewGO, "#go_ui/#go_rewardlayout/#go_hasget")
	self._btnclaim = gohelper.findChildButton(self.viewGO, "#go_ui/#go_rewardlayout/#go_claim/#btn_claim")
	self._goFreeTip = gohelper.findChild(self.viewGO, "#go_ui/current/tip2")

	gohelper.setActive(self._goFreeTip, false)
end

function SummonMainCharacterCoBranding:onUpdateParam()
	SummonMainCharacterCoBranding.super.onUpdateParam(self)
end

function SummonMainCharacterCoBranding:onOpen()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshProgressRewards, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self._refreshProgressRewards, self)
	SummonMainCharacterCoBranding.super.onOpen(self)
	self:_refreshProgressRewards()
	self:_refreshPreferentialInfo()
	self:_checkFirstEnter()
end

function SummonMainCharacterCoBranding:onClose()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshProgressRewards, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self._refreshProgressRewards, self)
	SummonMainCharacterCoBranding.super.onClose(self)
	StoreGoodsTaskController.instance:waitUpdateRedDot()
end

function SummonMainCharacterCoBranding:onDestroyView()
	SummonMainCharacterCoBranding.super.onDestroyView(self)

	for _, item in ipairs(self._goRewardItemList) do
		item.simageIcon:UnLoadImage()
		item.btnclick:RemoveClickListener()
	end

	tabletool.clear(self._goRewardItemList)
end

function SummonMainCharacterCoBranding:_adLoaded()
	return
end

local rewardPropKey = "SummonMainCharacterCoBrandingFirstEnter"
local rewardPropState = {
	NotRead = 0,
	HaveRead = 1
}

function SummonMainCharacterCoBranding:_refreshProgressRewards()
	local poolCo = SummonMainModel.instance:getCurPool()

	if not poolCo or string.nilorempty(poolCo.progressChooseGroupId) then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(poolCo.id)

	if not poolMO then
		return
	end

	local rewardCount = poolMO.customPickMO:getOptionalRewardCount() or 0

	if not poolMO.summonCount then
		local summonCount = 0
		local maxRewardCount = 0
		local canRewardCount = 0
		local nextRwardCount, curRewardItemList
		local numsList = SummonConfig.instance:getOptionalProgressRewardByPoolId(poolCo.id)

		if numsList and #numsList > 0 then
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

		self:_refreshPreferentialInfo()

		self._txtDesc.text = rewardCount < canRewardCount and luaLang("sp02_summon_progress_rewards_can_get_tip") or nextRwardCount and summonCount < nextRwardCount and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sp02_summon_progress_rewards_tip"), nextRwardCount - summonCount) or luaLang("sp02_summon_progress_rewards_full_tip")

		local canClaim = rewardCount < canRewardCount

		gohelper.setActive(self._goclaim, canClaim)
		gohelper.setActive(self._goallget, maxRewardCount <= rewardCount)
	end
end

function SummonMainCharacterCoBranding:_checkFirstEnter()
	if not GuideModel.instance:isGuideFinish(108) then
		return
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return
	end

	local state = GameUtil.playerPrefsGetNumberByUserId(rewardPropKey, rewardPropState.NotRead)

	if state ~= rewardPropState.HaveRead then
		GameUtil.playerPrefsSetNumberByUserId(rewardPropKey, rewardPropState.HaveRead)
		self:openDetailView()
	end
end

function SummonMainCharacterCoBranding:getRewardDesc(curRewardItemList)
	if curRewardItemList and next(curRewardItemList) then
		local itemNameList = {}

		for _, rewardParam in ipairs(curRewardItemList) do
			local config = ItemConfig.instance:getItemConfig(rewardParam[1], rewardParam[2])
			local num = rewardParam[3]
			local singleDesc = string.format("<#FFEF99>%s*%s</color>", config.name, num)

			table.insert(itemNameList, singleDesc)
		end

		return table.concat(itemNameList, "+")
	end

	return ""
end

function SummonMainCharacterCoBranding:_refreshPreferentialInfo()
	local curPool = SummonMainModel.instance:getCurPool()

	if not curPool then
		return
	end

	local poolMO = SummonMainModel.instance:getPoolServerMO(curPool.id)
	local preferentialLimitCount = poolMO.canGetGuaranteeSRCount

	if self._gopreferential then
		gohelper.setActive(self._gopreferential, preferentialLimitCount > 0)

		if self._txtpreferential and preferentialLimitCount > 0 then
			self._txtpreferential.text = poolMO.guaranteeSRCountDown
		end
	end
end

function SummonMainCharacterCoBranding:claimReward()
	local poolCo = SummonMainModel.instance:getCurPool()

	self._nextRewardsRequestTime = self._nextRewardsRequestTime or 0

	if poolCo and self._nextRewardsRequestTime <= Time.time then
		self._nextRewardsRequestTime = Time.time + 0.3

		SummonRpc.instance:sendGetSummonProgressRewardsRequest(poolCo.id)
	end
end

function SummonMainCharacterCoBranding:openDetailView()
	local poolCo = SummonMainModel.instance:getCurPool()

	if poolCo then
		SummonMainController.instance:openpPogressRewardView(poolCo.id)
	end
end

return SummonMainCharacterCoBranding
