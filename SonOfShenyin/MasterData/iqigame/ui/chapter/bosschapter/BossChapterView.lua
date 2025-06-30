-- chunkname: @IQIGame\\UI\\Chapter\\BossChapter\\BossChapterView.lua

local bossChapterItem = require("IQIGame.UI.Chapter.BossChapter.BossChapterItem")
local m = {
	Items = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.Content = self.ScrollView:GetComponent("ScrollAreaList")

	function self.Content.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.Content.onRenderEnd()
		self:OnRenderEnd()
	end

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:SetData()
	self.passDataList = BossChapterModule.GetAllResourceChapters()

	self.Content:Refresh(#self.passDataList)
	UGUIUtil.SetText(self.ConsumTitle, ChapterUIApi:GetConsumText(BossChapterModule.ReduceConsumeCount(), CfgDiscreteDataTable[43].Data[1]))
end

function m:OnRenderItem(cell)
	local data = self.passDataList[cell.index + 1]
	local itemRow = self.Items[cell.gameObject]

	if itemRow == nil then
		itemRow = bossChapterItem.New(cell.gameObject)
		self.Items[cell.gameObject] = itemRow
	end

	itemRow:SetData(data, cell.index + 1)
end

function m:OnRenderEnd()
	return
end

function m:Dispose()
	self:RemoveListeners()

	for k, v in pairs(self.Items) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
