-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneStrengthenItem.lua

local m = {
	Discount = 0
}
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function m.New(view, onClickStrengthenBtn)
	local obj = Clone(m)

	obj:Init(view, onClickStrengthenBtn)

	return obj
end

function m:Init(view, onClickStrengthenBtn)
	self.View = view
	self.OnClickStrengthenBtnCallback = onClickStrengthenBtn

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickStrengthenBtn()
		self:OnClickStrengthenBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI)

	self.StrengthenBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStrengthenBtn)
	UGUIUtil.SetText(self.DescLabelText, EndlessMazeRuneStrengthenUIApi:GetString("DescLabelText"))
end

function m:SetData(mazeRunePOD, discount)
	self.MazeRunePOD = mazeRunePOD
	self.Discount = discount

	local cfgRuneData = CfgRuneTable[mazeRunePOD.CID]

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
	UGUIUtil.SetText(self.OldLevelText, EndlessMazeRuneStrengthenUIApi:GetString("LevelText", self.MazeRunePOD.Level))
	UGUIUtil.SetText(self.NewLevelText, EndlessMazeRuneStrengthenUIApi:GetString("LevelText", self.MazeRunePOD.Level + 1))

	if #cfgRuneData.StrengthenParam > 0 then
		local strengthenParam = cfgRuneData.StrengthenParam[mazeRunePOD.Level + 1]

		UGUIUtil.SetText(self.DescText, string.format(cfgRuneData.Describe, tostring(strengthenParam)))
	elseif cfgRuneData.Feature == Constant.Maze.RuneFeatureStrengthen then
		local strengthenParams = {}

		for i = 1, #cfgRuneData.Attribute do
			local attrId = cfgRuneData.Attribute[i][1]

			if attrId ~= nil then
				local attrLv1Value = cfgRuneData.Attribute[i][2]
				local attrDeltaValue = cfgRuneData.Attribute[i][3]
				local newLvAddAttrValue = attrLv1Value + attrDeltaValue * (mazeRunePOD.Level - 1)

				table.insert(strengthenParams, AttributeModule.GetAttShowValue(attrId, newLvAddAttrValue))
			end
		end

		UGUIUtil.SetText(self.DescText, string.format(cfgRuneData.Describe, unpack(strengthenParams)))
	end

	local cfgItemData = CfgItemTable[Constant.ItemID.CRYSTAL]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.CostItemNumText, tostring(math.max(1, math.floor(cfgRuneData.StrengthenCost[mazeRunePOD.Level] * self.Discount))))
end

function m:OnClickStrengthenBtn()
	self.OnClickStrengthenBtnCallback(self.MazeRunePOD)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.StrengthenBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStrengthenBtn)
	self.RuneCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
