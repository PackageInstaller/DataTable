-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGamePlayerRecruit\\PlaceGamePlayerRecruitCell.lua

local m = {
	lv = 1,
	skillCells = {}
}
local PlaceGameFormationSkillCell = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameFormationChooseSoul.PlaceGameFormationSkillCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnRecruit()
		self:OnBtnRecruit()
	end

	self.SkillCellPrefab:SetActive(false)

	self.skillCells = {}

	for i = 1, 4 do
		local cell = PlaceGameFormationSkillCell.New(UnityEngine.Object.Instantiate(self.SkillCellPrefab))

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.SkillGrid.transform, false)

		self.skillCells[i] = cell
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnRecruit:GetComponent("Button").onClick:AddListener(self.DelegateBtnRecruit)
end

function m:RemoveListener()
	self.BtnRecruit:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRecruit)
end

function m:SetData(cid, lv)
	self.cid = cid
	self.lv = lv

	self:UpdateView()
end

function m:UpdateView()
	local cfgData = CfgPlaceGameSoulTable[self.cid]
	local path = UIGlobalApi.GetImagePath(cfgData.HeadIcon)

	AssetUtil.LoadImage(self, path, self.ImgHead:GetComponent("Image"))

	local cfgSkillGroupData = CfgSkillGroupTable[cfgData.DefaultSkill]

	self:ShowSkills(cfgSkillGroupData.GroupSkills)
	UGUIUtil.SetText(self.TextSoulName, cfgData.Name)
	UGUIUtil.SetText(self.TextLv, PlaceGamePlayerRecruitUIApi:GetString("TextLv", self.lv))
end

function m:ShowSkills(skillCids)
	for i = 1, #self.skillCells do
		local cell = self.skillCells[i]

		cell:SetData(skillCids[i], {}, 0)
	end
end

function m:OnBtnRecruit()
	PlaceGameModule.Recruit(self.cid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.skillCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
