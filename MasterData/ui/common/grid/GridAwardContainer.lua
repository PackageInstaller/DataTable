-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\GridAwardContainer.lua

local ResSpecialGridConfig = require("ClientData/ResSpecialGridConfig")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ResRandClient = require("ClientData/ResRandClient")
local ResGridSpecialImgConfig = require("ClientData/ResGridSpecialImgConfig")
local UIControls = UIControls
local GridAwardContainer = Class("GridAwardContainer", UIControls.Child)

function GridAwardContainer:ctor()
	self.statePanel = UIControls.Panel(self, "StatePanel")
	self.imgLock = UIControls.Image(self, "StatePanel/ImgStateLock")
	self.imgGet = UIControls.Image(self, "StatePanel/ImgStateGet")
	self.imgSpe = UIControls.Image(self, "ImgSpe")
	self.panelNum = UIControls.Panel(self, "NumPanel")
	self.txtNum = UIControls.Label(self, "NumPanel/Text")
	self.isShowPreviewTips = false
	self.mEventHold = nil
	self.mEventClick = nil

	if UIControls.checkControlFunc(self, "BtnAdd") then
		self.btnAdd = UIControls.Button(self, "BtnAdd")

		self.btnAdd:addEventClick(self.onAddClick)

		self.btnChange = UIControls.Button(self, "BtnChange")

		self.btnChange:addEventClick(self.onChangeClick)
	end

	if UIControls.checkControlFunc(self, "TextPettyPayNum") then
		self.txtPettyPayNum = UIControls.Label(self, "TextPettyPayNum")
	end

	if UIControls.checkControlFunc(self, "NewLabel") then
		self.newLabel = UIControls.Panel(self, "NewLabel")
	end
end

function GridAwardContainer:setObj(clientItem, checkNeedConvertObject)
	self.object = clientItem

	if clientItem then
		local gridPrefab = UIControls.getGridPanelPrefab(clientItem)

		if gridPrefab ~= self.nowGridPrefab then
			self.nowGridPrefab = gridPrefab

			if self.grid then
				self.grid:destroy()

				self.panelGiftFree = nil
			end

			local gridType = UIControls.getGridPanelType(clientItem, "Child")

			self.grid = gridType(self, "GridItem", self.nowGridPrefab)

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

			if self.holdTipsMode then
				self.grid.mEnableHoldTips = true
				self.grid.mEnableTips = false
			end

			if self.mEventClick then
				self.grid.mEventClick = self.mEventClick
			end

			if self.mEventHold then
				self.grid.mEventHold = self.mEventHold
			end
		end

		self.grid.checkNeedConvertObject = checkNeedConvertObject

		self.grid:setObj(clientItem)
		self.statePanel:setVisible(false)
		self.imgSpe:setVisible(false)

		if self.lazyEffChild then
			self.lazyEffChild:setVisible(false)
		end

		if self.addMode and self.btnAdd then
			self.btnAdd:setVisible(false)
			self.btnChange:setVisible(true)
		end
	else
		if self.grid then
			self.grid:setVisible(false)
		end

		self.statePanel:setVisible(false)
		self.imgSpe:setVisible(false)

		if self.lazyEffChild then
			self.lazyEffChild:setVisible(false)
		end

		if self.addMode and self.btnAdd then
			self.btnAdd:setVisible(true)
			self.btnChange:setVisible(false)
		end
	end
end

function GridAwardContainer:destroy()
	if self.grid then
		self.grid:destroy()

		self.grid = nil
	end

	GridAwardContainer.super.destroy(self)
end

function GridAwardContainer:setContainerConfig(configId)
	self.configData = ResSpecialGridConfig[configId]

	self:setStateImgs()
end

local GRID_STATE = {
	high = 2,
	dis = 3,
	normal = 1
}

function GridAwardContainer:setNumColor(state)
	if not self.grid.setTextNumColor or not self.configData then
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

function GridAwardContainer:setIconGray(isGray)
	self.grid:setIconGray(isGray)
	self:setNumColor(GRID_STATE.dis)
end

function GridAwardContainer:hideTxtNum(isHide)
	self.grid:hideTextNum(isHide)
end

function GridAwardContainer:flyToCommonFuncEntryPanel()
	self.grid:flyToCommonFuncEntryPanel()
end

function GridAwardContainer:confirmSpecialGridConfig()
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

function GridAwardContainer:setState(isLock, isGet, hideLock)
	self.hideLock = hideLock
	self.isLock = isLock
	self.isGet = isGet

	self:_refreshStatePanel()
end

function GridAwardContainer:_refreshStatePanel()
	if self.isLock or self.isGet then
		self.statePanel:setVisible(true)

		if self.isLock and not self.hideLock then
			self.imgLock:setVisible(true)
		else
			self.imgLock:setVisible(false)
		end

		if self.isGet then
			self.imgGet:setVisible(true)
		else
			self.imgGet:setVisible(false)
		end
	else
		self.statePanel:setVisible(false)
	end
end

function GridAwardContainer:setLock(isLock)
	self.isLock = isLock

	self:_refreshStatePanel()
end

function GridAwardContainer:setGet(isGet)
	self.isGet = isGet

	self:_refreshStatePanel()

	if self.lazyEffChild then
		self.lazyEffChild:setVisible(not self.isGet)
	end
end

function GridAwardContainer:setGetEffect(isGet)
	if isGet then
		if not self.efxGridBonus then
			self.efxGridBonus = UIControls.Child(self, "", "System/Common/Grid/GridAwardContainerEfxSpe")
		end

		self.efxGridBonus:setVisible(false)
	elseif self.efxGridBonus then
		self.efxGridBonus:setVisible(false)
	end
end

function GridAwardContainer:setActivitySpecialImage(actId)
	if ResOpActivityTemplate[actId] and ResOpActivityTemplate[actId].grid_special_config then
		self:setSpe(true, 3, ResOpActivityTemplate[actId].grid_special_config)
	else
		self:setSpe(false)
	end
end

function GridAwardContainer:setSpe(v, typeId, speConfigId)
	if v and typeId then
		local iconName = "TxtPass"
		local iconPath = "Atlas/CommonAtlas/GridAtlas/GridAtlas"

		if typeId == 1 then
			iconName = "TxtPass"
		elseif typeId == 2 then
			iconName = "TxtPass01"
		elseif typeId == 3 then
			if ResGridSpecialImgConfig[speConfigId] then
				local configData = ResGridSpecialImgConfig[speConfigId]

				iconName = configData.icon_name

				if configData.icon_path then
					iconPath = "Atlas/" .. configData.icon_path
				end

				local effPath = configData.eff_path

				if effPath and effPath ~= "" then
					self:setSpecEffect(effPath)

					if iconName == nil or iconName == "" then
						return
					end
				end
			end
		elseif typeId == 4 then
			iconName = "TxtLimit01"
		elseif typeId == 5 then
			iconName = "TxtChallengeBossUp"
		end

		self.imgSpe:setImage(iconPath, iconName)
	end

	self.imgSpe:setVisible(v)
end

function GridAwardContainer:setSpecEffect(effPath, cellPath)
	if not self.lazyEffChild then
		self.lazyEffChild = UIControls.Child(self, "", cellPath or "System/Common/Grid/GridEfxCell")
		self.lazyEfx = UIControls.LazyEffectPlayer(self.lazyEffChild, "")

		self.lazyEffChild:setVisible(not self.isGet)
	end

	self.lazyEfx:playEffectByPath(effPath)
end

function GridAwardContainer:setStateImgs()
	if self.configData and self.configData.get_icon_name then
		local iconPath = self.configData.get_icon_path
		local iconName = self.configData.get_icon_name

		self:changeGetImg(iconPath, iconName)
	end
end

function GridAwardContainer:setNumSpe(v, text)
	if v and text then
		self.txtNum:setText(text)
	end

	self.panelNum:setVisible(v)
end

function GridAwardContainer:changeGetImg(path, name)
	self.imgGet:setImage(path, name)
end

function GridAwardContainer:changeLockImg(path, name)
	self.imgLock:setImage(path, name)
end

function GridAwardContainer:setTextNumCtrlEnable()
	if self.grid.setTextNumCtrlEnable then
		self.grid:setTextNumCtrlEnable()
	end
end

function GridAwardContainer:checkGiftFree(hasDiamond)
	if hasDiamond and self.object and self.object.id ~= Const.MONEY_ID_FAKE_DIAMOND then
		if not self.panelGiftFree then
			self.panelGiftFree = UIControls.Child(self.grid, "", "System/Common/Grid/GridFreeCell")
		end

		self.panelGiftFree:setVisible(true)
	elseif self.panelGiftFree then
		self.panelGiftFree:setVisible(false)
	end
end

function GridAwardContainer:onShowRandClient(bonusId)
	local bonus = ResRandClient[bonusId] or {}
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}
	local show_flag = bonus.show_flag or {}

	if showIds[1] then
		local clientItem = BaseObject.GetObject(showIds[1], showNums[1] or 1)

		self.mDisableWays = true

		self:setObj(clientItem)
		self:setVisible(true)

		if show_flag[1] and show_flag[1] >= 1 then
			self:setSpe(true, 3, show_flag[1])
		else
			self:setSpe(false)
		end
	else
		self:setObj(nil)
	end
end

function GridAwardContainer:setAddMode(addMode, addClickCb, changeClickCb)
	self.addMode = addMode

	if self.addMode then
		self.addClickCb = addClickCb
		self.changeClickCb = changeClickCb
	elseif self.btnAdd then
		self.btnAdd:setVisible(false)
		self.btnChange:setVisible(false)
	end
end

function GridAwardContainer:onAddClick()
	if self.addClickCb then
		self.addClickCb(self)
	end
end

function GridAwardContainer:onChangeClick()
	if self.changeClickCb then
		self.changeClickCb(self)
	end
end

function GridAwardContainer:setToHoldMode(eventClick)
	self.mEventClick = eventClick
	self.holdTipsMode = true

	if self.grid then
		self.grid.mEnableHoldTips = true
		self.grid.mEnableTips = false

		if self.mEventClick then
			self.grid.mEventClick = self.mEventClick
		end
	end
end

function GridAwardContainer:setTipsEnable(enable, eventClick)
	self.grid.mEnableTips = enable

	if eventClick then
		self.grid.mEventClick = eventClick
	end
end

function GridAwardContainer:showTips()
	if self.grid and self.grid.openTipsPanel then
		local pre = self.grid.mEnableTips

		self.grid.mEnableTips = true

		self.grid:openTipsPanel()

		self.grid.mEnableTips = pre
	end
end

function GridAwardContainer:showNewLabel(isShow)
	if self.newLabel then
		self.newLabel:setVisible(isShow)
	end
end

return GridAwardContainer
