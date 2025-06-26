-- chunkname: @IQIGame\\UI\\EndlessMazeRune\\EndlessMazeRuneTipController.lua

local m = {
	IsShow = false
}
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickDescKeywordTipBtn()
		self:OnClickDescKeywordTipBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI, false)

	UGUIUtil.SetText(self.DescLabelText, RuneTipsUIApi:GetString("DescLabelText"))
	UGUIUtil.SetText(self.DetailLabelText, RuneTipsUIApi:GetString("DetailLabelText"))
end

function m:Show(mazeRunePOD)
	local cfgRuneData = CfgRuneTable[mazeRunePOD.CID]
	local level = mazeRunePOD.Level
	local finishNum = mazeRunePOD.FinishNum

	self:ShowByCfg(cfgRuneData, level, finishNum)
end

function m:ShowByCfgData(cfgRuneData, level, finishNum)
	self.IsShow = true

	self:ShowByCfg(cfgRuneData, level, finishNum)
	self:AddListeners()
end

function m:ShowByCfg(cfgRuneData, level, finishNum)
	level = level or 1
	finishNum = finishNum or 0

	self.View:SetActive(true)
	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
	AssetUtil.LoadImage(self, RuneTipsUIApi:GetString("QualityImage", cfgRuneData.Quality), self.QualityImg:GetComponent("Image"))

	local cfgRuneConstituteData = CfgRuneConstituteTable[cfgRuneData.TypeConstitute]

	UGUIUtil.SetText(self.TypeText, cfgRuneConstituteData.Name)

	cfgRuneConstituteData = CfgRuneConstituteTable[cfgRuneData.QualityConstitute]

	UGUIUtil.SetText(self.QualityText, cfgRuneConstituteData.Name)

	local descText = cfgRuneData.Describe

	if #cfgRuneData.StrengthenParam > 0 then
		descText = string.format(descText, tostring(cfgRuneData.StrengthenParam[level]))
	elseif cfgRuneData.Feature == Constant.Maze.RuneFeatureStrengthen then
		local params = {}

		for i = 1, #cfgRuneData.Attribute do
			local attrId = cfgRuneData.Attribute[i][1]

			if attrId ~= nil then
				local attrLv1Value = cfgRuneData.Attribute[i][2]
				local attrDeltaValue = cfgRuneData.Attribute[i][3]
				local curLvAddAttrValue = attrLv1Value + attrDeltaValue * (level - 1)

				table.insert(params, AttributeModule.GetAttShowValue(attrId, curLvAddAttrValue))
			end
		end

		descText = string.format(descText, unpack(params))
	end

	UGUIUtil.SetText(self.DescText, descText)

	local detailText = RuneTipsUIApi:GetString("DetailText", cfgRuneData.FeatureInfo, level, cfgRuneData.MaxStrengthenLevel)

	UGUIUtil.SetText(self.DetailText, detailText)

	if cfgRuneData.Target ~= 0 then
		local cfgTargetData = CfgTargetTable[cfgRuneData.Target]

		UGUIUtil.SetText(self.GrowProgressText, RuneTipsUIApi:GetString("GrowProgressText", cfgTargetData.TargetDes, finishNum, cfgTargetData.TargetNum))
	end

	self.DetailLabelNode:SetActive(cfgRuneData.Feature ~= 0)
	self.DetailText:SetActive(cfgRuneData.Feature ~= 0)
	self.GrowProgressText:SetActive(cfgRuneData.Feature ~= 0 and cfgRuneData.Target ~= 0)
end

function m:Hide()
	self.IsShow = false

	self:RemoveListeners()
	self.View:SetActive(false)
end

function m:AddListeners()
	self.DescKeywordTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDescKeywordTipBtn)
end

function m:RemoveListeners()
	self.DescKeywordTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDescKeywordTipBtn)
end

function m:OnClickDescKeywordTipBtn()
	if UIGlobalApi.CheckExistKeywordTag(self.RuneCell.CfgRuneData.Describe) then
		UIModule.Open(Constant.UIControllerName.LinkTipUI, Constant.UILayer.UI, {
			self.RuneCell.CfgRuneData.Describe,
			self.DescKeywordTipPoint,
			UGUISide.TopRight,
			UGUISide.TopLeft
		})
	end
end

function m:Dispose()
	if self.IsShow then
		self:RemoveListeners()
	end

	AssetUtil.UnloadAsset(self)
	self.RuneCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
