-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UIChapterBtnController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local Controller = Clone(ActorController)

function Controller:__OnInit()
	self.view = {}

	LuaCodeInterface.BindOutlet(self.actor.gameObject, self.view)
	self:__RefreshPower()
	self:__RefreshBuyPowerBtnState()
	self:__OnControllerReady()
	self.view.mainLineName.gameObject:SetActive(false)
end

function Controller:__OnInitEventDelegate()
	function self.__delegateOnNotifyStage()
		return
	end

	function self.__delegateOnTriggerButtonClick()
		if UnlockFunctionModule.OnClickInterceptor(Constant.UnlockType.FUNC_SmallPhone) then
			return
		end

		local userData = {}

		userData.ToggleType = Constant.WorldAreaUIToggleType.Trunk

		UIModule.Open(Constant.UIControllerName.WorldAreaUI, Constant.UILayer.UI, userData)
	end

	function self.__delegateOnPowerBtnClick()
		JumpModule.Jump(40000000)
	end

	function self.__delegateOnUpdateItem()
		self:__RefreshPower()
	end

	function self.__delegateOnUnlockFunction()
		self:__RefreshBuyPowerBtnState()
	end
end

function Controller:__OnAddListeners()
	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.__delegateOnNotifyStage)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.__delegateOnUpdateItem)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.__delegateOnUnlockFunction)
	self.view.triggerBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnTriggerButtonClick)
	self.view.powerBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnPowerBtnClick)
end

function Controller:__OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.__delegateOnNotifyStage)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.__delegateOnUpdateItem)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.__delegateOnUnlockFunction)
	self.view.triggerBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnTriggerButtonClick)
	self.view.powerBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnPowerBtnClick)
end

function Controller:__OnDispose()
	LuaCodeInterface.ClearOutlet(self.actor.gameObject, self.view)
end

function Controller:__RefreshMainLineProcess()
	return
end

function Controller:__RefreshBuyPowerBtnState()
	local active = ShopModule.GetShopDataWithShopID(Constant.ShopType.Energy) ~= nil

	self.view.powerBtn.gameObject:SetActive(active)
end

function Controller:__RefreshPower()
	local power = WarehouseModule.GetPlayerStrengthNum()
	local maxPower = PlayerModule.GetPlayerEnergy()

	UGUIUtil.SetText(self.view.powerText, power .. "/" .. maxPower)
end

return Controller
