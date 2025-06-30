-- chunkname: @IQIGame\\UI\\ActivityList\\LotteryActivity\\LotteryActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local m = Clone(ActivityViewBase)

function m:__Init()
	function self.DelegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end
end

function m:__AddListeners()
	self.jumpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickJumpBtn)
end

function m:__RemoveListeners()
	self.jumpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickJumpBtn)
end

function m:__SetData(activityListCfg)
	self.activityListCfg = activityListCfg

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.activityListCfg.ChapterNameImg), self.background:GetComponent("Image"))
end

function m:__Dispose()
	return
end

function m:OnClickJumpBtn()
	JumpModule.Jump(self.activityListCfg.Jump)
end

return m
