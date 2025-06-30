-- chunkname: @IQIGame\\UI\\MagicTower\\MagicTowerTaskItemState.lua

local ActivityTaskItemState = require("IQIGame.UI.Activity.Common.ActivityTaskItemState")
local m = {}

m = extend(ActivityTaskItemState, m)

function m.New(view, state, rewardPool, api, onClick)
	local obj = Clone(m)

	obj:Init(view, state, rewardPool, api, onClick)

	return obj
end

function m:SetData(taskUIData, taskState)
	self:BaseSetData(taskUIData, taskState)

	if self.InitState == taskState then
		UGUIUtil.SetText(self.PercentText, self.Api:GetString("TaskItemPercentText", taskUIData.CurrentNum, taskUIData.TargetNum))

		if self.PercentBar ~= nil then
			self.PercentBar:GetComponent("Image").fillAmount = taskUIData.CurrentNum / taskUIData.TargetNum
		end
	end
end

function m:Dispose()
	self:BaseDispose()
end

return m
