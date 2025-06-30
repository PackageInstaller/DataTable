-- chunkname: @IQIGame\\UI\\Friend\\FriendListItem.lua

local FriendListItem = {}
local FriendHeroItemScript = require("IQIGame.UI.Friend.FriendHeroItem")

function FriendListItem.New(go, mainView)
	local o = Clone(FriendListItem)

	o:Initialize(go, mainView)

	return o
end

function FriendListItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FriendListItem:InitMembers()
	return
end

function FriendListItem:InitComponent()
	self.DetailBtn = self.DetailBtn:GetComponent("Button")
	self.VisitHomeBtn = self.VisitHomeBtn:GetComponent("Button")
	self.RemarksBtn = self.RemarksBtn:GetComponent("Button")
	self.DeleteBtn = self.DeleteBtn:GetComponent("Button")
	self.HeroShowGroup = self.HeroShowGroup:GetComponent("ScrollAreaList")
end

function FriendListItem:InitDelegate()
	function self.DelegateRemarkBtn()
		self:RemarkBtnClick()
	end

	function self.DelegateDeleteBtn()
		self:DeleteBtnClick()
	end

	function self.DelegateVisitHomeBtn()
		self:VisitHomeBtnClick()
	end

	function self.DelegateOpenPlayerView()
		self:GetPlayerInfo()
	end

	function self.DelegateGetPlayerInfo(playerInfo)
		self:OpenPlayerInfoView(playerInfo)
	end
end

function FriendListItem:AddListener()
	self.DetailBtn.onClick:AddListener(self.DelegateOpenPlayerView)
	self.VisitHomeBtn.onClick:AddListener(self.DelegateVisitHomeBtn)
	self.RemarksBtn.onClick:AddListener(self.DelegateRemarkBtn)
	self.DeleteBtn.onClick:AddListener(self.DelegateDeleteBtn)
	EventDispatcher.AddEventListener(EventID.GetPlayerInfoResult, self.DelegateGetPlayerInfo)
end

function FriendListItem:RemoveListener()
	self.DetailBtn.onClick:RemoveListener(self.DelegateOpenPlayerView)
	self.VisitHomeBtn.onClick:RemoveListener(self.DelegateVisitHomeBtn)
	self.RemarksBtn.onClick:RemoveListener(self.DelegateRemarkBtn)
	self.DeleteBtn.onClick:RemoveListener(self.DelegateDeleteBtn)
	EventDispatcher.RemoveEventListener(EventID.GetPlayerInfoResult, self.DelegateGetPlayerInfo)
end

function FriendListItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function FriendListItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function FriendListItem:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function FriendListItem:Refresh(friendData)
	self.FriendData = friendData

	if self.FriendData ~= nil then
		UGUIUtil.SetText(self.LvText, self.FriendData.pLv)
		UGUIUtil.SetText(self.FriendName, self.FriendData.pName)
		UGUIUtil.SetText(self.FriendID, self.FriendData.guid)
		UGUIUtil.SetText(self.Remark, self.FriendData.remark)

		if self.Remark:GetComponent("Text").text == "" or self.Remark:GetComponent("Text").text == nil then
			LuaUtility.SetGameObjectShow(self.Remark.gameObject, false)
		else
			LuaUtility.SetGameObjectShow(self.Remark.gameObject, true)
		end

		if self.FriendData.online then
			UGUIUtil.SetText(self.Online, FriendUIApi:GetOnlinText(true))
		else
			local second = PlayerModule.GetServerTime() - friendData.lastLoginTime

			UGUIUtil.SetText(self.Online, getSimpleTimeDurationText(second <= 0 and 0 or second) .. FriendUIApi:GetOnlinText(false))
		end

		if self.FriendData.heroSkin == nil then
			self.FriendData.heroSkin = {
				skinCid = CfgDiscreteDataTable[Constant.DiscreteData.SKIN_ID].Data[1]
			}
		end

		local headPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(self.FriendData.heroSkin.skinCid, Constant.SkinImageType.HeroResourcesHead)

		LuaUtility.LoadImage(self, headPath, self.Head:GetComponent("Image"))

		for i = 1, self.HeroShowGroup.transform:GetChild(0).childCount do
			local heroChild = self.HeroShowGroup.transform:GetChild(0):GetChild(i - 1)

			if i <= #self.FriendData.helpHeros then
				local obj = self.HeroShowGroup.transform:Find("Items"):GetChild(i - 1).gameObject
				local item = FriendHeroItemScript.New(obj, self)

				item:Refresh(self.FriendData.helpHeros[i])
				LuaUtility.SetGameObjectShow(heroChild.gameObject, true)
			else
				LuaUtility.SetGameObjectShow(heroChild.gameObject, false)
			end
		end
	end
end

function FriendListItem:VisitHomeBtnClick()
	return
end

function FriendListItem:RemarkBtnClick()
	EventDispatcher.Dispatch(EventID.OpenChangeRemarkPanel, self.FriendData.id)
end

function FriendListItem:DeleteBtnClick()
	NoticeModule.ShowNotice(20028, function()
		FriendModule.SendDeleteFriend(self.FriendData.id)
	end, nil)
end

function FriendListItem:OpenPlayerInfoView(playerData)
	UIModule.Open(Constant.UIControllerName.UserInfoUI, Constant.UILayer.UI, {
		playerData,
		false
	})
end

function FriendListItem:GetPlayerInfo()
	UserInfoModule.GetSeverPlayerInfo(self.FriendData.pId, self.FriendData.serverId)
end

return FriendListItem
