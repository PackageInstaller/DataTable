-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tourarena/view/copy/sphere/SphereGameCopyOfTourArena.lua

module("logic.extensions.tourarena.view.copy.sphere.SphereGameCopyOfTourArena", package.seeall)

local SphereGameCopyOfTourArena = class("SphereGameCopyOfTourArena")

function SphereGameCopyOfTourArena:ctor()
	self._recycleBottleList = {}
	self._recycleSphereList = {}
	self._recycleBottleGos = {}
	self._recycleSphereGos = {}
	self._sgChildObjs = {}
	self._sgBottleObjs = {}
	self._backList = {}
	self._maxBackCount = 3
end

function SphereGameCopyOfTourArena:buildUI(go)
	self.mainGO = go
	self._child = goutil.findChild(self.mainGO, "child")
	self._bottle = goutil.findChild(self.mainGO, "bottle")
	self._gamespace = goutil.findChild(self.mainGO, "gamespace")
	self._gameover = goutil.findChild(self.mainGO, "gameover")
	self._txtResult = goutil.findChildTextComponent(self.mainGO, "gameover/txtResult")
	self._btnOver = Framework.ButtonAdapter.GetFrom(self.mainGO, "gameover/btnOver")
	self._recycleChildParent = goutil.findChild(self.mainGO, "recycleChildParent")
	self._btnReset = Framework.ButtonAdapter.GetFrom(self.mainGO, "btnReset")
	self._txtLevel = goutil.findChildTextComponent(self.mainGO, "txtLevel")
	self._txtCostTime = goutil.findChildTextComponent(self.mainGO, "txtCostTime")
	self._btnAdd = Framework.ButtonAdapter.GetFrom(self.mainGO, "btnAdd")
	self._btnBack = Framework.ButtonAdapter.GetFrom(self.mainGO, "btnBack")
	self._txtBack = goutil.findChildTextComponent(self.mainGO, "btnBack/txt")

	goutil.setActive(self._child, false)
	goutil.setActive(self._bottle, false)
	GameUtil.SetActive(self._txtLevel.gameObject, false)
	GameUtil.SetActive(self._txtCostTime.gameObject, true)
end

function SphereGameCopyOfTourArena:destroyUI()
	return
end

function SphereGameCopyOfTourArena:bindEvents()
	self._btnOver:AddClickListener(self._onClickOver, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnBack:AddClickListener(self._onClickBack, self)
end

function SphereGameCopyOfTourArena:unbindEvents()
	self._btnOver:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnBack:RemoveClickListener()
end

function SphereGameCopyOfTourArena:onEnter(activityId, stagePlanId, stageId)
	GlobalDispatcher:addListener(GlobalNotify.onSGClickBottle, self._onClickBottle, self)
	GlobalDispatcher:addListener(GlobalNotify.SGCloseClick, self._onCloseClick, self)
	GlobalDispatcher:addListener(GlobalNotify.SGOpenClick, self._onOpenClick, self)
	GlobalDispatcher:addListener(GlobalNotify.ACEndMakeCakeRes, self._onEndMakeCakeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ACMakeCakeAddPipeRes, self._onMakeCakeAddPipeRes, self)

	self._activityId = activityId
	self._stagePlanId = stagePlanId
	self._stageId = stageId
	self._cfgActivity = MakeCakeConfig.instance:getActivityCfg(self._activityId)
	self._isNeedBtnAdd = self._cfgActivity ~= nil

	GameUtil.SetActive(self._btnAdd.gameObject, self._isNeedBtnAdd)
	self:_startNext(self._stageId)
end

function SphereGameCopyOfTourArena:_startNext(stageId)
	UIStateManager.instance:updateParms(ViewName.SphereGameCopyOfTourArenaMainView, {
		self._activityId,
		self._stagePlanId,
		stageId
	})

	self._stageId = stageId
	self._isCanAddBottle = true
	self._bottleCfgs = self:_getInitBottleList(self._stageId)
	self._txtLevel.text = string.format(lang("makecake_tip4"), GameUtil.getChineseNumber(self._stageId))
	self._isCanExit = true
	self._isSuccess = false

	self:_clearTween()
	self:_initGameObject()
	self:_initData()
	self:_setTxtResult()
	self:_updateTxtBack()

	if self._activityId > 0 then
		AnniversaryCakeAgent.instance:sendPM_ACStartMakeCakeReq(self._activityId, stageId)
	end

	self:_startTicking()
end

function SphereGameCopyOfTourArena:onExit()
	self:_stopTicking()
	GlobalDispatcher:removeListener(GlobalNotify.onSGClickBottle, self._onClickBottle, self)
	GlobalDispatcher:removeListener(GlobalNotify.SGCloseClick, self._onCloseClick, self)
	GlobalDispatcher:removeListener(GlobalNotify.SGOpenClick, self._onOpenClick, self)
	GlobalDispatcher:removeListener(GlobalNotify.ACEndMakeCakeRes, self._onEndMakeCakeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ACMakeCakeAddPipeRes, self._onMakeCakeAddPipeRes, self)
	self:_clearBottles()
	self:_clearSpheres()
	self:_clearTween()
end

function SphereGameCopyOfTourArena:_startTicking()
	settimer(1, self._ticking, self)
end

function SphereGameCopyOfTourArena:_stopTicking()
	removetimer(self._ticking, self)
end

function SphereGameCopyOfTourArena:_ticking()
	self._costTime = self._costTime + 1
	self._txtCostTime.text = string.format("计时：%s秒", self._costTime)
end

function SphereGameCopyOfTourArena:_getInitBottleList(stageId)
	local cfgs = MakeCakeConfig.instance:getLevelCfgList(stageId)
	local list = {}

	for i, v in ipairs(cfgs) do
		local t = {}

		table.insert(t, v.Pos1)
		table.insert(t, v.Pos2)
		table.insert(t, v.Pos3)
		table.insert(t, v.Pos4)
		table.insert(list, t)
	end

	return list
end

function SphereGameCopyOfTourArena:_initData()
	self:_clearBottles()
	self:_clearSpheres()
	self:_clearBackList()

	self._isCanClickBottle = true
	self._curSourceBottle = nil
	self._curTargetBottle = nil
	self._isCanAddBottle = true
	self._curUseBackCount = 0
	self._costTime = 0

	self:_initSpheres()
	self:_initBottles()
	self:_updateTxtBack()
end

function SphereGameCopyOfTourArena:_onClickOver()
	if not self._isCanExit then
		return
	end

	local info = {}

	info.isPass = self._isSuccess
	info.gameScore = self:_getCostTime()

	GlobalDispatcher:dispatch(GlobalNotify.onSGClickGameOver, info)
end

function SphereGameCopyOfTourArena:_getCostTime()
	return self._costTime
end

function SphereGameCopyOfTourArena:_onClickReset()
	if #self._backList == 0 and self._isCanAddBottle then
		FloatWordMgr.instance:show(lang("makecake_tip10"))

		return
	end

	if not self._isCanClickBottle then
		return
	end

	local text = lang("makecake_tip11")

	local function okFunc()
		self:_resetStart()
	end

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, nil, lang("confirm"), lang("cancel"))
end

function SphereGameCopyOfTourArena:_onClickAdd()
	if not self._isCanClickBottle then
		return
	end

	if not self._isNeedBtnAdd then
		return
	end

	local curMatCount = MaterialMgr.getMatCount(self._cfgActivity.addPipeCost)
	local matType, id, needNum = MaterialMgr.getMatParams(self._cfgActivity.addPipeCost)

	if curMatCount < needNum then
		FloatWordMgr.instance:show(lang("makecake_tip12"))

		return
	end

	local curLeftCount = MakeCakeModel.instance:getLeftDailyFreeTimes()
	local curMaxCount = MakeCakeModel.instance:getFreeAddPipeCount()
	local cfg = MakeCakeConfig.instance:getStageCfg(self._stagePlanId, self._stageId)

	if cfg then
		if not cfg.addPipeLimit then
			local text = ""

			if curLeftCount > 0 then
				text = lang("makecake_tip17")
			else
				local itemStr = MaterialMgr.getContentMatCfg(matType, id, 40, -8, MaterialMgr.ICON_TYPE_ICON)

				text = string.format(lang("makecake_tip13"), itemStr, needNum)
			end

			local function okFunc()
				if self._isCanAddBottle then
					self._isCanAddBottle = false

					if self._activityId > 0 then
						AnniversaryCakeAgent.instance:sendPM_ACMakeCakeAddPipeReq(self._activityId)
					end
				end
			end

			TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, nil, lang("confirm"), lang("cancel"))
		end
	end
end

function SphereGameCopyOfTourArena:_onClickBack()
	if not self._isCanClickBottle then
		return
	end

	if self._curUseBackCount >= self._maxBackCount then
		FloatWordMgr.instance:show(lang("makecake_tip14"))

		return
	end

	local step = self:_getOneBack()

	if step then
		if self._curSourceBottle then
			self._curSourceBottle:moveChildToBottom()

			self._curSourceBottle = nil
		end

		self._curUseBackCount = self._curUseBackCount + 1

		self:_updateTxtBack()
		step.destBottle:moveChildToAnother(step.srcBottle)
	else
		FloatWordMgr.instance:show(lang("makecake_tip10"))
	end
end

function SphereGameCopyOfTourArena:_onClickBottle(sgBottleObj)
	if not self._isCanClickBottle then
		printInfo("test 点击瓶子无效")

		return
	end

	if not self._curSourceBottle then
		if sgBottleObj:isEmpty() then
			return
		end

		self._curSourceBottle = sgBottleObj

		self._curSourceBottle:moveChildToTop()
	elseif self._curSourceBottle == sgBottleObj then
		self._curSourceBottle:moveChildToBottom()

		self._curSourceBottle = nil
	elseif sgBottleObj:isEmpty() then
		if not self._curSourceBottle:isEmpty() then
			self._curSourceBottle:moveChildToAnother(sgBottleObj)
			self:_recordBackList(self._curSourceBottle, sgBottleObj)

			self._curSourceBottle = nil
		end
	elseif sgBottleObj:isMax() then
		self._curSourceBottle:moveChildToBottom()
		sgBottleObj:moveChildToTop()

		self._curSourceBottle = sgBottleObj
	elseif self._curSourceBottle:getTopColorIndex() == sgBottleObj:getTopColorIndex() then
		self._curSourceBottle:moveChildToAnother(sgBottleObj)
		self:_recordBackList(self._curSourceBottle, sgBottleObj)

		self._curSourceBottle = nil
	else
		self._curSourceBottle:moveChildToBottom()
		sgBottleObj:moveChildToTop()

		self._curSourceBottle = sgBottleObj
	end

	self:_updateGameState()
end

function SphereGameCopyOfTourArena:_onCloseClick()
	self._isCanClickBottle = false
end

function SphereGameCopyOfTourArena:_onOpenClick()
	self._isCanClickBottle = true
end

function SphereGameCopyOfTourArena:_onEndMakeCakeRes()
	self._isCanExit = true
end

function SphereGameCopyOfTourArena:_onMakeCakeAddPipeRes()
	self:_addOneBottle()
end

function SphereGameCopyOfTourArena:_resetStart()
	if self._activityId > 0 then
		AnniversaryCakeAgent.instance:sendPM_ACStartMakeCakeReq(self._activityId, self._stageId)
	end

	self:_initGameObject()
	self:_initData()
end

function SphereGameCopyOfTourArena:_updateGameState()
	local count = #self._sgBottleObjs
	local num = 0

	for i, v in ipairs(self._sgBottleObjs) do
		if v:isSameColorOrNil() then
			num = num + 1
		end
	end

	self._isSuccess = num ~= 0 and num == count

	if self._isSuccess then
		self:_stopTicking()

		self._isCanClickBottle = false
		self._isCanExit = false
		self._gameOverTween = TweenUtil.DoDelay(0.4, function()
			self._gameOverTween = nil
			self._isCanClickBottle = false
			self._isCanExit = false

			goutil.setActive(self._gameover, true)

			if self._activityId > 0 then
				AnniversaryCakeAgent.instance:sendPM_ACEndMakeCakeReq(self._activityId)
			else
				self:_onEndMakeCakeRes()
			end
		end)
	end
end

function SphereGameCopyOfTourArena:_clearTween()
	if self._gameOverTween then
		self._gameOverTween:Kill()

		self._gameOverTween = nil
	end
end

function SphereGameCopyOfTourArena:_initGameObject()
	goutil.setActive(self._gameover, false)
	goutil.setActive(self._btnAdd.gameObject, self._isNeedBtnAdd)
end

function SphereGameCopyOfTourArena:_getSphereGo()
	local count = #self._recycleSphereGos

	if count > 0 then
		local go = self._recycleSphereGos[count]

		table.remove(self._recycleSphereGos, count)
		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._child, self._recycleChildParent.transform, "sphere")

		goutil.setActive(go, true)

		return go
	end
end

function SphereGameCopyOfTourArena:_recycleSphere(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleChildParent)
		table.insert(self._recycleSphereGos, go)
	end
end

function SphereGameCopyOfTourArena:_getSphereObj()
	local count = #self._recycleSphereList

	if count > 0 then
		local obj = self._recycleSphereList[count]

		table.remove(self._recycleSphereList, count)

		return obj
	else
		return SGChildObj.New()
	end
end

function SphereGameCopyOfTourArena:_recycleSphereObj(obj)
	obj:onExit()
	table.insert(self._recycleSphereList, obj)
end

function SphereGameCopyOfTourArena:_initSpheres()
	for i, array in ipairs(self._bottleCfgs) do
		for k, v in ipairs(array) do
			if v > 0 then
				local go = self:_getSphereGo()
				local obj = self:_getSphereObj()

				obj:buildUI(go)
				table.insert(self._sgChildObjs, obj)
			end
		end
	end
end

function SphereGameCopyOfTourArena:_clearSpheres()
	for i, v in ipairs(self._sgChildObjs) do
		local go = v:getGo()

		self:_recycleSphere(go)
		self:_recycleSphereObj(v)
	end

	table.clear(self._sgChildObjs)
end

function SphereGameCopyOfTourArena:_getBottleObj()
	local count = #self._recycleBottleList

	if count > 0 then
		local obj = self._recycleBottleList[count]

		table.remove(self._recycleBottleList, count)

		return obj
	else
		return SGBottleObj.New()
	end
end

function SphereGameCopyOfTourArena:_recycleBottleObj(obj)
	obj:onExit()
	table.insert(self._recycleBottleList, obj)
end

function SphereGameCopyOfTourArena:_getBottleGo()
	local count = #self._recycleBottleGos

	if count > 0 then
		local go = self._recycleBottleGos[count]

		table.remove(self._recycleBottleGos, count)
		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._bottle, self._recycleChildParent.transform, "bottle")

		goutil.setActive(go, true)

		return go
	end
end

function SphereGameCopyOfTourArena:_recycleBottleGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleChildParent)
		table.insert(self._recycleBottleGos, go)
	end
end

function SphereGameCopyOfTourArena:_addOneBottle()
	local obj = self:_getBottleObj()
	local go = self:_getBottleGo()
	local count = #self._sgBottleObjs

	go.name = "bottle" .. count + 1

	go.transform:SetParent(self._gamespace.transform)
	obj:buildUI(go)
	obj:onEnter()
	table.insert(self._sgBottleObjs, obj)
	goutil.setActive(self._btnAdd.gameObject, false)
end

function SphereGameCopyOfTourArena:_initBottles()
	local count = #self._bottleCfgs

	self._sgBottleObjs = {}

	local index = 0

	for i = 1, count do
		local obj = self:_getBottleObj()
		local go = self:_getBottleGo()

		go.name = "bottle" .. i

		go.transform:SetParent(self._gamespace.transform)
		goutil.setActive(go, true)
		obj:buildUI(go)
		obj:onEnter()

		local list = self._bottleCfgs[i]

		for i, colorIndex in ipairs(list) do
			if colorIndex > 0 then
				index = index + 1

				obj:addObj(self._sgChildObjs[index], colorIndex)
			end
		end

		obj:updateChildPos()
		table.insert(self._sgBottleObjs, obj)
	end
end

function SphereGameCopyOfTourArena:_clearBottles()
	if self._sgBottleObjs then
		for i, v in ipairs(self._sgBottleObjs) do
			local go = v:getGo()

			self:_recycleBottleGo(go)
			self:_recycleBottleObj(v)
		end

		table.clear(self._sgBottleObjs)
	end
end

function SphereGameCopyOfTourArena:_recordBackList(srcBottle, destBottle)
	local t = {}

	t.srcBottle = srcBottle
	t.destBottle = destBottle

	table.insert(self._backList, t)
end

function SphereGameCopyOfTourArena:_getOneBack()
	local count = #self._backList

	if count > 0 then
		return table.remove(self._backList, count)
	end
end

function SphereGameCopyOfTourArena:_clearBackList()
	table.clear(self._backList)
end

function SphereGameCopyOfTourArena:_setTxtResult()
	local cfg = MakeCakeConfig.instance:getStageCfg(self._stagePlanId, self._stageId)

	if cfg then
		goutil.setActive(self._txtResult.gameObject, false)
	end
end

function SphereGameCopyOfTourArena:_updateTxtBack()
	local leftCount = self._maxBackCount - self._curUseBackCount

	leftCount = leftCount >= 0 and leftCount or 0
	self._txtBack.text = string.format(lang("makecake_tip16"), leftCount, self._maxBackCount)
end

return SphereGameCopyOfTourArena
