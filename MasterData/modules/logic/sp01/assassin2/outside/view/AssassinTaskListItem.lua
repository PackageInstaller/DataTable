-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinTaskListItem.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinTaskListItem", package.seeall)

local AssassinTaskListItem = class("AssassinTaskListItem", ListScrollCell)

function AssassinTaskListItem:init(go)
	self.viewGO = go
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self.txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self.txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self.txttaskdesc = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self.scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goRewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self.goFinished = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self.goDoing = gohelper.findChild(self.viewGO, "#go_normal/txt_finishing")
	self.btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self.goRunning = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_running", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self.btnFinishAll = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinTaskListItem:addEventListeners()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishAllOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnClickAllTaskFinish, self._OnClickAllTaskFinish, self)
end

function AssassinTaskListItem:removeEventListeners()
	self.btnNotFinish:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnClickAllTaskFinish, self._OnClickAllTaskFinish, self)
end

function AssassinTaskListItem:_btnNotFinishOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.AssassinTaskView)
		end
	end
end

function AssassinTaskListItem:_btnFinishAllOnClick()
	AssassinController.instance:dispatchEvent(AssassinEvent.OnClickAllTaskFinish)
end

AssassinTaskListItem.FinishKey = "AssassinTaskListItem FinishKey"

function AssassinTaskListItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(AssassinTaskListItem.FinishKey)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function AssassinTaskListItem:_OnClickAllTaskFinish()
	if self.taskMo then
		if self.taskMo.getAll then
			self:_btnFinishOnClick()
		else
			local isFinish = self.taskMo.finishCount < self.co.maxFinishCount and self.taskMo.hasFinished

			if isFinish then
				self:getAnimator():Play(UIAnimationName.Finish, 0, 0)
			end
		end
	end
end

function AssassinTaskListItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function AssassinTaskListItem:secondAnimationDone()
	UIBlockMgr.instance:endBlock(AssassinTaskListItem.FinishKey)
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.AssassinOutside, nil, nil, nil, nil, VersionActivity2_9Enum.ActivityId.Outside)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id)
	end
end

function AssassinTaskListItem:_editableInitView()
	self.rewardItemList = {}
end

function AssassinTaskListItem:onUpdateMO(taskMo)
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

function AssassinTaskListItem:refreshNormalUI()
	self.co = self.taskMo.config
	self.txttaskdesc.text = self.co.desc
	self.txtnum.text = self.taskMo.progress
	self.txttotal.text = self.co.maxProgress

	if self.taskMo.finishCount >= self.co.maxFinishCount then
		gohelper.setActive(self.goDoing, false)
		gohelper.setActive(self.btnNotFinish, false)
		gohelper.setActive(self.goRunning, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self.btnFinish, true)
		gohelper.setActive(self.btnNotFinish, false)
		gohelper.setActive(self.goDoing, false)
		gohelper.setActive(self.goRunning, false)
		gohelper.setActive(self.goFinished, false)
	else
		if self.co.jumpId ~= 0 then
			gohelper.setActive(self.btnNotFinish, true)
			gohelper.setActive(self.goDoing, false)
			gohelper.setActive(self.goRunning, false)
		else
			gohelper.setActive(self.btnNotFinish, false)
			gohelper.setActive(self.goDoing, true)
			gohelper.setActive(self.goRunning, true)
		end

		gohelper.setActive(self.goFinished, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
	end

	self:refreshRewardItems()
end

function AssassinTaskListItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	self.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self.goRewardContent)

			table.insert(self.rewardItemList, rewardItem)
		end

		rewardItem:setMOValue(type, id, quantity, nil, true)
		rewardItem:setCountFontSize(39)
		rewardItem:showStackableNum2()
		rewardItem:isShowEffect(true)
		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewardList + 1, #self.rewardItemList do
		gohelper.setActive(self.rewardItemList[i].go, false)
	end

	self.scrollReward.horizontalNormalizedPosition = 0
end

function AssassinTaskListItem:refreshGetAllUI()
	return
end

function AssassinTaskListItem:canGetReward()
	return self.taskMo.finishCount < self.co.maxFinishCount and self.taskMo.hasFinished
end

function AssassinTaskListItem:getAnimator()
	return self.animator
end

function AssassinTaskListItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

return AssassinTaskListItem
