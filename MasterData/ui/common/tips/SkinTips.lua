-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SkinTips.lua

local ItemGuidePanel = require("UI/Common/Tips/ItemGuidePanel")
local ResItemConvert = require("ClientData/ResItemConvert")
local strClassName = "SkinTips"
local SkinTips = Class(strClassName, UIControls.Tips)

function SkinTips:ctor()
	self:initUI()
end

function SkinTips:initUI()
	self.txtRule = UIControls.Label(self, "BgPanel/TextRule")
	self.panelGuide = ItemGuidePanel(self, "BgPanel/TipsWayPanel")

	self.panelGuide:setVisible(false)

	if UIControls.checkControlFunc(self, "BgPanel/IconChange") then
		self.panelIconChange = UIControls.Panel(self, "BgPanel/IconChange")
		self.textChange = UIControls.Label(self, "BgPanel/TextChange")
	end
end

function SkinTips:_setObj(grid)
	self.srcGrid = grid
	self.item = grid.object

	self.txtRule:setText(self.item.resData.desc)

	if not grid.mDisableWays then
		self.panelGuide:show(self.item.resData.get_ids, self.srcGrid, self.uiConfig)
	end

	self:setItems()

	if self.panelIconChange ~= nil then
		local checkConvertObject = self.checkNeedConvertObject and BaseObject.checkConvertObject(self.item)

		self.panelIconChange:setVisible(checkConvertObject)
		self.textChange:setVisible(checkConvertObject)

		if checkConvertObject then
			local resItemConvert = ResItemConvert[self.item.id]

			self.textChange:setText(resItemConvert.des)
		end
	end
end

function SkinTips:setItems()
	if self.grid then
		self.grid:destroy()

		self.grid = nil
	end

	self.grid = UIControls.SkinCardChild(self, "BgPanel/SkinCardPanel", "System/Common/Grid/GridSkinCard")

	self.grid:setVisible(true)

	self.grid.isShowPreviewTips = false
	self.grid.mEnableTips = false

	self.grid:setSkin(self.item.clientData)
end

return SkinTips
