-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanTaskItem.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanTaskItem", package.seeall)

local HuiDiaoLanTaskItem = class("HuiDiaoLanTaskItem", ListScrollCellExtend)

function HuiDiaoLanTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._gonojump = gohelper.findChild(self.viewGO, "#go_normal/#go_nojump")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HuiDiaoLanTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function HuiDiaoLanTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function HuiDiaoLanTaskItem:_btnnotfinishbgOnClick()
	if self.taskMo.config.jumpId > 0 then
		GameFacade.jump(self.taskMo.config.jumpId)
	end
end

function HuiDiaoLanTaskItem:_btnfinishbgOnClick()
	self:_onOneClickClaimReward(self.taskMo.activityId)
	UIBlockHelper.instance:startBlock("HuiDiaoLanTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function HuiDiaoLanTaskItem:_btngetallOnClick()
	HuiDiaoLanGameController.instance:dispatchEvent(HuiDiaoLanEvent.OneClickClaimReward, self.taskMo.activityId)
	UIBlockHelper.instance:startBlock("HuiDiaoLanTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinishAll, self, 0.5)
end

function HuiDiaoLanTaskItem:_delayFinish()
	TaskRpc.instance:sendFinishTaskRequest(self.taskMo.config.id)
end

function HuiDiaoLanTaskItem:_delayFinishAll()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity220)
end

function HuiDiaoLanTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function HuiDiaoLanTaskItem:_editableAddEvents()
	HuiDiaoLanGameController.instance:registerCallback(HuiDiaoLanEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function HuiDiaoLanTaskItem:_editableRemoveEvents()
	HuiDiaoLanGameController.instance:unregisterCallback(HuiDiaoLanEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function HuiDiaoLanTaskItem:_onOneClickClaimReward(actId)
	if self.taskMo and self.taskMo.activityId == actId and self.taskMo:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function HuiDiaoLanTaskItem:getAnimator()
	return self._animator
end

function HuiDiaoLanTaskItem:onUpdateMO(mo)
	self.taskMo = mo

	local rankDiff = HuiDiaoLanTaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function HuiDiaoLanTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, 0.15)
	end
end

function HuiDiaoLanTaskItem:onSelect(isSelect)
	return
end

function HuiDiaoLanTaskItem:_refreshUI()
	local atMO = self.taskMo

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= -99999

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
		gohelper.setActive(self._gonojump, false)

		if atMO:isFinished() then
			gohelper.setActive(self._goallfinish, true)
		elseif atMO:alreadyGotReward() then
			gohelper.setActive(self._btnfinishbg, true)
		elseif atMO.config.jumpId > 0 then
			gohelper.setActive(self._btnnotfinishbg, true)
		else
			gohelper.setActive(self._gonojump, true)
		end

		if atMO.config then
			if not atMO.config.offestProgress then
				local offestPro = 0

				self._txtnum.text = math.max(atMO:getFinishProgress() + offestPro, 0)
				self._txttotal.text = math.max(atMO:getMaxProgress() + offestPro, 0)

				if atMO.config then
					self._txttaskdes.text = atMO.config.desc or ""
				end

				local list = DungeonConfig.instance:getRewardItems(tonumber(atMO.config.bonus))
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
end

function HuiDiaoLanTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setCountFontSize(48)
end

function HuiDiaoLanTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

return HuiDiaoLanTaskItem
