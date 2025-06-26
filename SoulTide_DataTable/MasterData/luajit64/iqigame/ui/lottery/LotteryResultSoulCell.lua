-- chunkname: @IQIGame\\UI\\Lottery\\LotteryResultSoulCell.lua

local m = {
	SoulCid = 0
}

function m.New(view, mainCanvas)
	local obj = Clone(m)

	obj:Init(view, mainCanvas)

	return obj
end

function m:Init(view, mainCanvas)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	local sortComponents = self.View:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = mainCanvas
	end

	UGUIUtil.SetText(self.RepeatLabelText, LotteryUIApi:GetString("SoulFragmentLabelText"))
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
end

function m:SetData(soulCid, isNew)
	self.SoulCid = soulCid

	local cfgSoulData = CfgSoulTable[soulCid]
	local cfgSoulResData

	for i, cfgDressData in pairsCfg(CfgDressTable) do
		if cfgDressData.Type == Constant.DressType.Portrait and cfgDressData.InitialDress ~= 0 and cfgDressData.SoulID == soulCid then
			cfgSoulResData = CfgSoulResTable[cfgDressData.SoulResID]

			break
		end
	end

	if cfgSoulResData == nil then
		logError("灵魂 " .. soulCid .. "找不到初始时装对应的SoulRes")

		return
	end

	if cfgSoulResData.SoulPrayImage == "" then
		logError("灵魂 " .. soulCid .. "初始时装没有配置对应的SoulRes.SoulPrayImage")

		return
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgSoulResData.SoulPrayImage), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.NameText, cfgSoulData.Name)
	self.NewIcon:SetActive(isNew)
	self.RepeatNode:SetActive(not isNew)

	if not isNew then
		local itemCid = cfgSoulData.TransItem[1]
		local cfgItemData = CfgItemTable[itemCid]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.ChangeItemNumIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.ChangeItemNumText, LotteryUIApi:GetString("SoulFragmentNumText", cfgSoulData.TransItem[2]))
	end
end

function m:OnClickSelf()
	local soulData = SoulModule.GetSoulData(self.SoulCid)

	UIModule.Open(Constant.UIControllerName.SoulLockUI, Constant.UILayer.UI, soulData)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
