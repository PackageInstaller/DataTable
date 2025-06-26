-- chunkname: @IQIGame\\UI\\Girl\\BackGround\\BackGroundView.lua

local m = {
	girlBackGroundDataTab = {},
	backGroundRenderCellPool = {}
}
local BackGroundRenderCell = require("IQIGame.UI.Girl.BackGround.BackGroundRenderCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBGTitle, GirlUIApi:GetString("BGTextBGTitle"))
	UGUIUtil.SetTextInChildren(self.BtnUse, GirlUIApi:GetString("BGBtnUseLabel"))

	function self.delegateBtnSource()
		self:OnBtnSource()
	end

	function self.delegateBtnUse()
		self:OnBtnUse()
	end

	function self.delegateUnlockBGEvent()
		self:OnUnlockBG()
	end

	local scrollList = self.BackGroundScroll:GetComponent("ScrollAreaList")

	function scrollList.onSelectedCell(cell)
		self:OnSelectedGridCell(cell)
	end

	function scrollList.onRenderCell(cell)
		self:OnRenderGridCell(cell)
	end

	self:AddListener()
end

function m:AddListener()
	self.BtnSource:GetComponent("Button").onClick:AddListener(self.delegateBtnSource)
	self.BtnUse:GetComponent("Button").onClick:AddListener(self.delegateBtnUse)
	EventDispatcher.AddEventListener(EventID.UpdateUnlockGirlBackgroundEvent, self.delegateUnlockBGEvent)
end

function m:RemoveListener()
	self.BtnSource:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSource)
	self.BtnUse:GetComponent("Button").onClick:RemoveListener(self.delegateBtnUse)
	EventDispatcher.RemoveEventListener(EventID.UpdateUnlockGirlBackgroundEvent, self.delegateUnlockBGEvent)
end

function m:ShowSelectBG()
	for i, v in pairs(self.backGroundRenderCellPool) do
		if v.backGroundData.cid == self.selectBackGroundData.cid then
			v:SetSelect(true)
		else
			v:SetSelect(false)
		end
	end

	UGUIUtil.SetText(self.TextSelect, self.selectBackGroundData:GetConfigData().Name)
	self.BtnSource:SetActive(not self.selectBackGroundData.unlock and self.selectBackGroundData:GetConfigData().BuyMallId > 0)
	self.BtnUse:SetActive(self.selectBackGroundData.unlock and self.selectBackGroundData.cid ~= GirlBackGroundModule.currentUseBG)

	if self.selectBackGroundData.cid == GirlBackGroundModule.currentUseBG then
		UGUIUtil.SetText(self.TextCurrent, GirlUIApi:GetString("BGTextCurrent"))
	else
		UGUIUtil.SetText(self.TextCurrent, self.selectBackGroundData:GetConfigData().GainWay)
	end

	UGUIUtil.SetTextInChildren(self.BtnSource, self.selectBackGroundData:GetConfigData().GainWay)
	EventDispatcher.Dispatch(EventID.UpdateGirlBackgroundEvent, self.selectBackGroundData.cid)
end

function m:OnSelectedGridCell(cell)
	self.selectBackGroundData = self.girlBackGroundDataTab[cell.index + 1]

	self:ShowSelectBG()
end

function m:OnRenderGridCell(cell)
	local bgData = self.girlBackGroundDataTab[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local renderCell = self.backGroundRenderCellPool[instanceID]

	if renderCell == nil then
		renderCell = BackGroundRenderCell.New(cell.gameObject)
		self.backGroundRenderCellPool[instanceID] = renderCell
	end

	renderCell:SetData(bgData)
	renderCell:SetCurrentUse(bgData.cid == GirlBackGroundModule.currentUseBG)
	renderCell:SetSelect(self.selectBackGroundData.cid == bgData.cid)
end

function m:UpdateView()
	self.girlBackGroundDataTab = GirlBackGroundModule.GetBackGroundData()

	local index = 0

	if self.selectBackGroundData == nil then
		for i, v in pairs(self.girlBackGroundDataTab) do
			if v.cid == GirlBackGroundModule.currentUseBG then
				self.selectBackGroundData = v

				break
			end

			index = index + 1
		end
	end

	self.BackGroundScroll:GetComponent("ScrollAreaList").defaultSelectedToggle = index

	self.BackGroundScroll:GetComponent("ScrollAreaList"):Refresh(#self.girlBackGroundDataTab)
end

function m:OnUnlockBG()
	self:UpdateView()
end

function m:OnBtnSource()
	if self.selectBackGroundData:GetConfigData().BuyMallId ~= 0 then
		UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
			mallCid = self.selectBackGroundData:GetConfigData().BuyMallId
		})
	end
end

function m:OnBtnUse()
	if GirlBackGroundModule.currentUseBG ~= self.selectBackGroundData.cid then
		GirlBackGroundModule.SaveBackGround(self.selectBackGroundData.cid)

		self.selectBackGroundData = nil

		self:UpdateView()
	end
end

function m:Open()
	self.View:SetActive(true)

	self.isOpen = true
	self.selectBackGroundData = nil
end

function m:Close()
	self.isOpen = false

	EventDispatcher.Dispatch(EventID.UpdateGirlBackgroundEvent, GirlBackGroundModule.currentUseBG)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.backGroundRenderCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
