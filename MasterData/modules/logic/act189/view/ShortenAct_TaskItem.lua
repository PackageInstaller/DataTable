-- chunkname: @modules/logic/act189/view/ShortenAct_TaskItem.lua

module("modules.logic.act189.view.ShortenAct_TaskItem", package.seeall)

local ShortenAct_TaskItem = class("ShortenAct_TaskItem", ListScrollCellExtend)

function ShortenAct_TaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._golimit = gohelper.findChild(self.viewGO, "#go_normal/#go_limit")
	self._txtlimittext = gohelper.findChildText(self.viewGO, "#go_normal/#go_limit/limitinfobg/#txt_limittext")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ShortenAct_TaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
end

function ShortenAct_TaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
end

local sf = string.format

function ShortenAct_TaskItem:initInternal(...)
	ShortenAct_TaskItem.super.initInternal(self, ...)

	self.scrollReward = self._scrollrewardsGo:GetComponent(typeof(ZProj.LimitedScrollRect))
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject
end

function ShortenAct_TaskItem:_btnnotfinishbgOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_resources_open)

	local mo = self._mo
	local config = mo.config
	local jumpId = config.jumpId
	local taskId = config.id

	if jumpId == 0 then
		return
	end

	if self._isLimit then
		self:_showToast()

		return
	end

	if GameFacade.jump(jumpId) then
		if ViewMgr.instance:isOpen(ViewName.ShortenAct_PanelView) then
			ViewMgr.instance:closeView(ViewName.ShortenAct_PanelView)
		end

		Activity189Controller.instance:trySendFinishReadTaskRequest_jump(taskId)
	end
end

local kBlock = "ShortenAct_TaskItem:_btnfinishbgOnClick()"

function ShortenAct_TaskItem:_btnfinishbgOnClick()
	UIBlockMgr.instance:startBlock(kBlock)

	self.animator.speed = 1

	self.animatorPlayer:Play(UIAnimationName.Finish, self._firstAnimationDone, self)
end

function ShortenAct_TaskItem:_editableInitView()
	self._rewardItemList = {}
	self._btnnotfinishbgGo = self._btnnotfinishbg.gameObject
	self._btnfinishbgGo = self._btnfinishbg.gameObject
	self._goallfinishGo = self._goallfinish.gameObject
	self._scrollrewardsGo = self._scrollrewards.gameObject
	self._gorewardsContentFilter = gohelper.onceAddComponent(self._gorewards, typeof(UnityEngine.UI.ContentSizeFitter))
	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self.animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ShortenAct_TaskItem:onDestroyView()
	self._simagenormalbg:UnLoadImage()
end

function ShortenAct_TaskItem:_viewContainer()
	return self._view.viewContainer
end

function ShortenAct_TaskItem:getAnimator()
	return self.animator
end

function ShortenAct_TaskItem:onUpdateMO(mo)
	self._mo = mo

	if mo.getAll then
		self:_refreshGetAllUI()
	else
		self:_refreshNormalUI()
	end
end

function ShortenAct_TaskItem:_refreshGetAllUI()
	return
end

function ShortenAct_TaskItem:_isReadTask()
	local mo = self._mo
	local CO = mo.config

	return CO.listenerType == "ReadTask"
end

function ShortenAct_TaskItem:_getProgressReadTask()
	local mo = self._mo

	return 0
end

function ShortenAct_TaskItem:_getMaxProgressReadTask()
	return 1
end

function ShortenAct_TaskItem:_refreshNormalUI()
	local mo = self._mo
	local CO = mo.config
	local progress = mo.progress
	local maxProgress = CO.maxProgress
	local openLimitActId = CO.openLimitActId
	local jumpId = CO.jumpId
	local jumpConfig = JumpConfig.instance:getJumpConfig(jumpId)

	if self:_isReadTask() then
		progress = self:_getProgressReadTask()
		maxProgress = self:_getMaxProgressReadTask()
	end

	local isClaimable = mo:isClaimable()

	self._txttaskdes.text = CO.desc

	gohelper.setActive(self._btnnotfinishbgGo, mo:isUnfinished())
	gohelper.setActive(self._goallfinishGo, mo:isClaimed())
	gohelper.setActive(self._btnfinishbgGo, isClaimable)
	self:_setActive_limite(false)

	local isLimited = false

	if openLimitActId > 0 then
		local actStatus, toastId, toastParamList = ActivityHelper.getActivityStatusAndToast(openLimitActId, true)

		isLimited = actStatus ~= ActivityEnum.ActivityStatus.Normal

		self:_setActive_limite(isLimited)

		if actStatus == ActivityEnum.ActivityStatus.NotOpen then
			local actMO = Activity189Model.instance:getActMO(openLimitActId)
			local remainTimeSec = actMO:getRealStartTimeStamp() - ServerTime.now()

			self._txtlimittext.text = sf(luaLang("ShortenAct_TaskItem_remain_open"), TimeUtil.getFormatTime(remainTimeSec))
			self._limitDesc = self:_getStrByToast(ToastEnum.ActivityNotOpen)
		elseif actStatus == ActivityEnum.ActivityStatus.Expired or actStatus == ActivityEnum.ActivityStatus.NotOnLine or actStatus == ActivityEnum.ActivityStatus.None then
			self:_setLimitDesc(luaLang("turnback_end"))
		elseif actStatus == ActivityEnum.ActivityStatus.NotUnlock then
			self:_setLimitTextByToast(toastId, toastParamList)
		end
	end

	if jumpConfig and not isLimited then
		local canJump, toastId, toastParamList = JumpController.instance:canJumpNew(jumpConfig.param)

		isLimited = not canJump

		self:_setActive_limite(not canJump)
		self:_setLimitTextByToast(toastId, toastParamList)
	end

	GameUtil.loadSImage(self._simagenormalbg, ResUrl.getShortenActSingleBg(isClaimable and "shortenact_taskitembg2" or "shortenact_taskitembg1"))
	self:_refreshRewardItems()
end

function ShortenAct_TaskItem:_showToast()
	ToastController.instance:showToastWithString(self._limitDesc)
end

function ShortenAct_TaskItem:_setLimitDesc(str)
	str = str or ""
	self._txtlimittext.text = str
	self._limitDesc = str
end

function ShortenAct_TaskItem:_getStrByToast(toastId, toastParamList)
	return ToastController.instance:getToastMsgWithTableParam(toastId, toastParamList)
end

function ShortenAct_TaskItem:_setLimitTextByToast(toastId, toastParamList)
	self:_setLimitDesc(self:_getStrByToast(toastId, toastParamList))
end

function ShortenAct_TaskItem:_refreshRewardItems()
	local mo = self._mo
	local CO = mo.config
	local bonus = CO.bonus

	if string.nilorempty(bonus) then
		gohelper.setActive(self.scrollReward.gameObject, false)

		return
	end

	gohelper.setActive(self.scrollReward.gameObject, true)

	local rewardList = GameUtil.splitString2(bonus, true, "|", "#")

	self._gorewardsContentFilter.enabled = #rewardList > 2

	for index, rewardArr in ipairs(rewardList) do
		local type, id, quantity = rewardArr[1], rewardArr[2], rewardArr[3]
		local rewardItem = self._rewardItemList[index]

		if not rewardItem then
			rewardItem = IconMgr.instance:getCommonPropItemIcon(self._gorewards)

			rewardItem:setMOValue(type, id, quantity, nil, true)
			rewardItem:setCountFontSize(26)
			rewardItem:showStackableNum2()
			rewardItem:isShowEffect(true)
			table.insert(self._rewardItemList, rewardItem)

			local itemIcon = rewardItem:getItemIcon()

			if itemIcon.getCountBg then
				local countBg = itemIcon:getCountBg()

				transformhelper.setLocalScale(countBg.transform, 1, 1.5, 1)
			end

			if itemIcon.getCount then
				local count = itemIcon:getCount()

				transformhelper.setLocalScale(count.transform, 1.5, 1.5, 1)
			end
		else
			rewardItem:setMOValue(type, id, quantity, nil, true)
		end

		gohelper.setActive(rewardItem.go, true)
	end

	for i = #rewardList + 1, #self._rewardItemList do
		gohelper.setActive(self._rewardItemList[i].go, false)
	end

	self.scrollReward.horizontalNormalizedPosition = 0
end

function ShortenAct_TaskItem:_firstAnimationDone()
	local c = self:_viewContainer()

	c:removeByIndex(self._index, self._secondAnimationDone, self)
end

function ShortenAct_TaskItem:_secondAnimationDone()
	local c = self:_viewContainer()
	local mo = self._mo
	local CO = mo.config
	local taskId = CO.id

	UIBlockMgr.instance:endBlock(kBlock)
	self.animatorPlayer:Play(UIAnimationName.Idle)

	if mo.getAll then
		c:sendFinishAllTaskRequest()
	else
		c:sendFinishTaskRequest(taskId)
	end
end

function ShortenAct_TaskItem:_setActive_limite(isActive)
	self._isLimit = isActive

	gohelper.setActive(self._golimit, isActive)
end

return ShortenAct_TaskItem
