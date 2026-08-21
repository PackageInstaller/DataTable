-- chunkname: @IQIGame\\Scene\\HorizontalRPG\\HorizontalRPGSceneAreaCell.lua

local m = {
	isCreated = false,
	MovePlatform = {}
}
local HorizontalRPGMovePlatform = require("IQIGame.Scene.HorizontalRPG.Element.HorizontalRPGMovePlatform")

function m.New(parent)
	local obj = Clone(m)

	obj:Init(parent)

	return obj
end

function m:Init(parent)
	self.AreaRoot = parent

	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(data)
	self.HorizontalRPGMapAreaData = data
end

function m:OnLoadAreaPrefabSuccess(assetName, asset, duration, innerUserData)
	self.View = UnityEngine.Object.Instantiate(asset)
	self.View.name = self.HorizontalRPGMapAreaData.cid

	self.View.transform:SetParent(self.AreaRoot, false)
	LuaCodeInterface.BindOutlet(self.View, self)

	self.ElementNode = self.View.transform:Find("Root/ElementNode")
	self.MovePlatform = {}

	local moveLand = self.View.transform:Find("Root/Platform/MoveLand")

	if moveLand then
		for i = 0, moveLand.transform.childCount - 1 do
			local obj = moveLand.transform:GetChild(i).gameObject
			local movePlatform = HorizontalRPGMovePlatform.New(obj)

			table.insert(self.MovePlatform, movePlatform)
		end
	end

	self.isCreated = true

	self:RefreshArea()
end

function m:OnLoadAreaPrefabFail(assetName, asset, duration, innerUserData)
	logError(assetName)
end

function m:ShowAreaElement()
	self.isCreated = false

	if self.HorizontalRPGMapAreaData then
		if self.View == nil then
			local path = UIGlobalApi.GetArtPath(self.HorizontalRPGMapAreaData:GetCfgData().ScenePrefab)

			AssetUtil.LoadAsset(self, path, self.OnLoadAreaPrefabSuccess, self.OnLoadAreaPrefabFail)
		else
			self.isCreated = true

			self:RefreshArea()
		end
	end
end

function m:RefreshArea()
	if self.isCreated then
		for i = 0, self.ElementNode.childCount - 1 do
			local pos = i + 1
			local element = HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:GetHorizontalRPGElement(self.HorizontalRPGMapAreaData.cid, pos)
			local root = self.View.transform:Find("Root/ElementNode/" .. pos)
			local pathNode = self.View.transform:Find("Root/ElementNode/" .. pos .. "/path")
			local elementData = self.HorizontalRPGMapAreaData:GetElementDataByPos(pos)

			if elementData then
				element:SetData(elementData, pathNode)

				if HorizontalRPGModule.horizontalRPGScene.PutBoxElement[elementData.cid] == nil then
					element.View.transform:SetParent(root, false)
				end
			else
				if element.ElementData then
					HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:RecycleHorizontalRPGElement(element.ElementData.cid)
				end

				element:Reset()
			end
		end

		if self.showCallBack then
			self.showCallBack(self.HorizontalRPGMapAreaData.pos)
		end

		self.showCallBack = nil
	end
end

function m:RefreshWeather()
	if self.isCreated then
		local Day = self.View.transform:Find("Root/Platform/Day")
		local Night = self.View.transform:Find("Root/Platform/Night")
		local weather = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.weather

		if Day then
			Day.gameObject:SetActive(weather == 0)
		end

		if Night then
			Night.gameObject:SetActive(weather == 1)
		end

		for i, v in pairs(self.MovePlatform) do
			v:RefreshWeather(weather == 0)
		end
	end
end

function m:CleanAreaElement()
	HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:RecycleHorizontalRPGElement(self.HorizontalRPGMapAreaData.cid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self:CleanAreaElement()

	for i, v in pairs(self.MovePlatform) do
		v:Dispose()
	end

	self.HorizontalRPGMapAreaData = nil
	self.AreaRoot = nil
	self.showCallBack = nil

	if self.View then
		LuaCodeInterface.ClearOutlet(self.View, self)
		UnityEngine.Object.Destroy(self.View)

		self.View = nil
	end
end

return m
