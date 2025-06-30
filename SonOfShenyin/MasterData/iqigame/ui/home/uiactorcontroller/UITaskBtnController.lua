-- chunkname: @IQIGame\\UI\\Home\\UIActorController\\UITaskBtnController.lua

local ActorController = require("IQIGame/Scene/Home/Controller/ActorController")
local Controller = Clone(ActorController)

function Controller:__OnInit()
	self.view = {}

	LuaCodeInterface.BindOutlet(self.actor.gameObject, self.view)
	self:__RefreshUnlockBtn()
	self:__OnControllerReady()
end

function Controller:__OnInitEventDelegate()
	function self.__delegateOnUnlockFunction()
		self:__RefreshUnlockBtn()
	end

	function self.__delegateOnTaskBtnClick()
		self:__OnTaskBtnClick()
	end
end

function Controller:__OnAddListeners()
	return
end

function Controller:__OnRemoveListeners()
	return
end

function Controller:__OnDispose()
	LuaCodeInterface.ClearOutlet(self.actor.gameObject, self.view)
end

function Controller:__RefreshUnlockBtn()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_TASK] = self.view.taskBtn

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function Controller:__OnTaskBtnClick()
	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.FUNC_TASK) then
		UIModule.Open(Constant.UIControllerName.TaskSystemUI, Constant.UILayer.UI)
	else
		NoticeModule.ShowNotice(19001)
	end
end

return Controller
