-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/view/LengZhou6TaskItem.lua

module("modules.logic.versionactivity2_7.lengzhou6.view.LengZhou6TaskItem", package.seeall)

local LengZhou6TaskItem = class("LengZhou6TaskItem", ListScrollCellExtend)

function LengZhou6TaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gonojump = gohelper.findChild(self.viewGO, "#go_normal/#go_nojump")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LengZhou6TaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function LengZhou6TaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function LengZhou6TaskItem:_btnnotfinishbgOnClick()
	if self._mo.config.jumpId > 0 then
		GameFacade.jump(self._mo.config.jumpId)
	end
end

function LengZhou6TaskItem:_btnfinishbgOnClick()
	self:_onOneClickClaimReward(self._mo.activityId)
	UIBlockHelper.instance:startBlock(LengZhou6Enum.BlockKey.OneClickClaimReward, 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function LengZhou6TaskItem:_delayFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._mo.config.id)
end

function LengZhou6TaskItem:_btngetallOnClick()
	LengZhou6Controller.instance:dispatchEvent(LengZhou6Event.OneClickClaimReward, self._mo.activityId)
	UIBlockHelper.instance:startBlock(LengZhou6Enum.BlockKey.OneClickClaimReward, 0.5)
	TaskDispatcher.runDelay(self._delayFinishAll, self, 0.5)
end

function LengZhou6TaskItem:_delayFinishAll()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity190)
end

function LengZhou6TaskItem:_onOneClickClaimReward(actId)
	if self._mo and self._mo.activityId == actId and self._mo:alreadyGotReward() then
		self._playFinishAnim = true

		self._animator:Play("finish", 0, 0)
	end
end

function LengZhou6TaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function LengZhou6TaskItem:_editableAddEvents()
	LengZhou6Controller.instance:registerCallback(LengZhou6Event.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function LengZhou6TaskItem:_editableRemoveEvents()
	LengZhou6Controller.instance:unregisterCallback(LengZhou6Event.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function LengZhou6TaskItem:onUpdateMO(mo)
	self._mo = mo
	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff()
end

function LengZhou6TaskItem:_refreshUI()
	if not self._mo then
		return
	end

	local isNormal = self._mo.id ~= LengZhou6Enum.TaskMOAllFinishId

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if not isNormal then
		return
	end

	if self._playFinishAnim then
		self._playFinishAnim = false

		self._animator:Play("idle", 0, 1)
	end

	gohelper.setActive(self._goallfinish, false)
	gohelper.setActive(self._btnnotfinishbg, false)
	gohelper.setActive(self._btnfinishbg, false)
	gohelper.setActive(self._gonojump, false)

	if self._mo:isFinished() then
		gohelper.setActive(self._goallfinish, true)
	elseif self._mo:alreadyGotReward() then
		gohelper.setActive(self._btnfinishbg, true)
	elseif self._mo.config.jumpId > 0 then
		gohelper.setActive(self._btnnotfinishbg, true)
	else
		gohelper.setActive(self._gonojump, true)
	end

	if self._mo.config then
		if not self._mo.config.offestProgress then
			local offestPro = 0

			self._txtnum.text = math.max(self._mo:getFinishProgress() + offestPro, 0)
			self._txttotal.text = math.max(self._mo:getMaxProgress() + offestPro, 0)

			if self._mo.config then
				self._txttaskdes.text = self._mo.config.desc or ""
			end

			local list = DungeonConfig.instance:getRewardItems(tonumber(self._mo.config.bonus))
			local item_list = {}

			for k, v in ipairs(list) do
				item_list[k] = {
					isIcon = true,
					materilType = v[1],
					materilId = v[2],
					quantity = v[3]
				}
			end

			self.item_list = item_list

			IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)

			self._scrollRewards.horizontalNormalizedPosition = 0
		end
	end
end

function LengZhou6TaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function LengZhou6TaskItem:_moveByRankDiff()
	local rankDiff = LengZhou6TaskListModel.instance:getRankDiff(self._mo)

	if not rankDiff or rankDiff == 0 then
		return
	end

	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end

	local posx, _, _ = transformhelper.getLocalPos(self.viewTrs)

	transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

	self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, 0.15)
end

function LengZhou6TaskItem:onSelect(isSelect)
	return
end

function LengZhou6TaskItem:getAnimator()
	return self._animator
end

function LengZhou6TaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

return LengZhou6TaskItem
