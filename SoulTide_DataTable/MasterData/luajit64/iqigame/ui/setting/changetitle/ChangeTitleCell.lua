-- chunkname: @IQIGame\\UI\\Setting\\ChangeTitle\\ChangeTitleCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextTag, ChangeTitleUIApi:GetString("TextTag"))
end

function m:SetData(playerTitleData)
	self.playerTitleData = playerTitleData

	local path = UIGlobalApi.GetPrefabRoot(self.playerTitleData.cfgInfo.Prefab)

	AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, nil)

	local isPutOn = self.playerTitleData.cfgID == PlayerModule.PlayerInfo.baseInfo.title

	self.Tag:SetActive(isPutOn)

	local timeLimit = self.playerTitleData:GetTimeLimit()

	self.DateTag:SetActive(timeLimit > 0 and timeLimit > PlayerModule.GetServerTime())
end

function m:OnLoadSucceed(assetName, asset, duration, userData)
	for i = 0, self.TitlePos.transform.childCount - 1 do
		local obj = self.TitlePos.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local goTitle = UnityEngine.Object.Instantiate(asset)

	goTitle.transform:SetParent(self.TitlePos.transform, false)
end

function m:SetSelect(top)
	self.Choose:SetActive(top)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
