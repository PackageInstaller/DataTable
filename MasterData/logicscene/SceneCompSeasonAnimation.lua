-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/season/SceneCompSeasonAnimation.lua

module("logicscene.scene.component.season.SceneCompSeasonAnimation", package.seeall)

local SceneCompSeasonAnimation = class("SceneCompSeasonAnimation", SceneComponentBase)

SceneCompSeasonAnimation.fogDisappearAnimTime = 0.5

function SceneCompSeasonAnimation:onEnterScene(sceneId, bornX, bornZ)
	SceneCompSeasonAnimation.super.onEnterScene(self, sceneId, bornX, bornZ)

	self._grid2gridPlayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._camera2gridPlayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._bossEnterShowPlayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._bossDoppelgangerPlayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._doppelganger2BossPlayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._unlockTranspointslayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._launchFirePlayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._s2BossShowPlayer = SeasonSceneAnimatiorPlayer.New(self._scene)
	self._s2BossDefenseBreak = SeasonSceneAnimatiorPlayer.New(self._scene)
	AMTargetPosition.spineDirectionWithFlipX = false
end

function SceneCompSeasonAnimation:onEnterSceneFinished(sceneId, bornX, bornZ)
	return
end

function SceneCompSeasonAnimation:onExitScene()
	AMTargetPosition.spineDirectionWithFlipX = true

	if self._grid2gridPlayer then
		self._grid2gridPlayer:clear()

		self._grid2gridPlayer = nil
	end

	if self._unlockTranspointslayer then
		self._unlockTranspointslayer:clear()

		self._unlockTranspointslayer = nil
	end

	if self._camera2gridPlayer then
		self._camera2gridPlayer:clear()

		self._camera2gridPlayer = nil
	end

	if self._bossEnterShowPlayer then
		self._bossEnterShowPlayer:clear()

		self._bossEnterShowPlayer = nil
	end

	if self._bossDoppelgangerPlayer then
		self._bossDoppelgangerPlayer:clear()

		self._bossDoppelgangerPlayer = nil
	end

	if self._doppelganger2BossPlayer then
		self._doppelganger2BossPlayer:clear()

		self._doppelganger2BossPlayer = nil
	end

	if self._launchFirePlayer then
		self._launchFirePlayer:clear()

		self._launchFirePlayer = nil
	end

	if self._s2BossShowPlayer then
		self._s2BossShowPlayer:clear()

		self._s2BossShowPlayer = nil
	end

	if self._s2BossDefenseBreak then
		self._s2BossDefenseBreak:clear()

		self._s2BossDefenseBreak = nil
	end

	self:_destroyTempObject()
end

function SceneCompSeasonAnimation:isPlaying()
	if self._grid2gridPlayer and self._grid2gridPlayer:isPlayingAnim() then
		return true
	end

	if self._camera2gridPlayer and self._camera2gridPlayer:isPlayingAnim() then
		return true
	end

	if self._bossEnterShowPlayer and self._bossEnterShowPlayer:isPlayingAnim() then
		return true
	end

	if self._bossDoppelgangerPlayer and self._bossDoppelgangerPlayer:isPlayingAnim() then
		return true
	end

	if self._doppelganger2BossPlayer and self._doppelganger2BossPlayer:isPlayingAnim() then
		return true
	end

	if self._unlockTranspointslayer and self._unlockTranspointslayer:isPlayingAnim() then
		return true
	end

	if self._launchFirePlayer and self._launchFirePlayer:isPlayingAnim() then
		return true
	end

	if self._s2BossShowPlayer and self._s2BossShowPlayer:isPlayingAnim() then
		return true
	end

	if self._s2BossDefenseBreak and self._s2BossDefenseBreak:isPlayingAnim() then
		return true
	end
end

function SceneCompSeasonAnimation:transmitGrid2Grid(teamId, startGridRow, startGridCol, destGridRow, destGridCol, callback)
	if not self._grid2gridPlayer then
		return
	end

	self._grid2gridPlayer:stop()

	local transUnit = self._scene.leaders:getTeamUnit(teamId)
	local startGridUnit = self._scene.gridUnitsMgr:getGridUnit(startGridRow, startGridCol)
	local destGridUnit = self._scene.gridUnitsMgr:getGridUnit(destGridRow, destGridCol)
	local mainCam = GlobalModel.instance.mainCamera.gameObject
	local posx, posy = destGridUnit.transform:getPos()

	local function do_playAnim()
		transUnit.actions:stopAllActions()

		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local targets = {
			transUnit.go,
			startGridUnit.go,
			destGridUnit.go,
			mainCam
		}

		self._grid2gridPlayer:playWithTargets("storyconfig/animations/season/season_transmit_grid2grid.txt", targets, function()
			self._scene.camera:enablFollowTarget(isFollowEnable)

			local startGridEvent = self._scene.eventsData:getEventUnit(startGridUnit.row, startGridUnit.col)
			local destGridEvent = self._scene.eventsData:getEventUnit(destGridUnit.row, destGridUnit.col)

			if startGridEvent then
				startGridEvent.gridEvent:updateEvent()
			end

			if destGridEvent then
				destGridEvent.gridEvent:updateEvent()
			end

			if callback then
				callback()
			end
		end)
	end

	self._grid2gridPlayer:preloadResources(posx, posy, nil, do_playAnim)
end

function SceneCompSeasonAnimation:playRainbowAnim(teamId, startGridRow, startGridCol, destGridRow, destGridCol, callback)
	local transUnit = self._scene.leaders:getTeamUnit(teamId)
	local startGridUnit = self._scene.gridUnitsMgr:getGridUnit(startGridRow, startGridCol)
	local destGridUnit = self._scene.gridUnitsMgr:getGridUnit(destGridRow, destGridCol)
	local posStartX, posStartY = startGridUnit.transform:getPos()
	local posDestX, posDestY = destGridUnit.transform:getPos()

	local function stopFunc()
		transUnit.transform:setPos(posDestX, posDestY)
	end

	SceneCompSeasonAnimation.rainbowCircleRadius = SceneCompSeasonAnimation.rainbowCircleRadius or 4.4

	local action = transUnit:runArcPath(posStartX, posStartY, posDestX, posDestY, SceneCompSeasonAnimation.rainbowCircleRadius, callback)

	action.onStoped = stopFunc
end

function SceneCompSeasonAnimation:playCamera2Pos(x, y, callback)
	if not self._camera2gridPlayer then
		return
	end

	self._camera2gridPlayer:stop()
	self:_createTempObject()

	local mainCam = GlobalModel.instance.mainCamera.gameObject

	Framework.TransformUtil.SetPos(self._tempGameObj.transform, x, y, 0)

	local function do_playAnim()
		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local targets = {
			mainCam,
			self._tempGameObj
		}

		self._camera2gridPlayer:playWithTargets("storyconfig/animations/season/season_camera2grid.txt", targets, function()
			self._scene.camera:enablFollowTarget(isFollowEnable)

			if callback then
				callback()
			end
		end)
	end

	self._camera2gridPlayer:preloadResources(x, y, nil, do_playAnim)
end

function SceneCompSeasonAnimation:playLaunchFire(startGridRow, startGridCol, destGridRow, destGridCol, callback)
	if not self._launchFirePlayer then
		return
	end

	self._launchFirePlayer:stop()

	local startGridUnit = self._scene.gridUnitsMgr:getGridUnit(startGridRow, startGridCol)
	local destGridUnit = self._scene.gridUnitsMgr:getGridUnit(destGridRow, destGridCol)
	local posx, posy = destGridUnit.transform:getPos()

	local function do_playAnim()
		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local fogElem = self._scene.fogsMgr:getFogElementByRowAndCol(destGridRow, destGridCol)
		local targets = {
			startGridUnit.go,
			destGridUnit.go
		}

		self._grid2gridPlayer:playWithTargets("storyconfig/animations/season/season_launch_fire.txt", targets, function()
			self:_playUnlockFog({
				fogElem
			})
			self._scene.camera:enablFollowTarget(isFollowEnable)

			if callback then
				callback()
			end
		end)
	end

	self._launchFirePlayer:preloadResources(posx, posy, nil, do_playAnim)
end

function SceneCompSeasonAnimation:playCamera2Grid(destRow, destCol, callback, callbacktarget)
	if not self._camera2gridPlayer then
		return
	end

	self._camera2gridPlayer:stop()

	local gridUnit = self._scene.gridUnitsMgr:getGridUnit(destRow, destCol)
	local mainCam = GlobalModel.instance.mainCamera.gameObject
	local posx, posy = gridUnit.transform:getPos()

	local function do_playAnim()
		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local targets = {
			mainCam,
			gridUnit.go
		}

		self._camera2gridPlayer:playWithTargets("storyconfig/animations/season/season_camera2grid.txt", targets, function()
			self._scene.camera:enablFollowTarget(isFollowEnable)

			if callback then
				callback(callbacktarget)
			end
		end)
	end

	self._camera2gridPlayer:preloadResources(posx, posy, nil, do_playAnim)
end

function SceneCompSeasonAnimation:playEnterBossShow()
	if not self._bossEnterShowPlayer then
		return
	end

	local teamId = SeasonTeamsModel.instance:getCurrTeamId()

	if not teamId or teamId == 0 then
		return
	end

	self._bossEnterShowPlayer:stop()

	local bossUnit = self._scene.gridUnitsMgr:getBoss()
	local posx, posy = bossUnit.transform:getPos()

	local function do_playAnim()
		local teamUnit = self._scene.leaders:getTeamUnit(teamId)

		if not teamUnit then
			self._bossEnterShowPlayer:stop()
			GlobalDispatcher:dispatch(GlobalNotify.SeasonFirstEnterBossShowAnimDone)

			return
		end

		local mainCam = GlobalModel.instance.mainCamera.gameObject
		local camX, camY, camZ = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)

		self:_createTempObject()
		Framework.TransformUtil.SetPos(self._tempGameObj.transform, camX, camY, camZ)

		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local seasonId = SeasonModel.instance:getSeasonId()
		local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(seasonId)

		if cfg and checknumber(cfg.storyId) > 0 then
			self._bossEnterShowPlayer:setReplaceStoryId(checknumber(cfg.storyId))
		end

		local targets = {
			self._tempGameObj,
			bossUnit.go,
			teamUnit.go
		}

		self._bossEnterShowPlayer:playWithTargets("storyconfig/animations/season/season_enter_boss_show.txt", targets, function()
			self._scene.camera:enablFollowTarget(isFollowEnable)
			GlobalDispatcher:dispatch(GlobalNotify.SeasonFirstEnterBossShowAnimDone)
		end)
	end

	local gridEvent = self._scene.eventsData:getEventUnit(bossUnit.row, bossUnit.col)

	self._bossEnterShowPlayer:preloadResources(posx, posy, gridEvent.gridEvent:getDependentResources(), do_playAnim)
end

function SceneCompSeasonAnimation:playBoss2Doppelganger(callback)
	if not self._bossDoppelgangerPlayer then
		return
	end

	local endStoryIdMap = {
		[1] = 4350006,
		[3] = 4550002
	}
	local seasonId = SeasonModel.instance:getSeasonId()

	if not endStoryIdMap[seasonId] then
		local repaceStoryId = 0

		self._bossDoppelgangerPlayer:stop()

		local bossUnit = self._scene.gridUnitsMgr:getBoss()
		local bossDoppelgangers = self._scene.gridUnitsMgr:getBossDoppelgangers()
		local gridBossEvent = self._scene.eventsData:getEventUnit(bossUnit.row, bossUnit.col)
		local posx, posy = bossUnit.transform:getPos()

		local function do_playAnim()
			local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

			self._scene.camera:enablFollowTarget(false)

			if repaceStoryId > 0 then
				self._bossEnterShowPlayer:setReplaceStoryId(checknumber(repaceStoryId))
			end

			local targets = {
				gridBossEvent.go
			}

			for i = 1, #bossDoppelgangers do
				local gridEvent = self._scene.eventsData:getEventUnit(bossDoppelgangers[i].row, bossDoppelgangers[i].col)

				table.insert(targets, gridEvent.go)
			end

			local mainCam = GlobalModel.instance.mainCamera.gameObject
			local camX, camY, camZ = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)

			self:_createTempObject()
			Framework.TransformUtil.SetPos(self._tempGameObj.transform, camX, camY, camZ)
			table.insert(targets, self._tempGameObj)
			self._bossDoppelgangerPlayer:setBossNode(gridBossEvent.go)
			self._bossDoppelgangerPlayer:playWithTargets("storyconfig/animations/season/season_boss_doppelganger.txt", targets, function()
				self._scene.camera:enablFollowTarget(isFollowEnable)
				self:playCamera2Pos(camX, camY, function()
					gridBossEvent.gridEvent:setPlayedDoppelgangerAppear()

					for i = 1, #bossDoppelgangers do
						local gridEvent = self._scene.eventsData:getEventUnit(bossDoppelgangers[i].row, bossDoppelgangers[i].col)

						gridEvent.gridEvent:setPlayedDoppelgangerAppear()
					end

					if callback then
						callback()
					end
				end)
			end)
		end

		local additionalRes
		local bossRes = gridBossEvent.gridEvent:getDependentResources()

		if bossRes then
			for i = 1, #bossRes do
				additionalRes = additionalRes or {}

				table.insert(additionalRes, bossRes[i])
			end
		end

		for i = 1, #bossDoppelgangers do
			local gridEvent = self._scene.eventsData:getEventUnit(bossDoppelgangers[i].row, bossDoppelgangers[i].col)
			local doppelgangersRes = gridEvent.gridEvent:getDependentResources()

			if doppelgangersRes then
				for i = 1, #doppelgangersRes do
					additionalRes = additionalRes or {}

					table.insert(additionalRes, doppelgangersRes[i])
				end
			end
		end

		self._bossDoppelgangerPlayer:preloadResources(posx, posy, additionalRes, do_playAnim)
	end
end

function SceneCompSeasonAnimation:playDoppelganger2Boss(callback)
	if not self._doppelganger2BossPlayer then
		return
	end

	self._doppelganger2BossPlayer:stop()

	local bossUnit = self._scene.gridUnitsMgr:getBoss()
	local bossDoppelgangers = self._scene.gridUnitsMgr:getBossDoppelgangers()
	local gridBossEvent = self._scene.eventsData:getEventUnit(bossUnit.row, bossUnit.col)
	local posx, posy = bossUnit.transform:getPos()

	local function do_playAnim()
		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local gridX, gridY = gridBossEvent.transform:getPos()
		local targets = {
			gridBossEvent.go
		}

		for i = 1, #bossDoppelgangers do
			local gridEvent = self._scene.eventsData:getEventUnit(bossDoppelgangers[i].row, bossDoppelgangers[i].col)

			table.insert(targets, gridEvent.go)
		end

		self:_createTempObject()

		local mainCam = GlobalModel.instance.mainCamera.gameObject
		local camX, camY, camZ = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)

		table.insert(targets, self._tempGameObj)
		Framework.TransformUtil.SetPos(self._tempGameObj.transform, camX, camY, camZ)
		self._bossDoppelgangerPlayer:setBossNode(gridBossEvent.go)
		self._doppelganger2BossPlayer:playWithTargets("storyconfig/animations/season/season_doppelganger_disappear.txt", targets, function()
			self._scene.camera:enablFollowTarget(isFollowEnable)
			gridBossEvent.transform:setPos(gridX, gridY)

			for i = 1, #bossDoppelgangers do
				local gridEvent = self._scene.eventsData:getEventUnit(bossDoppelgangers[i].row, bossDoppelgangers[i].col)

				gridEvent.gridEvent:setPlayedBossAppear()
			end

			gridBossEvent.gridEvent:setPlayedBossAppear()

			if callback then
				callback()
			end
		end)
	end

	local additionalRes
	local bossRes = gridBossEvent.gridEvent:getDependentResources()

	if bossRes then
		for i = 1, #bossRes do
			additionalRes = additionalRes or {}

			table.insert(additionalRes, bossRes[i])
		end
	end

	for i = 1, #bossDoppelgangers do
		local gridEvent = self._scene.eventsData:getEventUnit(bossDoppelgangers[i].row, bossDoppelgangers[i].col)
		local doppelgangersRes = gridEvent.gridEvent:getDependentResources()

		if doppelgangersRes then
			for i = 1, #doppelgangersRes do
				additionalRes = additionalRes or {}

				table.insert(additionalRes, doppelgangersRes[i])
			end
		end
	end

	self._doppelganger2BossPlayer:preloadResources(posx, posy, additionalRes, do_playAnim)
end

function SceneCompSeasonAnimation:playS2BossShowAnim(destRow, destCol, callback, callbacktarget)
	if not self._s2BossShowPlayer then
		return
	end

	local additionalRes

	self._s2BossShowPlayer:stop()

	local gridBossEvent = self._scene.eventsData:getEventUnit(destRow, destCol)

	gridBossEvent.gridEvent:setVisible(false)

	local gridX, gridY = gridBossEvent.transform:getPos()

	local function do_playAnim()
		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local targets = {
			gridBossEvent.go
		}

		self:_createTempObject()

		local mainCam = GlobalModel.instance.mainCamera.gameObject
		local camX, camY, camZ = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)

		table.insert(targets, self._tempGameObj)
		Framework.TransformUtil.SetPos(self._tempGameObj.transform, camX, camY, camZ)
		self._s2BossShowPlayer:setBossNode(gridBossEvent.go)
		self._s2BossShowPlayer:playWithTargets("storyconfig/animations/season/season_s2boss_appear.txt", targets, function()
			self._scene.camera:enablFollowTarget(isFollowEnable)
			gridBossEvent.transform:setPos(gridX, gridY)
			gridBossEvent.gridEvent:setPlayedBossAppear()

			if callback then
				callback(callbacktarget)
			end
		end)
	end

	local gridEvent = self._scene.eventsData:getEventUnit(destRow, destCol)
	local gridRes = gridEvent.gridEvent:getDependentResources()

	if gridRes then
		for i = 1, #gridRes do
			additionalRes = additionalRes or {}

			table.insert(additionalRes, gridRes[i])
		end
	end

	self._s2BossShowPlayer:preloadResources(gridX, gridY, additionalRes, do_playAnim)
end

function SceneCompSeasonAnimation:playS2BossDefenseBreakAnim(callback)
	if not self._s2BossDefenseBreak then
		return
	end

	local additionalRes

	self._s2BossDefenseBreak:stop()

	local bossUnit = self._scene.gridUnitsMgr:getBoss()
	local gridBossEvent = self._scene.eventsData:getEventUnit(bossUnit.row, bossUnit.col)

	local function do_playAnim()
		gridBossEvent.gridEvent:setPlayedBossAppear()

		if callback then
			callback()
		end
	end

	self._s2BossDefenseBreak:preloadResources(posx, posy, additionalRes, do_playAnim)
end

function SceneCompSeasonAnimation:playUnlockFogsAnim()
	local unlockFogGridId = SeasonController.instance:getRecentlyUnlockedFogsGrid()

	if unlockFogGridId == 0 then
		return
	end

	local seasonId = SeasonModel.instance:getSeasonId()
	local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, unlockFogGridId) or {}

	if evtConfig and evtConfig.eventType == SeasonGridEvtTypes.EVT_DANCE_LION then
		return
	end

	local gridElements = self._scene.fogsMgr:getFogRelateToElements(unlockFogGridId)

	if not gridElements then
		return
	end

	local isTrans = self._scene.fogsMgr:getUnlockTranspointGridId() == unlockFogGridId

	if isTrans then
		self:_playUnlockTransmit(gridElements)
	else
		self:_playUnlockFog(gridElements)
	end
end

function SceneCompSeasonAnimation:_playUnlockFog(gridElements)
	if not self._camera2gridPlayer then
		return
	end

	if not gridElements then
		return
	end

	local posx, posy = 0, 0

	for i = 1, #gridElements do
		local x, y = gridElements[i].transform:getPos()

		posx = posx + x
		posy = posy + y
	end

	posx = posx / #gridElements
	posy = posy / #gridElements

	local mainCam = GlobalModel.instance.mainCamera.gameObject
	local camX, camY, camZ = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)

	self:playCamera2Pos(posx, posy, function()
		for i = 1, #gridElements do
			gridElements[i]:disappear()
		end

		UnityTweens.TweenEmpty.StartTween(mainCam, SceneCompSeasonAnimation.fogDisappearAnimTime, function()
			SeasonController.instance:recordRecentlyUnlockedFogsGrid(0)
			self:playCamera2Pos(camX, camY)
		end)
	end)
end

function SceneCompSeasonAnimation:_playUnlockTransmit(gridElements)
	if not self._unlockTranspointslayer then
		return
	end

	self._unlockTranspointslayer:stop()

	local effUnit = self._scene.fogsMgr:getUnlockTranspointEff()

	if not effUnit then
		return
	end

	local unlockTrans = {}
	local seasonId = SeasonModel.instance:getSeasonId()

	for i = 1, #gridElements do
		local gridId = SeasonPathFindingDataModel.instance:grid2Id(gridElements[i].row, gridElements[i].col)
		local mapData = SeasonModel.instance:getMapInfoById(gridId)

		if mapData and not mapData:isLock() then
			local gridEvent = self._scene.eventsData:getEventUnit(gridElements[i].row, gridElements[i].col)

			gridEvent.gridEvent:setPrepareTranspointAnim(true)

			local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)
			local linkObjId = checknumber(evtCfg.linkObjIds)
			local row, col = self._scene:getCellRowAndColIndexByElementId(linkObjId)
			local linkObj = self._scene.eventsData:getEventUnit(row, col)

			linkObj.gridEvent:setPrepareTranspointAnim(true)
			table.insert(unlockTrans, {
				unlock = gridEvent,
				lock = linkObj
			})
		end
	end

	local function do_playAnim()
		local isFollowEnable = self._scene.camera:isFollowTargetEnabled()

		self._scene.camera:enablFollowTarget(false)

		local targets = {}

		self:_createTempObject()

		local mainCam = GlobalModel.instance.mainCamera.gameObject
		local camX, camY, camZ = Framework.TransformUtil.GetPos(mainCam.transform, nil, nil, nil)

		Framework.TransformUtil.SetPos(self._tempGameObj.transform, camX, camY, camZ)
		table.insert(targets, unlockTrans[2].unlock.go)
		table.insert(targets, unlockTrans[2].lock.go)
		table.insert(targets, unlockTrans[1].unlock.go)
		table.insert(targets, unlockTrans[1].lock.go)
		table.insert(targets, effUnit.go)
		table.insert(targets, self._tempGameObj)
		table.insert(targets, unlockTrans[3].lock.go)
		table.insert(targets, unlockTrans[3].unlock.go)

		local trnaspoints = {}

		table.insert(trnaspoints, unlockTrans[2].unlock)
		table.insert(trnaspoints, unlockTrans[2].lock)
		table.insert(trnaspoints, unlockTrans[1].unlock)
		table.insert(trnaspoints, unlockTrans[1].lock)
		table.insert(trnaspoints, unlockTrans[3].unlock)
		table.insert(trnaspoints, unlockTrans[3].lock)

		local fogs = {}

		for i = 1, #trnaspoints do
			table.insert(fogs, self._scene.fogsMgr:getFogElementByRowAndCol(trnaspoints[i].row, trnaspoints[i].col))
		end

		self._unlockTranspointslayer:setTranspoints(trnaspoints, fogs)
		self._unlockTranspointslayer:playWithTargets("storyconfig/animations/season/season_unlock_transpoints.txt", targets, function()
			SeasonController.instance:recordRecentlyUnlockedFogsGrid(0)
			self._scene.camera:enablFollowTarget(isFollowEnable)

			for i = 1, #trnaspoints do
				trnaspoints[i].gridEvent:setPrepareTranspointAnim(false)
			end

			self._scene.fogsMgr:destroyUnlockTranspointEff()
			FloatWordMgr.instance:show("传送阵已开启")
		end)
	end

	local additionalRes = {
		SceneCompSeasonFogsMgr.unlockTranspointsEffPath
	}

	for i = 1, #gridElements do
		local posx, posy = gridElements[i].transform:getPos()

		additionalRes = self._scene.stage:detectSceneResources(posx, posy, addtionalRes)
	end

	local posx, posy = effUnit.transform:getPos()

	self._unlockTranspointslayer:preloadResources(posx, posy, additionalRes, do_playAnim)
end

function SceneCompSeasonAnimation:_createTempObject()
	if not self._tempGameObj then
		self._tempGameObj = goutil.create("Season Anim Temp")

		self._tempGameObj:SetActive(false)
	end
end

function SceneCompSeasonAnimation:_destroyTempObject()
	if self._tempGameObj then
		goutil.destroy(self._tempGameObj)

		self._tempGameObj = nil
	end
end

return SceneCompSeasonAnimation
