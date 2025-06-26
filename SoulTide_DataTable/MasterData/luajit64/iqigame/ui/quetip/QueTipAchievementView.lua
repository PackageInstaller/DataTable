-- chunkname: @IQIGame\\UI\\QueTip\\QueTipAchievementView.lua

local QueTipAchievementView = {}

function QueTipAchievementView.New(go)
	local obj = Clone(QueTipAchievementView)

	obj:Initialize(go)

	return obj
end

function QueTipAchievementView:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.tfName = self.goName:GetComponent("Text")
end

function QueTipAchievementView:Open(id)
	local cfgData = CfgMainQuestTable[id]

	self.goView:SetActive(true)

	self.tfName.text = QueueTipUIApi:GetString("achievementViewName", cfgData.Name)
end

function QueTipAchievementView:Close()
	self.goView:SetActive(false)
end

function QueTipAchievementView:Dispose()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return QueTipAchievementView
