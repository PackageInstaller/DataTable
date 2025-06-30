-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostBossUI_buffDetailPanel.lua

local GhostBossUI_buffDetailPanel = {}

function GhostBossUI_buffDetailPanel.New(go, mainView)
	local o = Clone(GhostBossUI_buffDetailPanel)

	o:Initialize(go, mainView)

	return o
end

function GhostBossUI_buffDetailPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostBossUI_buffDetailPanel:InitComponent()
	return
end

function GhostBossUI_buffDetailPanel:InitDelegate()
	function self.delegateOnClickButtonClose()
		self:Hide()
	end
end

function GhostBossUI_buffDetailPanel:AddListener()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
end

function GhostBossUI_buffDetailPanel:RemoveListener()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
end

function GhostBossUI_buffDetailPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostBossUI_buffDetailPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostBossUI_buffDetailPanel:Refresh(Data)
	self.data = Data

	local cfgBuff = CfgUtil.GetCfgBuffDataWithID(self.data)

	if LuaUtility.StrIsNullOrEmpty(cfgBuff.Icon) then
		logError("Buff: {0} 配置了 IsVisible 字段，但是未配置 icon", tostring(cfgBuff.Id))
	else
		local path = BattleApi:GetAttributeIconUrl(cfgBuff.Icon)

		AssetUtil.LoadImage(self, path, self.imageIcon:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	LuaUtility.SetText(self.textName, cfgBuff.Name)
	LuaUtility.SetText(self.textDetail, cfgBuff.Describe)
end

function GhostBossUI_buffDetailPanel:OnDestroy()
	return
end

return GhostBossUI_buffDetailPanel
