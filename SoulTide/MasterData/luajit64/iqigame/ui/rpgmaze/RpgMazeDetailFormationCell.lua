-- chunkname: @IQIGame\\UI\\RpgMaze\\RpgMazeDetailFormationCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(soulData, dollPOD)
	self.View:SetActive(soulData ~= nil)

	if soulData == nil then
		return
	end

	local cfgSoulResData = soulData:GetCfgSoulRes2D()
	local iconPath = UIGlobalApi.GetHarmoniousImagePath(cfgSoulResData.SoulSoulCard)

	AssetUtil.LoadImage(self, iconPath, self.SoulIcon:GetComponent("Image"))

	local cfgSoulLevelData = CfgSoulLevelTable[dollPOD.lv]
	local maxExp = cfgSoulLevelData.NextEXP

	self.ExpBar:GetComponent("Image").fillAmount = dollPOD.exp / maxExp

	UGUIUtil.SetText(self.LevelText, dollPOD.lv)
	self.FrontView:SetActive(dollPOD.position == 1)
	self.BackView:SetActive(dollPOD.position ~= 1)

	local cfgSoulData = soulData:GetCfgSoul()

	UGUIUtil.SetText(self.EngNameText, cfgSoulData.Name)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
