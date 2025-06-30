-- chunkname: @IQIGame\\UI\\HomeLandVisit\\HomeLandVisitRender.lua

HomeLandVisitRender = {}

function HomeLandVisitRender.New(itemCellView)
	local itemCell = Clone(HomeLandVisitRender)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandVisitRender:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.playerHead = PlayerHeadUI.New(self.PlayerHead)

	UGUIUtil.SetText(self.TextBtnVisit, HomeLandVisitUIApi:GetString("TextBtnVisit"))
	UGUIUtil.SetText(self.TextBtnGoHome, HomeLandVisitUIApi:GetString("TextBtnGoHome"))

	self.btnVisit = self.BtnVisit:GetComponent("Button")
	self.btnGoHome = self.BtnGoHome:GetComponent("Button")

	function self.delegateBtnVisit()
		self:OnBtnVisit()
	end

	function self.delegateBtnGoHome()
		self:OnBtnGoHome()
	end

	self:AddListener()
end

function HomeLandVisitRender:AddListener()
	self.btnVisit.onClick:AddListener(self.delegateBtnVisit)
	self.btnGoHome.onClick:AddListener(self.delegateBtnGoHome)
end

function HomeLandVisitRender:RemoveListener()
	self.btnVisit.onClick:RemoveListener(self.delegateBtnVisit)
	self.btnGoHome.onClick:RemoveListener(self.delegateBtnGoHome)
end

function HomeLandVisitRender:SetDate(data)
	self.friendData = data

	if self.friendData then
		local isIn = self.friendData.pId == HomeLandLuaModule.targetPid

		self.BtnGoHome:SetActive(isIn)
		self.BtnVisit:SetActive(not isIn)
		self.playerHead:SetData(self.friendData.headIcon, self.friendData.pLv, self.friendData.avatarFrame)
		UGUIUtil.SetText(self.TextName, self.friendData.pName)
		UGUIUtil.SetText(self.TextSign, self.friendData.remark)

		local onlineText = ""

		if self.friendData.online then
			onlineText = MiscApi:GetString("OnlineText")
		else
			onlineText = getSimpleTimeDurationText(PlayerModule.GetServerTime() - self.friendData.lastLoginTime, 3)
		end

		UGUIUtil.SetText(self.TextSignTime, onlineText)
	end
end

function HomeLandVisitRender:OnBtnVisit()
	if not HomeLandLuaModule.isVisitHome then
		net_home.exitHome()
	end

	HomeLandLuaModule.Shutdown()
	HomeLandLuaModule.VisitHome(self.friendData.serverId, self.friendData.pId)
	UIModule.Close(Constant.UIControllerName.HomeLandVisitUI)
end

function HomeLandVisitRender:OnBtnGoHome()
	HomeLandLuaModule.Shutdown()
	HomeLandLuaModule.EnterHome()
	UIModule.Close(Constant.UIControllerName.HomeLandVisitUI)
end

function HomeLandVisitRender:Dispose()
	self:RemoveListener()
	self.playerHead:Dispose()

	self.playerHead = nil

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandVisitRender
