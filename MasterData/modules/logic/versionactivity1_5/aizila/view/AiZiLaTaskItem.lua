-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaTaskItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaTaskItem", package.seeall)

local AiZiLaTaskItem = class("AiZiLaTaskItem", ListScrollCellExtend)

function AiZiLaTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gomainTaskTitle = gohelper.findChild(self.viewGO, "#go_normal/#go_mainTaskTitle")
	self._gotaskTitle = gohelper.findChild(self.viewGO, "#go_normal/#go_taskTitle")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function AiZiLaTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function AiZiLaTaskItem:_btnnotfinishbgOnClick()
	if self._aizilaTaskMO then
		local episodeId = self._aizilaTaskMO.config.episodeId

		if AiZiLaModel.instance:getEpisodeMO(episodeId) then
			AiZiLaModel.instance:setCurEpisodeId(episodeId)
			AiZiLaController.instance:dispatchEvent(AiZiLaEvent.SelectEpisode)
			AiZiLaController.instance:openEpsiodeDetailView(episodeId)
		else
			AiZiLaHelper.showToastByEpsodeId(episodeId)
		end
	end
end

function AiZiLaTaskItem:_btnfinishbgOnClick()
	if AiZiLaController.instance:delayReward(AiZiLaEnum.AnimatorTime.TaskReward, self._aizilaTaskMO) then
		self:_onOneClickClaimReward(self._aizilaTaskMO.activityId)
	end
end

function AiZiLaTaskItem:_btngetallOnClick()
	if AiZiLaController.instance:delayReward(AiZiLaEnum.AnimatorTime.TaskReward, self._aizilaTaskMO) then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.OneClickClaimReward, self._aizilaTaskMO.activityId)
	end
end

function AiZiLaTaskItem:_editableInitView()
	self._initAnim = true
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	self.viewTrs = self.viewGO.transform
	self._gonormalTrs = self._gonormal.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function AiZiLaTaskItem:_editableAddEvents()
	AiZiLaController.instance:registerCallback(AiZiLaEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function AiZiLaTaskItem:_editableRemoveEvents()
	AiZiLaController.instance:unregisterCallback(AiZiLaEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function AiZiLaTaskItem:_onOneClickClaimReward(actId)
	if self._aizilaTaskMO and self._aizilaTaskMO.activityId == actId and self._aizilaTaskMO:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function AiZiLaTaskItem:getAnimator()
	return self._animator
end

function AiZiLaTaskItem:_onInitOpenAnim()
	if not self.__isRunInitAnim then
		self.__isRunInitAnim = true

		if self._index and self._index <= 5 then
			self:_playAnim(UIAnimationName.Open, true)

			self._isHasOpenAnimTask = true

			TaskDispatcher.runDelay(self._playInitOpenAnim, self, 0.05 + 0.06 * self._index)
		end
	end
end

function AiZiLaTaskItem:_playInitOpenAnim()
	self:_playAnim(UIAnimationName.Open, false)
end

function AiZiLaTaskItem:_playAnim(animName, isStop, isEnd)
	local animator = self:getAnimator()

	if animator then
		animator.speed = isStop and 0 or 1

		animator:Play(animName, 0, isEnd and 1 or 0)
		animator:Update(0)
	end
end

function AiZiLaTaskItem:onUpdateMO(mo)
	self:_onInitOpenAnim()

	self._aizilaTaskMO = mo

	local rankDiff = AiZiLaTaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csMixScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function AiZiLaTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, AiZiLaEnum.UITaskItemHeight.ItemCell * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, AiZiLaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function AiZiLaTaskItem:onSelect(isSelect)
	return
end

function AiZiLaTaskItem:_getOffsetY()
	if self._aizilaTaskMO and self._aizilaTaskMO.showTypeTab then
		return AiZiLaEnum.UITaskItemHeight.ItemTab * -0.5
	end

	return 0
end

function AiZiLaTaskItem:_refreshUI()
	local atMO = self._aizilaTaskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= AiZiLaEnum.TaskMOAllFinishId

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if isNormal then
		if self._playFinishAnin then
			self._playFinishAnin = false

			self._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg, false)
		gohelper.setActive(self._btnfinishbg, false)
		gohelper.setActive(self._gomainTaskTitle, atMO.showTypeTab and atMO:isMainTask())
		gohelper.setActive(self._gotaskTitle, atMO.showTypeTab and not atMO:isMainTask())
		transformhelper.setLocalPosXY(self._gonormalTrs, 0, self:_getOffsetY())

		if atMO:isFinished() then
			gohelper.setActive(self._goallfinish, true)
		elseif atMO:alreadyGotReward() then
			gohelper.setActive(self._btnfinishbg, true)
		else
			gohelper.setActive(self._btnnotfinishbg, true)
		end

		if atMO.config then
			if not atMO.config.offestProgress then
				local offestPro = 0

				self._txtnum.text = math.max(atMO:getFinishProgress() + offestPro, 0)
				self._txttotal.text = math.max(atMO:getMaxProgress() + offestPro, 0)

				if atMO.config then
					self._txttaskdes.text = atMO.config.desc or ""
				end

				local item_list = ItemModel.instance:getItemDataListByConfigStr(atMO.config.bonus)

				self.item_list = item_list

				IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)

				self._scrollRewards.horizontalNormalizedPosition = 0
			end
		end
	end
end

function AiZiLaTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function AiZiLaTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end

	if self._playInitOpenAnimTask then
		self._playInitOpenAnimTask = nil

		TaskDispatcher.cancelTask(self._playInitOpenAnim, self)
	end
end

AiZiLaTaskItem.prefabPath = "ui/viewres/versionactivity_1_5/v1a5_aizila/v1a5_aizila_taskitem.prefab"

return AiZiLaTaskItem
