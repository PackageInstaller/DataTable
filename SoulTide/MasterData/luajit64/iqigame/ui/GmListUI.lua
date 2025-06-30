-- chunkname: @IQIGame\\UI\\GmListUI.lua

local GmListUI = Base:Extend("GmListUI", "IQIGame.Onigao.UI.GmListUI", {
	hasRefreshed = false,
	cmdItemPool = {}
})
local GmListItem = require("IQIGame.UI.GmList.GmListItem")

function GmListUI:OnInit()
	self:Initialize()
end

function GmListUI:GetPreloadAssetPaths()
	return nil
end

function GmListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GmListUI:OnOpen(userData)
	self:Refresh(userData)
end

function GmListUI:OnClose(userData)
	self:Dispose()
end

function GmListUI:OnPause()
	return
end

function GmListUI:OnResume()
	return
end

function GmListUI:OnCover()
	return
end

function GmListUI:OnReveal()
	return
end

function GmListUI:OnRefocus(userData)
	return
end

function GmListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GmListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GmListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GmListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GmListUI:Initialize()
	self.tabList = self.goTabList:GetComponent("ScrollAreaList")

	function self.tabList.onRenderCell(cell)
		self:OnRenderTab(cell)
	end

	function self.tabList.onSelectedCell(cell)
		self:OnSelectedTab(cell)
	end

	self.cmdList = self.goCmdList:GetComponent("ScrollAreaList")

	function self.cmdList.onRenderCell(cell)
		self:OnRenderCmdItem(cell)
	end

	function self.cmdList.onSelectedCell(cell)
		self:OnSelectedCmdItem(cell)
	end

	self.inputFilter = self.goFilterInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.inputCustom = self.goInputCustom:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnFilter = self.goBtnFilter:GetComponent("Button")
	self.btnFilterClear = self.goBtnFilterClear:GetComponent("Button")
	self.btnCustomClear = self.goBtnCustomClear:GetComponent("Button")
	self.btnCustomCmd = self.goBtnCustomCmd:GetComponent("Button")

	function self.onClickBtnCustomClearDelegate()
		self:OnClickBtnCustomClear()
	end

	function self.onClickBtnCustomCmdDelegate()
		self:OnClickBtnCustomCmd()
	end

	function self.onClickBtnFilterDelegate()
		self:OnClickBtnFilter()
	end

	function self.onClickBtnFilterClearDelegate()
		self:OnClickBtnFilterClear()
	end

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onSendCmdSuccessDelegate(type)
		self:OnSendCmdSuccess(type)
	end
end

function GmListUI:Refresh(userData)
	self.hasRefreshed = false

	self:RefreshDatum()
	self:RefreshTabs()

	self.hasRefreshed = true
	GmListModule.enableGmModule = true
end

function GmListUI:Dispose()
	GmListModule.enableGmModule = false
end

function GmListUI:OnDestroy()
	for i, v in pairs(self.cmdItemPool) do
		v:OnDestroy()
	end
end

function GmListUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnFilterClear.onClick:AddListener(self.onClickBtnFilterClearDelegate)
	self.btnFilter.onClick:AddListener(self.onClickBtnFilterDelegate)
	self.btnCustomClear.onClick:AddListener(self.onClickBtnCustomClearDelegate)
	self.btnCustomCmd.onClick:AddListener(self.onClickBtnCustomCmdDelegate)
	EventDispatcher.AddEventListener(EventID.CmdSendSuccess, self.onSendCmdSuccessDelegate)
end

function GmListUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnFilterClear.onClick:RemoveListener(self.onClickBtnFilterClearDelegate)
	self.btnFilter.onClick:RemoveListener(self.onClickBtnFilterDelegate)
	self.btnCustomClear.onClick:RemoveListener(self.onClickBtnCustomClearDelegate)
	self.btnCustomCmd.onClick:RemoveListener(self.onClickBtnCustomCmdDelegate)
	EventDispatcher.RemoveEventListener(EventID.CmdSendSuccess, self.onSendCmdSuccessDelegate)
end

function GmListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.GmListUI)
end

function GmListUI:OnClickBtnFilter()
	self:RefreshCmdList(self.inputFilter.text)
end

function GmListUI:OnSendCmdSuccess(type)
	if type == GmListModule.DEFAULT_CUSTOM_TYPE then
		self.type2cfgListDic[GmListModule.DEFAULT_CUSTOM_TYPE] = GmListModule.GetCustomGmDatum()

		if self.curType == GmListModule.DEFAULT_CUSTOM_TYPE then
			self:RefreshCmdList()
		end
	end
end

function GmListUI:OnClickBtnFilterClear()
	self.inputFilter.text = ""

	self:OnClickBtnFilter()
end

function GmListUI:OnClickBtnCustomClear()
	self.inputCustom.text = ""
end

function GmListUI:OnClickBtnCustomCmd()
	GmListModule.SendCmd(self.inputCustom.text, GmListModule.DEFAULT_CUSTOM_TYPE)
end

function GmListUI:OnRenderTab(cell)
	local luaIndex = cell.index + 1
	local type = self.typeList[luaIndex]
	local toggleHelper = cell.gameObject:GetComponent("ToggleHelperComponent")

	toggleHelper.text = self.type2nameDic[type]

	if luaIndex == 1 and self.hasRefreshed == false then
		cell.gameObject:GetComponent("Toggle").isOn = true
	end
end

function GmListUI:OnSelectedTab(cell)
	local luaIndex = cell.index + 1

	self.curType = self.typeList[luaIndex]

	self:RefreshCmdList()
end

function GmListUI:OnRenderCmdItem(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local cfgData = self.curCfgDataList[luaIndex]
	local item = self.cmdItemPool[insID]

	if item == nil then
		item = GmListItem.New(cell.gameObject)
		self.cmdItemPool[insID] = item
	end

	item:Refresh(cfgData)
end

function GmListUI:OnSelectedCmdItem(cell)
	local luaIndex = cell.index + 1
	local cfgData = self.curCfgDataList[luaIndex]

	self.inputCustom.text = cfgData.Cmd
end

function GmListUI:RefreshDatum()
	self.typeList = {}
	self.type2cfgListDic = {}
	self.type2nameDic = {}

	for i, v in pairs(CfgGmTable) do
		if self.type2cfgListDic[v.Type] == nil then
			self.type2cfgListDic[v.Type] = {}
		end

		self.type2cfgListDic[v.Type][#self.type2cfgListDic[v.Type] + 1] = v
		self.type2nameDic[v.Type] = v.TypeName
	end

	for i, v in pairs(self.type2cfgListDic) do
		table.sort(v, function(a, b)
			return a.Id < b.Id
		end)

		self.typeList[#self.typeList + 1] = i
	end

	table.sort(self.typeList, function(a, b)
		return a < b
	end)

	self.typeList[#self.typeList + 1] = GmListModule.DEFAULT_CUSTOM_TYPE
	self.type2cfgListDic[GmListModule.DEFAULT_CUSTOM_TYPE] = GmListModule.GetCustomGmDatum()
	self.type2nameDic[GmListModule.DEFAULT_CUSTOM_TYPE] = "【历史指令】"
end

function GmListUI:RefreshTabs()
	self.tabList:Refresh(#self.typeList)
end

function GmListUI:RefreshCmdList(filter)
	local allCfgList = self.type2cfgListDic[self.curType]

	if filter ~= nil and filter ~= "" then
		self.curCfgDataList = {}

		for i, v in ipairs(allCfgList) do
			if string.find(v.Cmd, filter) then
				self.curCfgDataList[#self.curCfgDataList + 1] = v
			end
		end
	else
		self.curCfgDataList = allCfgList
	end

	self.cmdList:Refresh(#self.curCfgDataList)
end

return GmListUI
