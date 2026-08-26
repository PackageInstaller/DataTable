-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryActivityChallengeView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryActivityChallengeView", package.seeall)

local RoleStoryActivityChallengeView = class("RoleStoryActivityChallengeView", BaseView)

function RoleStoryActivityChallengeView:onInitView()
	self._challengeViewGO = gohelper.findChild(self.viewGO, "challengeview")
	self.simagemonster = gohelper.findChildSingleImage(self._challengeViewGO, "BG/item/Root/#simage_Photo")
	self.rewardBg = gohelper.findChildImage(self._challengeViewGO, "Info/image_InfoBG2")
	self.btnReward = gohelper.findChildButtonWithAudio(self._challengeViewGO, "Info/btnReward")
	self.simgaReward = gohelper.findChildSingleImage(self._challengeViewGO, "Info/btnReward/#image_Reward")
	self.txtRewardNum = gohelper.findChildTextMesh(self._challengeViewGO, "Info/#txt_RewardNum")
	self.goRewardRed = gohelper.findChild(self._challengeViewGO, "Info/#go_Reddot")
	self.goRewardCanGet = gohelper.findChild(self._challengeViewGO, "Info/btnReward/canget")
	self.goRewardHasGet = gohelper.findChild(self._challengeViewGO, "Info/btnReward/hasget")
	self.slider = gohelper.findChildSlider(self._challengeViewGO, "Info/Slider")
	self.txtProgress = gohelper.findChildTextMesh(self._challengeViewGO, "Info/#txt_ScheduleNum")
	self.btnStart = gohelper.findChildButtonWithAudio(self._challengeViewGO, "#btn_start")
	self.simageCost = gohelper.findChildSingleImage(self._challengeViewGO, "#btn_start/#simage_icon")
	self.txtCostNum = gohelper.findChildTextMesh(self._challengeViewGO, "#btn_start/#simage_icon/#txt_num")
	self.tipsBtn = gohelper.findChildButtonWithAudio(self._challengeViewGO, "tipsbg/tips1/icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryActivityChallengeView:addEvents()
	self.btnStart:AddClickListener(self._btnstartOnClick, self)
	self.btnReward:AddClickListener(self._btnrewardOnClick, self)
	self.tipsBtn:AddClickListener(self._btntipsOnClick, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.GetChallengeBonus, self._onGetChallengeBonus, self)
end

function RoleStoryActivityChallengeView:removeEvents()
	self.btnStart:RemoveClickListener()
	self.btnReward:RemoveClickListener()
	self.tipsBtn:RemoveClickListener()
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ActStoryChange, self._onStoryChange, self)
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.GetChallengeBonus, self._onGetChallengeBonus, self)
end

function RoleStoryActivityChallengeView:_editableInitView()
	return
end

function RoleStoryActivityChallengeView:_btntipsOnClick()
	ViewMgr.instance:openView(ViewName.RoleStoryTipView)
end

function RoleStoryActivityChallengeView:_btnstartOnClick()
	if not self.storyMo then
		return
	end

	local episodeId = self.storyMo.cfg.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)
	local costs = GameUtil.splitString2(episodeCo.cost, true)
	local count = 1
	local items = {}

	for i, v in ipairs(costs) do
		table.insert(items, {
			type = v[1],
			id = v[2],
			quantity = v[3] * count
		})
	end

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		if RoleStoryModel.instance:checkTodayCanExchange() then
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough1, icon, notEnoughItemName)
		else
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough2, icon, notEnoughItemName)
		end

		return
	end

	DungeonFightController.instance:enterFightByBattleId(episodeCo.chapterId, episodeId, episodeCo.battleId)
end

function RoleStoryActivityChallengeView:_btnrewardOnClick()
	if not self.storyMo then
		return
	end

	if self.storyMo.wave < self.storyMo.maxWave or self.storyMo.getChallengeReward then
		local bonus = self.storyMo.cfg.challengeBonus
		local bonuss = GameUtil.splitString2(bonus, true)
		local bonus1 = bonuss[1]

		MaterialTipController.instance:showMaterialInfo(bonus1[1], bonus1[2])

		return
	end

	HeroStoryRpc.instance:sendGetChallengeBonusRequest()
end

function RoleStoryActivityChallengeView:onUpdateParam()
	return
end

function RoleStoryActivityChallengeView:onOpen()
	return
end

function RoleStoryActivityChallengeView:onClose()
	return
end

function RoleStoryActivityChallengeView:_onStoryChange()
	self:refreshView()
end

function RoleStoryActivityChallengeView:_onGetChallengeBonus()
	self:refreshProgress()
end

function RoleStoryActivityChallengeView:refreshView()
	self.storyId = RoleStoryModel.instance:getCurActStoryId()
	self.storyMo = RoleStoryModel.instance:getById(self.storyId)

	if not self.storyMo then
		return
	end

	self:refreshItem()
	self:refreshProgress()
	self:refreshCost()
end

function RoleStoryActivityChallengeView:refreshCost()
	if not self.storyMo then
		return
	end

	local episodeId = self.storyMo.cfg.episodeId
	local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

	if not episodeCo then
		return
	end

	local costs = GameUtil.splitString2(episodeCo.cost, true)
	local cost1 = costs[1]
	local icon = ItemModel.instance:getItemSmallIcon(cost1[2])

	self.simageCost:LoadImage(icon)

	self.txtCostNum.text = string.format("-%s", cost1[3] or 0)
end

function RoleStoryActivityChallengeView:refreshItem()
	if not self.storyMo then
		return
	end

	local monsterPic = self.storyMo.cfg.monster_pic
	local path = string.format("singlebg/dungeon/rolestory_photo_singlebg/%s_1.png", monsterPic)

	self.simagemonster:LoadImage(path)
end

function RoleStoryActivityChallengeView:refreshProgress()
	if not self.storyMo then
		return
	end

	local cur = self.storyMo.wave
	local max = self.storyMo.maxWave
	local hasGet = self.storyMo.getChallengeReward

	if hasGet then
		cur = max
	end

	self.txtProgress.text = string.format("<color=#c96635>%s</color>/%s", cur, max)

	self.slider:SetValue(cur / max)

	local bonus = self.storyMo.cfg.challengeBonus
	local bonuss = GameUtil.splitString2(bonus, true)
	local bonus1 = bonuss[1]
	local config, icon = ItemModel.instance:getItemConfigAndIcon(bonus1[1], bonus1[2])

	UISpriteSetMgr.instance:setUiFBSprite(self.rewardBg, "bg_pinjidi_" .. config.rare)
	self.simgaReward:LoadImage(icon)

	self.txtRewardNum.text = tostring(bonus1[3])

	gohelper.setActive(self.goRewardRed, max <= cur and not hasGet)
	gohelper.setActive(self.goRewardCanGet, max <= cur and not hasGet)
	gohelper.setActive(self.goRewardHasGet, hasGet)
end

function RoleStoryActivityChallengeView:onDestroyView()
	if self.simagemonster then
		self.simagemonster:UnLoadImage()
	end

	if self.simageCost then
		self.simageCost:UnLoadImage()
	end
end

return RoleStoryActivityChallengeView
