-- chunkname: @modules/logic/versionactivity3_6/yami/view/task/V3a6YaMiTaskItem.lua

module("modules.logic.versionactivity3_6.yami.view.task.V3a6YaMiTaskItem", package.seeall)

local V3a6YaMiTaskItem = class("V3a6YaMiTaskItem", ListScrollCellExtend)

function V3a6YaMiTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._gotype1 = gohelper.findChild(self.viewGO, "#go_normal/#go_type1")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/#go_type1/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/#go_type1/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#go_type1/#txt_taskdes")
	self._gotype2 = gohelper.findChild(self.viewGO, "#go_normal/#go_type2")
	self._txtleveltext = gohelper.findChildText(self.viewGO, "#go_normal/#go_type2/#txt_leveltext")
	self._txtlevelnum = gohelper.findChildText(self.viewGO, "#go_normal/#go_type2/#txt_levelnum")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnjump = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_jump")
	self._btnget = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_get")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiTaskItem:addEvents()
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.OnClickAllTaskFinish, self._OnClickAllTaskFinish, self)
end

function V3a6YaMiTaskItem:removeEvents()
	self._btnjump:RemoveClickListener()
	self._btnget:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.OnClickAllTaskFinish, self._OnClickAllTaskFinish, self)
end

function V3a6YaMiTaskItem:_btnjumpOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.V3a6YaMiTaskView)
		end
	end
end

function V3a6YaMiTaskItem:_btngetallOnClick()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.OnClickAllTaskFinish)
end

V3a6YaMiTaskItem.FinishKey = "V3a6YaMiTaskItem_FinishKey"

function V3a6YaMiTaskItem:_btngetOnClick()
	UIBlockMgr.instance:startBlock(V3a6YaMiTaskItem.FinishKey)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function V3a6YaMiTaskItem:_OnClickAllTaskFinish()
	if self.taskMo then
		if self.taskMo.getAll then
			self:_btngetOnClick()
		else
			local isFinish = self.taskMo.finishCount < ((not self.co.maxFinishCount or nil) and 1) and self.taskMo.hasFinished

			if isFinish then
				self:getAnimator():Play(UIAnimationName.Finish, 0, 0)
			end
		end
	end
end

function V3a6YaMiTaskItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function V3a6YaMiTaskItem:secondAnimationDone()
	UIBlockMgr.instance:endBlock(V3a6YaMiTaskItem.FinishKey)
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Act231)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id)
	end
end

function V3a6YaMiTaskItem:_editableInitView()
	self.rewardItemList = {}
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.scrollReward = self._scrollrewards.gameObject:GetComponent(typeof(ZProj.LimitedScrollRect))
end

function V3a6YaMiTaskItem:onUpdateMO(taskMo)
	self.taskMo = taskMo
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject

	gohelper.setActive(self._gonormal, not self.taskMo.getAll)
	gohelper.setActive(self._gogetall, self.taskMo.getAll)

	if self.taskMo.getAll then
		self:refreshGetAllUI()
	else
		self:refreshNormalUI()
	end
end

function V3a6YaMiTaskItem:refreshNormalUI()
	self.co = self.taskMo.config
	self._txttaskdes.text = self.co.desc
	self._txtnum.text = self.taskMo.progress
	self._txttotal.text = self.co.maxProgress

	if (self.co.maxFinishCount or 1) <= self.taskMo.finishCount then
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnjump.gameObject, false)
		gohelper.setActive(self._btnget.gameObject, false)
		gohelper.setActive(self._goallfinish, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self._btnget, true)
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnjump.gameObject, false)
		gohelper.setActive(self._goallfinish, false)
	else
		if self.co.jumpId ~= 0 then
			gohelper.setActive(self._goallfinish, true)
			gohelper.setActive(self._btnjump.gameObject, true)
		else
			gohelper.setActive(self._goallfinish, false)
			gohelper.setActive(self._btnjump.gameObject, false)
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnget.gameObject, false)
	end

	self:refreshRewardItems()
end

function V3a6YaMiTaskItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	self._gorewards:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gorewards)

			transformhelper.setLocalScale(rewardItem.go.transform, 1, 1, 1)
			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(26)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			table.insert(self.rewardItemList, rewardItem)

			if type == MaterialEnum.MaterialType.item then
				local countBg = rewardItem:getItemIcon():getCountBg()
				local count = rewardItem:getItemIcon():getCount()

				transformhelper.setLocalScale(countBg.transform, 1, 1.5, 1)
				transformhelper.setLocalScale(count.transform, 1.5, 1.5, 1)
			end
		else
			rewardItem:setMOValue(type, id, quantity, nil, true)
		end

		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewardList + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end

	self.scrollReward.horizontalNormalizedPosition = 0
end

function V3a6YaMiTaskItem:refreshGetAllUI()
	return
end

function V3a6YaMiTaskItem:canGetReward()
	return self.taskMo.finishCount < ((not self.co.maxFinishCount or nil) and 1) and self.taskMo.hasFinished
end

function V3a6YaMiTaskItem:getAnimator()
	return self.animator
end

function V3a6YaMiTaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
end

return V3a6YaMiTaskItem
