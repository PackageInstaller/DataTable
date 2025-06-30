-- chunkname: @IQIGame\\UI\\Common\\CommonReturnBtn.lua

CommonReturnBtn = {}

function CommonReturnBtn.New(view, targetUI)
	local obj = Clone(CommonReturnBtn)

	obj:Init(view, targetUI)

	return obj
end

function CommonReturnBtn:Init(view, targetUI)
	self.View = view
	self.TargetUI = targetUI

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickReturnBtn()
		self:OnClickReturnBtn()
	end

	function self.DelegateOnClickHomeBtn()
		self:OnClickHomeBtn()
	end

	self:AddListeners()
end

function CommonReturnBtn:AddListeners()
	self.HomeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHomeBtn)
	self.ReturnBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReturnBtn)
end

function CommonReturnBtn:RemoveListeners()
	self.HomeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHomeBtn)
	self.ReturnBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReturnBtn)
end

function CommonReturnBtn:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function CommonReturnBtn:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function CommonReturnBtn:RegisterReturnEvent(ReturnBtnEvent)
	self.ReturnBtnEvent = ReturnBtnEvent
end

function CommonReturnBtn:RegisterBackHomeEvent(func)
	self.backHomeEvent = func
end

function CommonReturnBtn:OnClickReturnBtn()
	if self.ReturnBtnEvent then
		self.ReturnBtnEvent()
	else
		UIModule.CloseSelf(self.TargetUI)
	end
end

function CommonReturnBtn:OnClickHomeBtn()
	GameChapterModule.CurSelectChapterType = nil
	GameChapterModule.CurSelectChapterUserData = nil

	if self.backHomeEvent then
		self.backHomeEvent()

		return
	end

	EventDispatcher.Dispatch(EventID.OpenMobilePhoneEvent, true)
	UIModule.CloseAllUIFrom({
		Constant.UIControllerName.MainUI,
		Constant.UIControllerName.GuideUI
	})
end

function CommonReturnBtn:SetState(state)
	LuaUtility.SetGameObjectShow(self.View, state)
end

function CommonReturnBtn:SetHomeBtnState(state)
	LuaUtility.SetGameObjectShow(self.HomeBtn, state)
end

function CommonReturnBtn:Dispose()
	self:RemoveListeners()

	self.ReturnBtnEvent = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return CommonReturnBtn
