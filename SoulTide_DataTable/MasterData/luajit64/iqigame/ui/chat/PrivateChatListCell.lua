-- chunkname: @IQIGame\\UI\\Chat\\PrivateChatListCell.lua

local PrivateChatListCell = {
	cellView = {},
	headIcon = {},
	_playerData = {}
}

function PrivateChatListCell.PackageOrReuseView(ui, itemCellPrefab)
	if ui == nil or itemCellPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_PrivateChatListCell == nil then
		ui.__SUB_UI_MAP_PrivateChatListCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_PrivateChatListCell
	local itemCell

	if subUIMap[itemCellPrefab:GetInstanceID()] ~= nil then
		itemCell = subUIMap[itemCellPrefab:GetInstanceID()]
	else
		itemCell = PrivateChatListCell.New(itemCellPrefab)
		subUIMap[itemCellPrefab:GetInstanceID()] = itemCell
	end

	return itemCell
end

function PrivateChatListCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_PrivateChatListCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_PrivateChatListCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_PrivateChatListCell = nil
end

function PrivateChatListCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self.cellObj:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateOnBtnClick)
	LuaCodeInterface.ClearOutlet(self.cellObj, self.cellView)
	LuaCodeInterface.ClearOutlet(self.headGo, self.headIcon)

	self.cellObj = nil
	self.cellView = nil
	self.headGo = nil
	self.headIcon = nil
end

function PrivateChatListCell.New(itemCellView)
	local itemCell = Clone(PrivateChatListCell)

	itemCell.cellObj = itemCellView
	itemCell.cellView = {}

	LuaCodeInterface.BindOutlet(itemCell.cellObj, itemCell.cellView)

	itemCell.headGo = itemCell.cellView.goSlotParent.transform:GetChild(0).gameObject

	LuaCodeInterface.BindOutlet(itemCell.headGo, itemCell.headIcon)

	itemCell.headIcon.HeadIcon:GetComponent("Button").enabled = false

	function itemCell.DelegateOnBtnClick()
		itemCell:OnBtnClick()
	end

	itemCell.cellObj:GetComponent("Toggle").onValueChanged:AddListener(itemCell.DelegateOnBtnClick)

	return itemCell
end

function PrivateChatListCell:SetItem(PlayerData)
	self._playerData = PlayerData

	if PlayerData.avatarFrame ~= nil and PlayerData.avatarFrame ~= "" then
		local avatarFrame = tonumber(PlayerData.avatarFrame)

		if avatarFrame > 0 then
			local cfgPlayerAvatarFrameData = CfgPlayerAvatarFrameTable[avatarFrame]
			local path = UIGlobalApi.GetPrefabRoot(cfgPlayerAvatarFrameData.Prefab)

			AssetUtil.LoadAsset(self, path, self.OnLoadFrameSucceed, nil, self.headIcon)
		end
	end

	self.headIcon.LevelText:GetComponent("Text").text = ChatUIApi:GetString("GetPlayerLv", PlayerData.pLv)

	local headIconData = CfgPlayerHeadIconTable[tonumber(PlayerData.headIcon)]

	if headIconData ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.IconPath .. headIconData.Url, self.headIcon.HeadIcon:GetComponent("Image"))
	end

	local isPlayerHavePrivateChat = ChatModule.IsPlayerHavePrivateChatNewMsg(PlayerData.pName)

	if isPlayerHavePrivateChat == true then
		self:SetRedPointVisible(true)
	else
		self:SetRedPointVisible(false)
	end
end

function PrivateChatListCell:OnLoadFrameSucceed(assetName, asset, duration, userData)
	local root = userData.HeadFrame

	if root ~= nil then
		for i = 0, root.transform.childCount - 1 do
			local obj = root.transform:GetChild(i).gameObject

			UnityEngine.GameObject.Destroy(obj)
		end

		local goFrame = UnityEngine.Object.Instantiate(asset)

		goFrame.transform:SetParent(root.transform, false)
		UIUtil.InitSortedComponents(root:GetComponentInParent(typeof(UnityEngine.Canvas)), goFrame)
	end
end

function PrivateChatListCell:SetRedPointVisible(value)
	if self.cellView._privateChatRedBg ~= nil then
		self.cellView._privateChatRedBg:SetActive(value)
	end
end

function PrivateChatListCell:SelectCell(isOn)
	self.cellObj:GetComponent("Toggle").isOn = isOn
end

function PrivateChatListCell:OnBtnClick()
	ChatModule.CurrentChannelIndex = ChatModule.CHANNEL_PRIVATE_CHAT

	EventDispatcher.Dispatch(EventID.ClickPrivateChatPlayer, self._playerData)
	self:SetRedPointVisible(false)
end

function PrivateChatListCell:OnBtnDeleteClick()
	return
end

function PrivateChatListCell:Clear()
	self.cellView.playerNameTxt:GetComponent("Text").text = ""
	self.cellView.remarkTxt:GetComponent("Text").text = ""
	self.cellView = {}
	self.headIcon = {}

	UnityEngine.Object.Destroy(self.cellObj)

	self._playerData = {}
end

return PrivateChatListCell
