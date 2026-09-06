-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/res/GameResObject.lua

module("logiccommon.common.res.GameResObject", package.seeall)

local GameResObject = class("GameResObject", GameRes)

function GameResObject:ctor()
	GameResObject.super.ctor(self)

	self.go = nil
	self.posX = nil
	self.posY = nil
	self.posZ = nil
	self.posLX = nil
	self.posLY = nil
	self.posLZ = nil
	self.scaleX = nil
	self.scaleY = nil
	self.scaleZ = nil
	self.parent = nil
	self.sortingOrder = nil
	self.loadedHandler = nil
	self.loadedHandlerTarget = nil
	self.autoDestroy = true
	self._visible = true
	self.active = true
	self.isPause = nil
	self.rotationX = nil
	self.rotationY = nil
	self.rotationZ = nil
end

function GameResObject:setParent(parent)
	self.parent = parent

	if self.go and self.go.transform.parent ~= parent then
		self.go.transform:SetParent(parent)
	end
end

function GameResObject:setSortingOrder(sortingLayer)
	if sortingLayer ~= self.sortingOrder then
		self.sortingOrder = sortingLayer

		if self.go then
			GoUtil.SetSortingOrder(self.go, self.sortingOrder)
		end
	end
end

function GameResObject:setVisible(visible)
	self._visible = visible or false

	if self.go then
		GoUtil.SetVisible(self.go, visible)
	end
end

function GameResObject:setActive(active)
	self.active = active

	if self.go and self.go.activeSelf ~= active then
		self.go:SetActive(active)
	end
end

function GameResObject:pause()
	if self.isPause then
		return
	end

	self.isPause = true

	if self.go then
		GoUtil.PauseObject(self.go)
	end
end

function GameResObject:resume()
	if not self.isPause then
		return
	end

	self.isPause = nil

	if self.go then
		GoUtil.ResumeObject(self.go)
	end
end

function GameResObject:setScale(scaleX, scaleY, scaleZ)
	self.scaleX = scaleX or 1
	self.scaleY = scaleY or self.scaleX
	self.scaleZ = scaleZ or self.scaleX

	if self.go then
		Framework.TransformUtil.SetLocalScale(self.go.transform, self.scaleX, self.scaleY, self.scaleZ)
	end
end

function GameResObject:setRotation(rx, ry, rz)
	self.rotationX = rx or 0
	self.rotationY = ry or 0
	self.rotationZ = rz or 0

	if self.go then
		Framework.TransformUtil.SetLocalRotation(self.go.transform, self.rotationX, self.rotationY, self.rotationZ)
	end
end

function GameResObject:setPos(x, y, z)
	self.posX = x
	self.posY = y
	self.posZ = z

	if self.go then
		Framework.TransformUtil.SetPos(self.go.transform, self.posX or 0, self.posY or 0, self.posZ or 0)
	end
end

function GameResObject:setLocalPos(x, y, z)
	self.posLX = x
	self.posLY = y
	self.posLZ = z

	if self.go then
		Framework.TransformUtil.SetLocalPos(self.go.transform, self.posLX or 0, self.posLY or 0, self.posLZ or 0)
	end
end

function GameResObject:setLayer(layer)
	self.layer = layer

	if self.layer and self.go and self.go.layer ~= layer then
		Framework.GameObjectUtil.SetLayerRecursively(self.go, self.layer)
	end
end

function GameResObject:onGameObjectEnd()
	self:onDisable()
end

function GameResObject:onGameObjectStart()
	self:onEnable()
end

function GameResObject:onEnable()
	GameResObject.super.onEnable(self)

	if self.parent then
		self:setParent(self.parent)
	end

	if not self.posX and not self.posY then
		if self.posZ then
			Framework.TransformUtil.SetPos(self.go.transform, self.posX or 0, self.posY or 0, self.posZ or 0)
		end

		if not self.posLX and not self.posLY then
			if self.posLZ then
				Framework.TransformUtil.SetLocalPos(self.go.transform, self.posLX or 0, self.posLY or 0, self.posLZ or 0)
			end

			if not self._visible then
				self:setVisible(self._visible)
			end

			if self.layer then
				Framework.GameObjectUtil.SetLayerRecursively(self.go, self.layer)
			end

			if self.scaleX and self.scaleY and self.scaleZ then
				self:setScale(self.scaleX, self.scaleY, self.scaleZ)
			end

			if self.rotationX and self.rotationY and self.rotationZ then
				self:setRotation(self.rotationX, self.rotationY, self.rotationZ)
			end

			if self.isPause then
				GoUtil.PauseObject(self.go)
			end

			if self.sortingOrder then
				GoUtil.SetSortingOrder(self.go, self.sortingOrder)
			end
		end
	end

	self:setActive(self.active)
end

function GameResObject:onDisable()
	GameResObject.super.onDisable(self)

	self.posX = nil
	self.posY = nil
	self.posZ = nil
	self.posLX = nil
	self.posLY = nil
	self.posLZ = nil
	self.scaleX = 1
	self.scaleY = 1
	self.scaleZ = 1
	self.rotationX = 0
	self.rotationY = 0
	self.rotationZ = 0
	self.parent = nil
	self.active = true
	self.sortingOrder = nil
	self.layer = nil

	if not self._visible then
		self:setVisible(true)
	end

	self._visible = true

	if self.isPause and self.go then
		GoUtil.ResumeObject(self.go)

		self.isPause = nil
	end

	self.go = nil
end

return GameResObject
