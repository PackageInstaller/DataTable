-- chunkname: @IQIGame\\UI\\InputPlayerNameTextUI.lua

local InputPlayerNameTextUI = Base:Extend("InputPlayerNameTextUI", "IQIGame.Onigao.UI.InputPlayerNameTextUI", {
	isClickLogin = false
})
local bigMonth = {
	true,
	nil,
	true,
	nil,
	true,
	nil,
	true,
	true,
	nil,
	true,
	nil,
	true
}
local smallMonth = {
	[6] = true,
	[9] = true,
	[4] = true,
	[11] = true
}
local specialMonth = {
	[2] = true
}

function InputPlayerNameTextUI:OnInit()
	self.isMan = true
	self.isClickLogin = false

	self:InitComponent()
	self:InitDelegate()
end

function InputPlayerNameTextUI:InitComponent()
	self.TextTitle:GetComponent("Text").text = InputPlayerNameTextUIApi:GetTextTitle()
	self.TextTitle1:GetComponent("Text").text = InputPlayerNameTextUIApi:GetTextTitle1()
	self.ErrorTipsText:GetComponent("Text").text = InputPlayerNameTextUIApi:GetNameErrorTipsText()
	self.createNameTimeLine = self.gameObject:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	self.girlToBoyTimeLine = self.manImg:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	self.boyToGirlTimeLine = self.girlImg:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	self.monthScroll = self.monthScroll:GetComponent("DateTimePickerScrollRect")
	self.dayScroll = self.dayScroll:GetComponent("DateTimePickerScrollRect")

	LuaUtility.SetCanvasGroupShowWithGameObject(self.dataSelect, false)
end

function InputPlayerNameTextUI:InitDelegate()
	function self.__OnNameInputValueChangedEventProxy(text)
		self:__OnNameInputValueChangedEventHandler(text)
	end

	function self.delegateBtnRandom()
		self:OnClickBtnRandom()
	end

	function self.delegateBtnLogin()
		self:OnClickBtnLogin()
	end

	function self.OnGendersToggleValueChangeDelegate(isOn)
		self:GendersToggleValueChange(isOn)
	end

	function self.delegateOnClickButtonBirth()
		self:OnClickButtonBirth()
	end

	function self.OnMonthChangeDelegate(SelectedValue)
		self:OnMonthChange(SelectedValue)
	end

	function self.OnDayChangeDelegate(SelectedValue)
		self:OnDayChange(SelectedValue)
	end

	function self.delegateOnClickConfirmBtn()
		self:OnClickConfirmBtn()
	end

	function self.onCreateNameSuccessEvent()
		self:OnCreateNameSuccess()
	end
end

function InputPlayerNameTextUI:OnAddListeners()
	self.BtnLogin:GetComponent("Button").onClick:AddListener(self.delegateBtnLogin)
	self.BtnRandom:GetComponent("Button").onClick:AddListener(self.delegateBtnRandom)
	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:AddListener(self.__OnNameInputValueChangedEventProxy)
	self.gendersToggle:GetComponent("Toggle").onValueChanged:AddListener(self.OnGendersToggleValueChangeDelegate)
	self.buttonBirth:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonBirth)
	self.confirmBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickConfirmBtn)

	self.monthScroll.OnSelectedValueChanged = self.monthScroll.OnSelectedValueChanged + self.OnMonthChangeDelegate
	self.dayScroll.OnSelectedValueChanged = self.dayScroll.OnSelectedValueChanged + self.OnDayChangeDelegate

	EventDispatcher.AddEventListener(EventID.InputNameUICreateNameSuccessEvent, self.onCreateNameSuccessEvent)
	EventUtil.AddEventListener(self, EventID.ChangeNameSensitiveErrorEvent)
end

function InputPlayerNameTextUI:OnRemoveListeners()
	self.BtnLogin:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLogin)
	self.BtnRandom:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRandom)
	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:RemoveListener(self.__OnNameInputValueChangedEventProxy)
	self.buttonBirth:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonBirth)
	self.confirmBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickConfirmBtn)

	self.monthScroll.OnSelectedValueChanged = self.monthScroll.OnSelectedValueChanged - self.OnMonthChangeDelegate
	self.dayScroll.OnSelectedValueChanged = self.dayScroll.OnSelectedValueChanged - self.OnDayChangeDelegate

	EventDispatcher.RemoveEventListener(EventID.InputNameUICreateNameSuccessEvent, self.onCreateNameSuccessEvent)
	EventUtil.ClearEventListener(self)
end

function InputPlayerNameTextUI:__OnChangeNameSensitiveErrorEventHandler()
	self.isClickLogin = false
end

function InputPlayerNameTextUI:OnCreateNameSuccess()
	SDKLoginModule.CreateNewRole()
	self.createNameTimeLine:Play()

	self.createNameCoroutine = CoroutineUtility.CreateCoroutine(function()
		while self.createNameTimeLine.state == UnityEngine.Playables.PlayState.Playing do
			CoroutineUtility.Yield()
		end

		UIModule.Close(Constant.UIControllerName.InputPlayerNameTextUI)
		EventDispatcher.DispatchSingleEvent(EventID.CreateNameSuccessEvent)
		EventDispatcher.Dispatch(EventID.StoryChangePlayer)

		self.isClickLogin = false
	end)

	self.createNameCoroutine:Start()
end

function InputPlayerNameTextUI:GendersToggleValueChange(isOn)
	self.isMan = isOn

	LuaUtility.SetGameObjectShow(self.manImg, isOn)
	LuaUtility.SetGameObjectShow(self.girlImg, not isOn)

	if isOn then
		self.girlToBoyTimeLine:Play()
	else
		self.boyToGirlTimeLine:Play()
	end

	LuaUtility.PlaySoundWithID(10000001)
end

function InputPlayerNameTextUI:OnClickConfirmBtn()
	local str = string.format("%s/%s", self.monthScroll.SelectedValue < 10 and "0" .. self.monthScroll.SelectedValue or self.monthScroll.SelectedValue, self.dayScroll.SelectedValue < 10 and "0" .. self.dayScroll.SelectedValue or self.dayScroll.SelectedValue)

	LuaUtility.SetText(self.textBirth, str)
	LuaUtility.SetCanvasGroupShowWithGameObject(self.dataSelect, false)
end

function InputPlayerNameTextUI:OnClickButtonBirth()
	LuaUtility.SetCanvasGroupShowWithGameObject(self.dataSelect, true)
	self.monthScroll:ResetItems(12)
	self.monthScroll:SmoothScrollTo(0, 0.2, 0.5, 0.5)
end

function InputPlayerNameTextUI:OnMonthChange(selectedValue)
	local selectDay = self.dayScroll.SelectedValue
	local dayDefine = 0

	if bigMonth[selectedValue] then
		dayDefine = 31
	elseif specialMonth[selectedValue] then
		dayDefine = 29
	elseif smallMonth[selectedValue] then
		dayDefine = 30
	end

	if dayDefine == self.dayScroll:GetItemsCount() then
		return
	end

	self.dayScroll:ResetItems(dayDefine)

	if selectDay == 0 then
		self.dayScroll:SmoothScrollTo(0, 0.2, 0.5, 0.5)
	else
		self.dayScroll:SmoothScrollTo(math.min(selectDay, dayDefine) - 1, 0.2, 0.5, 0.5)
	end
end

function InputPlayerNameTextUI:OnDayChange()
	return
end

function InputPlayerNameTextUI:GetPreloadAssetPaths()
	return nil
end

function InputPlayerNameTextUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function InputPlayerNameTextUI:OnOpen(userData)
	UIModule.Close(Constant.UIControllerName.LoginUI)
	LuaUtility.SetText(self.textBirth, "01/01")
	self:OnClickBtnRandom()
	self:GendersToggleValueChange(true)
end

function InputPlayerNameTextUI:OnClose(userData)
	return
end

function InputPlayerNameTextUI:OnPause()
	return
end

function InputPlayerNameTextUI:OnResume()
	return
end

function InputPlayerNameTextUI:OnCover()
	return
end

function InputPlayerNameTextUI:OnReveal()
	return
end

function InputPlayerNameTextUI:OnRefocus(userData)
	return
end

function InputPlayerNameTextUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function InputPlayerNameTextUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function InputPlayerNameTextUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function InputPlayerNameTextUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function InputPlayerNameTextUI:OnDestroy()
	self.createNameTimeLine = nil
	self.girlToBoyTimeLine = nil
	self.boyToGirlTimeLine = nil
	self.monthScroll = nil
	self.dayScroll = nil
end

function InputPlayerNameTextUI:OnClickBtnRandom()
	local len = #CfgRoleRandomNameTable
	local random1 = math.random(1, len)
	local random2 = math.random(1, len)
	local random3 = math.random(1, len)
	local cfgRandom1 = CfgRoleRandomNameTable[random1]
	local cfgRandom2 = CfgRoleRandomNameTable[random2]
	local cfgRandom3 = CfgRoleRandomNameTable[random3]

	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = cfgRandom1.Name1 .. cfgRandom2.Name2 .. cfgRandom3.Name3
end

function InputPlayerNameTextUI:OnClickBtnLogin()
	if not self.isLegality or self.isClickLogin == true then
		return
	end

	local name = self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").text
	local filteredName = FilterName(name)

	if filteredName ~= name or filteredName == "" or filteredName == nil then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, UserInfoApi:GetNameUnserviceableText())

		return
	end

	self.isClickLogin = true

	SDKLoginModule.SensitiveWordFilter(filteredName, function(resultStr, isHasSensitive)
		if isHasSensitive then
			NoticeModule.ShowNotice(21045002)

			self.isClickLogin = false

			return
		end

		local monthStr
		local monthValue = self.monthScroll.SelectedValue

		if monthValue < 10 then
			if monthValue == 0 then
				monthStr = "0" .. 1
			else
				monthStr = "0" .. monthValue
			end
		else
			monthStr = tostring(monthValue)
		end

		local dayStr
		local dayValue = self.dayScroll.SelectedValue

		if dayValue < 10 then
			if dayValue == 0 then
				dayStr = "0" .. 1
			else
				dayStr = "0" .. dayValue
			end
		else
			dayStr = tostring(dayValue)
		end

		local data = {}

		data[UserInfoModule.CHANGE_PLAYER_NAME] = resultStr
		data[UserInfoModule.CHANGE_PLAYER_Sex] = tostring(self.isMan and 0 or 1)
		data[UserInfoModule.CHANGE_PLAYER_BirthDay] = string.format("%s/%s", monthStr, dayStr)

		UserInfoModule.ChangeUserData(data)
	end)
end

function InputPlayerNameTextUI:__OnNameInputValueChangedEventHandler(text)
	local min = CfgDiscreteDataTable[45].Data[1]
	local max = CfgDiscreteDataTable[45].Data[2]
	local length = #text

	self.isLegality = min <= length and length <= max

	self.ErrorTipsText:SetActive(not self.isLegality)
	LuaUtility.SetGameObjectShow(self.effect_inputName, true)
	LuaUtility.SetText(self.successTips_07, text)

	self.isClickLogin = false
end

return InputPlayerNameTextUI
