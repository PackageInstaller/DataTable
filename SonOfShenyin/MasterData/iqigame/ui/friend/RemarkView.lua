-- chunkname: @IQIGame\\UI\\Friend\\RemarkView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateConfirmBtn()
		self:RequestRemark()
	end

	function self.DelegateCancelBtn()
		self:Hide()
	end

	function self.DelegateOnRemarkResultEvent()
		self:RemarkResult()
	end

	self.input = self.InputRemark:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	UGUIUtil.SetTextInChildren(self.ConfirmBtn, FriendUIApi:GetconfrimBtnText())
	UGUIUtil.SetTextInChildren(self.CancelBtn, FriendUIApi:GetcancelBtnText())
	UGUIUtil.SetText(self.Placeholder, FriendUIApi:GetInputPromptTex())
	self:AddListeners()
end

function m:AddListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:AddListener(self.DelegateConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateCancelBtn)
	EventDispatcher.AddEventListener(EventID.SetRemarkResult, self.DelegateOnRemarkResultEvent)
end

function m:RemoveListeners()
	self.ConfirmBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateConfirmBtn)
	self.CancelBtn:GetComponent("Button").onClick:AddListener(self.DelegateCancelBtn)
	EventDispatcher.RemoveEventListener(EventID.SetRemarkResult, self.DelegateOnRemarkResultEvent)
end

function m:SetData(friendID)
	self.FriendID = friendID
	self.input.text = ""
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:RequestRemark()
	local filteredName = FilterName(self.input.text)

	if filteredName ~= self.input.text or filteredName == "" or filteredName == nil then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, FriendUIApi:RemarkUnserviceableText())

		return
	end

	SDKLoginModule.SensitiveWordFilter(filteredName, function(resultStr, isHasSensitive)
		if isHasSensitive then
			NoticeModule.ShowNotice(21045002)

			return
		end

		FriendModule.SendSetAlias(self.FriendID, resultStr)
	end)
end

function m:RemarkResult()
	self.input.text = ""

	self:Hide()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
