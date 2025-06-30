-- chunkname: @IQIGame\\UI\\Lottery\\LotteryResultSoulFragmentCell.lua

local m = {}

function m.New(view, mainCanvas)
	local obj = Clone(m)

	obj:Init(view, mainCanvas)

	return obj
end

function m:Init(view, mainCanvas)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickIcon()
		self:OnClickIcon()
	end

	local sortComponents = self.View:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = mainCanvas
	end

	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickIcon)
end

function m:SetData(cfgItemData, num, isNew)
	self.CfgItemData = cfgItemData

	local iconPath

	for i, cfgSoulData in pairsCfg(CfgSoulTable) do
		if cfgSoulData.UnlockItem[1] == cfgItemData.Id then
			iconPath = UIGlobalApi.GetImagePath(cfgSoulData.FragmentIcon)

			break
		end
	end

	self.View:SetActive(false)
	AssetUtil.LoadAsset(self, iconPath, self.OnSuccess, self.OnFail, self.Icon:GetComponent("Image"))
	self.NewIcon:SetActive(isNew)
	UGUIUtil.SetText(self.NameText, cfgItemData.Name)
	UGUIUtil.SetText(self.ItemNumText, LotteryUIApi:GetString("SoulFragmentNumText", num))
end

function m:OnSuccess(assetName, asset, duration, userData)
	local image = userData

	image.sprite = LuaCodeInterface.ToSprite(asset)

	self.View:SetActive(true)
end

function m:OnFail(assetName, status, errorMessage, userData)
	return
end

function m:OnClickIcon()
	ItemModule.OpenTipByData(self.CfgItemData, true, true)
end

function m:Dispose()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickIcon)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
