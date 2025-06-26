-- chunkname: @IQIGame\\UI\\NoviceTaskUI\\activeBtnCall.lua

local m = {}

function m.New(view, mainView)
	local obj = Clone(m)

	obj:__Init(view, mainView)

	return obj
end

function m:__Init(view, mainView)
	self.gameObject = view
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	function self.DelegateOnBtnClick()
		self:OnButtonClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClick)
end

function m:RemoveListeners()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClick)
end

function m:Show(data)
	self.data = data

	self.gameObject:SetActive(true)
	LuaUtility.SetText(self.expText, tostring(data.needSchedule))
	LuaUtility.SetGameObjectShow(self.canGetImg.gameObject, data.status == Constant.passTaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.canGetEffect, data.status == Constant.passTaskStatus.hasDone)
	LuaUtility.SetGameObjectShow(self.haveGetState.gameObject, data.status == Constant.passTaskStatus.hadGot)

	if data.status == Constant.passTaskStatus.hadGot then
		LuaUtility.SetImageColorWithGameObject(self.expImg.gameObject, 0.46, 0.46, 0.46, 0.82)
		LuaUtility.SetTextColor(self.expText, 0.41, 0.41, 0.41, 0.8)
	elseif data.status == Constant.passTaskStatus.hasDone then
		LuaUtility.SetImageColorWithGameObject(self.expImg.gameObject, 1, 1, 1, 0.82)
		LuaUtility.SetTextColor(self.expText, 0.6, 0.41, 0.85, 0.8)
	else
		LuaUtility.SetImageColorWithGameObject(self.expImg.gameObject, 1, 1, 1, 0.82)
		LuaUtility.SetTextColor(self.expText, 0.6, 0.41, 0.85, 0.8)
	end

	self.taskSystemData = data
	self.rewardState = data.status
	self.taskCid = data.cid
end

function m:OnButtonClick()
	if self.rewardState == Constant.TaskStatus.hasDone then
		local SubmitTypes = {}

		table.insert(SubmitTypes, TaskSystemModule.CombineContent(self.data.cfgTaskConfig.Type, self.data.cfgTaskConfig.TypeExtend))
		TaskSystemModule.SubmitTaskForType(SubmitTypes)
	else
		self.mainView:OnTaskAwardShow(self.data)
	end
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
