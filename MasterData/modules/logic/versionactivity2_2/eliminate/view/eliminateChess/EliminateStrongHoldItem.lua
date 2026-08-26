-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateStrongHoldItem.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateStrongHoldItem", package.seeall)

local EliminateStrongHoldItem = class("EliminateStrongHoldItem", ListScrollCellExtend)

function EliminateStrongHoldItem:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._imageslotBGColor = gohelper.findChildImage(self.viewGO, "#go_info/#image_slotBGColor")
	self._simageslotBG = gohelper.findChildSingleImage(self.viewGO, "#go_info/#simage_slotBG")
	self._imageInfoTextBG = gohelper.findChildImage(self.viewGO, "#go_info/#image_InfoTextBG")
	self._txtInfo = gohelper.findChildText(self.viewGO, "#go_info/#image_InfoTextBG/#txt_Info")
	self._goEnemyPower = gohelper.findChild(self.viewGO, "#go_info/#go_EnemyPower")
	self._imageEnemyPower = gohelper.findChildImage(self.viewGO, "#go_info/#go_EnemyPower/#image_EnemyPower")
	self._imageEnemyPower2 = gohelper.findChildImage(self.viewGO, "#go_info/#go_EnemyPower/#image_EnemyPower2")
	self._txtEnemyPower = gohelper.findChildText(self.viewGO, "#go_info/#go_EnemyPower/#txt_Enemy_Power")
	self._txtEnemyPower1 = gohelper.findChildText(self.viewGO, "#go_info/#go_EnemyPower/#txt_Enemy_Power1")
	self._goPlayerPower = gohelper.findChild(self.viewGO, "#go_info/#go_PlayerPower")
	self._imagePlayerPower = gohelper.findChildImage(self.viewGO, "#go_info/#go_PlayerPower/#image_PlayerPower")
	self._imagePlayerPower2 = gohelper.findChildImage(self.viewGO, "#go_info/#go_PlayerPower/#image_PlayerPower2")
	self._txtPlayerPower = gohelper.findChildText(self.viewGO, "#go_info/#go_PlayerPower/#txt_Player_Power")
	self._txtPlayerPower1 = gohelper.findChildText(self.viewGO, "#go_info/#go_PlayerPower/#txt_Player_Power1")
	self._goEnemy = gohelper.findChild(self.viewGO, "#go_Enemy")
	self._goEnemyWin = gohelper.findChild(self.viewGO, "#go_EnemyWin")
	self._goPlayer = gohelper.findChild(self.viewGO, "#go_Player")
	self._goPlayerWin = gohelper.findChild(self.viewGO, "#go_PlayerWin")
	self._goLine4 = gohelper.findChild(self.viewGO, "#go_Line4")
	self._goLine6 = gohelper.findChild(self.viewGO, "#go_Line6")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateStrongHoldItem:addEvents()
	return
end

function EliminateStrongHoldItem:removeEvents()
	return
end

local UnityEngine_Animator_Type = typeof(UnityEngine.Animator)
local battleNormal = GameUtil.parseColor("#e5d3c3")
local green = GameUtil.parseColor("#7ECC66")
local red = GameUtil.parseColor("#FF7A66")
local tweenHelper = ZProj.TweenHelper
local itemColor = Color.New(1, 1, 1, 1)

function EliminateStrongHoldItem:_editableInitView()
	gohelper.setActive(self._goEnemyWin, false)
	gohelper.setActive(self._goPlayerWin, false)

	self.enemyWinAni = self._goEnemyWin:GetComponent(UnityEngine_Animator_Type)
	self.playerWinAni = self._goPlayerWin:GetComponent(UnityEngine_Animator_Type)
	self._goEnemyPowerAni = self._goEnemyPower:GetComponent(UnityEngine_Animator_Type)
	self._goPlayerPowerAni = self._goPlayerPower:GetComponent(UnityEngine_Animator_Type)
	self._txtEnemyPower.text = 0
	self._txtPlayerPower.text = 0

	self:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, "idle")
	self:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, "idle")
end

function EliminateStrongHoldItem:initData(data, i, maxLen)
	self._data = data
	self._strongholdIndex = i
	self._maxLen = maxLen

	self:initInfo()
	self:updateInfo()
end

function EliminateStrongHoldItem:onStart()
	return
end

function EliminateStrongHoldItem:initInfo()
	if self._data then
		local config = self._data:getStrongholdConfig()
		local levelConfig = EliminateTeamChessModel.instance:getCurWarChessEpisodeConfig()

		if config then
			local ruleId = config.ruleId
			local ruleConfig = EliminateConfig.instance:getStrongHoldRuleRuleConfig(ruleId)
			local text = ruleConfig and EliminateLevelModel.instance.formatString(ruleConfig.desc) or ""

			self:updateInfoText(text)

			local needShowLine = self._maxLen > 1 and self._strongholdIndex ~= self._maxLen
			local maxCount = math.max(config.friendCapacity, config.enemyCapacity)

			gohelper.setActive(self._goLine4, needShowLine and maxCount == 4)
			gohelper.setActive(self._goLine6, needShowLine and maxCount == 6)

			local imageName = EliminateLevelEnum.scenePathToStrongLandImageName[levelConfig.chessScene]

			if not string.nilorempty(imageName) then
				UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageslotBGColor, imageName, false)
			else
				gohelper.setActive(self._imageslotBGColor.gameObject, false)
			end

			local strongholdBg = config.strongholdBg

			if not string.nilorempty(strongholdBg) then
				self._simageslotBG:LoadImage(strongholdBg, nil, nil)
			end
		end
	end
end

function EliminateStrongHoldItem:initStrongHoldChess(playerChessGo, enemyChessGo, powerGo, hpGo)
	self:_initPlayerStrongHoldChess(playerChessGo, powerGo, hpGo)
	self:_initEnemyStrongHoldChess(enemyChessGo, powerGo, hpGo)
end

function EliminateStrongHoldItem:_initPlayerStrongHoldChess(chessGo, powerGo, hpGo)
	self._playerChessList = self:getUserDataTb_()
	self._playerPowerList = self:getUserDataTb_()
	self._playerGrowUpList = self:getUserDataTb_()
	self._playerChessGO = chessGo
	self._playerChessTr = self._playerChessGO.transform
	self._playerSelectGo = gohelper.findChild(self._playerChessGO, "#go_Selected")

	transformhelper.setLocalPos(self._playerChessTr, 0, 0, 0)

	if self._data then
		local config = self._data:getStrongholdConfig()
		local itemGo = gohelper.findChild(self._playerChessGO, "#go_slots")

		self._playerChessGoAni = itemGo:GetComponent(UnityEngine_Animator_Type)

		local itemCount = itemGo.transform.childCount
		local friendCapacity = config.friendCapacity

		for i = 1, itemCount do
			local item = gohelper.findChild(self._playerChessGO, "#go_slots/slot_" .. i)

			if friendCapacity < i then
				gohelper.setActive(item, false)
			else
				local imgItem = gohelper.findChildImage(self._playerChessGO, "#go_slots/slot_" .. i)

				self._playerChessList[i] = {
					item = item,
					imgItem = imgItem
				}

				local powerItem = gohelper.clone(powerGo, item, "slot_power_" .. i)

				recthelper.setAnchorX(powerItem.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosX)
				recthelper.setAnchorY(powerItem.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosY)
				gohelper.setActive(powerItem, false)

				local powerImage = gohelper.findChildImage(powerItem, "#image_chessPower")
				local powerText = gohelper.findChildText(powerItem, "#image_chessPower/#txt_chessPower")
				local ani = powerItem:GetComponent(UnityEngine_Animator_Type)

				self._playerPowerList[i] = {
					item = powerItem,
					powerImage = powerImage,
					powerText = powerText,
					ani = ani
				}

				local growUpItem = gohelper.clone(hpGo, item, "slot_growUp_" .. i)

				growUpItem.transform:SetParent(itemGo.transform)

				local x, y, z = transformhelper.getLocalPos(item.transform)

				transformhelper.setLocalPos(growUpItem.transform, x, y + EliminateTeamChessEnum.powerOffsetY, z)
				gohelper.setActive(growUpItem, false)

				local progressImage = gohelper.findChildImage(growUpItem, "image_FG")
				local progressImageEff = gohelper.findChildImage(growUpItem, "image_FG/image_FG_eff")

				table.insert(self._playerGrowUpList, {
					item = growUpItem,
					progressImage = progressImage,
					progressImageEff = progressImageEff
				})
			end
		end

		local rectWidth = recthelper.getWidth(self._playerChessTr)

		recthelper.setWidth(self.viewGO.transform, rectWidth)
	end
end

function EliminateStrongHoldItem:_initEnemyStrongHoldChess(chessGo, powerGo, hpGo)
	self._enemyChessList = self:getUserDataTb_()
	self._enemyPowerList = self:getUserDataTb_()
	self._enemyGrowUpList = self:getUserDataTb_()
	self._enemyChessGO = chessGo
	self._enemyChessTr = self._enemyChessGO.transform

	transformhelper.setLocalPos(self._enemyChessTr, 0, 0, 0)

	if self._data then
		local config = self._data:getStrongholdConfig()
		local itemGo = gohelper.findChild(self._enemyChessGO, "#go_slots")

		self._enemyChessGoAni = itemGo:GetComponent(UnityEngine_Animator_Type)

		local itemCount = itemGo.transform.childCount
		local enemyCapacity = config.enemyCapacity

		for i = itemCount, 1, -1 do
			local item = gohelper.findChild(self._enemyChessGO, "#go_slots/slot_" .. i)

			if enemyCapacity < i then
				gohelper.setActive(item, false)
			else
				local imgItem = gohelper.findChildImage(self._enemyChessGO, "#go_slots/slot_" .. i)

				table.insert(self._enemyChessList, {
					item = item,
					imgItem = imgItem
				})

				local powerItem = gohelper.clone(powerGo, item, "slot_power_" .. i)

				recthelper.setAnchorX(powerItem.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosX)
				recthelper.setAnchorY(powerItem.transform:GetComponent(gohelper.Type_RectTransform), EliminateTeamChessEnum.powerItemRectPosY)
				powerItem.transform:SetParent(itemGo.transform)
				gohelper.setActive(powerItem, false)

				local powerImage = gohelper.findChildImage(powerItem, "#image_chessPower")
				local powerText = gohelper.findChildText(powerItem, "#image_chessPower/#txt_chessPower")

				table.insert(self._enemyPowerList, {
					item = powerItem,
					powerImage = powerImage,
					powerText = powerText
				})

				local growUpItem = gohelper.clone(hpGo, item, "slot_growUp_" .. i)

				growUpItem.transform:SetParent(itemGo.transform)

				local x, y, z = transformhelper.getLocalPos(item.transform)

				transformhelper.setLocalPos(growUpItem.transform, x, y + EliminateTeamChessEnum.powerOffsetY, z)
				gohelper.setActive(growUpItem, false)

				local progressImage = gohelper.findChildImage(growUpItem, "image_FG")
				local progressImageEff = gohelper.findChildImage(growUpItem, "image_FG/image_FG_eff")

				table.insert(self._enemyGrowUpList, {
					item = growUpItem,
					progressImage = progressImage,
					progressImageEff = progressImageEff
				})
			end
		end
	end
end

function EliminateStrongHoldItem:addStrongholdChess(data, strongholdId, index)
	if self._data.id ~= strongholdId then
		return
	end

	local item, powerItem

	if data.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		item = self._playerChessList[index]
		powerItem = self._playerPowerList[index]
	end

	if data.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		item = self._enemyChessList[index]
		powerItem = self._enemyPowerList[index]
	end

	self:refreshItemInfo(index, data, item, powerItem, nil)
end

function EliminateStrongHoldItem:removeStrongholdChess(strongholdId, uid, index, teamType)
	if self._data.id ~= strongholdId then
		return
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RemoveStronghold3DChess, uid)
	self:hideIndexInfo(index, teamType)

	if uid == EliminateTeamChessEnum.tempPieceUid then
		self:refreshSlotItemView()
	else
		TaskDispatcher.runDelay(self.refreshSlotItemView, self, EliminateTeamChessEnum.teamChessPlaceStep)
	end
end

function EliminateStrongHoldItem:hideIndexInfo(index, teamType)
	local item, powerItem, growUpItem

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		item = self._playerChessList[index]
		powerItem = self._playerPowerList[index]
		growUpItem = self._playerGrowUpList[index]
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		item = self._enemyChessList[index]
		powerItem = self._enemyPowerList[index]
		growUpItem = self._enemyGrowUpList[index]
	end

	if item ~= nil then
		itemColor.a = 0
		item.imgItem.color = itemColor
	end

	if powerItem ~= nil then
		gohelper.setActive(powerItem.item, false)
	end

	if growUpItem ~= nil then
		gohelper.setActive(growUpItem.item, false)
	end
end

function EliminateStrongHoldItem:enemyGoPlayAni(name)
	if self._enemyChessGoAni then
		self._enemyChessGoAni:Play(name, 0, 0)
	end
end

function EliminateStrongHoldItem:playerGoPlayAni(name)
	if self._playerChessGoAni then
		self._playerChessGoAni:Play(name, 0, 0)
	end
end

function EliminateStrongHoldItem:strongHoldSettle(strongholdId)
	if self._data.id ~= strongholdId then
		return
	end

	self:enemyGoPlayAni("close")
	self:playerGoPlayAni("close")
	self:setInfoActive(false)
	self:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.enemy, false)
	self:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.player, false)

	local rectWidth = recthelper.getWidth(self._imageslotBGColor.gameObject.transform) - 70
	local rectHeight = recthelper.getHeight(self._imageslotBGColor.gameObject.transform) - 60

	TeamChessUnitEntityMgr.instance:moveEntityByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, strongholdId, self._goinfo.transform, rectWidth, rectHeight)
	TeamChessUnitEntityMgr.instance:moveEntityByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, strongholdId, self._goinfo.transform, rectWidth, rectHeight)

	local playerSoliderCount = self._data:getPlayerSoliderCount()
	local enemySoliderCount = self._data:getEnemySoliderCount()

	if playerSoliderCount > 0 or enemySoliderCount > 0 then
		TaskDispatcher.runDelay(self.showResultFight, self, EliminateTeamChessEnum.entityMoveTime)
	else
		self:strongHoldSettleShowResult()
	end
end

function EliminateStrongHoldItem:showResultFight()
	TaskDispatcher.cancelTask(self.showResultFight, self)

	local x, y, z = transformhelper.getPos(self._goinfo.transform)

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, EliminateTeamChessEnum.VxEffectType.StrongHoldBattle, x, y, z)
	TaskDispatcher.runDelay(self.strongHoldSettleShowResult, self, EliminateTeamChessEnum.StrongHoldBattleVxTime)
end

function EliminateStrongHoldItem:strongHoldSettleShowResult()
	TaskDispatcher.cancelTask(self.strongHoldSettleShowResult, self)

	local status = self._data.status
	local enemyIsWin = status == EliminateTeamChessEnum.StrongHoldState.enemySide
	local mySideIsWin = status == EliminateTeamChessEnum.StrongHoldState.mySide

	gohelper.setActive(self._goEnemyWin, enemyIsWin)
	gohelper.setActive(self._goPlayerWin, mySideIsWin)

	if enemyIsWin or mySideIsWin then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_checkpoint_extrafall_eliminate)
	end

	if enemyIsWin then
		TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, self._data.id)
		self:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.player, true)

		if self.enemyWinAni then
			self.enemyWinAni:Play("open", 0, 0)
		end
	end

	if mySideIsWin then
		TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, self._data.id)
		self:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.enemy, true)

		if self.playerWinAni then
			self.playerWinAni:Play("open", 0, 0)
		end
	end
end

function EliminateStrongHoldItem:strongHoldSettleResetShow()
	logNormal("EliminateStrongHoldItem:strongHoldSettleResetShow")
	gohelper.setActive(self._goEnemyWin, false)
	gohelper.setActive(self._goPlayerWin, false)
	self:enemyGoPlayAni("open")
	self:playerGoPlayAni("open")
	self:setInfoActive(true)
	self:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.enemy, true)
	self:setPowerActive(EliminateTeamChessEnum.TeamChessTeamType.player, true)
	TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.enemy, self._data.id)
	TeamChessUnitEntityMgr.instance:resetEntityPosByTeamTypeAndStrongHold(EliminateTeamChessEnum.TeamChessTeamType.player, self._data.id)
	self:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.enemy, false)
	self:setChessGray(EliminateTeamChessEnum.TeamChessTeamType.player, false)
end

function EliminateStrongHoldItem:setChessGray(teamType, active)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		local mySidePiece = self._data.mySidePiece

		if mySidePiece then
			for i = 1, #mySidePiece do
				local piece = mySidePiece[i]

				if piece then
					TeamChessUnitEntityMgr.instance:setGrayActive(piece.uid, active)
				end
			end
		end
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		local enemySidePiece = self._data.enemySidePiece

		if enemySidePiece then
			for i = 1, #enemySidePiece do
				local piece = enemySidePiece[i]

				if piece then
					TeamChessUnitEntityMgr.instance:setGrayActive(piece.uid, active)
				end
			end
		end
	end
end

function EliminateStrongHoldItem:teamChessUpdateActiveMoveState(uid)
	if uid == nil then
		return
	end

	local entity = TeamChessUnitEntityMgr.instance:getEntity(uid)
	local chess = self._data:getChess(uid)

	if entity and chess then
		local canMove = chess:canActiveMove()

		if canMove then
			if not EliminateTeamChessEnum.ModeType.Outline then
				local mode = EliminateTeamChessEnum.ModeType.Normal

				entity:setShowModeType(mode)
			end
		end
	end
end

function EliminateStrongHoldItem:setStrongHoldSelect(soliderId, strongHoldId)
	if self._playerSelectGo then
		local isActive = strongHoldId and self._data.id == strongHoldId or false

		gohelper.setActiveCanvasGroup(self._playerSelectGo, isActive)
	end
end

function EliminateStrongHoldItem:refreshViewByRoundState(roundStepState)
	if self._enemyChessList == nil then
		return
	end

	for i = 1, #self._enemyChessList do
		local item = self._enemyChessList[i]

		if item then
			gohelper.setActive(item.item, roundStepState == EliminateTeamChessEnum.TeamChessRoundType.enemy)
		end
	end
end

function EliminateStrongHoldItem:setInfoActive(active)
	gohelper.setActive(self._imageInfoTextBG.gameObject, active)
end

function EliminateStrongHoldItem:refreshSlotItemView()
	TaskDispatcher.cancelTask(self.refreshSlotItemView, self)

	if self._data then
		local config = self._data:getStrongholdConfig()

		for i = 1, config.friendCapacity do
			local item = self._playerChessList[i]
			local powerItem = self._playerPowerList[i]
			local growUpItem = self._playerGrowUpList[i]

			self:refreshItemInfo(i, self._data.mySidePiece[i], item, powerItem, growUpItem)
		end

		for i = 1, config.enemyCapacity do
			local item = self._enemyChessList[i]
			local powerItem = self._enemyPowerList[i]
			local growUpItem = self._enemyGrowUpList[i]

			self:refreshItemInfo(i, self._data.enemySidePiece[i], item, powerItem, growUpItem)
		end
	end
end

function EliminateStrongHoldItem:refreshItemInfo(index, data, item, powerItem, growUpItem)
	if item == nil or item.item == nil or powerItem == nil or powerItem.item == nil then
		return
	end

	gohelper.setActive(powerItem.item, data ~= nil)

	if growUpItem ~= nil then
		local needShow = false

		if data and data.skill then
			for i = 1, #data.skill do
				local skill = data.skill[i]

				if skill and skill:needShowGrowUp() then
					needShow = true

					break
				end
			end
		end

		gohelper.setActive(growUpItem.item, needShow)
	end

	if data ~= nil then
		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RefreshStronghold3DChess, data, self._data.id, index, item.item.transform)

		if powerItem and powerItem.powerText then
			self:updatePowerNumber(powerItem.powerText, data.battle, data.id)
		end

		local activeSkill = data:getActiveSkill()

		if activeSkill ~= nil then
			self:teamChessGrowUpValueChange(data.uid, activeSkill.id, nil)
		end
	end

	itemColor.a = data == nil and 1 or 0
	item.imgItem.color = itemColor
end

function EliminateStrongHoldItem:updatePowerNumber(powerText, value, soliderId)
	local config = EliminateConfig.instance:getSoldierChessConfig(soliderId)
	local color = battleNormal

	if value > config.defaultPower then
		color = green
	end

	if value < config.defaultPower then
		color = red
	end

	powerText.text = value
	powerText.color = color
end

function EliminateStrongHoldItem:checkInPlayerChessRect(x, y)
	if self._playerChessTr == nil then
		return false
	end

	return recthelper.screenPosInRect(self._playerChessTr, CameraMgr.instance:getMainCamera(), x, y)
end

function EliminateStrongHoldItem:updateInfo()
	if self._data then
		self:refreshStateByScore(self._data.myScore, self._data.enemyScore, false)
	end
end

function EliminateStrongHoldItem:strongHoldPowerChange(strongholdId, teamType, diffValue)
	if self._data == nil or self._data.id ~= strongholdId then
		return
	end

	self:refreshStateByScore(self._data.myScore, self._data.enemyScore, true)
end

function EliminateStrongHoldItem:playAni(teamType, aniName)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player and self._goPlayerPowerAni then
		self._goPlayerPowerAni:Play(aniName, 0, 0)
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy and self._goEnemyPowerAni then
		self._goEnemyPowerAni:Play(aniName, 0, 0)
	end
end

function EliminateStrongHoldItem:teamChessPowerChange(uid, diffValue)
	local mySlideIndex = self._data:getMySideIndexByUid(uid)

	if mySlideIndex ~= -1 and self._playerPowerList then
		local powerItem = self._playerPowerList[mySlideIndex]

		if powerItem and powerItem.powerText then
			local data = self._data:getMySideByUid(uid)

			if data then
				self:updatePowerNumber(powerItem.powerText, data.battle, data.id)

				if diffValue ~= 0 then
					local name = diffValue > 0 and "up" or "down"

					if powerItem.ani then
						powerItem.ani:Play(name, 0, 0)
					end
				end
			end

			return
		end
	end

	local enemySlideIndex = self._data:getEnemySideIndexByUid(uid)

	if enemySlideIndex ~= -1 and self._enemyPowerList then
		local powerItem = self._enemyPowerList[enemySlideIndex]

		if powerItem and powerItem.powerText then
			local data = self._data:getEnemySideByUid(uid)

			if data then
				self:updatePowerNumber(powerItem.powerText, data.battle, data.id)

				if diffValue ~= 0 then
					local name = diffValue > 0 and "up" or "down"

					if powerItem.ani then
						powerItem.ani:Play(name, 0, 0)
					end
				end
			end

			return
		end
	end
end

function EliminateStrongHoldItem:teamChessGrowUpValueChange(uid, skillId, upValue)
	if skillId == nil then
		return
	end

	local mySlideIndex = self._data:getMySideIndexByUid(uid)

	if mySlideIndex ~= -1 and self._playerGrowUpList then
		local growUpItem = self._playerGrowUpList[mySlideIndex]

		if growUpItem and growUpItem.progressImage then
			local data = self._data:getMySideByUid(uid)
			local skill = data and data:getSkill(skillId)
			local progress = skill and skill:getGrowUpProgress() or 0
			local needShow = skill and skill:needShowGrowUp() or false

			if progress > 0 then
				tweenHelper.DOFillAmount(growUpItem.progressImage, progress, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
				tweenHelper.DOFillAmount(growUpItem.progressImageEff, progress, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
			else
				growUpItem.progressImage.fillAmount = progress
				growUpItem.progressImageEff.fillAmount = progress
			end

			gohelper.setActive(growUpItem.item, needShow)

			return
		end
	end

	local enemySlideIndex = self._data:getEnemySideIndexByUid(uid)

	if enemySlideIndex ~= -1 and self._enemyGrowUpList then
		local growUpItem = self._enemyGrowUpList[enemySlideIndex]

		if growUpItem and growUpItem.progressImage then
			local data = self._data:getEnemySideByUid(uid)
			local skill = data and data:getSkill(skillId)
			local progress = skill and skill:getGrowUpProgress() or 0
			local needShow = skill and skill:needShowGrowUp() or false

			if progress > 0 then
				tweenHelper.DOFillAmount(growUpItem.progressImage, progress, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
				tweenHelper.DOFillAmount(growUpItem.progressImageEff, progress, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime, nil, nil, nil, EaseType.OutQuart)
			else
				growUpItem.progressImage.fillAmount = progress
				growUpItem.progressImageEff.fillAmount = progress
			end

			gohelper.setActive(growUpItem.item, needShow)

			return
		end
	end
end

function EliminateStrongHoldItem:setPowerTrParent(parent)
	if gohelper.isNil(parent) then
		return
	end

	self._enemyPowerParent = gohelper.create2d(parent.gameObject, "enemyPowerItem")
	self._playerPowerParent = gohelper.create2d(parent.gameObject, "playerPowerItem")

	local enemyPowerTr = self._enemyPowerParent.transform
	local playerPowerTr = self._playerPowerParent.transform

	for i = 1, #self._enemyPowerList do
		local item = self._enemyPowerList[i]

		if item then
			item.item.transform:SetParent(enemyPowerTr)
		end
	end

	for i = 1, #self._playerPowerList do
		local item = self._playerPowerList[i]

		if item then
			item.item.transform:SetParent(playerPowerTr)
		end
	end
end

function EliminateStrongHoldItem:setPowerActive(teamType, active)
	if teamType == EliminateTeamChessEnum.TeamChessTeamType.player and not gohelper.isNil(self._enemyPowerParent) then
		gohelper.setActive(self._enemyPowerParent, active)
	end

	if teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy and not gohelper.isNil(self._playerPowerParent) then
		gohelper.setActive(self._playerPowerParent, active)
	end
end

function EliminateStrongHoldItem:updateInfoText(txt)
	self._txtInfo.text = txt

	gohelper.setActive(self._imageInfoTextBG.gameObject, not string.nilorempty(txt))
end

function EliminateStrongHoldItem:refreshStateByScore(myScore, enemySocre)
	local lastEnemyScore = tonumber(self._txtEnemyPower.text)
	local lastPayerScore = tonumber(self._txtPlayerPower.text)
	local playerWin = lastEnemyScore < lastPayerScore

	self._txtPlayerPower.text = myScore
	self._txtPlayerPower1.text = myScore
	self._txtEnemyPower.text = enemySocre
	self._txtEnemyPower1.text = enemySocre

	if myScore < enemySocre then
		self._txtEnemyPower.color = EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	end

	if myScore < enemySocre then
		self._txtEnemyPower1.color = EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	end

	if myScore < enemySocre then
		self._txtEnemyPower.fontSize = EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	end

	if myScore < enemySocre then
		self._txtEnemyPower1.fontSize = EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	end

	if enemySocre < myScore then
		self._txtPlayerPower.color = EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	end

	if enemySocre < myScore then
		self._txtPlayerPower1.color = EliminateLevelEnum.winColor or EliminateLevelEnum.loserColor
	end

	if enemySocre < myScore then
		self._txtPlayerPower.fontSize = EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	end

	if enemySocre < myScore then
		self._txtPlayerPower1.fontSize = EliminateLevelEnum.winSize or EliminateLevelEnum.loserSize
	end

	local playerAni, enemyAni = "idle", "idle"

	if myScore ~= enemySocre then
		if myScore < enemySocre then
			playerAni = lastPayerScore == lastEnemyScore and "idle" or playerWin and "down" or "down_refresh"
			enemyAni = lastPayerScore == lastEnemyScore and "up" or "up_refresh"
		else
			playerAni = lastPayerScore == lastEnemyScore and "up" or playerWin and "up_refresh" or "up"
			enemyAni = lastPayerScore == lastEnemyScore and "idle" or "down_refresh"
		end
	end

	self:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, playerAni)
	self:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, enemyAni)
end

function EliminateStrongHoldItem:refreshAni(active)
	if active then
		local myScore = self._data.myScore
		local enemySocre = self._data.enemyScore
		local playerAni, enemyAni = "idle", "idle"

		if myScore < enemySocre then
			enemyAni = "up"
		elseif enemySocre < myScore then
			playerAni = "up"
		end

		self:playAni(EliminateTeamChessEnum.TeamChessTeamType.player, playerAni)
		self:playAni(EliminateTeamChessEnum.TeamChessTeamType.enemy, enemyAni)
	end
end

function EliminateStrongHoldItem:clear()
	return
end

function EliminateStrongHoldItem:onDestroy()
	TaskDispatcher.cancelTask(self.showResultFight, self)
	TaskDispatcher.cancelTask(self.strongHoldSettleShowResult, self)
	TaskDispatcher.cancelTask(self.refreshSlotItemView, self)

	self._playerPowerParent = nil
	self._enemyPowerParent = nil
	self._enemyChessGoAni = nil
	self._playerChessGoAni = nil
end

return EliminateStrongHoldItem
