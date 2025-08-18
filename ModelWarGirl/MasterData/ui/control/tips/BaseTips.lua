-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Tips\\BaseTips.lua

local TipsFunc = require("UI/Control/Tips/TipsFuncBtns")
local WINDOW_TIPS_ORDER = 15
local BaseTips = Class("BaseTips", UIControls.Window)

function BaseTips:ctor(prefabPath, order, needShow)
	return
end

function BaseTips:initFuncBtn(maxFuncCount, otherFuncCount)
	if UIControls.checkControlFunc(self, "BgPanel/Func") then
		self.panelFunc = TipsFunc(self, "BgPanel/Func", maxFuncCount, otherFuncCount)
	end

	if UIControls.checkControlFunc(self, "BgPanel/BtnProbability") then
		self.btnProb = UIControls.Button(self, "BgPanel/BtnProbability")

		self.btnProb:addEventClick(self.onClickProb)
	end
end

function BaseTips:show(grid, config, uiConfig, checkNeedConvertObject, params)
	self.uiConfig = uiConfig

	if grid == nil then
		self:clear()
	end

	self._grid = grid

	if self.panelFunc then
		self._config = config

		if config == nil then
			config = UIControls.TipsConfig()
		end

		self.panelFunc:setConfig(config:getConfigs(grid), grid)
	end

	self.checkNeedConvertObject = checkNeedConvertObject

	self:_setObj(grid, params)

	local baseOrder = 0

	if grid.mWindow then
		baseOrder = grid.mWindow:getOrder()
	end

	self:setOrder(baseOrder + WINDOW_TIPS_ORDER)
	self:checkItemSpec()

	if not self:getVisible() then
		self:setVisible(true)
	end
end

function BaseTips:checkItemSpec()
	if self.btnProb and self.item and self.item.resData and self.item.resData.prob_id then
		self.btnProb:setVisible(true)
	end
end

function BaseTips:onClickProb()
	UIManager.getUI("probabilityTips"):show(self._grid, self._config, self.uiConfig, self.checkNeedConvertObject)
	self:setVisible(false)
end

function BaseTips:clear()
	self:setVisible(false)
end

function BaseTips:_setObj(grid)
	return
end

function BaseTips:showObj(ui, obj, uiConfig, tipsConfig, checkNeedConvertObject, params)
	local grid = {}

	grid.mWindow = ui.mWindow or ui
	grid.object = obj
	grid.mDisableWays = ui.mDisableWays

	self:show(grid, tipsConfig, uiConfig, checkNeedConvertObject, params)
end

return BaseTips
