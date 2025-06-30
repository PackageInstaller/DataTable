-- chunkname: @IQIGame\\UI\\EndlessMazeRuneFilterUI.lua

local EndlessMazeRuneFilterUI = Base:Extend("EndlessMazeRuneFilterUI", "IQIGame.Onigao.UI.EndlessMazeRuneFilterUI", {
	TYPE_QUALITY = 1,
	TYPE_EFFECT = 2
})
local EndlessMazeRuneFilterPattern = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneFilterPattern")

function EndlessMazeRuneFilterUI:OnInit()
	function self.DelegateOnClickClearBtn()
		self:OnClickClearBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	local qualityOptions = EndlessMazeRuneFilterUIApi:GetString("QualityOptions")
	local tagOptions = EndlessMazeRuneFilterUIApi:GetString("TagOptions")
	local qualityTexts = EndlessMazeRuneFilterUIApi:GetString("QualityTexts")
	local tagTexts = EndlessMazeRuneFilterUIApi:GetString("TagTexts")

	self.Toggles = {}
	self.ToggleDataList = {}

	for i = 1, #qualityOptions do
		local toggleGO = UnityEngine.Object.Instantiate(self.TogglePrefab)

		toggleGO.transform:SetParent(self.QualityToggleGrid.transform, false)
		table.insert(self.Toggles, toggleGO:GetComponent("Toggle"))
		table.insert(self.ToggleDataList, {
			type = EndlessMazeRuneFilterUI.TYPE_QUALITY,
			index = i
		})

		toggleGO:GetComponent("ToggleHelperComponent").text = qualityTexts[i]
	end

	for i = 1, #tagTexts do
		for j = 1, #tagOptions[i] do
			local toggleGO = UnityEngine.Object.Instantiate(self.TogglePrefab)

			toggleGO.transform:SetParent(self["EffectToggleGrid" .. i].transform, false)
			table.insert(self.Toggles, toggleGO:GetComponent("Toggle"))
			table.insert(self.ToggleDataList, {
				type = EndlessMazeRuneFilterUI.TYPE_EFFECT,
				subType = i,
				index = j
			})

			toggleGO:GetComponent("ToggleHelperComponent").text = tagTexts[i][j]
		end
	end

	for i = 1, #self.Toggles do
		self["DelegateOnToggleValueChanged" .. i] = function(isOn)
			self:OnToggleValueChanged(i, isOn)
		end
	end

	self.FilterPattern = EndlessMazeRuneFilterPattern.New()

	for i = 1, 2 do
		local labelNode = self["LabelNode" .. i]
		local labelTextGO1 = labelNode.transform:Find("Text_01").gameObject
		local labelTextGO2 = labelNode.transform:Find("Text_02").gameObject
		local labelText1, labelText2 = EndlessMazeRuneFilterUIApi:GetString("FilterTypeLabel", i)

		UGUIUtil.SetText(labelTextGO1, labelText1)
		UGUIUtil.SetText(labelTextGO2, labelText2)
	end

	UGUIUtil.SetTextInChildren(self.ClearBtn, EndlessMazeRuneFilterUIApi:GetString("ClearBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, EndlessMazeRuneFilterUIApi:GetString("ConfirmBtnText"))
end

function EndlessMazeRuneFilterUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneFilterUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneFilterUI:OnOpen(userData)
	if userData.isCleared then
		self:Clear()
	end

	self.OnConfirmCallback = userData.onConfirm
end

function EndlessMazeRuneFilterUI:OnClose(userData)
	return
end

function EndlessMazeRuneFilterUI:OnAddListeners()
	for i = 1, #self.Toggles do
		local toggle = self.Toggles[i]

		toggle.onValueChanged:AddListener(self["DelegateOnToggleValueChanged" .. i])
	end

	self.ClearBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickClearBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneFilterUI:OnRemoveListeners()
	for i = 1, #self.Toggles do
		local toggle = self.Toggles[i]

		toggle.onValueChanged:RemoveListener(self["DelegateOnToggleValueChanged" .. i])
	end

	self.ClearBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickClearBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseBtn1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function EndlessMazeRuneFilterUI:OnPause()
	return
end

function EndlessMazeRuneFilterUI:OnResume()
	return
end

function EndlessMazeRuneFilterUI:OnCover()
	return
end

function EndlessMazeRuneFilterUI:OnReveal()
	return
end

function EndlessMazeRuneFilterUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneFilterUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneFilterUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneFilterUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneFilterUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneFilterUI:OnDestroy()
	self.Toggles = nil
end

function EndlessMazeRuneFilterUI:OnToggleValueChanged(index, isOn)
	local toggleData = self.ToggleDataList[index]
	local toggleGroupIndex = 0

	if toggleData.type == EndlessMazeRuneFilterUI.TYPE_QUALITY then
		local qualityOptions = EndlessMazeRuneFilterUIApi:GetString("QualityOptions")

		toggleGroupIndex = table.indexOf(self.FilterPattern.Qualities, qualityOptions[toggleData.index])

		if isOn then
			table.insert(self.FilterPattern.Qualities, qualityOptions[toggleData.index])
		elseif toggleGroupIndex ~= -1 then
			table.remove(self.FilterPattern.Qualities, toggleGroupIndex)
		end
	elseif toggleData.type == EndlessMazeRuneFilterUI.TYPE_EFFECT then
		local tagOptions = EndlessMazeRuneFilterUIApi:GetString("TagOptions")[toggleData.subType]

		toggleGroupIndex = table.indexOf(self.FilterPattern.Effects, tagOptions[toggleData.index])

		if isOn then
			table.insert(self.FilterPattern.Effects, tagOptions[toggleData.index])
		elseif toggleGroupIndex ~= -1 then
			table.remove(self.FilterPattern.Effects, toggleGroupIndex)
		end
	end
end

function EndlessMazeRuneFilterUI:OnClickClearBtn()
	self:Clear()
end

function EndlessMazeRuneFilterUI:Clear()
	self.FilterPattern:Clear()

	for i = 1, #self.Toggles do
		local toggle = self.Toggles[i]

		toggle.isOn = false
	end
end

function EndlessMazeRuneFilterUI:OnClickConfirmBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneFilterUI)

	if self.OnConfirmCallback ~= nil then
		self.OnConfirmCallback(self.FilterPattern)
	end
end

function EndlessMazeRuneFilterUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneFilterUI)
end

return EndlessMazeRuneFilterUI
