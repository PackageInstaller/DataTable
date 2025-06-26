-- chunkname: @IQIGame\\UI\\Common\\WeatherTimeUI.lua

WeatherTimeUI = {}

function WeatherTimeUI.New(view)
	local obj = Clone(WeatherTimeUI)

	obj:Init(view)

	return obj
end

function WeatherTimeUI:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(view, self)
end

function WeatherTimeUI:SetData(tWeatherCid, time)
	if self.Timer ~= nil then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.StartTime = time

	local cfgWeatherInfo = CfgMainCityWeatherTable[tWeatherCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgWeatherInfo.Icon), self.ImgIcon:GetComponent("Image"))

	self.Text:GetComponent("Text").text = cfgWeatherInfo.Name
	self.TextTime:GetComponent("Text").text = WeatherTimeUIApi:GetString("TextTime", getHourMinuteText(time))
	self.Timer = Timer.New(function()
		self:ShowTime()
	end, 60, -1)

	self.Timer:Start()
end

function WeatherTimeUI:ShowTime()
	self.StartTime = self.StartTime + 60
	self.TextTime:GetComponent("Text").text = WeatherTimeUIApi:GetString("TextTime", getHourMinuteText(self.StartTime))
end

function WeatherTimeUI:Dispose()
	if self.Timer ~= nil then
		self.Timer:Stop()

		self.Timer = nil
	end

	self.StartTime = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return WeatherTimeUI
