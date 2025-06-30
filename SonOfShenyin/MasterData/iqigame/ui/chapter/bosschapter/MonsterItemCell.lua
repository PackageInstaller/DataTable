-- chunkname: @IQIGame\\UI\\Chapter\\BossChapter\\MonsterItemCell.lua

local m = {
	isSelect = false,
	subItemList = {}
}
local SkillItemCell = require("IQIGame.UI.Chapter.BossChapter.SkillItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateSelectBtn()
		self:IsSelect()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateSelectBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateSelectBtn)
end

function m:SetData(bossData, func, index)
	self.SelectFunc = func
	self.CfgData = CfgMonsterTable[bossData]

	UGUIUtil.SetText(self.BossName, self.CfgData.Name)
	LuaUtility.SetGameObjectShow(self.BossSignImg, self.CfgData.MonsterType == 4)

	if self.CfgData.bust and self.CfgData.bust ~= "" then
		local path = BattleApi:GetMonsterBustPath(self.CfgData.Id)

		AssetUtil.LoadImage(self, path, self.BossSmallimg:GetComponent("Image"))
	end

	self:SetSubItem()
end

function m:SetSubItem()
	for i = #self.subItemList, 1, -1 do
		UnityEngine.Object.Destroy(self.subItemList[i].View)
	end

	self.subItemList = {}

	local subSkillsData = self.CfgData.Skill

	for i = 1, #subSkillsData do
		local obj = UnityEngine.Object.Instantiate(self.SkillItemCell)

		obj.transform:SetParent(self.SkillItemParent.transform, false)
		obj:SetActive(true)

		local item = SkillItemCell.New(obj)

		item:SetData(subSkillsData[i])
		table.insert(self.subItemList, item)
	end
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:IsSelect()
	if self.isSelect then
		self:OnUnSelect()
	elseif self.SelectFunc ~= nil then
		self.SelectFunc(self)
		self:OnSelect()
	end

	self.isSelect = not self.isSelect
end

function m:OnUnSelect()
	self.SkillItemParent:SetActive(false)
end

function m:OnSelect()
	self.SkillItemParent:SetActive(true)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
