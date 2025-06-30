-- chunkname: @IQIGame\\UI\\HomeLand\\HomeLandLockRoomView.lua

local HomeLandLockRoomView = {}

function HomeLandLockRoomView.__New(ui)
	local o = Clone(HomeLandLockRoomView)

	o:InitView(ui)

	return o
end

function HomeLandLockRoomView:InitView(ui, rootParent)
	self.rootUI = ui

	LuaCodeInterface.BindOutlet(self.rootUI, self)
	UGUIUtil.SetText(self.TextBtnLock, HomeLandRoomUIApi:GetString("TextBtnLock", false))
	UGUIUtil.SetText(self.TextBtnLockEng, HomeLandRoomUIApi:GetString("TextBtnLock", true))

	self.btnLockComponent = self.BtnLock:GetComponent("Button")
	self.btnBackComponent = self.BtnBack:GetComponent("Button")

	function self.delegateOnLock()
		self:OnClickBtnLock()
	end

	function self.delegateOnBtnBack()
		self:OnClickBackBtn()
	end
end

function HomeLandLockRoomView:AddEventListener()
	self.btnLockComponent.onClick:AddListener(self.delegateOnLock)
	self.btnBackComponent.onClick:AddListener(self.delegateOnBtnBack)
end

function HomeLandLockRoomView:RemoveEventListener()
	self.btnLockComponent.onClick:RemoveListener(self.delegateOnLock)
	self.btnBackComponent.onClick:RemoveListener(self.delegateOnBtnBack)
end

function HomeLandLockRoomView:UpDateView()
	if HomeLandLuaModule.isVisitHome then
		self.BtnLock:SetActive(false)
	else
		self.BtnLock:SetActive(true)
	end

	local cfgRoom = CfgHomeLandRoomTable[HomeLandLuaModule.currentEnterRoomID]

	UGUIUtil.SetText(self.TextRoomName, cfgRoom.Name)
end

function HomeLandLockRoomView:OnClickBtnLock()
	UIModule.Open(Constant.UIControllerName.HomeLandUnlockRoomUI, Constant.UILayer.UI, HomeLandLuaModule.currentEnterRoomID)
end

function HomeLandLockRoomView:OnClickBackBtn()
	local cfgRoom = CfgHomeLandRoomTable[HomeLandLuaModule.currentEnterRoomID]

	if cfgRoom.CastleIndex == 2 then
		UIModule.Open(Constant.UIControllerName.HomeLandChangeRoomUI, Constant.UILayer.UI)
	else
		GameEntry.LuaEvent:Fire(nil, HomelandQuitRoomEventArgs():Fill(HomeLandLuaModule.currentEnterRoomID))
		UIModule.Close(Constant.UIControllerName.HomeLandRoomUI)
	end
end

function HomeLandLockRoomView:Dispose()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)

	self.rootUI = nil
end

function HomeLandLockRoomView:Open()
	self.rootUI:SetActive(true)
	self:AddEventListener()
	self:UpDateView()
end

function HomeLandLockRoomView:Close()
	self.rootUI:SetActive(false)
	self:RemoveEventListener()
end

return HomeLandLockRoomView
