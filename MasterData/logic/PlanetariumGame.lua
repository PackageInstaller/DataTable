-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/PlanetariumGame.lua

module("logic.extensions.planetarium.view.PlanetariumGame", package.seeall)

local PlanetariumGame = class("PlanetariumGame", ViewComponent)

function PlanetariumGame:ctor()
	return
end

function PlanetariumGame:unbindEvents()
	PlanetariumGame.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChange)
	GameUtil.rmClickHandler(self._btnRotate)
end

function PlanetariumGame:bindEvents()
	PlanetariumGame.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnChange, self._onClickChange, self)
	GameUtil.addClickHandler(self._btnRotate, self._onClickRotate, self)
end

function PlanetariumGame:buildUI()
	PlanetariumGame.super.buildUI(self)

	self._btnChange = self:getBtn("game/btnChange")
	self._btnRotate = self:getBtn("game/btnRotate")

	local mapParent = self:getGo("game/starMap")

	self._starMap = {}
	self._mapCount = 3

	for i = 1, self._mapCount do
		local starRing = {}

		starRing.go = self:getGo("game/starMap/ring_" .. i)
		starRing.select = self:getGo("game/starMap/ring_" .. i .. "/select")

		table.insert(self._starMap, starRing)
		GameUtil.SetActive(starRing.select, false)
	end
end

function PlanetariumGame:onExit()
	PlanetariumGame.super.onExit(self)

	for i = 1, self._mapCount do
		uGuiUtil.clearImage(self._starMap[i].go)
	end

	self:_clearAllTween()
end

function PlanetariumGame:onEnter()
	PlanetariumGame.super.onEnter(self)
	self:_initData()

	self._isGameStart = false
	self._isSuccess = false
	self._isRotating = false
	self._tweenRotate = {}

	self:_initStarRingAngle()
	self.addGEvent(self, GlobalNotify.PlanetariumGameInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.PlanetariumGameEndGameRes, self._endRefresh, self)
	self:_sendGetInfoReq()
end

function PlanetariumGame:_initData()
	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.Planetarium)
	self._stageId = 1
end

function PlanetariumGame:_startGame()
	if self._isGameStart then
		return
	end

	self._isGameStart = true
	self._clientKey = math.random(ServerTime.now())

	self:_sendGameStartReq()
end

function PlanetariumGame:_initStarRingAngle()
	for id = 1, self._mapCount do
		self:_initRingAngle(id, 0)
	end
end

function PlanetariumGame:_initStarRingUI()
	for id = 1, self._mapCount do
		self:_setStarRingUI(id)
	end
end

function PlanetariumGame:_refresh()
	self:_refreshGameResult()
end

function PlanetariumGame:_refreshStarMap()
	self._curSelectId = 1
	self._recordRingPos = {}

	for id = 1, self._mapCount do
		GameUtil.SetActive(self._starMap[id].select, false)

		local data = self:_getGameRingCfgById(self._stageId, id)

		self:_setStarRingUI(id)
		self:_rotateRing(id, data.startAngle, false)
	end

	GameUtil.SetActive(self._starMap[self._curSelectId].select, true)

	local curSelectData = self:_getGameRingCfgById(self._stageId, self._curSelectId)

	if curSelectData.linkage > 0 then
		GameUtil.SetActive(self._starMap[curSelectData.linkage].select, true)
	end
end

function PlanetariumGame:_setStarRingUI(id)
	local data = self:_getGameRingCfgById(self._stageId, id)

	uGuiUtil.setSpriteToImage(self._starMap[id].go, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("planetarium", data.bgName))
end

function PlanetariumGame:_onClickChange()
	if self._isSuccess then
		FloatWordMgr.instance:show("今日星图已复原，明日再来~")

		return
	end

	if self._isRotating then
		return
	end

	GameUtil.SetActive(self._starMap[self._curSelectId].select, false)

	for i, v in pairs(self._starMap) do
		GameUtil.SetActive(v.select, false)
	end

	self._curSelectId = (self._curSelectId + 1) % self._mapCount

	if self._curSelectId <= 0 then
		self._curSelectId = 3
	end

	GameUtil.SetActive(self._starMap[self._curSelectId].select, true)

	local curSelectData = self:_getGameRingCfgById(self._stageId, self._curSelectId)

	if curSelectData.linkage > 0 then
		GameUtil.SetActive(self._starMap[curSelectData.linkage].select, true)
	end
end

function PlanetariumGame:_onClickRotate()
	if self._isSuccess then
		FloatWordMgr.instance:show("今日星图已复原，明日再来~")

		return
	end

	if self._isRotating then
		return
	end

	local curSelectData = self:_getGameRingCfgById(self._stageId, self._curSelectId)

	self:_rotateRing(self._curSelectId, curSelectData.rotateAngle, true, true)

	if curSelectData.linkage > 0 then
		local data = self:_getGameRingCfgById(self._stageId, curSelectData.linkage)

		self:_rotateRing(curSelectData.linkage, data.rotateAngle, true, false)
	end
end

function PlanetariumGame:_rotateRing(id, angle, isPlayAnim, isDoOnComplete)
	local RotateX, RotateY, RotateZ = GameUtil.getLocalRotation(self._starMap[id].go)
	local newRotate = Mathf.Round(RotateZ) + angle

	self:_setRingAngle(id, newRotate, isPlayAnim, isDoOnComplete)
end

function PlanetariumGame:_initRingAngle(id, angle)
	GameUtil.setLocalRotation(self._starMap[id].go, 0, 0, angle)

	self._starMap[id].angle = angle
end

function PlanetariumGame:_setRingAngle(id, angle, isPlayAnim, isDoOnComplete)
	self._starMap[id].angle = angle

	if not isPlayAnim then
		GameUtil.setLocalRotation(self._starMap[id].go, 0, 0, angle)
		printInfo("test PlanetariumGame:_setRingAngle1", id, angle, isPlayAnim, isDoOnComplete)
	else
		local duration = 0.2

		self:_clearTween(id)

		self._isRotating = true

		printInfo("test PlanetariumGame:_setRingAngle2", id, angle, isPlayAnim, isDoOnComplete)

		self._tweenRotate[id] = self._starMap[id].go.transform:DORotate(Vector3.New(0, 0, angle), duration, DG.Tweening.RotateMode.FastBeyond360):OnComplete(function()
			self._isRotating = false

			printInfo("test 判断前", isDoOnComplete)

			if isDoOnComplete and self:_checkSuccess() then
				printInfo("test 判断后", isDoOnComplete)

				self._isSuccess = true

				self:_successEvent()
			end
		end)
	end
end

function PlanetariumGame:_checkSuccess()
	printInfo("test PlanetariumGame:_checkSuccess1")

	for i, data in ipairs(self._starMap) do
		local num = data.angle % 360

		printInfo("test PlanetariumGame:_checkSuccess2", i, num, num ~= 0)

		if num ~= 0 then
			return false
		end
	end

	printInfo("test PlanetariumGame:_checkSuccess3")

	return true
end

function PlanetariumGame:_successEvent()
	self:_endGame()
	self:_passGameUI()
end

function PlanetariumGame:_endGame()
	if not self._isGameStart then
		return
	end

	self:_sendGameEndReq()
end

function PlanetariumGame:_passGameUI()
	self._isGameStart = false
end

function PlanetariumGame:_endRefresh()
	self:_sendGetInfoReq()
end

function PlanetariumGame:_clearTween(id)
	if self._tweenRotate[id] then
		self._tweenRotate[id]:Kill()

		self._tweenRotate[id] = nil
	end
end

function PlanetariumGame:_clearAllTween()
	if self._tweenRotate then
		for k, v in pairs(self._tweenRotate) do
			v:Kill()
		end

		table.clear(self._tweenRotate)
	end
end

function PlanetariumGame:_sendGameStartReq()
	PlanetariumController.instance:sendPM_PlanetariumGameStartGameReq(self._activityId, self._clientKey)
end

function PlanetariumGame:_sendGameEndReq()
	local severKey = PlanetariumModel.instance:getServerKey()
	local scoreNum = self._isSuccess and 1 or 0
	local encryptedKey = GameUtil.getClientEncryptedKey(self._clientKey, severKey, {
		scoreNum
	})

	PlanetariumController.instance:sendPM_PlanetariumGameEndGameReq(self._activityId, self._isSuccess, encryptedKey)
end

function PlanetariumGame:_sendGetInfoReq()
	PlanetariumController.instance:sendPM_PlanetariumGameInfoReq(self._activityId)
end

function PlanetariumGame:_refreshGameResult()
	self._isSuccess = PlanetariumModel.instance:getDailyFinish()
end

function PlanetariumGame:_getGameRingCfgById(stageId, value)
	return PlanetariumConfig.instance:getGameRingCfgById(stageId, value)
end

return PlanetariumGame
