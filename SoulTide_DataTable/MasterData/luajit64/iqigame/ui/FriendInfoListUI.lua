-- chunkname: @IQIGame\\UI\\FriendInfoListUI.lua

local FriendInfoListUI = {
	showSmallCollectItemCount = 6,
	friendExhibitionCellTab = {}
}

FriendInfoListUI = Base:Extend("FriendInfoListUI", "IQIGame.Onigao.UI.FriendInfoListUI", FriendInfoListUI)

local FriendExhibitionCell = require("IQIGame.UI.FriendInfoList.FriendExhibitionCell")

function FriendInfoListUI:OnInit()
	UGUIUtil.SetText(self.PanelTitle, FriendInfoListUIApi:GetString("PanelTitle"))
	UGUIUtil.SetText(self.TextLv, FriendInfoListUIApi:GetString("TextLv"))
	UGUIUtil.SetText(self.InfoCarTitle, FriendInfoListUIApi:GetString("InfoCarTitle"))
	UGUIUtil.SetText(self.TextName1, FriendInfoListUIApi:GetString("TextName1"))
	UGUIUtil.SetText(self.TextName2, FriendInfoListUIApi:GetString("TextName2"))
	UGUIUtil.SetText(self.InfoExhibitionTitle, FriendInfoListUIApi:GetString("InfoExhibitionTitle"))
	UGUIUtil.SetText(self.TextBtnPreviewCard, FriendInfoListUIApi:GetString("TextBtnPreviewCard"))
	UGUIUtil.SetText(self.TextBtnContact, FriendInfoListUIApi:GetString("TextBtnContact"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnPreviewCard()
		self:OnBtnPreviewCard()
	end

	function self.delegateBtnContact()
		self:OnBtnContact()
	end

	self.friendExhibitionCellTab = {}

	for i = 1, 3 do
		local cell = FriendExhibitionCell.New(self["ExhibitionPos" .. i], i)

		self.friendExhibitionCellTab[i] = cell
	end
end

function FriendInfoListUI:GetPreloadAssetPaths()
	return nil
end

function FriendInfoListUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FriendInfoListUI:IsManualShowOnOpen(userData)
	return false
end

function FriendInfoListUI:GetBGM(userData)
	return nil
end

function FriendInfoListUI:OnOpen(userData)
	self.playerInfo = userData
	self.numImg = {}

	for i = 0, self.SortLv.transform.childCount - 1 do
		self.numImg[i + 1] = self.SortLv.transform:GetChild(i).gameObject
	end

	self:UpDateView()
end

function FriendInfoListUI:OnClose(userData)
	return
end

function FriendInfoListUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnPreviewCard:GetComponent("Button").onClick:AddListener(self.delegateBtnPreviewCard)
	self.BtnContact:GetComponent("Button").onClick:AddListener(self.delegateBtnContact)
end

function FriendInfoListUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnPreviewCard:GetComponent("Button").onClick:RemoveListener(self.delegateBtnPreviewCard)
	self.BtnContact:GetComponent("Button").onClick:RemoveListener(self.delegateBtnContact)
end

function FriendInfoListUI:OnPause()
	return
end

function FriendInfoListUI:OnResume()
	return
end

function FriendInfoListUI:OnCover()
	return
end

function FriendInfoListUI:OnReveal()
	return
end

function FriendInfoListUI:OnRefocus(userData)
	return
end

function FriendInfoListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FriendInfoListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FriendInfoListUI:OnLoadSucceed(assetName, asset, duration, userData)
	local type = userData.type

	if type == "LoadPlayerAvatarFrame" then
		for i = 0, self.HeadFrame.transform.childCount - 1 do
			local obj = self.HeadFrame.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goFrame = UnityEngine.Object.Instantiate(asset)

		goFrame.transform:SetParent(self.HeadFrame.transform, false)
		UIUtil.InitSortedComponents(self.UIController:GetComponent("Canvas"), goFrame)
	elseif type == "LoadPlayerTitle" then
		for i = 0, self.TitlePos.transform.childCount - 1 do
			local obj = self.TitlePos.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goTitle = UnityEngine.Object.Instantiate(asset)

		goTitle.transform:SetParent(self.TitlePos.transform, false)
	end
end

function FriendInfoListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FriendInfoListUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.friendExhibitionCellTab) do
		v:Dispose()
	end
end

function FriendInfoListUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.FriendInfoListUI)
end

function FriendInfoListUI:UpDateView()
	local cfgPlayerHeadIcon = CfgPlayerHeadIconTable[self.playerInfo.baseInfo.headIcon]
	local iconPath = UIGlobalApi.IconPath .. cfgPlayerHeadIcon.Url

	AssetUtil.LoadImage(self, iconPath, self.HeadIcon:GetComponent("Image"))

	local cfgPlayerAvatarFrame = CfgPlayerAvatarFrameTable[self.playerInfo.baseInfo.avatarFrame]
	local path = UIGlobalApi.GetPrefabRoot(cfgPlayerAvatarFrame.Prefab)

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
		type = "LoadPlayerAvatarFrame"
	})
	self:ShowPlayerLv(self.playerInfo.baseInfo.pLv)
	self:ShowTitle(self.playerInfo.baseInfo.title)
	UGUIUtil.SetText(self.TextName, self.playerInfo.baseInfo.pName)
	UGUIUtil.SetText(self.SettingDes, self.playerInfo.baseInfo.intro)
	UGUIUtil.SetText(self.TextPlayerID, FriendInfoListUIApi:GetString("TextPlayerID", self.playerInfo.baseInfo.guid))
	UGUIUtil.SetText(self.TextValue1, self.playerInfo.soulCount)
	UGUIUtil.SetText(self.TextValue2, self:GetMaxMazeChapter())
	self.GuildInfoNode:SetActive(self.playerInfo.guildId ~= nil and self.playerInfo.guildId > 0)

	local guildName = self.playerInfo.guildName == nil and "" or self.playerInfo.guildName

	UGUIUtil.SetText(self.GuildName, guildName)
	self:UpDateExhibitionPos()

	local otherCollectItems = {}
	local showCollectItems = {}

	for i, v in pairs(self.playerInfo.showCollectItems) do
		if v > 0 then
			table.insert(showCollectItems, v)
		end
	end

	for i, v in pairs(self.playerInfo.allCollectItems) do
		if table.indexOf(showCollectItems, v) == -1 then
			table.insert(otherCollectItems, v)
		end
	end

	self.ExhibitionSmallModule:SetActive(false)

	for i = 1, self.ExhibitionList.transform.childCount - 1 do
		local obj = self.ExhibitionList.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	self.ImgMore:SetActive(#otherCollectItems > self.showSmallCollectItemCount)

	for i = 1, #otherCollectItems do
		if i < self.showSmallCollectItemCount then
			local goObj = UnityEngine.Object.Instantiate(self.ExhibitionSmallModule)

			goObj.transform:SetParent(self.ExhibitionList.transform, false)
			goObj:SetActive(true)

			local id = otherCollectItems[i]
			local path = UIGlobalApi.GetIconPath(CfgItemTable[id].Icon)
			local imgTransform = goObj.transform:GetChild(0)

			AssetUtil.LoadImage(self, path, imgTransform:GetChild(0).gameObject:GetComponent("Image"))
		end
	end

	local isFriend = FriendModule.GetFriendByPId(self.playerInfo.baseInfo.pid) ~= nil
	local isSelf = self.playerInfo.baseInfo.pid == PlayerModule.PlayerInfo.baseInfo.pid

	self.BtnContact:SetActive(not isFriend and not isSelf)
	self.BtnPreviewCard:SetActive(#self.playerInfo.allCollectItems > 0)
end

function FriendInfoListUI:UpDateExhibitionPos()
	for i, v in pairs(self.friendExhibitionCellTab) do
		local data

		if self.playerInfo.showCollectItems then
			data = self.playerInfo.showCollectItems[i]
		end

		v:SetData(data)
	end
end

function FriendInfoListUI:GetMaxMazeChapter()
	local str = ""
	local num = 0
	local cfgMazeInstance, chapterOrder

	for i = 1, #self.playerInfo.finishMaze do
		local id = self.playerInfo.finishMaze[i]
		local cfg = CfgMazeInstanceTable[id]
		local Order1 = CfgChapterTable[cfg.ChapterId].Order
		local Order2 = cfg.Order
		local rankValue = Order1 * 1000 + Order2

		if num < rankValue then
			num = rankValue
			cfgMazeInstance = cfg
			chapterOrder = Order1
		end
	end

	if cfgMazeInstance then
		str = SettingUIApi:GetString("ChapterValue", chapterOrder, cfgMazeInstance.Order)
	end

	return str
end

function FriendInfoListUI:ShowTitle(settingTitle)
	local isSetTitle = settingTitle ~= nil and settingTitle > 0

	if isSetTitle then
		local path = UIGlobalApi.GetPrefabRoot(CfgPlayerCoatOfArmsTable[settingTitle].Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
			type = "LoadPlayerTitle"
		})
	end
end

function FriendInfoListUI:ShowPlayerLv(lv)
	local lvString = tostring(lv)
	local reverseLvString = string.reverse(lvString)
	local index = 1

	for i = #self.numImg, 1, -1 do
		local numImgObj = self.numImg[i]
		local str = string.sub(reverseLvString, index, index)

		if str ~= "" then
			numImgObj:SetActive(true)
			AssetUtil.LoadImage(self, SettingUIApi:GetString("imgLvPath", tonumber(str)), numImgObj:GetComponent("Image"))
		else
			numImgObj:SetActive(false)
		end

		index = index + 1
	end
end

function FriendInfoListUI:OnBtnPreviewCard()
	UIModule.Open(Constant.UIControllerName.CheckPlayerExhibitionUI, Constant.UILayer.UI, self.playerInfo.allCollectItems)
end

function FriendInfoListUI:OnBtnContact()
	FriendModule.SendApplyFriend(self.playerInfo.baseInfo.pid)
end

return FriendInfoListUI
