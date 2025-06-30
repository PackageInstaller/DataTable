-- chunkname: @IQIGame\\UI\\Chapter\\MonsterDetailView_new.lua

local MonsterItemView = require("IQIGame.UI.Chapter.MonsterItemCell_new")
local m = {
	Items = {},
	cellList = {}
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateCloseBtnClick()
		self:Hide()
	end

	UGUIUtil.SetText(self.DetailsTitle1, ChapterUIApi:GetDetailsTitle(1))
	UGUIUtil.SetText(self.DetailsTitle2, ChapterUIApi:GetDetailsTitle(2))
	self:AddListeners()
end

function m:AddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateCloseBtnClick)
end

function m:RemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateCloseBtnClick)
end

function m:SetData(monsterTeamId)
	self.MonsterData = BossChapterModule.GetMonsterTeam(monsterTeamId)

	for i = #self.cellList, 1, -1 do
		UnityEngine.Object.Destroy(self.cellList[i].View.gameObject)
	end

	self.cellList = {}

	local GradeData = {}

	for i = 1, #self.MonsterData do
		local CfgData = CfgMonsterTable[self.MonsterData[i]]
		local Md = {}

		Md.MonsterID = self.MonsterData[i]
		Md.MonsterType = CfgData.MonsterType

		table.insert(GradeData, Md)
	end

	table.sort(GradeData, function(a, b)
		return a.MonsterType > b.MonsterType
	end)

	local SortMonsterData = {}
	local index = 1

	for i, v in pairs(GradeData) do
		SortMonsterData[index] = v.MonsterID
		index = index + 1
	end

	self.MonsterData = SortMonsterData

	for i = 1, #self.MonsterData do
		self:InstanceCell(i)
	end
end

function m:InstanceCell(index)
	local obj = UnityEngine.Object.Instantiate(self.BossItemCell)

	obj.transform:SetParent(self.BossScrollGrid.transform, false)
	obj:SetActive(true)

	local bossData = self.MonsterData[index]
	local item = MonsterItemView.New(obj.gameObject)

	item:SetData(bossData, function()
		self:SelectItemCell()
	end, index)
	item:OnUnSelect()
	table.insert(self.cellList, item)
end

function m:SelectItemCell(cell)
	for i = 1, #self.cellList do
		self.cellList[i]:OnUnSelect()
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()

	for i = #self.cellList, 1, -1 do
		UnityEngine.Object.Destroy(self.cellList[i].View.gameObject)
	end

	self.cellList = {}

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
