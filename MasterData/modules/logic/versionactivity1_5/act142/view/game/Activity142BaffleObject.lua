-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142BaffleObject.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142BaffleObject", package.seeall)

local Activity142BaffleObject = class("Activity142BaffleObject", UserDataDispose)

function Activity142BaffleObject:ctor(baffleContainerTr)
	self:__onInit()

	self.baffleContainerTr = baffleContainerTr
end

function Activity142BaffleObject:init()
	self:createSceneNode()
end

function Activity142BaffleObject:createSceneNode()
	self.viewGO = UnityEngine.GameObject.New("baffle_item")
	self.transform = self.viewGO.transform

	self.transform:SetParent(self.baffleContainerTr, false)
end

function Activity142BaffleObject:updatePos(baffleCo)
	self.baffleCo = baffleCo

	local x, y, z = Activity142Helper.calBafflePosInScene(self.baffleCo.x, self.baffleCo.y, self.baffleCo.direction)

	transformhelper.setLocalPos(self.transform, x, y, z)
	gohelper.setActive(self.viewGO, true)
	self:loadAvatar()
end

function Activity142BaffleObject:loadAvatar()
	if not gohelper.isNil(self.baffleGo) then
		gohelper.destroy(self.baffleGo)
	end

	self.loader = PrefabInstantiate.Create(self.viewGO)

	local path = self:getBaffleResPath()

	self.loader:startLoad(path, self.onSceneObjectLoadFinish, self)
end

function Activity142BaffleObject:getBaffleResPath()
	return Activity142Helper.getBaffleResPath(self.baffleCo)
end

function Activity142BaffleObject:onSceneObjectLoadFinish()
	self.baffleGo = self.loader:getInstGO()

	if not gohelper.isNil(self.baffleGo) then
		local canvasGo = gohelper.findChild(self.baffleGo, "Canvas")

		if canvasGo then
			local canvas = canvasGo:GetComponent(typeof(UnityEngine.Canvas))

			if canvas then
				canvas.worldCamera = CameraMgr.instance:getMainCamera()
			end
		end
	end

	gohelper.setLayer(self.viewGO, UnityLayer.Scene, true)
end

function Activity142BaffleObject:recycle()
	gohelper.setActive(self.viewGO, false)
end

function Activity142BaffleObject:dispose()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	gohelper.setActive(self.viewGO, true)
	gohelper.destroy(self.viewGO)
	self:__onDispose()
end

return Activity142BaffleObject
