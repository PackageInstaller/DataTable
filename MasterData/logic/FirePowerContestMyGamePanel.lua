-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/FirePowerContestMyGamePanel.lua

module("logic.extensions.firepowercontest.game.FirePowerContestMyGamePanel", package.seeall)

local FirePowerContestMyGamePanel = class("FirePowerContestMyGamePanel", FirePowerContestGamePanel)

function FirePowerContestMyGamePanel:ctor(mainGo, pool, view)
	FirePowerContestMyGamePanel.super.ctor(self, mainGo, pool, view, true)

	self._handler = FirePowerContestModel.instance.handler

	self:_initDrag()

	self._startDragTimeStamp = nil
	self._hasSendEnd = false
end

function FirePowerContestMyGamePanel:_initDrag()
	self._draging = false

	if FirePowerContestConfig.enableDragAim then
		self._pointerDownHandler = PointerDownHandler.Get(self._dragContainer):AddLuaHandler(function(go, data)
			self:_OnDragBegin(go, data)
		end)
	end

	self._pointerUpHandler = PointerUpHandler.Get(self._dragContainer):AddLuaHandler(function(go, data)
		self:_OnDragEnded(go, data)
	end)
end

function FirePowerContestMyGamePanel:_initRes()
	FirePowerContestMyGamePanel.super._initRes(self)

	self._aim = goutil.findChild(self._mainGo, "aim")
	self._line = goutil.findChild(self._aim, "line")
	self._dragContainer = goutil.findChild(self._mainGo, "dragContainer")

	goutil.setActive(self._aim, false)

	if FirePowerContestConfig.enableDragAim then
		self._aimEffectNode = self._pool:createFromPool(FirePowerContestPool.Effect, self._aim.transform)

		local url = FirePowerContestConfig.instance:getEffectUrl("fx_ui_hyll_miaozhun")
		local eff = UIEffectManager.instance:playEffect(self._view, url, self._aimEffectNode.transform, 0, 0, true)

		eff:setParent(self._aimEffectNode.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)

		self._aimEffect = eff
	end

	self._tips = goutil.findChild(self._mainGo, "tip")
end

function FirePowerContestMyGamePanel:reset()
	FirePowerContestMyGamePanel.super.reset(self)

	self._hasSendEnd = false
	self._sendEndStageTimestamp = nil

	goutil.setActive(self._tips, true)
end

function FirePowerContestMyGamePanel:lock()
	FirePowerContestMyGamePanel.super.lock(self)
	goutil.setActive(self._aim, false)

	self._draging = false
	self._startDragTimeStamp = nil
end

function FirePowerContestMyGamePanel:dispose()
	if FirePowerContestConfig.enableDragAim then
		PointerDownHandler.Get(self._dragContainer):RemoveLuaHandler(self._pointerDownHandler)
	end

	PointerUpHandler.Get(self._dragContainer):RemoveLuaHandler(self._pointerUpHandler)

	if self._aimEffect then
		UIEffectManager.instance:stopEffect(self._aimEffect)

		self._aimEffect = nil
	end

	if self._aimEffectNode then
		goutil.destroy(self._aimEffectNode)

		self._aimEffectNode = nil
	end

	FirePowerContestMyGamePanel.super.dispose(self)
end

function FirePowerContestMyGamePanel:_OnDragBegin(go, data)
	if self._data.isLeaving or not self._hasStart or self._launchLock or self._hasSendEnd then
		return
	end

	if #self._itemCells == 0 then
		return
	end

	self._draging = true
	self._startDragTimeStamp = UnityEngine.Time.realtimeSinceStartup
end

local otherHitTest = false

function FirePowerContestMyGamePanel:_OnDragEnded(go, data)
	if self._data.isLeaving or not self._hasStart or not self._draging then
		return
	end

	goutil.setActive(self._aim, false)

	self._draging = false
	self._startDragTimeStamp = nil

	if self._data.bulletCount <= 0 then
		FloatWordMgr.instance:show(lang("FirePowerContestMyGamePanel__1"))
	else
		local mousePos = UGUIToolHelper.GetTouchPosition()

		mousePos = goutil.screenToLocalPos(mousePos, self._itemContainerTransform)
		mousePos = Vector3.New(mousePos.x, mousePos.y, 0)

		local angle = math.deg(math.atan2(mousePos.y - self._launchPos.y, mousePos.x - self._launchPos.x))
		local bulletId = self._data:getMyBulletId()
		local launchTimes = UnityEngine.Time.realtimeSinceStartup * 1000 - self._data.startTimeClient

		if FirePowerContestConfig.debugClient and not otherHitTest then
			otherHitTest = true

			FirePowerContestController.instance:handleNofityLaunch(0, {
				angle = angle,
				bulletId = bulletId,
				lanuchTimes = launchTimes
			})

			return
		end

		self._handler:launch(angle, bulletId, launchTimes)
		self:launchBullet(angle, bulletId, launchTimes)
		goutil.setActive(self._tips, false)
	end
end

function FirePowerContestMyGamePanel:_checkAimPos()
	if self._draging and self._startDragTimeStamp ~= nil then
		local nowTime = UnityEngine.Time.realtimeSinceStartup

		if nowTime - self._startDragTimeStamp > 0.6 then
			goutil.setActive(self._aim, true)

			local mousePos = UGUIToolHelper.GetTouchPosition()

			mousePosT = goutil.screenToLocalPos(mousePos, self._itemContainerTransform)
			mousePosT = Vector3.New(mousePosT.x, mousePosT.y, 0)

			if not self._bounds:Contains(mousePosT) then
				self._draging = false

				goutil.setActive(self._aim, false)

				return
			end

			local distance = Vector3.Distance(mousePosT, self._launchPos)

			GameUtil.setHeight(self._line, distance)

			local angle = math.deg(math.atan2(mousePosT.y - self._launchPos.y, mousePosT.x - self._launchPos.x)) - 90

			mousePosT = goutil.screenToLocalPos(mousePos, self._mainGoTransform)

			GameUtil.setLocalPos(self._aim, mousePosT.x, mousePosT.y, 0)
			GameUtil.setLocalRotation(self._line, 0, 0, angle)
			GameUtil.setLocalRotation(self._imgIcon, 0, 0, angle)
		end
	end
end

function FirePowerContestMyGamePanel:tick()
	if self._hasStart and not self._launchLock then
		self:_checkAimPos()
		FirePowerContestMyGamePanel.super.tick(self)
	end
end

function FirePowerContestMyGamePanel:_checkEnd()
	if not self._bRoundDone then
		if #self._itemCells == 0 then
			if not self._launchLock then
				self._bRoundDone = true

				self:_flyPerfect(function()
					self:_showWaiting()
				end)
			end
		elseif self._data.bulletCount == 0 and #self._bulletCells == 0 then
			self._bRoundDone = true

			self:_showWaiting()
		end
	end

	self:_checkDelaySendEndStage()
end

function FirePowerContestMyGamePanel:_showWaiting()
	self:setPopMsg(lang("FirePowerContestMyGamePanel__2"))
	self:_checkSendEndStage()
end

function FirePowerContestMyGamePanel:_checkSendEndStage()
	if self._hasStart and not self._hasSendEnd then
		local isBulletEmpty = self._data.bulletCount == 0 and #self._bulletCells == 0
		local isItemEmpty = #self._itemCells == 0

		if isBulletEmpty or isItemEmpty then
			self._hasSendEnd = true

			self:_delaySendEndStage()
		end
	end
end

function FirePowerContestMyGamePanel:_delaySendEndStage()
	self._sendEndStageTimestamp = UnityEngine.Time.realtimeSinceStartup + 2
end

function FirePowerContestMyGamePanel:_checkDelaySendEndStage()
	if self._sendEndStageTimestamp ~= nil and UnityEngine.Time.realtimeSinceStartup >= self._sendEndStageTimestamp then
		self._sendEndStageTimestamp = nil

		if not FirePowerContestConfig.debugClient then
			FirePowerContestAgent.instance:sendPM_FPCAskNextStageReq(self._curStage)
		end
	end
end

function FirePowerContestMyGamePanel:handleOneHit(bulletId, posId, itemInfo, bulletInfo)
	itemInfo = itemInfo or self:_searchItemInfo(posId)
	bulletInfo = bulletInfo or self:_searchBulletInfo(bulletId)

	self._handler:hit(bulletId, posId)

	local comboScore = 0
	local itemScore = 0

	if bulletInfo then
		bulletInfo.hitCounter = (bulletInfo.hitCounter or 0) + 1
		comboScore = self:getComboScores(bulletInfo.hitCounter)
	else
		print("my bulletInfo is nil " .. tostring(bulletId))
	end

	if itemInfo then
		itemScore = itemInfo.score

		self:_flyItemScore(itemInfo.score, itemInfo)
		self:_flyComboScore(comboScore, itemInfo)
	else
		print("my itemInfo is nil " .. tostring(posId))
	end

	self._data:addMyScore(itemScore + comboScore)
	self:updateScoreCount(self._data.myScore)
end

return FirePowerContestMyGamePanel
