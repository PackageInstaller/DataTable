-- chunkname: @IQIGame\\UI\\Guild\\GuildDevelop\\GuildBuildingCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextMaxLevel, GuildDevelopUIApi:GetString("TextMaxLevel"))
	UGUIUtil.SetTextInChildren(self.EffectBtn, GuildDevelopUIApi:GetString("EffectBtnLabel"))

	function self.DelegateEffectBtn()
		self:OnEffectBtn()
	end

	self:AddListener()
end

function m:AddListener()
	self.EffectBtn:GetComponent("Button").onClick:AddListener(self.DelegateEffectBtn)
end

function m:RemoveListener()
	self.EffectBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateEffectBtn)
end

function m:UpdateView()
	local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(self.buildCid)
	local cfgGuildBuildingLevelUpData = GuildModule.GetBuildingLevelData(self.buildCid, buildLv)
	local cfgGuildBuildingData = CfgGuildBuildingTable[self.buildCid]

	UGUIUtil.SetText(self.TextTitle, cfgGuildBuildingData.Name)

	local path = UIGlobalApi.GetImagePath(cfgGuildBuildingData.Url)

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextLevelDes, cfgGuildBuildingLevelUpData.NowLevelDes)
	UGUIUtil.SetText(self.TextEffectDes, cfgGuildBuildingLevelUpData.NowEffectDes)
	UGUIUtil.SetText(self.TextCondition, cfgGuildBuildingLevelUpData.LockDesc)
	self.EffectBtn:SetActive(cfgGuildBuildingLevelUpData.TimeLimitEffectType > 0)
	self.ConditionNode:SetActive(buildLv < buildMaxLv)
	self.MaxNode:SetActive(buildMaxLv <= buildLv)
end

function m:SetData(buildCid, buildLv, buildMaxLv)
	self.buildCid = buildCid
	self.buildLv = buildLv
	self.buildMaxLv = buildMaxLv

	self:UpdateView()
end

function m:OnEffectBtn()
	UIModule.Open(Constant.UIControllerName.GuildDevelopBuyEffectUI, Constant.UILayer.UI, self.buildCid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
