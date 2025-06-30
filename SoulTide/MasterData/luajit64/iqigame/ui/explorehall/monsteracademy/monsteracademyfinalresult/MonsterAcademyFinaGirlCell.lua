-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyFinalResult\\MonsterAcademyFinaGirlCell.lua

local m = {
	monsterGirlStarPool = {}
}
local MonsterAcademyGirlStarCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyGirlStarCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.monsterGirlStarPool = {}

	for i = 1, 5 do
		local starCell = MonsterAcademyGirlStarCell.New(self["Star" .. i], i)

		self.monsterGirlStarPool[i] = starCell
	end

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.girlData = data

	self:UpdateView()
end

function m:UpdateView()
	local path = UIGlobalApi.GetImagePath(self.girlData.cfgInfo.HeadPortrait)

	AssetUtil.LoadImage(self, path, self.ImgHeadIcon:GetComponent("Image"))

	local favorStage, LoveStage = self.girlData:GetGirlStage()

	UGUIUtil.SetText(self.TextFavor, LoveStage)

	for i, v in pairs(self.monsterGirlStarPool) do
		local num, maxNum = self:GetPerValue(i)

		v:SetData(num, maxNum)
	end
end

function m:GetPerValue(index)
	local num = 0
	local maxNum = 0
	local tab = {}

	for i, v in pairsCfg(CfgGalgameMonsterGirlFavorTable) do
		if v.SoulID == self.girlData.cfgID then
			tab[v.FavorStage] = v
		end
	end

	local preIndex = index - 1
	local preCfg = tab[preIndex]
	local curCfg = tab[index]
	local favorStage, LoveStage = self.girlData:GetGirlStage()

	if index < favorStage then
		if preCfg then
			maxNum = curCfg.FavorValue - preCfg.FavorValue
		else
			maxNum = curCfg.FavorValue
		end

		num = maxNum
	else
		if preCfg then
			maxNum = curCfg.FavorValue - preCfg.FavorValue
			num = self.girlData.favor - preCfg.FavorValue
		else
			maxNum = curCfg.FavorValue
			num = self.girlData.favor
		end

		num = num < 0 and 0 or num
	end

	return num, maxNum
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.monsterGirlStarPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
