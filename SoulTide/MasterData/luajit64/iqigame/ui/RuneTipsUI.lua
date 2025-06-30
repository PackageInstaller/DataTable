-- chunkname: @IQIGame\\UI\\RuneTipsUI.lua

local RuneTipsUI = Base:Extend("RuneTipsUI", "IQIGame.Onigao.UI.RuneTipsUI", {})
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function RuneTipsUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI, false)

	UGUIUtil.SetText(self.DescLabelText, RuneTipsUIApi:GetString("DescLabelText"))
	UGUIUtil.SetText(self.DetailLabelText, RuneTipsUIApi:GetString("DetailLabelText"))
end

function RuneTipsUI:GetPreloadAssetPaths()
	return nil
end

function RuneTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RuneTipsUI:OnOpen(userData)
	self:UpdateView(userData.runeCid, userData.mazeRunePOD)
end

function RuneTipsUI:OnClose(userData)
	return
end

function RuneTipsUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function RuneTipsUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function RuneTipsUI:OnPause()
	return
end

function RuneTipsUI:OnResume()
	return
end

function RuneTipsUI:OnCover()
	return
end

function RuneTipsUI:OnReveal()
	return
end

function RuneTipsUI:OnRefocus(userData)
	return
end

function RuneTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RuneTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RuneTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RuneTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RuneTipsUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.RuneCell:Dispose()
end

function RuneTipsUI:UpdateView(runeCid, mazeRunePOD)
	if runeCid == nil then
		if mazeRunePOD == nil then
			logError("参数runeCid, mazeRunePOD不能都为空")
		end

		runeCid = mazeRunePOD.CID
	end

	local cfgRuneData = CfgRuneTable[runeCid]
	local level = 1
	local finishNum = 0

	if mazeRunePOD ~= nil then
		level = mazeRunePOD.Level
		finishNum = mazeRunePOD.FinishNum
	end

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
	self.FeatureImg:SetActive(cfgRuneData.Feature ~= 0)

	if cfgRuneData.Feature ~= 0 then
		AssetUtil.LoadImage(self, EndlessMazeRuneMainUIApi:GetString("RuneCellFeatureImage", cfgRuneData.Feature), self.FeatureImg:GetComponent("Image"))
	end

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

function RuneTipsUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.RuneTipsUI)
end

return RuneTipsUI
