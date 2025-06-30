-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyAchievement\\MonsterAcademyAchievementTaskCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.taskData = data
	self.cfgTaskData = CfgMainQuestTable[self.taskData.cid]

	if self.taskData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK then
		if self.taskData.CurrentNum >= self.taskData.TargetNum then
			self.state = 2
		else
			self.state = 1
		end
	else
		self.state = 3
	end

	local value = 0

	for i = 1, #self.cfgTaskData.Reward, 2 do
		local id = self.cfgTaskData.Reward[i]
		local showID = CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid].AchPointShow

		if showID == id then
			value = self.cfgTaskData.Reward[i + 1]

			break
		end
	end

	UGUIUtil.SetText(self.TextAchievementDoing, MonsterAcademyAchievementUIApi:GetString("TextTargetNum", value))
	UGUIUtil.SetText(self.TextAchievementOver, MonsterAcademyAchievementUIApi:GetString("TextTargetNum", value))
	UGUIUtil.SetText(self.TextNameDoing, self.cfgTaskData.Name)
	UGUIUtil.SetText(self.TextNameOver, self.cfgTaskData.Name)
	UGUIUtil.SetText(self.TextTargetDoing, self.cfgTaskData.Description)
	UGUIUtil.SetText(self.TextTargetOver, self.cfgTaskData.Description)
	UGUIUtil.SetText(self.TextStateDoing, MonsterAcademyAchievementUIApi:GetString("TextState", self.state))
	UGUIUtil.SetText(self.TextStateOver, MonsterAcademyAchievementUIApi:GetString("TextState", self.state))
	self:RefreshState(self.state)
end

function m:RefreshState(state)
	self.goCellDoing:SetActive(state == 1)
	self.goCellOver:SetActive(state ~= 1)
end

function m:Dispose()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
