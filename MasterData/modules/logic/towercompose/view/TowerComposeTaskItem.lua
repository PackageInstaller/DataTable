-- chunkname: @modules/logic/towercompose/view/TowerComposeTaskItem.lua

module("modules.logic.towercompose.view.TowerComposeTaskItem", package.seeall)

local TowerComposeTaskItem = class("TowerComposeTaskItem", ListScrollCellExtend)

function TowerComposeTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/scroll_desc/Viewport/Content/#txt_taskdes")
	self._goscrollRewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "#go_normal/#scroll_rewards")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/#go_rewards")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")
	self._btndesc = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/scroll_desc/Viewport/Content/#txt_taskdes/#btn_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeTaskItem:addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnormalOnClick, self)
	self._btnfinishbg:AddClickListener(self._btncangetOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
	self._btndesc:AddClickListener(self._btndescOnClick, self)
end

function TowerComposeTaskItem:removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
	self._btndesc:RemoveClickListener()
end

TowerComposeTaskItem.BlockKey = "TowerComposeTaskItemRewardGetAnim"
TowerComposeTaskItem.TaskMaskTime = 0.65

function TowerComposeTaskItem:_btnnormalOnClick()
	if self.jumpId > 0 then
		local jumpSucc = GameFacade.jump(self.jumpId)

		if jumpSucc then
			ViewMgr.instance:closeView(ViewName.TowerComposeTaskView)
		end
	elseif self.config.jumpId == 0 and self.config.taskType == TowerComposeEnum.TaskType.LimitTime and not string.nilorempty(self.config.params) then
		local paramInfo = string.split(self.config.params, "|")
		local themeId = tonumber(paramInfo[1])
		local modList = string.splitToNumber(paramInfo[2], "#")
		local lockModConfig = TowerComposeModel.instance:checkHasModsLock(themeId, modList)

		if lockModConfig then
			GameFacade.showToast(ToastEnum.TowerComposeModLock, lockModConfig.name)

			return
		end

		GameFacade.showOptionMessageBox(MessageBoxIdDefine.TowerComposeJumpToReplaceMod, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, self.dropAndReplaceModCallBack, nil, nil, self)
	end
end

function TowerComposeTaskItem:dropAndReplaceModCallBack()
	local jumpSucc = TowerComposeController.instance:jumpToModEquipView(self.config)

	if jumpSucc then
		ViewMgr.instance:closeView(ViewName.TowerComposeTaskView)
	end
end

function TowerComposeTaskItem:_btncangetOnClick()
	if not self.taskId and not self.mo.canGetAll then
		return
	end

	self._animator:Play(UIAnimationName.Finish)
	UIBlockMgr.instance:startBlock(TowerComposeTaskItem.BlockKey)
	TowerComposeController.instance:dispatchEvent(TowerComposeEvent.OnTaskRewardGetFinish, self._index)
	TaskDispatcher.runDelay(self._onPlayActAniFinished, self, TowerComposeTaskItem.TaskMaskTime)
end

function TowerComposeTaskItem:_btngetallOnClick()
	self:_btncangetOnClick()
end

function TowerComposeTaskItem:_btndescOnClick()
	if string.nilorempty(self.config.params) then
		return
	end

	local paramInfo = string.split(self.config.params, "|")
	local modList = string.splitToNumber(paramInfo[2], "#") or {}

	if #modList > 0 then
		TowerComposeController.instance:dispatchEvent(TowerComposeEvent.ShowModDescTip, modList)
	end
end

function TowerComposeTaskItem:_onPlayActAniFinished()
	TaskDispatcher.cancelTask(self._onPlayActAniFinished, self)

	if self.mo.canGetAll then
		local canGetIdList = TowerComposeTaskModel.instance:getAllCanGetList()

		TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.TowerCompose, 0, canGetIdList, nil, nil, 0)
	else
		TaskRpc.instance:sendFinishTaskRequest(self.taskId)
	end

	UIBlockMgr.instance:endBlock(TowerComposeTaskItem.BlockKey)
end

function TowerComposeTaskItem:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._scrollrewards = self._goscrollRewards:GetComponent(gohelper.Type_LimitedScrollRect)
	self._goscrollDesc = gohelper.findChild(self.viewGO, "#go_normal/scroll_desc")
	self._scrolldesc = self._goscrollDesc:GetComponent(gohelper.Type_LimitedScrollRect)
end

function TowerComposeTaskItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo
	self._scrollrewards.parentGameObject = self._view._csListScroll.gameObject
	self._scrolldesc.parentGameObject = self._view._csListScroll.gameObject

	if self.mo.canGetAll then
		gohelper.setActive(self._gonormal, false)
		gohelper.setActive(self._gogetall, true)
	else
		gohelper.setActive(self._gonormal, true)
		gohelper.setActive(self._gogetall, false)
		self:refreshNormal()
	end
end

function TowerComposeTaskItem:refreshNormal()
	self.taskId = self.mo.id
	self.config = self.mo.config
	self.jumpId = self.config.jumpId
	self._txttaskdes.text = self.config.taskType == TowerComposeEnum.TaskType.LimitTime and not string.nilorempty(self.config.params) and TowerComposeController.instance:setModDescColor(self.config.desc, true, "#C56030") or self.config.desc
	self._txtnum.text = self.mo.progress
	self._txttotal.text = self.config.maxProgress

	self:refreshReward()
	self:refreshState()
end

function TowerComposeTaskItem:refreshReward()
	local config = self.mo.config

	if string.nilorempty(config.bonus) then
		return
	end

	local rewardList = GameUtil.splitString2(config.bonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gorewards)
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

function TowerComposeTaskItem:refreshState()
	if TowerComposeTaskModel.instance:isTaskFinished(self.mo) then
		gohelper.setActive(self._goallfinish, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	elseif self.mo.hasFinished then
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, true)
	else
		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, true)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	end
end

function TowerComposeTaskItem:getAnimator()
	return self._animator
end

function TowerComposeTaskItem:onDestroyView()
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

return TowerComposeTaskItem
