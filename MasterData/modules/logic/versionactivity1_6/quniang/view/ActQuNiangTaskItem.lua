-- chunkname: @modules/logic/versionactivity1_6/quniang/view/ActQuNiangTaskItem.lua

module("modules.logic.versionactivity1_6.quniang.view.ActQuNiangTaskItem", package.seeall)

local ActQuNiangTaskItem = class("ActQuNiangTaskItem", ListScrollCellExtend)

ActQuNiangTaskItem.prefabPath = "ui/viewres/versionactivity_1_6/v1a6_quniang/v1a6_quniang_taskitem.prefab"

function ActQuNiangTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._scrollreward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
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

function ActQuNiangTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function ActQuNiangTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function ActQuNiangTaskItem:_btnnotfinishbgOnClick()
	ActQuNiangController.instance:openLevelView({
		needShowFight = self._actTaskMO.config.listenerType ~= "StoryFinish"
	})
	ViewMgr.instance:closeView(ViewName.ActQuNiangTaskView)
end

function ActQuNiangTaskItem:_btnfinishbgOnClick()
	if ActQuNiangController.instance:delayReward(ActQuNiangEnum.AnimatorTime.TaskReward, self._actTaskMO) then
		self:_onOneClickClaimReward(self._actTaskMO.activityId)
	end
end

function ActQuNiangTaskItem:_btngetallOnClick()
	if ActQuNiangController.instance:delayReward(ActQuNiangEnum.AnimatorTime.TaskReward, self._actTaskMO) then
		ActQuNiangController.instance:dispatchEvent(ActQuNiangEvent.OneClickClaimReward, self._actTaskMO.activityId)
	end
end

function ActQuNiangTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
end

function ActQuNiangTaskItem:_editableAddEvents()
	self.addEventCb(self, ActQuNiangController.instance, ActQuNiangEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function ActQuNiangTaskItem:_editableRemoveEvents()
	self.removeEventCb(self, ActQuNiangController.instance, ActQuNiangEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function ActQuNiangTaskItem:_onOneClickClaimReward(actId)
	if self._actTaskMO and self._actTaskMO.activityId == actId and self._actTaskMO:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function ActQuNiangTaskItem:getAnimator()
	return self._animator
end

function ActQuNiangTaskItem:onUpdateMO(mo)
	self._scrollreward.parentGameObject = self._view._csListScroll.gameObject
	self._actTaskMO = mo

	local rankDiff = ActQuNiangTaskListModel.instance.instance:getRankDiff(mo)

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function ActQuNiangTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, ActQuNiangEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function ActQuNiangTaskItem:onSelect(isSelect)
	return
end

function ActQuNiangTaskItem:_refreshUI()
	local atMO = self._actTaskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= ActQuNiangEnum.TaskMOAllFinishId

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

		self._txtnum.text = atMO:getFinishProgress()
		self._txttotal.text = atMO:getMaxProgress()

		if atMO.config then
			self._txttaskdes.text = atMO.config.taskDesc or ""
		end

		local item_list = ItemModel.instance:getItemDataListByConfigStr(atMO.config.bonus)

		self.item_list = item_list

		IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)
	end

	self._scrollreward.horizontalNormalizedPosition = 0
end

function ActQuNiangTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function ActQuNiangTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

return ActQuNiangTaskItem
