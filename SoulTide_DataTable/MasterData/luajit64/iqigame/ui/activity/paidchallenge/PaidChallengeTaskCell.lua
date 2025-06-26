-- chunkname: @IQIGame\\UI\\Activity\\PaidChallenge\\PaidChallengeTaskCell.lua

local PaidChallengeTaskCell = {}

function PaidChallengeTaskCell.New(view)
	local obj = Clone(PaidChallengeTaskCell)

	obj:Init(view)

	return obj
end

function PaidChallengeTaskCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfDesc = self.goDesc:GetComponent("Text")
	self.tfTarget = self.goTarget:GetComponent("Text")
	self.txtIcon = self.goLockTxtIcon:GetComponent("Image")
end

function PaidChallengeTaskCell:Refresh(day, taskData)
	self.day = day
	self.taskData = taskData

	self:RefreshState()
end

function PaidChallengeTaskCell:OnHide()
	AssetUtil.UnloadAsset(self)
end

function PaidChallengeTaskCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function PaidChallengeTaskCell:RefreshState()
	self.goLockRoot:SetActive(self.taskData.TaskStatus == 0)
	self.goUnlockRoot:SetActive(self.taskData.TaskStatus ~= 0)

	if self.taskData.TaskStatus == 0 then
		local path = ActivityUIApi:GetString("paidViewLockTxtPath", self.day)

		if path ~= "" then
			AssetUtil.LoadImage(self, path, self.txtIcon)
		end
	end

	local cfgTaskData = CfgMainQuestTable[self.taskData.cid]

	self.tfDesc.text = ActivityUIApi:GetString("paidViewTaskDesc", cfgTaskData.Description)
	self.tfTarget.text = ActivityUIApi:GetString("paidViewTaskTarget", self.taskData.CurrentNum, self.taskData.TargetNum)
end

return PaidChallengeTaskCell
