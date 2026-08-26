-- chunkname: @modules/logic/activity/controller/chessmap/ActivityChessInteractObject.lua

module("modules.logic.activity.controller.chessmap.ActivityChessInteractObject", package.seeall)

local ActivityChessInteractObject = class("ActivityChessInteractObject")
local HandlerClzMap = {
	[ActivityChessEnum.InteractType.Player] = ActivityChessInteractPlayer,
	[ActivityChessEnum.InteractType.TriggerFail] = ActivityChessInteractTriggerFail
}

function ActivityChessInteractObject:init(interactData)
	self.originData = interactData
	self.id = interactData.id

	local cfg = Activity109Config.instance:getInteractObjectCo(self.originData.actId, self.id)

	if cfg then
		self.objType = cfg.interactType
		self.config = cfg

		if not HandlerClzMap[cfg.interactType] then
			self._handler = HandlerClzMap[cfg.interactType].New()

			self._handler:init(self)
		end
	else
		logError("can't find interact_object : " .. tostring(interactData.actId) .. ", " .. tostring(interactData.id))
	end

	self.goToObject = ActivityChessGotoObject.New(self)
	self.effect = ActivityChessInteractEffect.New(self)
	self.avatar = nil
end

function ActivityChessInteractObject:setAvatar(avatarObj)
	self.avatar = avatarObj

	self:updateAvatarInScene()
end

function ActivityChessInteractObject:updateAvatarInScene()
	if not self.avatar or not self.avatar.sceneGo then
		return
	end

	if self.originData.posX and self.originData.posY then
		local sceneX, sceneY, sceneZ = ActivityChessGameController.instance:calcTilePosInScene(self.originData.posX, self.originData.posY, self.avatar.order)

		self.avatar.sceneX = sceneX
		self.avatar.sceneY = sceneY

		transformhelper.setLocalPos(self.avatar.sceneTf, sceneX, sceneY, sceneZ)
	end

	local scale = 0.6

	transformhelper.setLocalScale(self.avatar.sceneTf, scale, scale, scale)

	if self.avatar.loader then
		local resPath = self:getAvatarPath()

		if not string.nilorempty(resPath) then
			self.avatar.loader:startLoad(string.format("scenes/m_s12_dfw/prefab/picpe/%s.prefab", resPath), self.onSceneObjectLoadFinish, self)
		end
	end
end

ActivityChessInteractObject.DirectionList = {
	2,
	4,
	6,
	8
}
ActivityChessInteractObject.DirectionSet = {}

for k, v in pairs(ActivityChessInteractObject.DirectionList) do
	ActivityChessInteractObject.DirectionSet[v] = true
end

function ActivityChessInteractObject:onSceneObjectLoadFinish()
	if self.avatar and self.avatar.loader then
		local go = self.avatar.loader:getInstGO()

		if not gohelper.isNil(go) then
			local canvasGo = gohelper.findChild(go, "Canvas")

			if canvasGo then
				local canvas = canvasGo:GetComponent(typeof(UnityEngine.Canvas))

				if canvas then
					canvas.worldCamera = CameraMgr.instance:getMainCamera()
				end
			end

			for _, dir in ipairs(ActivityChessInteractObject.DirectionList) do
				self.avatar["goFaceTo" .. dir] = gohelper.findChild(go, "piecea/char_" .. dir)
			end
		end

		self.avatar.isLoaded = true

		self:getHandler():onAvatarLoaded()
		self.goToObject:onAvatarLoaded()
		self.effect:onAvatarLoaded()
	end
end

function ActivityChessInteractObject:tryGetGameObject()
	if self.avatar and self.avatar.loader then
		local go = self.avatar.loader:getInstGO()

		if not gohelper.isNil(go) then
			return go
		end
	end
end

function ActivityChessInteractObject:getAvatarPath()
	local actId = self.originData.actId
	local objId = self.originData.id
	local co = Activity109Config.instance:getInteractObjectCo(actId, objId)

	if co then
		return co.avatar
	end
end

function ActivityChessInteractObject:canSelect()
	return self.config and self.config.interactType == ActivityChessEnum.InteractType.Player
end

function ActivityChessInteractObject:getHandler()
	return self._handler
end

function ActivityChessInteractObject:canBlock()
	return self.config and (self.config.interactType == ActivityChessEnum.InteractType.Obstacle or self.config.interactType == ActivityChessEnum.InteractType.TriggerFail or self.config.interactType == ActivityChessEnum.InteractType.Player)
end

function ActivityChessInteractObject:getSelectPriority()
	local p

	return (self.config or nil) and ActivityChessEnum.InteractSelectPriority[self.config.interactType] or self.id
end

function ActivityChessInteractObject:dispose()
	if self.avatar ~= nil then
		if self.avatar.loader then
			self.avatar.loader:dispose()

			self.avatar.loader = nil
		end

		if not gohelper.isNil(self.avatar.sceneGo) then
			gohelper.setActive(self.avatar.sceneGo, true)
			gohelper.destroy(self.avatar.sceneGo)
		end

		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.DeleteInteractAvatar, self.avatar)

		self.avatar = nil
	end

	local disposeCompName = {
		"_handler",
		"goToObject",
		"effect"
	}

	for i, name in ipairs(disposeCompName) do
		if self[name] ~= nil then
			self[name]:dispose()

			self[name] = nil
		end
	end
end

return ActivityChessInteractObject
