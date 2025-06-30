-- chunkname: @IQIGame\\UI\\ChangeWeatherUI.lua

local ChangeWeatherUI = Base:Extend("ChangeWeatherUI", "IQIGame.Onigao.UI.ChangeWeatherUI", {
	WeatherCells = {}
})
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local WeatherCell = require("IQIGame.UI.ChangeWeather.WeatherCell")

function ChangeWeatherUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateCreateWeatherCell()
		return self:CreateWeatherCell()
	end

	function self.DelegateDestroyWeatherCell(weatherCell)
		self:DestroyWeatherCell(weatherCell)
	end

	function self.DelegateOnSelectWeather(weatherCid)
		self:OnSelectWeather(weatherCid)
	end

	self.ObjectPool = UIObjectPool.New(5, self.DelegateCreateWeatherCell, self.DelegateDestroyWeatherCell)
end

function ChangeWeatherUI:GetPreloadAssetPaths()
	return nil
end

function ChangeWeatherUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChangeWeatherUI:OnOpen(userData)
	self:UpdateView(userData)
end

function ChangeWeatherUI:OnClose(userData)
	return
end

function ChangeWeatherUI:OnPause()
	return
end

function ChangeWeatherUI:OnResume()
	return
end

function ChangeWeatherUI:OnCover()
	return
end

function ChangeWeatherUI:OnReveal()
	return
end

function ChangeWeatherUI:OnRefocus(userData)
	return
end

function ChangeWeatherUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChangeWeatherUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChangeWeatherUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChangeWeatherUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChangeWeatherUI:OnDestroy()
	local weatherCell

	for i = 1, #self.WeatherCells do
		weatherCell = self.WeatherCells[i]

		weatherCell:Dispose()
	end

	self.WeatherCells = nil

	self.ObjectPool:Dispose()
end

function ChangeWeatherUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.MazeSelectWeather, self.DelegateOnSelectWeather)
end

function ChangeWeatherUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeSelectWeather, self.DelegateOnSelectWeather)
end

function ChangeWeatherUI:OnClickCloseBtn()
	self:SendResultAndClose(0)
end

function ChangeWeatherUI:UpdateView(weatherList)
	self:ClearWeathers()

	local weatherCell

	for i = 1, #weatherList do
		weatherCell = self.ObjectPool:Obtain()

		weatherCell:SetData(weatherList[i])
		weatherCell.View.transform:SetParent(self.WeatherCellGrid.transform, false)
		table.insert(self.WeatherCells, weatherCell)
	end
end

function ChangeWeatherUI:ClearWeathers()
	local weatherCell

	for i = 1, #self.WeatherCells do
		weatherCell = self.WeatherCells[i]

		weatherCell:Clear()
		self.ObjectPool:Release(weatherCell)
	end

	self.WeatherCells = {}
end

function ChangeWeatherUI:CreateWeatherCell()
	local view = UnityEngine.Object.Instantiate(self.WeatherCellPrefab)

	return WeatherCell.New(view)
end

function ChangeWeatherUI:DestroyWeatherCell(weatherCell)
	weatherCell:Destroy()
end

function ChangeWeatherUI:OnSelectWeather(weatherCid)
	self:SendResultAndClose(weatherCid)
end

function ChangeWeatherUI:SendResultAndClose(weatherCid)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CHOOSE_WEATHER, {
		WeatherCid = weatherCid
	})
	UIModule.Close(Constant.UIControllerName.ChangeWeatherUI)
end

return ChangeWeatherUI
