-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaBulletEntity.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaBulletEntity", package.seeall)

local SpLilyaBulletEntity = class("SpLilyaBulletEntity", LuaCompBase)

function SpLilyaBulletEntity:init(go)
	self.go = go
	self.imageBullet = gohelper.findChild(go, "#image_bullet")
	self.goDamage = gohelper.findChild(go, "#go_damage")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SpLilyaBulletEntity:addEventListeners()
	return
end

function SpLilyaBulletEntity:removeEventListeners()
	return
end

function SpLilyaBulletEntity:_editableInitView()
	self._canvasGroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)

	self:hide()
end

function SpLilyaBulletEntity:hide()
	self._canvasGroup.alpha = 0
	self._isExploded = false

	gohelper.setActive(self.imageBullet, false)
end

function SpLilyaBulletEntity:setPos(x, y)
	transformhelper.setLocalPos(self.go.transform, x, y, 0)
end

function SpLilyaBulletEntity:setRotation(rotationZ)
	transformhelper.setLocalRotation(self.imageBullet.transform, 0, 0, rotationZ or 0)
end

function SpLilyaBulletEntity:setRadius(radius)
	radius = radius or 0

	local visualDiameter = radius * 2 * SpLilyaEnum.BulletVisualScale

	recthelper.setSize(self.imageBullet.transform, visualDiameter, visualDiameter)
end

function SpLilyaBulletEntity:setExplodeRadius(explodeRadius)
	explodeRadius = explodeRadius or 0

	recthelper.setSize(self.goDamage.transform, explodeRadius * 2, explodeRadius * 2)
end

function SpLilyaBulletEntity:setExplodeState(value)
	self._isExploded = value == true

	gohelper.setActive(self.imageBullet, not self._isExploded)
	gohelper.setActive(self.goDamage, self._isExploded)
end

function SpLilyaBulletEntity:show()
	self._canvasGroup.alpha = 1

	if not self._isExploded then
		gohelper.setActive(self.imageBullet, true)
	end
end

function SpLilyaBulletEntity:onDestroy()
	return
end

return SpLilyaBulletEntity
