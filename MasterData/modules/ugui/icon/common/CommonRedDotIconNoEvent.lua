-- chunkname: @modules/ugui/icon/common/CommonRedDotIconNoEvent.lua

module("modules.ugui.icon.common.CommonRedDotIconNoEvent", package.seeall)

local CommonRedDotIconNoEvent = class("CommonRedDotIconNoEvent", LuaCompBase)

function CommonRedDotIconNoEvent:init(go)
	self.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, go)
	self.typeGoDict = self:getUserDataTb_()
	self.isShowRedDot = false

	for _, v in pairs(RedDotEnum.Style) do
		self.typeGoDict[v] = gohelper.findChild(self.go, "type" .. v)

		gohelper.setActive(self.typeGoDict[v], false)
	end
end

function CommonRedDotIconNoEvent:onStart()
	self:refreshRedDot()
end

function CommonRedDotIconNoEvent:setCheckShowRedDotFunc(func, funcObj)
	self.checkFunc = func
	self.checkFuncObj = funcObj

	self:refreshRedDot()
end

function CommonRedDotIconNoEvent:setShowType(showType)
	self.showType = showType or RedDotEnum.Style.Normal
end

function CommonRedDotIconNoEvent:refreshRedDot()
	if not self.checkFunc then
		gohelper.setActive(self.go, false)

		return
	end

	local isShow = self.checkFunc(self.checkFuncObj)

	self.isShowRedDot = isShow

	gohelper.setActive(self.go, isShow)

	if isShow then
		for _, v in pairs(RedDotEnum.Style) do
			gohelper.setActive(self.typeGoDict[v], self.showType == v)
		end
	end
end

function CommonRedDotIconNoEvent:setScale(scale)
	transformhelper.setLocalScale(self.go.transform, scale, scale, scale)
end

function CommonRedDotIconNoEvent:onDestroy()
	self.checkFunc = nil
	self.checkFuncObj = nil
end

return CommonRedDotIconNoEvent
