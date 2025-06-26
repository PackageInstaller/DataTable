-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UISummerActivitiesBtnController.lua

local UIButtonActorController = require("IQIGame/UI/Home/UIActorController/UIButtonActorController")
local Controller = Clone(UIButtonActorController)

function Controller:__OnInit()
	self:__OnButtonActor_OnInit()
	self:SetButtonData(Constant.UIControllerName.ActiveActivityListUI, nil, nil)
end

function Controller:__OnInitEventDelegate()
	function self.__delegateOnUnlockFunction()
		self:__RefreshUnlockBtn()
	end

	function self.__delegateOnTriggerBtnClick()
		self:__OnTriggerBtnClick()
	end

	function self.notifyUnlockEvent()
		self:__RefreshUnlockBtn()
	end
end

function Controller:__OnAddListeners()
	EventDispatcher.AddEventListener(EventID.PlayerLvChange, self.notifyUnlockEvent)
	EventDispatcher.AddEventListener(EventID.ActivityUpdateEvent, self.notifyUnlockEvent)
	self.view.triggerBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnTriggerBtnClick)
end

function Controller:__OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.PlayerLvChange, self.notifyUnlockEvent)
	EventDispatcher.RemoveEventListener(EventID.ActivityUpdateEvent, self.notifyUnlockEvent)
	self.view.triggerBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnTriggerBtnClick)
end

function Controller:__OnTriggerBtnClick()
	if self.unlockType ~= nil and self.unlockType ~= 0 and not UnlockFunctionModule.IsUnlock(self.unlockType) then
		if self.noticeCid ~= nil and self.noticeCid ~= 0 then
			NoticeModule.ShowNotice(self.noticeCid)
		end

		return
	end

	UIModule.Open(self.UIName, Constant.UILayer.UI, {
		teamID = Constant.ActivityListTeamID.SummerActivity
	})
end

function Controller:__RefreshUnlockBtn()
	local activityList = ActiveActivityListModule.GetActivityListByTeamID(Constant.ActivityListTeamID.SummerActivity)

	if #activityList > 0 then
		LuaUtility.SetGameObjectShow(self.actor.gameObject, true)
	else
		LuaUtility.SetGameObjectShow(self.actor.gameObject, false)
	end
end

return Controller
