-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Mission\\LunaWorldTaskRewardBox.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickClaimBtn()
		self:OnClickClaimBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.ClaimBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClaimBtn)
end

function m:RemoveListeners()
	self.ClaimBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClaimBtn)
end

function m:SetData(taskUIData)
	self.TaskUIData = taskUIData

	self.ClaimBtn:SetActive(taskUIData == nil or taskUIData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK)
	self.OpenView:SetActive(taskUIData ~= nil and taskUIData.TaskStatus == TaskModule.TaskStatus.FINISH_TASK)
	self.RedPoint:SetActive(taskUIData ~= nil and taskUIData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and taskUIData.CurrentNum >= taskUIData.TargetNum)
end

function m:OnClickClaimBtn()
	if self.TaskUIData == nil then
		return
	end

	if self.TaskUIData.TaskStatus == TaskModule.TaskStatus.CURRENT_TASK and self.TaskUIData.CurrentNum >= self.TaskUIData.TargetNum then
		TaskModule.SendCommitTaskMsg(self.TaskUIData.cid)
	end
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.TaskUIData = nil
end

return m
