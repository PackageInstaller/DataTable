-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreInputNumberUIController.lua

require("IQIGame.UIExternalApi.DualTeamExploreInputNumberUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local DualTeamExploreInputNumCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreInputNumCell")
local DualTeamExploreInputNumberUIController = {
	NumberLimit = 0,
	Cid = 0,
	NumCells = {},
	NumberBtnMap = {},
	DelegateOnClickNumberBtnMap = {}
}

function DualTeamExploreInputNumberUIController.New(uiController)
	local obj = Clone(DualTeamExploreInputNumberUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreInputNumberUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreInputNumberUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreInputNumberUIController:OnInit()
	function self.DelegateOnClickBackspaceBtn()
		self:OnClickBackspaceBtn()
	end

	function self.DelegateOnClickCleanBtn()
		self:OnClickCleanBtn()
	end

	function self.DelegateOnClickCancelBtn()
		self:OnClickCancelBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	self.DisplayNumPool = UIObjectPool.New(6, function()
		return DualTeamExploreInputNumCell.New(UnityEngine.Object.Instantiate(self.DisplayNumPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	for number = 0, 10 do
		self.NumberBtnMap[number] = self.KeyboardNode.transform:Find("Button" .. number)
		self.DelegateOnClickNumberBtnMap[number] = function()
			self:OnClickNumberBtn(number)
		end
	end

	UGUIUtil.SetText(self.TitleText, DualTeamExploreInputNumberUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.CleanBtn, DualTeamExploreInputNumberUIApi:GetString("CleanBtnText"))
	UGUIUtil.SetTextInChildren(self.CancelBtn, DualTeamExploreInputNumberUIApi:GetString("CancelBtnText"))
	UGUIUtil.SetTextInChildren(self.ConfirmBtn, DualTeamExploreInputNumberUIApi:GetString("ConfirmBtnText"))
end

function DualTeamExploreInputNumberUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreInputNumberUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreInputNumberUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreInputNumberUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreInputNumberUIController:OnOpen(userData)
	self:UpdateView(userData.cid)
end

function DualTeamExploreInputNumberUIController:OnClose(userData)
	return
end

function DualTeamExploreInputNumberUIController:OnAddListeners()
	for num, btnGo in pairs(self.NumberBtnMap) do
		btnGo:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNumberBtnMap[num])
	end

	self.BackspaceBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBackspaceBtn)
	self.CleanBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCleanBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreInputNumberUIController:OnRemoveListeners()
	for num, btnGo in pairs(self.NumberBtnMap) do
		btnGo:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNumberBtnMap[num])
	end

	self.BackspaceBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBackspaceBtn)
	self.CleanBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCleanBtn)
	self.CancelBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCancelBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
end

function DualTeamExploreInputNumberUIController:OnPause()
	return
end

function DualTeamExploreInputNumberUIController:OnResume()
	return
end

function DualTeamExploreInputNumberUIController:OnCover()
	return
end

function DualTeamExploreInputNumberUIController:OnReveal()
	return
end

function DualTeamExploreInputNumberUIController:OnRefocus(userData)
	return
end

function DualTeamExploreInputNumberUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreInputNumberUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreInputNumberUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreInputNumberUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreInputNumberUIController:OnDestroy()
	self:ClearNum()
	self.DisplayNumPool:Dispose()

	for num, go in pairs(self.NumberBtnMap) do
		self.NumberBtnMap[num] = nil
	end

	for num, func in pairs(self.DelegateOnClickNumberBtnMap) do
		self.DelegateOnClickNumberBtnMap[num] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function DualTeamExploreInputNumberUIController:UpdateView(cid)
	self.Cid = cid

	local cfgDualTeamExploreNumberInputData = CfgDualTeamExploreNumberInputTable[self.Cid]

	UGUIUtil.SetText(self.DescText, cfgDualTeamExploreNumberInputData.Describe)
	self:ClearNum()

	self.NumberLimit = 0

	for i = 1, #cfgDualTeamExploreNumberInputData.Number do
		local optionalNumbers = cfgDualTeamExploreNumberInputData.Number[i]

		if #optionalNumbers > 0 then
			self.NumberLimit = self.NumberLimit + 1
		end
	end

	for i = 1, self.NumberLimit do
		local cell = self.DisplayNumPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.DisplayNumContainer.transform, false)
		table.insert(self.NumCells, cell)
	end

	self.InputNumbers = {}

	self:RefreshNumbers()
end

function DualTeamExploreInputNumberUIController:ClearNum()
	for i = 1, #self.NumCells do
		local cell = self.NumCells[i]

		cell.View.transform:SetParent(self.UIController.transform, false)
		cell.View:SetActive(false)
		self.DisplayNumPool:Release(cell)
	end

	self.NumCells = {}
end

function DualTeamExploreInputNumberUIController:RefreshNumbers()
	local numberReverseIndex = 0

	for i = #self.NumCells, 1, -1 do
		local cell = self.NumCells[i]
		local number = self.InputNumbers[#self.InputNumbers - numberReverseIndex]

		cell:SetData(number)

		numberReverseIndex = numberReverseIndex + 1
	end
end

function DualTeamExploreInputNumberUIController:OnClickNumberBtn(number)
	if #self.InputNumbers >= self.NumberLimit then
		return
	end

	table.insert(self.InputNumbers, number)
	self:RefreshNumbers()
end

function DualTeamExploreInputNumberUIController:OnClickBackspaceBtn()
	if #self.InputNumbers == 0 then
		return
	end

	table.remove(self.InputNumbers, #self.InputNumbers)
	self:RefreshNumbers()
end

function DualTeamExploreInputNumberUIController:OnClickCleanBtn()
	self.InputNumbers = {}

	self:RefreshNumbers()
end

function DualTeamExploreInputNumberUIController:OnClickCancelBtn()
	UIModule.CloseSelf(self)
	DualTeamExploreModule.SendInputNumber(0)
end

function DualTeamExploreInputNumberUIController:OnClickConfirmBtn()
	if #self.InputNumbers < self.NumberLimit then
		return
	end

	UIModule.CloseSelf(self)

	local cfgDualTeamExploreNumberInputData = CfgDualTeamExploreNumberInputTable[self.Cid]
	local easterEggRequireCount = #cfgDualTeamExploreNumberInputData.EasterEggNums

	if easterEggRequireCount > 0 then
		local easterEggCorrectCount = 0

		for i = 1, easterEggRequireCount do
			local easterEggNum = cfgDualTeamExploreNumberInputData.EasterEggNums[i]
			local inputNumber = self.InputNumbers[i]

			if inputNumber == easterEggNum then
				easterEggCorrectCount = easterEggCorrectCount + 1
			end
		end

		if easterEggCorrectCount == easterEggRequireCount then
			DualTeamExploreModule.SendInputNumber(3)

			return
		end
	end

	local normalRequireCount = self.NumberLimit
	local normalCorrectCount = 0

	for i = 1, normalRequireCount do
		local optionalNumbers = cfgDualTeamExploreNumberInputData.Number[i]

		if #optionalNumbers == 0 then
			logError("Number字段配置错误，有效数字不连续")
		end

		local inputNumber = self.InputNumbers[i]

		if table.indexOf(optionalNumbers, inputNumber) ~= -1 then
			normalCorrectCount = normalCorrectCount + 1
		end
	end

	local result

	result = normalCorrectCount == normalRequireCount and 1 or 2

	DualTeamExploreModule.SendInputNumber(result)
end

return DualTeamExploreInputNumberUIController
