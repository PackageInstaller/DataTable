-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/items/YaXianInteractObject.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.items.YaXianInteractObject", package.seeall)

local YaXianInteractObject = class("YaXianInteractObject", UserDataDispose)
local HandlerClsMap = {
	[YaXianGameEnum.InteractType.Player] = YaXianInteractPlayerHandle,
	[YaXianGameEnum.InteractType.TriggerFail] = YaXianInteractTriggerFailHandle
}
local StatusClsMap = {
	[YaXianGameEnum.InteractType.Player] = YaXianInteractPlayerStatus,
	[YaXianGameEnum.InteractType.Enemy] = YaXianInteractEnemyStatus
}

function YaXianInteractObject:ctor(interactContainerTr)
	self:__onInit()

	self.delete = false
	self.interactContainerTr = interactContainerTr
end

function YaXianInteractObject:init(interactMo)
	self.id = interactMo.id
	self.interactMo = interactMo

	local cfg = YaXianConfig.instance:getInteractObjectCo(self.interactMo.actId, self.id)

	if cfg then
		self.config = cfg

		if not HandlerClsMap[cfg.interactType] then
			self.handler = HandlerClsMap[cfg.interactType].New()

			self.handler:init(self)
		end
	else
		logError("can't find interact_object : " .. tostring(interactMo.actId) .. ", " .. tostring(interactMo.id))
	end

	self:createSceneNode()
end

function YaXianInteractObject:createSceneNode()
	self.interactItemContainerGo = UnityEngine.GameObject.New("interact_item")
	self.interactItemContainerTr = self.interactItemContainerGo.transform

	self.interactItemContainerTr:SetParent(self.interactContainerTr, false)
end

function YaXianInteractObject:loadAvatar()
	if self.loader then
		return
	end

	local resPath = self:getAvatarPath()

	if self:isExitInteract() then
		self.loader = MultiAbLoader.New()

		self.loader:addPath(YaXianGameEnum.SceneResPath.ExitDefaultPath)

		if not string.nilorempty(resPath) then
			self.loader:addPath(resPath)
		end

		self.loader:startLoad(self.onSceneObjectMultiLoadFinish, self)

		return
	end

	self.loader = PrefabInstantiate.Create(self.interactItemContainerGo)

	if not string.nilorempty(resPath) then
		self.loader:startLoad(resPath, self.onSceneObjectLoadFinish, self)
	end
end

function YaXianInteractObject:onSceneObjectLoadFinish()
	self.interactGo = self.loader:getInstGO()

	self:initInteractGo()
	self:getHandler():onAvatarLoaded()
	gohelper.setLayer(self.interactItemContainerGo, UnityLayer.Scene, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractLoadDone, self.id)
end

function YaXianInteractObject:onSceneObjectMultiLoadFinish()
	local defaultExitPrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.ExitDefaultPath):GetResource()

	self.defaultExitInteractGo = gohelper.clone(defaultExitPrefab, self.interactItemContainerGo, "default")
	self.goEnd = gohelper.findChild(self.defaultExitInteractGo, "#go_end")
	self.goTxtEnd = gohelper.findChild(self.defaultExitInteractGo, "#go_end/#go_txtend")
	self.transformEnd = self.goEnd and self.goEnd.transform

	local resPath = self:getAvatarPath()

	if not string.nilorempty(resPath) then
		local exitPrefab = self.loader:getAssetItem(resPath):GetResource()

		self.interactGo = gohelper.clone(exitPrefab, self.interactItemContainerGo)

		self:initInteractGo()
	end

	self:getHandler():onAvatarLoaded()
	gohelper.setLayer(self.interactItemContainerGo, UnityLayer.Scene, true)
	YaXianGameController.instance:dispatchEvent(YaXianEvent.OnInteractLoadDone, self.id)
end

function YaXianInteractObject:initInteractGo()
	self.interactGo.name = self.id
	self.interactAnimator = ZProj.ProjAnimatorPlayer.Get(self.interactGo)

	self:stopAnimation()
	self:initDirectionNode()

	self.iconGoContainer = gohelper.findChild(self.interactGo, "icon")
	self.effectGoContainer = gohelper.findChild(self.interactGo, "skill")

	local statusCls = StatusClsMap[self.config.interactType]

	if statusCls then
		self.status = statusCls.New()

		self.status:init(self)
	end

	self.effectMgr = YaXianInteractEffect.New()

	self.effectMgr:init(self)

	self.goTop = gohelper.findChild(self.interactGo, "tou")

	if not gohelper.isNil(self.goTop) then
		self.transformTop = self.goTop.transform or nil
	end
end

function YaXianInteractObject:updateInteractPos()
	if self.delete then
		return
	end

	local sceneX, sceneY, sceneZ = YaXianGameHelper.calcTilePosInScene(self.interactMo.posX, self.interactMo.posY)

	transformhelper.setLocalPos(self.interactItemContainerTr, sceneX, sceneY, sceneZ)
end

function YaXianInteractObject:updateInteractMo(interactMo)
	self.interactMo = interactMo

	self:updateInteractDirection()
	self:updateInteractPos()
end

function YaXianInteractObject:getShowPriority()
	return YaXianGameEnum.InteractShowPriority[self.config.interactType] or YaXianGameEnum.MinShowPriority
end

function YaXianInteractObject:updateActiveByShowPriority(maxPriority)
	gohelper.setActive(self.interactGo, maxPriority <= self:getShowPriority())

	if self:isExitInteract() then
		if maxPriority > self:getShowPriority() then
			gohelper.setActive(self.goEnd, false)

			return
		end

		gohelper.setActive(self.goEnd, true)
		gohelper.setActive(self.goTxtEnd, not self.interactGo)

		if self.interactGo then
			if not gohelper.isNil(self.transformEnd) then
				transformhelper.setLocalPosXY(self.transformEnd, 0, (self.transformTop or nil) and (self.transformTop.localPosition.y or 0.5))
			else
				logError("transformEnd is nil, interact name : " .. tostring((self.config or nil) and (self.config.name or "nil")))
			end
		elseif not gohelper.isNil(self.transformEnd) then
			transformhelper.setLocalPosXY(self.transformEnd, 0, 0)
		else
			logError("transformEnd is nil, interact name : " .. tostring((self.config or nil) and (self.config.name or "nil")))
		end
	end
end

function YaXianInteractObject:updateInteractDirection()
	self:getHandler():faceTo(self.interactMo.direction)
end

function YaXianInteractObject:setActive(active)
	gohelper.setActive(self.interactItemContainerGo, active)
end

function YaXianInteractObject:deleteSelf()
	self.delete = true

	gohelper.setActive(self.interactItemContainerGo, false)
end

function YaXianInteractObject:renewSelf()
	self.delete = false

	gohelper.setActive(self.interactItemContainerGo, true)
	self:_stopAnimation()
end

function YaXianInteractObject:isDelete()
	return self.delete
end

function YaXianInteractObject:getAvatarPath()
	if self.config and not string.nilorempty(self.config.avatar) then
		return "scenes/" .. self.config.avatar
	end

	return nil
end

function YaXianInteractObject:initDirectionNode()
	self.directionAvatarDict = self:getUserDataTb_()
	self.directionAvatarDict[YaXianGameEnum.MoveDirection.Bottom] = gohelper.findChild(self.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Bottom)
	self.directionAvatarDict[YaXianGameEnum.MoveDirection.Left] = gohelper.findChild(self.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Left)
	self.directionAvatarDict[YaXianGameEnum.MoveDirection.Right] = gohelper.findChild(self.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Right)
	self.directionAvatarDict[YaXianGameEnum.MoveDirection.Top] = gohelper.findChild(self.interactGo, "cha4_" .. YaXianGameEnum.MoveDirection.Top)
end

function YaXianInteractObject:getHandler()
	return self.handler
end

function YaXianInteractObject:getSelectPriority()
	local p

	return (self.config or nil) and YaXianGameEnum.InteractSelectPriority[self.config.interactType] or self.id
end

function YaXianInteractObject:isFighting()
	if self.config.alertType ~= YaXianGameEnum.AlertType.FourWay then
		return false
	end

	return self.interactMo.alertPosList and next(self.interactMo.alertPosList)
end

function YaXianInteractObject:isEnemy()
	return self.config.interactType == YaXianGameEnum.InteractType.Enemy or self.config.interactType == YaXianGameEnum.InteractType.TriggerFail
end

function YaXianInteractObject:getEffectMgr()
	return self.effectMgr
end

function YaXianInteractObject:showEffect(type, doneCallback, doneCallbackObj)
	if self.effectMgr then
		self.effectMgr:showEffect(type, doneCallback, doneCallbackObj)
	end
end

function YaXianInteractObject:cancelEffectTask()
	if self.effectMgr then
		self.effectMgr:cancelTask()
	end
end

function YaXianInteractObject:isExitInteract()
	return self.config.interactType == YaXianGameEnum.InteractType.TriggerVictory
end

function YaXianInteractObject:isPlayer()
	return self.config.interactType == YaXianGameEnum.InteractType.Player
end

function YaXianInteractObject:playAnimation(aniName)
	if self.interactAnimator then
		self.currentPlayAnimationName = aniName

		self.interactAnimator:Play(aniName)
	end
end

function YaXianInteractObject:stopAnimation()
	if string.nilorempty(self.currentPlayAnimationName) then
		local closeName = YaXianGameEnum.CloseAnimationName[self.currentPlayAnimationName]

		if closeName then
			self.interactAnimator:Play(closeName, self._stopAnimation, self)

			return
		end
	end

	self:_stopAnimation()
end

function YaXianInteractObject:_stopAnimation()
	if self.interactAnimator then
		self.interactAnimator:Play("idle")
	end
end

function YaXianInteractObject:dispose()
	gohelper.setActive(self.iconGoContainer, true)
	gohelper.setActive(self.interactItemContainerGo, true)
	gohelper.destroy(self.iconGoContainer)
	gohelper.destroy(self.interactItemContainerGo)

	if self.handler ~= nil then
		self.handler:dispose()
	end

	if self.loader then
		self.loader:dispose()
	end

	if self.status then
		self.status:dispose()
	end

	if self.effectMgr then
		self.effectMgr:dispose()
	end

	self:__onDispose()
end

return YaXianInteractObject
