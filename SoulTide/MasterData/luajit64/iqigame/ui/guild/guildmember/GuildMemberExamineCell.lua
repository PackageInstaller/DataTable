-- chunkname: @IQIGame\\UI\\Guild\\GuildMember\\GuildMemberExamineCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.OnlineTimeLabel, GuildMemberManageUIApi:GetString("OnlineTimeLabel"))
	UGUIUtil.SetTextInChildren(self.AgreeBtn, GuildMemberManageUIApi:GetString("AgreeBtnLabel"))
	UGUIUtil.SetTextInChildren(self.RefuseBtn, GuildMemberManageUIApi:GetString("RefuseBtnLabel"))

	self.playerHeadCell = PlayerHeadUI.New(self.PlayerHead)

	function self.DelegateSeePlayerBtn()
		self:OnSeePlayerBtn()
	end

	function self.DelegateAgreeBtn()
		self:OnAgreeBtn()
	end

	function self.DelegateRefuseBtn()
		self:OnRefuseBtn()
	end

	self:AddListener()
end

function m:AddListener()
	self.SeePlayerBtn:GetComponent("Button").onClick:AddListener(self.DelegateSeePlayerBtn)
	self.AgreeBtn:GetComponent("Button").onClick:AddListener(self.DelegateAgreeBtn)
	self.RefuseBtn:GetComponent("Button").onClick:AddListener(self.DelegateRefuseBtn)
end

function m:RemoveListener()
	self.SeePlayerBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSeePlayerBtn)
	self.AgreeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateAgreeBtn)
	self.RefuseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRefuseBtn)
end

function m:OnSeePlayerBtn()
	if self.auditData then
		SettingModule.GetPlayerInfo(self.auditData.player.serverId, self.auditData.player.pid, function(playerInfo)
			UIModule.Open(Constant.UIControllerName.FriendInfoListUI, Constant.UILayer.UI, playerInfo)
		end)
	end
end

function m:OnAgreeBtn()
	if self.auditData then
		GuildModule.AcceptApply(self.auditData.player.pid)
	end
end

function m:OnRefuseBtn()
	if self.auditData then
		GuildModule.RefuseApply({
			self.auditData.player.pid
		})
	end
end

function m:SetData(data)
	self.auditData = data

	self:UpdateView()
end

function m:UpdateView()
	if self.auditData then
		self.playerHeadCell:SetData(self.auditData.player.headIcon, self.auditData.player.pLv, self.auditData.player.avatarFrame)
		UGUIUtil.SetText(self.NameText, self.auditData.player.pName)

		local onlineText = ""

		if self.auditData.online then
			onlineText = GuildMemberUIApi:GetString("OnlineText")
		else
			onlineText = getSimpleTimeDurationText(PlayerModule.GetServerTime() - self.auditData.lastLoginTime, 3)
		end

		UGUIUtil.SetText(self.LastLoginTimeText, onlineText)

		for i = 0, self.TitlePos.transform.childCount - 1 do
			local obj = self.TitlePos.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		if self.auditData.player.title > 0 then
			local path = UIGlobalApi.GetPrefabRoot(CfgPlayerCoatOfArmsTable[self.auditData.player.title].Prefab)

			AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)
		end
	end
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	local goTitle = UnityEngine.Object.Instantiate(asset)

	goTitle.transform:SetParent(self.TitlePos.transform, false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.playerHeadCell:Dispose()

	self.playerHeadCell = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
