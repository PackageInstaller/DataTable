-- chunkname: @modules/logic/versionactivity2_4/music/view/VersionActivity2_4MusicTaskItem.lua

module("modules.logic.versionactivity2_4.music.view.VersionActivity2_4MusicTaskItem", package.seeall)

local VersionActivity2_4MusicTaskItem = class("VersionActivity2_4MusicTaskItem", ListScrollCell)

function VersionActivity2_4MusicTaskItem:init(go)
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

function VersionActivity2_4MusicTaskItem:addEventListeners()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishAllOnClick, self)
end

function VersionActivity2_4MusicTaskItem:removeEventListeners()
	self.btnNotFinish:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
end

function VersionActivity2_4MusicTaskItem:_btnNotFinishOnClick()
	if self.co.jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if GameFacade.jump(self.co.jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity2_4MusicTaskView)
		end
	else
		ViewMgr.instance:closeView(ViewName.VersionActivity2_4MusicTaskView)
	end
end

function VersionActivity2_4MusicTaskItem:getAllPlayAnim()
	if self.taskMo.getAll or not self._showFinishedBtn then
		return
	end

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self._getAllPlayAnimDone, self)
end

function VersionActivity2_4MusicTaskItem:_getAllPlayAnimDone()
	self.animatorPlayer:Play(UIAnimationName.Idle)
	self:refreshNormalUI(true)
end

function VersionActivity2_4MusicTaskItem:_btnFinishAllOnClick()
	local list = self._view.viewContainer:getTaskItemList()

	for k, v in pairs(list) do
		v:getAllPlayAnim()
	end

	self:_btnFinishOnClick()
end

VersionActivity2_4MusicTaskItem.FinishKey = "VersionActivity2_4MusicTaskItem FinishKey"

function VersionActivity2_4MusicTaskItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(VersionActivity2_4MusicTaskItem.FinishKey)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function VersionActivity2_4MusicTaskItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function VersionActivity2_4MusicTaskItem:secondAnimationDone()
	UIBlockMgr.instance:endBlock(VersionActivity2_4MusicTaskItem.FinishKey)
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Activity179)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.taskMo.id)
	end
end

function VersionActivity2_4MusicTaskItem:_editableInitView()
	self.rewardItemList = {}
end

function VersionActivity2_4MusicTaskItem:onUpdateMO(taskMo)
	self.taskMo = taskMo
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject

	gohelper.setActive(self._gonormal, not self.taskMo.getAll)
	gohelper.setActive(self._gogetall, self.taskMo.getAll)

	self._showFinishedBtn = false

	if self.taskMo.getAll then
		self:refreshGetAllUI()
	else
		self:refreshNormalUI()
	end

	self._view.viewContainer:addTaskItem(self)
end

function VersionActivity2_4MusicTaskItem:refreshNormalUI(forceGetAward)
	self.co = lua_activity179_task.configDict[self.taskMo.id]
	self._maxFinishCount = 1
	self.txttaskdesc.text = self.co.desc
	self.txtnum.text = self.taskMo.progress
	self.txttotal.text = self.co.maxProgress
	self._showFinishedBtn = false

	if self.taskMo.finishCount >= self._maxFinishCount or forceGetAward then
		gohelper.setActive(self.goDoing, false)
		gohelper.setActive(self.btnNotFinish, false)
		gohelper.setActive(self.goRunning, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.hasFinished then
		self._showFinishedBtn = true

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
			gohelper.setActive(self.btnNotFinish, true)
			gohelper.setActive(self.goDoing, true)
			gohelper.setActive(self.goRunning, true)
		end

		gohelper.setActive(self.goFinished, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
	end

	self:refreshRewardItems()
end

function VersionActivity2_4MusicTaskItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = {}

	if tonumber(bonus) then
		local list = DungeonConfig.instance:getRewardItems(tonumber(bonus))

		for k, v in ipairs(list) do
			rewardList[k] = {
				v[1],
				v[2],
				v[3]
			}
		end
	else
		rewardList = ItemModel.instance:getItemDataListByConfigStr(bonus)
	end

	self.goRewardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self.goRewardContent)

			transformhelper.setLocalScale(rewardItem.go.transform, 1, 1, 1)
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

function VersionActivity2_4MusicTaskItem:refreshGetAllUI()
	return
end

function VersionActivity2_4MusicTaskItem:canGetReward()
	return self.taskMo.finishCount < self._maxFinishCount and self.taskMo.hasFinished
end

function VersionActivity2_4MusicTaskItem:getAnimator()
	return self.animator
end

function VersionActivity2_4MusicTaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
end

return VersionActivity2_4MusicTaskItem
