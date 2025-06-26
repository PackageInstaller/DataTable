-- chunkname: @IQIGame\\UI\\MemoryStory\\MemoryStoryTaskMould.lua

local m = {
	TaskId = 0,
	TargetList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	self.TargetText.gameObject:SetActive(false)

	self.normalTaskTitle = self.UnFinishedText:GetComponent("Text")
	self.finishTaskTitle = self.FinishedText:GetComponent("Text")
end

function m:SetData(taskId, playAnim)
	self.TaskId = taskId

	self:__RefreshShow()
	self.view.gameObject:SetActive(true)
end

function m:Refresh()
	self:__RefreshShow()
end

function m:__RefreshShow()
	local taskCfg = CfgMemoryStoryTaskTable[self.TaskId]
	local taskInfo = MemoryStoryPlayerModule.GetReceiveTaskData(self.TaskId)

	if taskInfo == nil then
		logError("can not find task data in player with taskId: " .. tostring(self.TaskId))
		self.view.gameObject:SetActive(false)

		return
	end

	local isFinish = true

	for _, v in pairs(taskCfg.TargetId) do
		local targetCfg = CfgMemoryStoryTargetTable[v]
		local text

		if targetCfg.TotalProgress ~= taskInfo[v] then
			isFinish = false
			text = MemoryStorySceneMainUIApi:GetString("GetTaskTargetText", targetCfg.TargetName, isFinish)
		else
			text = MemoryStorySceneMainUIApi:GetString("GetTaskTargetText", targetCfg.FinishedTargetName, isFinish)
		end

		if targetCfg.IsShowRate then
			text = text .. MemoryStorySceneMainUIApi:GetString("GetTaskProgressText", taskInfo[v], targetCfg.TotalProgress)
		end

		self:__GetTargetText(v).text = text
	end

	local titleText = MemoryStorySceneMainUIApi:GetString("GetTaskTitleText", taskCfg.Title, isFinish)

	if isFinish then
		self.finishTaskTitle.text = titleText

		self.Finished.gameObject:SetActive(true)
		self.UnFinished.gameObject:SetActive(false)
	else
		self.normalTaskTitle.text = titleText

		self.UnFinished.gameObject:SetActive(true)
		self.Finished.gameObject:SetActive(false)
	end
end

function m:__GetTargetText(targetId)
	local targetText = self.TargetList[targetId]

	if targetText == nil then
		local obj = UnityEngine.Object.Instantiate(self.TargetText)

		obj.transform:SetParent(self.TargetText.transform.parent, false)
		obj.gameObject:SetActive(true)

		local text = obj.gameObject:GetComponent("Text")

		self.TargetList[targetId] = text

		return text
	end

	return targetText
end

function m:IsFree()
	return not self.view.gameObject.activeSelf
end

function m:Free()
	for i, v in pairs(self.TargetList) do
		UnityEngine.GameObject.Destroy(v.gameObject)
	end

	self.TargetList = {}
end

function m:Hide()
	self.view.gameObject:SetActive(false)
end

function m:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.TargetList = nil

	UnityEngine.GameObject.Destroy(self.view.gameObject)

	self.view = nil
end

return m
