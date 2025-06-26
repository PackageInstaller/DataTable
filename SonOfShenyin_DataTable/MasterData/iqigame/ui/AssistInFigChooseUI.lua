-- chunkname: @IQIGame\\UI\\AssistInFigChooseUI.lua

local AIFFriendHeroCell = require("IQIGame.UI.AssisInFighting.AIFFriendHeroCell")
local AssistInFigChooseUI = Base:Extend("AssistInFigChooseUI", "IQIGame.Onigao.UI.AssistInFigChooseUI", {
	requestMaxLv = 0,
	HelpHeroList = {},
	cellList = {}
})

function AssistInFigChooseUI:OnInit()
	LuaCodeInterface.BindOutlet(self.View, self)
	self:InitDelegation()

	self.MyScrollAreaList = self.ContentScroll:GetComponent("ScrollAreaList")

	function self.MyScrollAreaList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	self.CloseBtn_Btn = self.CloseBtn:GetComponent("Button")
	self.RefreshBtn_Btn = self.RefreshBtn:GetComponent("Button")
	self.tapContent_Element = TapContent:New()

	self.tapContent_Element:Init(self.ElementTapContent.gameObject, self.OnToggleElementChangedDelegate)

	self.tapContent_Profession = TapContent:New()

	self.tapContent_Profession:Init(self.ProfessionTapContent.gameObject, self.OnToggleProfessionChangedDelegate)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(self.DelegateOnClickCloseBtn)
end

function AssistInFigChooseUI:InitDelegation()
	function self.GetHelpHeroListDele()
		self:GetHelpHeroListDeleFunction()
	end

	function self.OnToggleElementChangedDelegate(go, isOn)
		self:OnToggleElementChanged(go, isOn)
	end

	function self.OnToggleProfessionChangedDelegate(go, isOn)
		self:OnToggleProfessionChanged(go, isOn)
	end

	function self.OnGetHeroInfoResultFuncDele(_HeroData)
		self:OnGetHeroInfoResultFunc(_HeroData)
	end

	function self.DelegateUpdateFriend(pid)
		self:AddheroFunction(pid)
	end

	function self.OnRefreshBtnOn_Click()
		self:OnRefreshBtnClick()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnCloseBtnClick()
	end
end

function AssistInFigChooseUI:GetPreloadAssetPaths()
	return nil
end

function AssistInFigChooseUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function AssistInFigChooseUI:IsManualShowOnOpen(userData)
	return false
end

function AssistInFigChooseUI:GetBGM(userData)
	return nil
end

function AssistInFigChooseUI:OnOpen(maxLV)
	self.requestMaxLv = maxLV

	AssistInFightingModule.RecommendHelpHeros(self.requestMaxLv)
end

function AssistInFigChooseUI:OnToggleElementChanged(go_name)
	if go_name == "fire" then
		self.curScreenElement = WarlockModule.EaseElement.EaseFire
	elseif go_name == "water" then
		self.curScreenElement = WarlockModule.EaseElement.EaseWater
	elseif go_name == "wind" then
		self.curScreenElement = WarlockModule.EaseElement.EaseWind
	elseif go_name == "mine" then
		self.curScreenElement = WarlockModule.EaseElement.EaseMine
	elseif go_name == "ice" then
		self.curScreenElement = WarlockModule.EaseElement.EaseIce
	elseif go_name == "All" then
		self.curScreenElement = nil
	end

	self:GetHelpHeroListDeleFunction()
end

function AssistInFigChooseUI:OnToggleProfessionChanged(go_name)
	if go_name == "conjuring" then
		self.curScreenProfession = WarlockModule.EaseProfession.EaseConjuring
	elseif go_name == "implement" then
		self.curScreenProfession = WarlockModule.EaseProfession.EaseImplement
	elseif go_name == "speech" then
		self.curScreenProfession = WarlockModule.EaseProfession.EaseSpeech
	elseif go_name == "Rune" then
		self.curScreenProfession = WarlockModule.EaseProfession.EaseRune
	elseif go_name == "curtain" then
		self.curScreenProfession = WarlockModule.EaseProfession.EaseCurtain
	elseif go_name == "provide" then
		self.curScreenProfession = WarlockModule.EaseProfession.EaseProvide
	elseif go_name == "All" then
		self.curScreenProfession = nil
	end

	self:GetHelpHeroListDeleFunction()
end

function AssistInFigChooseUI:ScreenHelpHeroList()
	self.HelpHeroList = {}

	if self.curScreenProfession == nil and self.curScreenElement == nil then
		self.HelpHeroList = AssistInFightingModule.FriendHelpHeroList
	else
		for i = 1, #AssistInFightingModule.FriendHelpHeroList do
			local itemData = AssistInFightingModule.FriendHelpHeroList[i]
			local isAdd = WarlockModule.ToggleScreenhero(itemData, self.curScreenElement, self.curScreenProfession)

			if isAdd then
				table.insert(self.HelpHeroList, itemData)
			end
		end
	end
end

function AssistInFigChooseUI:GetHelpHeroListDeleFunction()
	self:ScreenHelpHeroList()
	self.MyScrollAreaList:Refresh(#self.HelpHeroList)
end

function AssistInFigChooseUI:OnRenderGridCell(gridCellData)
	local data = self.HelpHeroList[gridCellData.index + 1]
	local insID = gridCellData.gameObject:GetInstanceID()
	local cell = self.cellList[insID]

	data.insID = insID

	if cell == nil then
		cell = AIFFriendHeroCell.New(gridCellData.gameObject, self)
		self.cellList[insID] = cell
	end

	cell:RefreshData(data)

	gridCellData.gameObject.name = data.cid
end

function AssistInFigChooseUI:OnClose(userData)
	return
end

function AssistInFigChooseUI:AddFriendFunction()
	self:GetHelpHeroListDeleFunction()
end

function AssistInFigChooseUI:AddheroFunction()
	AssistInFightingModule.RecommendHelpHeros(self.requestMaxLv)
end

function AssistInFigChooseUI:OnGetHeroInfoResultFunc(_HeroData)
	logError("打开详细面板=---------------")
	UIModule.Open(Constant.UIControllerName.RoleDetailsUI, Constant.UILayer.UI, {
		_HeroData
	})
end

function AssistInFigChooseUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.GetHelpHerosResult, self.GetHelpHeroListDele)
	EventDispatcher.AddEventListener(EventID.GetHeroInfoResultDele, self.OnGetHeroInfoResultFuncDele)
	EventDispatcher.AddEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	self.RefreshBtn_Btn.onClick:AddListener(self.OnRefreshBtnOn_Click)
end

function AssistInFigChooseUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.GetHelpHerosResult, self.GetHelpHeroListDele)
	EventDispatcher.RemoveEventListener(EventID.GetHeroInfoResultDele, self.OnGetHeroInfoResultFuncDele)
	EventDispatcher.RemoveEventListener(EventID.UpdateFriend, self.DelegateUpdateFriend)
	self.RefreshBtn_Btn.onClick:RemoveListener(self.OnRefreshBtnOn_Click)
end

function AssistInFigChooseUI:OnPause()
	return
end

function AssistInFigChooseUI:OnResume()
	return
end

function AssistInFigChooseUI:OnCover()
	return
end

function AssistInFigChooseUI:OnReveal()
	return
end

function AssistInFigChooseUI:OnRefocus(userData)
	return
end

function AssistInFigChooseUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function AssistInFigChooseUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function AssistInFigChooseUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function AssistInFigChooseUI:OnCloseBtnClick()
	UIModule.Close(Constant.UIControllerName.AssistInFigChooseUI)
end

function AssistInFigChooseUI:OnRefreshBtnClick()
	AssistInFightingModule.RecommendHelpHeros(self.requestMaxLv)
end

function AssistInFigChooseUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function AssistInFigChooseUI:AddClick(Obj, action)
	local button = Obj:GetComponent("Button")

	button.onClick:RemoveAllListeners()
	button.onClick:AddListener(function()
		action(self, button.gameObject)
	end)
end

function AssistInFigChooseUI:RemoveClick(Obj, action)
	local button = Obj:GetComponent("Button")

	button.onClick:RemoveListener(function()
		action(self, button.gameObject)
	end)
end

function AssistInFigChooseUI:OnDestroy()
	self.commonReturnBtn:Dispose()

	for i, v in pairs(self.cellList) do
		v:OnDestroy()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
end

return AssistInFigChooseUI
