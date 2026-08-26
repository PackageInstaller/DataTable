-- chunkname: @modules/logic/versionactivity2_2/act173/view/Activity173FullView.lua

module("modules.logic.versionactivity2_2.act173.view.Activity173FullView", package.seeall)

local Activity173FullView = class("Activity173FullView", BaseView)
local TickRefreshRemainTime = 1

function Activity173FullView:onInitView()
	self._txtDescr = gohelper.findChildText(self.viewGO, "Left/#txt_Descr")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/image_LimitTimeBG/#txt_LimitTime")
	self._btnGO = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_GO")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity173FullView:addEvents()
	self._btnGO:AddClickListener(self._btnGOOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Activity173FullView:removeEvents()
	self._btnGO:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Activity173FullView:_btnGOOnClick()
	self:closeThis()
	GameFacade.jump(JumpEnum.JumpId.Activity173)
end

function Activity173FullView:_btnCloseOnClick()
	self:closeThis()
end

function Activity173FullView:_editableInitView()
	return
end

function Activity173FullView:onUpdateParam()
	return
end

function Activity173FullView:onClickModalMask()
	self:closeThis()
end

function Activity173FullView:onOpen()
	PatFaceCustomHandler.setHasShow(PatFaceEnum.patFace.V2a2_LimitDecorate_PanelView)
	self:refreshActRemainTime()
	TaskDispatcher.cancelTask(self.refreshActRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshActRemainTime, self, TickRefreshRemainTime)
	self:initRewards()
	self:initActivityInfo()
end

function Activity173FullView:refreshActRemainTime()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(VersionActivity2_2Enum.ActivityId.LimitDecorate)
end

function Activity173FullView:initActivityInfo()
	local actInfo = ActivityConfig.instance:getActivityCo(VersionActivity2_2Enum.ActivityId.LimitDecorate)

	self._txtDescr.text = actInfo and actInfo.actDesc
end

function Activity173FullView:initRewards()
	self._onlineTasks = Activity173Config.instance:getAllOnlineTasks()
	self._bonusMap = {}

	for i = 1, #self._onlineTasks do
		local taskCo = self._onlineTasks[i]
		local rewardItem = self:getOrCreateRewardItem(i)

		if string.nilorempty(taskCo.bonus) then
			logError("限定装饰品奖励活动任务奖励配置为空: 任务Id = " .. tostring(taskCo.id))
		else
			local bonus = string.splitToNumber(taskCo.bonus, "#")
			local isPortraitReward = self:checkIsPortraitReward(bonus)

			if isPortraitReward then
				self:onConfigPortraitReward(bonus, rewardItem)
			end

			self._bonusMap[taskCo.id] = bonus
			rewardItem.txtNum.text = luaLang("multiple") .. tostring(bonus[3])
		end
	end
end

function Activity173FullView:getOrCreateRewardItem(index)
	self._rewardItems = self._rewardItems or self:getUserDataTb_()

	local rewardItem = self._rewardItems[index]

	if not rewardItem then
		rewardItem = self:getUserDataTb_()
		rewardItem.goRewardItem = gohelper.findChild(self.viewGO, "Right/Reward" .. index)
		rewardItem.txtNum = gohelper.findChildText(rewardItem.goRewardItem, "image_NumBG/txt_Num")
		rewardItem.simageheadicon = gohelper.findChildSingleImage(rewardItem.goRewardItem, "#simage_HeadIcon")
		rewardItem.btnclick = gohelper.findChildButtonWithAudio(rewardItem.goRewardItem, "btn_click")

		rewardItem.btnclick:AddClickListener(self.onClickRewardIcon, self, index)

		self._rewardItems[index] = rewardItem
	end

	return rewardItem
end

function Activity173FullView:onClickRewardIcon(index)
	if self._onlineTasks then
		local taskCo = self._onlineTasks[index]

		if not taskCo then
			return
		end

		if self._bonusMap then
			local bonus = self._bonusMap[taskCo.id]

			if not bonus then
				logError("打开物品详情界面失败:缺少奖励配置 任务Id = " .. tostring(taskCo.id))

				return
			end

			MaterialTipController.instance:showMaterialInfo(bonus[1], bonus[2])
		end
	end
end

function Activity173FullView:checkIsPortraitReward(bonus)
	local bonusType = bonus[1]
	local bonusId = bonus[2]

	if bonusType == MaterialEnum.MaterialType.Item then
		local config = ItemModel.instance:getItemConfig(bonusType, bonusId)

		if config and config.subType == ItemEnum.SubType.Portrait then
			return true
		end
	end
end

function Activity173FullView:onConfigPortraitReward(bonus, rewardItem)
	if rewardItem.simageheadicon then
		self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(rewardItem.simageheadicon)

		self._liveHeadIcon:setLiveHead(tonumber(bonus[2]))
	end
end

function Activity173FullView:removeAllRewardIconClick()
	if self._rewardItems then
		for _, rewardItem in pairs(self._rewardItems) do
			if rewardItem.btnclick then
				rewardItem.btnclick:RemoveClickListener()
			end
		end
	end
end

function Activity173FullView:onClose()
	TaskDispatcher.cancelTask(self.refreshActRemainTime, self)
	self:removeAllRewardIconClick()
end

function Activity173FullView:onDestroyView()
	return
end

return Activity173FullView
