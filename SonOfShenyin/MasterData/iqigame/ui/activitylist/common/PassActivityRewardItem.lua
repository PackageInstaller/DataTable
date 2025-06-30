-- chunkname: @IQIGame\\UI\\ActivityList\\Common\\PassActivityRewardItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.itemCell = ItemCell.New(self.commonSlotUI)

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(taskSystemData)
	local actionParams = UIUtil.GetConfigArr(taskSystemData.BaseData.ActionParam)

	self.itemCell:SetItemByCid(actionParams[1][1])
	self.itemCell:SetNum(actionParams[1][2])

	if taskSystemData.virtual == true and taskSystemData.status == Constant.TaskStatus.doing then
		LuaUtility.SetGameObjectShow(self.lockImg, true)
		LuaUtility.SetGameObjectShow(self.canGetImg, false)
		LuaUtility.SetGameObjectShow(self.receivedImg, false)
	else
		LuaUtility.SetGameObjectShow(self.canGetImg, taskSystemData.status == Constant.TaskStatus.hasDone)
		LuaUtility.SetGameObjectShow(self.receivedImg, taskSystemData.status == Constant.TaskStatus.hadGot)
		LuaUtility.SetGameObjectShow(self.lockImg, false)
	end
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self.itemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
