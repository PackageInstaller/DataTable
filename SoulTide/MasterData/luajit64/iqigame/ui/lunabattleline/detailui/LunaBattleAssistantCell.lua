-- chunkname: @IQIGame\\UI\\LunaBattleLine\\DetailUI\\LunaBattleAssistantCell.lua

local m = {
	IsMe = false
}

function m.New(view, isMe)
	local obj = Clone(m)

	obj:Init(view, isMe)

	return obj
end

function m:Init(view, isMe)
	self.View = view
	self.IsMe = isMe

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelfBtn()
		self:OnClickSelfBtn()
	end

	self.MyView:SetActive(isMe)
	self.OtherView:SetActive(not isMe)

	if isMe then
		self.IconGO = self.MyIcon
	else
		self.IconGO = self.OtherIcon
	end

	self:AddListeners()
end

function m:AddListeners()
	self.SelfBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelfBtn)
end

function m:RemoveListeners()
	self.SelfBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelfBtn)
end

function m:SetData(zonePOD, soulPrefab)
	self.ZonePOD = zonePOD

	self.View:SetActive(soulPrefab ~= nil)

	if soulPrefab == nil then
		return
	end

	local cfgDressData = CfgDressTable[soulPrefab.dress2DCid]
	local cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.HeadIcon), self.IconGO:GetComponent("Image"))
end

function m:OnClickSelfBtn()
	if self.IsMe then
		local defaultTabIndex = FormationModule.GetLastChooseFormationId()

		UIModule.Open(Constant.UIControllerName.LunaBattleLineFormationUI, Constant.UILayer.UI, {
			index = defaultTabIndex,
			onComplete = function(soulPrefabId)
				LunaBattleLineModule.SendGarrison(self.ZonePOD.zoneId, soulPrefabId, function(zoneId)
					self:SetData(self.ZonePOD, self.ZonePOD.garrison)
				end)
			end
		})
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.IconGO = nil
	self.ZonePOD = nil
end

return m
