-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\Task\\ActivityCatRaceTaskCell.lua

local ResClientNotice = require("ClientData/ResClientNotice")
local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local strClassName = "ActivityCatRaceTaskCell"
local ActivityCatRaceTaskCell = Class(strClassName, UIControls.Child)

function ActivityCatRaceTaskCell:ctor()
	self:initUI()
end

function ActivityCatRaceTaskCell:initUI()
	self.bgTaskPanel = UIControls.Panel(self, "BgTask")
	self.friendTaskPanel = UIControls.Panel(self, "BgFriendTask")
	self.taskUncollectPanel = UIControls.Panel(self, "BgFriendTask/TaskUncollect")
	self.taskCollectPanel = UIControls.Panel(self, "BgFriendTask/TaskCollect")
	self.tipsTxt = UIControls.Label(self, "BgFriendTask/TaskUncollect/TextTips")
	self.extraEfxPanel = UIControls.Panel(self, "BgFriendTask/TaskCollect/Efx")
	self.tipsBtn = UIControls.Button(self, "BgFriendTask/BtnTips")

	self.tipsBtn:addEventClick(self._onBtnTips)
end

function ActivityCatRaceTaskCell:_onBtnTips()
	if self.type == CatRaceConfig.MY_TASK_TYPE then
		-- block empty
	elseif self.type == CatRaceConfig.FRIEND_TASK_TYPE then
		UIManager.getUI("infoNotice", true):showSystemInfo(self.mainActData.miscData.friend_task_tip_id)
	elseif self.type == CatRaceConfig.OPTIONAL_TASK_TYPE then
		UIManager.getUI("infoNotice", true):showSystemInfo(self.mainActData.miscData.optional_task_tip_id)
	end
end

function ActivityCatRaceTaskCell:setData(data, mainActID, friendTabCallback)
	self:setVisible(true)

	self.data = data
	self.type = data.type
	self.actData = data.actData
	self.opId = self.actData.actObject.opId
	self.achieveType = data.achieveType
	self.achieveIndex = data.achieveIndex
	self.mainActID = mainActID
	self.mainActObj = CurAvatar:getActivityObj(self.mainActID)
	self.mainActOpID = self.mainActObj.opId
	self.mainActData = self.mainActObj.actData
	self.friendTabCallback = friendTabCallback

	if self.type == CatRaceConfig.MY_TASK_TYPE then
		self:initMyTask()
	elseif self.type == CatRaceConfig.FRIEND_TASK_TYPE then
		self:initFriendTask()
	elseif self.type == CatRaceConfig.OPTIONAL_TASK_TYPE then
		self:initOptionalTask()
	end

	self:refreshData()
end

function ActivityCatRaceTaskCell:initMyTask()
	self.bgTaskPanel:setVisible(true)
	self.friendTaskPanel:setVisible(false)
	self:initTaskDetail("BgTask")

	self.goBtn = UIControls.Button(self, "BgTask/BtnGo", "Text")

	self.goBtn:addEventClick(self._onBtnGo)

	self.awardGridPath = "BgTask/GridAward"
end

function ActivityCatRaceTaskCell:initFriendTask()
	self.bgTaskPanel:setVisible(false)
	self.friendTaskPanel:setVisible(true)
	self:initTaskDetail("BgFriendTask/TaskCollect")

	self.changeBtn = UIControls.Button(self, "BgFriendTask/TaskCollect/BtnChange")

	self.changeBtn:addEventClick(self._onBtnChange)

	self.undoneTip = ResClientNotice[446].notice
	self.friendGoBtn = UIControls.Button(self, "BgFriendTask/TaskUncollect/BtnGo", "Text")

	self.friendGoBtn:addEventClick(self._onBtnFriendGo)

	self.friendGoIconNewImg = UIControls.Image(self, "BgFriendTask/TaskUncollect/BtnGo/IconNew")
	self.awardGridPath = "BgFriendTask/TaskCollect/GridAward"
	self.friendTaskStateTxt = UIControls.Label(self, "BgTask/TextState")
end

function ActivityCatRaceTaskCell:initOptionalTask()
	self.bgTaskPanel:setVisible(false)
	self.friendTaskPanel:setVisible(true)
	self:initTaskDetail("BgFriendTask/TaskCollect")

	self.changeBtn = UIControls.Button(self, "BgFriendTask/TaskCollect/BtnChange", "Text")

	self.changeBtn:addEventClick(self._onBtnChange)

	self.undoneTip = ResClientNotice[445].notice
	self.friendGoBtn = UIControls.Button(self, "BgFriendTask/TaskUncollect/BtnGo", "Text")

	self.friendGoBtn:addEventClick(self._onBtnFriendGo)

	self.awardGridPath = "BgFriendTask/TaskCollect/GridAward"
end

function ActivityCatRaceTaskCell:initTaskDetail(prefix)
	self.detailPrefix = prefix
	self.taskSlider = UIControls.Slider(self, prefix .. "/TaskSlider", "TextProgress")
	self.ruleTxt = UIControls.Label(self, prefix .. "/TextRule")
	self.awrdGrid = UIControls.Panel(self, prefix .. "/GridAward")
	self.confirmBtn = UIControls.Button(self, prefix .. "/BtnConfirm", "Text")

	self.confirmBtn:addEventClick(self._onBtnConfirm)

	self.achieveStateTxt = UIControls.Label(self, prefix .. "/TextState")
end

function ActivityCatRaceTaskCell:refreshData()
	self:refreshDaily()

	if self.type == CatRaceConfig.MY_TASK_TYPE then
		self:refreshAchieveProgress()
	elseif self.type == CatRaceConfig.FRIEND_TASK_TYPE then
		local friendTaskID, friendTaskType = self.mainActData:getFriendTask()

		if friendTaskID then
			self.taskUncollectPanel:setVisible(false)
			self.taskCollectPanel:setVisible(true)

			self.achieveType = friendTaskType
			self.achieveIndex = 1

			self:refreshAchieveProgress()
		else
			local undoneTaskNum = self.mainActData:getRemainFriendTaskNum()

			if undoneTaskNum > 0 then
				self.tipsTxt:setText(utils.format(self.undoneTip, undoneTaskNum))
				self.friendGoBtn:setText(Lang.get(126))
				self.friendGoBtn:setVisible(true)
				self.friendGoIconNewImg:setVisible(self.mainActData:hasAvailableFriendTask())
				self.friendTaskStateTxt:setVisible(false)
			else
				self.tipsTxt:setText(ResClientNotice[447].notice)
				self.friendTaskStateTxt:setText(Lang.get(51498))
				self.friendTaskStateTxt:setVisible(true)
				self.friendGoBtn:setVisible(false)
			end

			self.taskUncollectPanel:setVisible(true)
			self.taskCollectPanel:setVisible(false)
		end
	elseif self.type == CatRaceConfig.OPTIONAL_TASK_TYPE then
		if self.mainActData:isSelOptionalTask() then
			local optionalTaskID, optionalTaskType = self.mainActData:getOptionalTask()

			self.taskUncollectPanel:setVisible(false)
			self.taskCollectPanel:setVisible(true)

			self.achieveType = optionalTaskType
			self.achieveIndex = 1

			self:refreshAchieveProgress()
		else
			self.tipsTxt:setText(self.undoneTip)
			self.taskUncollectPanel:setVisible(true)
			self.taskCollectPanel:setVisible(false)
		end
	end
end

function ActivityCatRaceTaskCell:refreshDaily()
	local nextResetTime = self.actData:getNextResetTime(self.achieveType)

	if nextResetTime and nextResetTime ~= 0 and self.actData.miscData and self.actData.miscData.refresh_time > 0 then
		local curTime = ClientUtils.getServerTime()

		if nextResetTime < curTime then
			self.actData:resetDaily(self.achieveType)
		end
	end
end

function ActivityCatRaceTaskCell:refreshAchieveProgress()
	self.achieveData = self.actData:getAchieveOneData(self.achieveType, self.achieveIndex)
	self.awardId = self.achieveData.award

	self.ruleTxt:setText(self.achieveData.desc_name)

	if self.grids then
		for _, grid in pairs(self.grids) do
			grid:destroy()
		end
	end

	self.grids = {}

	ClientUtils.CreateBonusGrid(self, self.grids, self.awardGridPath, self.awardId, true, nil, true, CatRaceConfig.GRID_CONFIG)

	if self.type == CatRaceConfig.FRIEND_TASK_TYPE and self.mainActData:checkIsFirstFriendTask() then
		if self.extraGrids then
			for _, grid in pairs(self.extraGrids) do
				grid:destroy()
			end
		end

		self.extraGrids = {}

		ClientUtils.CreateBonusGrid(self, self.extraGrids, self.awardGridPath, self.mainActData.miscData.friend_task_award, true, nil, true, CatRaceConfig.GRID_CONFIG)
		self.extraEfxPanel:setVisible(true)
	else
		self.extraEfxPanel:setVisible(false)

		if self.extraGrids then
			for _, grid in pairs(self.extraGrids) do
				grid:destroy()
			end
		end
	end

	local progress = self.actData:getAchieveProgress(self.achieveType)
	local param = self.actData:getAchieveParam(self.achieveType, self.achieveIndex)
	local rate = 0

	rate = param <= progress and 1 or progress / param

	self.taskSlider:setValue(rate)

	progress = ClientUtils.getNumShortStr(math.min(param, progress))

	self.taskSlider:setText(progress .. "/" .. ClientUtils.getNumShortStr(param))

	local state = self.actData:getAchieveState(self.achieveType, self.achieveIndex)
	local selectable = state == Const.ACT_ACHIEVE_STATE_ENOUGH

	self.confirmBtn:setEnable(selectable)

	if state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.confirmBtn:setText(Lang.get(32787))
		self.confirmBtn:setVisible(true)

		if self.goBtn then
			self.goBtn:setVisible(false)
		end

		if self.changeBtn then
			self.changeBtn:setVisible(false)
		end

		self.achieveStateTxt:setVisible(false)
	elseif state == Const.ACT_ACHIEVE_STATE_GOT then
		if self.goBtn then
			self.goBtn:setVisible(false)
		end

		self.achieveStateTxt:setText(Lang.get(74))
		self.achieveStateTxt:setVisible(true)

		if self.grids then
			for _, grid in pairs(self.grids) do
				grid:setState(true, true, true)
			end
		end

		self.confirmBtn:setVisible(false)

		if self.changeBtn then
			self.changeBtn:setVisible(false)
		end
	else
		if self.goBtn then
			self.goBtn:setText(Lang.get(126))
			self.goBtn:setVisible(true)
			self.goBtn:setEnable(true)
		end

		self.confirmBtn:setVisible(false)
		self.achieveStateTxt:setVisible(false)

		if self.changeBtn then
			self.changeBtn:setText(Lang.get(933))
			self.changeBtn:setVisible(true)
			self.changeBtn:setEnable(true)
		end
	end
end

function ActivityCatRaceTaskCell:_onBtnConfirm()
	if self.type == CatRaceConfig.FRIEND_TASK_TYPE then
		CurAvatar:activityRPC(Functor(RPC.opActCatRaceGetTaskAward, self.mainActOpID), self.mainActOpID)
	end

	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.achieveIndex, self.achieveType), self.opId)
end

function ActivityCatRaceTaskCell:_onBtnChange()
	if self.type == CatRaceConfig.OPTIONAL_TASK_TYPE then
		if self.mainActData:isOptionalTaskAwardAvaliable() then
			MsgManager.notice(ResClientNotice[448].notice)
		elseif self.mainActData.lastOptionalTaskGetRecord and self.mainActData.lastOptionalTaskGetRecord + CatRaceConfig.TASK_CHANGE_CD > ClientUtils.getServerTime() then
			MsgManager.notice(ResClientNotice[456].notice)
		else
			local ui = UIManager.getUI("activityCatRaceTaskChooseDlg", true)

			if ui then
				local data = {
					mainActID = self.mainActID
				}

				ui:setData(data)
			end
		end
	elseif self.type == CatRaceConfig.FRIEND_TASK_TYPE then
		if self.mainActData.lastFriendTaskGetRecord and self.mainActData.lastFriendTaskGetRecord + CatRaceConfig.TASK_CHANGE_CD > ClientUtils.getServerTime() then
			MsgManager.notice(ResClientNotice[456].notice)
		else
			MsgManager.notice(ResClientNotice[449].notice)
			self.mParent:onBtnFriendTask(self, true)
		end
	end
end

function ActivityCatRaceTaskCell:_onBtnGo()
	local miscData = self.actData:getAchieveMiscDataByType(self.achieveType)

	if miscData and miscData.jump_id then
		JumpGuideManager.jump(miscData.jump_id)
		self.mParent:setVisible(false)
	end
end

function ActivityCatRaceTaskCell:_onBtnFriendGo()
	if self.type == CatRaceConfig.FRIEND_TASK_TYPE then
		self.friendTabCallback()
	elseif self.type == CatRaceConfig.OPTIONAL_TASK_TYPE then
		if self.mainActData:isOptionalTaskAwardAvaliable() then
			MsgManager.notice(ResClientNotice[448].notice)
		else
			local ui = UIManager.getUI("activityCatRaceTaskChooseDlg", true)

			if ui then
				local data = {
					mainActID = self.mainActID
				}

				ui:setData(data)
			end
		end
	end
end

return ActivityCatRaceTaskCell
