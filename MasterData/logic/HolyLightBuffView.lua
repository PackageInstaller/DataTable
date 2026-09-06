-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holylight/view/HolyLightBuffView.lua

module("logic.extensions.holylight.view.HolyLightBuffView", package.seeall)

local HolyLightBuffView = class("HolyLightBuffView", ViewComponent)

function HolyLightBuffView:buildUI()
	HolyLightBuffView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")

	local buffScrollerview = goutil.findChild(self.mainGO, "buffCol/buffScrollerview")
	local buffScrollercell = goutil.findChild(self.mainGO, "buffCol/buffScrollercell")

	self._buffScrollList = ScrollerList.create(buffScrollerview, buffScrollercell, GameUtil.handler(self._updateBuffCell, self), GameUtil.handler(self._clearBuffCell, self))
end

function HolyLightBuffView:bindEvents()
	HolyLightBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function HolyLightBuffView:unbindEvents()
	HolyLightBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function HolyLightBuffView:onEnter()
	HolyLightBuffView.super.onEnter(self)

	self._activityId = HolyLightController.instance:getActivityId()
	self._activityType = HolyLightController.instance:getActivityType()

	if self._activityId <= 0 then
		TipsFacade.instance:openTipWindowNoX("提示", "不在活动范围内", function()
			self:close()
		end, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._holyLightMgr = HolyLightController.instance:getHolyLightMgr(self._activityId)

	GlobalDispatcher:addListener(GlobalNotify.HolyLightGetInfoRes, self._onUpdateUI, self)
	self:_onUpdateUI()
end

function HolyLightBuffView:onExit()
	HolyLightBuffView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HolyLightGetInfoRes, self._onUpdateUI, self)
	self._buffScrollList:dispose()

	self._holyLightMgr = nil
end

function HolyLightBuffView:_onUpdateUI()
	self:_updateBuffScrollerList()
end

function HolyLightBuffView:_updateBuffScrollerList()
	local buffIdList = self._holyLightMgr:getMyBuffIdList()

	self._buffScrollList:reloadData(buffIdList)
end

function HolyLightBuffView:_updateBuffCell(view, cell, buffId, tag)
	local realLevel = self._holyLightMgr:getRealLevelOfBuff(buffId)
	local data = HolyLightConfig.instance:getHlBuffDataByLv(buffId, realLevel)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "iconGo")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtDesc = goutil.findChildTextComponent(mainGo, "txtDesc")
	local txAttr = goutil.findChildTextComponent(mainGo, "txAttr")
	local path = data.iconPath
	local bgGo = iconGo

	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("ui/%s.png", path)

		local function func()
			return
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	end

	txtName.text = data.name
	txtDesc.text = data.des

	local realLevel = self._holyLightMgr:getRealLevelOfBuff(buffId)
	local maxLevel = self._holyLightMgr:getMaxLevelOfBuff(buffId)

	txAttr.text = realLevel < maxLevel and string.format("当前等级：<color=#20B376FF>%s</color>/%s", realLevel, maxLevel) or string.format("当前等级：%s/%s", realLevel, maxLevel)
end

function HolyLightBuffView:_clearBuffCell(cell)
	local mainGo = cell.gameObject
	local iconGo = goutil.findChild(mainGo, "iconGo")

	uGuiUtil.clearImage(iconGo)
	GameUtil.rmClickHandler(mainGo)
end

return HolyLightBuffView
