-- chunkname: @IQIGame\\UI\\Guild\\GuildMember\\GuildMemberCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.OnLineTimeText, GuildMemberUIApi:GetString("OnLineTimeTextTitle"))

	self.playerHead = PlayerHeadUI.New(self.PlayerHead)

	function self.DelegateSeePlayerBtn()
		self:OnSeePlayerBtn()
	end

	function self.DelegatePositionBtn()
		self:OnPositionBtn()
	end

	function self.DelegateImpeachmentBtn()
		self:OnImpeachmentBtn()
	end

	function self.DelegateDeleteBtn()
		self:OnDeleteBtn()
	end

	self:AddListener()
end

function m:AddListener()
	self.SeePlayerBtn:GetComponent("Button").onClick:AddListener(self.DelegateSeePlayerBtn)
	self.PositionBtn:GetComponent("Button").onClick:AddListener(self.DelegatePositionBtn)
	self.ImpeachmentBtn:GetComponent("Button").onClick:AddListener(self.DelegateImpeachmentBtn)
	self.DeleteBtn:GetComponent("Button").onClick:AddListener(self.DelegateDeleteBtn)
end

function m:RemoveListener()
	self.SeePlayerBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSeePlayerBtn)
	self.PositionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegatePositionBtn)
	self.ImpeachmentBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateImpeachmentBtn)
	self.DeleteBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateDeleteBtn)
end

function m:SetData(otherData, mySelfData)
	self.memberData = otherData
	self.mySelfData = mySelfData

	self:UpdateView()
end

function m:UpdateView()
	if self.memberData and self.mySelfData then
		local showSee = self.memberData.player.pid ~= self.mySelfData.player.pid

		self.SeePlayerBtn:SetActive(showSee)

		local showPosition = self.mySelfData.position == Constant.GuildPosition.Guild_President and self.memberData.player.pid ~= self.mySelfData.player.pid

		self.PositionBtn:SetActive(showPosition)

		local showImpeachment = self.memberData.position == Constant.GuildPosition.Guild_President and self.memberData.player.pid ~= self.mySelfData.player.pid
		local lastTime = self.memberData.online == false and PlayerModule.GetServerTime() - self.memberData.lastLoginTime >= 604800

		self.ImpeachmentBtn:SetActive(showImpeachment and lastTime)

		local showDelete = (self.mySelfData.position == Constant.GuildPosition.Guild_President or self.mySelfData.position == Constant.GuildPosition.Guild_Vice_President) and self.memberData.player.pid ~= self.mySelfData.player.pid and self.memberData.position == Constant.GuildPosition.Guild_Ordinary_Members

		self.DeleteBtn:SetActive(showDelete)
		self.playerHead:SetData(self.memberData.player.headIcon, self.memberData.player.pLv, self.memberData.player.avatarFrame)
		UGUIUtil.SetText(self.PlayerName, self.memberData.player.pName)

		local onlineText = ""

		if self.memberData.online then
			onlineText = GuildMemberUIApi:GetString("OnlineText")
		else
			onlineText = getSimpleTimeDurationText(PlayerModule.GetServerTime() - self.memberData.lastLoginTime, 3)
		end

		UGUIUtil.SetText(self.LastLoginTimeText, onlineText)
		UGUIUtil.SetText(self.ActivityText, GuildMemberUIApi:GetString("ActivityText", self.memberData.activeNum))
		UGUIUtil.SetText(self.PositionText, GuildMemberUIApi:GetString("PositionText", self.memberData.position))

		for i = 0, self.TitlePos.transform.childCount - 1 do
			local obj = self.TitlePos.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		if self.memberData.player.title > 0 then
			local path = UIGlobalApi.GetPrefabRoot(CfgPlayerCoatOfArmsTable[self.memberData.player.title].Prefab)

			AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)
		end
	end
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	local goTitle = UnityEngine.Object.Instantiate(asset)

	goTitle.transform:SetParent(self.TitlePos.transform, false)
end

function m:OnSeePlayerBtn()
	SettingModule.GetPlayerInfo(self.memberData.player.serverId, self.memberData.player.pid, function(playerInfo)
		UIModule.Open(Constant.UIControllerName.FriendInfoListUI, Constant.UILayer.UI, playerInfo)
	end)
end

function m:OnPositionBtn()
	UIModule.Open(Constant.UIControllerName.GuildMemberAppointUI, Constant.UILayer.UI, {
		OpenType = 1,
		MemberData = self.memberData
	})
end

function m:OnImpeachmentBtn()
	if self.memberData then
		if GuildModule.guildPOD.impeachmentTime > 0 then
			NoticeModule.ShowNotice(21066602)

			return
		end

		NoticeModule.ShowNotice(21066600, function()
			GuildModule.Impeachment()
		end, nil, self.memberData.player.pName)
	end
end

function m:OnDeleteBtn()
	UIModule.Open(Constant.UIControllerName.GuildMemberAppointUI, Constant.UILayer.UI, {
		OpenType = 2,
		MemberData = self.memberData
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.playerHead:Dispose()

	self.playerHead = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
