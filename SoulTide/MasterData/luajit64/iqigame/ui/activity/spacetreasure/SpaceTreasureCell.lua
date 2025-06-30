-- chunkname: @IQIGame\\UI\\Activity\\SpaceTreasure\\SpaceTreasureCell.lua

local m = {}

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.View = view
	self.root = root

	LuaCodeInterface.BindOutlet(self.View, self)

	local sortComponents = self.View:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = self.root.UIController.gameObject:GetComponent("Canvas")
	end

	function self.delegateBtnSelf()
		self:OnClickBtnSelf()
	end

	function self.delegateOnClickItemIcon()
		self:OnClickItemIcon()
	end

	self:AddListener()
	self:SetSelect(false)
end

function m:AddListener()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateBtnSelf)
	self.ImgIcon:GetComponent("Button").onClick:AddListener(self.delegateOnClickItemIcon)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSelf)
	self.ImgIcon:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickItemIcon)
end

function m:SetData(cfgID)
	self.cfgSpaceListID = cfgID

	self:UpdateView()
end

function m:UpdateView()
	local cfgSpaceList = CfgSpaceTreasureListTable[self.cfgSpaceListID]
	local costItemCid = cfgSpaceList.Cost[1]
	local needItemNum = cfgSpaceList.Cost[2]
	local haveNum = WarehouseModule.GetItemNumByCfgID(costItemCid)

	self.costItemCfgData = CfgItemTable[costItemCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.costItemCfgData.Icon), self.ImgIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.NameText, cfgSpaceList.SpaceName)
	UGUIUtil.SetText(self.ItemNumText, ActivityUIApi:GetString("SpaceTreasureCellItemNum", haveNum, needItemNum))

	self.ImgProgress:GetComponent("Image").fillAmount = haveNum / needItemNum

	self.ExploreEffect:SetActive(needItemNum <= haveNum)
end

function m:OnClickItemIcon()
	ItemModule.OpenTipByData(self.costItemCfgData, true)
end

function m:OnClickBtnSelf()
	if self.clickSelfCallBack then
		self.clickSelfCallBack(self)
	end
end

function m:SetSelect(top)
	self.CheckView:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.clickSelfCallBack = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
