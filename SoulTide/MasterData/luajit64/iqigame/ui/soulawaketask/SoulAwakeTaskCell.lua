-- chunkname: @IQIGame\\UI\\SoulAwakeTask\\SoulAwakeTaskCell.lua

local SoulAwakeTaskCell = {}

function SoulAwakeTaskCell.New(view)
	local obj = Clone(SoulAwakeTaskCell)

	obj:Init(view)

	return obj
end

function SoulAwakeTaskCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function SoulAwakeTaskCell:Refresh(taskData, index, taskDatum)
	self.taskData = taskData
	self.index = index
	self.taskDatum = taskDatum
	self.cfgTaskData = CfgMainQuestTable[self.taskData.cid]

	self:RefreshState()
end

function SoulAwakeTaskCell:OnHide()
	return
end

function SoulAwakeTaskCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil

	AssetUtil.UnloadAsset(self)
end

function SoulAwakeTaskCell:RefreshState()
	local lastWorkingIndex = 0

	for i, v in ipairs(self.taskDatum) do
		if v.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
			lastWorkingIndex = i
		end
	end

	local curStatus

	if lastWorkingIndex > self.index then
		curStatus = TaskModule.TaskStatus.FINISH_TASK
	elseif self.index == lastWorkingIndex then
		curStatus = TaskModule.TaskStatus.CURRENT_TASK
	elseif lastWorkingIndex < self.index then
		curStatus = TaskModule.TaskStatus.LOCK_SHOW_TASK
	end

	self.goNormalState:SetActive(curStatus == TaskModule.TaskStatus.LOCK_SHOW_TASK)
	self.goNowState:SetActive(curStatus == TaskModule.TaskStatus.CURRENT_TASK)
	self.goFinishState:SetActive(curStatus == TaskModule.TaskStatus.FINISH_TASK)

	local trans

	if curStatus == TaskModule.TaskStatus.LOCK_SHOW_TASK then
		trans = self.goNormalState.transform
	elseif curStatus == TaskModule.TaskStatus.CURRENT_TASK then
		trans = self.goNowState.transform
	elseif curStatus == TaskModule.TaskStatus.FINISH_TASK then
		trans = self.goFinishState.transform
	end

	local tfName = trans:Find("Text_01"):GetComponent("Text")
	local tfEngDesc = trans:Find("Text_02"):GetComponent("Text")
	local tfDesc = trans:Find("Text_03"):GetComponent("Text")
	local tfTarget = trans:Find("Text_04"):GetComponent("Text")
	local imgBg = trans:Find("Image_Num"):GetComponent("Image")

	tfName.text = SoulAwakeTaskUIApi:GetString("goTaskName", self.cfgTaskData.Name, curStatus)
	tfEngDesc.text = SoulAwakeTaskUIApi:GetString("goTaskEngDesc")
	tfDesc.text = SoulAwakeTaskUIApi:GetString("goTaskDesc", CfgTargetTable[self.cfgTaskData.TargetId].TargetDes, curStatus)

	if curStatus == TaskModule.TaskStatus.FINISH_TASK then
		tfTarget.text = SoulAwakeTaskUIApi:GetString("goTaskTarget", self.taskData.TargetNum, self.taskData.TargetNum, curStatus)
	else
		tfTarget.text = SoulAwakeTaskUIApi:GetString("goTaskTarget", self.taskData.CurrentNum, self.taskData.TargetNum, curStatus)
	end

	AssetUtil.LoadImage(self, SoulAwakeTaskUIApi:GetString("goCellBgPath", self.index), imgBg)

	if curStatus == TaskModule.TaskStatus.CURRENT_TASK then
		local tfWorkingDesc = trans:Find("Text_05"):GetComponent("Text")

		tfWorkingDesc.text = SoulAwakeTaskUIApi:GetString("goTaskWorkingDesc")
	end
end

return SoulAwakeTaskCell
