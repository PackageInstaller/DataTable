-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rolerelationship/view/RelationShipSuccessView.lua

module("logic.extensions.scenariocopy.view.rolerelationship.RelationShipSuccessView", package.seeall)

local RelationShipSuccessView = class("RelationShipSuccessView", ViewComponent)

function RelationShipSuccessView:ctor()
	RelationShipSuccessView.super.ctor(self)
end

function RelationShipSuccessView:unbindEvents()
	RelationShipSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function RelationShipSuccessView:bindEvents()
	RelationShipSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function RelationShipSuccessView:buildUI()
	RelationShipSuccessView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._bg = goutil.findChild(self.mainGO, "imgBg")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
end

function RelationShipSuccessView:onExit()
	RelationShipSuccessView.super.onExit(self)
end

function RelationShipSuccessView:onEnter()
	RelationShipSuccessView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._rsCfg = RoleRelationshipConfig.instance:getRsCfg(self._activityId)
	self._bgPath = self._rsCfg.sucBgPath
	self._titleStr = self._rsCfg.sucTitle

	local path = "ui/bigbg/" .. self._bgPath

	self:_loadBigBg(self._bg, path, true)

	self._txtTitle.text = self._titleStr
end

function RelationShipSuccessView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function RelationShipSuccessView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

return RelationShipSuccessView
