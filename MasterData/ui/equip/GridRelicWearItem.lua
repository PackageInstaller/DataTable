-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Equip\\GridRelicWearItem.lua

local strClassName = "GridRelicWearItem"
local GridRelicWearItem = Class(strClassName, UIControls.ItemGridLoop)

function GridRelicWearItem:initUI()
	GridRelicWearItem.super.initUI(self)

	self.bgLv = UIControls.Panel(self, "BgLv")
	self.imgMax = UIControls.Image(self, "BgLv/ImgMax")
	self.txtLv = UIControls.Label(self, "BgLv/TextLv")
	self.panelWearing = UIControls.Panel(self, "IconState")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onGridClick)
end

function GridRelicWearItem:onGridClick()
	if self.mEventClick then
		self.mEventClick(self)
	end
end

function GridRelicWearItem:_setObj(relic)
	GridRelicWearItem.super._setObj(self, relic)
	self.panelWearing:setVisible(self.object.inWearing ~= nil)
	self.bgLv:setVisible(self.object.enhanceLevel ~= 0)
	self.imgMax:setVisible(self.object:isEnhanceLvMax())
	self.imgNew:setVisible(CurAvatar:relicCanLvUp(self.object))

	if self.object.enhanceLevel > 0 and self.object.enhanceLevel < self.object.maxLevel then
		self.txtLv:setVisible(true)
		self.txtLv:setText(string.format(Lang.get(30171), self.object.enhanceLevel))
	else
		self.txtLv:setVisible(false)
	end
end

function GridRelicWearItem:setBeSelect(isSelected)
	self.beSelected = isSelected

	self.btnSensor:setEnable(self.beSelected == false)
end

return GridRelicWearItem
