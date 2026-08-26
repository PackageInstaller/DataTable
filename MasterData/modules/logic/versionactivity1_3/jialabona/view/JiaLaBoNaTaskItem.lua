-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaTaskItem.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaTaskItem", package.seeall)

local JiaLaBoNaTaskItem = class("JiaLaBoNaTaskItem", ListScrollCellExtend)

function JiaLaBoNaTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function JiaLaBoNaTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function JiaLaBoNaTaskItem:_btnnotfinishbgOnClick()
	if self._act120TaskMO then
		local episodeId = self._act120TaskMO.config.episodeId

		if JiaLaBoNaHelper.isOpenDay(episodeId) then
			Activity120Model.instance:setCurEpisodeId(episodeId)
			JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.SelectEpisode)
			ViewMgr.instance:closeView(ViewName.JiaLaBoNaTaskView)
		else
			JiaLaBoNaHelper.showToastByEpsodeId(episodeId)
		end
	end
end

function JiaLaBoNaTaskItem:_btnfinishbgOnClick()
	if JiaLaBoNaController.instance:delayReward(JiaLaBoNaEnum.AnimatorTime.TaskReward, self._act120TaskMO) then
		self:_onOneClickClaimReward(self._act120TaskMO.activityId)
	end
end

function JiaLaBoNaTaskItem:_btngetallOnClick()
	if JiaLaBoNaController.instance:delayReward(JiaLaBoNaEnum.AnimatorTime.TaskReward, self._act120TaskMO) then
		JiaLaBoNaController.instance:dispatchEvent(JiaLaBoNaEvent.OneClickClaimReward, self._act120TaskMO.activityId)
	end
end

function JiaLaBoNaTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function JiaLaBoNaTaskItem:_editableAddEvents()
	JiaLaBoNaController.instance:registerCallback(JiaLaBoNaEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function JiaLaBoNaTaskItem:_editableRemoveEvents()
	JiaLaBoNaController.instance:unregisterCallback(JiaLaBoNaEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function JiaLaBoNaTaskItem:_onOneClickClaimReward(actId)
	if self._act120TaskMO and self._act120TaskMO.activityId == actId and self._act120TaskMO:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function JiaLaBoNaTaskItem:getAnimator()
	return self._animator
end

function JiaLaBoNaTaskItem:onUpdateMO(mo)
	self._act120TaskMO = mo

	local rankDiff = Activity120TaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function JiaLaBoNaTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, JiaLaBoNaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function JiaLaBoNaTaskItem:onSelect(isSelect)
	return
end

function JiaLaBoNaTaskItem:_refreshUI()
	local atMO = self._act120TaskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= JiaLaBoNaEnum.TaskMOAllFinishId

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

function JiaLaBoNaTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function JiaLaBoNaTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

JiaLaBoNaTaskItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_jialabona/v1a3_jialabonataskitem.prefab"

return JiaLaBoNaTaskItem
