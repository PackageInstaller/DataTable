-- chunkname: @modules/ugui/icon/common/CommonRedDotTag.lua

module("modules.ugui.icon.common.CommonRedDotTag", package.seeall)

local CommonRedDotTag = class("CommonRedDotTag", LuaCompBase)

function CommonRedDotTag:init(go)
	self.go = go

	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshRelateDot, self)
end

function CommonRedDotTag:refreshDot()
	if self.overrideFunc then
		local result, resultString = pcall(self.overrideFunc, self.overrideFuncObj, self)

		if not result then
			logError(string.format("CommonRedDotTag:overrideFunc dotId:%s error:%s", self.dotId, resultString))
		end

		return
	end

	local show = RedDotModel.instance:isDotShow(self.dotId, 0)

	if self.reverse then
		show = not show
	end

	gohelper.setActive(self.go, show)
end

function CommonRedDotTag:refreshRelateDot(dict)
	self:refreshDot()
end

function CommonRedDotTag:setScale(scale)
	transformhelper.setLocalScale(self.go.transform, scale, scale, scale)
end

function CommonRedDotTag:setId(id, reverse)
	self.dotId = id
	self.reverse = reverse
end

function CommonRedDotTag:overrideRefreshDotFunc(func, funcObj)
	self.overrideFunc = func
	self.overrideFuncObj = funcObj
end

function CommonRedDotTag:onDestroy()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshRelateDot, self)
end

return CommonRedDotTag
