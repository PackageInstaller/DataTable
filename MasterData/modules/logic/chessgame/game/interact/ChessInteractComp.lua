-- chunkname: @modules/logic/chessgame/game/interact/ChessInteractComp.lua

module("modules.logic.chessgame.game.interact.ChessInteractComp", package.seeall)

local ChessInteractComp = class("ChessInteractComp")
local HandlerClzMap = {
	[ChessGameEnum.InteractType.Normal] = ChessInteractBase,
	[ChessGameEnum.InteractType.Role] = ChessInteractPlayer,
	[ChessGameEnum.InteractType.Teleport] = ChessInteractBase,
	[ChessGameEnum.InteractType.Hit] = ChessInteractBase,
	[ChessGameEnum.InteractType.Save] = ChessInteractBase,
	[ChessGameEnum.InteractType.Hunter] = ChessInteractHunter,
	[ChessGameEnum.InteractType.Prey] = ChessInteractBase,
	[ChessGameEnum.InteractType.Obstacle] = ChessInteractObstacle
}
local EffectClzMap = {
	[ChessGameEnum.GameEffectType.Display] = ChessEffectBase,
	[ChessGameEnum.GameEffectType.Talk] = ChessEffectBase
}
local ActEffectClzMap = {}

function ChessInteractComp:init(mapId, interactMO)
	self.mo = interactMO
	self.mapId = mapId

	local cfg = self.mo:getConfig()

	self.id = self.mo:getId()

	if cfg then
		self.objType = cfg.interactType
		self.config = cfg

		local interactType = cfg.interactType

		if not HandlerClzMap[interactType] then
			local handlerClz = ChessInteractComp

			self._handler = handlerClz.New()

			self._handler:init(self)
		end
	end

	local effectType = self.mo:getEffectType()

	if effectType and effectType ~= ChessGameEnum.GameEffectType.None then
		local actEffectClzMap = ActEffectClzMap[interactMO.actId]
		local actEffectClz = actEffectClzMap and actEffectClzMap[effectType]
		local effectClz = actEffectClz or EffectClzMap[effectType]

		self.chessEffectObj = effectClz.New(self)
	end

	self.avatar = nil
end

function ChessInteractComp:updateComp(interactMO)
	self.mo = interactMO

	local co = self.mo:getConfig()

	self:updatePos(co)

	if self.objType == ChessGameEnum.InteractType.Hunter then
		self:getHandler():refreshAlarmArea()
	end
end

function ChessInteractComp:setAvatar(avatarObj)
	self.avatar = avatarObj

	self:updateAvatarInScene()
end

function ChessInteractComp:checkShowAvatar()
	return self.avatar and self.avatar.isLoaded
end

function ChessInteractComp:setCurrpath(path)
	self._path = path
end

function ChessInteractComp:getCurrpath()
	return self._path
end

function ChessInteractComp:checkHaveAvatarPath()
	local co = self.mo:getConfig()
	local resPath = co.path

	if not string.nilorempty(resPath) then
		return true
	end

	return false
end

function ChessInteractComp:updateAvatarInScene()
	if not self.avatar or not self.avatar.sceneGo then
		return
	end

	local co = self.mo:getConfig()

	self:updatePos(co)

	if self.avatar.loader and co then
		local resPath = co.path

		self.avatar.name = SLFramework.FileHelper.GetFileName(resPath, false)

		if not string.nilorempty(resPath) then
			local currPath = self:getCurrpath()

			if currPath == resPath then
				return
			end

			local go = self.avatar.loader:getAssetItem(resPath)

			if not go then
				self.avatar.loader:startLoad(resPath, self.onSceneObjectLoadFinish, self)
				self:setCurrpath(resPath)
			end
		end
	end
end

function ChessInteractComp:updatePos(co)
	if not self.avatar or not self.avatar.sceneGo then
		return
	end

	if self.mo.posX and self.mo.posY and co then
		local offset = co.offset

		self.avatar.sceneX = self.mo.posX or co.x
		self.avatar.sceneY = self.mo.posY or co.x

		local position = {
			z = 0,
			x = self.mo.posX,
			y = self.mo.posY
		}
		local v3 = ChessGameHelper.nodePosToWorldPos(position)

		transformhelper.setLocalPos(self.avatar.sceneTf, v3.x + offset.x, v3.y + offset.y, v3.z + offset.z)

		if not self.mo.direction then
			self._handler:faceTo(self.mo.direction)
		end
	end
end

function ChessInteractComp:changeModule(newPath)
	local currPath = self:getCurrpath()

	if currPath == newPath then
		return
	end

	if not self._oldLoader then
		self._oldLoader = self.avatar.loader
	elseif self.avatar.loader then
		self.avatar.loader:dispose()

		self.avatar.loader = nil
	end

	self:loadModule(newPath)
end

function ChessInteractComp:loadModule(path)
	gohelper.destroyAllChildren(self.avatar.sceneGo)

	self.avatar.loader = PrefabInstantiate.Create(self.avatar.sceneGo)

	if not string.nilorempty(path) then
		local go = self.avatar.loader:getAssetItem(path)

		if not gohelper.isNil(go) then
			self.avatar.loader:startLoad(path, self.onSceneObjectLoadFinish, self)
			self:setCurrpath(path)
		end
	end
end

ChessInteractComp.DirectionList = {
	2,
	4,
	6,
	8
}
ChessInteractComp.DirectionSet = {}

for k, v in pairs(ChessInteractComp.DirectionList) do
	ChessInteractComp.DirectionSet[v] = true
end

function ChessInteractComp:onSceneObjectLoadFinish()
	if self.avatar and self.avatar.loader then
		local go = self.avatar.loader:getInstGO()

		if not gohelper.isNil(go) and not self.avatar.isLoaded then
			local canvasGo = gohelper.findChild(go, "Canvas")

			if canvasGo then
				local canvas = canvasGo:GetComponent(typeof(UnityEngine.Canvas))

				if canvas then
					canvas.worldCamera = CameraMgr.instance:getMainCamera()
				end
			end

			for _, dir in ipairs(ChessInteractComp.DirectionList) do
				self.avatar["goFaceTo" .. dir] = gohelper.findChild(go, "dir_" .. dir)
			end

			self.avatar.effectNode = gohelper.findChild(go, "icon")
		end

		self.avatar.isLoaded = true

		self:getHandler():onAvatarLoaded()
		ChessGameController.instance.interactsMgr:checkCompleletedLoaded(self.mo.id)
	end
end

function ChessInteractComp:tryGetGameObject()
	if self.avatar and self.avatar.loader then
		local go = self.avatar.loader:getInstGO()

		if not gohelper.isNil(go) then
			return go
		end
	end
end

function ChessInteractComp:tryGetSceneGO()
	if self.avatar and not gohelper.isNil(self.avatar.sceneGo) then
		return self.avatar.sceneGo
	end
end

function ChessInteractComp:hideSelf()
	if self.avatar and not gohelper.isNil(self.avatar.sceneGo) then
		gohelper.setActive(self.avatar.sceneGo, false)
	end
end

function ChessInteractComp:isShow()
	if not self.mo then
		return false
	else
		return self.mo:isShow()
	end
end

function ChessInteractComp:getAvatarName()
	local actId = self.mo.actId
	local objId = self.mo.id
	local co = ChessGameConfig.instance:getInteractObjectCo(actId, objId)

	if co then
		return co.avatar
	end
end

function ChessInteractComp:getObjId()
	return self.id
end

function ChessInteractComp:getObjType()
	return self.objType
end

function ChessInteractComp:getObjPosIndex()
	return self.mo:getPosIndex()
end

function ChessInteractComp:getHandler()
	return self._handler
end

function ChessInteractComp:onCancelSelect()
	if self:getHandler() then
		self:getHandler():onCancelSelect()
	end

	if self.chessEffectObj then
		self.chessEffectObj:onCancelSelect()
	end
end

function ChessInteractComp:onSelected()
	if self:getHandler() then
		self:getHandler():onSelected()
	end

	if self.chessEffectObj then
		self.chessEffectObj:onSelected()
	end
end

function ChessInteractComp:canSelect()
	return self.config and self.config.interactType == ChessGameEnum.InteractType.Player or self.config.interactType == ChessGameEnum.InteractType.AssistPlayer
end

function ChessInteractComp:dispose()
	if self.avatar ~= nil then
		if self.avatar.loader then
			self.avatar.loader:dispose()

			self.avatar.loader = nil
		end

		if not gohelper.isNil(self.avatar.sceneGo) then
			gohelper.setActive(self.avatar.sceneGo, false)
			gohelper.destroy(self.avatar.sceneGo)
		end

		ChessGameController.instance:dispatchEvent(ChessGameEvent.DeleteInteractAvatar, self.id)

		self.avatar = nil
	end

	local disposeCompName = {
		"_handler",
		"chessEffectObj"
	}

	for i, name in ipairs(disposeCompName) do
		if self[name] ~= nil then
			self[name]:dispose()

			self[name] = nil
		end
	end
end

function ChessInteractComp:showStateView(objState, params)
	if self:getHandler().showStateView then
		return self:getHandler():showStateView(objState, params)
	end
end

return ChessInteractComp
