-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monopoly/controller/MonopolyController.lua

module("logic.extensions.Monopoly.controller.MonopolyController", package.seeall)

local MonopolyController = class("MonopolyController", BaseController)

function MonopolyController:onInit()
	MonopolyController.super.onInit(self)
	self:onReset()
end

function MonopolyController:onReset()
	self.getInfoCallBackList = nil
	self._towerInfoLoaded = false
	self._createSaizi = nil
	self._saiziRotating = false
	self._saiziDoneCallBack = nil
	self._commonSaizi = nil
	self._closeAnim = nil
	self.randomNum = 1
	self.callBackList = nil

	self:destroyAnimationSaiziTimer()
	self:clearSaiziRes()
	MonopolyAgent.instance:reset()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialItemChange, self._updateRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self._updateRedpoint, self)
end

function MonopolyController:getMonopolyInfo(callBack)
	self.getInfoCallBackList = self.getInfoCallBackList or {}

	table.insert(self.getInfoCallBackList, callBack)
	MonopolyAgent.instance:sendPM_GetMyMonopolyInfoReq(checknumber(MonopolyModel.instance:getActivityId()), function(msg)
		MonopolyModel.instance:setCurRound(msg.round)
		MonopolyModel.instance:setCurPosition(msg.step + 1)
		MonopolyModel.instance:setHasBuyDiceTimes(msg.hasBuyDiceTimes)

		for k, v in ipairs(msg.stepInfos) do
			MonopolyModel.instance:setStepLevel(v.step, v.level)
		end

		MonopolyModel.instance:setLastTimeStamp()

		for k, v in pairs(self.getInfoCallBackList) do
			GameUtil.callBack(v)
		end

		self.getInfoCallBackList = nil
	end)
end

function MonopolyController:go(pointedForward, callBack)
	self.callBackList = self.callBackList or {}

	table.insert(self.callBackList, callBack)
	MonopolyAgent.instance:sendPM_MonopolyDiceReq(MonopolyModel.instance:getActivityId(), pointedForward, function(msg)
		MonopolyModel.instance:setCurRound(msg.round)
		MonopolyModel.instance:setCurPosition(msg.step + 1)
		MonopolyModel.instance:setStepLevelAdd1(msg.step)
		self:restoreCiList(msg.changeSetId)

		if msg.eventId and msg.eventId ~= 0 then
			MonopolyModel.instance:SaveRandomEvent(msg.eventId, msg.eventForward)
			MonopolyModel.instance:setStepLevelAdd1(msg.step)
		end

		for k, v in pairs(self.callBackList) do
			GameUtil.callBack(v, msg, pointedForward)
		end

		self.callBackList = nil
	end)
end

function MonopolyController:resetCiList()
	self.ciList = {}
end

function MonopolyController:restoreCiList(changeSetId)
	MaterialController.instance:saveChangeSetToTemp(changeSetId)
	table.insert(self.ciList, checknumber(changeSetId))
end

function MonopolyController:showMonopolyCI()
	if self.ciList then
		MaterialController.instance:showChangeSetInTemp(self.ciList)

		self.ciList = {}
	end
end

function MonopolyController:getIfDiceEnough()
	local activityId = MonopolyModel.instance:getActivityId()
	local consume = MonopolyConfig.instance:getMonopolyConfigById(activityId).commonDecMp
	local arr = string.split(consume, ":")
	local useNum = checknumber(arr[3])
	local has_num = MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))

	if has_num < useNum then
		return false
	else
		return true
	end
end

function MonopolyController:buyDice(num)
	local activityId = MonopolyModel.instance:getActivityId()
	local curBuyDiceTimes = MonopolyModel.instance:getHasBuyDiceTimes()

	MonopolyAgent.instance:sendPM_BuyDiceTimesReq(activityId, curBuyDiceTimes, num, function(msg)
		MonopolyModel.instance:setHasBuyDiceTimes(msg.hasBuyDiceTimes)
		UIStateManager.instance:popByName(ViewName.SellcellView)
		self:notify(GlobalNotify.MonopolyDiceCount, msg)
	end)
end

function MonopolyController:getDiceNum()
	local activityId = MonopolyModel.instance:getActivityId()
	local consume = MonopolyConfig.instance:getMonopolyConfigById(activityId).commonDecMp
	local arr = string.split(consume, ":")

	return MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))
end

function MonopolyController:getIfControlDiceEnough()
	local activityId = MonopolyModel.instance:getActivityId()
	local consume = MonopolyConfig.instance:getMonopolyConfigById(activityId).pointedDecMp
	local arr = string.split(consume, ":")
	local useNum = checknumber(arr[3])
	local has_num = MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))

	if has_num < useNum then
		return false
	else
		return true
	end
end

function MonopolyController:getControlDiceNum()
	local activityId = MonopolyModel.instance:getActivityId()
	local consume = MonopolyConfig.instance:getMonopolyConfigById(activityId).pointedDecMp
	local arr = string.split(consume, ":")

	return MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))
end

function MonopolyController:createSaizi()
	self._resLoader = MultiResLoader.New()
	self.resourcesList = {}

	table.insert(self.resourcesList, (self._commonSaizi == nil or nil) and "effect/prefabs/ui/fx_ui_saizi/fx_ui_saizi.prefab")
	self._resLoader:setResPaths(self.resourcesList)
	self._resLoader:load(function()
		self._saiziRes = self._resLoader:getResource(self.resourcesList[1])

		if self._saiziRes then
			local prefab = self._saiziRes:GetMainAsset()

			if prefab then
				self._saiziViewGo = goutil.clone(prefab)
				self.saiziGo = goutil.findChild(self._saiziViewGo, "camera/saiziobj/sz")

				if self.saiziGo then
					self.curRotateX = 10
					self.curRotateY = 200
					self.curRotateZ = 90

					local root = goutil.find("SCENEROOT")

					goutil.addChildToParent(self._saiziViewGo, root)
					Framework.TransformUtil.SetLocalRotation(self._saiziViewGo.transform, 0, 0, 0)

					self._saiziobj = goutil.findChild(self._saiziViewGo, "camera/saiziobj")

					GameUtil.setLocalPos(self._saiziobj, 2000, 2000, 2000)

					self._saiziRotating = false

					self:rotateSaizi(self._commonSaizi, self._closeAnim, self.randomNum, self._saiziDoneCallBack)
				end
			end
		end
	end, nil, self)
end

function MonopolyController:clearSaiziRes()
	if self._saiziViewGo then
		goutil.destroy(self._saiziViewGo.gameObject)

		self._saiziViewGo = nil
	end

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	self._saiziRes = nil
	self._createSaizi = nil
	self._saiziRotating = false
	self._saiziDoneCallBack = nil
	self._commonSaizi = nil
	self._closeAnim = nil
	self.randomNum = 1
end

function MonopolyController:rotateSaizi(_commonSaizi, _closeAnim, _randomNum, _callBack)
	if self._saiziRotating then
		return
	end

	self._saiziRotating = true
	self._commonSaizi = _commonSaizi
	self._saiziDoneCallBack = _callBack
	self._closeAnim = _closeAnim
	self.randomNum = _randomNum or 1

	if not self._createSaizi then
		self._createSaizi = true
		self._saiziSlowAngleRange = 5
		self._saiziSlowAngle = self._saiziSlowAngleRange * 2 - 1

		self:createSaizi()

		return
	end

	if self._closeAnim then
		self:_quickShowResult()

		return
	end

	local _durTime = 0.8
	local _randomX = math.random(0, 118)
	local _randomY = math.random(-50, 25)
	local bezier = UnityTweens.TweenBezier.StartTween(self._saiziobj, Vector3.New(_randomX, _randomY, 176), Vector3.New(57, 0, 176), Vector3.New((57 - _randomX) / 2, (0 - _randomY) / 2, 176), _durTime, UnityTweens.EaseType.easeInSine)

	if self.saiziGo then
		settimer(0.01, self._animationSaizi, self, true)
	end
end

function MonopolyController:_animationSaizi()
	self.curRotateCount = self.curRotateCount or 0

	if self.curRotateCount > 50 then
		self:_animationSaiziSlow()
	else
		self.curRotateCount = self.curRotateCount + 1

		local _randomRotate = 10

		self.curRotateX = self.curRotateX + _randomRotate
		self.curRotateY = self.curRotateY + _randomRotate + 3
		self.curRotateZ = self.curRotateZ + _randomRotate + 6

		Framework.TransformUtil.SetLocalRotation(self.saiziGo.transform, self.curRotateX, self.curRotateY, self.curRotateZ)
	end
end

function MonopolyController:_quickShowResult()
	local saiziPlane = {
		{
			280,
			290,
			260
		},
		{
			350,
			190,
			0
		},
		{
			300,
			280,
			0
		},
		{
			280,
			10,
			0
		},
		{
			10,
			20,
			310
		},
		{
			340,
			280,
			170
		}
	}
	local _saiziPlaneX = saiziPlane[self.randomNum][1]
	local _saiziPlaneY = saiziPlane[self.randomNum][2]
	local _saiziPlaneZ = saiziPlane[self.randomNum][3]

	GameUtil.setLocalPos(self._saiziobj, 57, 0, 176)
	Framework.TransformUtil.SetLocalRotation(self.saiziGo.transform, _saiziPlaneX, _saiziPlaneY, _saiziPlaneZ)
	self:destroyAnimationSaiziTimer()

	self.curRotateCount = 0
	self._saiziRotating = false

	if self._saiziDoneCallBack then
		self:_saiziDoneCallBack()

		self._saiziDoneCallBack = nil
	end
end

function MonopolyController:_animationSaiziSlow()
	local saiziPlane = {
		{
			280,
			290,
			260
		},
		{
			350,
			190,
			0
		},
		{
			300,
			280,
			0
		},
		{
			280,
			10,
			0
		},
		{
			10,
			20,
			310
		},
		{
			340,
			280,
			170
		}
	}
	local _saiziPlaneX = saiziPlane[self.randomNum][1]
	local _saiziPlaneY = saiziPlane[self.randomNum][2]
	local _saiziPlaneZ = saiziPlane[self.randomNum][3]
	local _isXDone = self:_isAngleRange(self.curRotateX, _saiziPlaneX)
	local _isYDone = self:_isAngleRange(self.curRotateY, _saiziPlaneY)
	local _isZDone = self:_isAngleRange(self.curRotateZ, _saiziPlaneZ)

	if self.curRotateX ~= _saiziPlaneX and not _isXDone then
		self.curRotateX = self:_addRotateValue(self.curRotateX, self._saiziSlowAngle)
	end

	if self.curRotateY ~= _saiziPlaneY and not _isYDone then
		self.curRotateY = self:_addRotateValue(self.curRotateY, self._saiziSlowAngle)
	end

	if self.curRotateZ ~= _saiziPlaneZ and not _isZDone then
		self.curRotateZ = self:_addRotateValue(self.curRotateZ, self._saiziSlowAngle)
	end

	if _isXDone and _isYDone and _isZDone then
		Framework.TransformUtil.SetLocalRotation(self.saiziGo.transform, _saiziPlaneX, _saiziPlaneY, _saiziPlaneZ)
		self:destroyAnimationSaiziTimer()

		self.curRotateCount = 0
		self._saiziRotating = false

		if self._saiziDoneCallBack then
			self:_saiziDoneCallBack()

			self._saiziDoneCallBack = nil
		end
	else
		Framework.TransformUtil.SetLocalRotation(self.saiziGo.transform, self.curRotateX, self.curRotateY, self.curRotateZ)
	end
end

function MonopolyController:destroyAnimationSaiziTimer()
	removetimer(self._animationSaizi, self)
end

function MonopolyController:_addRotateValue(_rotate, _addValue)
	if not _rotate or not _addValue then
		return
	end

	_rotate = _rotate + _addValue

	if _rotate > 360 then
		_rotate = 0
	end

	return _rotate
end

function MonopolyController:_isAngleRange(_rotateValue, _angle)
	if not _rotateValue or not _angle then
		return
	end

	if _rotateValue >= _angle - self._saiziSlowAngleRange and _rotateValue <= _angle + self._saiziSlowAngleRange then
		return true
	end
end

function MonopolyController:checkMatId(matId)
	for k, v in pairs(MountItemId) do
		if v == matId then
			return true
		end
	end

	return false
end

function MonopolyController:checkRedPoint()
	local isRed = MonopolyModel.instance:checkMonopolyOpen() and (self:getControlDiceNum() > 0 or self:getDiceNum() > 0)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_MONOPOLY, isRed)
end

function MonopolyController:_updateRedpoint(mo)
	if mo then
		local matType = mo.type

		if matType == MatType.ACTIVITY_ITEM then
			self:checkRedPoint()
		end
	end
end

MonopolyController.instance = MonopolyController.New()

return MonopolyController
