-- chunkname: @IQIGame\\UI\\SettlementUI\\SettlementLevelView.lua

local SettlementLevelView = {}

function SettlementLevelView.New(go, mainView)
	local o = Clone(SettlementLevelView)

	o:Initialize(go, mainView)

	return o
end

function SettlementLevelView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function SettlementLevelView:InitComponent()
	return
end

function SettlementLevelView:InitDelegate()
	return
end

function SettlementLevelView:AddListener()
	return
end

function SettlementLevelView:RemoveListener()
	return
end

function SettlementLevelView:OnDestroy()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SettlementLevelView:Refresh(upExp)
	local curLvExp = 0
	local lv = PlayerModule.GetLevel()
	local config = CfgUtil.GetCfgPlayerLevelDataWithID(lv)

	curLvExp = PlayerModule.GetExp() - config.Experience
	curLvExp = curLvExp < 0 and 0 or curLvExp

	local Next_exp = config.Exp

	LuaUtility.SetGameObjectShow(self.maxRoot, false)
	LuaUtility.SetGameObjectShow(self.textCurrentExp, false)
	LuaUtility.SetText(self.textLevel, lv)

	if lv >= getCfgTableLength(CfgPlayerLevelTable) then
		LuaUtility.SetGameObjectShow(self.maxRoot, true)
	else
		LuaUtility.SetGameObjectShow(self.textCurrentExp, true)
		LuaUtility.SetText(self.textCurrentExp, curLvExp)
		LuaUtility.SetText(self.textMaxExp, Next_exp)
	end

	LuaUtility.SetText(self.textUpExp, upExp)
end

return SettlementLevelView
