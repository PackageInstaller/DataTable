-- chunkname: @modules/logic/tower/view/permanenttower/TowerDeepTaskItem.lua

module("modules.logic.tower.view.permanenttower.TowerDeepTaskItem", package.seeall)

local TowerDeepTaskItem = class("TowerDeepTaskItem", ListScrollCellExtend)

function TowerDeepTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._goscrollRewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewardContent")
	self._btnnormal = gohelper.findChild(self.viewGO, "#go_normal/#btn_normal")
	self._btncanget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_canget")
	self._gohasget = gohelper.findChild(self.viewGO, "#go_normal/#go_hasget")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerDeepTaskItem:addEvents()
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function TowerDeepTaskItem:removeEvents()
	self._btncanget:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

TowerDeepTaskItem.BlockKey = "TowerDeepTaskItemRewardGetAnim"
TowerDeepTaskItem.TaskMaskTime = 0.65

function TowerDeepTaskItem:_btnnormalOnClick()
	if not self.jumpId or self.jumpId == 0 then
		return
	end

	GameFacade.jump(self.jumpId)
end

function TowerDeepTaskItem:_btncangetOnClick()
	if not self.taskId and not self.mo.canGetAll then
		return
	end

	self._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(TowerDeepTaskItem.BlockKey)
	TowerController.instance:dispatchEvent(TowerEvent.OnDeepTaskRewardGetFinish, self._index)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, TowerDeepTaskItem.TaskMaskTime)
end

function TowerDeepTaskItem:_btngetallOnClick()
	self:_btncangetOnClick()
end

function TowerDeepTaskItem:_onPlayActAniFinished()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.mo.canGetAll then
		local canGetIdList = TowerDeepTaskModel.instance:getAllCanGetList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.TowerPermanentDeep, 0, canGetIdList, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	end

	UIBlockMgr.instance:endBlock(TowerDeepTaskItem.BlockKey)
end

function TowerDeepTaskItem:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._scrollrewards = self._goscrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
end

function TowerDeepTaskItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo
	self._scrollrewards.parentGameObject = self._view._csListScroll.gameObject

	if self.mo.canGetAll then
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._gogetall, true)
	else
		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._gogetall, false)
		self:refreshNormal()
	end
end

function TowerDeepTaskItem:refreshNormal()
	self.taskId = self.mo.id
	self.config = self.mo.config
	self.jumpId = self.config.jumpId
	self._txttaskdes.text = self.config.desc

	self:refreshReward()
	self:refreshState()
end

function TowerDeepTaskItem:refreshReward()
	local config = self.mo.config
	local rewardList = GameUtil.splitString2(config.bonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gorewardContent)
			}
			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.itemIcon:setMOValue(rewardData[1], rewardData[2], rewardData[3])
		rewardItem.itemIcon:isShowCount(true)
		rewardItem.itemIcon:setCountFontSize(40)
		rewardItem.itemIcon:showStackableNum2()
		rewardItem.itemIcon:setHideLvAndBreakFlag(true)
		rewardItem.itemIcon:hideEquipLvAndBreak(true)
		gohelper.setActive(rewardItem.itemIcon.go, true)
	end

	for index = #rewardList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.itemIcon.go, false)
		end
	end
end

function TowerDeepTaskItem:refreshState()
	if TowerDeepTaskModel.instance:isTaskFinished(self.mo) then
		gohelper.setActive(self._gohasget, true)
		gohelper.setActive(self._btnnormal.gameObject, false)
		gohelper.setActive(self._btncanget.gameObject, false)
	elseif self.mo.hasFinished then
		gohelper.setActive(self._gohasget, false)
		gohelper.setActive(self._btnnormal.gameObject, false)
		gohelper.setActive(self._btncanget.gameObject, true)
	else
		gohelper.setActive(self._gohasget, false)
		gohelper.setActive(self._btnnormal.gameObject, true)
		gohelper.setActive(self._btncanget.gameObject, false)
	end
end

function TowerDeepTaskItem:getAnimator()
	return self._animator
end

function TowerDeepTaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.rewardItemTab then
		for _, item in pairs(self.rewardItemTab) do
			if item.itemIcon then
				item.itemIcon:onDestroy()

				item.itemIcon = nil
			end
		end

		self.rewardItemTab = nil
	end

	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)
end

return TowerDeepTaskItem
