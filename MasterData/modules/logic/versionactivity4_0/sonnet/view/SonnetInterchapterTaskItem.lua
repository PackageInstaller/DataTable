-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterTaskItem.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterTaskItem", package.seeall)

local SonnetInterchapterTaskItem = class("SonnetInterchapterTaskItem", ListScrollCellExtend)

function SonnetInterchapterTaskItem:onInitView()
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
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SonnetInterchapterTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self.addEventCb(self, SonnetInterchapterController.instance, SonnetInterchapterEvent.OnClickAllTaskFinish, self._OnClickAllTaskFinish, self)
end

function SonnetInterchapterTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	self.removeEventCb(self, SonnetInterchapterController.instance, SonnetInterchapterEvent.OnClickAllTaskFinish, self._OnClickAllTaskFinish, self)
end

function SonnetInterchapterTaskItem:_btnnotfinishbgOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.SonnetInterchapterTaskView)
		end
	end
end

function SonnetInterchapterTaskItem:_btngetallOnClick()
	SonnetInterchapterController.instance:dispatchEvent(SonnetInterchapterEvent.OnClickAllTaskFinish)
end

SonnetInterchapterTaskItem.FinishKey = "SonnetInterchapterTaskItem_FinishKey"

function SonnetInterchapterTaskItem:_btnfinishbgOnClick()
	UIBlockMgr.instance:startBlock(SonnetInterchapterTaskItem.FinishKey)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function SonnetInterchapterTaskItem:_OnClickAllTaskFinish()
	if self.taskMo then
		if self.taskMo.getAll then
			self:_btnfinishbgOnClick()
		else
			local isFinish = self.taskMo.finishCount < ((not self.co.maxFinishCount or nil) and 1) and self.taskMo.hasFinished

			if isFinish then
				self:getAnimator():Play(UIAnimationName.Finish, 0, 0)
			end
		end
	end
end

function SonnetInterchapterTaskItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function SonnetInterchapterTaskItem:secondAnimationDone()
	UIBlockMgr.instance:endBlock(SonnetInterchapterTaskItem.FinishKey)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.SonnetInterchapter)
	else
		self.animatorPlayer:Play(UIAnimationName.Idle)
		TaskRpc.instance:sendFinishTaskRequest(self.co.id)
	end
end

function SonnetInterchapterTaskItem:_editableInitView()
	self.rewardItemList = {}
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self.scrollReward = self._scrollrewards.gameObject:GetComponent(typeof(ZProj.LimitedScrollRect))
end

function SonnetInterchapterTaskItem:onUpdateMO(taskMo)
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

function SonnetInterchapterTaskItem:refreshNormalUI()
	self.co = self.taskMo.config
	self._txttaskdes.text = self.co.desc
	self._txtnum.text = self.taskMo.progress
	self._txttotal.text = self.co.maxProgress

	if (self.co.maxFinishCount or 1) <= self.taskMo.finishCount then
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
		gohelper.setActive(self._goallfinish, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._goallfinish, false)
	else
		if self.co.jumpId ~= 0 then
			gohelper.setActive(self._btnnotfinishbg.gameObject, true)
		else
			gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	end

	self:refreshRewardItems()
end

function SonnetInterchapterTaskItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = DungeonConfig.instance:getRewardItems(tonumber(bonus))

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

function SonnetInterchapterTaskItem:refreshGetAllUI()
	return
end

function SonnetInterchapterTaskItem:canGetReward()
	return self.taskMo.finishCount < ((not self.co.maxFinishCount or nil) and 1) and self.taskMo.hasFinished
end

function SonnetInterchapterTaskItem:getAnimator()
	return self.animator
end

function SonnetInterchapterTaskItem:onSelect(isSelect)
	return
end

function SonnetInterchapterTaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
end

return SonnetInterchapterTaskItem
