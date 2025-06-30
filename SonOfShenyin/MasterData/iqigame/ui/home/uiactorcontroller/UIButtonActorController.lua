-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UIButtonActorController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local Controller = Clone(ActorController)

Controller.UIName = nil
Controller.redDotID = 0
Controller.unlockType = 0

function Controller:__OnInit()
	self:__OnButtonActor_OnInit()
end

function Controller:__OnButtonActor_OnInit()
	self.view = {}

	LuaCodeInterface.BindOutlet(self.actor.gameObject, self.view)
	self:__RefreshUnlockBtn()
	self:__OnControllerReady()
end

function Controller:__OnInitEventDelegate()
	function self.__delegateOnUnlockFunction()
		self:__RefreshUnlockBtn()
	end

	function self.__delegateOnTriggerBtnClick()
		self:__OnTriggerBtnClick()
	end
end

function Controller:__OnAddListeners()
	self.view.triggerBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnTriggerBtnClick)
end

function Controller:__OnRemoveListeners()
	self.view.triggerBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnTriggerBtnClick)
end

function Controller:__OnDispose()
	self:__RemoveRedDot()
	self:__RemoveUnlockFunc()
	LuaCodeInterface.ClearOutlet(self.actor.gameObject, self.view)
end

function Controller:__RefreshUnlockBtn()
	if self.view.lockRoot == nil then
		return
	end

	if self.unlockType == 0 or self.unlockType == nil then
		return
	end

	local funcList = {}

	funcList[self.unlockType] = self.view.lockRoot.gameObject

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function Controller:__OnTriggerBtnClick()
	if self.unlockType ~= nil and self.unlockType ~= 0 and not UnlockFunctionModule.IsUnlock(self.unlockType) then
		if self.noticeCid ~= nil and self.noticeCid ~= 0 then
			NoticeModule.ShowNotice(self.noticeCid)
		end

		return
	end

	UIModule.Open(self.UIName, Constant.UILayer.UI)
end

function Controller:InitRedDot(redDotID)
	if self.view.redDot == nil then
		return
	end

	if redDotID == 0 or redDotID == nil then
		self.view.redDot.gameObject:SetActive(false)

		return
	end

	self.redDotID = redDotID

	RedDotModule.Subscribe(self.redDotID, self.view.redDot.gameObject)
end

function Controller:__RemoveRedDot()
	if self.view.redDot == nil then
		return
	end

	if self.redDotID == 0 or self.redDotID == nil then
		return
	end

	RedDotModule.Unsubscribe(self.redDotID, self.view.redDot.gameObject)
end

function Controller:SetButtonData(uiName, unlockType, noticeCid)
	self.UIName = uiName
	self.noticeCid = noticeCid

	if self.view.lockRoot == nil then
		return
	end

	if unlockType == nil or unlockType == 0 then
		self.view.lockRoot.gameObject:SetActive(false)

		return
	end

	self.unlockType = unlockType

	self:__RefreshUnlockBtn()
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.__delegateOnUnlockFunction)
end

function Controller:__RemoveUnlockFunc()
	if self.view.lockRoot == nil then
		return
	end

	if self.unlockType == nil or self.unlockType == 0 then
		return
	end

	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.__delegateOnUnlockFunction)
end

return Controller
