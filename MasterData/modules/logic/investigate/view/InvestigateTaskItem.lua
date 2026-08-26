-- chunkname: @modules/logic/investigate/view/InvestigateTaskItem.lua

module("modules.logic.investigate.view.InvestigateTaskItem", package.seeall)

local InvestigateTaskItem = class("InvestigateTaskItem", ListScrollCell)

function InvestigateTaskItem:init(go)
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
	self.btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self.goRunning = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#go_running")
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self.btnFinishAll = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall/#btn_getall")
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateTaskItem:addEventListeners()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishAllOnClick, self)
end

function InvestigateTaskItem:removeEventListeners()
	self.btnNotFinish:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
end

function InvestigateTaskItem:_btnNotFinishOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			-- block empty
		end
	end
end

function InvestigateTaskItem:_btnFinishAllOnClick()
	self:_btnFinishOnClick()
end

InvestigateTaskItem.FinishKey = "InvestigateTaskItem FinishKey"

function InvestigateTaskItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(InvestigateTaskItem.FinishKey)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function InvestigateTaskItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function InvestigateTaskItem:secondAnimationDone()
	UIBlockMgr.instance:endBlock(InvestigateTaskItem.FinishKey)
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Investigate)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.taskId)
	end
end

function InvestigateTaskItem:_editableInitView()
	self.rewardItemList = {}
end

function InvestigateTaskItem:onUpdateMO(taskMo)
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

function InvestigateTaskItem:refreshNormalUI()
	self.co = lua_investigate_reward.configDict[self.taskMo.id]
	self._maxFinishCount = 1
	self.txttaskdesc.text = self.co.desc
	self.txtnum.text = self.taskMo.progress
	self.txttotal.text = self.co.maxProgress

	if self.taskMo.finishCount >= self._maxFinishCount then
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

function InvestigateTaskItem:refreshRewardItems()
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

			transformhelper.setLocalScale(rewardItem.go.transform, 1, 1, 1)
			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(26)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			table.insert(self.rewardItemList, rewardItem)

			local countBg = rewardItem:getItemIcon():getCountBg()
			local count = rewardItem:getItemIcon():getCount()

			transformhelper.setLocalScale(countBg.transform, 1, 1.5, 1)
			transformhelper.setLocalScale(count.transform, 1.5, 1.5, 1)
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

function InvestigateTaskItem:refreshGetAllUI()
	return
end

function InvestigateTaskItem:canGetReward()
	return self.taskMo.finishCount < self._maxFinishCount and self.taskMo.hasFinished
end

function InvestigateTaskItem:getAnimator()
	return self.animator
end

function InvestigateTaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

return InvestigateTaskItem
