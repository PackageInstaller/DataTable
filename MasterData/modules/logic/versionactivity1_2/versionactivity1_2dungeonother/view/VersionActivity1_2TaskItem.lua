-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/view/VersionActivity1_2TaskItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2TaskItem", package.seeall)

local VersionActivity1_2TaskItem = class("VersionActivity1_2TaskItem", ListScrollCell)

function VersionActivity1_2TaskItem:init(go)
	self.viewGO = go
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._simageclickbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/click/bg")
	self.txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self.txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self.txttaskdesc = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self.scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goRewardContent = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	self.goFinished = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._simageallfinishbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#go_allfinish/bg")
	self.btnNotFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self.btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg", AudioEnum.UI.play_ui_task_slide)
	self.btnFinishAll = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall", AudioEnum.UI.play_ui_task_slide)
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	self.animatorPlayer:Play(UIAnimationName.Open)

	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_2TaskItem:addEventListeners()
	self.btnNotFinish:AddClickListener(self._btnNotFinishOnClick, self)
	self.btnFinish:AddClickListener(self._btnFinishOnClick, self)
	self.btnFinishAll:AddClickListener(self._btnFinishAllOnClick, self)
end

function VersionActivity1_2TaskItem:removeEventListeners()
	self.btnNotFinish:RemoveClickListener()
	self.btnFinish:RemoveClickListener()
	self.btnFinishAll:RemoveClickListener()
end

VersionActivity1_2TaskItem.ModeToColorDict = {
	Story3 = "#dc3736",
	Hard = "#dc3736",
	Story1 = "#cba167",
	Story2 = "#e67f33",
	Normal = "#abe66e"
}

function VersionActivity1_2TaskItem:_btnNotFinishOnClick()
	local jumpId = self.co.jumpId

	if jumpId ~= 0 then
		AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

		if VersionActivity1_2DungeonModel.instance:jump2DailyEpisode(jumpId) then
			return
		end

		if GameFacade.jump(jumpId) then
			ViewMgr.instance:closeView(ViewName.VersionActivity1_2TaskView)
		end
	end
end

function VersionActivity1_2TaskItem:_btnFinishAllOnClick()
	self:_btnFinishOnClick()
end

VersionActivity1_2TaskItem.FinishKey = "FinishKey"

function VersionActivity1_2TaskItem:_btnFinishOnClick()
	UIBlockMgr.instance:startBlock(VersionActivity1_2TaskItem.FinishKey)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self.firstAnimationDone, self)
end

function VersionActivity1_2TaskItem:firstAnimationDone()
	self._view.viewContainer.taskAnimRemoveItem:removeByIndex(self._index, self.secondAnimationDone, self)
end

function VersionActivity1_2TaskItem:secondAnimationDone()
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if self.taskMo.getAll then
		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.ActivityDungeon, nil, nil, nil, nil, VersionActivity1_2Enum.ActivityId.Dungeon)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.co.id)
	end

	UIBlockMgr.instance:endBlock(VersionActivity1_2TaskItem.FinishKey)
end

function VersionActivity1_2TaskItem:_editableInitView()
	self.rewardItemList = {}

	self._simageclickbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
	self._simageallfinishbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_diehei"))
end

function VersionActivity1_2TaskItem:onUpdateMO(taskMo)
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

function VersionActivity1_2TaskItem:refreshNormalUI()
	self._simagenormalbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_putong"))

	self.co = self.taskMo.config

	self:refreshDesc()

	self.txtnum.text = self.taskMo.progress
	self.txttotal.text = self.co.maxProgress

	if self.taskMo.finishCount >= self.co.maxFinishCount then
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
		gohelper.setActive(self.goFinished, true)
	elseif self.taskMo.hasFinished then
		gohelper.setActive(self.btnFinish.gameObject, true)
		gohelper.setActive(self.btnNotFinish.gameObject, false)
		gohelper.setActive(self.goFinished, false)
	else
		gohelper.setActive(self.btnNotFinish.gameObject, true)
		gohelper.setActive(self.goFinished, false)
		gohelper.setActive(self.btnFinish.gameObject, false)
	end

	self:refreshRewardItems()
end

function VersionActivity1_2TaskItem:refreshDesc()
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

	desc = string.gsub(desc, "(GLN%-%d+)", string.format("<color=%s>%s</color>", VersionActivity1_2TaskItem.ModeToColorDict.Normal, "%1"))

	if mode then
		desc = string.gsub(desc, "(%[.-%])", string.format("<color=%s>%s</color>", VersionActivity1_2TaskItem.ModeToColorDict[mode], "%1"))
	end

	self.txttaskdesc.text = desc
end

function VersionActivity1_2TaskItem:refreshRewardItems()
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

function VersionActivity1_2TaskItem:refreshGetAllUI()
	self._simagegetallbg:LoadImage(ResUrl.getVersionActivity1_2TaskImage("renwu_lingqu"))
end

function VersionActivity1_2TaskItem:canGetReward()
	return self.taskMo.finishCount < self.co.maxFinishCount and self.taskMo.hasFinished
end

function VersionActivity1_2TaskItem:getAnimator()
	return self.animator
end

function VersionActivity1_2TaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
	self._simagegetallbg:UnLoadImage()
	self._simageclickbg:UnLoadImage()
	self._simageallfinishbg:UnLoadImage()
end

return VersionActivity1_2TaskItem
