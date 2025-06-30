-- chunkname: @IQIGame\\UI\\LunaBattleLine\\Assistant\\LunaBattleAssistantPlayerInfo.lua

local m = {}

function m.New(view, UIController)
	local obj = Clone(m)

	obj:Init(view, UIController)

	return obj
end

function m:Init(view, UIController)
	self.View = view
	self.UIController = UIController

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(player)
	local friendPOD = FriendModule.GetFriendByPId(player.pid)

	UGUIUtil.SetText(self.FriendLabel, LunaBattleLineAssistantUIApi:GetString("FriendLabel", friendPOD ~= nil))
	self.FriendIcon:SetActive(friendPOD ~= nil)

	if player.headIcon ~= nil and player.headIcon ~= 0 then
		local cfgPlayerHeadIconData = CfgPlayerHeadIconTable[player.headIcon]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgPlayerHeadIconData.Url), self.PlayerHeadIcon:GetComponent("Image"))
	end

	for i = 0, self.PlayerHeadFrameNode.transform.childCount - 1 do
		local obj = self.PlayerHeadFrameNode.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	if player.avatarFrame ~= nil and player.avatarFrame ~= 0 then
		local cfgPlayerAvatarFrameData = CfgPlayerAvatarFrameTable[player.avatarFrame]
		local path = UIGlobalApi.GetPrefabRoot(cfgPlayerAvatarFrameData.Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
			parentNode = self.PlayerHeadFrameNode
		})
	end

	for i = 0, self.TitleNode.transform.childCount - 1 do
		local obj = self.TitleNode.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local hasTitle = player.title ~= nil and player.title ~= 0

	if hasTitle then
		local path = UIGlobalApi.GetPrefabRoot(CfgPlayerCoatOfArmsTable[player.title].Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil, {
			parentNode = self.TitleNode
		})
	end

	self.TitleView:SetActive(hasTitle)
	UGUIUtil.SetText(self.PlayerNameText, player.pName)
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	local gameObject = UnityEngine.Object.Instantiate(asset)

	gameObject.transform:SetParent(userData.parentNode.transform, false)
	UIUtil.InitSortedComponents(self.UIController:GetComponent("Canvas"), gameObject)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

return m
