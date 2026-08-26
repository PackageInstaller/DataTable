-- chunkname: @modules/logic/commandstation/view/CommandStationTaskView.lua

module("modules.logic.commandstation.view.CommandStationTaskView", package.seeall)

local CommandStationTaskView = class("CommandStationTaskView", BaseView)

function CommandStationTaskView:onInitView()
	self._imageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/simage_title")
	self._imageReward = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_reward")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_arrowLeft")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_arrowRight")
	self._txtRewardDesc = gohelper.findChildTextMesh(self.viewGO, "Left/Dec/txt_tips2")
	self._goUnFinishTip = gohelper.findChild(self.viewGO, "Left/Dec/tips1/txt_tips1")
	self._goFinishTip = gohelper.findChild(self.viewGO, "Left/Dec/tips1/txt_finished")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Dec/txt_tips2/#btn_detail")
	self._btnNormalTask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Top/#btn_normalTask")
	self._goNormalTaskRed = gohelper.findChild(self.viewGO, "Right/Top/#btn_normalTask/#go_reddot")
	self._goNormalTaskSelect = gohelper.findChild(self.viewGO, "Right/Top/#btn_normalTask/select")
	self._btnCatchTask = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Top/#btn_catchTask")
	self._goCatchTaskRed = gohelper.findChild(self.viewGO, "Right/Top/#btn_catchTask/#go_reddot")
	self._goCatchTaskSelect = gohelper.findChild(self.viewGO, "Right/Top/#btn_catchTask/select")
	self._goTime = gohelper.findChild(self.viewGO, "Right/Top/#go_time")
	self._txtTime = gohelper.findChildTextMesh(self.viewGO, "Right/Top/#go_time/#txt_time")
	self._txtCanGet = gohelper.findChildTextMesh(self.viewGO, "Right/Top/#txt_canget")
	self._simagePaperItemIcon = gohelper.findChildSingleImage(self.viewGO, "Right/Progress/#simage_reward")
	self._txtprogress = gohelper.findChildTextMesh(self.viewGO, "Right/Progress/#txt_progress")
	self._rewardItem = gohelper.findChild(self.viewGO, "Right/Progress/#scroll_view/Viewport/Content/#go_rewarditem")
	self._slider = gohelper.findChildImage(self.viewGO, "Right/Progress/#scroll_view/Viewport/Content/progressbg/fill")
	self._goContent = gohelper.findChild(self.viewGO, "Right/Progress/#scroll_view/Viewport/Content")
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._goline = gohelper.findChild(self.viewGO, "Right/Top/image_line")
end

function CommandStationTaskView:addEvents()
	self._btnNormalTask:AddClickListener(self._swtichTaskShow, self, 1)
	self._btnCatchTask:AddClickListener(self._swtichTaskShow, self, 2)
	self._btnLeft:AddClickListener(self.changeBigBonusIndex, self, -1)
	self._btnRight:AddClickListener(self.changeBigBonusIndex, self, 1)
	self._btnDetail:AddClickListener(self.showItemTips, self)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnTaskUpdate, self.refreshTask, self)
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onGetTaskBonus, self)
	CommandStationController.instance:registerCallback(CommandStationEvent.OnBonusUpdate, self.refreshBonus, self)
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self.refreshBonus, self)
	self.addEventCb(self, CommandStationController.instance, CommandStationEvent.OnGetCommandPostInfo, self._onOnGetCommandPostInfo, self)
end

function CommandStationTaskView:removeEvents()
	self._btnNormalTask:RemoveClickListener()
	self._btnCatchTask:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnDetail:RemoveClickListener()
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnTaskUpdate, self.refreshTask, self)
	TaskController.instance:unregisterCallback(TaskEvent.UpdateTaskList, self._onGetTaskBonus, self)
	CommandStationController.instance:unregisterCallback(CommandStationEvent.OnBonusUpdate, self.refreshBonus, self)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self.refreshBonus, self)
end

function CommandStationTaskView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_0.CommandStationPaper.play_ui_mission_open)
	RedDotController.instance:addMultiRedDot(self._goNormalTaskRed, {
		{
			id = RedDotEnum.DotNode.CommandStationTaskNormal
		},
		{
			uid = -1,
			id = RedDotEnum.DotNode.CommandStationTaskNormal
		}
	})
	RedDotController.instance:addMultiRedDot(self._goCatchTaskRed, {
		{
			id = RedDotEnum.DotNode.CommandStationTaskCatch
		},
		{
			uid = -1,
			id = RedDotEnum.DotNode.CommandStationTaskCatch
		}
	})

	CommandStationTaskListModel.instance.curSelectType = 1

	if CommandStationEnum.ForceHideCommandStation then
		CommandStationTaskListModel.instance.curSelectType = 2

		gohelper.setActive(self._btnNormalTask, false)
	end

	self._bonusCos, self._bonusCountList = CommandStationConfig.instance:getTotalTaskRewards()
	self._bigBonusCos = {}

	local index

	for i, bonus in ipairs(self._bonusCos) do
		if bonus.isBig == 1 then
			table.insert(self._bigBonusCos, bonus)

			local isGet = tabletool.indexOf(CommandStationModel.instance.gainBonus, bonus.id)

			if not index and not isGet then
				index = #self._bigBonusCos
			end
		end
	end

	local icon = ItemConfig.instance:getItemIconById(CommandStationConfig.instance:getPaperItemId())

	self._simagePaperItemIcon:LoadImage(ResUrl.getPropItemIcon(icon))

	index = index or #self._bigBonusCos
	self._curBigBonusIndex = index

	self:refreshTask()
	self:refreshBonus()

	if self:haveCatchTask() then
		local nextRefreshTime = ServerTime.getWeekEndTimeStamp(true) - ServerTime.now()

		TaskDispatcher.runDelay(self._onGetTaskBonus, self, nextRefreshTime)
	end

	TaskDispatcher.runRepeat(self._refreshTime, self, 1, -1)
	self:_refreshTime()
	TaskDispatcher.runDelay(self._autoScrollNoGetBonus, self, 0)
end

function CommandStationTaskView:_autoScrollNoGetBonus()
	local offset = 0

	for i = 1, #self._bonusCos do
		if not tabletool.indexOf(CommandStationModel.instance.gainBonus, self._bonusCos[i].id) then
			break
		end

		offset = offset + self._bonusCountList[i] * 100 + 70
	end

	local width = recthelper.getWidth(self._goContent.transform.parent)
	local contentWidth = recthelper.getWidth(self._goContent.transform)

	offset = Mathf.Clamp(offset, 0, contentWidth - width)

	recthelper.setAnchorX(self._goContent.transform, -offset)
end

function CommandStationTaskView:haveCatchTask()
	return #CommandStationTaskListModel.instance.allCatchTaskMos > 0 and CommandStationModel.instance.catchNum > 0
end

function CommandStationTaskView:refreshTask()
	CommandStationTaskListModel.instance:init()

	local haveCatchTask = self:haveCatchTask()

	gohelper.setActive(self._btnCatchTask, haveCatchTask)

	if CommandStationEnum.ForceHideCommandStation then
		gohelper.setActive(self._btnCatchTask, false)
		gohelper.setActive(self._goTime, false)
		gohelper.setActive(self._goline, haveCatchTask)
	end

	local isCatch = CommandStationTaskListModel.instance.curSelectType == CommandStationEnum.TaskType.Catch
	local var_7_0

	if isCatch then
		var_7_0 = RedDotEnum.DotNode.CommandStationTaskCatch or RedDotEnum.DotNode.CommandStationTaskNormal

		local var_7_1

		if isCatch then
			var_7_1 = PlayerPrefsKey.CommandStationTaskCatchOnce or PlayerPrefsKey.CommandStationTaskNormalOnce
		end
	end

	self:setTaskNewRed(var_7_0, var_7_1)
	gohelper.setActive(self._goNormalTaskSelect, not isCatch)
	gohelper.setActive(self._goCatchTaskSelect, isCatch)
	gohelper.setActive(self._txtCanGet, isCatch)

	if not haveCatchTask and isCatch then
		self:_swtichTaskShow(1)

		return
	end
end

function CommandStationTaskView:setTaskNewRed(redDotType, key)
	local isRed = RedDotModel.instance:isDotShow(redDotType, -1)

	if not isRed then
		return
	end

	local curVersion = CommandStationConfig.instance:getCurVersionId()

	GameUtil.playerPrefsSetNumberByUserId(key .. curVersion, 0)
	RedDotRpc.instance:clientAddRedDotGroupList({
		{
			uid = -1,
			value = 0,
			id = redDotType
		}
	}, false)
end

function CommandStationTaskView:_refreshTime()
	local nextRefreshTime = 0
	local constCo = CommandStationConfig.instance:getConstConfig(CommandStationEnum.ConstId.VersionEndDt)

	if constCo then
		nextRefreshTime = TimeUtil.stringToTimestamp(constCo.value2) + ServerTime.clientToServerOffset() - ServerTime.now()
	end

	nextRefreshTime = math.max(0, nextRefreshTime)
	self._txtTime.text = TimeUtil.SecondToActivityTimeFormat(nextRefreshTime)
end

function CommandStationTaskView:_onOnGetCommandPostInfo()
	self:refreshBonus()
end

function CommandStationTaskView:refreshBonus()
	local curItemNum = CommandStationConfig.instance:getCurPaperCount()
	local needItemNum = CommandStationConfig.instance:getCurTotalPaperCount()

	self._txtCanGet.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("commandstation_paper_canget"), CommandStationModel.instance.catchNum)
	self._txtprogress.text = string.format("<#DE9A2F>%d</color>/%d", curItemNum, needItemNum)

	local process = 0
	local totalProcess = 0
	local flag = false

	for i = 1, #self._bonusCos do
		local co = self._bonusCos[i]
		local preCo = self._bonusCos[i - 1]

		if preCo then
			if not preCo.pointNum then
				local prePoint = 0

				if self._bonusCountList[i - 1] then
					if not (self._bonusCountList[i - 1] * 100 + 70) then
						local preProgress = 0
						local nowProgress = self._bonusCountList[i] * 100 + 70
						local addProgress = (preProgress + nowProgress) / 2

						if curItemNum >= co.pointNum then
							process = process + addProgress
						elseif not flag then
							process = process + addProgress * (curItemNum - prePoint) / (co.pointNum - prePoint)
							flag = true
						end

						totalProcess = totalProcess + addProgress
					end
				end
			end
		end
	end

	self._slider.fillAmount = process / totalProcess

	CommandStationBonusListModel.instance:setData(self._bonusCos, self._bonusCountList)
	self:refreshBigBonus()
end

function CommandStationTaskView:_titleLoadCallback()
	local imageTitle = gohelper.findChildImage(self.viewGO, "Left/simage_title")

	imageTitle:SetNativeSize()

	if self._curBigBonusIndex == 9 then
		recthelper.setSize(imageTitle.transform, 480, 160)
	end
end

function CommandStationTaskView:_rewardCallback()
	local image = gohelper.findChildImage(self.viewGO, "Left/#simage_reward")

	image:SetNativeSize()
end

function CommandStationTaskView:refreshBigBonus()
	local co = self._bigBonusCos[self._curBigBonusIndex]

	if not co then
		return
	end

	gohelper.setActive(self._btnLeft, self._curBigBonusIndex > 1)
	gohelper.setActive(self._btnRight, self._curBigBonusIndex < #self._bigBonusCos)
	self._imageTitle:LoadImage(string.format("singlebg_lang/txt_commandstation_singlebg/commandstation_task_title%s.png", self._curBigBonusIndex), self._titleLoadCallback, self)
	self._imageReward:LoadImage(string.format("singlebg/commandstation/task/commandstation_task_reward%s.png", self._curBigBonusIndex), self._rewardCallback, self)

	local itemNames = {}
	local dict = GameUtil.splitString2(co.bonus, true)

	for _, arr in ipairs(dict) do
		local itemCo = ItemConfig.instance:getItemConfig(arr[1], arr[2])

		if itemCo then
			table.insert(itemNames, itemCo.name)
		end
	end

	self._txtRewardDesc.text = table.concat(itemNames, luaLang("commandstation_itemname_and"))

	local isFinish = tabletool.indexOf(CommandStationModel.instance.gainBonus, co.id)

	gohelper.setActive(self._goFinishTip, isFinish)
	gohelper.setActive(self._goUnFinishTip, not isFinish)
end

function CommandStationTaskView:changeBigBonusIndex(num)
	self._curBigBonusIndex = Mathf.Clamp(num + self._curBigBonusIndex, 1, #self._bigBonusCos)

	if num > 0 then
		self._anim:Play("switch_right", 0, 0)
	elseif num < 0 then
		self._anim:Play("switch_left", 0, 0)
	end

	TaskDispatcher.runDelay(self.refreshBigBonus, self, 0.167)
	UIBlockHelper.instance:startBlock("CommandStationTaskView_switch", 0.167)
end

function CommandStationTaskView:showItemTips()
	local co = self._bigBonusCos[self._curBigBonusIndex]

	if not co then
		return
	end

	local dict = GameUtil.splitString2(co.bonus, true)

	MaterialTipController.instance:showMaterialInfo(dict[1][1], dict[1][2])
end

function CommandStationTaskView:_sendGetAllBonus()
	CommandStationRpc.instance:sendCommandPostBonusAllRequest()
end

function CommandStationTaskView:_swtichTaskShow(type)
	if type == CommandStationTaskListModel.instance.curSelectType then
		return
	end

	CommandStationTaskListModel.instance.curSelectType = type

	self:refreshTask()
	self:_refreshTime()
end

function CommandStationTaskView:_onGetTaskBonus()
	CommandStationRpc.instance:sendGetCommandPostInfoRequest()
end

function CommandStationTaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshBigBonus, self)
	TaskDispatcher.cancelTask(self._refreshTime, self)
	TaskDispatcher.cancelTask(self._onGetTaskBonus, self)
	TaskDispatcher.cancelTask(self._autoScrollNoGetBonus, self)
end

return CommandStationTaskView
