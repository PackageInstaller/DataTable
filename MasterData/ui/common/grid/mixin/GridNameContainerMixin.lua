-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridNameContainerMixin.lua

local UIControls = UIControls
local GridNameContainerMixin = {}
local WAIT_PLAY_EFX_TIME = 0.5
local WAIT_CHANGE_TIME = 0.2

function GridNameContainerMixin:ctorMixin()
	self:initUI()
end

function GridNameContainerMixin:initUI()
	self.txtItemName = UIControls.Label(self, "TextName")
	self.txtItemNum = UIControls.Label(self, "TextNum")

	if UIControls.checkControlFunc(self, "Efx") then
		self.efx = UIControls.LazyEffectPlayer(self, "Efx")
	end
end

function GridNameContainerMixin:setObj(clientItem)
	self.object = clientItem

	local gridPrefab = UIControls.getGridPanelPrefab(clientItem)

	if gridPrefab ~= self.nowGridPrefab then
		self.nowGridPrefab = gridPrefab

		if self.grid then
			self.grid:destroy()
		end

		local gridType = UIControls.getGridPanelType(clientItem, "Child")

		self.grid = gridType(self, "GridItem", self.nowGridPrefab)

		self.grid:setVisible(true)

		self.grid.mDisableWays = self.mDisableWays
	end

	self.grid:setObj(clientItem)
	self.txtItemName:setText(self.object.name)
end

function GridNameContainerMixin:setTextColor(r, g, b, a)
	self.txtItemName:setColorByRGBA(r, g, b, a)
end

function GridNameContainerMixin:playTransItemEfx(transItem)
	self.coFunc = coroutine.start(function(...)
		coroutine.wait(WAIT_PLAY_EFX_TIME)

		if self.efx then
			self.efx:setVisible(true)
		end

		coroutine.wait(WAIT_CHANGE_TIME)
		self:setObj(transItem)
	end)
end

function GridNameContainerMixin:clearCoroutine()
	if self.coFunc then
		coroutine.stop(self.coFunc)
	end

	self.coFunc = nil
end

return GridNameContainerMixin
