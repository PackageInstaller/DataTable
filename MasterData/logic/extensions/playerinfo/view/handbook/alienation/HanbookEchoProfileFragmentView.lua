-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HanbookEchoProfileFragmentView.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HanbookEchoProfileFragmentView", package.seeall)

local M = class("HanbookEchoProfileFragmentView", StaticFragmentView)

function M:ctor(mainGO, registry)
	M.super.ctor(self, mainGO)

	self._registry = registry
end

function M:buildUI()
	local mainGo = self._registry:getMainGo()

	self._scroll = self._registry:getUIComponent("handbook_alienation_carry_view_387448135", UIComponentType.ScrollRect)
	self._imgEchoIcon = self._registry:getImage("handbook_alienation_carry_view_1009003273")
	self._txtInfo1 = self._registry:getText("handbook_alienation_carry_view_-1521561818")
	self._txtReport = self._registry:getText("handbook_alienation_carry_view_-168489808")
	self._txtDescDown = self._registry:getText("handbook_alienation_carry_view_-1968559705")
end

function M:destroyUI()
	self._scroll = nil
	self._imgEchoIcon = nil
	self._txtInfo1 = nil
	self._txtReport = nil
	self._txtDescDown = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._scroll.verticalNormalizedPosition = 1
end

function M:onExit()
	return
end

function M:getMainGo()
	return self.mainGO
end

function M:setEchoItemData(echoItemId)
	self._echoItemId = echoItemId

	self:refreshView()

	self._scroll.verticalNormalizedPosition = 1
end

function M:refreshView()
	if not self._echoItemId then
		return
	end

	local cfg = BackpackConfig.instance:getItemInfoByItemId(self._echoItemId)

	IconLoader.setSprite(self._imgEchoIcon, IconType.EchoItemIcon, cfg.icon)

	self._txtInfo1.text = cfg and cfg.useDesc or nil

	local reportStr = cfg and StringUtil.randomReplaceBlackBlock(cfg.report) or ""

	self._txtReport.text = TextUtils.GetPunctuationFixedText(reportStr, self._txtReport, 0, 2000)
	self._txtDescDown.text = cfg and cfg.desc or nil
end

function M:isVisible()
	return self:getMainGo().activeSelf
end

function M:setVisible(visible)
	goutil.setActive(self:getMainGo(), visible)
end

return M
