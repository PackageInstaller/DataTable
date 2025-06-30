-- chunkname: @IQIGame\\UI\\TurntableGameUI.lua

local TurntableGameUI = {
	RotateSpeed = 0,
	StartSlowdown = false,
	DefaultAcceleration = -80,
	DefaultSpeed = 40,
	StartRotate = false,
	PointerRotationZ = 0,
	InMaze = false,
	CellPoolMap = {},
	TurntableCells = {},
	PointerRotation = Quaternion.identity
}

TurntableGameUI = Base:Extend("TurntableGameUI", "IQIGame.Onigao.UI.TurntableGameUI", TurntableGameUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local TurntableGameCell = require("IQIGame.UI.TurntableGame.TurntableGameCell")

function TurntableGameUI:OnInit()
	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickCloseTipBtn()
		self:OnClickCloseTipBtn()
	end

	self.ItemIconBtnPool = UIObjectPool.New(8, function()
		local imageBtn = UnityEngine.Object.Instantiate(self.IconBtn)

		return imageBtn
	end, function(btnGo)
		UnityEngine.Object.Destroy(btnGo)
	end)

	self:CreateCellPool(45)
	self:CreateCellPool(60)
	self:CreateCellPool(90)

	self.DefaultSpeed = TurntableGameUIApi:GetString("DefaultSpeed")
	self.DefaultAcceleration = TurntableGameUIApi:GetString("DefaultAcceleration")

	UGUIUtil.SetText(self.StartBtn, TurntableGameUIApi:GetString("StartBtnText"))
	UGUIUtil.SetText(self.ConfirmBtn, TurntableGameUIApi:GetString("ConfirmBtnText"))
	UGUIUtil.SetText(self.CloseBtn, TurntableGameUIApi:GetString("CloseBtnText"))
	self.TipView:SetActive(false)
	self.CloseTipBtn:SetActive(false)
end

function TurntableGameUI:GetPreloadAssetPaths()
	return nil
end

function TurntableGameUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TurntableGameUI:IsManualShowOnOpen(userData)
	return false
end

function TurntableGameUI:GetBGM(userData)
	return nil
end

function TurntableGameUI:OnOpen(userData)
	self:UpdateView(userData.turntableCid, userData.inMaze)
end

function TurntableGameUI:OnClose(userData)
	return
end

function TurntableGameUI:OnAddListeners()
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.CloseTipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseTipBtn)
end

function TurntableGameUI:OnRemoveListeners()
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickConfirmBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.CloseTipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseTipBtn)
end

function TurntableGameUI:OnPause()
	return
end

function TurntableGameUI:OnResume()
	return
end

function TurntableGameUI:OnCover()
	return
end

function TurntableGameUI:OnReveal()
	return
end

function TurntableGameUI:OnRefocus(userData)
	return
end

function TurntableGameUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.StartRotate or self.StartSlowdown then
		local elapseTime = elapseSeconds
		local acceleration = self.StartSlowdown and self.DefaultAcceleration or 0

		self.RotateSpeed = self.RotateSpeed + acceleration * elapseSeconds
		self.PointerRotationZ = self.PointerRotationZ - self.RotateSpeed * elapseTime

		if self.PointerRotationZ <= 0 then
			self.PointerRotationZ = self.PointerRotationZ + 360
		end

		self.PointerRotation:SetEuler(0, 0, self.PointerRotationZ)

		self.Pointer.transform.localRotation = self.PointerRotation

		self:RefreshCellHighlight(false)

		if self.RotateSpeed <= 0 then
			self:RotateComplete()
		end
	end
end

function TurntableGameUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TurntableGameUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TurntableGameUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TurntableGameUI:OnDestroy()
	self:ClearCells(true)

	for i = 1, #self.TurntableCells do
		local cell = self.TurntableCells[i]

		cell:Dispose()
	end

	self.TurntableCells = nil

	for i, pool in pairs(self.CellPoolMap) do
		pool:Dispose()
	end

	self.ItemIconBtnPool:Dispose()
end

function TurntableGameUI:CreateCellPool(angleType)
	local cellPool = UIObjectPool.New(360 / angleType, function()
		local go = UnityEngine.Object.Instantiate(self["RewardPrefab" .. angleType])
		local cell = TurntableGameCell.New(go, angleType, self.ItemIconBtnPool, function(index)
			self:OnClickCell(index)
		end)

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	self["CellPool" .. angleType] = cellPool
	self.CellPoolMap[angleType] = cellPool
end

function TurntableGameUI:UpdateView(turntableCid, inMaze)
	self.CfgTurntableData = CfgTurnTableTable[turntableCid]
	self.InMaze = inMaze

	local cellNum = #self.CfgTurntableData.CardType

	if cellNum ~= 4 and cellNum ~= 6 and cellNum ~= 8 then
		logError("道具数量不是约定的4/6/8而是" .. cellNum .. " turntable cid: " .. turntableCid)

		cellNum = cellNum > 8 and 8 or cellNum > 6 and 6 or 4
	end

	self:ClearCells()

	local angleType = 360 / cellNum
	local cellPool = self.CellPoolMap[angleType]

	self.TurntableCells = {}

	for i = 1, cellNum do
		local cell = cellPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.RewardPlate.transform, false)
		cell:OnObtain(i)
		cell:SetData(self.CfgTurntableData.CardIcon[i])

		self.TurntableCells[i] = cell
	end

	self:Reset()

	self.RotateSpeed = self.DefaultSpeed * self.CfgTurntableData.RotateVelocity
	self.PointerRotationZ = 80
	self.Pointer.transform.localRotation = Quaternion.Euler(0, 0, self.PointerRotationZ)

	self:RefreshCellHighlight(true)
end

function TurntableGameUI:ClearCells(isDestroy)
	for i = 1, #self.TurntableCells do
		local cell = self.TurntableCells[i]
		local pool = self.CellPoolMap[cell.AngleType]

		if not isDestroy then
			cell.View.transform:SetParent(self.UIController.transform, false)
		end

		cell.View:SetActive(false)
		cell:OnRelease()
		pool:Release(cell)
	end

	self.TurntableCells = {}
end

function TurntableGameUI:Reset()
	self.StartBtn:SetActive(true)
	self.ConfirmBtn:SetActive(false)
	self.CloseBtn:SetActive(false)
end

function TurntableGameUI:RefreshCellHighlight(isInit)
	for i = 1, #self.TurntableCells do
		local cell = self.TurntableCells[i]
		local angle = cell.AngleType * (cell.Index - 1)

		if angle < self.PointerRotationZ and self.PointerRotationZ <= angle + cell.AngleType then
			cell:SetHighlight(true, isInit)
		else
			cell:SetHighlight(false, isInit)
		end
	end
end

function TurntableGameUI:RotateComplete()
	self.StartRotate = false
	self.StartSlowdown = false

	self.CloseBtn:SetActive(true)
end

function TurntableGameUI:OnClickCell(index)
	self.TipView:SetActive(true)
	self.CloseTipBtn:SetActive(true)

	local desc = self.CfgTurntableData.CardDescribe[index]

	UGUIUtil.SetTextInChildren(self.TipView, desc)

	local cell = self.TurntableCells[index]

	self.TipView.transform.position = cell.ItemIconBtn.transform.position
end

function TurntableGameUI:OnClickCloseTipBtn()
	self.TipView:SetActive(false)
	self.CloseTipBtn:SetActive(false)
end

function TurntableGameUI:OnClickStartBtn()
	self.StartBtn:SetActive(false)
	self.ConfirmBtn:SetActive(true)

	self.StartRotate = true
end

function TurntableGameUI:OnClickConfirmBtn()
	self.ConfirmBtn:SetActive(false)

	self.StartSlowdown = true

	GameEntry.Sound:PlaySound(10510, Constant.SoundGroup.UI)
end

function TurntableGameUI:OnClickCloseBtn()
	local highlightIndex = 1

	for i = 1, #self.TurntableCells do
		local cell = self.TurntableCells[i]

		if cell.IsHighlight then
			highlightIndex = i

			break
		end
	end

	UIModule.CloseSelf(self)
	TurntableGameModule.SendChooseCard(highlightIndex, self.InMaze)
end

return TurntableGameUI
