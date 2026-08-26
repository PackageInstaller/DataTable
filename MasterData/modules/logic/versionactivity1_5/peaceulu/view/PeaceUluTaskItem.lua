-- chunkname: @modules/logic/versionactivity1_5/peaceulu/view/PeaceUluTaskItem.lua

module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluTaskItem", package.seeall)

local PeaceUluTaskItem = class("PeaceUluTaskItem", ListScrollCellExtend)

function PeaceUluTaskItem:init(go)
	self.viewGO = go
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._gogame = gohelper.findChild(self.viewGO, "#go_game")
	self._gonormalbg = gohelper.findChild(self.viewGO, "#go_normal/#simage_normalbg")
	self._goactivitybg = gohelper.findChild(self.viewGO, "#go_normal/#go_activity")
	self.txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self.txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self.txttaskdesc = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self.scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goRewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	self.goFinished = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self.btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	self.btnRemove = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_removebg", AudioEnum.UI.play_ui_task_slide)
	self.btnFinishAll = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	self.btnGame = gohelper.findChildButton(self.viewGO, "#go_game/#btn_game")
	self.btnGameCanvasGroup = self.btnGame.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	self.txtgamedesc = gohelper.findChildText(self.viewGO, "#go_game/#txt_desc")
	self.txtgametimes = gohelper.findChildText(self.viewGO, "#go_game/#btn_game/times/#txt_times")
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animationStartTime = 0

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PeaceUluTaskItem:addEventListeners()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnRemove:AddClickListener(self._btnRemoveOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishAllOnClick, self)
	self.btnGame:AddClickListener(self._btnGameOnClick, self)
end

function PeaceUluTaskItem:removeEventListeners()
	self.btnNotFinish:RemoveClickListener()
	self.btnRemove:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
	self.btnGame:RemoveClickListener()
end

PeaceUluTaskItem.ModeToColorDict = {
	Story3 = "#dc3736",
	Hard = "#dc3736",
	Story1 = "#cba167",
	Story2 = "#e67f33",
	Normal = "#abe66e"
}

function PeaceUluTaskItem:_btnGameOnClick()
	self:_playGame()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function PeaceUluTaskItem:_playGame()
	local canplay = PeaceUluModel.instance:checkCanPlay()

	if not canplay then
		return
	end

	PeaceUluController.instance:dispatchEvent(PeaceUluEvent.onSwitchTab, PeaceUluEnum.TabIndex.Game)
end

function PeaceUluTaskItem:_btnNotFinishOnClick()
	local jumpId = self.co.jumpId

	if jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if jumpId == 10011507 then
			self:_playGame()
		else
			GameFacade.jump(jumpId)
		end
	end
end

function PeaceUluTaskItem:_btnRemoveOnClick()
	if PeaceUluModel.instance:checkCanRemove() then
		self:_btnFinishOnClick()
	end
end

function PeaceUluTaskItem:_btnFinishAllOnClick()
	self:_btnFinishOnClick()
end

PeaceUluTaskItem.FinishKey = "FinishKey"

function PeaceUluTaskItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(PeaceUluTaskItem.FinishKey)

	self.animator.enabled = true
	self.animator.speed = 1

	self.animator:Play(UIAnimationName.Finish)
	self:firstAnimationDone()
end

function PeaceUluTaskItem:firstAnimationDone()
	TaskDispatcher.runDelay(self.secondAnimationDone, self, PeaceUluEnum.TaskMaskTime)
	self._view.viewContainer:dispatchEvent(PeaceUluEvent.onFinishTask, self._index)
end

function PeaceUluTaskItem:secondAnimationDone()
	TaskDispatcher.cancelTask(self.secondAnimationDone, self)
	self.animator:Play(UIAnimationName.Idle)

	local function callback()
		self.animator:Play(UIAnimationName.Idle)
	end

	if PeaceUluModel.instance:checkCanRemove() and not self.taskMo.hasFinished then
		PeaceUluRpc.instance:sendAct145RemoveTaskRequest(VersionActivity1_5Enum.ActivityId.PeaceUlu, self.taskId, callback, self)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id, callback, self)
	end

	UIBlockMgr.instance:endBlock(PeaceUluTaskItem.FinishKey)
end

function PeaceUluTaskItem:_editableInitView()
	self.rewardItemList = {}
end

function PeaceUluTaskItem:onUpdateMO(taskMo)
	self.taskMo = taskMo
	self.firstOpen = taskMo.firstOpen
	self.taskId = self.taskMo.id
	self.animator.enabled = true
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject

	gohelper.setActive(self._gonormal, not self.taskMo.isGame)
	gohelper.setActive(self._gogame, self.taskMo.isGame)

	if self.taskMo.isGame then
		self:refreshGameUI()
	else
		self:refreshNormalUI()
	end

	if self.firstOpen then
		if taskMo.isupdate then
			self._animationStartTime = Time.time
		end

		self:_refreshOpenAnimation()

		taskMo.isupdate = false
	end
end

function PeaceUluTaskItem:refreshGameUI()
	local num = PeaceUluConfig.instance:getGameTimes()
	local haveTimes = PeaceUluModel.instance:getGameHaveTimes()

	self._cannotPlay = haveTimes == 0
	self.txtgametimes.text = string.format("<color=#DB8542>%s</color>", haveTimes) .. "/" .. num

	if PeaceUluModel.instance:checkGetAllReward() then
		gohelper.setActive(self.btnGame.gameObject, true)

		self.txtgamedesc.text = luaLang("p_v1a5_peaceulu_taskitem_getallreward")
	else
		gohelper.setActive(self.btnGame.gameObject, not PeaceUluModel.instance:checkCanRemove())

		self.txtgamedesc.text = PeaceUluModel.instance:checkCanRemove() and string.format(luaLang("v1a5_peaceulu_mainview_times"), PeaceUluModel.instance:getRemoveNum()) or self._cannotPlay and not PeaceUluTaskModel.instance:checkAllTaskFinished() and luaLang("p_v1a5_peaceulu_taskitem_statusdesc") or self._cannotPlay and PeaceUluTaskModel.instance:checkAllTaskFinished() and luaLang("p_v1a5_peaceulu_taskitem_statusdesczero") or luaLang("p_v1a5_peaceulu_taskitem_gamedesc")
	end
end

function PeaceUluTaskItem:refreshNormalUI()
	self.co = self.taskMo.config

	if not self.co then
		return
	end

	local isDaily = self.taskMo.config.loopType == 1

	gohelper.setActive(self._gonormalbg, not isDaily)
	gohelper.setActive(self._goactivitybg, isDaily)
	self:refreshDesc()

	self.txtnum.text = self.taskMo.progress
	self.txttotal.text = self.co.maxProgress

	if PeaceUluModel.instance:checkGetAllReward() then
		gohelper.setActive(self.btnRemove.gameObject, false)
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.finishCount > 0 then
		gohelper.setActive(self.btnRemove.gameObject, false)
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self.btnRemove.gameObject, false)
		gohelper.setActive(self.btnFinish.gameObject, true)
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.goFinished, false)
	elseif PeaceUluModel.instance:checkCanRemove() and self.co.canRemove == 1 then
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, false)
		gohelper.setActive(self.btnRemove.gameObject, true)
	else
		gohelper.setActive(self.btnNotFinish.gameObject, true)
		gohelper.setActive(self.goFinished, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.btnRemove.gameObject, false)
	end

	self:refreshRewardItems()
end

function PeaceUluTaskItem:refreshDesc()
	if not self.co then
		return
	end

	local modeStr = string.match(self.co.desc, "%[(.-)%]")
	local mode

	if not string.nilorempty(modeStr) then
		if modeStr == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story1]) then
			mode = "Story1"
		elseif modeStr == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story2]) then
			mode = "Story2"
		elseif modeStr == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Story3]) then
			mode = "Story3"
		elseif modeStr == luaLang(VersionActivityDungeonBaseEnum.ChapterModeNameKey[VersionActivityDungeonBaseEnum.DungeonMode.Hard]) then
			mode = "Hard"
		end
	end

	local desc = self.co.desc

	desc = string.gsub(desc, "(GLN%-%d+)", string.format("<color=%s>%s</color>", PeaceUluTaskItem.ModeToColorDict.Normal, "%1"))

	if mode then
		desc = string.gsub(desc, "(%[.-%])", string.format("<color=%s>%s</color>", PeaceUluTaskItem.ModeToColorDict[mode], "%1"))
	end

	desc = string.format(desc, self.co.maxProgress)
	self.txttaskdesc.text = desc
end

function PeaceUluTaskItem:refreshRewardItems()
	local bonus = self.co.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self.rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self.goRewardContent)

			transformhelper.setLocalScale(rewardItem.go.transform, 0.62, 0.62, 1)
			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(40)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			table.insert(self.rewardItemList, rewardItem)
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

function PeaceUluTaskItem:_refreshOpenAnimation()
	if not self.animator or not self.animator.gameObject.activeInHierarchy then
		return
	end

	if self.firstOpen then
		local openAnimTime = self:_getAnimationTime()

		self.animator.speed = 1

		if self.taskMo.isGame and self._cannotPlay then
			self.animator:Play("open1", 0, 0)
		else
			self.animator:Play("open", 0, 0)
		end

		self.animator:Update(0)

		local currentAnimatorStateInfo = self.animator:GetCurrentAnimatorStateInfo(0)
		local length = currentAnimatorStateInfo.length

		if length <= 0 then
			length = 1
		end

		if self.taskMo.isGame and self._cannotPlay then
			self.animator:Play("open1", 0, (Time.time - openAnimTime) / length)
		else
			self.animator:Play("open", 0, (Time.time - openAnimTime) / length)
		end

		self.animator:Update(0)
	elseif self.taskMo.isGame and self._cannotPlay then
		self.animator:Play("idle1", 0, 0)
	else
		self.animator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function PeaceUluTaskItem:_getAnimationTime()
	if not self._animationStartTime then
		return nil
	end

	local delayTime = 0.06

	self._animationDelayTimes = delayTime * self._index

	return self._animationStartTime + self._animationDelayTimes
end

function PeaceUluTaskItem:refreshGetAllUI()
	return
end

function PeaceUluTaskItem:canGetReward()
	return self.taskMo.finishCount < self.co.maxProgress and self.taskMo.hasFinished
end

function PeaceUluTaskItem:getAnimator()
	return self.animator
end

function PeaceUluTaskItem:onDestroyView()
	UIBlockMgr.instance:endBlock(PeaceUluTaskItem.FinishKey)
	TaskDispatcher.cancelTask(self._opencallack, self)
	TaskDispatcher.cancelTask(self.secondAnimationDone, self)
end

return PeaceUluTaskItem
