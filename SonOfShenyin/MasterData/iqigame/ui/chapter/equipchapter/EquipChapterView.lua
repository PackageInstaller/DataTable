-- chunkname: @IQIGame\\UI\\Chapter\\EquipChapter\\EquipChapterView.lua

local EquipChapterView = {
	Items = {}
}
local equipChapterItem = require("IQIGame.UI.Chapter.EquipChapter.EquipChapterItem")

function EquipChapterView.New(view)
	local obj = Clone(EquipChapterView)

	obj:Init(view)

	return obj
end

function EquipChapterView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.Content = self.ScrollView:GetComponent("ScrollAreaList")

	function self.Content.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	self:AddListeners()
end

function EquipChapterView:AddListeners()
	return
end

function EquipChapterView:RemoveListeners()
	return
end

function EquipChapterView:SetData()
	self.passDataList = EquipChapterModule.GetAllResourceChapters()

	self.Content:Refresh(#self.passDataList)
end

function EquipChapterView:OnRenderItem(cell)
	local itemRow = self.Items[cell.gameObject]

	if itemRow == nil then
		itemRow = equipChapterItem.New(cell.gameObject)
		self.Items[cell.gameObject] = itemRow
	end

	local data = self.passDataList[cell.index + 1]

	itemRow:SetData(data)
end

function EquipChapterView:Show()
	self.View:SetActive(true)
end

function EquipChapterView:Hide()
	self.View:SetActive(false)
end

function EquipChapterView:Dispose()
	self:RemoveListeners()

	for _, v in pairs(self.Items) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return EquipChapterView
