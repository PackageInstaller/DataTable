-- chunkname: @IQIGame\\UI\\Main\\MainTipsView.lua

local MainTipsView = {}

function MainTipsView.__New(ui)
	local o = Clone(MainTipsView)

	o:InitView(ui)

	return o
end

function MainTipsView:InitView(ui)
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.scrollList = self.rootUI:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onSelectedCell(cell)
		self:OnClickSoulCell(cell)
	end

	function self.delegateUpdateMainCityTips()
		self:UpDateView()
	end
end

function MainTipsView:AddEventListener()
	EventDispatcher.AddEventListener(EventID.UpdateMainCityTips, self.delegateUpdateMainCityTips)
end

function MainTipsView:RemoveEventListener()
	EventDispatcher.RemoveEventListener(EventID.UpdateMainCityTips, self.delegateUpdateMainCityTips)
end

function MainTipsView:Dispose()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function MainTipsView:UpDateView()
	self.cfgMainTips = {}

	for i, v in ipairs(MainTipsModule.mainCfgTipsDataIDs) do
		table.insert(self.cfgMainTips, CfgFunctionTipsTable[v])
	end

	self.scrollList:Refresh(#self.cfgMainTips)
end

function MainTipsView:OnRenderCell(cell)
	local cfgData = self.cfgMainTips[cell.index + 1]
	local goObj = cell.gameObject

	goObj:SetActive(true)

	goObj.transform:Find("Text_1").gameObject:GetComponent("Text").text = cfgData.Describe
end

function MainTipsView:OnClickSoulCell(cell)
	local cfgData = self.cfgMainTips[cell.index + 1]

	JumpModule.Jump(cfgData.FunctionId)
end

function MainTipsView:Open()
	MainTipsModule.CheckSoulTips()
	self.rootUI:SetActive(true)
	self:AddEventListener()
	self:UpDateView()
end

function MainTipsView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return MainTipsView
