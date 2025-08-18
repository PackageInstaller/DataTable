-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Circle\\CircleGridModel.lua

local Model = require("Entity/Model")
local DragUtils = Framework.Drag.DragUtils
local ResClanGridType = require("ClientData/ResClanGridType")
local CircleCommonModel = require("Logic/Circle/CircleCommonModel")
local ResClanBattleLayer = require("ClientData/ResClanBattleLayer")
local ResClanBattleMonster = require("ClientData/ResClanBattleMonster")
local MONSTER_SHOW_GRID_PATH = "Avatars/avatar_redplan_01"
local MONSTER_SHOW_GRID_ANIMATOR = "Animator/animator_redplan_01.controller"
local GRID_END_PATH = "Avatars/avatar_endplan_01"
local GRID_END_ANIMATOR = "Animator/animator_endplan_01.controller"
local DEFAULT_GRID_PATH = "Avatars/avatar_plan_01"
local DEFAULT_GRID_ANIMATOR = "Animator/animator_plan_01.controller"
local GRID_PATH = {
	[Const.CIRCLE_GRID_OPEN_TYPE.HINDER] = "ghz_zhuomiandj_03",
	[Const.CIRCLE_GRID_OPEN_TYPE.NONE] = "ghz_zhuomiandj_03",
	[Const.CIRCLE_GRID_OPEN_TYPE.BOX] = "ghz_zhuomiandj_05",
	[Const.CIRCLE_GRID_OPEN_TYPE.MONSTER] = {
		"ghz_zhuomiandj_08",
		"ghz_zhuomiandj_09",
		"ghz_zhuomiandj_10"
	},
	[Const.CIRCLE_GRID_OPEN_TYPE.BOSS] = {
		"ghz_zhuomiandj_08",
		"ghz_zhuomiandj_09",
		"ghz_zhuomiandj_10"
	},
	[Const.CIRCLE_GRID_OPEN_TYPE.RUNE] = "ghz_zhuomiandj_07",
	[Const.CIRCLE_GRID_OPEN_TYPE.SCORE] = "ghz_zhuomiandj_06"
}
local OCCUPY_CONFIG = {
	[Const.CIRCLE_GRID_OPEN_TYPE.HINDER] = {
		animator = "Animator/animator_Stop.controller",
		path = "Avatars/avatar_Stop"
	},
	[Const.CIRCLE_GRID_OPEN_TYPE.NONE] = nil,
	[Const.CIRCLE_GRID_OPEN_TYPE.BOX] = {
		animator = "Animator/animator_box_01b.controller",
		path = "Avatars/avatar_box_01b"
	},
	[Const.CIRCLE_GRID_OPEN_TYPE.MONSTER] = {
		animator3 = "Animator/animator_monster_L.controller",
		animator1 = "Animator/animator_monster_S.controller",
		animator2 = "Animator/animator_monster_M.controller"
	},
	[Const.CIRCLE_GRID_OPEN_TYPE.BOSS] = {
		animator3 = "Animator/animator_monster_L.controller",
		animator1 = "Animator/animator_monster_S.controller",
		animator2 = "Animator/animator_monster_M.controller"
	},
	[Const.CIRCLE_GRID_OPEN_TYPE.RUNE] = {
		animator = "Animator/animator_Stone.controller",
		path = "Avatars/avatar_Stone"
	},
	[Const.CIRCLE_GRID_OPEN_TYPE.SCORE] = {
		animator = "Animator/animator_Star.controller",
		path = "Avatars/avatar_Star"
	}
}
local EFFECT_TYPE = {
	MONSTER_WEAK = 10,
	CAN_OPEN = 12,
	BOX_OPEN = 11,
	GUARDING = 2,
	CAN_FLAG = 18,
	BOSS_FLAG = 17,
	FLAG_MINE = 20,
	FLAG_OTHER = 19,
	MONSTER_DISAREAR = 9,
	RUNE_OPEN = 13,
	SCORE_OPEN = 16,
	GUARD_OVER = 3,
	PREVIEW_BOSS = 5,
	OPRATING = 7,
	SEARCH_MINE = 14,
	PATH_TIP = 8,
	GUARD = 1,
	PREVIEW_BOX = 4,
	SEARCH_OTHER = 15,
	PREVIEW_RUNE = 6
}
local EFFECT_PATH = {
	[EFFECT_TYPE.GUARD] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_02_01.prefab"
	},
	[EFFECT_TYPE.GUARDING] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_02_02.prefab"
	},
	[EFFECT_TYPE.GUARD_OVER] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_02_03.prefab"
	},
	[EFFECT_TYPE.PREVIEW_BOX] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_03.prefab"
	},
	[EFFECT_TYPE.PREVIEW_BOSS] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_04.prefab"
	},
	[EFFECT_TYPE.PREVIEW_RUNE] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_05.prefab"
	},
	[EFFECT_TYPE.OPRATING] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_06.prefab"
	},
	[EFFECT_TYPE.PATH_TIP] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_07.prefab"
	},
	[EFFECT_TYPE.MONSTER_DISAREAR] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_08.prefab"
	},
	[EFFECT_TYPE.MONSTER_WEAK] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_09.prefab"
	},
	[EFFECT_TYPE.BOX_OPEN] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_10.prefab"
	},
	[EFFECT_TYPE.RUNE_OPEN] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_10_01.prefab"
	},
	[EFFECT_TYPE.CAN_OPEN] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_01.prefab"
	},
	[EFFECT_TYPE.SEARCH_OTHER] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_15_01.prefab"
	},
	[EFFECT_TYPE.SEARCH_MINE] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_15_02.prefab"
	},
	[EFFECT_TYPE.SCORE_OPEN] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_10_02.prefab"
	},
	[EFFECT_TYPE.BOSS_FLAG] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_16.prefab"
	},
	[EFFECT_TYPE.CAN_FLAG] = {
		scale = 1,
		path = "Effects/Scene/efx_ghz_zhuomian_17.prefab"
	},
	[EFFECT_TYPE.FLAG_OTHER] = {
		scale = 1,
		path = "Drag/gonghuizhan/Avatars/ghz_qizi_01.prefab"
	},
	[EFFECT_TYPE.FLAG_MINE] = {
		scale = 1,
		path = "Drag/gonghuizhan/Avatars/ghz_qizi_02.prefab"
	}
}
local PRE_MONSTER_PATH = "Drag/gonghuizhan/scenemonsters/"
local PRE_SIMPLE_PATH = "Drag/gonghuizhan/"
local CirCleGridModel = Class("CirCleGridModel")

function CirCleGridModel:ctor(info, index, controlCenter)
	self.controlCenter = controlCenter
	self.index = index
	self.occupyUid = nil
	self.bossOccupyMap = {}
	self.occupyModel = nil
	self.gridType = self.controlCenter.getGridType(info.type)

	local config = ResClanGridType[self.gridType]

	self.row, self.col = self.controlCenter.indexToRowCol(index)
	self.data = config
	self.range = config.range
	self.pos = self.controlCenter.indexToPos(index, self.data.range)
	self.effectMap = {}
	self.effectPlayerMap = {}
	self.uponUids = {}

	self:refreshInfo(info, true, nil)

	self.slotCallBack = Slot(self._loadedCallBack, self)
end

function CirCleGridModel:refreshInfo(gridInfo, isInit, uid)
	self.preStatus = self.status
	self.gridInfo = gridInfo

	local openType = Const.CIRCLE_GRID_OPEN_TYPE.NONE

	if self.gridType ~= gridInfo.type then
		openType = gridInfo.type or Const.CIRCLE_GRID_OPEN_TYPE.NONE
	end

	self.openType = openType

	if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
		self.controlCenter.setBossIndex(self.index)
	end

	self.status = gridInfo.status

	if (self.preStatus == Const.CIRCLE_GRID_STATUS.GUARD or self.preStatus == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD) and self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		-- block empty
	end

	if (not isInit and self.status == Const.CIRCLE_GRID_STATUS.HIDE or self.status == Const.CIRCLE_GRID_STATUS.GUARD) and self.openType > Const.CIRCLE_GRID_OPEN_TYPE.NONE then
		ClientUtils.trySendException("stiger circleBattle", utils.format(Lang.get(42720), self.index, self.openType))
	end

	if not isInit then
		self:playMyShow(uid)
	end
end

function CirCleGridModel:setOccupyUid(uid, isOccupy)
	if isOccupy then
		local playerOpType

		if self:isBossShowing() then
			self.bossOccupyMap[uid] = true
		elseif self.occupyUid then
			if self.occupyUid == uid and CurAvatar.myCircle then
				local info = CurAvatar.myCircle:getCircleMember(uid)

				if info and info.battle_data.optype ~= Const.CIRCLE_PLAYER_STATE.BATTLE then
					-- block empty
				end
			end
		else
			self.occupyUid = uid
		end

		if CurAvatar.myCircle then
			local info = CurAvatar.myCircle:getCircleMember(uid)

			if info then
				playerOpType = info.battle_data.optype

				if info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.SEARCH then
					self:showTimeDown(true, uid)
				elseif (info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION or info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.BATTLE) and self.occupyModel then
					self.occupyModel:refreshState(info.battle_data.optype)
				end
			end
		end
	else
		local isAnyOp = false

		if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and (self.status == Const.CIRCLE_GRID_STATUS.SHOW or self.status == Const.CIRCLE_GRID_STATUS.OPEN) then
			self.bossOccupyMap[uid] = nil
			isAnyOp = next(self.bossOccupyMap) ~= nil
		else
			if self.occupyUid ~= uid then
				-- block empty
			else
				self.occupyUid = nil
			end

			isAnyOp = false
		end

		self.occupyUid = nil

		self:showTimeDown(false)
		self:showSearchEfx(false, uid)

		if self.occupyModel and not isAnyOp then
			self.occupyModel:refreshState(Const.CIRCLE_PLAYER_STATE.NONE)
		end

		self.controlCenter.refreshPlayerState(uid)
	end
end

function CirCleGridModel:showSearchEfx(v, uid)
	if v then
		if uid == CurAvatar.uid then
			self:showEffect(EFFECT_TYPE.SEARCH_MINE, true)
		else
			self:showEffect(EFFECT_TYPE.SEARCH_OTHER, true)
		end

		self:showCanOpenEffect(false)
	else
		self:showEffect(EFFECT_TYPE.SEARCH_OTHER, false)
		self:showEffect(EFFECT_TYPE.SEARCH_MINE, false)
		self:checkCanOpenEffect(true)
	end
end

function CirCleGridModel:getOccupyUid(...)
	return self.occupyUid
end

function CirCleGridModel:initOccupyModel(...)
	self:_playShow(true, CurAvatar.uid)
end

function CirCleGridModel:coPlayShow(uid)
	self:_playShow(nil, uid)
end

function CirCleGridModel:_playShow(isInit, uid)
	if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and self.preStatus ~= self.status then
		self:_playBoss(isInit, uid)
	elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER then
		self:_playMonster(isInit, uid)
	elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.RUNE then
		self:_playRune(isInit, uid)
	elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOX then
		self:_playBox(isInit, uid)
	elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.SCORE then
		self:_playScore(isInit)
	elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.HINDER then
		self:_playHinder(isInit)
	elseif Const.CIRCLE_GRID_TYPE.END[self.gridType] then
		self:_playEndGrid(isInit)
	else
		self:_playNormalGrid(isInit)
	end
end

function CirCleGridModel:_playNormalGrid(isInit)
	if self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local time = self:_commonShowGridOpen(isInit)

		if not isInit then
			coroutine.wait(time)
		end
	elseif self.status == Const.CIRCLE_GRID_STATUS.GUARD then
		self:showEffect(EFFECT_TYPE.GUARD, true)
		self:showEffect(EFFECT_TYPE.GUARDING, true)
	elseif not isInit then
		self:showEffect(EFFECT_TYPE.GUARD_OVER, true)
	end

	if not isInit then
		self:_onShowEnd()
	end
end

function CirCleGridModel:_playEndGrid(isInit)
	if (self.controlCenter.canChangeLayer() or self.controlCenter.isLayerChange()) and not self.endGridShowed then
		self.endGridShowed = true

		local time = self:_commonShowGridOpen()
	end

	if not isInit then
		self:_onShowEnd()
	end
end

function CirCleGridModel:_playBoss(isInit, uid)
	self.controlCenter.checkBossPos()

	if self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
		self:showEffect(EFFECT_TYPE.PREVIEW_BOSS, true)
	elseif self.status == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD then
		self:showEffect(EFFECT_TYPE.GUARD, true)
		self:showEffect(EFFECT_TYPE.GUARDING, true)
		self:showEffect(EFFECT_TYPE.PREVIEW_BOSS, true)
	elseif self.status == Const.CIRCLE_GRID_STATUS.SHOW then
		if not isInit then
			self:createTempModel(true)

			for i = 1, 30 do
				if self.tempTransform then
					self:_replaceGridModel()

					break
				end

				coroutine.step()
			end

			local time = self:_commonShowGridOpen(isInit)

			self:createOccupyModel(false)
			coroutine.wait(time)

			if self.occupyModel then
				self.occupyModel:playAnimation("show", true)
			end

			coroutine.wait(0.3)
			self:showEffect(EFFECT_TYPE.BOSS_FLAG, true)
			EffectManager:getFreedomEffectAsync("Effects/Scene/efx_ghz_zhuomian_14_03.prefab", self.pos, Vector3.zero, true)
		else
			local time = self:_commonShowGridOpen(isInit)

			self:createOccupyModel(true)
			self:showEffect(EFFECT_TYPE.BOSS_FLAG, true)
		end
	elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		self:checkBossAroundState()

		local time = self:_commonShowGridOpen(isInit, true)
		local time = 0.5

		if not isInit then
			self:createTempModel()
			coroutine.wait(time)
			coroutine.wait(1)
			self:_replaceGridModel()

			if uid ~= CurAvatar.uid then
				self:showEffect(EFFECT_TYPE.MONSTER_DISAREAR, true)
			end

			if self.occupyModel then
				self.occupyModel:playAnimation("hide", false)
			end

			coroutine.wait(1)
		end

		self:destroyOccupyModel()
	end

	if not isInit then
		self:_onShowEnd()
	end
end

function CirCleGridModel:_playMonster(isInit, uid)
	if self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
		-- block empty
	elseif self.status == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD then
		-- block empty
	elseif self.status == Const.CIRCLE_GRID_STATUS.SHOW then
		if not isInit then
			self:createTempModel(true)
			self:createOccupyModel(false)

			for i = 1, 30 do
				if self.tempTransform then
					self:_replaceGridModel()

					break
				end

				coroutine.step()
			end

			local time = self:_commonShowGridOpen(isInit)

			coroutine.wait(time - 0.2)

			if self.occupyModel then
				self.occupyModel:playAnimation("show", true)
			end

			coroutine.wait(0.3)

			local type = self:getOccupyModelType()

			EffectManager:getFreedomEffectAsync("Effects/Scene/efx_ghz_zhuomian_14_0" .. type .. ".prefab", self.pos, Vector3.zero, true)
		else
			local time = self:_commonShowGridOpen(isInit)

			self:createOccupyModel(true)
		end
	elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		self:onMonsterKilled()

		local time = self:_commonShowGridOpen(isInit, true)
		local time = 0.5

		if not isInit then
			self:createTempModel()
			coroutine.wait(time)
			coroutine.wait(1)

			if self.occupyModel then
				self.occupyModel:playAnimation("hide", false)
			end

			self:_replaceGridModel()

			if uid ~= CurAvatar.uid then
				self:showEffect(EFFECT_TYPE.MONSTER_DISAREAR, true)
			end

			coroutine.wait(1)
		end

		self:destroyOccupyModel()
	end

	if not isInit then
		self:_onShowEnd()
	end
end

function CirCleGridModel:_playRune(isInit, uid)
	if self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
		self:showEffect(EFFECT_TYPE.PREVIEW_RUNE, true)
	elseif self.status == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD then
		self:showEffect(EFFECT_TYPE.GUARD, true)
		self:showEffect(EFFECT_TYPE.GUARDING, true)
		self:showEffect(EFFECT_TYPE.PREVIEW_RUNE, true)
	elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local time = self:_commonShowGridOpen(isInit)

		if not isInit then
			self:createTempModel()
			self:showEffect(EFFECT_TYPE.RUNE_OPEN, true)
			coroutine.wait(1.7)
			self:_replaceGridModel()
			coroutine.wait(0.2)
		end
	end

	if not isInit then
		self:_onShowEnd(uid)
	end
end

function CirCleGridModel:_playBox(isInit, uid)
	if self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
		self:showEffect(EFFECT_TYPE.PREVIEW_BOX, true)
	elseif self.status == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD then
		self:showEffect(EFFECT_TYPE.GUARD, true)
		self:showEffect(EFFECT_TYPE.GUARDING, true)
		self:showEffect(EFFECT_TYPE.PREVIEW_BOX, true)
	elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local time = self:_commonShowGridOpen(isInit)

		if not isInit then
			self:createTempModel()
			self:showEffect(EFFECT_TYPE.BOX_OPEN, true)
			coroutine.wait(1.4)
			self:_replaceGridModel()
			coroutine.wait(0.3)
		end
	end

	if not isInit then
		self:_onShowEnd(uid)
	end
end

function CirCleGridModel:_playScore(isInit)
	if self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
		-- block empty
	elseif self.status == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD then
		-- block empty
	elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local time = self:_commonShowGridOpen(isInit)

		if not isInit then
			self:createTempModel()
			self:createOccupyModel(false)
			self:showEffect(EFFECT_TYPE.SCORE_OPEN, true)
			coroutine.wait(3.2)
			self:_replaceGridModel()
			self:destroyOccupyModel()
		end
	end

	if not isInit then
		self:_onShowEnd()
	end
end

function CirCleGridModel:_playHinder(isInit)
	if self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
		-- block empty
	elseif self.status == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD then
		-- block empty
	elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		local time = self:_commonShowGridOpen(isInit)

		if not isInit then
			self:createTempModel()
			self:createOccupyModel(false)
			coroutine.wait(0.1)

			if self.occupyModel then
				self.occupyModel:playAnimation("show")
			end

			coroutine.wait(1)
			self:_replaceGridModel()
		else
			self:createOccupyModel(true)
		end
	end

	if not isInit then
		self:_onShowEnd()
	end
end

function CirCleGridModel:_replaceGridModel(...)
	if self.tempTransform then
		self.transform = self.tempTransform

		self:checkLogoTarget()
		self.tempModel:showModel(true)
		self:destroyModel()

		self.model = self.tempModel
		self.tempModel = nil
		self.tempTransform = nil
	end
end

function CirCleGridModel:isPlayingShow(...)
	return self._isPlayingShow
end

function CirCleGridModel:playMyShow(uid)
	if self.preStatus == self.status then
		return
	end

	self:playShow(nil, uid)
end

function CirCleGridModel:playShow(delayTime, uid)
	self:releaseEffect()

	self._coPlay = coroutine.start(function()
		self:_onShowStart()
		coroutine.step()

		if delayTime then
			coroutine.wait(delayTime)
		end

		self:coPlayShow(uid)
	end)
end

function CirCleGridModel:_commonShowGridOpen(isInit, noAni)
	if not isInit then
		if not noAni and self.model then
			self:playAnimation("show")
		end
	elseif self.transform then
		local vec = self.transform.eulerAngles

		vec.z = 180
		self.transform.eulerAngles = vec
	end

	return 0.5
end

function CirCleGridModel:_onShowStart(...)
	self._isPlayingShow = true

	if self.logo then
		self.logo:setHide(true)
	end

	self:hideAllPlayerOnMe()
end

function CirCleGridModel:_onShowEnd(uid)
	self._isPlayingShow = nil

	if self.logo then
		self.logo:setHide(false)
	end

	self:checkPlayerShow()
	self:checkCanOpenEffect(true)
	self:refreshMarkedEffect()

	if self.controlCenter.checkOpenMarkGridPanel then
		self:refreshCanMarkEffect()
	end

	if uid == CurAvatar.uid then
		if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.RUNE and self.status == Const.CIRCLE_GRID_STATUS.OPEN then
			self.controlCenter.addOpenRuneEvent(self.gridInfo.param)
		elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOX and self.status == Const.CIRCLE_GRID_STATUS.OPEN then
			self.controlCenter.addOpenBoxEvent(self.boxData or {
				uid = CurAvatar.uid
			}, true)
		end
	end
end

function CirCleGridModel:setBoxData(data)
	self.boxData = data
end

function CirCleGridModel:createModel()
	local path, animator = self:_getModelPath()

	if path then
		animator = animator and PRE_SIMPLE_PATH .. animator
		self.animator = animator
		self.model = Model(self.slotCallBack)

		self.model:setModelDataSimple(PRE_SIMPLE_PATH .. path, animator)
		self.model:loadGameObject(false, true)
	end
end

function CirCleGridModel:createTempModel(initShow)
	initShow = initShow or false

	local path, animator = self:_getModelPath()

	if path then
		animator = animator and PRE_SIMPLE_PATH .. animator
		self.animator = animator
		self.tempModel = Model(Functor(self._loadedTempCallBack, self, initShow))

		self.tempModel:setModelDataSimple(PRE_SIMPLE_PATH .. path, animator)
		self.tempModel:loadGameObject(false, initShow)
	end
end

function CirCleGridModel:_getModelPath(...)
	local path, animator

	if Const.CIRCLE_GRID_TYPE.STATUE[self.gridType] then
		local layerData = ResClanBattleLayer[self.controlCenter.getShowLayer()]

		if layerData then
			local id = self.gridType - 2
			local data = layerData.statue[id]

			if data then
				path = "Avatars/" .. data.model_path
				animator = "Animator/" .. data.ani_path
			end
		end
	else
		local info = GRID_PATH[self.openType]

		if not Const.CIRCLE_GRID_TYPE.NORMAL[self.gridType] then
			if Const.CIRCLE_GRID_TYPE.END[self.gridType] then
				path = GRID_END_PATH
				animator = GRID_END_ANIMATOR
			else
				path = self.data.path
			end
		elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS or self.openType == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER then
			if self.status == Const.CIRCLE_GRID_STATUS.SHOW then
				path = MONSTER_SHOW_GRID_PATH
				animator = MONSTER_SHOW_GRID_ANIMATOR
			elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN then
				local config = ResClanBattleMonster[self.gridInfo.param]

				if config then
					path = info[config.type]
				end
			else
				path = DEFAULT_GRID_PATH
				animator = DEFAULT_GRID_ANIMATOR
			end
		elseif self.status == Const.CIRCLE_GRID_STATUS.OPEN or self.status == Const.CIRCLE_GRID_STATUS.SHOW then
			path = info
		else
			path = DEFAULT_GRID_PATH
			animator = DEFAULT_GRID_ANIMATOR
		end
	end

	if path == nil then
		-- block empty
	end

	return path, animator
end

function CirCleGridModel:_loadedCallBack(...)
	local go = self.model.modelGameObject
	local parent = self.controlCenter.getRootTran()

	if parent then
		go.transform.parent = parent
	end

	go.transform.position = self.pos
	self.transform = go.transform

	if Const.CIRCLE_GRID_TYPE.START[self.gridType] and self.row == 1 then
		local vec = self.transform.eulerAngles

		vec.y = 180
		self.transform.eulerAngles = vec
	elseif Const.CIRCLE_GRID_TYPE.END[self.gridType] and not self.controlCenter.canChangeLayer() then
		-- block empty
	end

	self:initOccupyModel(nil)
	self:checkLogoTarget()
	self.controlCenter.onGridLoaded()
end

function CirCleGridModel:_loadedTempCallBack(notTurn)
	local go = self.tempModel.modelGameObject
	local parent = self.controlCenter.getRootTran()

	if parent then
		go.transform.parent = parent
	end

	go.transform.position = self.pos
	self.tempTransform = go.transform

	if not notTurn then
		local vec = self.tempTransform.eulerAngles

		vec.z = 180
		self.tempTransform.eulerAngles = vec
	end
end

function CirCleGridModel:createOccupyModel(isInit)
	if self.occupyModel then
		return
	end

	local pos = self.pos:Clone()

	pos.y = pos.y + Const.CIRCLE_MODEL_YOFFSET

	local path, animator
	local showInfo = OCCUPY_CONFIG[self.openType]

	if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS or self.openType == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER then
		local id = self.gridInfo.param
		local info = ResClanBattleMonster[id]

		if info then
			path = PRE_MONSTER_PATH .. info.model
			animator = PRE_SIMPLE_PATH .. showInfo["animator" .. info.type]
		end
	elseif OCCUPY_CONFIG[self.openType] then
		path = PRE_SIMPLE_PATH .. showInfo.path
		animator = PRE_SIMPLE_PATH .. showInfo.animator
	elseif ResClanGridType[self.openType] then
		path = PRE_SIMPLE_PATH .. ResClanGridType[self.openType].path
	end

	if path then
		local data = {
			type = Const.CIRCLE_COMMON_MODEL_TYPE.OTHER,
			path = path,
			pos = pos,
			animator = animator
		}

		if self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
			data.isPreview = true
		end

		if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			data.gridIndex = self.index
		end

		self.occupyModel = CircleCommonModel(data, self.controlCenter)

		self.occupyModel:showModel(isInit)
	end
end

function CirCleGridModel:getLogoTran(...)
	return self.transform
end

function CirCleGridModel:setModelPos(pos)
	if self.transform then
		self.transform.position = pos
		self.pos = pos
	end
end

function CirCleGridModel:playAnimation(name)
	if self.animator and self.model then
		self.model:playAnimation(name)
	end
end

function CirCleGridModel:onMonsterKilled(...)
	local nearData = self:getNearData()

	for i, _ in pairs(nearData) do
		local grid = self.controlCenter.getGridByIndex(i)

		if grid and grid:isBossShowing() then
			grid:checkBossAroundState()
		end
	end

	local diagonalNearData = self:getDiagonalNearData()

	for i, _ in pairs(diagonalNearData) do
		local grid = self.controlCenter.getGridByIndex(i)

		if grid and grid:isBossShowing() then
			grid:checkBossAroundState()
		end
	end
end

function CirCleGridModel:checkBossAroundState(...)
	local nearData = self:getNearData()

	for i, _ in pairs(nearData) do
		local grid = self.controlCenter.getGridByIndex(i)

		if grid then
			grid:checkCanOpenEffect(true)
		end
	end

	local diagonalNearData = self:getDiagonalNearData()

	for i, _ in pairs(diagonalNearData) do
		local grid = self.controlCenter.getGridByIndex(i)

		if grid then
			grid:checkCanOpenEffect(true)
		end
	end
end

function CirCleGridModel:getOccupyModelType(...)
	local info = ResClanBattleMonster[self.gridInfo.param]

	if info then
		return info.type
	end

	return 1
end

function CirCleGridModel:checkLogoTarget(...)
	if self.logo then
		self.logo:setTarget(self)
	end
end

function CirCleGridModel:getUponUids(...)
	return self.uponUids
end

function CirCleGridModel:onPlayerCome(uid, tick)
	local info

	for i, _info in ipairs(self.uponUids) do
		if _info.uid == uid then
			_info.tick = tick
			info = _info

			table.remove(self.uponUids, i)

			break
		end
	end

	info = info or {
		uid = uid,
		tick = tick
	}

	local data = self.uponUids[1]
	local insertIndex

	insertIndex = data and data.uid == CurAvatar.uid and 2 or 1

	table.insert(self.uponUids, insertIndex, info)
	self:onPlayerNumChange()
end

function CirCleGridModel:onPlayerGo(uid)
	for i, _info in ipairs(self.uponUids) do
		if _info.uid == uid then
			self.controlCenter.showModel(uid, true)
			table.remove(self.uponUids, i)

			break
		end
	end

	self:onPlayerNumChange()
end

function CirCleGridModel:showTimeDown(v, uid)
	if v then
		local moveEndStamp = self:getOccupyPlayerMoveEndStamp()

		if moveEndStamp == nil then
			self:_countDown()
		else
			local leftTime = moveEndStamp - ClientUtils.getServerTime()

			if leftTime >= 0 then
				if self.barTimer then
					self.barTimer:Stop()
				end

				self.barTimer = Timer.New(Functor(self._countDown, self, Const.CIRCLE_OCCUPY_CANCEL_TIME), leftTime, 1)

				self.barTimer:Start()
			else
				local leftCancelTime = Const.CIRCLE_OCCUPY_CANCEL_TIME + leftTime

				if leftCancelTime > 0 then
					self:_countDown(leftCancelTime)
				end
			end
		end
	end
end

function CirCleGridModel:_countDown(time)
	local uid = self:getOccupyUid()

	if uid and CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(uid)

		if member and member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.SEARCH then
			local leftTime = time or member.battle_data.optick + Const.CIRCLE_OCCUPY_CANCEL_TIME - ClientUtils.getServerTime()

			if leftTime > 0 then
				self:showSearchEfx(true, uid)
			end
		end
	end
end

function CirCleGridModel:refreshLogoState(...)
	self:onPlayerNumChange()
end

function CirCleGridModel:onPlayerNumChange()
	self:checkPlayerShow()

	if not self.logo then
		self.logo = self.controlCenter.getLogo(Const.CIRCLE_LOGO_TYPE.GRID, self)
	end

	self.logo:onPlayerNumChange()
end

function CirCleGridModel:returnLogo(...)
	if self.logo then
		self.controlCenter.returnLogo(self.logo)
	end

	self.logo = nil
end

function CirCleGridModel:checkPlayerShow()
	if self._isPlayingShow then
		return
	end

	for i, info in ipairs(self.uponUids) do
		self.controlCenter.showModel(info.uid, i == 1)
	end
end

function CirCleGridModel:hideAllPlayerOnMe(...)
	for i, info in ipairs(self.uponUids) do
		self.controlCenter.showModel(info.uid, false)
	end
end

function CirCleGridModel:getOccupyPlayerMoveEndStamp(...)
	local uid = self:getOccupyUid()

	if uid then
		return self.controlCenter.getPlayerMoveEndStamp(uid)
	end
end

function CirCleGridModel:showEffect(effectType, isShow)
	if effectType == EFFECT_TYPE.SEARCH_OTHER or effectType == EFFECT_TYPE.SEARCH_MINE then
		self:releaseEffect(effectType)
	end

	local id = self.effectMap[effectType]
	local controller

	if id then
		controller = EffectManager:getController(id)

		if not controller then
			self.effectMap[effectType] = nil
		end
	end

	if isShow and not controller then
		local info = EFFECT_PATH[effectType]

		if info then
			local _id, _controller = self:createEffect(effectType)

			controller = _controller

			if _id then
				self.effectMap[effectType] = _id
			end
		end
	end

	if controller then
		if isShow then
			controller:TurnOn()
		else
			self:releaseEffect(effectType)
		end
	end
end

function CirCleGridModel:createEffect(effectType, angle)
	local info = EFFECT_PATH[effectType]

	if info then
		local instId, controller = EffectManager:loadLogicEffect(info.path)

		controller:SetLayer("Effect")

		local pos = self.pos

		controller:SetNormalEffect(nil, "", pos, Vector3(0, angle or 0, 0), 0)

		if EFFECT_TYPE.MONSTER_WEAK == effectType then
			local type = self:getOccupyModelType()

			if type == 1 then
				info.scale = 0.9
			elseif type == 2 then
				info.scale = 1
			elseif type == 3 then
				info.scale = 1.8
			end
		end

		controller:ScaleTheEffect(info.scale, info.scale, info.scale)

		return instId, controller
	end
end

function CirCleGridModel:checkEffectWillShow(force)
	if force or self.status ~= self.preStatus then
		self:checkCanOpenEffect(true)
	end

	if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER and self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		if self.preStatus ~= self.status then
			self:onMonsterKilled()
		end
	elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and self.status == Const.CIRCLE_GRID_STATUS.OPEN and self.preStatus ~= self.status then
		self:checkBossAroundState()
	end
end

function CirCleGridModel:showCanOpenEffect(v)
	self:showEffect(EFFECT_TYPE.CAN_OPEN, v)
end

function CirCleGridModel:checkShowMonsterWeakEffect(v)
	if (self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS or self.openType == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER) and self.status == Const.CIRCLE_GRID_STATUS.SHOW then
		self:showEffect(EFFECT_TYPE.MONSTER_WEAK, v)
	end
end

function CirCleGridModel:showPlayerEffect(uid, effectType, isShow, angle)
	local controller

	if isShow then
		local info = self.effectPlayerMap[uid]

		if info then
			local id = info[effectType]

			if id then
				controller = EffectManager:getController(id)
			else
				local _id, _controller = self:createEffect(effectType, angle)

				if _id then
					controller = _controller
					self.effectPlayerMap[uid][effectType] = _id
				end
			end
		else
			self.effectPlayerMap[uid] = {}

			local _id, _controller = self:createEffect(effectType, angle)

			if _id then
				controller = _controller
				self.effectPlayerMap[uid][effectType] = _id
			end
		end

		if controller then
			controller:TurnOn()
		end
	else
		local info = self.effectPlayerMap[uid]

		if info then
			local id = info[effectType]

			if id then
				self:releasePlayerEffect(uid, effectType)
			end
		end
	end

	return controller
end

function CirCleGridModel:showPathTip(uid, isShow, angle)
	if Const.CIRCLE_GRID_TYPE.START[self.gridType] then
		return
	end

	if isShow then
		local controller = self:showPlayerEffect(uid, EFFECT_TYPE.PATH_TIP, true, angle)

		if controller then
			-- block empty
		end
	else
		self:showPlayerEffect(uid, EFFECT_TYPE.PATH_TIP, false)
	end
end

function CirCleGridModel:getStatus(...)
	return self.status
end

function CirCleGridModel:onClickPlayer(...)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state and state:isFarMode() then
		return
	end

	local uids = self:getUponUids()

	if uids and #uids > 0 then
		local _uids = {}

		for i, info in ipairs(uids) do
			table.insert(_uids, info.uid)
		end

		UIManager.getUI("circleBattleMorePlayerDlg", true):setData(_uids)
	end
end

function CirCleGridModel:checkClickCondition(...)
	local state = GameFsm.getState(Const.STATE_MAIN_CIRCLE)

	if state and state:isFarMode() then
		return false
	end

	if self.occupyUid then
		if self.occupyUid == CurAvatar.uid then
			if CurAvatar.myCircle then
				local info = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

				if info and info.battle_data.oppos == self.index - 1 then
					if info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.SEARCH then
						local layer = self.controlCenter.getLayer()

						CurAvatar:tryCallCircleBattleRpc("clanBattleCancelGrid", layer, self.index - 1)
					else
						self:openMonsterInfo()
					end
				end
			end
		else
			local info = CurAvatar.myCircle:getCircleMember(self.occupyUid)

			if info then
				if info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.SEARCH then
					MsgManager.clientNotice(521)
				else
					MsgManager.clientNotice(543)
				end
			else
				MsgManager.clientNotice(521)
			end
		end

		return false
	end

	if self.controlCenter.isPlayerMoving(CurAvatar.uid) then
		return false
	end

	if CurAvatar.myCircle then
		local info = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)
		local tick = -1

		if info then
			tick = info.battle_data.cancel_tick
		end

		if tick + Const.CIRCLE_CLICK_GRID_INTERVAL > ClientUtils.getServerTime() then
			MsgManager.clientNotice(522)

			return false
		end

		if info.battle_data.optype ~= Const.CIRCLE_PLAYER_STATE.NONE then
			return false
		end

		if self:isHideCanOpen() then
			local point = self:getOprateCostPoint()

			if point and point > CurAvatar.myCircle:getActionPoint() then
				MsgManager.clientNotice(523)

				return false
			end
		end
	end

	return true
end

function CirCleGridModel:onClick(r, c)
	if self.controlCenter.checkOpenMarkGridPanel then
		self:onClickMarkGrid()

		return
	end

	local uids = self:getUponUids()

	if uids and #uids > 0 then
		self:onClickPlayer()

		return
	end

	if not self:checkClickCondition() then
		return
	end

	if Const.CIRCLE_GRID_TYPE.NORMAL[self.gridType] then
		if self.status ~= Const.CIRCLE_GRID_STATUS.OPEN then
			if self.status == Const.CIRCLE_GRID_STATUS.GUARD or self.status == Const.CIRCLE_GRID_STATUS.PREVIEW_GUARD then
				MsgManager.clientNotice(524)
			elseif self.status == Const.CIRCLE_GRID_STATUS.SHOW then
				if self:_canOpen() then
					if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
						self:openMonsterInfo()
					elseif self.openType == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER then
						self:openMonsterInfo()
					end
				end
			elseif self:_canOpen() then
				if not self.occupyUid then
					UIManager.showConfirmWithId(1049, Slot(self.occupy, self))
				else
					MsgManager.clientNotice(525)
				end
			end
		else
			MsgManager.clientNotice(594)
		end
	elseif Const.CIRCLE_GRID_TYPE.END[self.gridType] then
		local result, info = self.controlCenter.canChangeLayer()

		if result then
			UIManager.getUI("circleBattleEndDlg", true)
		else
			MsgManager.notice(info)
		end
	end
end

function CirCleGridModel:getOprateCostPoint(...)
	if CurAvatar.myCircle then
		if (self.openType == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER or self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS) and self.status ~= Const.CIRCLE_GRID_STATUS.PREVIEW then
			return CurAvatar.myCircle:getFightMonsterPointCost(self.gridInfo.param)
		else
			return CurAvatar.myCircle:getOpenGridPointCost()
		end
	end
end

function CirCleGridModel:openMonsterInfo(...)
	local info = ResClanBattleMonster[self.gridInfo.param]

	if info then
		local id = math.max(2, info.type)
		local uiName = "circleBattleMonsterInfo" .. id .. "Dlg"

		UIManager.getUI(uiName, true):setData(self.gridInfo.param, self.index)
	end
end

function CirCleGridModel:_canOpen()
	local grid
	local nearData = self:getNearData()

	for index, _ in pairs(nearData) do
		grid = self.controlCenter.getGridByIndex(index)

		if grid and grid:isOpen() and grid:isCanMoveHere() then
			return true
		end
	end
end

function CirCleGridModel:getNearData(...)
	if self.nearData == nil then
		self:_initNearInfo()
	end

	return self.nearData
end

function CirCleGridModel:_initNearInfo(...)
	self.nearData = {}
	self.diagonalNearData = {}

	local rowMap = {}
	local colMap = {}

	for r = self.row, self.row + self.data.range[2] - 1 do
		rowMap[r] = 1
	end

	for c = self.col, self.col + self.data.range[1] - 1 do
		colMap[c] = 1
	end

	for r, _ in pairs(rowMap) do
		for c, _ in pairs(colMap) do
			for i = -1, 1 do
				for j = -1, 1 do
					local _r, _c = r + i, c + j

					if rowMap[_r] and colMap[_c] then
						-- block empty
					elseif not rowMap[_r] and not colMap[_c] then
						if self.controlCenter.checkRC(_r, _c) then
							local index = self.controlCenter.rowColToIndex(_r, _c)

							self.diagonalNearData[index] = true
						end
					elseif self.controlCenter.checkRC(_r, _c) then
						local index = self.controlCenter.rowColToIndex(_r, _c)

						self.nearData[index] = true
					end
				end
			end
		end
	end
end

function CirCleGridModel:getDiagonalNearData(...)
	if self.diagonalNearData == nil then
		self:_initNearInfo()
	end

	return self.diagonalNearData
end

function CirCleGridModel:isBossShowing(...)
	return self.openType == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and self.status == Const.CIRCLE_GRID_STATUS.SHOW
end

function CirCleGridModel:isCanMoveHere(...)
	local path = self.controlCenter.getMovePath(self.controlCenter.startIndex, self.index)

	return path ~= nil
end

function CirCleGridModel:isNearBossShow(...)
	local data = self:getNearData()

	for i, _ in pairs(data) do
		local grid = self.controlCenter.getGridByIndex(i)

		if grid and grid:isBossShowing() then
			return true
		end
	end

	data = self:getDiagonalNearData()

	for i, _ in pairs(data) do
		local grid = self.controlCenter.getGridByIndex(i)

		if grid and grid:isBossShowing() then
			return true
		end
	end
end

function CirCleGridModel:isOpen(...)
	if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.HINDER then
		return false
	elseif Const.CIRCLE_GRID_TYPE.START[self.gridType] then
		return true
	else
		return self.status == Const.CIRCLE_GRID_STATUS.OPEN
	end
end

function CirCleGridModel:checkCanOpenEffect(isCheckNear)
	if self:isHideCanOpen() then
		self:showCanOpenEffect(true)
	end

	if isCheckNear and self:isOpen() then
		local nearData = self:getNearData()

		for i, _ in pairs(nearData) do
			local grid = self.controlCenter.getGridByIndex(i)

			if grid then
				grid:checkCanOpenEffect(false)
			end
		end
	end
end

function CirCleGridModel:isHideCanOpen(...)
	if self.status == Const.CIRCLE_GRID_STATUS.OPEN then
		return false
	end

	if not Const.CIRCLE_GRID_TYPE.NORMAL[self.gridType] then
		return false
	end

	if self.status == Const.CIRCLE_GRID_STATUS.HIDE or self.status == Const.CIRCLE_GRID_STATUS.PREVIEW then
		return self:_canOpen()
	else
		return false
	end
end

function CirCleGridModel:isEndGrid(...)
	return Const.CIRCLE_GRID_TYPE.END[self.gridType]
end

function CirCleGridModel:occupy(...)
	if self.openType == Const.CIRCLE_GRID_OPEN_TYPE.SHOW or self.openType == Const.CIRCLE_GRID_OPEN_TYPE.OPEN then
		MsgManager.clientNotice(594)

		return
	end

	if self.occupyUid and self.occupyUid ~= CurAvatar.uid then
		MsgManager.clientNotice(521)

		return
	end

	local checkPath = self.controlCenter.getMyServerCheckPath(self.index)

	if not self.controlCenter.isLayerChange() and checkPath then
		local layer = self.controlCenter.getLayer()

		CurAvatar:tryCallCircleBattleRpc("clanBattleOccupyGrid", layer, self.index - 1, checkPath)
	end
end

function CirCleGridModel:refreshMarkedEffect()
	local checkMarked = false
	local checkSelfMark = false

	if CurAvatar.myCircle and CurAvatar.myCircle:checkCanOpenGridPartCondition(self.index) then
		checkMarked, checkSelfMark = CurAvatar.myCircle:checkGridMarked(self.index)
	end

	if self.checkMarked then
		if self.showMyMark then
			self:showEffect(EFFECT_TYPE.FLAG_MINE, false)

			self.showMyMark = false
		elseif self.showOtherMark then
			self:showEffect(EFFECT_TYPE.FLAG_OTHER, false)

			self.showOtherMark = false
		end
	end

	self:showMarkedEffect(checkMarked, checkSelfMark, true)
end

CirCleGridModel.animatorType = typeof(UnityEngine.Animator)

function CirCleGridModel:showMarkedEffect(checkMarked, checkSelfMark, noAnim)
	if checkMarked then
		self.checkMyMark = checkSelfMark

		local effectType = self.checkMyMark and EFFECT_TYPE.FLAG_MINE or EFFECT_TYPE.FLAG_OTHER

		self:showEffect(effectType, true)

		if not noAnim then
			local id = self.effectMap[effectType]
			local controller

			if id then
				controller = EffectManager:getController(id)

				local animator = controller.gameObject:GetComponent(CirCleGridModel.animatorType)

				if animator then
					animator:Play("show")
				end
			end
		end

		self.checkMarked = true
	elseif not noAnim then
		local effectType = self.checkMyMark and EFFECT_TYPE.FLAG_MINE or EFFECT_TYPE.FLAG_OTHER
		local id = self.effectMap[effectType]
		local controller

		if id then
			controller = EffectManager:getController(id)

			local animator = controller.gameObject:GetComponent(CirCleGridModel.animatorType)

			if animator then
				animator:Play("hide")
			end
		end

		self.checkMarked = false
		self.checkMyMark = false
	else
		if self.checkMyMark then
			self:showEffect(EFFECT_TYPE.FLAG_MINE, false)
		else
			self:showEffect(EFFECT_TYPE.FLAG_OTHER, false)
		end

		self.checkMarked = false
		self.checkMyMark = false
	end
end

function CirCleGridModel:refreshCanMarkEffect()
	self.checkCanMark = false
	self.markTip = nil

	if CurAvatar.myCircle then
		self.checkCanMark, self.markTip = CurAvatar.myCircle:checkCanMarkGrid(self.index)
	end

	self:showCanMarkEffect(self.checkCanMark)
end

function CirCleGridModel:showCanMarkEffect(check)
	self:showEffect(EFFECT_TYPE.CAN_FLAG, check)
end

function CirCleGridModel:onClickMarkGrid()
	if self.checkMarked and self.checkMyMark or self.checkCanMark then
		if CurAvatar.myCircle then
			CurAvatar.myCircle:onClickMarkGrid(self.index)
		end
	elseif self.markTip then
		MsgManager.notice(self.markTip)
	end
end

function CirCleGridModel:destroyOccupyModel(...)
	if self.occupyModel then
		self.occupyModel:destroy()

		self.occupyModel = nil
	end
end

function CirCleGridModel:releasePlayerEffect(uid, effectType, isAll)
	if isAll then
		for uid, info in pairs(self.effectPlayerMap) do
			for t, id in pairs(info or {}) do
				EffectManager:releaseEffect(id)
			end
		end

		self.effectPlayerMap = {}

		return
	end

	local info = self.effectPlayerMap[uid]

	if info and info[effectType] then
		EffectManager:releaseEffect(info[effectType])

		info[effectType] = nil
	end
end

function CirCleGridModel:releaseEffect(effectType)
	if effectType then
		local id = self.effectMap[effectType]

		if id then
			EffectManager:releaseEffect(id)
		end

		self.effectMap[effectType] = nil
	else
		for _, id in pairs(self.effectMap) do
			EffectManager:releaseEffect(id)
		end

		self.effectMap = {}
	end
end

function CirCleGridModel:destroyModel(...)
	if self.model then
		self.model:destroy()

		self.model = nil
	end
end

function CirCleGridModel:destroy(...)
	if self._coPlay then
		coroutine.stop(self._coPlay)
	end

	if self.logo then
		self.controlCenter.returnLogo(self.logo)
	end

	if self.barTimer then
		self.barTimer:Stop()

		self.barTimer = nil
	end

	self:destroyOccupyModel()
	self:destroyModel()

	if self.tempModel then
		self.tempModel:destroy()

		self.tempModel = nil
	end

	self:releaseEffect()
	self:releasePlayerEffect(nil, nil, true)

	self.transform = nil
	self.tempTransform = nil
end

return CirCleGridModel
