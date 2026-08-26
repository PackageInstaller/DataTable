-- chunkname: @modules/logic/versionactivity1_2/yaxian/view/game/YaXianGamePathView.lua

module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGamePathView", package.seeall)

local YaXianGamePathView = class("YaXianGamePathView", BaseView)

function YaXianGamePathView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function YaXianGamePathView:addEvents()
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.RefreshInteractPath, self.refreshInteractPath, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnUpdateEffectInfo, self.onUpdateEffectInfo, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.OnResetView, self.resetMapView, self)
	self.addEventCb(self, YaXianGameController.instance, YaXianEvent.MainResLoadDone, self.onMainResLoadDone, self)
end

function YaXianGamePathView:removeEvents()
	return
end

function YaXianGamePathView:_editableInitView()
	self.playerPathPool = {}
	self.playerHalfPathPool = {}
	self.enemyPathPool = {}
	self.enemyHalfPathPool = {}
	self.playerPathList = {}
	self.playerHalfPathList = {}
	self.enemyPathList = {}
	self.enemyHalfPathList = {}
end

function YaXianGamePathView:onMainResLoadDone(loader)
	if self.initResDone then
		return
	end

	self.loader = loader
	self.sceneGo = self.viewContainer:getRootSceneGo()
	self.pathContainer = UnityEngine.GameObject.New("pathContainer")

	self.pathContainer.transform:SetParent(self.sceneGo.transform, false)
	transformhelper.setLocalPos(self.pathContainer.transform, 0, 0, YaXianGameEnum.ContainerOffsetZ.Path)

	self.greedLinePrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.GreenLine):GetResource()
	self.redLinePrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.RedLine):GetResource()
	self.greenHalfLinePrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.GreedLineHalf):GetResource()
	self.redHalfLinePrefab = self.loader:getAssetItem(YaXianGameEnum.SceneResPath.RedLineHalf):GetResource()
	self.initResDone = true
end

function YaXianGamePathView:onUpdateEffectInfo()
	self:refreshInteractPath(self.preIsShow)
end

function YaXianGamePathView:refreshInteractPath(isShow)
	self.preIsShow = isShow

	self:refreshPlayerInteractPath(isShow)
	self:refreshEnemyInteractPath(isShow)
end

function YaXianGamePathView:refreshPlayerInteractPath(isShow)
	self:recyclePlayerInteractPath()

	if isShow then
		local interactMo = YaXianGameModel.instance:getPlayerInteractMo()
		local canWalkTargetPosDict = YaXianGameModel.instance:getCanWalkTargetPosDict()

		for direction, pos in pairs(canWalkTargetPosDict) do
			self:buildPath(interactMo.posX, interactMo.posY, pos.x, pos.y, true, direction)
		end
	end
end

function YaXianGamePathView:refreshEnemyInteractPath(isShow)
	self:recycleEnemyInteractPath()

	if isShow then
		for _, interactMo in ipairs(YaXianGameModel.instance:getInteractMoList()) do
			if interactMo.nextPos then
				self:buildPath(interactMo.posX, interactMo.posY, interactMo.nextPos.posX, interactMo.nextPos.posY, false)
			end
		end
	end
end

function YaXianGamePathView:buildPath(startPosX, startPosY, targetPosX, targetPosY, isPlayer, direction)
	direction = direction or YaXianGameHelper.getDirection(startPosX, startPosY, targetPosX, targetPosY)

	if startPosX ~= targetPosX then
		local step = 1

		if targetPosX < startPosX then
			step = -1
		end

		for i = startPosX + step, targetPosX - step, step do
			local pathItem = self:getPathItem(isPlayer)

			self:setPathItemPos(pathItem, direction, i, startPosY)
		end

		local pathItem = self:getHalfPathItem(isPlayer)

		self:setPathItemPos(pathItem, direction, targetPosX, targetPosY)

		return
	end

	if startPosY ~= targetPosY then
		local step = 1

		if targetPosY < startPosY then
			step = -1
		end

		for i = startPosY + step, targetPosY - step, step do
			local pathItem = self:getPathItem(isPlayer)

			self:setPathItemPos(pathItem, direction, startPosX, i)
		end

		local pathItem = self:getHalfPathItem(isPlayer)

		self:setPathItemPos(pathItem, direction, targetPosX, targetPosY)

		return
	end

	logError(string.format("build Path fail ... %s, %s, %s, %s", startPosX, startPosY, targetPosX, targetPosY))
end

function YaXianGamePathView:getPathItem(isPlayer)
	local pathItem

	if isPlayer then
		pathItem = next(self.playerPathPool) and table.remove(self.playerPathPool) or self:createPathItem(self.greedLinePrefab)

		table.insert(self.playerPathList, pathItem)

		return pathItem
	end

	pathItem = next(self.enemyPathPool) and table.remove(self.enemyPathPool) or self:createPathItem(self.redLinePrefab)

	table.insert(self.enemyPathList, pathItem)

	return pathItem
end

function YaXianGamePathView:getHalfPathItem(isPlayer)
	local pathItem

	if isPlayer then
		pathItem = next(self.playerHalfPathPool) and table.remove(self.playerHalfPathPool) or self:createPathItem(self.greenHalfLinePrefab)

		table.insert(self.playerHalfPathList, pathItem)

		return pathItem
	end

	pathItem = next(self.enemyHalfPathPool) and table.remove(self.enemyHalfPathPool) or self:createPathItem(self.redHalfLinePrefab)

	table.insert(self.enemyHalfPathList, pathItem)

	return pathItem
end

function YaXianGamePathView:createPathItem(prefab)
	local pathItem = self:getUserDataTb_()

	pathItem.go = gohelper.clone(prefab, self.pathContainer)
	pathItem.tr = pathItem.go.transform
	pathItem.goDirectionDict = {
		[YaXianGameEnum.MoveDirection.Bottom] = gohelper.findChild(pathItem.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Bottom]),
		[YaXianGameEnum.MoveDirection.Left] = gohelper.findChild(pathItem.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Left]),
		[YaXianGameEnum.MoveDirection.Right] = gohelper.findChild(pathItem.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Right]),
		[YaXianGameEnum.MoveDirection.Top] = gohelper.findChild(pathItem.go, YaXianGameEnum.DirectionName[YaXianGameEnum.MoveDirection.Top])
	}

	return pathItem
end

function YaXianGamePathView:resetPathItem(pathItem)
	if not pathItem then
		return
	end

	for _, direction in pairs(YaXianGameEnum.MoveDirection) do
		gohelper.setActive(pathItem.goDirectionDict[direction], false)
	end
end

function YaXianGamePathView:setPathItemPos(pathItem, direction, posX, posY)
	self:resetPathItem(pathItem)
	gohelper.setActive(pathItem.go, true)
	gohelper.setActive(pathItem.goDirectionDict[direction], true)

	local x, y, z = YaXianGameHelper.calcTilePosInScene(posX, posY)

	transformhelper.setLocalPos(pathItem.tr, x, y, z)
end

function YaXianGamePathView:recyclePlayerInteractPath()
	for _, pathItem in ipairs(self.playerPathList) do
		gohelper.setActive(pathItem.go, false)
		table.insert(self.playerPathPool, pathItem)
	end

	for _, pathItem in ipairs(self.playerHalfPathList) do
		gohelper.setActive(pathItem.go, false)
		table.insert(self.playerHalfPathPool, pathItem)
	end

	self.playerPathList = {}
	self.playerHalfPathList = {}
end

function YaXianGamePathView:recycleEnemyInteractPath()
	for _, pathItem in ipairs(self.enemyPathList) do
		gohelper.setActive(pathItem.go, false)
		table.insert(self.enemyPathPool, pathItem)
	end

	for _, pathItem in ipairs(self.enemyHalfPathList) do
		gohelper.setActive(pathItem.go, false)
		table.insert(self.enemyHalfPathPool, pathItem)
	end

	self.enemyPathList = {}
	self.enemyHalfPathList = {}
end

function YaXianGamePathView:recycleAllPath()
	self:recyclePlayerInteractPath()
	self:recycleEnemyInteractPath()
end

function YaXianGamePathView:resetMapView()
	self:recycleAllPath()
end

function YaXianGamePathView:onClose()
	return
end

function YaXianGamePathView:onDestroyView()
	return
end

return YaXianGamePathView
