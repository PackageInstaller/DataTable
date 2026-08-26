-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameWallItem.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameWallItem", package.seeall)

local AssassinStealthGameWallItem = class("AssassinStealthGameWallItem", LuaCompBase)

function AssassinStealthGameWallItem:init(go)
	self.go = go

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameWallItem:_editableInitView()
	self._goimg = gohelper.findChild(self.go, "#go_img")

	self:_checkShow()
end

function AssassinStealthGameWallItem:addEventListeners()
	return
end

function AssassinStealthGameWallItem:removeEventListeners()
	return
end

function AssassinStealthGameWallItem:initData(wallId, isHor)
	self.id = wallId
	self.go.name = self.id
	self.isHor = isHor
end

function AssassinStealthGameWallItem:setMap(mapId)
	self.mapId = mapId

	self:_checkShow()
end

function AssassinStealthGameWallItem:_checkShow()
	local isShow = AssassinConfig.instance:isShowWall(self.mapId, self.id)

	if self._isShow == isShow then
		return
	end

	self._isShow = isShow

	gohelper.setActive(self._goimg, self._isShow)
end

function AssassinStealthGameWallItem:onDestroy()
	return
end

return AssassinStealthGameWallItem
