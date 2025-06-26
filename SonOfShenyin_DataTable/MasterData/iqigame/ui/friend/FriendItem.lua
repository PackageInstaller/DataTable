-- chunkname: @IQIGame\\UI\\Friend\\FriendItem.lua

local FriendItem = {}

function FriendItem.New(go, mainView)
	local o = Clone(FriendItem)

	o:Initialize(go, mainView)

	return o
end

function FriendItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FriendItem:InitMembers()
	return
end

function FriendItem:InitComponent()
	self.AddFriendBtn = self.addBtn:GetComponent("Button")
	self.agreeFriendBtn = self.agreeBtn:GetComponent("Button")
	self.refuseFriendBtn = self.refuseBtn:GetComponent("Button")
	self.DetailFriendBtn = self.DetailBtn:GetComponent("Button")
end

function FriendItem:InitDelegate()
	function self.DelegateAddFriend()
		self:AddFriend()
	end

	function self.DelegateAcceptFriend()
		self:AcceptFriend()
	end

	function self.DelegateIgnoreFriend()
		self:IgnoreFriend()
	end

	function self.DelegateOpenPlayerView()
		self:GetPlayerInfo()
	end

	function self.DelegateGetPlayerInfo(playerInfo)
		self:OpenPlayerInfoView(playerInfo)
	end
end

function FriendItem:AddListener()
	self.AddFriendBtn.onClick:AddListener(self.DelegateAddFriend)
	self.agreeFriendBtn.onClick:AddListener(self.DelegateAcceptFriend)
	self.refuseFriendBtn.onClick:AddListener(self.DelegateIgnoreFriend)
	self.DetailFriendBtn.onClick:AddListener(self.DelegateOpenPlayerView)
	EventDispatcher.AddEventListener(EventID.GetPlayerInfoResult, self.DelegateGetPlayerInfo)
end

function FriendItem:RemoveListener()
	self.AddFriendBtn.onClick:RemoveListener(self.DelegateAddFriend)
	self.agreeFriendBtn.onClick:RemoveListener(self.DelegateAcceptFriend)
	self.refuseFriendBtn.onClick:RemoveListener(self.DelegateIgnoreFriend)
	self.DetailFriendBtn.onClick:RemoveListener(self.DelegateOpenPlayerView)
	EventDispatcher.RemoveEventListener(EventID.GetPlayerInfoResult, self.DelegateGetPlayerInfo)
end

function FriendItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function FriendItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function FriendItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FriendItem:Refresh(friendData, type)
	self.FriendData = friendData

	if type == 1 then
		LuaUtility.SetGameObjectShow(self.addBtn, true)
		LuaUtility.SetGameObjectShow(self.applyItem, false)
	elseif type == 2 then
		LuaUtility.SetGameObjectShow(self.addBtn, false)
		LuaUtility.SetGameObjectShow(self.applyItem, true)
	end

	if self.FriendData ~= nil then
		UGUIUtil.SetText(self.LvText, self.FriendData.pLv)
		UGUIUtil.SetText(self.Name, self.FriendData.pName)
		UGUIUtil.SetText(self.ID, self.FriendData.guid)

		if self.FriendData.online then
			UGUIUtil.SetText(self.Online, FriendUIApi:GetOnlinText(true))
		else
			local sencond = PlayerModule.GetServerTime() - friendData.lastLoginTime

			UGUIUtil.SetText(self.Online, getSimpleTimeDurationText(sencond <= 0 and 0 or sencond) .. FriendUIApi:GetOnlinText(false))
		end

		if self.FriendData.heroSkin == nil then
			self.FriendData.heroSkin = {
				skinCid = CfgDiscreteDataTable[Constant.DiscreteData.SKIN_ID].Data[1]
			}
		end

		local skinDataCfg = CfgHeroSkinTable[self.FriendData.heroSkin.skinCid]
		local headPath = SkinModule.GetHeroSkinImgPathByType(skinDataCfg, Constant.SkinImageType.HeroResourcesHead)

		LuaUtility.LoadImage(self, headPath, self.Head:GetComponent("Image"))
	end
end

function FriendItem:IgnoreFriend()
	FriendModule.SendDealWithApplication({
		self.FriendData.id
	}, false)
end

function FriendItem:AcceptFriend()
	FriendModule.SendDealWithApplication({
		self.FriendData.id
	}, true)
end

function FriendItem:AddFriend()
	FriendModule.SendApplyFriend(self.FriendData.pId)
end

function FriendItem:GetPlayerInfo()
	UserInfoModule.GetSeverPlayerInfo(self.FriendData.pId, self.FriendData.serverId)
end

function FriendItem:OpenPlayerInfoView(playerData)
	UIModule.Open(Constant.UIControllerName.UserInfoUI, Constant.UILayer.UI, {
		playerData,
		false
	})
end

return FriendItem
