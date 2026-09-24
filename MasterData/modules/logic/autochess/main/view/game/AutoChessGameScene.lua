-- chunkname: @modules/logic/autochess/main/view/game/AutoChessGameScene.lua

module("modules.logic.autochess.main.view.game.AutoChessGameScene", package.seeall)

local AutoChessGameScene = class("AutoChessGameScene", BaseView)

function AutoChessGameScene:onInitView()
	self.gotouch = gohelper.findChild(self.viewGO, "UI/#go_touch")
	self.simageBg = gohelper.findChildSingleImage(self.viewGO, "Scene/BgLayer/simage_Bg")
	self.goChessLayer = gohelper.findChild(self.viewGO, "Scene/ChessLayer")
	self.goBoarder = gohelper.findChild(self.viewGO, "Scene/BoardLayer/Boader")
	self.goChess = gohelper.findChild(self.viewGO, "Scene/ChessLayer/Chess")
	self.goGlow1 = gohelper.findChild(self.viewGO, "Scene/BgLayerGlow/go_Glow1")
	self.goGlow2 = gohelper.findChild(self.viewGO, "Scene/BgLayerGlow/go_Glow2")
	self.goGlow3 = gohelper.findChild(self.viewGO, "Scene/BgLayerGlow/go_Glow3")
	self.goGlow4 = gohelper.findChild(self.viewGO, "Scene/BgLayerGlow/go_Glow4")
	self.dropItemList = {}

	for i = 1, 4 do
		local dropItem = self:getUserDataTb_()

		dropItem.go = gohelper.findChild(self.viewGO, "Scene/BoostLayer/path0" .. tostring(i))
		dropItem.simage = gohelper.findChildSingleImage(dropItem.go, "Icon")
		self.dropItemList[i] = dropItem
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessGameScene:addEvents()
	self._click:AddClickListener(self.onClickScene, self)
end

function AutoChessGameScene:removeEvents()
	self._click:RemoveClickListener()
end

function AutoChessGameScene:_editableInitView()
	self.moduleId = AutoChessModel.instance.moduleId
	self.sceneMo = AutoChessModel.instance:getSceneMo()
	self._tfTouch = self.gotouch.transform
	self._click = gohelper.getClickWithDefaultAudio(self.gotouch)

	CommonDragHelper.instance:registerDragObj(self.gotouch, self._beginDrag, self._onDrag, self._endDrag, self._checkDrag, self, nil, true)
	self:resetRandomSeed()
end

function AutoChessGameScene:onOpen()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.NextRound, self.onNextRound, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.CheckEnemyTeam, self.onCheckEnemy, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragMallItem, self.activeGlow, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragMallItemEnd, self.inactiveGlow, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.BossDrop, self.onBossDrop, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.FinishStepList, self.onStepFinish, self)
	AutoChessEntityMgr.instance:init(self)
	AutoChessEffectMgr.instance:init()

	if self.moduleId == AutoChessEnum.ModuleId.Friend then
		AutoChessController.instance:playStep(AutoChessEnum.ActionType.EndBuy)
	else
		self:changeScene(AutoChessEnum.ViewType.Player)
		AutoChessController.instance:playStep(AutoChessEnum.ActionType.StartBuy)
	end
end

function AutoChessGameScene:onClose()
	AutoChessController.instance:clearAllFlow()
	AutoChessHelper.lockScreen("AutoChessGameSceneLock", false)
end

function AutoChessGameScene:onDestroyView()
	TaskDispatcher.cancelTask(self.delayEnterFightScene, self)
	TaskDispatcher.cancelTask(self.delayAddEnemy, self)
	TaskDispatcher.cancelTask(self.startFightFlow, self)
	CommonDragHelper.instance:unregisterDragObj(self.gotouch)
	AutoChessEntityMgr.instance:dispose()
	AutoChessEffectMgr.instance:dispose()
end

function AutoChessGameScene:changeScene(type, outInit)
	self.viewType = type

	AutoChessGameModel.instance:initTileNodes(type)

	if self.viewType == AutoChessEnum.ViewType.All then
		if not self.sceneMo.lastFight then
			local fightData = self.sceneMo.fight
			local resUrl = AutoChessHelper.getSceneBgUrl(self.moduleId, type, fightData.roundType)

			self.simageBg:LoadImage(resUrl)
			AutoChessEntityMgr.instance:cacheAllEntity()

			if not outInit then
				self:initEntity()
			end
		end
	end
end

function AutoChessGameScene:initTile()
	local tileNodes = AutoChessGameModel.instance.tileNodes
	local row = AutoChessEnum.BoardSize.Row
	local column = self.viewType == AutoChessEnum.ViewType.All and AutoChessEnum.BoardSize.Column * 2 or AutoChessEnum.BoardSize.Column

	for i = 1, row do
		local tileSzise = AutoChessEnum.TileSize[self.viewType][i]

		for j = 1, column do
			local anchorPos = tileNodes[i][j]
			local go = gohelper.cloneInPlace(self.goBoarder, string.format("Boarder%d_%d", i, j))

			recthelper.setSize(go.transform, tileSzise.x, tileSzise.y)
			recthelper.setAnchor(go.transform, anchorPos.x, anchorPos.y)
			gohelper.setActive(go, true)
		end

		if self.viewType == AutoChessEnum.ViewType.Player then
			local anchorPos = tileNodes[4][i]
			local go = gohelper.cloneInPlace(self.goBoarder, string.format("Boarder%d_%d", 0, i))

			recthelper.setSize(go.transform, tileSzise.x, tileSzise.y)
			recthelper.setAnchor(go.transform, anchorPos.x, anchorPos.y)
			gohelper.setActive(go, true)
		end
	end
end

function AutoChessGameScene:createLeaderEntity(data)
	local go = self:getResInst(AutoChessStrEnum.ResPath.LeaderEntity, self.goChessLayer, "Leader" .. data.uid)
	local entity = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessLeaderEntity, self)

	entity:setData(data)

	return entity
end

function AutoChessGameScene:initEntity()
	local fightMo = self.sceneMo.fight

	if self.viewType == AutoChessEnum.ViewType.Player then
		AutoChessEntityMgr.instance:addLeaderEntity(fightMo.mySideMaster)

		local unwarZone = fightMo:getUnwarZone()

		if unwarZone then
			for _, v in ipairs(unwarZone.positions) do
				if tonumber(v.chess.uid) ~= 0 then
					AutoChessEntityMgr.instance:addEntity(unwarZone.id, v.chess, v.index)
				end
			end
		end
	elseif self.viewType == AutoChessEnum.ViewType.Enemy and fightMo.enemyMaster.id ~= 0 then
		AutoChessEntityMgr.instance:addLeaderEntity(fightMo.enemyMaster)
	end

	for _, warZone in ipairs(fightMo.warZones) do
		local x = warZone.id

		for i = 1, #warZone.positions do
			local chessPos = warZone.positions[i]
			local uid = chessPos.chess.uid

			if tonumber(uid) ~= 0 and (self.viewType == AutoChessEnum.ViewType.Player and chessPos.index < AutoChessEnum.BoardSize.Column or self.viewType == AutoChessEnum.ViewType.Enemy and chessPos.index > AutoChessEnum.BoardSize.Column - 1) then
				AutoChessEntityMgr.instance:addEntity(x, chessPos.chess, chessPos.index)
			end
		end
	end
end

function AutoChessGameScene:createEntity(warZone, data, pos)
	local go = self:getResInst(AutoChessStrEnum.ResPath.ChessEntity, self.goChessLayer, "Chess" .. data.uid)
	local chessEntity = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessEntity, self)

	chessEntity:setData(data, warZone, pos)

	return chessEntity
end

function AutoChessGameScene:onCloseViewFinish(viewName)
	if viewName == ViewName.AutoChessStartFightView then
		AutoChessHelper.lockScreen("AutoChessGameSceneLock", true)

		local svrFight = self.sceneMo.lastFight

		AutoChessEntityMgr.instance:addLeaderEntity(svrFight.mySideMaster, true)

		if svrFight.enemyMaster.id ~= 0 then
			AutoChessEntityMgr.instance:addLeaderEntity(svrFight.enemyMaster, true)
		end

		for _, warZone in ipairs(svrFight.warZones) do
			local x = warZone.id

			for i = 1, #warZone.positions do
				local chessPos = warZone.positions[i]
				local uid = chessPos.chess.uid

				if i <= AutoChessEnum.BoardSize.Column and tonumber(uid) ~= 0 then
					AutoChessEntityMgr.instance:addEntity(x, chessPos.chess, chessPos.index)
				end
			end
		end

		TaskDispatcher.runDelay(self.delayAddEnemy, self, 0.5)
	end
end

function AutoChessGameScene:delayAddEnemy()
	local svrFight = self.sceneMo.lastFight

	for _, warZone in ipairs(svrFight.warZones) do
		local x = warZone.id

		for i = 1, #warZone.positions do
			local chessPos = warZone.positions[i]
			local uid = chessPos.chess.uid

			if i > AutoChessEnum.BoardSize.Column and tonumber(uid) ~= 0 then
				AutoChessEntityMgr.instance:addEntity(x, chessPos.chess, chessPos.index)
			end
		end
	end

	TaskDispatcher.runDelay(self.startFightFlow, self, 0.3)
end

function AutoChessGameScene:onNextRound()
	AutoChessEntityMgr.instance:clearEntity()
	self:changeScene(AutoChessEnum.ViewType.Player)
end

function AutoChessGameScene:onCheckEnemy(isCheck)
	if isCheck then
		self:changeScene(AutoChessEnum.ViewType.Enemy)
	else
		self:changeScene(AutoChessEnum.ViewType.Player)
	end
end

function AutoChessGameScene:activeGlow(config)
	if config.type == AutoChessStrEnum.ChessType.Attack then
		gohelper.setActive(self.goGlow1, true)
		gohelper.setActive(self.goGlow3, true)
	elseif config.type == AutoChessStrEnum.ChessType.Support then
		gohelper.setActive(self.goGlow2, true)
	else
		gohelper.setActive(self.goGlow4, true)
	end
end

function AutoChessGameScene:inactiveGlow()
	gohelper.setActive(self.goGlow1, false)
	gohelper.setActive(self.goGlow2, false)
	gohelper.setActive(self.goGlow3, false)
	gohelper.setActive(self.goGlow4, false)
end

function AutoChessGameScene:onClickScene()
	if self.isDraging or AutoChessController.instance.isPlaying then
		return
	end

	local usingLeaderSkill = AutoChessGameModel.instance.usingLeaderSkill
	local position = GamepadController.instance:getMousePosition()
	local tempPos = recthelper.screenPosToAnchorPos(position, self._tfTouch)
	local tileX, tileY = AutoChessGameModel.instance:getNearestTileXY(tempPos.x, tempPos.y)

	if tileY then
		if self.viewType == AutoChessEnum.ViewType.Enemy then
			if self.sceneMo.fight.roundType == AutoChessEnum.RoundType.BOSS then
				tileX = 1
				tileY = 6
			else
				tileY = tileY + 5
			end
		end

		if self.viewType == AutoChessEnum.ViewType.All then
			if not self.sceneMo.lastFight then
				local fightMo = self.sceneMo.fight
				local chessPos = fightMo:getChessPosition(tileX, tileY)

				if chessPos then
					local chessMo = chessPos.chess

					if chessMo then
						if not chessMo.uid then
							local uid = 0

							if uid ~= 0 then
								local chessEntity = AutoChessEntityMgr.instance:getEntity(uid)

								if usingLeaderSkill then
									local types = AutoChessGameModel.instance.targetTypes

									if tabletool.indexOf(types, chessMo.config.type) then
										local master = self.sceneMo.fight.mySideMaster

										AutoChessRpc.instance:sendAutoChessUseMasterSkillRequest(self.moduleId, master.skill.id, tonumber(uid))
									end
								elseif chessMo.config.type == AutoChessStrEnum.ChessType.Incubate and chessPos.chess.cd == 0 then
									AutoChessRpc.instance:sendAutoChessUseSkillRequest(self.moduleId, uid)
								else
									local param = {
										type = AutoChessCard.ShowType.Sell,
										entity = chessEntity,
										showSell = self.viewType == AutoChessEnum.ViewType.Player
									}

									AutoChessController.instance:openCardInfoView(param)
								end
							end

							if usingLeaderSkill then
								AutoChessGameModel.instance:setUsingLeaderSkill(false)
							end
						end
					end
				end
			end
		end
	else
		local masterMo = AutoChessGameModel.instance:getNearestMaster(tempPos)

		if masterMo then
			if masterMo.config and masterMo.config.skillId ~= 0 then
				ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
					leader = masterMo
				})
			end
		elseif usingLeaderSkill then
			AutoChessGameModel.instance:setUsingLeaderSkill(false)
		end
	end
end

function AutoChessGameScene:_beginDrag(_, pointerEventData)
	self.isDraging = true

	if self.viewType == AutoChessEnum.ViewType.All then
		if not self.sceneMo.lastFight then
			local fightMo = self.sceneMo.fight
			local tempPos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._tfTouch)
			local tileX, tileY = AutoChessGameModel.instance:getNearestTileXY(tempPos.x, tempPos.y)

			if tileX then
				local chessPos = fightMo:getChessPosition(tileX, tileY)
				local chessMo = chessPos.chess

				if chessMo.uid ~= 0 then
					local entity = AutoChessEntityMgr.instance:getEntity(chessMo.uid)

					if entity.teamType == AutoChessEnum.TeamType.Player then
						self.chessAvatar = AutoChessGameModel.instance.avatar

						if self.chessAvatar then
							self.selectChess = entity

							self.selectChess:hide()

							local dir = transformhelper.getLocalScale(entity.dirTrs)
							local meshComp = entity.meshComp
							local uiMesh = gohelper.findChildUIMesh(self.chessAvatar)

							uiMesh.material = meshComp.uiMesh.material
							uiMesh.mesh = meshComp.uiMesh.mesh

							uiMesh:SetVerticesDirty()
							uiMesh:SetMaterialDirty()
							recthelper.setAnchor(self.chessAvatar.transform, tempPos.x, tempPos.y)
							transformhelper.setLocalScale(self.chessAvatar.transform, dir, 1, 1)

							local image = gohelper.findChildImage(self.chessAvatar, "role")

							image.sprite = meshComp.imageRole.sprite

							image:SetNativeSize()
							gohelper.setActive(self.chessAvatar, true)
							AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntity, chessMo.config)
							self:activeGlow(chessMo.config)
						end
					end
				end
			end
		end
	end
end

function AutoChessGameScene:_onDrag(_, pointerEventData)
	if self.selectChess then
		local position = pointerEventData.position
		local pos = recthelper.screenPosToAnchorPos(position, self._tfTouch)

		self:_moveToPos(self.chessAvatar.transform, pos)
	end
end

function AutoChessGameScene:_endDrag(_, pointerEventData)
	self.isDraging = false

	if self.selectChess then
		if self.viewType == AutoChessEnum.ViewType.All then
			if not self.sceneMo.lastFight then
				local fightMo = self.sceneMo.fight
				local fromUid = self.selectChess.mo.uid
				local fromWarZone = self.selectChess.warZone
				local fromIndex = self.selectChess.index
				local position = pointerEventData.position
				local tempPos = recthelper.screenPosToAnchorPos(position, self._tfTouch)
				local tileX, tileY = AutoChessGameModel.instance:getNearestTileXY(tempPos.x, tempPos.y)

				if tileY and tileY < 6 then
					if fromWarZone == AutoChessEnum.WarZone.Four or tileX == AutoChessEnum.WarZone.Four then
						if fromWarZone == AutoChessEnum.WarZone.Four and tileX == AutoChessEnum.WarZone.Four then
							if fromIndex + 1 == tileY then
								self.selectChess:show()
							else
								local targetChessPos = fightMo:getChessPosition(tileX, tileY)
								local targetEntity = AutoChessEntityMgr.instance:tryGetEntity(targetChessPos.chess.uid)

								if targetEntity then
									self.selectChess:show()
								else
									AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
									AutoChessRpc.instance:sendAutoChessBuildRequest(self.moduleId, AutoChessEnum.BuildType.Exchange, fromWarZone, fromIndex, fromUid, tileX, tileY - 1)
								end
							end
						else
							GameFacade.showToast(ToastEnum.AutoChessExchangeError)
							self.selectChess:show()
						end
					elseif tileX == fromWarZone and tileY == fromIndex + 1 then
						self.selectChess:show()
					else
						local targetChessPos = fightMo:getChessPosition(tileX, tileY)
						local targetEntity = AutoChessEntityMgr.instance:tryGetEntity(targetChessPos.chess.uid)

						if targetEntity then
							if AutoChessHelper.sameWarZoneType(fromWarZone, tileX) or AutoChessHelper.canMix(targetChessPos.chess, self.selectChess.mo) then
								if targetEntity.mo.id == self.selectChess.mo.id then
									AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
								else
									AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
								end

								AutoChessRpc.instance:sendAutoChessBuildRequest(self.moduleId, AutoChessEnum.BuildType.Exchange, fromWarZone, fromIndex, fromUid, tileX, tileY - 1, targetEntity.mo.uid)
							else
								GameFacade.showToast(ToastEnum.AutoChessExchangeError)
								self.selectChess:show()
							end
						elseif AutoChessHelper.sameWarZoneType(fromWarZone, tileX) then
							AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_purchase)
							AutoChessRpc.instance:sendAutoChessBuildRequest(self.moduleId, AutoChessEnum.BuildType.Exchange, fromWarZone, fromIndex, fromUid, tileX, tileY - 1)
						else
							GameFacade.showToast(ToastEnum.AutoChessExchangeError)
							self.selectChess:show()
						end
					end
				else
					local pointerEnter = pointerEventData.pointerEnter

					if pointerEnter and pointerEnter.name == "#go_CheckSell" then
						AutoChessRpc.instance:sendAutoChessBuildRequest(self.moduleId, AutoChessEnum.BuildType.Sell, fromWarZone, fromIndex, fromUid)
					else
						self.selectChess:show()
					end
				end

				gohelper.setActive(self.chessAvatar, false)

				self.chessAvatar = nil
				self.selectChess = nil

				AutoChessController.instance:dispatchEvent(AutoChessEvent.DragChessEntityEnd)
				self:inactiveGlow()
			end
		end
	end
end

function AutoChessGameScene:_checkDrag()
	return self.viewType == AutoChessEnum.ViewType.All or AutoChessController.instance.isPlaying
end

function AutoChessGameScene:_moveToPos(transform, pos)
	local curPosX, curPosY = transformhelper.getPos(transform)

	if math.abs(curPosX - pos.x) > 50 or math.abs(curPosY - pos.y) > 50 then
		if self.tweenId then
			ZProj.TweenHelper.KillById(self.tweenId)

			self.tweenId = nil
		end

		self.tweenId = ZProj.TweenHelper.DOAnchorPos(transform, pos.x, pos.y, 0.2)
	else
		recthelper.setAnchor(transform, pos.x, pos.y)
	end
end

function AutoChessGameScene:startFightFlow()
	AutoChessHelper.lockScreen("AutoChessGameSceneLock", false)
	AutoChessController.instance:playStep(AutoChessEnum.ActionType.RoundStart)
end

function AutoChessGameScene:delayEnterFightScene()
	self:changeScene(AutoChessEnum.ViewType.All, true)
end

function AutoChessGameScene:onStepFinish(type)
	if type == AutoChessEnum.ActionType.EndBuy then
		TaskDispatcher.runDelay(self.delayEnterFightScene, self, 0.5)
	elseif type == AutoChessEnum.ActionType.RoundStart then
		if self.sceneMo.lastFight.roundType == AutoChessEnum.RoundType.BOSS then
			for _, item in ipairs(self.dropItemList) do
				gohelper.setActive(item.go, false)
			end
		end

		self:resetRandomSeed()
	end
end

function AutoChessGameScene:onBossDrop(effectString)
	local collectionIds = string.splitToNumber(effectString, "#")

	for _, collectionId in ipairs(collectionIds) do
		local collectionCfg = AutoChessConfig.instance:getCollectionCfg(collectionId)

		if collectionCfg then
			local index = math.random(1, #self.randomSeed)
			local number = self.randomSeed[index]

			if number then
				local dropItem = self.dropItemList[number]

				dropItem.simage:LoadImage(ResUrl.getAutoChessIcon(collectionCfg.image, "collection"))
				gohelper.setActive(dropItem.go, true)
				table.remove(self.randomSeed, index)
			else
				logError("掉落物已耗尽，超出策划约定数量(4个)")
			end
		end
	end
end

function AutoChessGameScene:resetRandomSeed()
	self.randomSeed = {
		1,
		2,
		3,
		4
	}
end

return AutoChessGameScene
