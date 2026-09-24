-- chunkname: @modules/logic/versionactivity4_0/deleike/model/DeleikeGameMgr.lua

module("modules.logic.versionactivity4_0.deleike.model.DeleikeGameMgr", package.seeall)

local DeleikeGameMgr = class("DeleikeGameMgr")
local Vector2 = UnityEngine.Vector2

function DeleikeGameMgr:startGame(gameId)
	self.gameId = gameId
	self.gameCfg, self.mapCfg = DeleikeConfig.instance:getGameConfig(self.gameId)

	if not self.gameCfg or not self.mapCfg then
		return false
	end

	self.bgResPath = ResUrl.getDeleikeSingleBg(self.gameCfg.mapBg)
	self.skillMgr = DeleikeSkillMgr.New()
	self.unitCoord = DeleikeUnitCoord.New()
	self.inputLocked = false
	self._undoStack = {}

	return true
end

function DeleikeGameMgr:endGame()
	DeleikeController.instance:onGameFinish()
	DeleikeController.instance:closeGameView()
end

function DeleikeGameMgr:setInputLocked(locked)
	self.inputLocked = locked == true

	if self.inputLocked and self.skillMgr then
		self.skillMgr:resetState()
	end
end

function DeleikeGameMgr:initScene(sceneRoot)
	self.sceneRoot = sceneRoot
	self.sceneRootRt = sceneRoot.transform
	self.goBgTile = gohelper.findChild(sceneRoot, "BgRoot/go_BgTile")
	self.goGridTile = gohelper.findChild(sceneRoot, "GridRoot/go_GridTile")
	self.goAnchorTile = gohelper.findChild(sceneRoot, "TileRoot/go_AnchorTile")
	self.goNormalTile = gohelper.findChild(sceneRoot, "TileRoot/go_NormalTile")
	self.goSkillPoint = gohelper.findChild(sceneRoot, "TriggerRoot/go_SkillPoint")
	self.goDoor = gohelper.findChild(sceneRoot, "TriggerRoot/go_Door")
	self.goLineTile = gohelper.findChild(sceneRoot, "LineRoot/go_LineTile")
	self.goSkillLine1 = gohelper.findChild(sceneRoot, "go_SkillLine1")
	self.goSkillLine2 = gohelper.findChild(sceneRoot, "go_SkillLine2")
	self.goPlayer = gohelper.findChild(sceneRoot, "Player")

	self.skillMgr:init(self.goSkillLine1, self.goSkillLine2)
end

function DeleikeGameMgr:addPolygonTile(tileType, x, y, worldPos, rotation, polygon, customName, rect)
	if not polygon and (tileType == DeleikeEnum.TileType.Normal or tileType == DeleikeEnum.TileType.Anchor) then
		worldPos = Vector2(worldPos.x, worldPos.y + DeleikeEnum.NormalTileArtOffsetY)
	end

	local mo = DeleikeTileMo.New()

	mo:init(tileType, x, y, worldPos, rotation, polygon, rect)

	local name = customName or DeleikeHelper.GetTileName(tileType, x, y)
	local go = gohelper.cloneInPlace(self:_getTilePrefab(tileType), name)

	gohelper.setActive(go, true)

	local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, self:_getTileClass(tileType))

	comp:setData(mo)

	if tileType == DeleikeEnum.TileType.Bg and self.bgResPath then
		gohelper.getSingleImage(go):LoadImage(self.bgResPath)
	end

	self.unitCoord:registerUnit(comp)

	return comp
end

function DeleikeGameMgr:addBgTile(x, y, worldPos)
	local comp = self:addPolygonTile(DeleikeEnum.TileType.Bg, x, y, worldPos)

	if self.goGridTile then
		local hw = DeleikeEnum.GridTileWidth * 0.5
		local hh = DeleikeEnum.GridTileHeight * 0.5

		self:addPolygonTile(DeleikeEnum.TileType.Grid, x, y, worldPos, 0, {
			{
				x = -hw,
				y = -hh
			},
			{
				x = hw,
				y = -hh
			},
			{
				x = hw,
				y = hh
			},
			{
				x = -hw,
				y = hh
			}
		}, comp.go.name .. "_Grid", {
			cx = 0,
			cy = 0,
			w = DeleikeEnum.GridTileWidth,
			h = DeleikeEnum.GridTileHeight
		})
	end
end

function DeleikeGameMgr:addLineTile(centerX, centerY, dirX, dirY)
	local perpX, perpY = -dirY, dirX
	local perpAngle = math.deg(math.atan2(perpY, perpX))
	local name = string.format("Line_%d", math.random(1000, 9999))

	self:addPolygonTile(DeleikeEnum.TileType.Line, 0, 0, Vector2(centerX, centerY), perpAngle, nil, name)
end

function DeleikeGameMgr:snapshotForUndo()
	local unitCoord = self.unitCoord

	if not unitCoord then
		return
	end

	local tiles = {}
	local unitList = unitCoord.unitList

	for i = 1, #unitList do
		local comp = unitList[i]
		local mo = comp.mo

		if mo and comp.go and not gohelper.isNil(comp.go) then
			local polygon = {}

			for j = 1, #mo.polygon do
				polygon[j] = {
					x = mo.polygon[j].x,
					y = mo.polygon[j].y
				}
			end

			local r = mo.rect
			local var_8_0 = {
				tileType = mo.tileType,
				x = mo.x,
				y = mo.y,
				pos = {
					x = mo.pos.x,
					y = mo.pos.y
				},
				rotation = mo.rotation,
				polygon = polygon
			}

			var_8_0.rect = r and {
				w = r.w,
				h = r.h,
				cx = r.cx,
				cy = r.cy
			} or nil
			var_8_0.name = comp.go.name
			tiles[#tiles + 1] = var_8_0
		end
	end

	local triggers = {}
	local triggerList = unitCoord.triggerList

	for i = 1, #triggerList do
		local comp = triggerList[i]

		if not gohelper.isNil(comp.go) then
			local x, y = comp:getLogicPos()

			triggers[#triggers + 1] = {
				comp = comp,
				collected = comp.isCollected,
				x = x,
				y = y
			}
		end
	end

	local playerX, playerY, skillCounts

	if self.player then
		playerX, playerY = self.player:getLogicPos()
		skillCounts = {
			self.player:getSkillCount(1),
			self.player:getSkillCount(2)
		}
	end

	local camX, camY

	if self.sceneRootRt then
		local camPos = self.sceneRootRt.anchoredPosition

		camY = camPos.y
		camX = camPos.x
	end

	table.insert(self._undoStack, {
		tiles = tiles,
		triggers = triggers,
		playerX = playerX,
		playerY = playerY,
		skillCounts = skillCounts,
		camX = camX,
		camY = camY
	})
	DeleikeController.instance:dispatchEvent(DeleikeEvent.UndoStateChanged, true)
end

function DeleikeGameMgr:undoLastCut()
	local stack = self._undoStack

	if not stack or #stack == 0 then
		return
	end

	local snapshot = stack[#stack]

	if self.skillMgr then
		self.skillMgr:cancelDrag(true)
	end

	local unitCoord = self.unitCoord

	if unitCoord then
		unitCoord:clearAllTweens()

		local unitList = unitCoord.unitList

		for i = #unitList, 1, -1 do
			local comp = unitList[i]

			if comp.mo and comp.go and not gohelper.isNil(comp.go) then
				gohelper.destroy(comp.go)
				unitCoord:unregisterUnit(comp)
			end
		end
	end

	local tiles = snapshot.tiles

	for i = 1, #tiles do
		local t = tiles[i]

		self:addPolygonTile(t.tileType, t.x, t.y, t.pos, t.rotation, t.polygon, t.name, t.rect)
	end

	local triggers = snapshot.triggers

	for i = 1, #triggers do
		local t = triggers[i]
		local comp = t.comp

		if not gohelper.isNil(comp.go) then
			comp:setLogicPos(t.x, t.y)

			if not t.collected and comp.isCollected then
				comp:revive()
			end
		end
	end

	unitCoord:bumpSceneVersion()

	if self.player and snapshot.skillCounts then
		self.player:setPos(snapshot.playerX, snapshot.playerY)
		self.player:setSkillCount(1, snapshot.skillCounts[1])
		self.player:setSkillCount(2, snapshot.skillCounts[2])
	end

	if self.sceneRootRt and snapshot.camX ~= nil then
		recthelper.setAnchor(self.sceneRootRt, snapshot.camX, snapshot.camY)
	end

	table.remove(stack)
	DeleikeController.instance:dispatchEvent(DeleikeEvent.UndoStateChanged, #stack > 0)
end

function DeleikeGameMgr:canUndo()
	return self._undoStack ~= nil and #self._undoStack > 0
end

function DeleikeGameMgr:addTriggerPoint(type, x, y, worldPos)
	local isSkillPoint = type ~= DeleikeEnum.TriggerType.Door

	if isSkillPoint then
		if not self.goSkillPoint then
			local template = self.goDoor
			local go = gohelper.cloneInPlace(template)

			gohelper.setActive(go, true)

			if isSkillPoint then
				local comp = MonoHelper.addLuaComOnceToGo(go, DeleikeTriggerSkill or DeleikeTriggerDoor)

				comp:setData(type, x, y, worldPos)
				self.unitCoord:registerUnit(comp)
			end
		end
	end
end

function DeleikeGameMgr:createPlayer(spawnPos, goJoystick)
	if self.player then
		return
	end

	self.player = MonoHelper.addNoUpdateLuaComOnceToGo(self.goPlayer, DeleikePlayerComp, goJoystick)

	self.player:initData(spawnPos)

	if self.skillMgr then
		self.skillMgr.player = self.player
	end

	self.unitCoord:registerUnit(self.player)
end

function DeleikeGameMgr:onTriggerPicked(triggerType)
	if not self.player then
		return
	end

	AudioMgr.instance:trigger(AudioEnum4_0.Deleike.get_skill)

	if triggerType == DeleikeEnum.TriggerType.Skill1 then
		local count = self.player:getSkillCount(1)

		self.player:setSkillCount(1, count + 1, true)
	elseif triggerType == DeleikeEnum.TriggerType.Skill2 then
		local count = self.player:getSkillCount(2)

		self.player:setSkillCount(2, count + 1, true)
	end
end

function DeleikeGameMgr:clearScene()
	local unitCoord = self.unitCoord

	if unitCoord then
		local units = unitCoord:getAllUnits()

		for i = 1, #units do
			local comp = units[i]

			if comp.go and not gohelper.isNil(comp.go) and comp ~= self.player then
				gohelper.destroy(comp.go)
			end
		end

		unitCoord:clearAll()
	end

	if self.skillMgr then
		self.skillMgr:resetState()

		self.skillMgr.player = nil
	end

	self._undoStack = {}

	DeleikeController.instance:dispatchEvent(DeleikeEvent.UndoStateChanged, false)

	self.inputLocked = false

	if self.sceneRootRt then
		recthelper.setAnchor(self.sceneRootRt, 0, 0)
	end

	self.player = nil
end

function DeleikeGameMgr:dispose()
	self:clearScene()

	self.gameId = nil
	self.gameCfg, self.mapCfg = nil
	self.goBgTile = nil
	self.goGridTile = nil
	self.goAnchorTile, self.goNormalTile = nil
	self.goSkillPoint, self.goDoor = nil
	self.goLineTile = nil
	self.goSkillLine1, self.goSkillLine2 = nil
	self.goPlayer = nil
	self.goJoystick = nil

	if self.unitCoord then
		self.unitCoord:dispose()

		self.unitCoord = nil
	end

	if self.skillMgr then
		self.skillMgr:dispose()

		self.skillMgr = nil
	end
end

function DeleikeGameMgr:_getTilePrefab(tileType)
	if tileType == DeleikeEnum.TileType.Bg then
		return self.goBgTile
	elseif tileType == DeleikeEnum.TileType.Grid then
		return self.goGridTile
	elseif tileType == DeleikeEnum.TileType.Anchor then
		return self.goAnchorTile
	elseif tileType == DeleikeEnum.TileType.Line then
		return self.goLineTile
	end

	return self.goNormalTile
end

function DeleikeGameMgr:_getTileClass(type)
	self.type2Class = self.type2Class or {
		[DeleikeEnum.TileType.Bg] = DeleikeTileBg,
		[DeleikeEnum.TileType.Grid] = DeleikeTileBg,
		[DeleikeEnum.TileType.Normal] = DeleikeTileNormal,
		[DeleikeEnum.TileType.Line] = DeleikeTileLine
	}

	return self.type2Class[type] or DeleikeTileNormal
end

DeleikeGameMgr.instance = DeleikeGameMgr.New()

return DeleikeGameMgr
