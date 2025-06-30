-- chunkname: @IQIGame\\UI\\Common\\PlayerHeadUI.lua

PlayerHeadUI = {}

function PlayerHeadUI.New(view)
	local obj = Clone(PlayerHeadUI)

	obj:Init(view)

	return obj
end

function PlayerHeadUI:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)
end

function PlayerHeadUI:SetData(playerHeadIconCid, level, playerHeadFrameCid)
	local cfgPlayerHeadIconData = CfgPlayerHeadIconTable[playerHeadIconCid]

	if cfgPlayerHeadIconData ~= nil then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgPlayerHeadIconData.Url), self.HeadIcon:GetComponent("Image"))
	end

	if playerHeadFrameCid ~= nil and playerHeadFrameCid > 0 and self.HeadFrame ~= nil then
		local cfgPlayerAvatarFrameData = CfgPlayerAvatarFrameTable[playerHeadFrameCid]
		local path = UIGlobalApi.GetPrefabRoot(cfgPlayerAvatarFrameData.Prefab)

		AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)
	end

	if self.LevelText ~= nil then
		self.LevelText:GetComponent("Text").text = getTipText(Constant.TipConst.TIP_LEVEL, level)
	end
end

function PlayerHeadUI:OnLoadSucceed(assetName, asset, duration, userData)
	for i = 0, self.HeadFrame.transform.childCount - 1 do
		local obj = self.HeadFrame.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local goFrame = UnityEngine.Object.Instantiate(asset)

	goFrame.transform:SetParent(self.HeadFrame.transform, false)
	UIUtil.InitSortedComponents(self.View:GetComponentInParent(typeof(UnityEngine.Canvas)), goFrame)
	EventDispatcher.Dispatch(EventID.PlayerHeadFrameLoaded)
end

function PlayerHeadUI:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end
