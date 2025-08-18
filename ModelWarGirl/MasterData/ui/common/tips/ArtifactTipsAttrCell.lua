-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\ArtifactTipsAttrCell.lua

local ArtifactTipsAttrCell = Class("ArtifactTipsAttrCell", UIControls.Panel)

function ArtifactTipsAttrCell:ctor()
	self.imgAttr = UIControls.Image(self, self.mPath .. "/Icon")
	self.textName = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.textNumber = UIControls.Label(self, self.mPath .. "/TextNum")
end

function ArtifactTipsAttrCell:setAttr(attrName, value)
	self.attrName = attrName
	self.value = value

	local zhName, attrValue = ClientUtils.getRolePropZhName(attrName, value)

	self.textName:setText(zhName)
	self.textNumber:setText(attrValue)

	local icon = ClientUtils.getRolePropIcon(attrName)

	if icon then
		self.imgAttr:setImage(icon[1], icon[2])
	end
end

return ArtifactTipsAttrCell
