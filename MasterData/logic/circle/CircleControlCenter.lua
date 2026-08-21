-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Circle\\CircleControlCenter.lua

local DragUtils = Framework.Drag.DragUtils
local CircleGridModel = require("Logic/Circle/CircleGridModel")
local CirclePlayerModel = require("Logic/Circle/CirclePlayerModel")
local CircleCommonModel = require("Logic/Circle/CircleCommonModel")
local ResClanBattleMap = require("ClientData/ResClanBattleMap")
local ResClanGridType = require("ClientData/ResClanGridType")
local CircleBattlePlayerLogo = require("UI/Circle/CircleBattlePlayerLogo")
local CircleBattleGridLogo = require("UI/Circle/CircleBattleGridLogo")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ResClanBattleLayer = require("ClientData/ResClanBattleLayer")
local CircleControlCenter = {}
local self = CircleControlCenter
local GAP = 0.2
local SIZE = 2.2
local ROW = 10
local COL = 20
local END_MAP = {
	[81] = true,
	[101] = true
}
local SHOW_MODEL_TYPE = {
	FENCE = 2,
	TRAIN = 1
}
local EVENT_TYPE = {
	LOOK_TRAIN_GO = 11,
	MONSTER_KILLED = 2,
	LOOK_FENCE = 12,
	BOSS_KILLED = 3,
	OPEN_RUNE = 1,
	LOOK_TRAIN_OUT = 13,
	LOOK_WELCOME = 20
}
local PATH_CONFIG = {
	[SHOW_MODEL_TYPE.TRAIN] = {
		animator = "Drag/gonghuizhan/Animator/animator_huoche_01.controller",
		path = "Drag/gonghuizhan/Avatars/avatar_huoche_01"
	},
	[SHOW_MODEL_TYPE.FENCE] = {
		animator = "Drag/gonghuizhan/Animator/animator_luzhuang_01.controller",
		path = "Drag/gonghuizhan/Avatars/avatar_luzhuang_01"
	}
}

function CircleControlCenter.init(...)
	self.gridsData = {}
	self.heroModels = {}
	self.outHeroModels = {}
	self.girdModels = {}
	self.offLineBases = {}
	self.logoPool = {}
	self.cacheModels = {}
	self.onlyShowModels = {}
	self.msgs = {}
	self.cacheShowInfos = {}
	self.cacheOpenUI = {}
	self.startIndex = -1
	self.showLayer = 1
	self.bossIndex = -1
	self._isShowPlaying = false
	self.needLoadNum = 0
	self.loadedNum = 0
	self.cacheEvents = {}

	self._initScene()
	self.initCreate()
end

function CircleControlCenter.postInit(...)
	self.postInitCreate()

	self.inited = true
end

function CircleControlCenter.reset(...)
	if self.coShow then
		coroutine.stop(self.coShow)
	end

	self.startIndex = -1
	self.bossIndex = -1
	self.needLoadNum = 0
	self.loadedNum = 0
	self.msgs = {}
	self.cacheShowInfos = {}
	self.cacheEvents = {}
	self.eventId = nil

	self.clearLogos()
end

function CircleControlCenter._initScene(...)
	local root = UnityEngine.GameObject.Find("gonghuizhan_root")
	local go = DragUtils.CreateRayCheckGo("ClickField", root.transform)

	go.transform.localPosition = Vector3.zero
	go.layer = Const.LAYER_DRAG_FIELD

	local modelRoot = UnityEngine.GameObject("ModelRoot")

	modelRoot.transform.parent = root.transform
	modelRoot.transform.localPosition = Vector3(0, 0.05, 0.1)
	self.root = modelRoot

	local heroModelRoot = UnityEngine.GameObject("HeroModelRoot")

	heroModelRoot.transform.parent = root.transform
	heroModelRoot.transform.localPosition = Vector3(0, 0.05, 0.1)
	self.heroRoot = heroModelRoot

	local show_root = root.transform:Find("idle_show_root")

	if show_root then
		local name

		for i = 1, 20 do
			if i < 10 then
				name = "go0" .. i
			else
				name = "go" .. i
			end

			local tran = show_root:Find(name)

			if tran then
				table.insert(self.offLineBases, tran)
			end
		end
	end

	local h = COL * SIZE + (COL - 1) * GAP
	local v = ROW * SIZE + (ROW - 1) * GAP

	go.transform.localScale = Vector3(h, 0.1, v)
	self.leftUpPos = Vector2(self.root.transform.position.x + h * 0.5, self.root.transform.position.z - v * 0.5)
	self.rootPos = self.root.transform.position
end

function CircleControlCenter.changeLayer(...)
	local newSceneId = self.isSceneChanged()

	if newSceneId then
		local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

		if state then
			local ui = UIManager.getUI("circleBattleLoadingDlg", true)

			ui:setData(self.reEnter)
			ui:waitSceneLoadFinish()

			local function func(...)
				local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

				if state then
					state:backToNormalShow(0)
					state:changeToFarMode(0)
				end

				local ui = UIManager.tryGetUI("circleBattleLoadingDlg")

				if ui then
					ui:sceneLoadFinish()
				end
			end

			state:changeScene(newSceneId, func)
		end
	else
		UIManager.getUI("circleBattleLoadingDlg", true):setData(self.reEnter)

		local player = self.getPlayerModelByUid(CurAvatar.uid)

		if player then
			player:leaveTrain()
		end

		self._clearGridModels()

		self.cacheModels = {}

		for i, model in ipairs(self.outHeroModels) do
			if self.cacheModels[model.data.uid] then
				-- block empty
			else
				self.cacheModels[model.data.uid] = model

				model:reset()
			end
		end

		for uid, info in pairs(self.heroModels) do
			if not info or not info.model or self.cacheModels[info.model.data.uid] then
				-- block empty
			else
				self.cacheModels[info.model.data.uid] = info.model

				info.model:reset()
			end
		end

		for i, tran in ipairs(self.offLineBases) do
			if tran then
				tran.gameObject:SetActive(false)
			end
		end

		self.reset()

		self.outHeroModels = {}
		self.heroModels = {}

		self.initCreate()
		self.postInitCreate()

		local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

		if state then
			state:backToNormalShow(0)
			state:changeToFarMode(0)
		end

		CurAvatar:refreshCircleBattleMainShow()
	end
end

function CircleControlCenter.resetData(...)
	self.reset()

	self.outHeroModels = {}
	self.heroModels = {}

	self.initCreate()
	self.postInitCreate()

	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:backToNormalShow(0)
		state:changeToFarMode(0)
	end

	CurAvatar:refreshCircleBattleMainShow()
end

function CircleControlCenter.reEnter(...)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		local ui = UIManager.tryGetUI("circleBattleMainDlg")

		if ui then
			ui:onBtnZoomNearClick()
		else
			state:changeToNearMode()
		end
	end
end

function CircleControlCenter.initCreate()
	self.showLayer = self.getLayer()

	self._addGrids()
	self.checkAllGridOpen()
end

function CircleControlCenter.postInitCreate(...)
	self._addModels()
	self._addShowModel()
end

function CircleControlCenter._addGrids(gridList)
	if CurAvatar.myCircle then
		gridList = CurAvatar.myCircle:getGridData()
	end

	if gridList == nil then
		-- block empty
	end

	for i, info in ipairs(gridList or {}) do
		local type = self.getGridType(info.type)
		local typeInfo = ResClanGridType[type]

		if Const.CIRCLE_GRID_TYPE.START[info.type] then
			self.startIndex = i
		end

		if typeInfo then
			local row, col = self.indexToRowCol(i)

			if not self.gridsData[row] or not self.gridsData[row][col] then
				local model = CircleGridModel(info, i, self)

				self.needLoadNum = self.needLoadNum + 1

				table.insert(self.girdModels, model)

				for k = row, row + typeInfo.range[2] - 1 do
					for z = col, col + typeInfo.range[1] - 1 do
						local data = {
							type = i,
							grid = model
						}

						self.gridsData[k] = self.gridsData[k] or {}
						self.gridsData[k][z] = data
					end
				end
			end
		end
	end

	for i, model in ipairs(self.girdModels) do
		if model then
			model:createModel()
			model:checkCanOpenEffect(false)
			model:refreshMarkedEffect()
		end
	end
end

function CircleControlCenter._addModels(...)
	if CurAvatar.myCircle then
		local outUids = {}

		for _, member in ipairs(CurAvatar.myCircle:getMemberListForModel()) do
			if not self.heroModels[member.base.uid] then
				if member.base.uid == CurAvatar.uid or member.battle_data.oppos >= 0 then
					self._addSingleModel(member.base.uid, true)
				else
					table.insert(outUids, member.base.uid)
				end
			end
		end

		for i = #outUids, 1, -1 do
			self._addSingleModel(outUids[i], true)
		end
	end

	self._clearCachedModels()
end

function CircleControlCenter._addSingleModel(uid, isInit)
	if CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(uid)

		if member then
			local index = -1

			if not isInit then
				index = self.startIndex
			elseif member.battle_data.oppos >= 0 then
				local _index = self.getSuitableEndIndex(member.battle_data.oppos + 1, self.startIndex)

				if _index > 0 then
					index = _index
				end
			elseif member.base.uid == CurAvatar.uid then
				index = self.startIndex
			end

			local pos, angle

			if index == -1 then
				do return false end

				local num = utils.getTableElemCount(self.outHeroModels)

				if num < Const.CIRCLE_SHOW_MODEL_NUM then
					local tran = self.offLineBases[num + 1]

					if tran then
						tran.gameObject:SetActive(true)

						local _pos = tran.position

						pos = Vector3(_pos.x, _pos.y + 0.3, _pos.z)
					end
				else
					return false
				end
			else
				pos = self.indexToModelPos(index, true)
			end

			local modelId = 11101
			local baseId
			local modelData = member.battle_data.model

			if modelData then
				local hero = BaseObject.GetObject(modelData.resid)

				if hero then
					hero:setBase(modelData.base)
					hero:setSkin(modelData.skin)

					modelId = hero:getShowModelId()
					baseId = hero:getShowBaseModelId()
				end
			end

			local model, data

			if self.cacheModels[uid] then
				model = self.cacheModels[uid]
				data = model.data
				data.pos = pos
				self.cacheModels[uid] = nil
			end

			if not model then
				data = {
					type = Const.CIRCLE_COMMON_MODEL_TYPE.PLAYER,
					uid = uid,
					modelId = modelId,
					baseId = baseId,
					pos = pos,
					angle = angle
				}
				model = CirclePlayerModel(data, self)
			end

			model:setPos(pos)

			if index == -1 then
				table.insert(self.outHeroModels, model)
			else
				self.newPlayerModelIn(data.uid, index, model, member.battle_data.optype, member.battle_data.optick)
			end

			if isInit and member.battle_data.optype ~= Const.CIRCLE_PLAYER_STATE.NONE then
				local targetIndex = member.battle_data.oppos + 1
				local grid = self.getGridByIndex(targetIndex)

				if grid then
					grid:setOccupyUid(member.base.uid, true)
				end
			end
		end
	end
end

function CircleControlCenter._addShowModel(...)
	if not CurAvatar.myCircle then
		return
	end

	if not self.inited and next(self.onlyShowModels) == nil then
		self.onlyShowModels[SHOW_MODEL_TYPE.FENCE] = self.onlyShowModels[SHOW_MODEL_TYPE.FENCE] or {}

		for i = 1, 3 do
			local pos = Vector3(25.155 + (i - 1) * 1.5, -0.13, -0.19)

			table.insert(self.onlyShowModels[SHOW_MODEL_TYPE.FENCE], self._createCommonModel(pos, SHOW_MODEL_TYPE.FENCE))
		end

		self.onlyShowModels[SHOW_MODEL_TYPE.TRAIN] = self.onlyShowModels[SHOW_MODEL_TYPE.TRAIN] or {}

		local pos = Vector3(34.89, -7.48, -0.54)

		table.insert(self.onlyShowModels[SHOW_MODEL_TYPE.TRAIN], self._createCommonModel(pos, SHOW_MODEL_TYPE.TRAIN))
	else
		for type, list in pairs(self.onlyShowModels) do
			for _, model in ipairs(list or {}) do
				model:playAnimation("idle")
			end
		end

		self:checkInitShow(SHOW_MODEL_TYPE.TRAIN)
		self:checkInitShow(SHOW_MODEL_TYPE.FENCE)
	end
end

function CircleControlCenter._createCommonModel(pos, showType)
	local info = PATH_CONFIG[showType]

	if info then
		pos = self.localToWorldPos(pos)

		local data = {
			type = Const.CIRCLE_COMMON_MODEL_TYPE.OTHER,
			path = info.path,
			animator = info.animator,
			pos = pos,
			loadEndCB = Slot(self.checkInitShow, showType)
		}

		return CircleCommonModel(data, self)
	end
end

function CircleControlCenter.checkInitShow(showType)
	if self.inited and CurAvatar.myCircle then
		if showType == SHOW_MODEL_TYPE.TRAIN then
			if CurAvatar.myCircle:isBossDead(self.showLayer) then
				local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.TRAIN)

				if model then
					model:playAnimation("show")
				end
			end
		elseif showType == SHOW_MODEL_TYPE.FENCE then
			local data = CurAvatar.myCircle:getCurLayerConditionInfo()
			local left = data.totalBoxNum - data.boxNum

			for i = 1, data.boxNum do
				local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.FENCE, i)

				if model then
					model:playAnimation("hide_nosound")
				end
			end
		end
	end
end

function CircleControlCenter.newPlayerModelIn(uid, index, model, state, tick)
	self.heroModels[uid] = {
		model = model,
		index = index
	}

	self.uponGrid(uid, index, state)
end

function CircleControlCenter.move(uid, endIndex, targetIndex, endMap)
	local r, c = self.indexToRowCol(endIndex)
	local info = self.heroModels[uid]

	if info and info.model then
		local path = self.getMovePath(info.index, endIndex, endMap)

		if not info.model:isMoving() then
			if path and #path > 0 then
				endIndex = path[#path]
			end

			info.model:move(endIndex, path, targetIndex)
		end
	end
end

function CircleControlCenter.uponGrid(uid, index, tick)
	local info = self.heroModels[uid]

	if info then
		local curGrid = self.getGridByIndex(index)

		if curGrid then
			curGrid:onPlayerCome(uid, tick)
		end

		info.index = index
	end

	self.refreshPlayerState(uid)
end

function CircleControlCenter.leaveGrid(uid)
	local info = self.heroModels[uid]

	if info then
		local preIndex = info.index
		local preGrid = self.getGridByIndex(preIndex)

		if preGrid then
			preGrid:onPlayerGo(uid)
		end
	end
end

function CircleControlCenter.showModel(uid, v)
	if not v then
		local info = self.heroModels[uid]

		if info and info.model then
			info.model:showModel(v)
		end
	else
		if Const.CIRCLE_BATTLE_MAX_PLAYER_MODEL_NUM > 0 then
			local showNum = 0
			local optick = math.huge
			local lastUid

			for _uid, info in pairs(self.heroModels) do
				if uid ~= _uid and info and info.model and info.model:getVisible() then
					showNum = showNum + 1

					if _uid ~= CurAvatar.uid then
						local _tick = info.model:getPlayerOpTick()

						if _tick < optick then
							optick = _tick
							lastUid = _uid
						end
					end
				end
			end

			if showNum >= Const.CIRCLE_BATTLE_MAX_PLAYER_MODEL_NUM and lastUid then
				self.showModel(lastUid, false)
			end
		end

		local info = self.heroModels[uid]

		if info and info.model then
			info.model:showModel(v)
		end
	end
end

function CircleControlCenter.putMsg(uid, type, param)
	if not self.inited then
		return
	end

	if uid == CurAvatar.uid then
		local info = self.heroModels[uid]

		if info and info.model then
			info.model:onMsgNotify(type, param)
		end
	end
end

function CircleControlCenter.refreshPlayerState(uid)
	if not CurAvatar.myCircle then
		return
	end

	local member = CurAvatar.myCircle:getCircleMember(uid)

	if member then
		local state = member.battle_data.optype
		local info = self.heroModels[uid]

		if info then
			if info.model then
				info.model:refreshState(state)
			end

			if info.index then
				local grid = self.getGridByIndex(info.index)

				if grid then
					grid:refreshLogoState()
				end
			end
		end
	end
end

function CircleControlCenter.checkWelcome(eventId)
	if not GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		return
	end

	if CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

		if member and member.battle_data.oppos < 0 and self.checkLayer ~= self.getLayer() then
			self.checkLayer = self.getLayer()

			UIManager.getUI("circleBattleWelcomeDlg", true):setData(eventId)

			return
		end
	end
end

function CircleControlCenter.refreshModel(...)
	local info = self.heroModels[CurAvatar.uid]

	if info and info.model then
		info.model:refreshModel()
	end
end

function CircleControlCenter.checkOpenUI(name, ...)
	if name then
		local ui = UIManager.tryGetUI(name)

		if ui then
			table.insert(self.cacheOpenUI, {
				name = name,
				param = ...
			})
		else
			UIManager.getUI(name, true):setData(...)
		end
	else
		local info = self.cacheOpenUI[1]

		if info then
			table.remove(self.cacheOpenUI, 1)
			UIManager.getUI(info.name, true):setData(info.param)
		end
	end
end

function CircleControlCenter.isNeedShowBossPos(...)
	if self.bossIndex and CurAvatar.myCircle then
		local gridInfo = CurAvatar.myCircle:getGridInfo(self.bossIndex, self.getShowLayer())

		if gridInfo and gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and gridInfo.status ~= Const.CIRCLE_GRID_STATUS.OPEN then
			return self.indexToPos(self.bossIndex)
		end
	end
end

function CircleControlCenter.checkBossPos(...)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:checkBossPos()
	end
end

function CircleControlCenter.onGridLoaded(...)
	self.loadedNum = self.loadedNum + 1
end

function CircleControlCenter.isLoadFinish(...)
	if self.loadedNum < self.needLoadNum then
		return false
	end

	if not self._delayOk then
		self._delayOk = true

		return
	end

	self._delayOk = nil

	return true
end

function CircleControlCenter.getMyServerCheckPath(targetIndex)
	local checkPath = {}
	local info = self.heroModels[CurAvatar.uid]

	if info and info.model then
		local preOpPos = -1

		if CurAvatar.myCircle then
			local member = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

			if member then
				preOpPos = member.battle_data.oppos
			end
		end

		if preOpPos == -1 then
			checkPath[1] = self.startIndex - 1
		else
			checkPath[1] = preOpPos
			checkPath[2] = info.index - 1
		end

		local startIndex = self.getPlayerIndex(CurAvatar.uid)
		local endIndex, endMap = self.getSuitableEndIndex(targetIndex, startIndex)
		local path = self.getMovePath(info.index, endIndex, endMap)

		if path and #path > 0 then
			for i, index in ipairs(path) do
				table.insert(checkPath, index - 1)
			end
		end
	end

	if #checkPath > 0 then
		return {
			path_pos = checkPath
		}
	end
end

function CircleControlCenter.getEndGridServerCheckPath(...)
	local endIndex = next(END_MAP)

	if endIndex then
		local data = self.getMyServerCheckPath(endIndex)

		if data then
			table.insert(data.path_pos, endIndex - 1)
		end

		return data
	end
end

function CircleControlCenter.getEndGridServerCheckIndex(...)
	for i, _ in pairs(END_MAP) do
		local nearMap = self.getNearIndexs(i)

		if nearMap then
			for index, _ in pairs(nearMap) do
				local grid = self.getGridByIndex(index)

				if not grid:isEndGrid() and grid:isOpen() then
					return i - 1
				end
			end
		end
	end
end

function CircleControlCenter.getAngle(vec1, vec2)
	local angle = Vector3.Angle(vec2, vec1)
	local vec = Vector3.Cross(vec2, vec1)
	local a = vec.y > 0 and angle or -angle

	return a
end

function CircleControlCenter.getPlayerModelByUid(uid)
	local info = self.heroModels[uid]

	if info then
		return info.model
	end
end

function CircleControlCenter.getEndPos(...)
	local endIndex = next(END_MAP)

	if endIndex then
		local grid = self.getGridByIndex(endIndex)

		if grid then
			return grid.pos
		end
	end
end

function CircleControlCenter.getPlayerMoveEndStamp(uid)
	local info = self.heroModels[uid]

	if info and info.model then
		return info.model:getMoveEndStamp()
	end
end

function CircleControlCenter.setBossIndex(index)
	self.bossIndex = index
end

function CircleControlCenter.isBossShowing(...)
	if CurAvatar.myCircle then
		local gridInfo = CurAvatar.myCircle:getGridInfo(self.bossIndex)

		if gridInfo and gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and gridInfo.status == Const.CIRCLE_GRID_STATUS.SHOW then
			return true
		end
	end
end

function CircleControlCenter.isPlayerMoving(uid)
	local info = self.heroModels[uid]

	if info and info.model then
		return info.model:isMoving()
	end
end

function CircleControlCenter.isGridOccupyUid(layer, index)
	if layer ~= self.getShowLayer() then
		return nil
	end

	local grid = self.getGridByIndex(index)

	if grid then
		return grid:getOccupyUid()
	end
end

function CircleControlCenter.canChangeLayer(...)
	if not CurAvatar.myCircle then
		return false
	end

	if not self.isAllConnect() then
		return false, ClientUtils.getClientNotice(516)
	end

	if not CurAvatar.myCircle:isBossDead(self.showLayer) then
		return false, ClientUtils.getClientNotice(517)
	end

	if not CurAvatar.myCircle:isAllBoxFound(self.showLayer) then
		return false, ClientUtils.getClientNotice(518)
	end

	return true
end

function CircleControlCenter.getLogo(logoType, target)
	local logo

	if not logo then
		if logoType == Const.CIRCLE_LOGO_TYPE.PLAYER then
			logo = CircleBattlePlayerLogo(nil, "System/CircleBattle/CircleBattleLogo", 0, 0)
		else
			logo = CircleBattleGridLogo(nil, "System/CircleBattle/CircleBattleSceneLogo", 0, 0)
		end

		if self.logoPool[logo.id] then
			self.returnLogo(self.logoPool[logo.id])
		end

		self.logoPool[logo.id] = logo
	end

	logo:setTarget(target)
	logo:setHide(false)

	return logo
end

function CircleControlCenter.returnLogo(logo)
	if logo then
		if logo.id then
			self.logoPool[logo.id] = nil
		end

		logo:destroy()
	end
end

function CircleControlCenter.showAllLogos(v)
	for i, logo in pairs(self.logoPool) do
		if logo then
			logo:setHide(not v)
		end
	end
end

function CircleControlCenter.showAllPlayerModels(v)
	if not tolua.isnull(self.heroRoot) then
		self.heroRoot:SetActive(v)
	end
end

function CircleControlCenter.getRootPos(...)
	if self.rootPos then
		return self.rootPos
	end

	return Vector3.zero
end

function CircleControlCenter.focusOnMe(duration)
	self.focusOnIndex(self.getPlayerIndex(CurAvatar.uid), duration)
end

function CircleControlCenter.focusOnIndex(index, duration)
	local pos = self.indexToPos(index)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state then
		state:focusOnPos(pos, duration or 2)
	end
end

function CircleControlCenter.isAllConnect()
	if CurAvatar.myCircle then
		for index, _ in pairs(END_MAP) do
			local indexs = self.getNearIndexs(index)

			for i, _ in pairs(indexs) do
				local info = CurAvatar.myCircle:getGridInfo(i)

				if info and info.status == Const.CIRCLE_GRID_STATUS.OPEN and info.type ~= Const.CIRCLE_GRID_OPEN_TYPE.HINDER then
					return true
				end
			end
		end
	end
end

function CircleControlCenter.checkPlayerModel(uid)
	local info = self.heroModels[uid]

	if info and info.model then
		-- block empty
	else
		local isOut = false

		for i, model in ipairs(self.outHeroModels) do
			if model and model.data.uid == uid then
				isOut = true

				self.newPlayerModelIn(uid, self.startIndex, model, Const.CIRCLE_PLAYER_STATE.NONE, ClientUtils.getServerTime())

				local pos = self.indexToModelPos(self.startIndex, true)

				model:setPos(pos)
				table.remove(self.outHeroModels, i)

				break
			end
		end

		if not isOut then
			self._addSingleModel(uid, false)
		end
	end
end

function CircleControlCenter.isPlayerOnGrid(index)
	for uid, info in pairs(self.heroModels) do
		if info.index == index and not info.model:isMoving() then
			return uid
		end
	end

	return nil
end

function CircleControlCenter.getModelCurIndex(uid)
	local info = self.heroModels[uid]

	if info then
		return info.index
	end

	return -1
end

function CircleControlCenter.getNearIndexs(index)
	local map = {}
	local r, c = self.indexToRowCol(index)

	for i = -1, 1 do
		for j = -1, 1 do
			local _r, _c = r + i, c + j

			if i * j == 0 and self.checkRC(_r, _c) then
				local _index = self.rowColToIndex(_r, _c)

				if index ~= _index then
					map[_index] = true
				end
			end
		end
	end

	return map
end

function CircleControlCenter.getPlayerIndex(uid)
	local info = self.heroModels[uid]

	if info then
		return info.index
	end

	return self.startIndex
end

function CircleControlCenter.getRootTran(...)
	if not tolua.isnull(self.root) then
		return self.root.transform
	end
end

function CircleControlCenter.getHeroRootTran(...)
	if not tolua.isnull(self.heroRoot) then
		return self.heroRoot.transform
	end
end

function CircleControlCenter.getGridByRC(r, c)
	if self.checkRC(r, c) and self.gridsData[r] and self.gridsData[r][c] then
		local grid = self.gridsData[r][c].grid

		return grid
	end
end

function CircleControlCenter.getGridByIndex(index)
	local r, c = self.indexToRowCol(index)

	if self.checkRC(r, c) then
		return self.getGridByRC(r, c)
	end
end

function CircleControlCenter.getGridType(type)
	if Const.CIRCLE_GRID_TYPE.SPACE[type] or Const.CIRCLE_GRID_TYPE.STATUE[type] or Const.CIRCLE_GRID_TYPE.START[type] or Const.CIRCLE_GRID_TYPE.END[type] then
		return type
	else
		return 0
	end
end

function CircleControlCenter.getLayer(...)
	if CurAvatar.myCircle then
		return CurAvatar.myCircle:getCurBattleLayer()
	end

	return 1
end

function CircleControlCenter.getShowLayer(...)
	return self.showLayer or self:getLayer()
end

function CircleControlCenter.isLayerChange(...)
	return self.showLayer ~= self.getLayer()
end

function CircleControlCenter.isSceneChanged(...)
	local showLayer = self.getShowLayer()
	local newLayer = self.getLayer()

	if showLayer ~= newLayer and ResClanBattleLayer[showLayer].scene_id ~= ResClanBattleLayer[newLayer].scene_id then
		return ResClanBattleLayer[newLayer].scene_id
	end
end

function CircleControlCenter.getSuitableEndIndex(targetIndex, startIndex)
	local nearMap = self.getNearIndexs(targetIndex)

	if nearMap and next(nearMap) ~= nil then
		local endMap = {}
		local endIndex = -1
		local minDis = math.huge

		for i, _ in pairs(nearMap) do
			local nGrid = self.getGridByIndex(i)

			if nGrid and nGrid:isOpen() then
				if startIndex == i then
					endIndex = startIndex

					break
				end

				local path = self.getMovePath(startIndex, i)

				if path then
					if minDis > #path then
						endIndex = i
						minDis = #path
					end

					endMap[i] = true
				end
			end
		end

		return endIndex, endMap
	end
end

function CircleControlCenter._getStraightDis(startIndex, endIndex)
	local sr, sc = self.indexToRowCol(startIndex)
	local er, ec = self.indexToRowCol(endIndex)

	return (sr - er)^2 + (sc - ec)^2
end

function CircleControlCenter.getMovePath(startIndex, endIndex, endMap)
	local openMap = {}
	local closeMap = {}
	local t = self._wrapIndex(startIndex, startIndex, endIndex)

	openMap[startIndex] = t

	local minPoint

	while next(openMap) ~= nil do
		minPoint = nil

		for i, info in pairs(openMap) do
			if minPoint == nil then
				minPoint = info
			elseif minPoint.f > info.f then
				minPoint = info
			end
		end

		if minPoint.index == endIndex then
			break
		elseif endMap ~= nil and endMap[minPoint.index] then
			break
		end

		openMap[minPoint.index] = nil
		closeMap[minPoint.index] = minPoint

		local nearMap = self.getNearIndexs(minPoint.index)

		for index, info in pairs(nearMap) do
			if openMap[index] then
				local t = openMap[index]
				local offsetG = self._getGH(minPoint.index, index, index)
				local startG = t.g

				if startG > minPoint.g + offsetG then
					t.g = minPoint.g + offsetG
					t.f = t.g + t.h
					t.parent = minPoint
				end
			elseif CurAvatar.myCircle then
				local gridInfo = CurAvatar.myCircle:getGridInfo(index)
				local isAdd = false

				if not closeMap[index] and gridInfo then
					if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.HINDER then
						-- block empty
					elseif gridInfo.status ~= Const.CIRCLE_GRID_STATUS.OPEN then
						if Const.CIRCLE_GRID_TYPE.START[gridInfo.type] then
							isAdd = true
						end
					else
						isAdd = true
					end

					if isAdd then
						local t = self._wrapIndex(index, startIndex, endIndex, minPoint)

						openMap[index] = t

						local offsetG = self._getGH(minPoint.index, index, index)

						t.g = minPoint.g + offsetG
						t.f = t.g + t.h
					end
				end
			end
		end
	end

	if minPoint.index == endIndex or endMap ~= nil and endMap[minPoint.index] then
		local path = {}

		while minPoint.parent do
			table.insert(path, 1, minPoint.index)

			minPoint = minPoint.parent
		end

		return path
	end
end

function CircleControlCenter._wrapIndex(index, startIndex, endIndex, parent)
	local g, h = self._getGH(index, startIndex, endIndex)

	return {
		index = index,
		g = g,
		h = h,
		f = g + h,
		parent = parent
	}
end

function CircleControlCenter._getGH(index, startIndex, endIndex)
	local nr, nc = self.indexToRowCol(index)
	local sr, sc = self.indexToRowCol(startIndex)
	local er, ec = self.indexToRowCol(endIndex)

	return math.abs(nr - sr) + math.abs(nc - sc), math.abs(nr - er) + math.abs(nc - ec)
end

function CircleControlCenter.getReachIndexs(startIndex)
	startIndex = startIndex or self.startIndex

	local openMap = {}
	local closeMap = {}

	openMap[startIndex] = true

	local target = next(openMap)

	while target do
		local nearMap = self.getNearIndexs(target)

		for index, _ in pairs(nearMap) do
			if openMap[index] or closeMap[index] then
				-- block empty
			else
				local grid = self.getGridByIndex(index)

				if grid:isOpen() then
					openMap[index] = true
				end
			end
		end

		openMap[target] = nil
		closeMap[target] = true
		target = next(openMap)
	end

	return closeMap
end

function CircleControlCenter.getAllLodModels(...)
	local models = {}

	for uid, info in pairs(self.heroModels) do
		table.insert(models, info.model)
	end

	return models
end

function CircleControlCenter.checkMove(uid, targetIndex)
	self.checkPlayerModel(uid)

	local startIndex = self.getPlayerIndex(uid)
	local endIndex, endMap = self.getSuitableEndIndex(targetIndex, startIndex)

	self.move(uid, endIndex, targetIndex, endMap)
end

function CircleControlCenter.showMyLogoAni(...)
	local playerModel = self.getPlayerModelByUid(CurAvatar.uid)

	if playerModel then
		playerModel:showMyLogoAni()
	end
end

function CircleControlCenter.addEvent(eventType, eventData)
	self.eventId = self.eventId or 1
	self.eventId = self.eventId + 1

	local info = {
		isShowing = false,
		id = self.eventId,
		eventType = eventType,
		eventData = eventData
	}
	local insertIndex = 1
	local isJump = false

	if #self.cacheEvents > 0 then
		for i, data in ipairs(self.cacheEvents) do
			if info.eventType == data.eventType and info.eventType == EVENT_TYPE.LOOK_FENCE then
				if data.isShowing then
					isJump = true

					self.lookFenceShow(info.id, false, info.eventData.boxNum)
				else
					self.lookFenceShow(data.id, false, data.eventData.boxNum)
				end
			end

			if info.eventType < data.eventType then
				break
			end

			insertIndex = i + 1
		end
	end

	if not isJump then
		if insertIndex > #self.cacheEvents then
			table.insert(self.cacheEvents, info)
		else
			table.insert(self.cacheEvents, insertIndex, info)
		end
	end

	self.checkEvent()
end

function CircleControlCenter.checkEvent(id)
	if not self.inited then
		return
	end

	if id then
		local removeIndex = -1

		for i, info in ipairs(self.cacheEvents) do
			if id == info.id then
				removeIndex = i
			end
		end

		if removeIndex > 0 then
			table.remove(self.cacheEvents, removeIndex)
		end
	end

	for i, info in ipairs(self.cacheEvents) do
		if info.isShowing then
			return
		end
	end

	if not self.coEvent then
		self.coEvent = coroutine.start(function(...)
			coroutine.step()

			local info = self.cacheEvents[1]

			if info then
				self.sendEvent(info)
			end

			self.coEvent = nil
		end)
	end
end

function CircleControlCenter.sendEvent(info)
	if not GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		return
	end

	local ui = UIManager.tryGetUI("circleBattleHeroListDlg")

	if ui then
		return
	end

	if CurAvatar.myCircle then
		local battleData = CurAvatar.myCircle:getMyBattleMemberData()

		if battleData and battleData.optype == Const.CIRCLE_PLAYER_STATE.FORMATION then
			return
		end
	end

	info.isShowing = true

	if info.eventType == EVENT_TYPE.OPEN_RUNE then
		UIManager.getUI("circleBattleRuneTipDlg", true):setData(info.eventData, info.id)
	elseif info.eventType == EVENT_TYPE.LOOK_FENCE then
		if info.eventData.uid == CurAvatar.uid then
			if not self.isInAiTest then
				UIManager.getUI("circleBattleBoxDlg", true):setData(function(...)
					self.lookFenceShow(info.id, true, info.eventData.boxNum)
				end)
			else
				self.lookFenceShow(info.id, false, info.eventData.boxNum)
			end
		elseif not self.isInAiTest then
			UIManager.getUI("circleBattleConfirmDlg", true):setData(info.eventData, function(isLook)
				self.lookFenceShow(info.id, isLook, info.eventData.boxNum)
			end)
		else
			self.lookFenceShow(info.id, false, info.eventData.boxNum)
		end
	elseif info.eventType == EVENT_TYPE.LOOK_TRAIN_OUT then
		if info.eventData.uid == CurAvatar.uid then
			self.lookTrainOutShow(info.id, true)
		elseif not self.isInAiTest then
			UIManager.getUI("circleBattleConfirmDlg", true):setData(info.eventData, function(isLook)
				self.lookTrainOutShow(info.id, isLook)
			end)
		else
			self.lookTrainOutShow(info.id, false)
		end
	elseif info.eventType == EVENT_TYPE.LOOK_TRAIN_GO then
		if info.eventData.uid == CurAvatar.uid then
			self.lookTrainGoShow(info.id)
		elseif not self.isInAiTest then
			UIManager.getUI("circleBattleConfirmDlg", true):setData(info.eventData, function(isLook)
				self.lookTrainGoShow(info.id, isLook)
			end)
		else
			self.lookTrainGoShow(info.id, true)
		end
	elseif info.eventType == EVENT_TYPE.MONSTER_KILLED then
		UIManager.getUI("circleBattleKillMonsterEfxDlg", true):setData(info.id)
	elseif info.eventType == EVENT_TYPE.BOSS_KILLED then
		UIManager.getUI("circleBattleKillBossEfxDlg", true):setData(info.id)
	elseif info.eventType == EVENT_TYPE.LOOK_WELCOME then
		self.checkWelcome(info.id)
	end
end

function CircleControlCenter.addOpenRuneEvent(data)
	self.addEvent(EVENT_TYPE.OPEN_RUNE, data)
end

function CircleControlCenter.addOpenBoxEvent(data, forceAdd)
	if forceAdd then
		self.addEvent(EVENT_TYPE.LOOK_FENCE, data)
	elseif data.uid == CurAvatar.uid then
		local grid = self.getGridByIndex(data.index)

		if grid then
			grid:setBoxData(data)
		end
	else
		self.addEvent(EVENT_TYPE.LOOK_FENCE, data)
	end
end

function CircleControlCenter.addBossKilledEvent(data)
	self.addEvent(EVENT_TYPE.LOOK_TRAIN_OUT, data)
end

function CircleControlCenter.addChangeLayerEvent(data)
	self.addEvent(EVENT_TYPE.LOOK_TRAIN_GO, data)
end

function CircleControlCenter.addBossKilledByMeEvent(data)
	self.addEvent(EVENT_TYPE.BOSS_KILLED, data)
end

function CircleControlCenter.addMonsterKilledByMeEvent(data)
	self.addEvent(EVENT_TYPE.MONSTER_KILLED, data)
end

function CircleControlCenter.addLookWelcomeEvent(data)
	self.addEvent(EVENT_TYPE.LOOK_WELCOME, data)
end

function CircleControlCenter.checkAddToBossKilledShow(gridInfo, index, uid, isBossKilled)
	self.checkEndGridShow(uid)

	if not CurAvatar.myCircle or not isBossKilled then
		return
	end

	if gridInfo.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local info

		if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			info = {
				uid = uid,
				index = index,
				type = Const.CIRCLE_BATTLE_SHOW_TYPE.BOSS
			}

			self.addBossKilledEvent(info)
		end
	end
end

function CircleControlCenter.checkBoxOpen(gridInfo, index, uid)
	self.checkEndGridShow(uid)

	if not CurAvatar.myCircle then
		return
	end

	if gridInfo.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local info

		if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOX then
			local data = CurAvatar.myCircle:getCurLayerConditionInfo()

			info = {
				uid = uid,
				index = index,
				type = Const.CIRCLE_BATTLE_SHOW_TYPE.BOX,
				boxNum = data.boxNum,
				totalBoxNum = data.totalBoxNum
			}

			self.addOpenBoxEvent(info)
		end
	end
end

function CircleControlCenter.checkEndGridShow(uid)
	if self.canChangeLayer() then
		local endIndex = next(END_MAP)
		local grid = self.getGridByIndex(endIndex)

		if grid then
			grid:playShow(nil, uid)
		end
	end
end

function CircleControlCenter.AddToEndShow(uid)
	local index = next(END_MAP)
	local info = {
		uid = uid,
		index = index,
		type = Const.CIRCLE_BATTLE_SHOW_TYPE.END
	}

	self.addChangeLayerEvent(info)
end

function CircleControlCenter.lookFenceShow(eventId, isLook, index)
	self.coPlayerShowNew(Const.CIRCLE_BATTLE_SHOW_TYPE.BOX, eventId, isLook, index)
end

function CircleControlCenter.lookTrainOutShow(eventId, isLook)
	self.coPlayerShowNew(Const.CIRCLE_BATTLE_SHOW_TYPE.BOSS, eventId, isLook)
end

function CircleControlCenter.lookTrainGoShow(eventId)
	self.coPlayerShowNew(Const.CIRCLE_BATTLE_SHOW_TYPE.END, eventId, true)
end

function CircleControlCenter.onShowOver(eventId)
	self._isShowPlaying = false

	self.checkEvent(eventId)
end

function CircleControlCenter.checkAllGridOpen(...)
	if CurAvatar.myCircle then
		local isAllOpen = CurAvatar.myCircle:isDebuffWork()

		if isAllOpen then
			for i, grid in ipairs(self.girdModels) do
				if grid then
					grid:checkShowMonsterWeakEffect(true)
				end
			end
		end
	end
end

function CircleControlCenter.coPlayerShowNew(showType, eventId, isLook, index)
	if isLook then
		local ui = UIManager.tryGetUI("circleBattleMainDlg")

		if ui then
			ui:enableOpration(false)
			ui:showDlg(false)
		end
	else
		local ui = UIManager.tryGetUI("circleBattleMainDlg")

		if ui then
			ui:showProcessAni(showType ~= Const.CIRCLE_BATTLE_SHOW_TYPE.END)
		end
	end

	local function _showEnd(...)
		local ui = UIManager.tryGetUI("circleBattleMainDlg")

		if ui then
			ui:enableOpration(true)

			if isLook then
				ui:showDlg(true)
			end

			ui:showProcessAni(showType ~= Const.CIRCLE_BATTLE_SHOW_TYPE.END and isLook)
			ui:onCameraShowEnd()
		end

		self.onShowOver(eventId)
	end

	self.coShow = coroutine.start(function(...)
		if isLook then
			local ui = UIManager.tryGetUI("circleBattleMainDlg")

			if ui then
				ui:onCameraShowStart()
			end

			if showType == Const.CIRCLE_BATTLE_SHOW_TYPE.END then
				local endIndex = next(END_MAP)

				self.focusOnIndex(endIndex, 1.5)
				coroutine.wait(0.5)

				local player = self.getPlayerModelByUid(CurAvatar.uid)

				if player then
					player:showOnEndGrid()
				end

				coroutine.wait(1.2)

				local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)
				local time = 0

				if state then
					time = state:lookEndShowAni1()
				end

				coroutine.wait(time)
			else
				coroutine.wait(0.3)

				local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

				if state then
					state:lookEndShow()
				end

				coroutine.wait(2)
			end
		end

		if showType == Const.CIRCLE_BATTLE_SHOW_TYPE.BOSS then
			local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.TRAIN)

			self.coPlayTrainOut(model, _showEnd, isLook)
		elseif showType == Const.CIRCLE_BATTLE_SHOW_TYPE.END then
			local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.TRAIN)

			self.coPlayTrainGo(model, _showEnd, isLook)
		elseif showType == Const.CIRCLE_BATTLE_SHOW_TYPE.BOX then
			local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.FENCE, index)

			self.coPlayFence(model, _showEnd, isLook)
		end
	end)
end

function CircleControlCenter.coPlayShow(info, isLook)
	self.coShow = coroutine.start(function(...)
		local showType = info.type

		self._isShowPlaying = true

		if isLook then
			if showType == Const.CIRCLE_BATTLE_SHOW_TYPE.END then
				local endIndex = next(END_MAP)

				self.focusOnIndex(endIndex, 1.5)
				coroutine.wait(0.5)

				local player = self.getPlayerModelByUid(CurAvatar.uid)

				if player then
					player:showOnEndGrid()
				end

				coroutine.wait(1)

				local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)
				local time = 0

				if state then
					time = state:lookEndShowAni1()
				end

				coroutine.wait(time)
			else
				local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

				if state then
					state:lookEndShow()
				end
			end

			coroutine.wait(1.5)
		end

		if showType == Const.CIRCLE_BATTLE_SHOW_TYPE.BOSS then
			local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.TRAIN)

			self.coPlayTrainOut(model, _showEnd)
		elseif showType == Const.CIRCLE_BATTLE_SHOW_TYPE.END then
			local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.TRAIN)

			self.coPlayTrainGo(model, _showEnd)
		elseif showType == Const.CIRCLE_BATTLE_SHOW_TYPE.BOX then
			local model = self.getOnlyShowModel(SHOW_MODEL_TYPE.FENCE, info.boxNum)

			self.coPlayFence(model, _showEnd)
		end
	end)
end

function CircleControlCenter.getOnlyShowModel(type, index)
	index = index or 1

	local list = self.onlyShowModels[type]

	if list and index <= #list then
		local model = list[index]

		return model
	end
end

function CircleControlCenter.coPlayTrainOut(model, endCB, isLook)
	if model then
		model:playEffect("Effects/Scene/efx_ghz_zhuomian_13_01.prefab", "Dummy009")
		model:playAnimation("show")
		coroutine.wait(4)

		if isLook and GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
			local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

			if state then
				state:backToNormalShow(1.5)
			end

			coroutine.wait(2)
		end
	end

	if endCB then
		endCB()
	end
end

function CircleControlCenter.coPlayTrainGo(model, endCB, isLook)
	if model then
		coroutine.wait(0.5)

		local player = self.getPlayerModelByUid(CurAvatar.uid)

		if player then
			player:showOnTrain(model)
		end

		coroutine.wait(1)
		model:playEffect("Effects/Scene/efx_ghz_zhuomian_13_01.prefab", "Dummy009")
		model:playAnimation("hide")
		coroutine.wait(5)
	end

	if self.isLayerChange() then
		self.changeLayer()
	end

	if endCB then
		endCB()
	end
end

function CircleControlCenter.coPlayFence(model, endCB, isLook)
	if model then
		model:playAnimation("hide")
		coroutine.wait(0.5)
		model:playEffect("Effects/Scene/efx_ghz_zhuomian_12.prefab", "")
		coroutine.wait(2)
	end

	if isLook and GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

		if state then
			state:backToNormalShow(1.5)
		end

		coroutine.wait(2)
	end

	if endCB then
		endCB()
	end
end

function CircleControlCenter.isShowPlaying(...)
	return self._isShowPlaying
end

function CircleControlCenter.onOccupyGrid(uid, layer, targetIndex, preOpPos)
	if not self.inited or self.getShowLayer() ~= layer then
		return
	end

	self.checkMove(uid, targetIndex, preOpPos)

	local grid = self.getGridByIndex(targetIndex)

	if grid then
		grid:setOccupyUid(uid, true)
	end
end

function CircleControlCenter.onOpenGrid(uid, layer, index, refreshList, extraData)
	if not self.inited or self.getShowLayer() ~= layer then
		return
	end

	if CurAvatar.myCircle then
		local gridInfo = CurAvatar.myCircle:getGridInfo(index)
	end

	local grid = self.getGridByIndex(index)

	if grid then
		if CurAvatar.myCircle then
			local gridInfo = CurAvatar.myCircle:getGridInfo(index)

			if gridInfo then
				grid:refreshInfo(gridInfo, false, uid)
			end
		end

		grid:setOccupyUid(uid, false)
	end

	local openNum = 0

	if refreshList then
		for _, i in ipairs(refreshList) do
			local gridInfo = CurAvatar.myCircle:getGridInfo(i)

			if gridInfo.status == Const.CIRCLE_GRID_STATUS.OPEN or gridInfo.status == Const.CIRCLE_GRID_STATUS.SHOW then
				openNum = openNum + 1
			end

			local grid = self.getGridByIndex(i)

			if CurAvatar.myCircle and grid and gridInfo then
				if i ~= index then
					grid:refreshInfo(gridInfo, false, uid)
				end

				self.checkBoxOpen(gridInfo, i, uid)
			end
		end
	end

	if uid == CurAvatar.uid and openNum > 1 and extraData.isCrit then
		local ui = UIManager.tryGetUI("circleBattleMainDlg")

		if ui then
			ui:showLuckAni(2)
		end
	end

	self.checkAllGridOpen()
end

function CircleControlCenter.onCancelGrid(uid, layer, targetIndex)
	if not self.inited or self.getShowLayer() ~= layer then
		return
	end

	if uid == CurAvatar.uid then
		MsgManager.clientNotice(520)
	end

	local grid = self.getGridByIndex(targetIndex)

	if grid then
		grid:setOccupyUid(uid, false)
	end
end

function CircleControlCenter.onOccupyMonster(uid, layer, targetIndex, preOpPos)
	if not self.inited or self.getShowLayer() ~= layer then
		return
	end

	local grid = self.getGridByIndex(targetIndex)

	if grid then
		grid:setOccupyUid(uid, true)
	end

	self.checkMove(uid, targetIndex, preOpPos)
end

function CircleControlCenter.onCancelOccupyMonster(uid, layer, targetIndex)
	if not self.inited or self.getShowLayer() ~= layer then
		return
	end

	local grid = self.getGridByIndex(targetIndex)

	if grid then
		grid:setOccupyUid(uid, false)
	end
end

function CircleControlCenter.onFightMonster(uid, layer, targetIndex)
	if not self.inited or self.getShowLayer() ~= layer then
		return
	end

	local grid = self.getGridByIndex(targetIndex)

	if grid then
		grid:setOccupyUid(uid, true)
	end
end

function CircleControlCenter.onFightMonsterOver(uid, layer, targetIndex, refreshList, isBossKilled)
	if not self.inited or self.getShowLayer() ~= layer then
		return
	end

	local grid = self.getGridByIndex(targetIndex)

	if grid then
		grid:setOccupyUid(uid, false)
	end

	if CurAvatar.myCircle then
		local gridInfo = CurAvatar.myCircle:getGridInfo(targetIndex)

		if gridInfo and uid == CurAvatar.uid then
			if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER and gridInfo.status == Const.CIRCLE_GRID_STATUS.OPEN then
				self.addMonsterKilledByMeEvent()
			elseif gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and isBossKilled then
				self.addBossKilledByMeEvent()
			end
		end
	end

	if refreshList then
		for _, i in ipairs(refreshList) do
			local grid = self.getGridByIndex(i)

			if CurAvatar.myCircle and grid then
				local gridInfo = CurAvatar.myCircle:getGridInfo(i)

				if gridInfo then
					grid:refreshInfo(gridInfo, false, uid)
					self.checkAddToBossKilledShow(gridInfo, i, uid, isBossKilled)
				end
			end
		end
	end

	self:refreshPlayerState(uid)
end

function CircleControlCenter.onUseSkill(uid, refreshList, skill)
	if not self.inited then
		return
	end

	if refreshList then
		for _, i in ipairs(refreshList) do
			local grid = self.getGridByIndex(i)

			if CurAvatar.myCircle and grid then
				local gridInfo = CurAvatar.myCircle:getGridInfo(i)

				if gridInfo then
					grid:refreshInfo(gridInfo, false, uid)
				end
			end
		end
	end

	if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		if skill.id == Const.CIRCLE_BATTLE_SKILL_ID.SHOW_BOSS then
			MsgManager.clientNotice(534)
		elseif skill.id == Const.CIRCLE_BATTLE_SKILL_ID.SHOW_BOX then
			MsgManager.clientNotice(536)
		elseif skill.id == Const.CIRCLE_BATTLE_SKILL_ID.SHOW_RUNE then
			MsgManager.clientNotice(535)
		end
	end
end

function CircleControlCenter.onPlayerEnter(uid)
	if not self.inited then
		return
	end
end

function CircleControlCenter.onPlayerExit(uid)
	if not self.inited then
		return
	end
end

function CircleControlCenter.onChangeLayer(uid)
	if not self.inited then
		return
	end

	self.AddToEndShow(uid)
end

function CircleControlCenter.checkRC(r, c)
	if not r or not c then
		return false
	end

	if r < 1 or r > ROW or c < 1 or c > COL then
		return false
	end

	return true
end

function CircleControlCenter.indexToRowCol(index)
	local row = math.ceil(index / 20)
	local col = index - (row - 1) * 20

	return row, col
end

function CircleControlCenter.rowColToIndex(r, c)
	return (r - 1) * COL + c
end

function CircleControlCenter.indexToPos(index, range)
	local r, c = self.indexToRowCol(index)

	return self.rowColToGridPos(r, c, range)
end

function CircleControlCenter.indexToModelPos(index, isPlayer)
	local pos = self.indexToPos(index)

	pos.y = pos.y + Const.CIRCLE_MODEL_YOFFSET

	if isPlayer then
		pos.y = pos.y + 0.1
	end

	return pos
end

function CircleControlCenter.localToWorldPos(pos)
	return self.rootPos + pos
end

function CircleControlCenter.rowColToGridPos(row, col, range)
	local _row, _col = 1, 1

	if range then
		_row = range[2]
		_col = range[1]
	end

	local rowOffset = row + (_row - 1) * 0.5 - (ROW + 1) * 0.5
	local colOffset = (COL + 1) * 0.5 - (col + (_col - 1) * 0.5)
	local z = rowOffset * (SIZE + GAP)
	local x = colOffset * (SIZE + GAP)

	return Vector3(self.rootPos.x + x, self.rootPos.y, self.rootPos.z + z)
end

function CircleControlCenter.posToRowCol(pos)
	local col = math.ceil((self.leftUpPos.x - pos.x) / (SIZE + GAP))
	local row = math.ceil((-self.leftUpPos.y + pos.z) / (SIZE + GAP))

	return row, col
end

function CircleControlCenter.onClickGrid(pos)
	if pos == nil then
		return
	end

	local r, c = self.posToRowCol(pos)

	if not self.checkRC(r, c) then
		return
	end

	local grid = self.getGridByRC(r, c)

	if grid then
		grid:onClick(r, c)
	end
end

function CircleControlCenter.onClickGridByIndex(index)
	if index then
		local grid = self.getGridByIndex(index)
		local r, c = self.indexToRowCol(index)

		if grid then
			grid:onClick(r, c)
		end
	end
end

function CircleControlCenter.onClickPlayer(uid)
	local info = self.heroModels[uid]

	if info and info.model then
		info.model:onClick()
	else
		for i, model in ipairs(self.outHeroModels) do
			if model.data.uid == uid then
				model:onClick()
			end
		end
	end
end

function CircleControlCenter.onCameraFar(...)
	if not self.inited then
		return
	end

	self.showAllPlayerModels(false)
	self.showAllLogos(false)

	local ui = UIManager.getUI("circleBattleMainDlg", nil, false)

	if ui then
		ui:checkShowBossPos(false)
	end
end

function CircleControlCenter.onCameraHalfNear(...)
	self.showAllPlayerModels(true)
	self.showAllLogos(true)
end

function CircleControlCenter.onCameraNear(...)
	self.checkBossPos()

	local isWelcome = self.checkShowWelcome()

	if not isWelcome and GameFsm.isInState(Const.STATE_MAIN_CIRCLE) and not UIManager.tryGetUI("circleBattleMainDlg") then
		CurAvatar:jumpToShowActivity(ResClanBattleMisc[1].act_tmplid)
	end

	self.checkEvent()

	if self.onCameraNearAction then
		self.onCameraNearAction()

		self.onCameraNearAction = nil
	end
end

function CircleControlCenter.onMarkGridDataChange()
	if not self.inited then
		return
	end

	local ui = UIManager.tryGetUI("circleBattleMainDlg")

	if ui then
		ui:onMarkGridDataChange()
	end

	for i, model in ipairs(self.girdModels) do
		if model then
			model:refreshMarkedEffect()

			if self.checkOpenMarkGridPanel then
				model:refreshCanMarkEffect()
			end
		end
	end
end

function CircleControlCenter.onOpenMarkGridPanel()
	if not self.inited then
		return
	end

	self.checkOpenMarkGridPanel = true

	self.showAllPlayerModels(false)
	self.showAllLogos(false)

	if CurAvatar.myCircle then
		CurAvatar.myCircle:onOpenMarkGridPanel()
	end

	for _, model in pairs(self.girdModels) do
		model:refreshCanMarkEffect()
	end

	if CurAvatar.myCircle then
		local index = CurAvatar.myCircle:getMyMarkGridIndex()

		if index > 0 then
			self.focusOnIndex(index, Const.CIRCLE_BATTLE_ZOOM_DURATION)
		end
	end
end

function CircleControlCenter.onCloseMarkGridPanel()
	if not self.inited then
		return
	end

	self.checkOpenMarkGridPanel = false

	self.showAllPlayerModels(true)
	self.showAllLogos(true)

	for _, model in pairs(self.girdModels) do
		model:showCanMarkEffect(false)
	end

	self.focusOnMe(Const.CIRCLE_BATTLE_ZOOM_DURATION)

	if CurAvatar.myCircle then
		local res = CurAvatar.myCircle:getMarkGridResult()

		CurAvatar.myCircle:onCloseMarkGridPanel()

		if res.unmark > 0 then
			local grid = self.getGridByIndex(res.unmark)

			grid:refreshMarkedEffect()
		end

		if res.mark > 0 then
			local grid = self.getGridByIndex(res.mark)

			grid:refreshMarkedEffect()
		end
	end
end

function CircleControlCenter.onSaveMarkGridPanel()
	if not self.inited then
		return
	end

	self.checkOpenMarkGridPanel = false

	self.showAllPlayerModels(true)
	self.showAllLogos(true)

	for _, model in pairs(self.girdModels) do
		model:showCanMarkEffect(false)
	end

	self.focusOnMe(Const.CIRCLE_BATTLE_ZOOM_DURATION)

	if CurAvatar.myCircle then
		local res = CurAvatar.myCircle:getMarkGridResult()

		CurAvatar.myCircle:onCloseMarkGridPanel()

		if res.unmark > 0 or res.mark > 0 then
			CurAvatar:sendMarkGridReq(res.mark - 1, res.unmark - 1)

			if res.unmark > 0 then
				local grid = self.getGridByIndex(res.unmark)

				grid:refreshMarkedEffect()
			end

			if res.mark > 0 then
				local grid = self.getGridByIndex(res.mark)

				grid:refreshMarkedEffect()
			end
		end
	end
end

function CircleControlCenter.onMarkGrid(index, checkSelf)
	if not self.inited then
		return
	end

	local grid = self.getGridByIndex(index)

	if grid then
		grid:refreshCanMarkEffect()
		grid:showMarkedEffect(true, checkSelf)
	end

	local ui = UIManager.tryGetUI("circleBattleMainDlg")

	if ui then
		ui:refreshMarkGridPanel()
	end
end

function CircleControlCenter.onUnMarkGrid(index)
	if not self.inited then
		return
	end

	local grid = self.getGridByIndex(index)

	if grid then
		grid:refreshCanMarkEffect()
		grid:showMarkedEffect(false)
	end

	local ui = UIManager.tryGetUI("circleBattleMainDlg")

	if ui then
		ui:refreshMarkGridPanel()
	end
end

function CircleControlCenter.onBoxMarkAward(refreshList)
	if not self.inited then
		return
	end

	if refreshList then
		for _, i in ipairs(refreshList) do
			local grid = self.getGridByIndex(i)

			if CurAvatar.myCircle and grid then
				local gridInfo = CurAvatar.myCircle:getGridInfo(i)

				if gridInfo then
					grid:refreshInfo(gridInfo, false)
				end
			end
		end
	end
end

function CircleControlCenter.onReconnect(...)
	local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_CIRCLE_BATTLE)

	if not actObj or actObj:inCloseState() then
		GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()

		return
	end

	if self.isLayerChange() then
		UIManager.getUI("circleBattleConfirmDlg", true):setData({
			type = Const.CIRCLE_BATTLE_SHOW_TYPE.END
		}, self.changeLayer)
	else
		self.changeLayer()
	end
end

function CircleControlCenter.checkShowWelcome(...)
	if CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

		if member and member.battle_data.oppos < 0 and self.checkLayer ~= self.getLayer() then
			self.addLookWelcomeEvent()

			return true
		end
	end
end

function CircleControlCenter._clearCachedModels(...)
	for uid, model in pairs(self.cacheModels) do
		if model then
			model:destroy()
		end
	end

	self.cacheModels = {}
end

function CircleControlCenter._clearGridModels(...)
	for i, model in ipairs(self.girdModels) do
		if model then
			model:destroy()
		end
	end

	self.girdModels = {}
	self.gridsData = {}
end

function CircleControlCenter._clearShowModels(...)
	for _, list in pairs(self.onlyShowModels) do
		for i, model in ipairs(list or {}) do
			model:destroy()
		end
	end

	self.onlyShowModels = {}
end

function CircleControlCenter.clear(...)
	self._clearGridModels()
	self._clearCachedModels()
	self._clearShowModels()

	for i, info in pairs(self.heroModels) do
		if info.model then
			info.model:destroy()
		end
	end

	self.heroModels = {}

	for i, model in ipairs(self.outHeroModels) do
		if model then
			model:destroy()
		end
	end

	self.outHeroModels = {}
end

function CircleControlCenter.clearLogos(...)
	for _, logo in pairs(self.logoPool) do
		if logo then
			logo:destroy()
		end
	end

	self.logoPool = {}
end

function CircleControlCenter.destroy(...)
	if self.coShow then
		coroutine.stop(self.coShow)

		self.coShow = nil
	end

	if self.coEvent then
		coroutine.stop(self.coEvent)

		self.coEvent = nil
	end

	if self.root then
		UnityEngine.Object.Destroy(self.root)

		self.root = nil
	end

	if self.heroRoot then
		UnityEngine.Object.Destroy(self.heroRoot)

		self.heroRoot = nil
	end

	self.clear()

	self.offLineBases = {}

	self.reset()

	self.inited = nil
	self.isInAiTest = nil
end

function CircleControlCenter.testEvent(...)
	coroutine.start(function(...)
		coroutine.wait(0.1)
		self.addMonsterKilledByMeEvent({})
		coroutine.wait(0.1)
		self.addLookWelcomeEvent({})
		coroutine.wait(0.1)
		self.addChangeLayerEvent({})
	end)
end

function CircleControlCenter.testAi(...)
	self.isInAiTest = true

	MsgManager.notice("start ai move success!")
	coroutine.start(function(...)
		while true do
			if not self.isInAiTest then
				break
			end

			if self.inited then
				local grids = {}

				for i, grid in ipairs(self.girdModels or {}) do
					if grid:isHideCanOpen() then
						table.insert(grids, grid)
					end
				end

				if #grids > 0 then
					local index = math.random(#grids)
					local grid = grids[index]

					if grid.occupyUid == nil then
						local point = grid:getOprateCostPoint()

						if point then
							if point > CurAvatar.myCircle:getActionPoint() then
								MsgManager.clientNotice(523)
							else
								grid:occupy()
							end
						end
					end
				end

				coroutine.wait(5)
			end
		end
	end)
end

function CircleControlCenter.testModelNum(num, modelId)
	if not GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		MsgManager.notice(Lang.get(40570))

		return
	end

	for i = 1, num do
		local r = i % 8
		local c = math.floor(i / 8)
		local index = c * 20 + (r == 0 and 8 or r)
		local model, data

		if not model then
			local pos = self.indexToModelPos(index, true)

			data = {
				type = Const.CIRCLE_COMMON_MODEL_TYPE.PLAYER,
				uid = index,
				modelId = modelId or 13203,
				baseId = modelId or 13203,
				pos = pos
			}
			model = CirclePlayerModel(data, self)

			table.insert(self.outHeroModels, model)
		end
	end

	MsgManager.notice(Lang.get(40571))
end

function CircleControlCenter.testAni(...)
	coroutine.start(function(...)
		if self.testModel then
			self.testModel:destroy()
		end

		local info = {
			param = 0,
			status = 0,
			type = 0
		}

		self.testModel = CircleGridModel(info, 201, self)

		self.testModel:createModel()
		coroutine.wait(1)

		local pos = self.localToWorldPos(Vector3(78, 0, 0))

		self.testModel:setModelPos(pos)
		coroutine.wait(1)

		local info1 = {
			param = 3001,
			type = Const.CIRCLE_GRID_OPEN_TYPE.BOSS,
			status = Const.CIRCLE_GRID_STATUS.SHOW
		}

		self.testModel:refreshInfo(info1)
		coroutine.wait(3)

		local info2 = {
			param = 3001,
			type = Const.CIRCLE_GRID_OPEN_TYPE.BOSS,
			status = Const.CIRCLE_GRID_STATUS.OPEN
		}

		self.testModel:refreshInfo(info2)
	end)
end

function CircleControlCenter.testCamera(...)
	coroutine.start(function(...)
		local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

		state:lookEndShowAni()
	end)
end

function CircleControlCenter.testFence(...)
	self.testBoxNum = self.testBoxNum or 0
	self.testBoxNum = self.testBoxNum + 1

	if self.testBoxNum > 3 then
		self.testBoxNum = 1
	end

	local gridInfo = {
		param = 1,
		type = Const.CIRCLE_GRID_OPEN_TYPE.BOX,
		status = Const.CIRCLE_GRID_STATUS.OPEN
	}
	local uid = "1"
	local index = math.random(100)

	if gridInfo.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local info

		if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			info = {
				uid = uid,
				index = index,
				type = Const.CIRCLE_BATTLE_SHOW_TYPE.BOSS
			}
		elseif gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOX then
			local data = {
				totalBoxNum = 3,
				boxNum = self.testBoxNum
			}

			info = {
				uid = uid,
				index = index,
				type = Const.CIRCLE_BATTLE_SHOW_TYPE.BOX,
				boxNum = data.boxNum,
				totalBoxNum = data.totalBoxNum
			}
		end

		self.addOpenBoxEvent(info)
	end
end

function CircleControlCenter.testTrainOut(...)
	local gridInfo = {
		param = 1,
		type = Const.CIRCLE_GRID_OPEN_TYPE.BOSS,
		status = Const.CIRCLE_GRID_STATUS.OPEN
	}
	local uid = "1"
	local index = math.random(100)

	if gridInfo.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local info

		if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			info = {
				uid = uid,
				index = index,
				type = Const.CIRCLE_BATTLE_SHOW_TYPE.BOSS
			}
		elseif gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOX then
			local data = {
				totalBoxNum = 3,
				boxNum = self.testBoxNum
			}

			info = {
				uid = uid,
				index = index,
				type = Const.CIRCLE_BATTLE_SHOW_TYPE.BOX,
				boxNum = data.boxNum,
				totalBoxNum = data.totalBoxNum
			}
		end

		self.addBossKilledEvent(info)
	end
end

function CircleControlCenter.testTrainGo(...)
	function self.canChangeLayer(...)
		return true
	end

	self.onChangeLayer("1")
end

return CircleControlCenter
