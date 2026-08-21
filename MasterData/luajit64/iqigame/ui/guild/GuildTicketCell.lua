-- chunkname: @IQIGame\\UI\\Guild\\GuildTicketCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickTipBtn()
		self:OnTipBtn()
	end

	function self.DelegateGuildUpdate()
		self:RefreshNum()
	end

	function self.DelegateUpdateItem()
		self:UpdateItem()
	end

	function self.DelegateNumAttrOnChangeValue(key, value)
		self:OnNumAttrChangeValue(key, value)
	end

	self:AddListener()
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdate)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.DelegateNumAttrOnChangeValue)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdate)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.DelegateNumAttrOnChangeValue)
end

function m:OnNumAttrChangeValue(key, value)
	if self.itemID == key then
		self:RefreshNum()
	end
end

function m:UpdateItem()
	self:RefreshNum()
end

function m:RefreshData(cid)
	self.itemID = cid

	local path = UIGlobalApi.GetIconPath(CfgItemTable[self.itemID].Icon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))
	self:RefreshNum()
end

function m:RefreshNum()
	local count = 0

	if self.itemID == Constant.ItemID.GUILD_FUNDS then
		if GuildModule.guildPOD then
			count = GuildModule.guildPOD.fund
		end
	elseif self.itemID == Constant.ItemID.GUILD_PURCHASE_COUPONS then
		count = WarehouseModule.GetItemNumByCfgID(self.itemID)
	end

	UGUIUtil.SetText(self.ValueText, count)
end

function m:OnTipBtn()
	if self.itemID == nil then
		return
	end

	local limitStr

	if self.itemID == Constant.ItemID.GUILD_FUNDS then
		local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(Constant.GuildBuilding.Guild_BuildingLV)
		local cfgGuildBuildingLevelUpData = GuildModule.GetBuildingLevelData(Constant.GuildBuilding.Guild_BuildingLV, buildLv)
		local cfgGuildEffectData = CfgGuildEffectTypeTable[cfgGuildBuildingLevelUpData.EffectType]
		local fundDailyGetRecord = GuildModule.guildPOD.fundDailyGetRecord

		fundDailyGetRecord = fundDailyGetRecord == nil and 0 or fundDailyGetRecord
		limitStr = GuildMainUIApi:GetString("TextGuildFundsTicket", fundDailyGetRecord, cfgGuildEffectData.Param[2])
	end

	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = CfgItemTable[self.itemID].Name,
		content = CfgItemTable[self.itemID].Describe,
		refTrans = self.View.transform,
		limit = limitStr
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
