-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridEquipTempleteMixin.lua

local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")
local GridEquipTempleteMixin = {}
local UIConst = UIConst

function GridEquipTempleteMixin:initUI()
	GridItemMixin.initUI(self)

	self.panelAttr = UIControls.Panel(self, "AttrPanel")
	self.textMain = UIControls.Label(self, "AttrPanel/Text")
	self.imgMain = UIControls.Image(self, "AttrPanel/Icon")
	self.imgSuit = UIControls.Image(self, "IconSuit")
	self.imgStep = UIControls.Image(self, "StarPanel/Icon")
	self.panelEnhance = UIControls.Panel(self, "BgUpgrade")
	self.panelWearing = UIControls.Panel(self, "IconState")
end

function GridEquipTempleteMixin:_setObj(object)
	GridItemMixin._setObj(self, object)
	self.imgSuit:setVisible(object.haveSuit == 1)

	if object.haveSuit == 1 and #object.suitIds <= 1 then
		local suitPath = CurAvatar:getSuitPath(object.suitIds[1])

		self.imgSuit:setImage(suitPath[1], suitPath[2])
	elseif object.haveSuit == 1 then
		self.imgSuit:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconSuit13")
	end

	self.panelAttr:setVisible(false)
	self.panelEnhance:setVisible(false)
	self.panelWearing:setVisible(false)

	local stepPath = object:getEquipStepPath()

	if stepPath then
		self.imgStep:setImage(stepPath[1], stepPath[2])
	end
end

function GridEquipTempleteMixin:clear()
	GridItemMixin.clear(self)
end

function GridEquipTempleteMixin:openTipsPanel()
	if self.mEnableTips then
		UIManager.getUI("equipTempleteTips"):show(self)
	end
end

setmetatable(GridEquipTempleteMixin, {
	__index = GridItemMixin
})

return GridEquipTempleteMixin
