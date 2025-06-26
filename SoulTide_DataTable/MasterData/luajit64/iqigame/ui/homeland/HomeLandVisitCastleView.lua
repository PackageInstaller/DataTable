-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandVisitCastleView.lua

local HomeLandVisitCastleView = {
	isOpen = false
}
local HomeLandVisitTipView = require("IQIGame.UI.HomeLand.HomeLandVisitTipView")

function HomeLandVisitCastleView.__New(ui)
	local o = Clone(HomeLandVisitCastleView)

	o:InitView(ui)

	return o
end

function HomeLandVisitCastleView:InitView(ui)
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.btnHelp = self.BtnHelp:GetComponent("Button")
	self.btnTreasureChest = self.BtnTreasureChest:GetComponent("Button")

	function self.delegateOnBtnHelp()
		self:OnClickBtnHelp()
	end

	function self.delegateOnBtnTreasureChest()
		self:OnClickBtnTreasureChest()
	end

	function self.delegateHomeLandVisitEvent()
		self:OnHomeLandVisitEvent()
	end

	self.visitTipView = HomeLandVisitTipView.New(self.HelpTipView)
end

function HomeLandVisitCastleView:AddEventListener()
	self.btnHelp.onClick:AddListener(self.delegateOnBtnHelp)
	self.btnTreasureChest.onClick:AddListener(self.delegateOnBtnTreasureChest)
	EventDispatcher.AddEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)
end

function HomeLandVisitCastleView:RemoveEventListener()
	self.btnHelp.onClick:RemoveListener(self.delegateOnBtnHelp)
	self.btnTreasureChest.onClick:RemoveListener(self.delegateOnBtnTreasureChest)
	EventDispatcher.RemoveEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)
end

function HomeLandVisitCastleView:OnHomeLandVisitEvent()
	self:UpDateShowNum()
end

function HomeLandVisitCastleView:UpDateView(type)
	if self.isOpen then
		self.visitTipView:Open()
		self.visitTipView:UpDateView(type)
	else
		self.visitTipView:Close()
	end

	self:UpDateShowNum()
end

function HomeLandVisitCastleView:UpDateShowNum()
	local value = CfgDiscreteDataTable[6520014].Data[1]
	local todayHelpCount = value - PlayerModule.PlayerInfo.todayHelpHomeCount

	UGUIUtil.SetText(self.TextBtnHelp, HomeLandChooseCastleApi:GetString("TextShowCount", todayHelpCount, value))

	local value1 = CfgDiscreteDataTable[6520015].Data[1]
	local todayOpenVisitTreasure = value1 - PlayerModule.PlayerInfo.todayOpenVisitTreasureChest

	UGUIUtil.SetText(self.TextBtnTreasureChest, HomeLandChooseCastleApi:GetString("TextShowCount", todayOpenVisitTreasure, value1))
end

function HomeLandVisitCastleView:Dispose()
	self.visitTipView:Dispose()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function HomeLandVisitCastleView:OnClickBtnHelp()
	self.isOpen = not self.isOpen

	self:UpDateView(1)
end

function HomeLandVisitCastleView:OnClickBtnTreasureChest()
	self.isOpen = not self.isOpen

	self:UpDateView(2)
end

function HomeLandVisitCastleView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()

	self.isOpen = false

	self:UpDateView()
end

function HomeLandVisitCastleView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandVisitCastleView
