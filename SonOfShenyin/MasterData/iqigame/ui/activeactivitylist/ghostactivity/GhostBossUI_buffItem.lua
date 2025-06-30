-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostBossUI_buffItem.lua

local GhostBossUI_buffItem = {}

function GhostBossUI_buffItem.New(go, mainView)
	local o = Clone(GhostBossUI_buffItem)

	o:Initialize(go, mainView)

	return o
end

function GhostBossUI_buffItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostBossUI_buffItem:InitComponent()
	return
end

function GhostBossUI_buffItem:InitDelegate()
	function self.delegateOnClickDetailsBtn()
		self:OnClickDetailsBtn()
	end
end

function GhostBossUI_buffItem:AddListener()
	self.DetailsBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickDetailsBtn)
end

function GhostBossUI_buffItem:RemoveListener()
	self.DetailsBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickDetailsBtn)
end

function GhostBossUI_buffItem:OnClickDetailsBtn()
	self.mainView:ShowBuffDetail(self.data)
end

function GhostBossUI_buffItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostBossUI_buffItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostBossUI_buffItem:Refresh(Data)
	self.data = Data

	local cfgBuff = CfgUtil.GetCfgBuffDataWithID(self.data)

	if LuaUtility.StrIsNullOrEmpty(cfgBuff.Icon) then
		logError("Buff: {0} 配置了 IsVisible 字段，但是未配置 icon", tostring(cfgBuff.Id))
	else
		local path = BattleApi:GetAttributeIconUrl(cfgBuff.Icon)

		AssetUtil.LoadImage(self, path, self.imageIcon:GetComponent(typeof(UnityEngine.UI.Image)))
	end
end

function GhostBossUI_buffItem:OnDestroy()
	return
end

return GhostBossUI_buffItem
