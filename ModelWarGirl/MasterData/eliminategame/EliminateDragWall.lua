-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/EliminateGame\\EliminateDragWall.lua

local UIUtils = require("Framework.UI.UIUtils")
local GameSettings = require("Helper/GameSettings")
local EliminateObject = require("EliminateGame/EliminateObject")
local EliminateHero = require("EliminateGame/EliminateHero")
local BattleConst = require("Common/FrameBattle/BattleConst")
local CueDataBank = require("System/CueDataBank")
local ResMiniGameMisc = require("ClientData/ResMiniGameMisc")
local DEFAULT_WALL_PIC_PATH = "Drag/RearHouse/bizhi/hz_bizhi_default"
local EliminateDragWall = Class("EliminateDragWall")
local UP_OFFSET = Const.REARHOUSE_UP_OFFSET
local ROW = 69 + UP_OFFSET
local COLUMN = Const.MINIGAME_COLUMN

EliminateDragWall.ROW = ROW
EliminateDragWall.COLUMN = COLUMN

local MOVE_TIME = 1
local LEFT_OBJ_INDEX = 1

function EliminateDragWall:ctor(dragCenter, state, zoneName, index)
	self.inited = false
	self.mainState = state
	self.dragCenter = dragCenter
	self.zoneName = zoneName
	self.index = index
	self.zoneId = self.dragCenter.getZoneId(zoneName)
	self.csPanel = UIUtils.InitRearHouseDragCenter(self.zoneName, Slot(self.mCheckPos, self))
	self.transform = self.csPanel.transform
	self.objs = {}
	self.itemObjs = {}
	self.shelfObjs = {}
	self.finishObjs = {}
	self.curDragObj = nil
	self.rows = ROW
	self.limitRows = self.rows - 4
	self.columns = COLUMN
	self.gridSize = Const.REARHOUSE_GRID_SIZE
	self.shelfNodes = {}

	local traRoot = self.csPanel.transform.parent

	self:initRoot(traRoot)
	self.csPanel:SetGridCount(self.rows, self.columns, self.gridSize)
	self:initData()
	self:showBack(false)
	self:initWallNode()
	self:initModeNode()
	CueDataBank.initCueData("35002")

	self.inited = true
end

function EliminateDragWall:initRoot(traRoot)
	traRoot.position = Vector3(traRoot.position.x, traRoot.position.y - 1 * Const.REARHOUSE_GRID_SIZE, traRoot.position.z)
end

function EliminateDragWall:initData(...)
	self.bounds = {}

	local tra = self.csPanel.transform
	local xOffset = self.columns * self.gridSize * 0.5
	local yOffset = self.rows * self.gridSize * 0.5
	local leftUpPos = Vector2(tra.position.x + xOffset, tra.position.y + yOffset)
	local rightDownPos = Vector2(tra.position.x - xOffset, tra.position.y - yOffset)
	local edit = {}

	edit.leftUpPos = leftUpPos
	edit.rightDownPos = {}
	edit.rightDownPos.y = rightDownPos.y + 3.5 * self.gridSize
	edit.rightDownPos.x = rightDownPos.x
	self.bounds.edit = edit
	self.bounds.edit.z = tra.position.z
	self.dragCenter.bounds = self.bounds

	self:initCreation()
end

function EliminateDragWall:initCreation(...)
	local t = {}
	local oriWidth = self.bounds.edit.leftUpPos.x - self.bounds.edit.rightDownPos.x
	local oriHeight = self.bounds.edit.leftUpPos.y - self.bounds.edit.rightDownPos.y

	t.size = Vector2(oriWidth * 1.5, oriHeight * 1.5)
	t.lock = {}

	self.csPanel:InitCreation(t)
end

function EliminateDragWall:initWallNode()
	self.wallNodes = {}

	for i = 1, 5 do
		local wallName = Const.WALL_NODE_DEFAULT_NAME .. i
		local wallNode = UnityEngine.GameObject.Find(wallName)

		if wallNode then
			self.wallNodes[i] = wallNode
		end
	end
end

function EliminateDragWall:showWallNode()
	local wallNode = self.dragCenter.getWallNode()

	for i, node in ipairs(self.wallNodes or {}) do
		node.gameObject:SetActive(wallNode == i)
	end
end

function EliminateDragWall:initModeNode()
	self.modeNodes = {}
	self.allShelfNodes = {}
	self.allShelfLayerNodes = {}

	for i = Const.ELIMINATE_SHELF_NUM_MIN, Const.ELIMINATE_SHELF_NUM_MAX do
		local modeNodeName = Const.DEFAULT_MODE_NODE_NAME .. i
		local node = UnityEngine.GameObject.Find(modeNodeName)

		if node then
			self.modeNodes[i] = node
		end

		self.allShelfNodes[i] = {}
		self.allShelfLayerNodes[i] = {}

		for j = 1, i do
			local shelfName = modeNodeName .. "_row" .. j
			local shelfNode = UnityEngine.GameObject.Find(shelfName)

			if shelfNode then
				self.allShelfNodes[i][j] = shelfNode
			end

			self.allShelfLayerNodes[i][j] = {}

			for k = 1, Const.ELIMINATE_PUT_NUM_MAX do
				local nodeLayerName = shelfName .. "_" .. k
				local nodeLayer = UnityEngine.GameObject.Find(nodeLayerName)

				if nodeLayer then
					self.allShelfLayerNodes[i][j][k] = nodeLayer
				end
			end
		end
	end
end

function EliminateDragWall:showModeNode()
	for i, node in pairs(self.modeNodes) do
		node.gameObject:SetActive(i == self.shelfNum)
	end

	self.shelfNodes = self.allShelfNodes[self.shelfNum]
	self.shelfLayerNodes = self.allShelfLayerNodes[self.shelfNum]
end

function EliminateDragWall:resetLevelData()
	self.shelfNum = self.dragCenter.getShelfNum()
	self.shelfSize = self.dragCenter.getShelfSize()
	self.heroOffsetY = self.dragCenter.getHeroOffsetY()
	self.shelfFinishCueId = self.dragCenter.getShelfFinishCueId()
	self.shelfLayerHeight = self.shelfSize[2] / self.shelfNum

	self:showModeNode()
	self:showWallNode()
end

function EliminateDragWall:setWallTexture(url)
	if self.csPanel then
		if not url then
			if self.zoneId >= 10 then
				url = DEFAULT_WALL_PIC_PATH .. self.zoneId
			else
				url = DEFAULT_WALL_PIC_PATH .. "0" .. self.zoneId
			end

			self.wallTextureData = nil
		end

		url = DEFAULT_WALL_PIC_PATH .. "05"

		self.csPanel:SetWallTexture(url)
	end
end

function EliminateDragWall:showBack(v)
	if self.csPanel then
		self.csPanel:Show(v)
	end
end

function EliminateDragWall:mCheckPos(pos, eventName)
	if self.isShowing then
		return
	end

	if self.isMoveing then
		return
	end

	if eventName == "click" then
		self:circleChoose(pos)

		return
	end
end

function EliminateDragWall:setChooseShelfIndex(index)
	self.curChooseIndex = index

	local num = self:getCurShelfIndexObjNum(self.curChooseIndex)

	if num == 0 then
		return
	end

	local curObj = self.objs[self.curChooseIndex][num]

	if curObj.status == Const.ELIMINATE_STATUS_TYPE_LOCK then
		MsgManager.notice(Lang.get(100348))

		return
	end

	self.curChooseObjs = {}

	for i = num, 1, -1 do
		local obj = self.objs[self.curChooseIndex][i]

		if obj.modelId == curObj.modelId and obj.status ~= Const.ELIMINATE_STATUS_TYPE_LOCK then
			obj:setChooseState()
			table.insert(self.curChooseObjs, obj)
		else
			break
		end
	end
end

function EliminateDragWall:clearChooseShelfIndex()
	for _, obj in pairs(self.curChooseObjs or {}) do
		obj:clearChooseState()
	end

	self.curChooseObjs = {}
	self.curChooseIndex = nil
end

function EliminateDragWall:checkClickShelfIndex(pos)
	for index, node in pairs(self.shelfNodes) do
		if node then
			local nodePos = node.transform.localPosition

			if pos.x - nodePos.x >= -self.shelfSize[1] / 2 and pos.x - nodePos.x <= self.shelfSize[1] / 2 and pos.y - nodePos.y <= self.shelfSize[2] and pos.y - nodePos.y >= 0 then
				return index
			end
		end
	end

	return nil
end

function EliminateDragWall:circleChoose(pos)
	if self.isBoom then
		return
	end

	if not self.curChooseIndex then
		local index = self:checkClickShelfIndex(pos)

		if index then
			local isLock = self:isLockShelf(index)

			if isLock then
				MsgManager.notice(Lang.get(100058))

				return
			end

			self:setChooseShelfIndex(index)
		end
	else
		local curClickIndex = self:checkClickShelfIndex(pos)

		if curClickIndex then
			local isLock = self:isLockShelf(curClickIndex)

			if isLock then
				MsgManager.notice(Lang.get(100058))

				return
			end

			if curClickIndex == self.curChooseIndex then
				self:clearChooseShelfIndex()
			else
				local isCanMove = self:isCanMoveToShelf(curClickIndex)

				if not isCanMove then
					self:clearChooseShelfIndex()
					self:setChooseShelfIndex(curClickIndex)
				else
					self:moveChooseObjs(curClickIndex)
				end
			end
		end
	end
end

function EliminateDragWall:isLockShelf(curClickIndex)
	for i, shelfObj in pairs(self.shelfObjs) do
		if shelfObj.curShelfIndex == curClickIndex and shelfObj.isFinish == true then
			return true
		end
	end

	return false
end

function EliminateDragWall:isCanMoveToShelf(curClickIndex)
	local isCan = false
	local num = self:getCurShelfIndexObjNum(curClickIndex)

	if num == 0 then
		return true
	end

	if num >= Const.ELIMINATE_PUT_NUM_MAX then
		return false
	end

	local maxObj = self.objs[curClickIndex][num]

	if self.curChooseObjs[1] and self.curChooseObjs[1].modelId == maxObj.modelId then
		return true
	end

	return false
end

function EliminateDragWall:getShelfNode(shelfIndex)
	return self.shelfNodes[shelfIndex]
end

function EliminateDragWall:getShelfLayerNode(shelfIndex, posIndex)
	return self.shelfLayerNodes[shelfIndex][posIndex]
end

function EliminateDragWall:getPutPos(shelfIndex, posIndex)
	local nodePos = self.shelfNodes[shelfIndex].transform.localPosition
	local nodeLayer = self:getShelfLayerNode(shelfIndex, posIndex)
	local nodeLayerPos = nodeLayer.transform.localPosition
	local pos = nodePos

	pos.y = pos.y + nodeLayerPos.y

	return pos
end

function EliminateDragWall:moveChooseObjs(shelfIndex)
	self.isMoveing = true

	local canMoveNum = Const.ELIMINATE_PUT_NUM_MAX - self:getCurShelfIndexObjNum(shelfIndex)

	for i, obj in ipairs(self.curChooseObjs or {}) do
		if i <= canMoveNum then
			local putIndex = self:getCurShelfIndexObjNum(shelfIndex) + 1

			if putIndex <= Const.ELIMINATE_PUT_NUM_MAX then
				local newPos = self:getPutPos(shelfIndex, putIndex)
				local nodeLayer = self:getShelfLayerNode(shelfIndex, putIndex)

				obj:modelMoveToPos(newPos, nodeLayer, MOVE_TIME)

				self.objs[obj.curShelfIndex][obj.curPosIndex] = nil

				if not self.objs[shelfIndex] then
					self.objs[shelfIndex] = {}
				end

				self.objs[shelfIndex][putIndex] = obj
				obj.curShelfIndex = shelfIndex
				obj.curPosIndex = putIndex
			end
		end
	end

	self:clearChooseShelfIndex()

	self.coHandle = coroutine.start(self.handleMoveOverEvent, self, MOVE_TIME)
end

function EliminateDragWall:getCurShelfIndexObjNum(index)
	local num = 0

	for _, obj in pairs(self.objs[index] or {}) do
		if obj.type == Const.REARHOUSE_TYPE_HERO then
			num = num + 1
		end
	end

	return num
end

function EliminateDragWall:playPutVoice()
	if ResMiniGameMisc[1] and ResMiniGameMisc[1].put_voice then
		CueManager.playVocal(ResMiniGameMisc[1].put_voice)
	end
end

function EliminateDragWall:handleMoveOverEvent(time)
	coroutine.wait(time)

	if self.coHandle then
		coroutine.stop(self.coHandle)

		self.coHandle = nil
	end

	self:playPutVoice()

	self.isMoveing = false

	self:checkCanClearObj()
	self:findBoom()
end

function EliminateDragWall:findBoom()
	for i, itemObj in pairs(self.itemObjs) do
		if itemObj.status == Const.ELIMINATE_STATUS_TYPE_BOOM then
			itemObj.statusArg = itemObj.statusArg - 1

			itemObj:refreshNumInfo(itemObj.statusArg)

			if itemObj.statusArg <= 0 then
				local function callBack()
					local function yesFunc()
						self.dragCenter.resetLevel()
					end

					local msgContent = Lang.get(101434)

					UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, Lang.get(5), msgContent, yesFunc, Lang.get(104), nil)
				end

				self.isBoom = true

				itemObj:playItemDestoryAction(callBack)

				break
			end
		end
	end
end

function EliminateDragWall:findKeyAndLockObj(objs)
	self.curKeyObjs = {}
	self.curLockObjs = {}

	for i, obj in pairs(objs) do
		if obj.status == Const.ELIMINATE_STATUS_TYPE_KEY then
			local curClearKeyType = obj.statusArg

			for layer, tmpObjs in pairs(self.objs or {}) do
				for _, tmpObj in pairs(tmpObjs or {}) do
					if tmpObj.status == Const.ELIMINATE_STATUS_TYPE_LOCK and tmpObj.statusArg == curClearKeyType then
						tmpObj.status = Const.ELIMINATE_STATUS_TYPE_NONE

						for i, itemObj in pairs(self.itemObjs) do
							if itemObj.status == Const.ELIMINATE_STATUS_TYPE_KEY and itemObj.statusArg == curClearKeyType then
								local newPos = self:getPutPos(tmpObj.curShelfIndex, tmpObj.curPosIndex)

								itemObj._transform.parent = tmpObj._transform

								itemObj:moveToPos(newPos, nil, MOVE_TIME)
								table.insert(self.curKeyObjs, itemObj)

								self.itemObjs[i] = nil
							end

							if itemObj.status == Const.ELIMINATE_STATUS_TYPE_LOCK and itemObj.statusArg == curClearKeyType then
								table.insert(self.curLockObjs, itemObj)

								self.itemObjs[i] = nil
							end
						end

						break
					end
				end
			end
		end
	end

	if #self.curKeyObjs > 0 then
		self.coKeyMoveHandle = coroutine.start(self.keyMoveOverEvent, self, MOVE_TIME)
	end
end

function EliminateDragWall:keyMoveOverEvent(time)
	self.isShowing = true

	coroutine.wait(time)

	if self.coKeyMoveHandle then
		coroutine.stop(self.coKeyMoveHandle)

		self.coKeyMoveHandle = nil
	end

	self.isCallback = false

	local function callBack()
		if not self.isCallback then
			self.isCallback = true
			self.curKeyObjs = nil
			self.curLockObjs = nil

			local isCan = self:checkCanClearObj()

			if not isCan then
				self.isShowing = false
			end
		end
	end

	for i, obj in pairs(self.curKeyObjs or {}) do
		obj:playItemDestoryAction()
	end

	for i, obj in pairs(self.curLockObjs or {}) do
		obj:playItemDestoryAction(callBack)
	end
end

function EliminateDragWall:destoryBoom(objs)
	for _, obj in pairs(objs) do
		if obj.status == Const.ELIMINATE_STATUS_TYPE_BOOM then
			for i, itemObj in pairs(self.itemObjs) do
				if itemObj.status == Const.ELIMINATE_STATUS_TYPE_BOOM then
					itemObj:destroy()

					self.itemObjs[i] = nil
				end
			end
		end
	end
end

function EliminateDragWall:checkCanClearObj()
	for layer, objs in pairs(self.objs or {}) do
		local isSame = self:isAllSameShelfIndex(layer)

		if isSame then
			self:findKeyAndLockObj(objs)
			self:destoryBoom(objs)

			local showObjs = {}

			for _, obj in pairs(self.objs[layer] or {}) do
				if obj.type == Const.REARHOUSE_TYPE_HERO then
					table.insert(showObjs, obj)
					table.insert(self.finishObjs, obj)
				end
			end

			self:playModelVocalByType(showObjs[1], Const.HERO_VOCAL_UPGRADE)
			self:playComposeShow(showObjs)
			self:handleShelfFinishEvent(layer)

			return true
		end
	end

	return false
end

function EliminateDragWall:handleShelfFinishEvent(layer)
	for i, shelfObj in pairs(self.shelfObjs) do
		if shelfObj.curShelfIndex == layer then
			shelfObj.isFinish = true

			shelfObj:playShelfFinishEffect(self.shelfFinishCueId)
		end
	end
end

function EliminateDragWall:isAllSameShelfIndex(index)
	local num = self:getCurShelfIndexObjNum(index)

	if num < Const.ELIMINATE_PUT_NUM_MAX then
		return false
	end

	local curModel

	for _, obj in pairs(self.objs[index] or {}) do
		if obj.type == Const.REARHOUSE_TYPE_HERO then
			curModel = curModel or obj.modelId

			if curModel ~= obj.modelId or obj.status == Const.ELIMINATE_STATUS_TYPE_LOCK then
				return false
			end
		end
	end

	return true
end

function EliminateDragWall:isObjAllClear()
	for index, objs in pairs(self.objs or {}) do
		local num = self:getCurShelfIndexObjNum(index)

		if num > 0 then
			return false
		end
	end

	return true
end

function EliminateDragWall:playComposeShow(objs)
	self.isShowing = true

	local putData, initData

	for i, obj in pairs(objs) do
		if i == LEFT_OBJ_INDEX then
			putData = obj.putData
			initData = obj.initData
		end

		obj:playDestoryEffect()
	end

	self:delObj(objs, false)

	self.composeObj = self:_createObj(self, putData, initData)

	self.composeObj:loadModel(true, Functor(self.checkFinish, self, objs))
end

function EliminateDragWall:checkFinish(objs)
	local isAllClear = self:isObjAllClear()

	if isAllClear and not self.isFinish then
		self.isFinish = true

		self:playEndAvg()
	end

	for i, obj in pairs(objs) do
		obj:setVisible(true)
	end

	self.composeObj = nil
	self.isShowing = false
end

function EliminateDragWall:playModelVocalByType(obj, type)
	local heroId = obj:getHeroId()

	CueManager.playHeroVocal(heroId, type)
end

function EliminateDragWall:playEndAvg()
	local preAvgId, endAvgId = self.dragCenter.getPreAndEndAvgId()

	if endAvgId then
		self:setHideAllLogo(true)
		UIManager.playAVG(endAvgId, nil, Slot(self.sendRpcWin, self))
	else
		self:sendRpcWin()
	end
end

function EliminateDragWall:sendRpcWin()
	self.isPlayPreAvg = false

	local chapter, stage = CurAvatar:getChapterAndStage(Const.MINI_GAME_TYPE_ELIMINATE)

	RPC.relaxingGamePass(Const.MINI_GAME_TYPE[Const.MINI_GAME_TYPE_ELIMINATE], chapter, stage)
end

function EliminateDragWall:showPlane(obj, show, colorMode)
	if obj then
		obj:showPlane(show, colorMode)
	end
end

function EliminateDragWall:setHideAllLogo(v)
	for _, itemObj in pairs(self.itemObjs) do
		itemObj:setHideLogo(v)
	end
end

function EliminateDragWall:playPreAvg()
	local preAvgId = self.dragCenter.getPreAndEndAvgId()

	if preAvgId and not self.isPlayPreAvg then
		UIManager.playAVG(preAvgId, nil, Slot(self.endPreAvg, self))

		self.isPlayPreAvg = true
	else
		self:setHideAllLogo(false)
	end
end

function EliminateDragWall:endPreAvg()
	self:setHideAllLogo(false)
end

function EliminateDragWall:resetLoad(func)
	self:resetLevelData()

	self.isShowing = false
	self.isMoveing = false
	self.isFinish = false
	self.isBoom = false

	if func then
		func()
	end

	self:onInitObjsLoadEnd()
end

function EliminateDragWall:onInitObjsLoadEnd(...)
	local function func(...)
		for _, itemObj in pairs(self.itemObjs) do
			local shelfIndex = itemObj.curShelfIndex
			local posIndex = itemObj.curPosIndex
			local parentObj = self.objs[shelfIndex][posIndex]

			itemObj:setParentTra(parentObj._transform)
		end

		self:playPreAvg()
	end

	self.coInitObjs = coroutine.start(func)
end

function EliminateDragWall:addObj(datas)
	for i, data in ipairs(datas) do
		local putData = data.putData
		local initData = data.initData
		local obj = self:_createObj(self, putData, initData)

		obj.curShelfIndex = initData.shelfIndex
		obj.curPosIndex = initData.posIndex

		if obj.type == Const.REARHOUSE_TYPE_HERO then
			if not self.objs[initData.shelfIndex] then
				self.objs[initData.shelfIndex] = {}
			end

			self.objs[initData.shelfIndex][initData.posIndex] = obj
		elseif obj.type == Const.REARHOUSE_TYPE_SHELF then
			table.insert(self.shelfObjs, obj)
		else
			table.insert(self.itemObjs, obj)
		end

		obj:loadModel()
	end
end

function EliminateDragWall:_createObj(parent, putData, initData)
	if putData.data.typeId == 5 then
		return EliminateHero(BattleConst.SHOW_ACTOR_ID_START, "", parent, putData, initData)
	else
		return EliminateObject(BattleConst.SHOW_ACTOR_ID_START, "", parent, putData, initData)
	end
end

function EliminateDragWall:delObj(objs, needDestory)
	for i, obj in pairs(objs) do
		if obj then
			if needDestory then
				obj:onDel()
			end

			self.objs[obj.curShelfIndex][obj.curPosIndex] = nil
		end
	end

	return true
end

function EliminateDragWall:delAllObj(isForceAll, isIncludeStage)
	for layer, objs in pairs(self.objs) do
		for did, obj in pairs(objs) do
			if obj then
				obj:destroy()

				obj = nil
			end
		end
	end

	self.objs = {}

	for _, obj in pairs(self.itemObjs) do
		if obj then
			obj:destroy()

			obj = nil
		end
	end

	self.itemObjs = {}

	for _, obj in pairs(self.shelfObjs) do
		if obj then
			obj:destroy()

			obj = nil
		end
	end

	self.shelfObjs = {}

	for _, obj in pairs(self.finishObjs) do
		if obj then
			obj:destroy()

			obj = nil
		end
	end

	self.finishObjs = {}

	if self.composeObj then
		self.composeObj:destroy()

		self.composeObj = nil
	end
end

function EliminateDragWall:destroy(...)
	self:delAllObj()

	self.csPanel = nil
	self.inited = false

	if self.coInitObjs then
		coroutine.stop(self.coInitObjs)

		self.coInitObjs = nil
	end

	if self.transform and self.transform.parent then
		UnityEngine.Object.Destroy(self.transform.parent.gameObject)
	end

	self.transform = nil

	if self.battleTimer then
		self.battleTimer:Stop()

		self.battleTimer = nil
	end
end

return EliminateDragWall
