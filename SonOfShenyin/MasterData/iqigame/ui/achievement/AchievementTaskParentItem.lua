-- chunkname: @IQIGame\\UI\\Achievement\\AchievementTaskParentItem.lua

local AchievementTaskParentItem = {}

function AchievementTaskParentItem.New(go, mainView)
	local o = Clone(AchievementTaskParentItem)

	o:Initialize(go, mainView)

	return o
end

function AchievementTaskParentItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function AchievementTaskParentItem:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
end

function AchievementTaskParentItem:InitDelegate()
	function self.buttonClickDelegate()
		self:OnButtonClick()
	end
end

function AchievementTaskParentItem:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function AchievementTaskParentItem:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function AchievementTaskParentItem:OnDestroy()
	self:RemoveListener()
end

function AchievementTaskParentItem:ResetStatus()
	LuaUtility.SetGameObjectShow(self.objectNormal, true)
	LuaUtility.SetGameObjectShow(self.objectSelect, false)
end

function AchievementTaskParentItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function AchievementTaskParentItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function AchievementTaskParentItem:OnSelected()
	LuaUtility.SetGameObjectShow(self.objectNormal, false)
	LuaUtility.SetGameObjectShow(self.objectSelect, true)
end

function AchievementTaskParentItem:OnButtonClick()
	self.mainView:OnParentTabClick(self)
	self:OnSelected()
end

function AchievementTaskParentItem:Refresh(Data)
	self.Data = Data

	self:ResetStatus()

	local cfgTask = TaskSystemModule.GetCfgTaskDataWithID(self.Data.cid)
	local finishNum = 0
	local parentTaskPod = TaskSystemModule.taskSystemDataDic[self.Data.cid]

	if parentTaskPod == nil then
		-- block empty
	elseif parentTaskPod.status >= Constant.TaskStatus.hasDone then
		finishNum = finishNum + 1
	end

	local childData = AchievementModule.GetSortTaskList(self.Data.cid)

	for n = 1, #childData do
		local childTaskPod = TaskSystemModule.taskSystemDataDic[childData[n].cid]

		if childTaskPod == nil then
			-- block empty
		elseif childTaskPod.status >= Constant.TaskStatus.hasDone then
			finishNum = finishNum + 1
		end
	end

	LuaUtility.SetText(self.textSelectName, cfgTask.Name)
	LuaUtility.SetText(self.textNormalName, cfgTask.Name)
	LuaUtility.SetText(self.presentScheduleNumText, finishNum)
	LuaUtility.SetText(self.allScheduleNumText, #childData + 1)
end

return AchievementTaskParentItem
