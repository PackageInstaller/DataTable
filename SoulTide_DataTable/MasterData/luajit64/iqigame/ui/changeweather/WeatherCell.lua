-- chunkname: @IQIGame\\UI\\ChangeWeather\\WeatherCell.lua

local m = {
	WeatherCid = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:Clear()
	self.View:SetActive(false)
	self.View.transform:SetParent(nil)
end

function m:SetData(weatherCid)
	self.View:SetActive(true)

	self.WeatherCid = weatherCid

	local cfgMazeWeatherData = CfgMazeWeatherTable[weatherCid]

	self.NameText:GetComponent("Text").text = cfgMazeWeatherData.Name

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgMazeWeatherData.Icon), self.Icon:GetComponent("Image"))
end

function m:OnClick()
	EventDispatcher.Dispatch(EventID.MazeSelectWeather, self.WeatherCid)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function m:Destroy()
	local view = self.View

	self:Dispose()
	UnityEngine.Object:Destroy(view)
end

return m
