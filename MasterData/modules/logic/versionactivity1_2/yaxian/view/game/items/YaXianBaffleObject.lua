-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/items/YaXianBaffleObject.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.items.YaXianBaffleObject", package.seeall)

local YaXianBaffleObject = class("YaXianBaffleObject", UserDataDispose)

function YaXianBaffleObject:ctor(baffleContainerTr)
	self:__onInit()

	self.baffleContainerTr = baffleContainerTr
end

function YaXianBaffleObject:init()
	self:createSceneNode()
end

function YaXianBaffleObject:createSceneNode()
	self.viewGO = UnityEngine.GameObject.New("baffle_item")
	self.transform = self.viewGO.transform

	self.transform:SetParent(self.baffleContainerTr, false)
end

function YaXianBaffleObject:getBaffleResPath()
	if self.baffleCo.direction == YaXianGameEnum.BaffleDirection.Left or self.baffleCo.direction == YaXianGameEnum.BaffleDirection.Right then
		return (self.baffleCo.type == 0 or nil) and (YaXianGameEnum.SceneResPath.LRBaffle0 or YaXianGameEnum.SceneResPath.LRBaffle1)
	else
		return (self.baffleCo.type == 0 or nil) and (YaXianGameEnum.SceneResPath.TBBaffle0 or YaXianGameEnum.SceneResPath.TBBaffle1)
	end
end

function YaXianBaffleObject:loadAvatar()
	if not gohelper.isNil(self.baffleGo) then
		gohelper.destroy(self.baffleGo)
	end

	self.loader = PrefabInstantiate.Create(self.viewGO)

	self.loader:startLoad(self:getBaffleResPath(), self.onSceneObjectLoadFinish, self)
end

function YaXianBaffleObject:onSceneObjectLoadFinish()
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

	transformhelper.setLocalScale(self.viewGO.transform, 0.8, 0.8, 0.8)
	gohelper.setLayer(self.viewGO, UnityLayer.Scene, true)
end

function YaXianBaffleObject:updatePos(baffleCo)
	self.baffleCo = baffleCo

	local x, y, z = YaXianGameHelper.calBafflePosInScene(self.baffleCo.x, self.baffleCo.y, self.baffleCo.direction)

	transformhelper.setLocalPos(self.transform, x, y, z)
	gohelper.setActive(self.viewGO, true)
	self:loadAvatar()
end

function YaXianBaffleObject:recycle()
	gohelper.setActive(self.viewGO, false)
end

function YaXianBaffleObject:dispose()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	gohelper.setActive(self.viewGO, true)
	gohelper.destroy(self.viewGO)
	self:__onDispose()
end

return YaXianBaffleObject
