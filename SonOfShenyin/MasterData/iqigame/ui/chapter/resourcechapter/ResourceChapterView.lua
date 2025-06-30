-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\ResourceChapterView.lua

local resourceChapterItem = require("IQIGame.UI.Chapter.ResourceChapter.ResourceChapterItem")
local m = {
	passDataList = {},
	Items = {}
}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:Init(view, mainView)

	return obj
end

function m:Init(view, mainView)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.Content = self.ScrollView:GetComponent("ScrollAreaList")

	function self.Content.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData()
	self.passDataList = ResourceChapterModule.GetAllResourceChapters()

	self.Content:Refresh(#self.passDataList)
end

function m:OnRenderItem(cell)
	local data = self.passDataList[cell.index + 1]
	local itemRow = self.Items[cell.gameObject]

	if itemRow == nil then
		itemRow = resourceChapterItem.New(cell.gameObject)
		self.Items[cell.gameObject] = itemRow
	end

	itemRow:SetData(data)
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
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
