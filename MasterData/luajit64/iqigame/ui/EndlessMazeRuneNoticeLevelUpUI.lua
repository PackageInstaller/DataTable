-- chunkname: @IQIGame\\UI\\EndlessMazeRuneNoticeLevelUpUI.lua

local EndlessMazeRuneNoticeLevelUpUI = Base:Extend("EndlessMazeRuneNoticeLevelUpUI", "IQIGame.Onigao.UI.EndlessMazeRuneNoticeLevelUpUI", {})
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function EndlessMazeRuneNoticeLevelUpUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI)

	local titleText1, titleText2 = EndlessMazeRuneNoticeApi:GetString("LevelUpTitleText")

	UGUIUtil.SetText(self.TitleText1, titleText1)
	UGUIUtil.SetText(self.TitleText2, titleText2)
end

function EndlessMazeRuneNoticeLevelUpUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneNoticeLevelUpUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneNoticeLevelUpUI:OnOpen(userData)
	self:UpdateView(userData.runeCid, userData.level)
end

function EndlessMazeRuneNoticeLevelUpUI:OnClose(userData)
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeLevelUpUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneNoticeLevelUpUI:OnPause()
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnResume()
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnCover()
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnReveal()
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneNoticeLevelUpUI:OnDestroy()
	self.RuneCell:Dispose()
end

function EndlessMazeRuneNoticeLevelUpUI:UpdateView(runeCid, level)
	local cfgRuneData = CfgRuneTable[runeCid]

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NameText, cfgRuneData.Name)
	UGUIUtil.SetText(self.OldLevelText, EndlessMazeRuneNoticeApi:GetString("LevelText", cfgRuneData.Name, level - 1, false))
	UGUIUtil.SetText(self.NewLevelText, EndlessMazeRuneNoticeApi:GetString("LevelText", cfgRuneData.Name, level, level == cfgRuneData.MaxStrengthenLevel))

	if #cfgRuneData.StrengthenParam > 0 then
		local oldStrengthenParam = cfgRuneData.StrengthenParam[level - 1]
		local newStrengthenParam = cfgRuneData.StrengthenParam[level]

		UGUIUtil.SetText(self.OldDescText, string.format(cfgRuneData.Describe, tostring(oldStrengthenParam)))
		UGUIUtil.SetText(self.NewDescText, string.format(cfgRuneData.Describe, tostring(newStrengthenParam)))
	elseif cfgRuneData.Feature == Constant.Maze.RuneFeatureStrengthen then
		local oldStrengthenParams = {}
		local newStrengthenParams = {}

		for i = 1, #cfgRuneData.Attribute do
			local attrId = cfgRuneData.Attribute[i][1]

			if attrId ~= nil then
				local attrLv1Value = cfgRuneData.Attribute[i][2]
				local attrDeltaValue = cfgRuneData.Attribute[i][3]
				local oldLvAddAttrValue = attrLv1Value + attrDeltaValue * (level - 2)
				local newLvAddAttrValue = attrLv1Value + attrDeltaValue * (level - 1)

				table.insert(oldStrengthenParams, AttributeModule.GetAttShowValue(attrId, oldLvAddAttrValue))
				table.insert(newStrengthenParams, AttributeModule.GetAttShowValue(attrId, newLvAddAttrValue))
			end
		end

		UGUIUtil.SetText(self.OldDescText, string.format(cfgRuneData.Describe, unpack(oldStrengthenParams)))
		UGUIUtil.SetText(self.NewDescText, string.format(cfgRuneData.Describe, unpack(newStrengthenParams)))
	end
end

function EndlessMazeRuneNoticeLevelUpUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneNoticeLevelUpUI)
end

return EndlessMazeRuneNoticeLevelUpUI
