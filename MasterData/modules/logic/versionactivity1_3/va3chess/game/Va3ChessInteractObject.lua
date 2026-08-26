-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/Va3ChessInteractObject.lua

module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessInteractObject", package.seeall)

local Va3ChessInteractObject = class("Va3ChessInteractObject")
local HandlerClzMap = {
	[Va3ChessEnum.InteractType.Player] = Va3ChessInteractPlayer,
	[Va3ChessEnum.InteractType.AssistPlayer] = Va3ChessInteractPlayer,
	[Va3ChessEnum.InteractType.TriggerFail] = Va3ChessInteractTriggerFail,
	[Va3ChessEnum.InteractType.PushedBlock] = Va3ChessInteractPushed,
	[Va3ChessEnum.InteractType.DestroyableItem] = Va3ChessInteractDestroyable,
	[Va3ChessEnum.InteractType.PushedOnceBlock] = Va3ChessInteractOncePushed,
	[Va3ChessEnum.InteractType.Trap] = Va3ChessInteractTrap,
	[Va3ChessEnum.InteractType.DeductHpEnemy] = Va3ChessInteractDeductHpEnemy,
	[Va3ChessEnum.InteractType.DestroyableTrap] = Va3ChessInteractDestroyableTrap,
	[Va3ChessEnum.InteractType.BoltLauncher] = Va3ChessInteractBoltLauncher,
	[Va3ChessEnum.InteractType.Pedal] = Va3ChessInteractPedal,
	[Va3ChessEnum.InteractType.Brazier] = Va3ChessInteractBrazier,
	[Va3ChessEnum.InteractType.StandbyTrackEnemy] = Va3ChessInteractStandbyTrackEnemy,
	[Va3ChessEnum.InteractType.SentryEnemy] = Va3ChessInteractSentryEnemy
}
local ActHandlerClzMap = {
	[Va3ChessEnum.ActivityId.Act142] = {
		[Va3ChessEnum.InteractType.Player] = Act142InteractPlayer,
		[Va3ChessEnum.InteractType.AssistPlayer] = Act142InteractPlayer
	}
}
local EffectClzMap = {
	[Va3ChessEnum.GameEffectType.Hero] = Va3ChessHeroEffect,
	[Va3ChessEnum.GameEffectType.Direction] = Va3ChessNextDirectionEffect,
	[Va3ChessEnum.GameEffectType.Sleep] = Va3ChessSleepMonsterEffect,
	[Va3ChessEnum.GameEffectType.Monster] = Va3ChessMonsterEffect,
	[Va3ChessEnum.GameEffectType.Display] = Va3ChessEffectBase
}
local ActEffectClzMap = {
	[Va3ChessEnum.ActivityId.Act142] = {
		[Va3ChessEnum.GameEffectType.Hero] = Va3ChessIconEffect,
		[Va3ChessEnum.GameEffectType.Monster] = Va3ChessIconEffect
	}
}

function Va3ChessInteractObject:init(interactData)
	self.originData = interactData
	self.id = interactData.id

	local cfg = Va3ChessConfig.instance:getInteractObjectCo(self.originData.actId, self.id)

	if cfg then
		self.objType = cfg.interactType
		self.config = cfg
		self.effectCfg = Va3ChessConfig.instance:getEffectCo(self.originData.actId, cfg.effectId)

		local interactType = cfg.interactType
		local actHandlerClzMap = ActHandlerClzMap[interactData.actId]
		local actHandlerClz = actHandlerClzMap and actHandlerClzMap[interactType]

		if not actHandlerClz then
			::label_1_0::

			local var_1_0 = HandlerClzMap[interactType]

			if not HandlerClzMap[interactType] then
				local handlerClz = Va3ChessInteractBase

				self._handler = handlerClz.New()

				self._handler:init(self)
			end
		end
	else
		logError("can't find interact_object : " .. tostring(interactData.actId) .. ", " .. tostring(interactData.id))
	end

	self.goToObject = Va3ChessGotoObject.New(self)
	self.effect = Va3ChessInteractEffect.New(self)

	if self.effectCfg then
		local effectType = self.effectCfg.effectType
		local actEffectClzMap = ActEffectClzMap[interactData.actId]
		local actEffectClz = actEffectClzMap and actEffectClzMap[effectType]
		local effectClz = actEffectClz or EffectClzMap[effectType]

		self.chessEffectObj = effectClz.New(self)
	end

	self.avatar = nil
end

function Va3ChessInteractObject:setIgnoreSight(value)
	self._ignoreSight = value
end

function Va3ChessInteractObject:GetIgnoreSight()
	return self._ignoreSight
end

function Va3ChessInteractObject:setAvatar(avatarObj)
	self.avatar = avatarObj

	self:updateAvatarInScene()
end

function Va3ChessInteractObject:updateAvatarInScene()
	if not self.avatar or not self.avatar.sceneGo then
		return
	end

	if self.originData.posX and self.originData.posY then
		local sceneX, sceneY, sceneZ = Va3ChessGameController.instance:calcTilePosInScene(self.originData.posX, self.originData.posY, self.avatar.order, true)

		self.avatar.sceneX = sceneX
		self.avatar.sceneY = sceneY

		transformhelper.setLocalPos(self.avatar.sceneTf, sceneX, sceneY, sceneZ)
	end

	if self.avatar.loader then
		local resPath = self:getAvatarPath()

		self.avatar.name = SLFramework.FileHelper.GetFileName(resPath, false)

		if not string.nilorempty(resPath) then
			self.avatar.loader:startLoad(string.format(Va3ChessEnum.SceneResPath.AvatarItemPath, resPath), self.onSceneObjectLoadFinish, self)
		end
	end
end

Va3ChessInteractObject.DirectionList = {
	2,
	4,
	6,
	8
}
Va3ChessInteractObject.DirectionSet = {}

for k, v in pairs(Va3ChessInteractObject.DirectionList) do
	Va3ChessInteractObject.DirectionSet[v] = true
end

function Va3ChessInteractObject:onSceneObjectLoadFinish()
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

			for _, dir in ipairs(Va3ChessInteractObject.DirectionList) do
				self.avatar["goFaceTo" .. dir] = gohelper.findChild(go, "dir_" .. dir)
			end
		end

		self.avatar.isLoaded = true

		self.effect:onAvatarLoaded()
		self.goToObject:onAvatarLoaded()

		if self.chessEffectObj then
			self.chessEffectObj:onAvatarFinish()
		end

		self:getHandler():onAvatarLoaded()
		self:showStateView(Va3ChessEnum.ObjState.Idle)
	end
end

function Va3ChessInteractObject:tryGetGameObject()
	if self.avatar and self.avatar.loader then
		local go = self.avatar.loader:getInstGO()

		if not gohelper.isNil(go) then
			return go
		end
	end
end

function Va3ChessInteractObject:tryGetSceneGO()
	if self.avatar and not gohelper.isNil(self.avatar.sceneGo) then
		return self.avatar.sceneGo
	end
end

function Va3ChessInteractObject:getAvatarPath()
	local actId = self.originData.actId
	local objId = self.originData.id
	local co = Va3ChessConfig.instance:getInteractObjectCo(actId, objId)

	if co then
		return co.avatar
	end
end

function Va3ChessInteractObject:getAvatarName()
	local actId = self.originData.actId
	local objId = self.originData.id
	local co = Va3ChessConfig.instance:getInteractObjectCo(actId, objId)

	if co then
		return co.avatar
	end
end

function Va3ChessInteractObject:getObjId()
	return self.id
end

function Va3ChessInteractObject:getObjType()
	return self.objType
end

function Va3ChessInteractObject:getObjPosIndex()
	return self.originData:getPosIndex()
end

function Va3ChessInteractObject:getHandler()
	return self._handler
end

function Va3ChessInteractObject:canBlock(fromDir, targetObjType)
	local blockDict = {
		[Va3ChessEnum.InteractType.Obstacle] = true,
		[Va3ChessEnum.InteractType.Player] = true,
		[Va3ChessEnum.InteractType.AssistPlayer] = true,
		[Va3ChessEnum.InteractType.BoltLauncher] = true,
		[Va3ChessEnum.InteractType.Brazier] = true,
		[Va3ChessEnum.InteractType.StandbyTrackEnemy] = true
	}

	if self.config then
		if not self.config.interactType then
			local interactType

			if blockDict[interactType] then
				return true
			end

			if self:getHandler().checkCanBlock then
				return self:getHandler():checkCanBlock(fromDir, targetObjType)
			end
		end
	end
end

function Va3ChessInteractObject:onCancelSelect()
	if self:getHandler() then
		self:getHandler():onCancelSelect()
	end

	if self.chessEffectObj then
		self.chessEffectObj:onCancelSelect()
	end
end

function Va3ChessInteractObject:onSelected()
	if self:getHandler() then
		self:getHandler():onSelected()
	end

	if self.chessEffectObj then
		self.chessEffectObj:onSelected()
	end
end

function Va3ChessInteractObject:canSelect()
	return self.config and self.config.interactType == Va3ChessEnum.InteractType.Player or self.config.interactType == Va3ChessEnum.InteractType.AssistPlayer
end

function Va3ChessInteractObject:getSelectPriority()
	local p

	return (self.config or nil) and Va3ChessEnum.InteractSelectPriority[self.config.interactType] or self.id
end

function Va3ChessInteractObject:dispose()
	if self.avatar ~= nil then
		if self.avatar.loader then
			self.avatar.loader:dispose()

			self.avatar.loader = nil
		end

		if not gohelper.isNil(self.avatar.sceneGo) then
			gohelper.setActive(self.avatar.sceneGo, true)
			gohelper.destroy(self.avatar.sceneGo)
		end

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.DeleteInteractAvatar, self.id)

		self.avatar = nil
	end

	local disposeCompName = {
		"_handler",
		"goToObject",
		"effect",
		"chessEffectObj"
	}

	for i, name in ipairs(disposeCompName) do
		if self[name] ~= nil then
			self[name]:dispose()

			self[name] = nil
		end
	end
end

function Va3ChessInteractObject:showStateView(objState, params)
	if self:getHandler().showStateView then
		return self:getHandler():showStateView(objState, params)
	end
end

return Va3ChessInteractObject
