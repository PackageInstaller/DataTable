-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/step/Va3ChessStepBulletUpdate.lua

module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepBulletUpdate", package.seeall)

local Va3ChessStepBulletUpdate = class("Va3ChessStepBulletUpdate", Va3ChessStepBase)

function Va3ChessStepBulletUpdate:start()
	self._bulletPoolDict = {}
	self._launcherId2BulletTweenDict = {}
	self._tweenCompleteCount = 0

	if self.originData and self.originData.arrowSteps then
		self._totalTweenCount = #self.originData.arrowSteps or 0
	end

	if self._totalTweenCount > 0 then
		if self._arrowAssetItem and self._arrowAssetItem.IsLoadSuccess then
			self:beginBulletListTween(self._arrowAssetItem, self.originData.arrowSteps, Va3ChessEnum.Bullet.Arrow)
		else
			loadAbAsset(Va3ChessEnum.Bullet.Arrow.path, false, self.onLoadArrowComplete, self)
		end
	else
		self:finish()
	end
end

function Va3ChessStepBulletUpdate:onLoadArrowComplete(assetItem)
	if self._arrowAssetItem then
		self._arrowAssetItem:Release()
	end

	self._arrowAssetItem = assetItem

	if assetItem then
		assetItem:Retain()
	end

	self:beginBulletListTween(self._arrowAssetItem, self.originData.arrowSteps, Va3ChessEnum.Bullet.Arrow)
end

function Va3ChessStepBulletUpdate:getBulletItem(assetItem, bulletSetting, parentGO, pos)
	if not bulletSetting or gohelper.isNil(parentGO) then
		return
	end

	local bulletItem
	local pool = self._bulletPoolDict[bulletSetting.path]

	if not pool then
		pool = {}
		self._bulletPoolDict[bulletSetting.path] = pool
	end

	local poolLen = #pool

	if poolLen > 0 then
		bulletItem = pool[poolLen]
		pool[poolLen] = nil
	end

	if not bulletItem and assetItem and assetItem.IsLoadSuccess then
		local bulletGO = gohelper.clone(assetItem:GetResource(bulletSetting.path), parentGO)

		if not gohelper.isNil(bulletGO) then
			bulletItem = {
				go = bulletGO,
				dir2GO = {}
			}

			for _, tmpDir in pairs(Va3ChessEnum.Direction) do
				bulletItem.dir2GO[tmpDir] = gohelper.findChild(bulletItem.go, string.format("dir_%s", tmpDir))
			end

			self:_setBulletDirGOActive(bulletItem)

			bulletItem.hitEffect = gohelper.findChild(bulletGO, "vx_jian_hit")

			gohelper.setActive(bulletItem.hitEffect, false)
		end
	end

	if bulletItem and not gohelper.isNil(bulletItem.go) then
		local bulletTrans = bulletItem.go.transform

		if pos and pos.x and pos.y and pos.z then
			transformhelper.setLocalPos(bulletTrans, pos.x, pos.y, pos.z)
		end

		bulletTrans:SetParent(parentGO.transform, true)
	else
		bulletItem = nil

		logError("Va3ChessStepBulletUpdate.getBulletItem error, get bullet item fail")
	end

	return bulletItem
end

function Va3ChessStepBulletUpdate:_setBulletDirGOActive(bulletItem, dir)
	if not bulletItem or not bulletItem.dir2GO then
		return
	end

	for goDir, dirGO in pairs(bulletItem.dir2GO) do
		gohelper.setActive(dirGO, goDir == dir)
	end
end

function Va3ChessStepBulletUpdate:recycleBulletItem(bulletItem, resPath)
	if not bulletItem or gohelper.isNil(bulletItem.go) then
		return
	end

	gohelper.setActive(bulletItem.go, false)

	local pool = self._bulletPoolDict[resPath]

	if not pool then
		pool = {}
		self._bulletPoolDict[resPath] = pool
	end

	table.insert(pool, bulletItem)
end

function Va3ChessStepBulletUpdate:disposeBulletItem(bulletItem)
	if not bulletItem then
		return
	end

	if bulletItem.dir2GO then
		for _, dirGO in pairs(bulletItem.dir2GO) do
			dirGO = nil
		end

		bulletItem.dir2GO = nil
	end

	if not gohelper.isNil(bulletItem.go) then
		gohelper.destroy(bulletItem.go)

		bulletItem.go = nil
	end
end

function Va3ChessStepBulletUpdate:beginBulletListTween(assetItem, stepDataList, bulletSetting)
	if not assetItem or not assetItem.IsLoadSuccess or not stepDataList or not bulletSetting then
		self:finish()

		return
	end

	for _, stepData in ipairs(stepDataList) do
		local pos = {}
		local parentGO
		local launcherInteractObj = Va3ChessGameController.instance.interacts:get(stepData.launcherId)

		if launcherInteractObj then
			local launcherSceneGO = launcherInteractObj:tryGetSceneGO()

			if not gohelper.isNil(launcherSceneGO) then
				local launcherSceneTrans = launcherSceneGO.transform

				pos.x, pos.y, pos.z = transformhelper.getLocalPos(launcherSceneTrans)
				parentGO = launcherSceneTrans.parent and launcherSceneTrans.parent.gameObject or nil
			end
		end

		local bulletItem = self:getBulletItem(assetItem, bulletSetting, parentGO, pos)

		if bulletItem and not gohelper.isNil(bulletItem.go) then
			self:playSingleBulletTween(bulletItem, stepData, bulletSetting)
		else
			self._totalTweenCount = self._totalTweenCount - 1
		end
	end

	if self._totalTweenCount <= 0 then
		self:finish()
	end
end

function Va3ChessStepBulletUpdate:playSingleBulletTween(bulletItem, stepData, bulletSetting)
	local startX = stepData.x1
	local startY = stepData.y1
	local w, h = Va3ChessGameModel.instance:getGameSize()
	local endX = Mathf.Clamp(stepData.x2, 0, w - 1)
	local endY = Mathf.Clamp(stepData.y2, 0, h - 1)
	local dir = Va3ChessMapUtils.ToDirection(startX, startY, endX, endY)

	self:_setBulletDirGOActive(bulletItem, dir)

	local launcherId = stepData.launcherId
	local flyTime = Va3ChessMapUtils.calBulletFlyTime(bulletSetting.speed, startX, startY, endX, endY)
	local sceneX, sceneY, sceneZ = Va3ChessGameController.instance:calcTilePosInScene(endX, endY)
	local tweenMoveId = ZProj.TweenHelper.DOLocalMove(bulletItem.go.transform, sceneX, sceneY, sceneZ, flyTime, function()
		self:onSingleTweenComplete(stepData, bulletSetting)
	end, nil, nil, EaseType.Linear)

	AudioMgr.instance:trigger(AudioEnum.chess_activity142.Arrow)

	self._launcherId2BulletTweenDict[launcherId] = {
		tweenId = tweenMoveId,
		bulletItem = bulletItem
	}
end

function Va3ChessStepBulletUpdate:onSingleTweenComplete(stepData, bulletSetting)
	local bulletItem
	local launcherId = stepData.launcherId
	local tweenBulletData = self._launcherId2BulletTweenDict[launcherId]

	if tweenBulletData then
		tweenBulletData.tweenId = nil
		bulletItem = tweenBulletData.bulletItem
		tweenBulletData.bulletItem = nil
	end

	self._launcherId2BulletTweenDict[launcherId] = nil

	local targetId = stepData.targetId

	if targetId and targetId > 0 then
		local interactMgr = Va3ChessGameController.instance.interacts
		local interactObj = interactMgr and interactMgr:get(targetId) or nil

		if interactObj and interactObj.effect and interactObj.effect.showEffect then
			interactObj.effect:showEffect(Va3ChessEnum.EffectType.ArrowHit)
		end
	end

	self:recycleBulletItem(bulletItem, bulletSetting.path)

	self._tweenCompleteCount = self._tweenCompleteCount + 1

	if self._tweenCompleteCount >= self._totalTweenCount and not next(self._launcherId2BulletTweenDict) then
		self:finish()
	end
end

function Va3ChessStepBulletUpdate:dispose()
	if self._arrowAssetItem then
		self._arrowAssetItem:Release()

		self._arrowAssetItem = nil
	end

	for k, tweenData in pairs(self._launcherId2BulletTweenDict) do
		ZProj.TweenHelper.KillById(tweenData.tweenId)

		tweenData.tweenId = nil

		self:disposeBulletItem(tweenData.bulletItem)

		tweenData.bulletItem = nil
		self._launcherId2BulletTweenDict[k] = nil
	end

	self._launcherId2BulletTweenDict = {}

	for k, pool in pairs(self._bulletPoolDict) do
		for i, bulletItem in ipairs(pool) do
			self:disposeBulletItem(bulletItem)

			pool[i] = nil
		end

		self._bulletPoolDict[k] = nil
	end

	self._bulletPoolDict = {}
	self._tweenCompleteCount = 0
	self._totalTweenCount = 0

	Va3ChessStepBulletUpdate.super.dispose(self)
end

return Va3ChessStepBulletUpdate
