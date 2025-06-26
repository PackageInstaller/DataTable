-- chunkname: @IQIGame\\UI\\Main\\PlayerInfoView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.View:GetComponent("Canvas").worldCamera = UnityEngine.Camera.main

	self.View.transform:SetParent(MainCityModule.showPlayer.transform, false)
	self:InitPostionAndScale()

	function self.DelegateOnClickHeroBtn()
		self:OnClickHeroBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickHomeBtn()
		self:OnClickHomeBtn()
	end

	function self.DelegateOnClickCopyUIDBtn()
		self:OnClickCopyUIDBtn()
	end

	function self.DelegateRefreshPlayerInfoData(type)
		self:ChangeUserDataCallBack(type)
	end

	function self.DelegatePlayerDataChange()
		self:PlayerDataChange()
	end

	function self.DelegateOnClickPlayerInfoBtn()
		self:OnClickPlayerInfoBtn()
	end

	function self.OnDelegation_NotifyRedDot_Task()
		self:UpdateRedDot_Task()
	end

	function self.OnDelegation_NotifyRedDot_Warlock()
		self:UpdateRedDot_Warlock()
	end

	self.expProgressImgCom = self.ExpProgressImg:GetComponent("Image")

	UGUIUtil.SetText(self.LvTitleText, "Lv.")
	UGUIUtil.SetText(self.HeroTitle, MainUIAPI:GetHeroTitle())
	UGUIUtil.SetText(self.TaskTitle, MainUIAPI:GetTaskTitle())
	UGUIUtil.SetText(self.HomeTitle, MainUIAPI:GetHomeTitle())
	UGUIUtil.SetText(self.HeroEnTitle, MainUIAPI:GetHeroEnTitle())
	UGUIUtil.SetText(self.TaskEnTitle, MainUIAPI:GetTaskEnTitle())
	UGUIUtil.SetText(self.HomeEnTitle, MainUIAPI:GetHomeEnTitle())
	UGUIUtil.SetTextsInChildren(self.CopyUIDBtn, MainUIAPI:GetCopyTitle())
	self:SetPlayerInfo()
	self:PlayerDataChange()
	self:AddListeners()
end

function m:AddListeners()
	self.HeroBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHeroBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.HomeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickHomeBtn)
	self.CopyUIDBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCopyUIDBtn)
	self.PlayerInfoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPlayerInfoBtn)
	EventDispatcher.AddEventListener(EventID.NotifyPlayerDataChange, self.DelegateRefreshPlayerInfoData)
	EventDispatcher.AddEventListener(EventID.PlayerDataChangeEvent, self.DelegatePlayerDataChange)
	EventDispatcher.AddEventListener(EventID.PlayerLvChange, self.DelegatePlayerDataChange)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Task, self.RedDot_10001)
	RedDotModule.Subscribe(Constant.E_RedDotPath.Warlock, self.RedDot_60001)
end

function m:RemoveListeners()
	self.HeroBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHeroBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.HomeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickHomeBtn)
	self.CopyUIDBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCopyUIDBtn)
	self.PlayerInfoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPlayerInfoBtn)
	EventDispatcher.RemoveEventListener(EventID.NotifyPlayerDataChange, self.DelegateRefreshPlayerInfoData)
	EventDispatcher.RemoveEventListener(EventID.PlayerDataChangeEvent, self.DelegatePlayerDataChange)
	EventDispatcher.RemoveEventListener(EventID.PlayerLvChange, self.DelegatePlayerDataChange)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Task, self.RedDot_10001)
	RedDotModule.Unsubscribe(Constant.E_RedDotPath.Warlock, self.RedDot_60001)
end

function m:SetPlayerInfo()
	UGUIUtil.SetText(self.NameText, PlayerModule.PlayerInfo.baseInfo.pName)
	UGUIUtil.SetText(self.UIDText, PlayerModule.PlayerInfo.baseInfo.guid)
end

function m:ChangeUserDataCallBack(type)
	if type == UserInfoModule.CHANGE_PLAYER_NAME then
		UGUIUtil.SetText(self.NameText, PlayerModule.PlayerInfo.baseInfo.pName)
	elseif type == UserInfoModule.CHANGE_PLAYER_Sex then
		-- block empty
	end
end

function m:PlayerDataChange()
	local curLvExp = 0

	if PlayerModule.PlayerInfo.baseInfo.pLv == #CfgPlayerLevelTable then
		self.expProgressImgCom.fillAmount = 0
	else
		local config = CfgPlayerLevelTable[PlayerModule.PlayerInfo.baseInfo.pLv]

		curLvExp = PlayerModule.PlayerInfo.baseInfo.exp - config.Experience

		if curLvExp < 0 then
			curLvExp = 0
		end

		local nextExp = config.Exp

		self.expProgressImgCom.fillAmount = curLvExp / nextExp
	end

	UGUIUtil.SetText(self.LvText, PlayerModule.PlayerInfo.baseInfo.pLv)
end

function m:InitPostionAndScale()
	self.View.transform.localScale = Vector3.New(0.005, 0.005, 0.005)
	self.View.transform.localPosition = Vector3.New(0.79, 0.25, 0)
end

function m:OnClickHeroBtn()
	UIModule.Open(Constant.UIControllerName.WarlockChoosePanel, Constant.UILayer.UI)
end

function m:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.TaskSystemUI, Constant.UILayer.UI)
end

function m:OnClickHomeBtn()
	return
end

function m:OnClickCopyUIDBtn()
	UnityEngine.GUIUtility.systemCopyBuffer = PlayerModule.PlayerInfo.baseInfo.guid

	NoticeModule.ShowNotice(20031)
end

function m:OnClickPlayerInfoBtn()
	UIModule.Open(Constant.UIControllerName.UserInfoUI, Constant.UILayer.UI, {
		UserInfoModule.GetPlayerInfo(),
		true
	})
end

function m:SetSelfParent(transform)
	self.View.transform:SetParent(transform)
	self:InitPostionAndScale()
end

function m:SetPlayerInfoViewState(state)
	if state then
		self:Show()
	else
		self:Hide()
	end
end

function m:Show()
	self.View:SetActive(true)
end

function m:Hide()
	self.View:SetActive(false)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
