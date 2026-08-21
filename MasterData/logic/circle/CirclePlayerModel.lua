-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Circle\\CirclePlayerModel.lua

local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local BoxCollider = typeof(UnityEngine.BoxCollider)
local DragUtils = Framework.Drag.DragUtils
local Model = require("Entity/Model")
local ModelTool = require("Entity/ModelTool")
local ResClanBattleMonster = require("ClientData/ResClanBattleMonster")
local CircleCommonModel = require("Logic/Circle/CircleCommonModel")
local strClassName = "CirclePlayerModel"
local CirclePlayerModel = Class(strClassName, CircleCommonModel)

function CirclePlayerModel:ctor(...)
	self.tweenCom = self.transform.gameObject:AddComponent(DOTweenComponent)
end

function CirclePlayerModel:setParent(...)
	local parent = self.controlCenter.getHeroRootTran()

	if parent then
		self.transform.parent = parent
	end
end

function CirclePlayerModel:createModel(isHigh)
	local model

	if isHigh then
		self.highModel = Model(Slot(self._highLoadedCallBack, self))
		model = self.highModel
	else
		self.model = Model(self.slotCallBack)
		model = self.model
	end

	model:setModelData(self:getHeroModelData(isHigh))
	model:loadGameObject(false, false)
end

function CirclePlayerModel:_loadedCallBack(...)
	local go = self.model.modelGameObject

	self.controller:InitModelAfterLoaded(go)
	ModelTool.addBaseModel(self.model:getModelInsId(), self.data.baseId or self.data.modelId, 1, Const.HERO_BASE_TYPE.Rear)

	if self.data.uid == CurAvatar.uid and not self.logo then
		self.logo = self.controlCenter.getLogo(Const.CIRCLE_LOGO_TYPE.PLAYER, self)
	end

	self.controlCenter.showModel(self.data.uid, self._visible)

	self.isModelLoaded = true
end

function CirclePlayerModel:_highLoadedCallBack(...)
	local go = self.highModel.modelGameObject

	self.controller:InitModelAfterLoaded(go)
	ModelTool.addBaseModel(self.highModel:getModelInsId(), self.data.baseId or self.data.modelId, 1, Const.HERO_BASE_TYPE.Rear)

	self.isHighModelLoaded = true

	self:_checkShowModel()
end

function CirclePlayerModel:checkLodModel(isShowHigh)
	if isShowHigh == self.showHighModel then
		return
	end

	self.showHighModel = isShowHigh

	self:_checkShowModel()
end

function CirclePlayerModel:_checkShowModel(...)
	if self.showHighModel then
		if self.isHighModelLoaded then
			if self.highModel then
				self.highModel:setVisible(true)
			end

			if self.model then
				self.model:setVisible(false)
			end
		elseif self.highModel then
			if self.model then
				self.model:setVisible(true)
			end
		else
			self:createModel(true)
		end
	elseif self.isHighModelLoaded then
		if self.highModel then
			self.highModel:setVisible(false)
		end

		if self.model then
			self.model:setVisible(true)
		end
	elseif self.model then
		self.model:setVisible(true)
	end
end

function CirclePlayerModel:getHeroModelData(high)
	local modelData = {}

	modelData.model_type = Const.MODEL_TYPE.RearHouse
	modelData.model_id = self.data.modelId

	if high then
		modelData.use_lod = Const.MODEL_LOD_LV1
	else
		modelData.use_lod = Const.MODEL_LOD_LV2
	end

	local animator = ModelTool.getAnimator(modelData.model_id, Const.MODEL_TYPE.RearHouse)

	if animator then
		modelData.animator = animator
	end

	return modelData
end

function CirclePlayerModel:refreshModel(...)
	if CurAvatar.myCircle then
		local battleData = CurAvatar.myCircle:getMyBattleMemberData()

		if battleData then
			local modelData = battleData.model
			local hero = BaseObject.GetObject(modelData.resid)

			if hero then
				hero:setBase(modelData.base)
				hero:setSkin(modelData.skin)

				self.data.modelId = hero:getShowModelId()
				self.data.baseId = hero:getShowBaseModelId()

				self:_destroyLow()
				self:createModel()
			end
		end
	end
end

function CirclePlayerModel:showMyLogoAni(...)
	if self.logo then
		self.logo:showMyAni(true)
	end
end

function CirclePlayerModel:getPlayerOpTick(...)
	if CurAvatar.myCircle then
		local member = CurAvatar.myCircle:getCircleMember(self.data.uid)

		if member and member.battle_data then
			return member.battle_data.optick
		end
	end

	return -1
end

function CirclePlayerModel:move(endIndex, path, targetIndex)
	if not self.opInvalid then
		local grid = self.controlCenter.getGridByIndex(endIndex)

		if grid then
			self.pathTip = nil

			if self.tweenCom then
				self.controlCenter.leaveGrid(self.data.uid)

				if path == nil then
					self._moveEndStamp = ClientUtils.getServerTime()
				else
					local data = {
						tween = {}
					}
					local pathTip = {}
					local rotateNum, moveNum = 0, 0
					local startIndex = self.controlCenter.getModelCurIndex(self.data.uid)
					local preAngle = self.transform.eulerAngles.y

					if startIndex > 0 then
						local angle = self:_getAngle(startIndex, path[1] or targetIndex)

						if math.abs(angle - preAngle) > 45 then
							preAngle = angle
							rotateNum = rotateNum + 1

							table.insert(data.tween, self:_getRotateTweenData(1, angle, 0))
						end
					end

					for i, _index in ipairs(path) do
						moveNum = moveNum + 1

						table.insert(data.tween, self:_getMoveTweenData(1, _index, 0))

						if i == #path then
							local angle = self:_getAngle(_index, targetIndex)

							if math.abs(angle - preAngle) > 45 then
								preAngle = angle
								rotateNum = rotateNum + 1

								table.insert(data.tween, self:_getRotateTweenData(1, angle, 0))
							end
						else
							local angle = self:_getAngle(_index, path[i + 1])

							if math.abs(angle - preAngle) > 45 then
								preAngle = angle
								rotateNum = rotateNum + 1

								table.insert(data.tween, self:_getRotateTweenData(1, angle, 0))
							end
						end

						table.insert(pathTip, {
							index = _index,
							angle = preAngle
						})
					end

					local originTimeCost = moveNum * Const.CIRCLE_MODEL_SINGLE_MOVE_TIME + rotateNum * Const.CIRCLE_MODEL_SINGLE_ROTATE_TIME
					local timeCost = originTimeCost

					if timeCost > Const.CIRCLE_MODEL_MAX_MOVE_TIME then
						timeCost = Const.CIRCLE_MODEL_MAX_MOVE_TIME
					end

					local overStamp = os.time() + timeCost
					local ratio = timeCost / originTimeCost

					for i, info in ipairs(data.tween) do
						if info.type ~= "rotate" then
							info.duration = Const.CIRCLE_MODEL_SINGLE_MOVE_TIME * ratio
						else
							info.duration = Const.CIRCLE_MODEL_SINGLE_ROTATE_TIME * ratio
						end
					end

					data.cb = Functor(self._tweenOverCB, self, overStamp, targetIndex, endIndex)

					self:setOpInvalid(true)

					if moveNum > 0 then
						self.pathTip = pathTip

						self:_onMoveStart()
					end

					if moveNum + rotateNum > 0 then
						self.tweenCom:DoSequence(data)
					else
						data.cb()
					end

					self._moveEndStamp = ClientUtils.getServerTime() + timeCost

					self:_delayOpen(targetIndex, endIndex, timeCost)
				end
			end
		end
	end
end

function CirclePlayerModel:_getMoveTweenData(ease, index, duration)
	local t = {}

	t.type = "move"
	t.ease = ease
	t.isJoin = false
	t.endValue = self.controlCenter.indexToModelPos(index, true)
	t.duration = duration

	return t
end

function CirclePlayerModel:_getRotateTweenData(ease, angle, duration)
	local t = {}

	t.type = "rotate"
	t.ease = ease
	t.isJoin = false

	local yAngle = angle + 360

	t.endValue = Vector3(0, yAngle, 0)
	t.duration = duration

	return t
end

function CirclePlayerModel:_getAngle(preIndex, nextIndex)
	local prePos = self.controlCenter.indexToPos(preIndex)
	local nextPos = self.controlCenter.indexToPos(nextIndex)
	local angle = Vector3.Angle(Vector3.forward, nextPos - prePos)
	local vec = Vector3.Cross(Vector3.forward, nextPos - prePos)
	local a = vec.y > 0 and angle or -angle

	return a
end

function CirclePlayerModel:_onMoveStart(...)
	if self.pathTip then
		for i, info in ipairs(self.pathTip) do
			local grid = self.controlCenter.getGridByIndex(info.index)

			if grid then
				grid:showPathTip(self.data.uid, true, info.angle - 90)
			end
		end
	end
end

function CirclePlayerModel:_onMoveEnd(endIndex)
	if not self.controlCenter.inited then
		return
	end

	self.controlCenter.uponGrid(self.data.uid, endIndex)

	if self.pathTip then
		for i, info in ipairs(self.pathTip) do
			local grid = self.controlCenter.getGridByIndex(info.index)

			if grid then
				grid:showPathTip(self.data.uid, false, info.angle)
			end
		end
	end
end

function CirclePlayerModel:getMoveEndStamp(...)
	return self._moveEndStamp
end

function CirclePlayerModel:_tweenOverCB(overStamp, targetIndex, endIndex)
	self:setOpInvalid(false)
	self:_onMoveEnd(endIndex)

	if self.data.uid ~= CurAvatar.uid or not CurAvatar.myCircle then
		return
	end

	local member = CurAvatar.myCircle:getCircleMember(self.data.uid)
	local grid = self.controlCenter.getGridByIndex(targetIndex)

	if false and grid and grid:isBossShowing() then
		self:_enterFormation(targetIndex)
	elseif member and member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION and member.battle_data.oppos == targetIndex - 1 then
		self:_enterFormation(targetIndex)
	end
end

function CirclePlayerModel:_enterFormation(targetIndex)
	local gridInfo = CurAvatar.myCircle:getGridInfo(targetIndex)

	if gridInfo and gridInfo.param then
		local config = ResClanBattleMonster[gridInfo.param]

		if config then
			local layer = self.controlCenter.getLayer()
			local battleData = {}

			battleData.circleBattleData = {}
			battleData.circleBattleData.layer = layer
			battleData.circleBattleData.serverGridPos = targetIndex - 1
			battleData.circleBattleData.isBoss = config.type == Const.CIRCLE_BATTLE_BOSS

			local optick = 0
			local data = CurAvatar.myCircle:getMyBattleMemberData()

			if data then
				optick = data.optick or 0
			end

			battleData.circleBattleData.optick = optick

			CurAvatar:enterFormation(config.pveid, BattleConst.BATTLE_TYPE_CIRCLE, battleData)
			UIManager.getUI("circleBattleFormationLoadingDlg", true)
			self.controlCenter.showAllLogos(false)
		end
	end
end

function CirclePlayerModel:_delayOpen(targetIndex, endIndex, timeCost)
	if not CurAvatar.myCircle then
		return
	end

	local member = CurAvatar.myCircle:getCircleMember(self.data.uid)

	if not member or member.battle_data.optype ~= Const.CIRCLE_PLAYER_STATE.SEARCH then
		return
	end

	if self.tweenTimer then
		self.tweenTimer:Stop()
	end

	self.tweenTimer = Timer.New(Functor(self._timerCB, self, targetIndex, endIndex), Const.CIRCLE_OCCUPY_CANCEL_TIME + timeCost, 1)

	self.tweenTimer:Start()
end

function CirclePlayerModel:_realOpen(targetIndex, endIndex)
	if self.data.uid ~= CurAvatar.uid then
		return
	end

	local grid = self.controlCenter.getGridByIndex(targetIndex)

	if grid and grid:getOccupyUid() == CurAvatar.uid and not grid:isOpen() then
		local layer = self.controlCenter.getShowLayer()

		CurAvatar:tryCallCircleBattleRpc("clanBattleOpenGrid", layer, targetIndex - 1)
	end
end

function CirclePlayerModel:_timerCB(targetIndex, endIndex)
	self:_realOpen(targetIndex, endIndex)
end

function CirclePlayerModel:setOpInvalid(v)
	if self.data.uid ~= CurAvatar.uid then
		return
	end

	self.opInvalid = v
end

function CirclePlayerModel:showOnEndGrid(...)
	local pos = self.controlCenter.getEndPos()

	if pos then
		pos.y = pos.y + Const.CIRCLE_MODEL_YOFFSET + 0.1

		self:setPos(pos)
	end
end

function CirclePlayerModel:showOnTrain(trainModel)
	if trainModel then
		local tran = trainModel:getTransform("guadian")

		if tran then
			EffectManager:getFreedomEffectAsync("Effects/Scene/efx_ghz_zhuomian_11_01.prefab", self.transform.position, Vector3.zero, true)

			if self.transform then
				self.transform.parent = tran
				self.transform.localPosition = Vector3(0, Const.CIRCLE_MODEL_YOFFSET + 0.1, 0)
				self.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			EffectManager:getFreedomEffectAsync("Effects/Scene/efx_ghz_zhuomian_11_02.prefab", self.transform.position, Vector3.zero, true)
		end
	end
end

function CirclePlayerModel:leaveTrain(...)
	local tran = self.controlCenter.getHeroRootTran()

	if tran and self.transform then
		self.transform.parent = tran
	end
end

function CirclePlayerModel:onClick(...)
	return
end

function CirclePlayerModel:isMoving(...)
	return self.opInvalid
end

function CirclePlayerModel:showMsg(...)
	return
end

function CirclePlayerModel:reset(...)
	if self.tweenCom and not tolua.isnull(self.tweenCom) then
		self.tweenCom:KillTween()
	end

	if self.tweenTimer then
		self.tweenTimer:Stop()

		self.tweenTimer = nil
	end

	self._moveEndStamp = nil

	if self.logo then
		self.controlCenter.returnLogo(self.logo)
	end

	self.logo = nil

	self:setOpInvalid(false)
end

function CirclePlayerModel:destroy(...)
	self:reset()
	CirclePlayerModel.super.destroy(self)
end

return CirclePlayerModel
