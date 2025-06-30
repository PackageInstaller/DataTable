-- chunkname: @IQIGame\\UI\\Chapter\\ResourceChapter\\GameLevelInfo\\EnemyDetailView.lua

local m = {
	SelectItemList = {}
}
local levelMonsterItem = require("IQIGame.UI.Chapter.ResourceChapter.GameLevelInfo.LevelMonsterItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.wrapContent = self.ScrollView:GetComponent("ScrollAreaList")

	function self.wrapContent.onRenderCell(cell)
		self:OnRenderItem(cell)
	end

	function self.wrapContent.onSelectedCell(cell)
		self:OnSelectCell(cell)
	end

	function self.wrapContent.onRenderEnd()
		self:OnRenderEnd()
	end

	UGUIUtil.SetText(self.EnemyInfoTitle, ChapterUIApi:GetPassInfoPanelTitle(1))
	UGUIUtil.SetText(self.SkillInfoTitle, ChapterUIApi:GetPassInfoPanelTitle(2))
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(levelData)
	self.LevelData = levelData

	local monsterTeam = CfgMonsterTeamTable[self.LevelData:GetCfg().MonsterTeam].MonsterTeam

	self.MonstersData = {}

	for i = 1, #monsterTeam do
		if monsterTeam[i] ~= 0 then
			table.insert(self.MonstersData, monsterTeam[i])
		end
	end

	self.wrapContent:Refresh(#self.MonstersData)
end

function m:OnRenderItem(cell)
	local MonsterID = self.MonstersData[cell.index + 1]
	local itemObj

	itemObj = levelMonsterItem.PackageOrReuseView(self, cell.gameObject)
	self.SelectItemList[cell.index + 1] = itemObj

	itemObj:SetData(MonsterID)
	itemObj:OnUnselected()

	if cell.index == 0 then
		self.firstCell = cell
	end
end

function m:OnSelectCell(cell)
	local itemObj = self.SelectItemList[cell.index + 1]

	self:UnselectedHeadCells()
	itemObj:OnClickCell()
	self:UpdateViewInfo(self.MonstersData[cell.index + 1])
end

function m:OnRenderEnd()
	self:OnSelectCell(self.firstCell)
end

function m:UnselectedHeadCells()
	for i, v in pairs(self.SelectItemList) do
		v:OnUnselected()
	end
end

function m:UpdateViewInfo(monsterID)
	UGUIUtil.SetText(self.EnemyNameText, CfgMonsterTable[monsterID].Name)
	UGUIUtil.SetText(self.IntoduceText, CfgMonsterTable[monsterID].Description)

	local skills = CfgMonsterTable[monsterID].SkillShow
	local skillDesc = ""

	for i = 1, #skills do
		skillDesc = skillDesc .. CfgSkillTable[skills[i]].Name .. ":" .. CfgSkillTable[skills[i]].EffectText .. "\n"
	end

	UGUIUtil.SetText(self.SkillText, ChapterUIApi:GetSkillDescValue(skillDesc))
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
