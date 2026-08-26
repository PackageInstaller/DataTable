-- chunkname: @modules/logic/versionactivity2_6/xugouji/view/XugoujiTaskItem.lua

module("modules.logic.versionactivity2_6.xugouji.view.XugoujiTaskItem", package.seeall)

local XugoujiTaskItem = class("XugoujiTaskItem", ListScrollCellExtend)
local AnimatorComp = typeof(UnityEngine.Animator)

function XugoujiTaskItem:onInitView()
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

function XugoujiTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function XugoujiTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function XugoujiTaskItem:_btnnotfinishbgOnClick()
	if self._taskMO.config.jumpId > 0 then
		GameFacade.jump(self._taskMO.config.jumpId)
	end
end

function XugoujiTaskItem:_btnfinishbgOnClick()
	self:_onOneClickClaimReward(self._taskMO.activityId)
	UIBlockHelper.instance:startBlock("LoperaTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function XugoujiTaskItem:_btngetallOnClick()
	XugoujiController.instance:dispatchEvent(XugoujiEvent.OneClickClaimReward, self._taskMO.activityId)
	UIBlockHelper.instance:startBlock("LoperaTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinishAll, self, 0.5)
end

function XugoujiTaskItem:_delayFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._taskMO.config.id)
end

function XugoujiTaskItem:_delayFinishAll()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity188)
end

function XugoujiTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(AnimatorComp)
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function XugoujiTaskItem:_editableAddEvents()
	LoperaController.instance:registerCallback(LoperaEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function XugoujiTaskItem:_editableRemoveEvents()
	LoperaController.instance:unregisterCallback(LoperaEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function XugoujiTaskItem:_onOneClickClaimReward(actId)
	if self._taskMO and self._taskMO.activityId == actId and self._taskMO:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function XugoujiTaskItem:getAnimator()
	return self._animator
end

function XugoujiTaskItem:onUpdateMO(mo)
	self._taskMO = mo

	local rankDiff = Activity188TaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function XugoujiTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, LoperaEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function XugoujiTaskItem:onSelect(isSelect)
	return
end

function XugoujiTaskItem:_refreshUI()
	local atMO = self._taskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= LoperaEnum.TaskMOAllFinishId

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

				local item_list = {}

				if tonumber(atMO.config.bonus) then
					local list = DungeonConfig.instance:getRewardItems(tonumber(atMO.config.bonus))

					for k, v in ipairs(list) do
						item_list[k] = {
							isIcon = true,
							materilType = v[1],
							materilId = v[2],
							quantity = v[3]
						}
					end
				else
					item_list = ItemModel.instance:getItemDataListByConfigStr(atMO.config.bonus)
				end

				self.item_list = item_list

				IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)

				self._scrollRewards.horizontalNormalizedPosition = 0
			end
		end
	end
end

function XugoujiTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function XugoujiTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

XugoujiTaskItem.prefabPath = "ui/viewres/versionactivity_2_6/v2a6_xugouji/v2a6_xugouji_taskitem.prefab"

return XugoujiTaskItem
