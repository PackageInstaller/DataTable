-- chunkname: @modules/ugui/icon/common/CommonIconTag.lua

module("modules.ugui.icon.common.CommonIconTag", package.seeall)

local CommonIconTag = class("CommonIconTag", LuaCompBase)

function CommonIconTag:init(go)
	self.go = go
	self.tr = go.transform
	self.typeGoDict = self:getUserDataTb_()

	for getApproach, v in pairs(ItemEnum.GetApproach2Tag) do
		self.typeGoDict[getApproach] = gohelper.findChild(self.go, "type" .. v)

		gohelper.setActive(self.typeGoDict[getApproach], false)
	end
end

function CommonIconTag:setScale(scale)
	transformhelper.setLocalScale(self.tr, scale, scale, scale)
end

function CommonIconTag:setAnchor(anchorX, anchorY)
	recthelper.setAnchor(self.tr, anchorX, anchorY)
end

function CommonIconTag:showTag(getApproach)
	gohelper.setActive(self.typeGoDict[getApproach], true)
end

function CommonIconTag:onDestroy()
	return
end

return CommonIconTag
