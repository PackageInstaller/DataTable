-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandFunView.lua

local HomeLandFunView = {
	isOpen = true
}
local funBtnNames = {
	"RoomFunBtn",
	"OverviewBtn",
	"ShopBtn",
	"VisitFunBtn",
	"GoHomeFunBtn",
	"FishBtn",
	"VisitNextFriend"
}

function HomeLandFunView.__New(ui, parent)
	local o = Clone(HomeLandFunView)

	o:InitView(ui, parent)

	return o
end

function HomeLandFunView:InitView(ui, parent)
	self.rootUI = ui
	self.parentUI = parent

	LuaCodeInterface.BindOutlet(self.rootUI, self)

	self.btnOpenComponent = self.BtnOpen:GetComponent("Button")
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.tweenPosition = self.rootUI:GetComponent("TweenPosition")
	self.startPos = Vector3.New(self.tweenPosition.from.x, self.tweenPosition.from.y, self.tweenPosition.from.z)
	self.endPos = Vector3.New(self.tweenPosition.to.x, self.tweenPosition.to.y, self.tweenPosition.to.z)
	self.tweenSpeed = self.tweenPosition.duration

	function self.delegateOnBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateOnBtnOpen()
		self:OnClickBtnOpen()
	end

	function self.DelegateOnUpdateItem()
		self:UpdateRed()
	end

	function self.delegateUpdateRoomEvent()
		self:UpdateRed()
	end

	function self.delegateOnUnlockNotify()
		self:CheckFishOpen()
	end

	function self.delegateAutoFishState()
		self:UpdateRed()
	end

	self:InitFunButtons()
end

function HomeLandFunView:InitFunButtons()
	self.funButtons = {}
	self.handlers = {}

	for k, v in ipairs(funBtnNames) do
		local btnObj = self[v]
		local textName1 = btnObj.transform:Find("Text_01").gameObject

		UGUIUtil.SetText(textName1, HomeLandChooseCastleApi:GetString(v .. "Text", false))

		self.funButtons[v] = btnObj

		local func = self["OnClick" .. v]

		self.handlers[v] = function(...)
			func(self, ...)
		end
	end
end

function HomeLandFunView:AddEventListener()
	for k, v in pairs(self.funButtons) do
		local button = v:GetComponent("Button")

		button.onClick:AddListener(self.handlers[k])
	end

	self.btnOpenComponent.onClick:AddListener(self.delegateOnBtnOpen)
	self.btnCloseComponent.onClick:AddListener(self.delegateOnBtnClose)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.AddEventListener(EventID.UpdateAutoFishStateEvent, self.delegateAutoFishState)
end

function HomeLandFunView:RemoveEventListener()
	for k, v in pairs(self.funButtons) do
		local button = v:GetComponent("Button")

		button.onClick:RemoveListener(self.handlers[k])
	end

	self.btnOpenComponent.onClick:RemoveListener(self.delegateOnBtnOpen)
	self.btnCloseComponent.onClick:RemoveListener(self.delegateOnBtnClose)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateRoom, self.delegateUpdateRoomEvent)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.delegateOnUnlockNotify)
	EventDispatcher.RemoveEventListener(EventID.UpdateAutoFishStateEvent, self.delegateAutoFishState)
end

function HomeLandFunView:UpDateView()
	self.tweenPosition = TweenPosition.Begin(self.rootUI, self.tweenSpeed, self.endPos)

	self.BtnOpen:SetActive(not self.isOpen)
	self.BtnClose:SetActive(self.isOpen)
	self.GoHomeFunBtn:SetActive(HomeLandLuaModule.isVisitHome)
	self.ShopBtn:SetActive(not HomeLandLuaModule.isVisitHome)
	self.OverviewBtn:SetActive(not HomeLandLuaModule.isVisitHome)
	self.VisitNextFriend:SetActive(HomeLandLuaModule.isVisitHome)
	self:CheckFishOpen()
	self:UpdateRed()
end

function HomeLandFunView:CheckFishOpen()
	local fishOpen = UnlockFunctionModule.IsUnlock(Constant.UnlockType.FISHING)

	self.FishBtn:SetActive(fishOpen and not HomeLandLuaModule.isVisitHome)
end

function HomeLandFunView:Dispose()
	for k, v in pairs(self.funButtons) do
		UnityEngine.GameObject.Destroy(v)
	end

	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function HomeLandFunView:OnClickBtnClose()
	self.tweenPosition = TweenPosition.Begin(self.rootUI, self.tweenSpeed, self.startPos)
	self.isOpen = false

	self.BtnOpen:SetActive(not self.isOpen)
	self.BtnClose:SetActive(self.isOpen)
end

function HomeLandFunView:OnClickBtnOpen()
	self.tweenPosition = TweenPosition.Begin(self.rootUI, self.tweenSpeed, self.endPos)
	self.isOpen = true

	self.BtnOpen:SetActive(not self.isOpen)
	self.BtnClose:SetActive(self.isOpen)
end

function HomeLandFunView:OnClickRoomFunBtn()
	UIModule.Open(Constant.UIControllerName.HomeLandChangeRoomUI, Constant.UILayer.UI)
end

function HomeLandFunView:OnClickVisitFunBtn()
	UIModule.Open(Constant.UIControllerName.HomeLandVisitUI, Constant.UILayer.UI)
end

function HomeLandFunView:OnClickVisitNextFriend()
	HomeLandVisitMould.VisitNextFriend()
end

function HomeLandFunView:OnClickGoHomeFunBtn()
	HomeLandLuaModule.Shutdown()
	HomeLandLuaModule.EnterHome()
end

function HomeLandFunView:OnClickOverviewBtn()
	UIModule.Open(Constant.UIControllerName.HomeLandOverviewUI, Constant.UILayer.UI)
end

function HomeLandFunView:OnClickShopBtn()
	JumpModule.Jump(10202016)
end

function HomeLandFunView:OnClickFishBtn()
	UIModule.Open(Constant.UIControllerName.HomeLandFishUI, Constant.UILayer.UI, {
		openType = 1
	})
end

function HomeLandFunView:UpdateRed()
	local isRed = HomeLandLuaModule.CheckUnLockRoomRed()

	self.RedImg:SetActive(false)

	local isRedFish = FishingModule.CheckAutoFishRed()

	self.RedFish:SetActive(isRedFish)
end

function HomeLandFunView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()

	self.isOpen = true

	self:UpDateView()
	FishingModule.CheckResumeFishing()
end

function HomeLandFunView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandFunView
