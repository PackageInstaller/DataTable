-- chunkname: @IQIGame\\UI\\Chat\\PlayerInfoPanel.lua

local PlayerInfoPanel = {
	playerData = {},
	cellView = {},
	headIconTable = {}
}

function PlayerInfoPanel.PackageOrReuseView(ui, itemCellPrefab)
	if ui == nil or itemCellPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_PlayerInfoPanel == nil then
		ui.__SUB_UI_MAP_PlayerInfoPanel = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_PlayerInfoPanel
	local itemCell

	if subUIMap[itemCellPrefab:GetInstanceID()] ~= nil then
		itemCell = subUIMap[itemCellPrefab:GetInstanceID()]
	else
		itemCell = PlayerInfoPanel.New(itemCellPrefab)
		subUIMap[itemCellPrefab:GetInstanceID()] = itemCell
	end

	itemCell.parentUI = ui

	return itemCell
end

function PlayerInfoPanel.New(cellObj)
	local itemCell = Clone(PlayerInfoPanel)

	itemCell.cellView = {}
	itemCell.cellObj = cellObj

	LuaCodeInterface.BindOutlet(cellObj, itemCell.cellView)

	local headIcon = itemCell.cellView.playerInfoHeadIcon.transform:GetChild(0)

	itemCell.HeadIconGO = headIcon.gameObject

	LuaCodeInterface.BindOutlet(itemCell.HeadIconGO, itemCell.headIconTable)

	itemCell.cellView.infoBtnTxt:GetComponent("Text").text = ChatUIApi:GetString("infoBtnTxt")
	itemCell.cellView.addFriendBtnTxt:GetComponent("Text").text = ChatUIApi:GetString("addFriendBtnTxt")
	itemCell.cellView.visitBtnTxt:GetComponent("Text").text = ChatUIApi:GetString("visitBtnTxt")
	itemCell.cellView.reportBtnTxt:GetComponent("Text").text = ChatUIApi:GetString("reportBtnTxt")

	function itemCell.DelegateOnClosePlayerInfoPanel()
		itemCell:OnClosePlayerInfoPanel()
	end

	function itemCell.DelegateOnInfoBtnHandler()
		itemCell:OnInfoBtnHandler()
	end

	function itemCell.DelegateOnAddFriendBtnHandler()
		itemCell:OnAddFriendBtnHandler()
	end

	function itemCell.DelegateOnVisitBtnHandler()
		itemCell:OnVisitBtnHandler()
	end

	function itemCell.DelegateOnReportBtnBtnHandler()
		itemCell:OnReportBtnHandler()
	end

	function itemCell.DelegateBtnBlackList()
		itemCell:OnBtnBlackList()
	end

	itemCell.cellView.visitBtn:SetActive(UnlockFunctionModule.IsUnlock(Constant.UnlockType.HOME))
	itemCell:AddListeners()

	return itemCell
end

function PlayerInfoPanel:AddListeners()
	self.cellView.playerInfoCloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClosePlayerInfoPanel)
	self.cellView.infoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnInfoBtnHandler)
	self.cellView.addFriendBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnAddFriendBtnHandler)
	self.cellView.visitBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnVisitBtnHandler)
	self.cellView.reportBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnReportBtnBtnHandler)
	self.cellView.blacklistBtn:GetComponent("Button").onClick:AddListener(self.DelegateBtnBlackList)
end

function PlayerInfoPanel:RemoveListeners()
	self.cellView.playerInfoCloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClosePlayerInfoPanel)
	self.cellView.infoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnInfoBtnHandler)
	self.cellView.addFriendBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnAddFriendBtnHandler)
	self.cellView.visitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnVisitBtnHandler)
	self.cellView.reportBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnReportBtnBtnHandler)
	self.cellView.blacklistBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBlackList)
end

function PlayerInfoPanel:SetItem(playerData)
	self.cellObj:SetActive(true)

	self.chatPlayerData = playerData
	self.playerData = playerData.PlayerSimplePOD

	local headIconData = CfgPlayerHeadIconTable[playerData.PlayerSimplePOD.headIcon]

	self.cellView.playerInfoNameTxt:GetComponent("Text").text = ChatUIApi:GetString("GetPlayerName", playerData.PlayerSimplePOD.pName)

	if playerData.PlayerSimplePOD.guid ~= nil then
		self.cellView.playerInfoNumTxt:GetComponent("Text").text = ChatUIApi:GetString("GetPlayerNum", playerData.PlayerSimplePOD.guid)
	else
		self.cellView.playerInfoNumTxt:GetComponent("Text").text = ChatUIApi:GetString("GetPlayerNum", playerData.PlayerSimplePOD.pid)
	end

	AssetUtil.LoadImage(self, UIGlobalApi.IconPath .. headIconData.Url, self.headIconTable.HeadIcon:GetComponent("Image"), self.OnLoadSucceed, self.OnLoadFailed)

	local lv = 0

	if playerData.PlayerSimplePOD.pid == PlayerModule.PlayerInfo.baseInfo.pid then
		lv = PlayerModule.PlayerInfo.baseInfo.pLv
	else
		lv = playerData.PlayerSimplePOD.pLv
	end

	self.headIconTable.LevelText:GetComponent("Text").text = ChatUIApi:GetString("GetPlayerLv", lv)

	if playerData.PlayerSimplePOD.avatarFrame ~= nil and playerData.PlayerSimplePOD.avatarFrame ~= "" then
		local avatarFrame = tonumber(playerData.PlayerSimplePOD.avatarFrame)

		if avatarFrame > 0 then
			local cfgPlayerAvatarFrameData = CfgPlayerAvatarFrameTable[avatarFrame]
			local path = UIGlobalApi.GetPrefabRoot(cfgPlayerAvatarFrameData.Prefab)

			AssetUtil.LoadAsset(self, path, self.OnLoadFrameSucceed, nil, self.headIconTable)
		end
	end
end

function PlayerInfoPanel:OnLoadFrameSucceed(assetName, asset, duration, userData)
	local root = userData.HeadFrame

	if root ~= nil then
		for i = 0, root.transform.childCount - 1 do
			local obj = root.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goFrame = UnityEngine.Object.Instantiate(asset)

		goFrame.transform:SetParent(root.transform, false)
		UIUtil.InitSortedComponents(self.cellObj:GetComponent("Canvas"), goFrame)
	end
end

function PlayerInfoPanel:OnBtnBlackList()
	FriendModule.SendMute(self.playerData.pid)
end

function PlayerInfoPanel:OnInfoBtnHandler()
	return
end

function PlayerInfoPanel:OnAddFriendBtnHandler()
	SettingModule.GetPlayerInfo(self.playerData.serverId, self.playerData.pid, function(playerInfo)
		UIModule.Open(Constant.UIControllerName.FriendInfoListUI, Constant.UILayer.UI, playerInfo)
	end)
end

function PlayerInfoPanel:OnVisitBtnHandler()
	HomeLandLuaModule.VisitHome(self.playerData.serverId, self.playerData.pid)
end

function PlayerInfoPanel:OnReportBtnHandler()
	UIModule.Open(Constant.UIControllerName.PlayerAccusationUI, Constant.UILayer.UI, self.chatPlayerData)
end

function PlayerInfoPanel:Clear()
	self.playerData = {}
end

function PlayerInfoPanel:OnClosePlayerInfoPanel()
	self:Clear()
	self.cellObj:SetActive(false)
end

function PlayerInfoPanel.OnLoadSucceed(assetName, asset, duration, icon)
	return
end

function PlayerInfoPanel.OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlayerInfoPanel:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.HeadIconGO, self.headIconTable)
	LuaCodeInterface.ClearOutlet(self.cellObj, self.cellView)

	self.cellObj = nil
	self.cellView = nil
	self.HeadIconGO = nil
	self.headIconTable = nil
end

return PlayerInfoPanel
