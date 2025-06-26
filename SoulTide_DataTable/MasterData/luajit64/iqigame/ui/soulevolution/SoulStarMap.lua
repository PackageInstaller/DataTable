-- chunkname: @IQIGame\\UI\\SoulEvolution\\SoulStarMap.lua

local SoulStarMap = {
	templatePool = {},
	bigStarPool = {},
	smallStarPool = {},
	linePool = {},
	starCellPool = {}
}
local SoulStarViewPoint = require("IQIGame.UI.SoulEvolution.SoulStarViewPoint")

function SoulStarMap.New(view, soulUI)
	local obj = Clone(SoulStarMap)

	obj:Init(view, soulUI)

	return obj
end

function SoulStarMap:Init(view, soulUI)
	self.View = view
	self.soulUI = soulUI

	LuaCodeInterface.BindOutlet(self.View, self)

	self.bigStarPool[1] = self.goBigStar
	self.smallStarPool[1] = self.goSmallStar
	self.linePool[1] = self.goStarLine
end

function SoulStarMap:Refresh(soulData)
	self.soulData = soulData
	self.cfgQualityDatum = self.soulData:GetAllCfgQuality()
	self.starCellPool = {}

	if self.templatePool[self.soulData.soulCid] == nil then
		local path = SoulUIApi:GetString("starViewMapPath", self.soulData.soulCid)

		AssetUtil.LoadAsset(self, path, self.OnLoadMapSuccess)

		return
	end

	self:ShowMap()
	self:FillStars()
end

function SoulStarMap:OnHide()
	for i, v in pairs(self.starCellPool) do
		v:OnHide()
	end

	for i, v in pairs(self.bigStarPool) do
		v.transform:SetParent(self.goBigPool.transform, false)
	end

	for i, v in pairs(self.smallStarPool) do
		v.transform:SetParent(self.goSmallPool.transform, false)
	end

	for i, v in pairs(self.linePool) do
		v.transform:SetParent(self.goLinePool.transform, false)
	end

	if self.template ~= nil then
		self.template.transform:SetParent(self.goTemplatePool.transform, false)
	end
end

function SoulStarMap:OnDestroy()
	AssetUtil.UnloadAsset(self)

	self.soulUI = nil

	for i, v in pairs(self.starCellPool) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function SoulStarMap:ShowMap()
	for i, v in pairs(self.templatePool) do
		v:SetActive(i == self.soulData.soulCid)
	end

	self.template = self.templatePool[self.soulData.soulCid]

	self.template.transform:SetParent(self.View.transform, false)
end

function SoulStarMap:FillStars()
	local lineRoot = self.template.transform:Find("Lines")

	for i = 1, lineRoot.childCount do
		local goLine = self:GetStarLine(i)

		if i < 10 then
			goLine.transform:SetParent(lineRoot:Find("Image_Line_0" .. i), false)
		else
			goLine.transform:SetParent(lineRoot:Find("Image_Line_" .. i), false)
		end
	end

	local startRoot = self.template.transform:Find("Panel")
	local bigIndex = 0
	local smallIndex = 0

	for i = 1, startRoot.childCount do
		if i <= #self.cfgQualityDatum then
			local cfgQuality = self.cfgQualityDatum[i]
			local isBig = cfgQuality.QualityLevel == 0
			local goStar

			if isBig then
				bigIndex = bigIndex + 1
				goStar = self:GetStarCell(bigIndex, self.bigStarPool, self.goBigPool)
			else
				smallIndex = smallIndex + 1
				goStar = self:GetStarCell(smallIndex, self.smallStarPool, self.goSmallPool)
			end

			goStar.transform:SetParent(startRoot:Find("Point_" .. i), false)

			local starCell = SoulStarViewPoint.New(goStar)

			self.starCellPool[#self.starCellPool + 1] = starCell

			if i > 1 then
				starCell.goLine = self.linePool[i - 1]
			end

			starCell:Refresh(self.soulData, cfgQuality)
		end
	end
end

function SoulStarMap:GetStarCell(index, pool, goPool)
	local ret = pool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(pool[1])
		pool[index] = ret

		ret.transform:SetParent(goPool.transform, false)
	end

	return ret
end

function SoulStarMap:GetStarLine(index)
	local ret = self.linePool[index]

	if ret == nil then
		ret = UnityEngine.Object.Instantiate(self.linePool[1])
		self.linePool[index] = ret

		ret.transform:SetParent(self.goLinePool.transform, false)
	end

	return ret
end

function SoulStarMap:OnLoadMapSuccess(assetName, asset, duration, userData)
	local go = UnityEngine.Object.Instantiate(asset)

	go.transform:SetParent(self.goTemplatePool.transform, false)

	self.templatePool[self.soulData.soulCid] = go
	go.transform:Find("Panel"):GetComponent("SortedComponentOrder").UIRootCanvas = self.soulUI.UIController:GetComponent("Canvas")
	go.transform:Find("Lines"):GetComponent("SortedComponentOrder").UIRootCanvas = self.soulUI.UIController:GetComponent("Canvas")

	self:Refresh(self.soulData)
end

function SoulStarMap:OnUpStarSuccess()
	for i, v in ipairs(self.starCellPool) do
		if v.isTarget then
			v:OnUpStarSuccess()
		elseif not v.isUnlock then
			v:RefreshState()
		end
	end
end

return SoulStarMap
