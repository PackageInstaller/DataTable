-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessTaskItem.lua

module("modules.logic.autochess.main.view.comp.AutoChessTaskItem", package.seeall)

local AutoChessTaskItem = class("AutoChessTaskItem", ListScrollCellExtend)

function AutoChessTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_jump")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_get")
	self._golock = gohelper.findChild(self.viewGO, "#go_normal/#go_lock")
	self._txtlock = gohelper.findChild(self.viewGO, "#go_normal/#go_lock/#txt_lock")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessTaskItem:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function AutoChessTaskItem:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function AutoChessTaskItem:_btnjumpOnClick()
	self._view:closeThis()
	ViewMgr.instance:closeView(ViewName.AutoChessCultivateView)
end

function AutoChessTaskItem:_btngetOnClick()
	self:_onOneClickClaimReward(self._taskMo.activityId)
	UIBlockHelper.instance:startBlock("AutoChessTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function AutoChessTaskItem:_btngetallOnClick()
	AutoChessController.instance:dispatchEvent(AutoChessEvent.OneClickClaimReward, self._taskMo.activityId)
	UIBlockHelper.instance:startBlock("AutoChessTaskItem_finishAnim", 0.5)
	TaskDispatcher.runDelay(self._delayFinishAll, self, 0.5)
end

function AutoChessTaskItem:_delayFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._taskMo.config.id)
end

function AutoChessTaskItem:_delayFinishAll()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.AutoChess)
end

function AutoChessTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function AutoChessTaskItem:_editableAddEvents()
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function AutoChessTaskItem:_editableRemoveEvents()
	self.removeEventCb(self, AutoChessController.instance, AutoChessEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function AutoChessTaskItem:_onOneClickClaimReward(actId)
	if self._taskMo and self._taskMo.activityId == actId and self._taskMo:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function AutoChessTaskItem:getAnimator()
	return self._animator
end

function AutoChessTaskItem:onUpdateMO(mo)
	self._taskMo = mo

	local rankDiff = AutoChessTaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function AutoChessTaskItem:_moveByRankDiff(rankDiff)
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

function AutoChessTaskItem:onSelect(isSelect)
	return
end

function AutoChessTaskItem:_refreshUI()
	local taskMo = self._taskMo

	if not taskMo then
		return
	end

	local isNormal = not taskMo:isAllMo()

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if isNormal then
		local isLock, unlockLvl = taskMo:isLock()

		if isLock then
			self._txtlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_warnlevel_unlock"), unlockLvl)

			gohelper.setActive(self._golock, true)

			return
		end

		gohelper.setActive(self._golock, false)

		if self._playFinishAnin then
			self._playFinishAnin = false

			self._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnjump, false)
		gohelper.setActive(self._btnget, false)

		if taskMo:isFinished() then
			gohelper.setActive(self._goallfinish, true)
		elseif taskMo:alreadyGotReward() then
			gohelper.setActive(self._btnget, true)
		else
			gohelper.setActive(self._btnjump, true)
		end

		local config = taskMo.config

		if not config.offestProgress then
			self._txtnum.text = math.max(taskMo:getFinishProgress() + config.offestProgress, 0)
			self._txttotal.text = math.max(taskMo:getMaxProgress() + config.offestProgress, 0)
			self._txttaskdes.text = config.desc or ""

			local list = DungeonConfig.instance:getRewardItems(tonumber(config.bonus))
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

function AutoChessTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function AutoChessTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

AutoChessTaskItem.prefabPath = "ui/viewres/versionactivity_2_5/autochess/item/autochesstaskitem.prefab"

return AutoChessTaskItem
