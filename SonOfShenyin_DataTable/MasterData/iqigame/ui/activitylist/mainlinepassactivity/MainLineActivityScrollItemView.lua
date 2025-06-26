-- chunkname: @IQIGame\\UI\\ActivityList\\MainLinePassActivity\\MainLineActivityScrollItemView.lua

local activityRewardItem = require("IQIGame.UI.ActivityList.Common.PassActivityRewardItem")
local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.normalItem = activityRewardItem.New(self.rewardItem1)
	self.hithItem = activityRewardItem.New(self.rewardItem2)
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(normalTaskData, highTaskData, isBuyHigh)
	UGUIUtil.SetText(self.textLevel, normalTaskData.BaseData.Desc)
	LuaUtility.SetGameObjectShow(self.imageGet, normalTaskData.status == Constant.TaskStatus.hasDone or normalTaskData.status == Constant.TaskStatus.hadGot)
	self.normalItem:SetData(normalTaskData)
	self.hithItem:SetData(highTaskData)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.normalItem:Dispose()
	self.hithItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
