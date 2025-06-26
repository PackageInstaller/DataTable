-- chunkname: @IQIGame\\UI\\HomeLandVisitUI.lua

local HomeLandVisitUI = Base:Extend("HomeLandVisitUI", "IQIGame.Onigao.UI.HomeLandVisitUI", {
	isOpen = false,
	selectIndex = 1
})
local HomeLandVisitListView = require("IQIGame.UI.HomeLandVisit.HomeLandVisitListView")
local HomeLandVisitTipView = require("IQIGame.UI.HomeLand.HomeLandVisitTipView")

function HomeLandVisitUI:OnInit()
	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	self.btnHelp = self.BtnHelp:GetComponent("Button")
	self.btnTreasureChest = self.BtnTreasureChest:GetComponent("Button")

	UGUIUtil.SetText(self.TextTitle, HomeLandVisitUIApi:GetString("TextTitle", false))
	UGUIUtil.SetText(self.TextTitleEng, HomeLandVisitUIApi:GetString("TextTitle", true))
	UGUIUtil.SetText(self.TextDes, HomeLandVisitUIApi:GetString("TextDes"))
	UGUIUtil.SetText(self.TextEmpty, HomeLandVisitUIApi:GetString("TextEmpty"))

	self.toggles = {}
	self.toggles[1] = self.ToggleVisit:GetComponent("Toggle")

	UGUIUtil.SetText(self.ToggleVisit.transform:Find("goUp/Text_01").gameObject, HomeLandVisitUIApi:GetString("TextToggleVisit1"))
	UGUIUtil.SetText(self.ToggleVisit.transform:Find("goDown/Text_01").gameObject, HomeLandVisitUIApi:GetString("TextToggleVisit1"))
	UGUIUtil.SetText(self.ToggleVisit.transform:Find("goUp/Text_02").gameObject, HomeLandVisitUIApi:GetString("TextToggleVisit2"))
	UGUIUtil.SetText(self.ToggleVisit.transform:Find("goDown/Text_02").gameObject, HomeLandVisitUIApi:GetString("TextToggleVisit2"))

	self.toggles[1].group = self.ToggleGrid:GetComponent("ToggleGroup")
	self.visitListView = HomeLandVisitListView.__New(self.VisitListView, self)

	function self.delegateToggleValueChange(isOn)
		self:OnToggleValueChange(isOn)
	end

	function self.delegateOnBtnHelp()
		self:OnClickBtnHelp()
	end

	function self.delegateOnBtnTreasureChest()
		self:OnClickBtnTreasureChest()
	end

	function self.delegateHomeLandVisitEvent()
		self:OnHomeLandVisitEvent()
	end

	self.visitTipView = HomeLandVisitTipView.New(self.VisitTip)
end

function HomeLandVisitUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandVisitUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandVisitUI:OnOpen(userData)
	self.selectIndex = 1
	self.toggles[1].isOn = true

	self:ShowChildView()

	self.isOpen = false

	self:UpDateView()
end

function HomeLandVisitUI:OnClose(userData)
	self.visitTipView:Close()
end

function HomeLandVisitUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.btnHelp.onClick:AddListener(self.delegateOnBtnHelp)
	self.btnTreasureChest.onClick:AddListener(self.delegateOnBtnTreasureChest)
	EventDispatcher.AddEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.delegateToggleValueChange)
	end
end

function HomeLandVisitUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.btnHelp.onClick:RemoveListener(self.delegateOnBtnHelp)
	self.btnTreasureChest.onClick:RemoveListener(self.delegateOnBtnTreasureChest)
	EventDispatcher.RemoveEventListener(EventID.HomeLandVisitEvent, self.delegateHomeLandVisitEvent)

	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.delegateToggleValueChange)
	end
end

function HomeLandVisitUI:OnPause()
	return
end

function HomeLandVisitUI:OnResume()
	return
end

function HomeLandVisitUI:OnCover()
	return
end

function HomeLandVisitUI:OnReveal()
	return
end

function HomeLandVisitUI:OnRefocus(userData)
	return
end

function HomeLandVisitUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandVisitUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandVisitUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandVisitUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandVisitUI:OnDestroy()
	self.visitTipView:Dispose()
end

function HomeLandVisitUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandVisitUI)
end

function HomeLandVisitUI:OnToggleValueChange(isOn)
	if isOn then
		for i = 1, #self.toggles do
			local toggle = self.toggles[i]

			if toggle.isOn == true and self.selectIndex ~= i then
				self.selectIndex = i

				self:ShowChildView()

				break
			end
		end
	end
end

function HomeLandVisitUI:ShowChildView()
	self.visitListView:Close()

	if self.selectIndex == 1 then
		self.visitListView:Open()
	end
end

function HomeLandVisitUI:OnHomeLandVisitEvent()
	self:UpDateShowNum()
end

function HomeLandVisitUI:OnClickBtnHelp()
	self.isOpen = not self.isOpen

	self:UpDateView(1)
end

function HomeLandVisitUI:OnClickBtnTreasureChest()
	self.isOpen = not self.isOpen

	self:UpDateView(2)
end

function HomeLandVisitUI:UpDateView(type)
	if self.isOpen then
		self.visitTipView:Open()
		self.visitTipView:UpDateView(type)
	else
		self.visitTipView:Close()
	end

	self:UpDateShowNum()
end

function HomeLandVisitUI:UpDateShowNum()
	local value = CfgDiscreteDataTable[6520014].Data[1]
	local todayHelpCount = value - PlayerModule.PlayerInfo.todayHelpHomeCount

	UGUIUtil.SetText(self.TextBtnHelp, HomeLandChooseCastleApi:GetString("TextShowCount", todayHelpCount, value))

	local value1 = CfgDiscreteDataTable[6520015].Data[1]
	local todayOpenVisitTreasure = value1 - PlayerModule.PlayerInfo.todayOpenVisitTreasureChest

	UGUIUtil.SetText(self.TextBtnTreasureChest, HomeLandChooseCastleApi:GetString("TextShowCount", todayOpenVisitTreasure, value1))
end

return HomeLandVisitUI
