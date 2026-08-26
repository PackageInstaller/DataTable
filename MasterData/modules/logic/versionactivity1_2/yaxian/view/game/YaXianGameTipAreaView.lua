-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGameTipAreaView.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameTipAreaView", package.seeall)

local YaXianGameTipAreaView = class("YaXianGameTipAreaView", BaseView)

function YaXianGameTipAreaView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianGameTipAreaView:addEvents()
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.RefreshAllInteractAlertArea, self.refreshAllInteractArea, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.ShowCanWalkGround, self.refreshCanWalkGround, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, self.onUpdateEffectInfo, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.DeleteInteractObj, self.recycleEnemyInteractTipArea, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnResetView, self.resetMapView, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.MainResLoadDone, self.onMainResLoadDone, self)
end

function YaXianGameTipAreaView:removeEvents()
	return
end

function YaXianGameTipAreaView:_editableInitView()
	self._alarmItemDict = {}
	self._alarmItemPool = {}
	self._targetPosItemDict = {}
	self._targetPosItemPool = {}
	self._canWalkItems = {}
	self._canWalkItemPool = {}
end

function YaXianGameTipAreaView:onMainResLoadDone(loader)
	if self.initResDone then
		return
	end

	self.loader = loader
	self.sceneGo = self.viewContainer:getRootSceneGo()
	self.sceneTipContainer = UnityEngine.GameObject.New("tipAreaContainer")

	self.sceneTipContainer.transform:SetParent(self.sceneGo.transform, false)
	transformhelper.setLocalPos(self.sceneTipContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.TipArea)

	self.alarmPrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.AlarmItem):GetResource()
	self.targetPrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.TargetItem):GetResource()
	self.canWalkPrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.DirItem):GetResource()
	self.initResDone = true
end

function YaXianGameTipAreaView:onUpdateEffectInfo()
	self:refreshCanWalkGround(self.preIsShow)
end

function YaXianGameTipAreaView:refreshAllInteractArea(isShow)
	for _, interactMo in ipairs(YaXianGameModel.instance:getInteractMoList()) do
		self:refreshInteractAlertArea(interactMo, isShow)
		self:refreshTargetPosArea(interactMo, isShow)
	end
end

function YaXianGameTipAreaView:refreshCanWalkGround(isShow)
	self.preIsShow = isShow

	self:recycleAllCanWalkItem()

	if not YaXianGameController.instance:isSelectingPlayer() then
		return
	end

	if isShow then
		local playerInteractMo = YaXianGameModel.instance:getPlayerInteractMo()
		local canWalkTargetPosDict = self:getCanWalkTargetPosDict(playerInteractMo.posX, playerInteractMo.posY)

		YaXianGameModel.instance:setCanWalkTargetPosDict(canWalkTargetPosDict)

		for _, pos in pairs(canWalkTargetPosDict) do
			local itemObj = self:createCanWalkItem(pos.x, pos.y)

			gohelper.setActive(itemObj.goNormal, true)
			gohelper.setActive(itemObj.goCenter, false)
		end

		local itemObj = self:createCanWalkItem(playerInteractMo.posX, playerInteractMo.posY)

		gohelper.setActive(itemObj.goNormal, false)
		gohelper.setActive(itemObj.goCenter, true)
	end
end

function YaXianGameTipAreaView:refreshInteractAlertArea(interactMo, isShow)
	self:recycleInteractAlertArea(interactMo.id)

	if not isShow then
		return
	end

	local areaList = interactMo and interactMo.alertPosList

	if areaList and #areaList > 0 then
		local alarmItem, alarmList

		for _, area in ipairs(areaList) do
			alarmList = self._alarmItemDict[interactMo.id]

			if not self._alarmItemDict[interactMo.id] then
				alarmList = {}
				self._alarmItemDict[interactMo.id] = alarmList
			end

			table.insert(alarmList, (self:createAlarmGroundItem(area.posX, area.posY)))
		end
	end
end

function YaXianGameTipAreaView:refreshTargetPosArea(interactMo, isShow)
	self:recycleInteractTargetPosArea(interactMo.id)

	if not isShow then
		return
	end

	if interactMo.nextPos then
		self._targetPosItemDict[interactMo.id] = self:createTargetPosItem(interactMo.nextPos.posX, interactMo.nextPos.posY)
	end
end

function YaXianGameTipAreaView:getCanWalkTargetPosDict(curX, curY)
	local isHide = YaXianGameModel.instance:hasInVisibleEffect()
	local isThroughWall = YaXianGameModel.instance:hasThroughWallEffect()
	local throughDistance = 0

	if isThroughWall then
		throughDistance = YaXianConfig.instance:getThroughSkillDistance()
	end

	local canWalkTargetPosDict = {}

	self:getMoveTargetPos(canWalkTargetPosDict, curX, curY, YaXianGameEnum.MoveDirection.Left, throughDistance, isHide)
	self:getMoveTargetPos(canWalkTargetPosDict, curX, curY, YaXianGameEnum.MoveDirection.Right, throughDistance, isHide)
	self:getMoveTargetPos(canWalkTargetPosDict, curX, curY, YaXianGameEnum.MoveDirection.Bottom, throughDistance, isHide)
	self:getMoveTargetPos(canWalkTargetPosDict, curX, curY, YaXianGameEnum.MoveDirection.Top, throughDistance, isHide)

	return canWalkTargetPosDict
end

function YaXianGameTipAreaView:getMoveTargetPos(canWalkTargetPosDict, curX, curY, direction, throughDistance, isHide)
	local posX, posY, passedWall = YaXianGameController.instance:getMoveTargetPos({
		posX = curX,
		posY = curY,
		moveDirection = direction,
		throughDistance = throughDistance,
		isHide = isHide
	})

	if posX == curX and posY == curY then
		canWalkTargetPosDict[direction] = nil
	else
		canWalkTargetPosDict[direction] = {
			x = posX,
			y = posY,
			passedWall = passedWall
		}
	end
end

function YaXianGameTipAreaView:createAlarmGroundItem(tileX, tileY)
	local itemObj
	local poolLen = #self._alarmItemPool

	if poolLen > 0 then
		itemObj = self._alarmItemPool[poolLen]
		self._alarmItemPool[poolLen] = nil
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()
		itemObj.go = gohelper.clone(self.alarmPrefab, self.sceneTipContainer, "alarmItem")
		itemObj.sceneTf = itemObj.go.transform
	end

	gohelper.setActive(itemObj.go, true)

	local x, y, z = YaXianGameHelper.calcTilePosInScene(tileX, tileY)

	transformhelper.setLocalPos(itemObj.sceneTf, x, y, z + YaXianGameEnum.AlertOffsetZ)

	return itemObj
end

function YaXianGameTipAreaView:createTargetPosItem(tileX, tileY)
	local itemObj
	local poolLen = #self._targetPosItemPool

	if poolLen > 0 then
		itemObj = table.remove(self._targetPosItemPool)
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()
		itemObj.go = gohelper.clone(self.targetPrefab, self.sceneTipContainer, "targetPosItem")
		itemObj.sceneTf = itemObj.go.transform
	end

	gohelper.setActive(itemObj.go, true)

	local x, y, z = YaXianGameHelper.calcTilePosInScene(tileX, tileY)

	transformhelper.setLocalPos(itemObj.sceneTf, x, y, z)

	return itemObj
end

function YaXianGameTipAreaView:createCanWalkItem(tileX, tileY)
	local itemObj
	local poolLen = #self._canWalkItemPool

	if poolLen > 0 then
		itemObj = self._canWalkItemPool[poolLen]
		self._canWalkItemPool[poolLen] = nil
	end

	if not itemObj then
		itemObj = self:getUserDataTb_()
		itemObj.go = gohelper.clone(self.canWalkPrefab, self.sceneTipContainer, "canWalkItem")
		itemObj.sceneTf = itemObj.go.transform
		itemObj.goCenter = gohelper.findChild(itemObj.go, "#go_center")
		itemObj.goNormal = gohelper.findChild(itemObj.go, "#go_normal")
	end

	gohelper.setActive(itemObj.go, true)

	local x, y, z = YaXianGameHelper.calcTilePosInScene(tileX, tileY)

	transformhelper.setLocalPos(itemObj.sceneTf, x, y, z)
	table.insert(self._canWalkItems, itemObj)

	return itemObj
end

function YaXianGameTipAreaView:recycleInteractAlertArea(interactId)
	local alarmList = self._alarmItemDict[interactId]

	if alarmList and #alarmList > 0 then
		for i = 1, #alarmList do
			gohelper.setActive(alarmList[i].go, false)
			table.insert(self._alarmItemPool, alarmList[i])
		end

		alarmList = nil
		self._alarmItemDict[interactId] = nil
	end
end

function YaXianGameTipAreaView:recycleInteractTargetPosArea(interactId)
	local targetPosItem = self._targetPosItemDict[interactId]

	if targetPosItem then
		gohelper.setActive(targetPosItem.go, false)
		table.insert(self._targetPosItemPool, targetPosItem)

		self._targetPosItemDict[interactId] = nil
	end
end

function YaXianGameTipAreaView:recycleEnemyInteractTipArea(interactId)
	self:recycleInteractTargetPosArea(interactId)
	self:recycleInteractAlertArea(interactId)
end

function YaXianGameTipAreaView:recycleAllAlarmItem()
	for k, alertItems in pairs(self._alarmItemDict) do
		for i = 1, #alertItems do
			gohelper.setActive(alertItems[i].go, false)
			table.insert(self._alarmItemPool, alertItems[i])
		end

		alertItems = nil
		self._alarmItemDict[k] = nil
	end
end

function YaXianGameTipAreaView:recycleAllCanWalkItem()
	for k, v in pairs(self._canWalkItems) do
		gohelper.setActive(v.go, false)
		table.insert(self._canWalkItemPool, v)

		self._canWalkItems[k] = nil
	end
end

function YaXianGameTipAreaView:recycleAllTargetPosItem()
	for k, targetPosItem in pairs(self._targetPosItemDict) do
		gohelper.setActive(targetPosItem.go, false)
		table.insert(self._targetPosItemPool, targetPosItem)

		self._targetPosItemDict[k] = nil
	end
end

function YaXianGameTipAreaView:resetMapView()
	self:recycleAllAlarmItem()
	self:recycleAllCanWalkItem()
	self:recycleAllTargetPosItem()
end

function YaXianGameTipAreaView:onClose()
	return
end

function YaXianGameTipAreaView:onDestroyView()
	return
end

return YaXianGameTipAreaView
