-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130TaskItem.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130TaskItem", package.seeall)

local Activity130TaskItem = class("Activity130TaskItem", ListScrollCellExtend)

function Activity130TaskItem:onInitView()
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

function Activity130TaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function Activity130TaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function Activity130TaskItem:_btnnotfinishbgOnClick()
	if self._act130TaskMO then
		local jumpId = self._act130TaskMO.config.jumpId

		if jumpId and jumpId > 0 then
			GameFacade.jump(jumpId)
		end
	end
end

function Activity130TaskItem:_btnfinishbgOnClick()
	if Activity130Controller.instance:delayReward(Activity130Enum.AnimatorTime.TaskReward, self._act130TaskMO) then
		self:_onOneClickClaimReward(self._act130TaskMO.activityId)
	end
end

function Activity130TaskItem:_btngetallOnClick()
	if Activity130Controller.instance:delayReward(Activity130Enum.AnimatorTime.TaskReward, self._act130TaskMO) then
		Activity130Controller.instance:dispatchEvent(Activity130Event.OneClickClaimReward, self._act130TaskMO.activityId)
	end
end

function Activity130TaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
end

function Activity130TaskItem:_editableAddEvents()
	Activity130Controller.instance:registerCallback(Activity130Event.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function Activity130TaskItem:_editableRemoveEvents()
	Activity130Controller.instance:unregisterCallback(Activity130Event.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function Activity130TaskItem:_onOneClickClaimReward(actId)
	if self._act130TaskMO and self._act130TaskMO.activityId == actId and self._act130TaskMO:alreadyGotReward() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function Activity130TaskItem:getAnimator()
	return self._animator
end

function Activity130TaskItem:onUpdateMO(mo)
	self._scrollreward.parentGameObject = self._view._csListScroll.gameObject
	self._act130TaskMO = mo

	local rankDiff = Activity130TaskListModel.instance:getRankDiff(mo)

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function Activity130TaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, Activity130Enum.AnimatorTime.TaskRewardMoveUp)
	end
end

function Activity130TaskItem:onSelect(isSelect)
	return
end

function Activity130TaskItem:_refreshUI()
	local atMO = self._act130TaskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= Activity130Enum.TaskMOAllFinishId

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
			self._txttaskdes.text = atMO.config.name or ""
		end

		local item_list = ItemModel.instance:getItemDataListByConfigStr(atMO.config.bonus)

		self.item_list = item_list

		IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)
	end

	self._scrollreward.horizontalNormalizedPosition = 0
end

function Activity130TaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function Activity130TaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

Activity130TaskItem.prefabPath = "ui/viewres/versionactivity_1_4/v1a4_37role/v1a4_role37_taskitem.prefab"

return Activity130TaskItem
