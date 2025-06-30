-- chunkname: @IQIGame\\UI\\HomeLandProcess\\HomeLandCompoundView.lua

local HomeLandCompoundView = {}
local ChildNeedItemCell = require("IQIGame.UI.HomeLandProcess.ChildNeedItemCell")
local TargetItemCell = require("IQIGame.UI.HomeLandProcess.TargetItemCell")

function HomeLandCompoundView.New(view)
	local obj = Clone(HomeLandCompoundView)

	obj:Init(view)

	return obj
end

function HomeLandCompoundView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.needItemCellTab = {}

	for i = 1, 3 do
		local needItemCell = ChildNeedItemCell.New(self["Item" .. i], i)

		self.needItemCellTab[i] = needItemCell
	end

	self.targetItemCell = TargetItemCell.New(self.TargetItem)

	UGUIUtil.SetText(self.TextTitle, HomeLandMakeItemListUIApi:GetString("CompoundText"))
end

function HomeLandCompoundView:AddListener()
	return
end

function HomeLandCompoundView:RemoveListener()
	return
end

function HomeLandCompoundView:UpdateView(processData, count)
	self.processData = processData
	self.count = count

	self.targetItemCell:SetData(self.processData.cfgInfo.ItemID)
	self.targetItemCell:SetNum(self.count)

	local len = #self.processData.cfgInfo.Props / 2

	for i = 1, #self.needItemCellTab do
		local cell = self.needItemCellTab[i]
		local id = 0
		local num = 0

		if i <= len then
			id = self.processData.cfgInfo.Props[i]
			num = self.processData.cfgInfo.Props[i + 1]
		end

		cell:SetData(id)
		cell:SetNum(self.count * num)
	end
end

function HomeLandCompoundView:Open()
	self:AddListener()
	self.View:SetActive(true)
end

function HomeLandCompoundView:Close()
	self:RemoveListener()
	self.View:SetActive(false)
end

function HomeLandCompoundView:Dispose()
	for i, v in pairs(self.needItemCellTab) do
		v:Dispose()
	end

	self.targetItemCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandCompoundView
