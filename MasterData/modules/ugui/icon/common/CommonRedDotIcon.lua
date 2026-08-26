-- chunkname: @modules/ugui/icon/common/CommonRedDotIcon.lua

module("modules.ugui.icon.common.CommonRedDotIcon", package.seeall)

local CommonRedDotIcon = class("CommonRedDotIcon", ListScrollCell)

function CommonRedDotIcon:init(go)
	self.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, go)
	self._txtCount = gohelper.findChildText(self.go, "type2/#txt_count")
	self.typeGoDict = self:getUserDataTb_()

	for _, v in pairs(RedDotEnum.Style) do
		self.typeGoDict[v] = gohelper.findChild(self.go, "type" .. v)

		gohelper.setActive(self.typeGoDict[v], false)
	end
end

function CommonRedDotIcon:addEventListeners()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshRelateDot, self)
	ActivityController.instance:registerCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.UseMainUI, self.defaultRefreshDot, self)
end

function CommonRedDotIcon:removeEventListeners()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateActTag, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateFriendInfoDot, self.refreshDot, self)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self.refreshRelateDot, self)
	ActivityController.instance:unregisterCallback(ActivityEvent.ChangeActivityStage, self.refreshDot, self)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.UseMainUI, self.defaultRefreshDot, self)
end

function CommonRedDotIcon:onStart()
	self:refreshDot()
end

function CommonRedDotIcon:refreshDot()
	gohelper.setActive(self.go, false)

	if self.overrideFunc then
		local result, resultString = pcall(self.overrideFunc, self.overrideFuncObj, self)

		if not result then
			logError(string.format("CommonRedDotIcon:overrideFunc error:%s", resultString))
		end

		return
	end

	self:defaultRefreshDot()
end

function CommonRedDotIcon:defaultRefreshDot()
	self.show = false

	local curMainUIId = MainUISwitchModel.instance:getCurUseUI()

	if self.infoList then
		for i, info in ipairs(self.infoList) do
			self.show = RedDotModel.instance:isDotShow(info.id, info.uid)

			if self.show then
				self._txtCount.text = RedDotModel.instance:getDotInfoCount(info.id, info.uid)

				local type = RedDotConfig.instance:getRedDotCO(info.id).style
				local switchReddotCo = MainUISwitchConfig.instance:getUIReddotStyle(curMainUIId, info.id)

				self:showRedDot((switchReddotCo or nil) and switchReddotCo.style)

				return
			end
		end
	end
end

function CommonRedDotIcon:refreshRelateDot(dict)
	for id, _ in pairs(dict) do
		if self.infoDict[id] then
			self:refreshDot()

			return
		end
	end
end

function CommonRedDotIcon:setScale(scale)
	transformhelper.setLocalScale(self.go.transform, scale, scale, scale)
end

function CommonRedDotIcon:setId(id, uid)
	self:setMultiId({
		{
			id = id,
			uid = uid
		}
	})
end

function CommonRedDotIcon:setMultiId(infoList)
	self.infoDict = {}

	if infoList then
		for i, info in ipairs(infoList) do
			info.uid = info.uid or 0
			self.infoDict[info.id] = info.uid
		end
	end

	self.infoList = infoList
end

function CommonRedDotIcon:showRedDot(type)
	gohelper.setActive(self.go, self.show)

	if self.show then
		for _, v in pairs(RedDotEnum.Style) do
			gohelper.setActive(self.typeGoDict[v], type == v)
		end
	end
end

function CommonRedDotIcon:SetRedDotTrsWithType(type, posx, posy)
	local reddottrs = self.typeGoDict[type].transform

	recthelper.setAnchor(reddottrs, posx, posy)
end

function CommonRedDotIcon:setRedDotTranScale(reddotType, scaleX, scaleY, scaleZ)
	scaleX = scaleX or 1
	scaleY = scaleY or 1
	scaleZ = scaleZ or 1

	local reddottrs = self.typeGoDict[reddotType].transform

	transformhelper.setLocalScale(reddottrs, scaleX, scaleY, scaleZ)
end

function CommonRedDotIcon:setRedDotTranLocalRotation(reddotType, x, y, z)
	x = x or 0
	y = y or 0
	z = z or 0

	local reddottrs = self.typeGoDict[reddotType].transform

	transformhelper.setLocalRotation(reddottrs, x, y, z)
end

function CommonRedDotIcon:overrideRefreshDotFunc(func, funcObj)
	self.overrideFunc = func
	self.overrideFuncObj = funcObj
end

function CommonRedDotIcon:onDestroy()
	return
end

return CommonRedDotIcon
