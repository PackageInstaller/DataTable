-- chunkname: @IQIGame\\UI\\Girl\\dress\\DressView.lua

local DressView = {
	dressCellPool = {}
}
local DressCell = require("IQIGame.UI.Girl.dress.DressCell")
local Live2DHarmoniousMask = require("IQIGame.UI.Common.Live2DHarmoniousMask")

function DressView.New(view)
	local obj = Clone(DressView)

	obj:Init(view)

	return obj
end

function DressView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.l2dBuilder = self.goLive2D:GetComponent("L2DBuilderGirl")
	self.live2DHarmoniousMask = Live2DHarmoniousMask.New(self.goLive2D)
	self.tfDressName = self.goDressName:GetComponent("Text")
	self.tfConditionDesc = self.goConditionDesc:GetComponent("Text")
	self.btnDress = self.goBtnDress:GetComponent("Button")
	self.btnCustom = self.goBtnCustom:GetComponent("Button")

	function self.onClickBtnCustomDelegate()
		self:OnClickBtnCustom()
	end

	function self.onClickBtnDressDelegate()
		self:OnClickBtnDress()
	end

	function self.onDressSuccessDelegate()
		self:OnDressSuccess()
	end

	function self.onDressUnlockNewDelegate(dressCid)
		self:OnDressUnlockNew(dressCid)
	end

	function self.onSoulChangeDelegate(soulCid)
		self:OnSoulChange(soulCid)
	end

	self.dressList = self.goDressList:GetComponent("ScrollAreaList")

	function self.dressList.onRenderCell(cell)
		self:OnRenderDressCell(cell)
	end

	function self.dressList.onSelectedCell(cell)
		self:OnSelectDressCell(cell)
	end

	self.goTitle:GetComponent("Text").text = GirlUIApi:GetString("dressViewTitle")
	self.goBtnDress.transform:Find("Text"):GetComponent("Text").text = GirlUIApi:GetString("dressViewBtnDressTxt")
	self.goBtnCloseTxt:GetComponent("Text").text = GirlUIApi:GetString("dressViewBtnCloseTxt")
	self.goSignWore:GetComponent("Text").text = GirlUIApi:GetString("dressViewBottomSignWoreTxt")
end

function DressView:Open(soulCid)
	self:SetActive(true)

	self.soulData = SoulModule.GetSoulData(soulCid)
	self.dressDatum = self.soulData.dress2DDataList

	self:RefreshDressList()
	self:OnAddListeners()
end

function DressView:Close()
	self:OnHide()
	SoulModule.ChangeL2DSkin(self.l2dBuilder, self.soulData, self.soulData:GetCfgDress2D())
end

function DressView:OnHide()
	for i, v in pairs(self.dressCellPool) do
		v:OnHide()
	end

	self:OnRemoveListeners()
end

function DressView:OnDestroy()
	for i, v in pairs(self.dressCellPool) do
		v:OnDestroy()
	end

	self.live2DHarmoniousMask:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function DressView:OnAddListeners()
	self:OnRemoveListeners()
	self.btnDress.onClick:AddListener(self.onClickBtnDressDelegate)
	self.btnCustom.onClick:AddListener(self.onClickBtnCustomDelegate)
	EventDispatcher.AddEventListener(EventID.DressWearSuccess, self.onDressSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.DressUnlockNew, self.onDressUnlockNewDelegate)
	EventDispatcher.AddEventListener(EventID.SoulChanged, self.onSoulChangeDelegate)
end

function DressView:OnRemoveListeners()
	self.btnDress.onClick:RemoveListener(self.onClickBtnDressDelegate)
	self.btnCustom.onClick:RemoveListener(self.onClickBtnCustomDelegate)
	EventDispatcher.RemoveEventListener(EventID.DressWearSuccess, self.onDressSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.DressUnlockNew, self.onDressUnlockNewDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulChanged, self.onSoulChangeDelegate)
end

function DressView:OnSoulChange(soulCid)
	if soulCid == self.soulData.soulCid then
		return
	end

	self.isChangeSoul = true

	self:Open(soulCid)
end

function DressView:OnRenderDressCell(grid)
	local luaIndex = grid.index + 1
	local insID = grid.gameObject:GetInstanceID()
	local dressData = self.dressDatum[luaIndex]
	local cell = self.dressCellPool[insID]

	if cell == nil then
		cell = DressCell.New(grid.transform:GetChild(0).gameObject)
		self.dressCellPool[insID] = cell
	end

	cell:Refresh(dressData)
	cell:SetSignSelectVisible(self.curDressData ~= nil and cell.dressData.dressCid == self.curDressData.dressCid)
end

function DressView:OnSelectDressCell(grid)
	local luaIndex = grid.index + 1

	self.curDressData = self.dressDatum[luaIndex]

	for i, v in pairs(self.dressCellPool) do
		v:SetSignSelectVisible(v.dressData.dressCid == self.curDressData.dressCid)
	end

	self:RefreshOnCurSelectDress()
end

function DressView:OnClickBtnDress()
	DressModule.ReqWearDress(self.curDressData.dressCid)
end

function DressView:OnDressSuccess()
	self.dressList:RenderCells()
	self:RefreshOnCurSelectDress()
end

function DressView:OnDressUnlockNew()
	self:RefreshOnCurSelectDress()
end

function DressView:OnClickBtnCustom()
	if self.curDressData.cfgDressRow.SkipTo ~= 0 then
		JumpModule.jumpCid(self.curDressData.cfgDressRow.SkipTo)
	elseif self.curDressData.cfgDressRow.BuyMallId ~= 0 then
		UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
			mallCid = self.curDressData.cfgDressRow.BuyMallId
		})
	elseif self.curDressData.cfgDressRow.NoticeId ~= 0 then
		NoticeModule.ShowNotice(self.curDressData.cfgDressRow.NoticeId)
	end
end

function DressView:RefreshDressList()
	local selectedIndex = 0

	for i, v in ipairs(self.dressDatum) do
		if v:CheckIsWore() then
			selectedIndex = i - 1

			break
		end
	end

	self.dressList.defaultSelectedToggle = selectedIndex

	self.dressList:Refresh(#self.dressDatum)
end

function DressView:RefreshOnCurSelectDress()
	local hasOwn = self.curDressData:CheckHasOwn()
	local isWore = self.curDressData:CheckIsWore()

	self.tfDressName.text = GirlUIApi:GetString("dressViewDressName", self.curDressData.cfgDressRow.Name)
	self.tfConditionDesc.text = GirlUIApi:GetString("dressViewCondition", self.curDressData.cfgDressRow.GainWay)

	self.goBtnDress:SetActive(hasOwn and not isWore)
	self.goSignWore:SetActive(isWore)
	self.goBtnCustom:SetActive(not hasOwn)
	self.goBtnCustom:GetComponent("GrayComponent"):SetGray(self.curDressData.cfgDressRow.SkipTo == 0 and self.curDressData.cfgDressRow.BuyMallId == 0)

	if not self.isChangeSoul then
		SoulModule.ChangeL2DSkin(self.l2dBuilder, self.soulData, CfgDressTable[self.curDressData.dressCid])
	end

	self.isChangeSoul = false
end

function DressView:SetActive(vs)
	self.View:SetActive(vs)
end

return DressView
