-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyBag\\MonsterAcademyItemCell.lua

local m = {}
local MonsterAcademyItemData = require("IQIGame.Module.CommonActivity.MonsterAcademy.MonsterAcademyItemData")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:ShowNum(false)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.monsterAcademyItemData = data

	local qualityPath = MonsterAcademyBagUIApi:GetString("QualityBackgroundPath", self.monsterAcademyItemData.cfgInfo.Quality)

	AssetUtil.LoadImage(self, qualityPath, self.QualityImg:GetComponent("Image"))

	if self.monsterAcademyItemData.cfgInfo.Icon ~= "" and self.monsterAcademyItemData.cfgInfo.Icon ~= nil then
		local path = UIGlobalApi.GetImagePath(self.monsterAcademyItemData.cfgInfo.Icon)

		AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	else
		self.Icon:GetComponent("Image").sprite = nil
	end

	self:SetNum(self.monsterAcademyItemData.num)
end

function m:SetMonsterItemDataByID(cfgID, num)
	local monsterData = MonsterAcademyItemData.New(cfgID, num)

	self:SetData(monsterData)
end

function m:SetNum(num)
	UGUIUtil.SetText(self.TextNum, tostring(num))
end

function m:ShowNum(top)
	self.TextNum:SetActive(top)
end

function m:SetBottomCheckVisible(vs)
	self.CheckBottom:SetActive(vs)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
