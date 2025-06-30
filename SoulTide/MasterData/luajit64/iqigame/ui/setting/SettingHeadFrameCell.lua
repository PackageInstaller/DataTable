-- chunkname: @IQIGame\\UI\\Setting\\SettingHeadFrameCell.lua

local m = {
	isCurrentSetting = false
}

function m.New(view, rootUI)
	local obj = Clone(m)

	obj:Init(view, rootUI)

	return obj
end

function m:Init(view, rootUI)
	self.rootUI = rootUI
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TagText, SettingPlayerInfoViewApi:GetString("TagText"))
end

function m:SetData(data)
	self.headFrameData = data

	self.Lock:SetActive(not self.headFrameData.isLock)

	local playerHeadFrameData = SettingModule.GetPlayHeadFrameData(PlayerModule.PlayerInfo.baseInfo.avatarFrame)

	if playerHeadFrameData then
		self.isCurrentSetting = playerHeadFrameData.cfgID == self.headFrameData.cfgID
	end

	local path = UIGlobalApi.GetPrefabRoot(self.headFrameData.cfgInfo.Prefab)

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)
	self.Tag:SetActive(self.isCurrentSetting)

	local timeLimit = self.headFrameData:GetTimeLimit()

	self.DateTag:SetActive(timeLimit > 0 and timeLimit > PlayerModule.GetServerTime())
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	for i = 0, self.HeadFrame.transform.childCount - 1 do
		local obj = self.HeadFrame.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local goFrame = UnityEngine.Object.Instantiate(asset)

	goFrame.transform:SetParent(self.HeadFrame.transform, false)
	UIUtil.InitSortedComponents(self.View:GetComponentInParent(typeof(UnityEngine.Canvas)), goFrame)
end

function m:Select(choose)
	self.Choose:SetActive(choose)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
