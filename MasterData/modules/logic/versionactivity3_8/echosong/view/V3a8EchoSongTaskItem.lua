-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongTaskItem.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongTaskItem", package.seeall)

local V3a8EchoSongTaskItem = class("V3a8EchoSongTaskItem", ListScrollCellExtend)

function V3a8EchoSongTaskItem:onInitView()
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

function V3a8EchoSongTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function V3a8EchoSongTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function V3a8EchoSongTaskItem:_btnnotfinishbgOnClick()
	if self._taskMo.config.jumpId > 0 then
		GameFacade.jump(self._taskMo.config.jumpId)
		ViewMgr.instance:closeView(ViewName.V3a8EchoSongTaskView)
	end
end

local BLOCK_KEY = "V3a8EchoSongTaskItem_finishAnim"

function V3a8EchoSongTaskItem:_btnfinishbgOnClick()
	self:_onOneClickClaimReward(self._taskMo.activityId)
	UIBlockHelper.instance:startBlock(BLOCK_KEY, 0.5)
	TaskDispatcher.runDelay(self._delayFinish, self, 0.5)
end

function V3a8EchoSongTaskItem:_delayFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._taskMo.config.id)
end

function V3a8EchoSongTaskItem:_btngetallOnClick()
	self:_onOneClickClaimReward(self._taskMo.activityId)
	UIBlockHelper.instance:startBlock(BLOCK_KEY, 0.5)
	TaskDispatcher.runDelay(self._delayFinishAll, self, 0.5)
end

function V3a8EchoSongTaskItem:_delayFinishAll()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity220)
end

function V3a8EchoSongTaskItem:_onOneClickClaimReward(actId)
	if self._taskMo and self._taskMo.activityId == actId and self._taskMo:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function V3a8EchoSongTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
	self._scrollRewards = gohelper.findChildComponent(self.viewGO, "#go_normal/#scroll_rewards", typeof(ZProj.LimitedScrollRect))
end

function V3a8EchoSongTaskItem:onUpdateMO(mo)
	self._taskMo = mo

	local rankDiff = Activity220TaskListModel.instance:getRankDiff(mo)

	self._scrollRewards.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function V3a8EchoSongTaskItem:_refreshUI()
	local atMO = self._taskMo

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

function V3a8EchoSongTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setCountFontSize(48)
end

function V3a8EchoSongTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, 0.15)
	end
end

function V3a8EchoSongTaskItem:getAnimator()
	return self._animator
end

function V3a8EchoSongTaskItem:onSelect(isSelect)
	return
end

function V3a8EchoSongTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

return V3a8EchoSongTaskItem
