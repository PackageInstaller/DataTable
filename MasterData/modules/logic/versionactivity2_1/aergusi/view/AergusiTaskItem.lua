-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiTaskItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiTaskItem", package.seeall)

local AergusiTaskItem = class("AergusiTaskItem", ListScrollCellExtend)

function AergusiTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._scrollreward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._goquan = gohelper.findChild(self.viewGO, "#go_normal/#btn_notfinishbg/quan")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gonojump = gohelper.findChild(self.viewGO, "#go_normal/#go_nojump")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AergusiTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function AergusiTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function AergusiTaskItem:_btnnotfinishbgOnClick()
	if self._taskMO then
		local jumpId = self._taskMO.config.jumpId

		if jumpId and jumpId > 0 then
			GameFacade.jump(jumpId)
		end
	end
end

function AergusiTaskItem:_btnfinishbgOnClick()
	if AergusiController.instance:delayReward(AergusiEnum.AnimatorTime.TaskReward, self._taskMO) then
		self:_onOneClickClaimReward(self._taskMO.activityId)
	end
end

function AergusiTaskItem:_btngetallOnClick()
	if AergusiController.instance:delayReward(AergusiEnum.AnimatorTime.TaskReward, self._taskMO) then
		Activity131Controller.instance:dispatchEvent(Activity131Event.OneClickClaimReward, self._taskMO.activityId)
	end
end

function AergusiTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.viewTrs = self.viewGO.transform
end

function AergusiTaskItem:_editableAddEvents()
	AergusiController.instance:registerCallback(AergusiEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function AergusiTaskItem:_editableRemoveEvents()
	AergusiController.instance:unregisterCallback(AergusiEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
end

function AergusiTaskItem:_onOneClickClaimReward(actId)
	if self._taskMO and self._taskMO.activityId == actId and self._taskMO:alreadyGotReward() then
		self._playFinishAnin = true
		self._animator.enabled = true

		self._animator:Play("finish", 0, 0)
	end
end

function AergusiTaskItem:getAnimator()
	return self._animator
end

function AergusiTaskItem:onUpdateMO(mo)
	self._taskMO = mo

	local rankDiff = AergusiTaskListModel.instance:getRankDiff(mo)

	self:_refreshUI()
	self:_moveByRankDiff(rankDiff)
end

function AergusiTaskItem:_moveByRankDiff(rankDiff)
	if rankDiff and rankDiff ~= 0 then
		if self._rankDiffMoveId then
			ZProj.TweenHelper.KillById(self._rankDiffMoveId)

			self._rankDiffMoveId = nil
		end

		local posx, posy, posz = transformhelper.getLocalPos(self.viewTrs)

		transformhelper.setLocalPosXY(self.viewTrs, posx, 165 * rankDiff)

		self._rankDiffMoveId = ZProj.TweenHelper.DOAnchorPosY(self.viewTrs, 0, AergusiEnum.AnimatorTime.TaskRewardMoveUp)
	end
end

function AergusiTaskItem:onSelect(isSelect)
	return
end

function AergusiTaskItem:_refreshUI()
	local atMO = self._taskMO

	if not atMO then
		return
	end

	local isNormal = atMO.id ~= AergusiEnum.TaskMOAllFinishId

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if isNormal then
		if self._playFinishAnin then
			self._playFinishAnin = false

			self._animator:Play("idle", 0, 1)
		else
			local disable = AergusiTaskListModel.instance:getAniDisableState()

			if disable then
				self._animator:Play("open", 1, 0)
				gohelper.setActive(self._goquan, false)
			end
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg, false)
		gohelper.setActive(self._btnfinishbg, false)
		gohelper.setActive(self._gonojump, false)

		if atMO:isFinished() then
			gohelper.setActive(self._goallfinish, true)
		elseif atMO:alreadyGotReward() then
			gohelper.setActive(self._btnfinishbg, true)
		else
			local jumpId = self._taskMO.config.jumpId

			gohelper.setActive(self._btnnotfinishbg.gameObject, jumpId > 0)
			gohelper.setActive(self._gonojump, jumpId <= 0)
		end

		self._txtnum.text = atMO:getFinishProgress()
		self._txttotal.text = atMO:getMaxProgress()

		if atMO.config then
			self._txttaskdes.text = atMO.config.name or ""
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
	end

	self._scrollreward.horizontalNormalizedPosition = 0
end

function AergusiTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function AergusiTaskItem:onDestroyView()
	if self._rankDiffMoveId then
		ZProj.TweenHelper.KillById(self._rankDiffMoveId)

		self._rankDiffMoveId = nil
	end
end

AergusiTaskItem.prefabPath = "ui/viewres/versionactivity_2_1/v2a1_aergusi/v2a1_aergusi_taskitem.prefab"

return AergusiTaskItem
