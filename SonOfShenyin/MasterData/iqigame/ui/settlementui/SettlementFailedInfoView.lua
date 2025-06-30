-- chunkname: @IQIGame\\UI\\SettlementUI\\SettlementFailedInfoView.lua

local SettlementFailedInfoView = {}

function SettlementFailedInfoView.New(go, mainView)
	local o = Clone(SettlementFailedInfoView)

	o:Initialize(go, mainView)

	return o
end

function SettlementFailedInfoView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SettlementFailedInfoView:InitComponent()
	return
end

function SettlementFailedInfoView:InitDelegate()
	function self.delegateOnClickJumpBtn()
		self:OnClickJumpBtn()
	end
end

function SettlementFailedInfoView:AddListener()
	self.jumpBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickJumpBtn)
end

function SettlementFailedInfoView:RemoveListener()
	self.jumpBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickJumpBtn)
end

function SettlementFailedInfoView:OnClickJumpBtn()
	local cfgData = CfgFunctionTable[self.jumpId]

	if cfgData == nil then
		logError("JumpModule.Jump : FunctionCid={0} is invalid.", self.jumpId)

		return
	end

	local funcType = cfgData.FuncSwitchOpen

	if funcType ~= 0 and UnlockFunctionModule.OnClickInterceptor(funcType) then
		return
	end

	WorldMapModule.ExitStoryOrLevel()
end

function SettlementFailedInfoView:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	AssetUtil.UnloadAsset(self)
end

function SettlementFailedInfoView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SettlementFailedInfoView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function SettlementFailedInfoView:Refresh(text, jumpId)
	self.jumpId = jumpId

	LuaUtility.SetText(self.HelpTitle, text)
end

return SettlementFailedInfoView
