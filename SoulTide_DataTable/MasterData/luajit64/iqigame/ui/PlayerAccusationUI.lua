-- chunkname: @IQIGame\\UI\\PlayerAccusationUI.lua

local PlayerAccusationUI = {
	tgs = {}
}

PlayerAccusationUI = Base:Extend("PlayerAccusationUI", "IQIGame.Onigao.UI.PlayerAccusationUI", PlayerAccusationUI)

function PlayerAccusationUI:OnInit()
	self:Initialize()
end

function PlayerAccusationUI:GetPreloadAssetPaths()
	return nil
end

function PlayerAccusationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlayerAccusationUI:IsManualShowOnOpen(userData)
	return false
end

function PlayerAccusationUI:GetBGM(userData)
	return nil
end

function PlayerAccusationUI:OnOpen(userData)
	self:Refresh(userData)
end

function PlayerAccusationUI:OnClose(userData)
	self:OnInit()
end

function PlayerAccusationUI:OnPause()
	return
end

function PlayerAccusationUI:OnResume()
	return
end

function PlayerAccusationUI:OnCover()
	return
end

function PlayerAccusationUI:OnReveal()
	return
end

function PlayerAccusationUI:OnRefocus(userData)
	return
end

function PlayerAccusationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlayerAccusationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlayerAccusationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlayerAccusationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlayerAccusationUI:Initialize()
	self.inputComp = self.goInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	for i = 1, 6 do
		self.tgs[i] = self.goToggleParent.transform:Find("Toggle_" .. i):GetComponent("Toggle")
		self.tgs[i].transform:Find("Text_01"):GetComponent("Text").text = PlayerAccusationUIApi:GetString("toggleName", i)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")
	self.btnSend = self.goBtnSend:GetComponent("Button")

	function self.onClickBtnToggleDelegate(isOn)
		self:OnToggle(isOn)
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnSendDelegate()
		self:OnClickBtnSend()
	end

	function self.onInputDelegate()
		self:OnInput()
	end

	self.goTitle:GetComponent("Text").text = PlayerAccusationUIApi:GetString("title")
	self.goBtnSend.transform:Find("Text"):GetComponent("Text").text = PlayerAccusationUIApi:GetString("btnSendTxt")
	self.inputComp.placeholder:GetComponent("Text").text = PlayerAccusationUIApi:GetString("defaultInputTxt")
end

function PlayerAccusationUI:Refresh(userData)
	self.playerData = userData
	self.inputComp.text = ""

	for i, v in pairs(self.tgs) do
		v.isOn = false
	end

	self.tgs[1].isOn = true
end

function PlayerAccusationUI:OnHide()
	return
end

function PlayerAccusationUI:OnDestroy()
	return
end

function PlayerAccusationUI:OnAddListeners()
	self.inputComp.onValueChanged:AddListener(self.onInputDelegate)
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnSend.onClick:AddListener(self.onClickBtnSendDelegate)

	for i, v in pairs(self.tgs) do
		v.onValueChanged:AddListener(self.onClickBtnToggleDelegate)
	end
end

function PlayerAccusationUI:OnRemoveListeners()
	self.inputComp.onValueChanged:RemoveListener(self.onInputDelegate)
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnSend.onClick:RemoveListener(self.onClickBtnSendDelegate)

	for i, v in pairs(self.tgs) do
		v.onValueChanged:RemoveListener(self.onClickBtnToggleDelegate)
	end
end

function PlayerAccusationUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function PlayerAccusationUI:OnClickBtnSend()
	local pid = self.playerData.PlayerSimplePOD.pid
	local channel = self.playerData.MsgData.channel
	local content = self.playerData.MsgData.content
	local reason = PlayerAccusationUIApi:GetString("toggleName", self.curIndex)
	local remark = self.inputComp.text

	ChatModule.ReqReportPlayer(pid, channel, content, reason, remark)
end

function PlayerAccusationUI:OnInput()
	return
end

function PlayerAccusationUI:OnToggle(isOn)
	if isOn then
		for i, v in ipairs(self.tgs) do
			if v.isOn then
				self.curIndex = i

				break
			end
		end
	end
end

return PlayerAccusationUI
