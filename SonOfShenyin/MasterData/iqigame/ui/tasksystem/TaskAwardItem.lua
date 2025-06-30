-- chunkname: @IQIGame\\UI\\TaskSystem\\TaskAwardItem.lua

local TaskAwardItem = {}

function TaskAwardItem.New(go)
	local o = Clone(TaskAwardItem)

	o:Initialize(go)

	return o
end

function TaskAwardItem:Initialize(go)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.cellNormal = ExtendItemCellOne.New(self.item.gameObject)

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function TaskAwardItem:InitComponent()
	return
end

function TaskAwardItem:InitDelegate()
	return
end

function TaskAwardItem:AddListener()
	return
end

function TaskAwardItem:RemoveListener()
	return
end

function TaskAwardItem:Show(show)
	LuaUtility.SetGameObjectShow(self.gameObject, show)
end

function TaskAwardItem:Refresh(Data)
	self.Data = Data

	self.cellNormal:SetAwardData(self.Data.ItemData, self.Data.ActionParam[2])
end

function TaskAwardItem:Dispose()
	self.cellNormal:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return TaskAwardItem
