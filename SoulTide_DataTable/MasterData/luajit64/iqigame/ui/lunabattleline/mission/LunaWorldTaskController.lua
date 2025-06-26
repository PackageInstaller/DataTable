-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Mission\\LunaWorldTaskController.lua

local m = {}
local LunaWorldTaskRewardBox = require("IQIGame.UI.LunaBattleLine.Mission.LunaWorldTaskRewardBox")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.RewardBox = LunaWorldTaskRewardBox.New(self.RewardBoxView)
end

function m:SetData(taskUIData)
	if taskUIData ~= nil then
		local cfgMainQuestData = CfgMainQuestTable[taskUIData.cid]
		local cfgTargetData = CfgTargetTable[cfgMainQuestData.TargetId]

		UGUIUtil.SetText(self.NameText, LunaBattleLineMissionUIApi:GetString("WorldTaskNameText", taskUIData.CurrentNum, taskUIData.TargetNum, cfgTargetData.TargetDes))
		UGUIUtil.SetText(self.ProgressText, LunaBattleLineMissionUIApi:GetString("WorldTaskProgressText", taskUIData.CurrentNum, taskUIData.TargetNum))

		self.ProgressBar:GetComponent("Image").fillAmount = taskUIData.CurrentNum / taskUIData.TargetNum
	end

	self.RewardBox:SetData(taskUIData)
end

function m:Dispose()
	self.RewardBox:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
