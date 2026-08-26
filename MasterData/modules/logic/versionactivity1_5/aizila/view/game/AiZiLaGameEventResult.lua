-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameEventResult.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventResult", package.seeall)

local AiZiLaGameEventResult = class("AiZiLaGameEventResult", BaseView)

function AiZiLaGameEventResult:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "content/#simage_PanelBG")
	self._scrollDescr = gohelper.findChildScrollRect(self.viewGO, "content/#scroll_Descr")
	self._txtDescr = gohelper.findChildText(self.viewGO, "content/#scroll_Descr/Viewport/Content/#txt_Descr")
	self._simagePanelBGMask = gohelper.findChildSingleImage(self.viewGO, "content/#simage_PanelBGMask")
	self._simageLevelPic = gohelper.findChildSingleImage(self.viewGO, "content/#simage_LevelPic")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "content/Reward/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "content/Reward/#scroll_rewards/Viewport/#go_rewards")
	self._btnleave = gohelper.findChildButtonWithAudio(self.viewGO, "content/Reward/Btn/#btn_leave")
	self._txtTips = gohelper.findChildText(self.viewGO, "content/#txt_Tips")
	self._goTagBG = gohelper.findChild(self.viewGO, "content/#go_TagBG")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaGameEventResult:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnleave:AddClickListener(self._btnleaveOnClick, self)
end

function AiZiLaGameEventResult:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnleave:RemoveClickListener()
end

function AiZiLaGameEventResult:_btncloseOnClick()
	AiZiLaGameController.instance:leaveEventResult()
end

function AiZiLaGameEventResult:_btnleaveOnClick()
	AiZiLaGameController.instance:leaveEventResult()
end

function AiZiLaGameEventResult:_editableInitView()
	self._goodsItemGo = self:getResInst(AiZiLaGoodsItem.prefabPath, self.viewGO)

	gohelper.setActive(self._goodsItemGo, false)

	self._goRewardBG = gohelper.findChild(self.viewGO, "content/Reward/image_RewardBG")
	self._goTexReward = gohelper.findChild(self.viewGO, "content/Reward/txt_Reward")
end

function AiZiLaGameEventResult:onUpdateParam()
	return
end

function AiZiLaGameEventResult:onOpen()
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	self.addEventCb(self, AiZiLaController.instance, AiZiLaEvent.ExitGame, self.closeThis, self)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btncloseOnClick, self)
	end

	self._eventId = self.viewParam.eventId
	self._actId = self.viewParam.actId
	self._optionId = self.viewParam.optionId
	self._optionResultId = self.viewParam.optionResultId
	self._itemMOList = self.viewParam.itemMOList
	self._eventCfg = AiZiLaConfig.instance:getEventCo(self._actId, self._eventId)
	self._optionCfg = AiZiLaConfig.instance:getOptionCo(self._actId, self._optionId)
	self._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(self._actId, AiZiLaGameModel.instance:getEpisodeId())
	self._optionResultCfg = AiZiLaConfig.instance:getOptionResultCo(self._actId, self._optionResultId)

	if not self._eventCfg then
		logError("export_事件 配置找不到: activityId:%s eventId:%s", self._actId, self._eventId)
	end

	if not self._optionCfg then
		logError("export_事件选项 配置找不到: activityId:%s optionId:%s", self._actId, self._optionId)
	end

	if not self._optionResultCfg then
		logError("export_选项结果 配置找不到: activityId:%s optionId:%s", self._actId, self._optionResultId)
	end

	self:refreshUI()
end

function AiZiLaGameEventResult:onClose()
	return
end

function AiZiLaGameEventResult:onDestroyView()
	self._simageLevelPic:UnLoadImage()
end

function AiZiLaGameEventResult:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function AiZiLaGameEventResult:refreshUI()
	if not self._eventCfg or not self._optionCfg then
		return
	end

	if self._episodeCfg and not string.nilorempty(self._episodeCfg.picture) then
		self._simageLevelPic:LoadImage(string.format("%s.png", self._episodeCfg.picture))
	end

	if self._itemMOList then
		local isHasward = #self._itemMOList > 0

		gohelper.setActive(self._goRewardBG, isHasward)
		gohelper.setActive(self._goTexReward, isHasward)
		gohelper.setActive(self._goTagBG, self._eventCfg.eventType == AiZiLaEnum.EventType.BranchLine)
		gohelper.CreateObjList(self, self._onRewardItem, self._itemMOList, self._gorewards, self._goodsItemGo, AiZiLaGoodsItem)

		self._txtDescr.text = self._optionCfg.conditionDesc

		if self._optionResultCfg then
			if not self._optionResultCfg.desc then
				local desc = self._optionCfg.desc

				self._txtTips.text = string.format("%s\n<color=#8f5501>%s</color>", self._optionCfg.name, desc)
			end
		end
	end
end

function AiZiLaGameEventResult:_onRewardItem(cell_component, data, index)
	cell_component:onUpdateMO(data)
end

return AiZiLaGameEventResult
