-- chunkname: @modules/logic/versionactivity1_5/act142/view/Activity142TaskItem.lua

module("modules.logic.versionactivity1_5.act142.view.Activity142TaskItem", package.seeall)

local Activity142TaskItem = class("Activity142TaskItem", ListScrollCellExtend)
local GET_REWARD_ANIMATION_TIME = 0.2

function Activity142TaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	self._scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142TaskItem:addEvents()
	Activity142Controller.instance:registerCallback(Activity142Event.OneClickClaimReward, self._onOneClickClaimReward, self)
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function Activity142TaskItem:removeEvents()
	Activity142Controller.instance:unregisterCallback(Activity142Event.OneClickClaimReward, self._onOneClickClaimReward, self)
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function Activity142TaskItem:_onOneClickClaimReward()
	if self._taskMO:haveRewardToGet() then
		self._playFinishAnim = true

		self._animator:Play("finish", 0, 0)
	end
end

function Activity142TaskItem:_btnnotfinishbgOnClick()
	if not self._taskMO then
		return
	end

	local episodeId = self._taskMO.config.episodeId
	local actId = Activity142Model.instance:getActivityId()
	local isOpen = Activity142Model.instance:isEpisodeOpen(actId, episodeId)

	if isOpen then
		Activity142Controller.instance:dispatchEvent(Activity142Event.ClickEpisode, episodeId)
	else
		Activity142Helper.showToastByEpisodeId(episodeId)
	end
end

function Activity142TaskItem:_btnfinishbgOnClick()
	Activity142Controller.instance:delayRequestGetReward(GET_REWARD_ANIMATION_TIME, self._taskMO)
	self:_onOneClickClaimReward()
end

function Activity142TaskItem:_btngetallOnClick()
	Activity142Controller.instance:delayRequestGetReward(GET_REWARD_ANIMATION_TIME, self._taskMO)
	Activity142Controller.instance:dispatchAllTaskItemGotReward()
end

function Activity142TaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(Va3ChessEnum.ComponentType.Animator)
end

function Activity142TaskItem:getAnimator()
	return self._animator
end

function Activity142TaskItem:onUpdateMO(mo)
	self._taskMO = mo
	self._scrollReward.parentGameObject = self._view._csListScroll.gameObject
	self._scrollReward.horizontalNormalizedPosition = 0

	self:_refreshUI()
end

function Activity142TaskItem:_refreshUI()
	local taskMO = self._taskMO

	if not taskMO then
		return
	end

	local isNormal = taskMO.id ~= Activity142Enum.TASK_ALL_RECEIVE_ITEM_EMPTY_ID

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if not isNormal then
		return
	end

	if self._playFinishAnim then
		self._playFinishAnim = false

		self._animator:Play("idle", 0, 1)
	end

	gohelper.setActive(self._btnfinishbg, false)
	gohelper.setActive(self._goallfinish, false)
	gohelper.setActive(self._btnnotfinishbg, false)

	if taskMO:isFinished() then
		gohelper.setActive(self._btnfinishbg, true)
	elseif taskMO:alreadyGotReward() then
		gohelper.setActive(self._goallfinish, true)
	else
		gohelper.setActive(self._btnnotfinishbg, true)
	end

	self._txtnum.text = taskMO:getProgress()
	self._txttotal.text = taskMO:getMaxProgress()

	if taskMO.config then
		self._txttaskdes.text = taskMO.config.desc or ""
	end

	local item_list = ItemModel.instance:getItemDataListByConfigStr(taskMO.config.bonus)

	IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)
end

function Activity142TaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function Activity142TaskItem:onDestroyView()
	return
end

return Activity142TaskItem
