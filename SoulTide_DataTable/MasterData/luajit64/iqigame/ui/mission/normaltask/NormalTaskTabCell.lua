-- chunkname: @IQIGame\\UI\\Mission\\NormalTask\\NormalTaskTabCell.lua

local NormalTaskTabCell = {}

function NormalTaskTabCell.New(view)
	local obj = Clone(NormalTaskTabCell)

	obj:Init(view)

	return obj
end

function NormalTaskTabCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfName2 = self.goName2:GetComponent("Text")
	self.tfEngName = self.goEngName:GetComponent("Text")
	self.tfEngName2 = self.goEngName2:GetComponent("Text")
	self.icon = self.goIcon:GetComponent("Image")
	self.icon2 = self.goIcon2:GetComponent("Image")
end

function NormalTaskTabCell:Refresh(groupType)
	self.groupType = groupType
	self.tfName.text = MissionUIApi:GetString("taskViewTabName", groupType, false)
	self.tfName2.text = MissionUIApi:GetString("taskViewTabName", groupType, true)
	self.tfEngName.text = MissionUIApi:GetString("taskViewTabEngName", groupType, false)
	self.tfEngName2.text = MissionUIApi:GetString("taskViewTabEngName", groupType, true)

	AssetUtil.LoadImage(self, MissionUIApi:GetString("taskViewToggleIconPath", groupType, false), self.icon)
	AssetUtil.LoadImage(self, MissionUIApi:GetString("taskViewToggleIconPath", groupType, true), self.icon2)
	self:RefreshRedPoint()
end

function NormalTaskTabCell:OnHide()
	return
end

function NormalTaskTabCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil

	AssetUtil.UnloadAsset(self)
end

function NormalTaskTabCell:RefreshRedPoint()
	self.goRedPoint:SetActive(self:CheckExistCanGetRewardTask())
end

function NormalTaskTabCell:CheckExistCanGetRewardTask()
	local processing = TaskModule.GetTaskProcessing(TaskModule.TaskType.NORMAL_TASK, {
		self.groupType
	})

	for i, v in pairs(processing) do
		if v.finNum >= v.tgtNum then
			return true
		end
	end

	return false
end

return NormalTaskTabCell
