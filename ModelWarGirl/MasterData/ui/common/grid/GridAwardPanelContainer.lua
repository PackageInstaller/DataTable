-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridAwardPanelContainer.lua

local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResGridSpecialImgConfig = require("ClientData/ResGridSpecialImgConfig")
local UIControls = UIControls
local GridAwardPanelContainer = Class("GridAwardPanelContainer", UIControls.Child)

function GridAwardPanelContainer:ctor()
	if UIControls.checkControlFunc(self, "LockPanel") then
		self.panelLock = UIControls.Panel(self, "LockPanel")
	end

	if UIControls.checkControlFunc(self, "GetPanel") then
		self.panelGet = UIControls.Panel(self, "GetPanel")
	end

	if UIControls.checkControlFunc(self, "DisPanel") then
		self.panelDis = UIControls.Panel(self, "DisPanel")
	end

	self.imgSpe = UIControls.Image(self, "ImgSpe")
	self.isShowPreviewTips = false
end

function GridAwardPanelContainer:setObj(clientItem)
	self.object = clientItem

	local gridPrefab = UIControls.getGridPanelPrefab(clientItem)

	if gridPrefab ~= self.nowGridPrefab then
		self.nowGridPrefab = gridPrefab

		if self.grid then
			self.grid:destroy()
		end

		local gridType = UIControls.getGridPanelType(clientItem, "Child")

		self.grid = gridType(self, "GirdPanel", self.nowGridPrefab)

		self.grid:setVisible(true)

		self.grid.mDisableWays = self.mDisableWays

		if clientItem.itemType and Const.HAVE_PREVIEW_TIPS_TYPE_DIC[clientItem.itemType] then
			self.grid.isShowPreviewTips = self.isShowPreviewTips
		end

		if self.awardExtraConfig then
			for propName, value in pairs(self.awardExtraConfig) do
				self.grid[propName] = value
			end
		end

		self:confirmSpecialGridConfig()
	end

	self.grid:setObj(clientItem)

	if self.lazyEffChild then
		self.lazyEffChild:setVisible(false)
	end
end

function GridAwardPanelContainer:setTipsEnable(enable)
	self.grid.mEnableTips = enable
end

function GridAwardPanelContainer:flyToCommonFuncEntryPanel()
	self.grid:flyToCommonFuncEntryPanel()
end

function GridAwardPanelContainer:setState(state)
	if self.panelLock then
		self.panelLock:setVisible(state == Const.ACT_ACHIEVE_STATE_LOCK)
	end

	if self.panelGet then
		self.panelGet:setVisible(state == Const.ACT_ACHIEVE_STATE_ENOUGH)
	end

	if self.panelDis then
		self.panelDis:setVisible(state == Const.ACT_ACHIEVE_STATE_GOT)
	end

	if self.grid then
		self.grid:setObjGray(state == Const.ACT_ACHIEVE_STATE_GOT)

		if self.grid.imgNew then
			self.grid.imgNew:setVisible(state == Const.ACT_ACHIEVE_STATE_ENOUGH)
		end
	end
end

function GridAwardPanelContainer:setContainerConfig(configId)
	self.configData = ResSpecialGridConfig[configId]
end

function GridAwardPanelContainer:setIconGray(isGray)
	self.grid:setIconGray(isGray)
	self:setNumColor(GRID_STATE.dis)
end

function GridAwardPanelContainer:confirmSpecialGridConfig()
	if self.configData then
		if self.configData.hide_bg == 1 and self.grid and self.grid.onConfigHideBg then
			self.grid:onConfigHideBg()
		end

		if self.configData.hide_quality == 1 and self.grid and self.grid.onConfigHideQuality then
			self.grid:onConfigHideQuality()
		end

		if self.configData.hide_frag_bg == 1 and self.grid and self.grid.onConfigHideFragBg then
			self.grid:onConfigHideFragBg()
		end

		if self.configData.is_speIcon_hide and self.grid and self.grid.onSpeIconHide then
			self.grid:onSpeIconHide()
		end

		if self.configData.is_bgStar_hide and self.grid and self.grid.onBgStarHide then
			self.grid:onBgStarHide()
		end

		self:setNumColor(GRID_STATE.normal)
	end
end

local GRID_STATE = {
	high = 2,
	dis = 3,
	normal = 1
}

function GridAwardPanelContainer:setNumColor(state)
	if not self.grid.setTextNumColor then
		return
	end

	local cfgData

	if state == GRID_STATE.normal then
		cfgData = self.configData.num_color_nml
	elseif state == GRID_STATE.high then
		cfgData = self.configData.num_color_high
	elseif state == GRID_STATE.dis then
		cfgData = self.configData.num_color_dis
	end

	if cfgData ~= nil then
		local color = {}

		color.r = cfgData[1]
		color.g = cfgData[2]
		color.b = cfgData[3]
		color.a = cfgData[4] or 255

		self.grid:setTextNumColor(color)
	end
end

function GridAwardPanelContainer:setSpe(v, typeId, speConfigId)
	if v and typeId == 3 and ResGridSpecialImgConfig[speConfigId] then
		local effPath = ResGridSpecialImgConfig[speConfigId].eff_path

		if effPath and effPath ~= "" then
			self:setSpecEffect(effPath)
		end

		if ResGridSpecialImgConfig[speConfigId].icon_path and ResGridSpecialImgConfig[speConfigId].icon_name then
			self.imgSpe:setImage("Atlas/" .. ResGridSpecialImgConfig[speConfigId].icon_path, ResGridSpecialImgConfig[speConfigId].icon_name)
		end
	end

	self.imgSpe:setVisible(v)
end

function GridAwardPanelContainer:setSpecEffect(effPath)
	if not self.lazyEffChild then
		self.lazyEffChild = UIControls.Child(self, "", "System/Common/Grid/GridEfxCell")
		self.lazyEfx = UIControls.LazyEffectPlayer(self.lazyEffChild, "")

		self.lazyEffChild:setVisible(true)
	end

	self.lazyEfx:playEffectByPath(effPath)
end

return GridAwardPanelContainer
