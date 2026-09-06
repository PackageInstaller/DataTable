-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/view/Run2023MainView.lua

module("logic.extensions.run2023.view.Run2023MainView", package.seeall)

local Run2023MainView = class("Run2023MainView", ViewComponent)
local InteractItemType = {
	Food = 1,
	Stone = 2,
	End = 3
}
local InteractItemClickState = {
	End = 5,
	SuperAccelera = 2,
	Fall = 4,
	NormalAccelera = 1,
	Decelerate = 3
}
local GameState = {
	Sprint = 2,
	Normal = 1
}
local Commonkey = {
	BackGround_NormalSpeed = "BackGround_NormalSpeed",
	Bubble_Max_Speed = "Bubble_Max_Speed",
	Stone_Percent = "Stone_Percent",
	Interact_Speed = "Interact_Speed",
	BackGround_AccelerateSpeed = "BackGround_AccelerateSpeed",
	Camera_Time = "Camera_Time",
	BackGround_RollingTime = "BackGround_RollingTime",
	Bubble_IntervalTime = "Bubble_IntervalTime",
	Bubble_Min_Speed = "Bubble_Min_Speed"
}
local EffectPath = {
	AQ_Normal_Accelera = "20221223/woyaoshangche/fx_ui_woyaoshangche_aoqiptjiasu.prefab",
	XN_Normal_Accelera = "20221223/woyaoshangche/fx_ui_woyaoshangche_xnuoptjiasu.prefab",
	AQ_Normal = "20221223/woyaoshangche/fx_ui_woyaoshangche_aoqijiasu.prefab",
	AQ_Super_Accelera = "20221223/woyaoshangche/fx_ui_woyaoshangche_aoqicjjiasu.prefab",
	AQ_Fall = "20221223/woyaoshangche/fx_ui_woyaoshangche_shuaidao.prefab",
	XN_Normal = "20221223/woyaoshangche/fx_ui_woyaoshangche_xnuojiasu.prefab",
	XN_Super_Accelera = "20221223/woyaoshangche/fx_ui_woyaoshangche_xnuocjjiasu.prefab",
	Light_Effect = "20221223/woyaoshangche/fx_ui_woyaoshangche_guangquan.prefab",
	Bubble_Effect = "20221223/woyaoshangche/fx_ui_woyaoshangche_paopao.prefab"
}
local SpineInfos = {
	Male = {
		FallAnimation = "fall",
		RunAnimation = "run2",
		Path = "20211028/zhiren_aoqi/zhiren_aoqi-ui_p.prefab"
	},
	Female = {
		FallAnimation = "fall",
		RunAnimation = "run",
		Path = "20221223/zhiren_nvaoqi/zhiren_nvaoqi-ui_p.prefab"
	},
	XiaoNuo = {
		FallAnimation = "fall",
		RunAnimation = "fly",
		Path = {
			"lihui_spine/10140_xiaonuo_lihui/10140_xiaonuo_lihui-ui_p.prefab"
		}
	},
	AnXingWangZhe = {
		FallAnimation = "idle",
		RunAnimation = "idle",
		Path = {
			"character/99984_anxingwangzhe/99984_anxingwangzhe-ui_p.prefab"
		}
	}
}
local CurSpineInfosByGender = {
	[GameEnum.Gender.Female] = SpineInfos.AnXingWangZhe,
	[GameEnum.Gender.Male] = SpineInfos.AnXingWangZhe
}

function Run2023MainView:ctor()
	Run2023MainView.super.ctor(self)
end

function Run2023MainView:unbindEvents()
	Run2023MainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._goStart)
	GameUtil.rmClickHandler(self._goClick)
end

function Run2023MainView:bindEvents()
	Run2023MainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._goStart, self._onClickStartGame, self)
	GameUtil.addClickHandler(self._goClick, self._onClickInteract, self)
end

function Run2023MainView:buildUI()
	Run2023MainView.super.buildUI(self)

	self._goStart = self:getGo("gameStart")
	self._goGame = self:getGo("game")
	self._goRoleCon = self:getGo("game/role")
	self._aqEffect = self:getGo("game/role/effect")
	self._aqEffectFall = self:getGo("game/role/effectFall")
	self._xiaonuoCon = self:getGo("game/xiaonuo")
	self._xnEffect = self:getGo("game/xiaonuo/effect")
	self._goClick = self:getGo("game/container/click")
	self._goBg = self:getGo("bg")
	self._bg1 = self:getGo("bg/bg_1")
	self._goShallowArea = self:getGo("game/container/btnSlideGame/slideArean/arena1")
	self._goDeepArea = self:getGo("game/container/btnSlideGame/slideArean/arena2")
	self._goInteractItem = self:getGo("game/container/btnSlideGame/item"):GetComponent("UIImageSpriteChange")
	self._interactItemEffect = self:getGo("game/container/btnSlideGame/item/effect")
	self._txtTimeSlider = self:getTxt("game/progress/time/txtTime")
	self._sliderTime = self:getSlider("game/progress")
	self._goBubble = self:getGo("game/bubble")
	self._goBubbleParent = self:getGo("game/container/bubbles")
	self._bubbleEffect = self:getGo("game/container/bubbles/effect")
	self._btnSlideGame = self:getGo("game/container/btnSlideGame")
	self._goGameContainer = self:getGo("game/container")

	GameUtil.SetActive(self._goBubble, false)

	self._offees = GameUtil.getWidth(self._bg1)
	self._roleLineList = {}
	self._itemLineList = {}
	self._bubbleLineList = {}
	self._goTips = {}

	for i = 1, 5 do
		table.insert(self._roleLineList, self:getGo("game/roleBorder/line_" .. i))

		if i <= 2 then
			table.insert(self._itemLineList, self:getGo("game/interactItemArea/line_" .. i))
		end

		if i <= 4 then
			table.insert(self._goTips, self:getGo("game/tips/tip_" .. i))
			table.insert(self._bubbleLineList, self:getGo("game/bubbleArea/line_" .. i))
		end
	end

	self._goEffectItemParent = self:getGo("game/container/btnSlideGame/effectItem")
	self._goEffectItemList = {}

	for i = 1, self._goEffectItemParent.transform.childCount do
		table.insert(self._goEffectItemList, self._goEffectItemParent.transform:GetChild(i - 1).gameObject)
	end
end

function Run2023MainView:onExit()
	Run2023MainView.super.onExit(self)
	removetimer(self._tickRunGame, self)
	removetimer(self._spawnBubble, self)
	removetimer(self._handleFallEffect, self)

	for i, v in ipairs(self._bubbleList) do
		goutil.destroy(v.gameObject, true)
	end

	self._skeletonGraphic.timeScale = 1
	self._xiaonuoSkeletonGraphic.timeScale = 1

	GameUtil.setLocalScale(self._goGame, 1, 1, 1)
	self:_clearRole()
	self:_removeCellEff(self._aqEffect)
	self:_removeCellEff(self._xnEffect)
	DG.Tweening.DOTween.KillAll(true)
	GlobalDispatcher:removeListener(GlobalNotify.RunGameEndRes, self._showResultView, self)
end

function Run2023MainView:onEnter()
	Run2023MainView.super.onEnter(self)

	local params = self:getOpenParam()

	self._isDemo = params[1]

	self:_initData()
	self:_resetView()
	self:_resetItem(self._goInteractItem, Vector3(self._interactArea.leftX, 0, 0))
	self:_resetItem(self._goEffectItemParent, Vector3(self._interactArea.leftX, 0, 0))
	self:_randomInteractItemType()
	self:_spawnBubble()
	self:_loadRole()
	GlobalDispatcher:addListener(GlobalNotify.RunGameEndRes, self._showResultView, self)
end

function Run2023MainView:_initData()
	local localPos = GameUtil.getLocalPos(self._goShallowArea)
	local width = GameUtil.getWidth(self._goShallowArea)

	self._shallowArea = {
		leftX = localPos.x - width / 2,
		rightX = localPos.x + width / 2
	}
	localPos = GameUtil.getLocalPos(self._goDeepArea)
	width = GameUtil.getWidth(self._goDeepArea)
	self._deepArea = {
		leftX = localPos.x - width / 2,
		rightX = localPos.x + width / 2
	}
	self._interactArea = {
		midX = 0,
		leftX = GameUtil.getLocalPos(self._itemLineList[1]).x,
		rightX = GameUtil.getLocalPos(self._itemLineList[2]).x
	}
	self._bubbleArea = {
		minX = GameUtil.getLocalPos(self._bubbleLineList[1]).x,
		maxX = GameUtil.getLocalPos(self._bubbleLineList[2]).x,
		minY = GameUtil.getLocalPos(self._bubbleLineList[3]).y,
		maxY = GameUtil.getLocalPos(self._bubbleLineList[4]).y
	}
	self._roleArea = {
		maxX = GameUtil.getLocalPos(self._roleLineList[1]).x,
		minX = GameUtil.getLocalPos(self._roleLineList[2]).x,
		maxY = GameUtil.getLocalPos(self._roleLineList[3]).y,
		minY = GameUtil.getLocalPos(self._roleLineList[4]).y,
		OriginY = GameUtil.getLocalPos(self._roleLineList[3]).y,
		FallY = GameUtil.getLocalPos(self._roleLineList[5]).y
	}
	self._activityId = Run2023Model.instance:getActivityId()
	self._gameCfgs = Run2023Config.instance:getGameCfgsByActId(self._activityId)
	self._tipsLiveTime = 1
	self._timeStamp = 0
	self._isLive = false
	self._gamingTime = 0
	self._isEnd = false
	self._sprintTime = self._gameCfgs.gameEndTime
	self._gameState = GameState.Normal
	self._bubbleList = {}
	self._bubblePool = {}
	self._bubbleIsUp = true
	self._bgSpeed = 0
	self._bgBeginSpeed = 0
	self._bgTargetSpeed = Run2023Config.instance:getGameCommonByKey(Commonkey.BackGround_NormalSpeed)
	self._bgTime = 0
	self._bgTotalTime = Run2023Config.instance:getGameCommonByKey(Commonkey.BackGround_RollingTime)
	self._cameraTime = checknumber(Run2023Config.instance:getGameCommonByKey(Commonkey.Camera_Time))
	self._isCameraClose = false
end

function Run2023MainView:_spawnBubble()
	local go = self:_getBubble()
	local goTxt = goutil.findChildTextComponent(go, "txtName")

	if self._bubbleIsUp == true then
		if not self._bubbleArea.maxY then
			local posY = self._bubbleArea.minY
			local pos = Vector3(self._bubbleArea.maxX, posY, 0)
			local planId = self._gameCfgs.blessWordPlanId
			local wishwordId = math.random(1, #Run2023Config.instance:getGameBlessWordCfgs(planId))

			goTxt.text = Run2023Config.instance:getGameBlessWordCfgsById(planId, wishwordId).desc

			self:_resetItem(go, pos)
			table.insert(self._bubbleList, go)

			self._bubbleIsUp = not self._bubbleIsUp
		end
	end
end

function Run2023MainView:_getBubble()
	local num = #self._bubblePool
	local go = num >= 1 and table.remove(self._bubblePool, num) or goutil.cloneAndSetParent(self._goBubble, self._goBubbleParent.transform)

	GameUtil.SetActive(go, true)

	return go
end

function Run2023MainView:_recycleBubble(go)
	GameUtil.SetActive(go, false)
	table.insert(self._bubblePool, go)
	table.removebyvalue(self._bubbleList, go)
end

function Run2023MainView:_loadRole()
	local gender = RoleModel.instance:getGender()

	if CurSpineInfosByGender[gender] then
		local spineInfos = CurSpineInfosByGender[gender]
		local path = spineInfos.Path
		local animation = spineInfos.RunAnimation

		self._goRole = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

			self._skeletonGraphic = goutil.findChild(eff.effGo, "skeleton"):GetComponent("SkeletonGraphic")

			RoleObjectPool.instance:playAnimation(self._skeletonGraphic, animation, true)
		end)

		self._goRole:setParent(self._goRoleCon.transform)
		self._goRole:setScale(0.4)
	end

	if SpineInfos.XiaoNuo then
		local spineInfos = SpineInfos.XiaoNuo
		local path = spineInfos.Path

		self._xiaonuo = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)

			self._xiaonuoSkeletonGraphic = goutil.findChild(eff.effGo, "skeleton"):GetComponent("SkeletonGraphic")
			self._xiaonuoSkeletonGraphic.startingAnimation = "fly"

			self._xiaonuoSkeletonGraphic.AnimationState:SetAnimation(0, "fly", true)
		end)

		self._xiaonuo:setParent(self._xiaonuoCon.transform)
		self._xiaonuo:setScale(0.4)
	end
end

function Run2023MainView:_clearRole()
	if self._goRole then
		UIEffectManager.instance:stopEffect(self._goRole)

		self._goRole = nil
	end

	if self._xiaonuo then
		UIEffectManager.instance:stopEffect(self._xiaonuo)

		self._xiaonuo = nil
	end
end

function Run2023MainView:_tickRunGame()
	local deltaTime = Time.deltaTime

	self._gamingTime = self._gamingTime + deltaTime

	self:_updateBgSpeed(self._bgBeginSpeed, self._bgTargetSpeed, deltaTime)
	self:_loopBackGround(deltaTime)
	self:_updateTimeSlider()

	if self._gameState == GameState.Sprint then
		return
	end

	self:_moveInteractItem(deltaTime)

	if #self._bubbleList >= 1 then
		self:_moveBubble(deltaTime)
	end

	if self._gamingTime >= self._timeStamp and self._isLive then
		self:_popTips(InteractItemClickState.End)

		self._isLive = false
	end
end

function Run2023MainView:_setBgSpeed(totalTime, curSpeed, targetSpeed)
	self._bgTime = 0
	self._bgTotalTime = totalTime
	self._bgSpeed = curSpeed
	self._bgBeginSpeed = curSpeed
	self._bgTargetSpeed = targetSpeed
end

function Run2023MainView:_updateBgSpeed(from, to, deltaTime)
	self._bgTime = Mathf.Min(self._bgTime + deltaTime, self._bgTotalTime)
	self._bgSpeed = Mathf.Lerp(from, to, self._bgTime / self._bgTotalTime)
end

function Run2023MainView:_loopBackGround(deltaTime)
	local pos = GameUtil.getLocalPos(self._goBg)
	local curX = pos.x - self._bgSpeed * deltaTime

	if curX <= -self._offees then
		curX = self._offees
	end

	GameUtil.setLocalPos(self._goBg, curX, 0, 0)
end

function Run2023MainView:_moveInteractItem(deltaTime)
	local pos = GameUtil.getLocalPos(self._goInteractItem)
	local moveSpeed = Run2023Config.instance:getGameCommonByKey(Commonkey.Interact_Speed)
	local curX = pos.x + moveSpeed * deltaTime

	GameUtil.setLocalPos(self._goInteractItem, curX, pos.y, pos.z)
	GameUtil.setLocalPos(self._goEffectItemParent, curX, pos.y, pos.z)

	if self._interactItemType == InteractItemType.End then
		if curX >= self._interactArea.midX then
			self:_sprintPhase()
		end
	elseif curX >= self._interactArea.rightX then
		self:_resetItem(self._goInteractItem, Vector3(self._interactArea.leftX, pos.y, pos.z))
		self:_resetItem(self._goEffectItemParent, Vector3(self._interactArea.leftX, pos.y, pos.z))
		self:_randomInteractItemType()
		GameUtil.SetActive(self._goClick, true)
	end
end

function Run2023MainView:_moveBubble(deltaTime)
	for i, v in ipairs(self._bubbleList) do
		local moveSpeed = math.random(Run2023Config.instance:getGameCommonByKey(Commonkey.Bubble_Min_Speed), Run2023Config.instance:getGameCommonByKey(Commonkey.Bubble_Max_Speed))
		local pos = GameUtil.getLocalPos(v)
		local curX = pos.x - moveSpeed * deltaTime

		GameUtil.setLocalPos(v, curX, pos.y, pos.z)

		if curX <= self._bubbleArea.minX or self:_isTouch(v) then
			GameUtil.setLocalPos(self._bubbleEffect, pos.x, pos.y, pos.z)
			self:_playCellEff(self._bubbleEffect, EffectPath.Bubble_Effect, 0, 0, false, nil)
			self:_recycleBubble(v)
		end
	end
end

function Run2023MainView:_isTouch(go)
	local pos = GameUtil.getLocalPos(go)

	if pos.x >= self._roleArea.minX and pos.x < self._roleArea.maxX and pos.y >= self._roleArea.minY and pos.y < self._roleArea.maxY then
		return true
	end

	return false
end

function Run2023MainView:_updateTimeSlider()
	self._txtTimeSlider.text = string.format("%.1f秒", self._gamingTime)

	local leftPercent = 0
	local rightPercent = 0

	if self._gameState == GameState.Sprint then
		leftPercent = self._gameCfgs.gameReadyTime / self._gameCfgs.gameEndTime
		rightPercent = (self._gamingTime - self._gameCfgs.gameReadyTime) / (self._sprintTime - self._gameCfgs.gameReadyTime) * (1 - self._gameCfgs.gameReadyTime / self._gameCfgs.gameEndTime)

		if self._gamingTime >= self._sprintTime - self._cameraTime and not self._isCameraClose then
			self._isCameraClose = true

			self._goGame.transform:DOScale(Vector3.New(1.5, 1.5, 1.5), 1):SetEase(DG.Tweening.Ease.OutSine)
		end

		if self._gamingTime >= self._sprintTime then
			local totalTime = math.round(self._gamingTime)

			if not self._isDemo then
				if not self._isEnd then
					self._isEnd = true

					local serverKey = Run2023Model.instance:beforeEndGame(totalTime)

					Run2023Controller.instance:sendEndGameReq(self._activityId, totalTime, serverKey)
				end
			elseif not self._isEnd then
				self._isEnd = true

				local prizeStr = Run2023Config.instance:getGameRewardCfgsById(self._gameCfgs.prizePlanId, totalTime)

				self:_showResultView(0, prizeStr, totalTime)
			end
		end
	else
		leftPercent = self._gamingTime / self._gameCfgs.gameEndTime
	end

	self._sliderTime:SetValue(leftPercent + rightPercent)
end

function Run2023MainView:_resetItem(go, pos)
	GameUtil.setLocalPos(go, pos.x, pos.y, pos.z)
	GameUtil.SetActive(go, true)
end

function Run2023MainView:_randomInteractItemType()
	local maxTime = self._gameCfgs.gameReadyTime

	if maxTime <= self._gamingTime then
		self._interactItemType = InteractItemType.End

		self:_playCellEff(self._interactItemEffect, EffectPath.Light_Effect, 0, 0, false, nil)
	else
		local percent = math.random(1, 100)

		if percent <= checknumber(Run2023Config.instance:getGameCommonByKey(Commonkey.Stone_Percent)) then
			self._interactItemType = InteractItemType.Stone or InteractItemType.Food
		end
	end

	for i, v in ipairs(self._goEffectItemList) do
		GameUtil.SetActive(v, false)
	end

	GameUtil.setUIImageSpriteIdx(self._goInteractItem, self._interactItemType - 1)
end

function Run2023MainView:_sprintPhase()
	local bgRollTime = Run2023Config.instance:getGameCommonByKey(Commonkey.BackGround_RollingTime)
	local bgTargetSpeed = Run2023Config.instance:getGameCommonByKey(Commonkey.BackGround_AccelerateSpeed)

	self._sprintTime = Mathf.Clamp(self._sprintTime, self._gameCfgs.gameMinEndTime, self._gameCfgs.gameMaxEndTime)
	self._gameState = GameState.Sprint

	GameUtil.SetActive(self._goGameContainer, false)

	self._skeletonGraphic.timeScale = 1.5
	self._xiaonuoSkeletonGraphic.timeScale = 1.5

	self:_setBgSpeed(bgRollTime, self._bgSpeed, bgTargetSpeed)
	self:_popTips(InteractItemClickState.End)
end

function Run2023MainView:_resetCharacterAnim()
	local gender = RoleModel.instance:getGender()
	local spineInfos = CurSpineInfosByGender[gender]
	local animation = spineInfos.RunAnimation

	RoleObjectPool.instance:playAnimation(self._skeletonGraphic, animation, true)

	self._roleArea.maxY = self._roleArea.OriginY
end

function Run2023MainView:_handleFallEffect()
	local function callback()
		self:_removeCellEff(self._aqEffectFall)
	end

	self:_playCellEff(self._aqEffectFall, EffectPath.AQ_Fall, 0, 0, false, callback)
	self:_playCellEff(self._xnEffect, EffectPath.XN_Normal, 0, 0, true, nil)
end

function Run2023MainView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function Run2023MainView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function Run2023MainView:_popTips(id)
	for i, v in ipairs(self._goTips) do
		GameUtil.SetActive(v, i == id)
	end

	if id ~= InteractItemClickState.End then
		self._timeStamp = self._gamingTime + self._tipsLiveTime
		self._isLive = true
	end
end

function Run2023MainView:_resetView()
	GameUtil.SetActive(self._goStart, true)
	GameUtil.SetActive(self._goGame, false)
	GameUtil.SetActive(self._goGameContainer, true)
	GameUtil.setLocalPos(self._goBg, 0, 0, 0)
end

function Run2023MainView:_showResultView(changeSetId, prizeStrList)
	self:close()
	UIStateManager.instance:push(ViewName.Run2023ResultView, changeSetId, prizeStrList, self._gamingTime, self._isDemo)
end

function Run2023MainView:_onClickStartGame()
	local bubbleIntervalTime = checknumber(Run2023Config.instance:getGameCommonByKey(Commonkey.Bubble_IntervalTime))

	GameUtil.SetActive(self._goStart, false)
	GameUtil.SetActive(self._goGame, true)
	settimer(0, self._tickRunGame, self)
	settimer(bubbleIntervalTime, self._spawnBubble, self)
end

function Run2023MainView:_onClickInteract()
	GameUtil.SetActive(self._goClick, false)

	local mySequence = DG.Tweening.DOTween.Sequence()

	self._btnSlideGame.transform:DOScale(Vector3.New(0.9, 0.9, 0.9), 0.2):SetEase(DG.Tweening.Ease.OutSine):OnComplete(function()
		self._btnSlideGame.transform:DOScale(Vector3.New(1, 1, 1), 0.2):SetEase(DG.Tweening.Ease.OutSine)
	end)

	local posX = GameUtil.getLocalPos(self._goInteractItem).x
	local stateId = 0

	if self._interactItemType == InteractItemType.Stone then
		local bgRollTime = Run2023Config.instance:getGameCommonByKey(Commonkey.BackGround_RollingTime)
		local bgTargetSpeed = Run2023Config.instance:getGameCommonByKey(Commonkey.BackGround_NormalSpeed)

		stateId = InteractItemClickState.Fall

		local gender = RoleModel.instance:getGender()
		local spineInfos = CurSpineInfosByGender[gender]
		local fallAnimation = spineInfos.FallAnimation

		RoleObjectPool.instance:playAnimation(self._skeletonGraphic, fallAnimation, false, function()
			self:_resetCharacterAnim()
		end, true)

		self._roleArea.maxY = self._roleArea.FallY

		self:_setBgSpeed(bgRollTime, 0, bgTargetSpeed)
		self:_removeCellEff(self._aqEffect)
		self:_removeCellEff(self._xnEffect)
		settimer(0.5, self._handleFallEffect, self, false)
	elseif self._interactItemType == InteractItemType.Food then
		if posX >= self._deepArea.leftX and posX < self._deepArea.rightX then
			stateId = InteractItemClickState.SuperAccelera

			self:_playCellEff(self._aqEffect, EffectPath.AQ_Super_Accelera, 0, 0, true, nil)
			self:_playCellEff(self._xnEffect, EffectPath.XN_Super_Accelera, 0, 0, true, nil)
		elseif posX >= self._shallowArea.leftX and posX < self._shallowArea.rightX then
			stateId = InteractItemClickState.NormalAccelera

			self:_playCellEff(self._aqEffect, EffectPath.AQ_Normal_Accelera, 0, 0, true, nil)
			self:_playCellEff(self._xnEffect, EffectPath.XN_Normal_Accelera, 0, 0, true, nil)
		else
			stateId = InteractItemClickState.Decelerate

			self:_playCellEff(self._aqEffect, EffectPath.AQ_Normal, 0, 0, true, nil)
			self:_playCellEff(self._aqEffect, EffectPath.XN_Normal, 0, 0, true, nil)
		end
	end

	if stateId > 0 then
		self:_popTips(stateId)

		local planId = self._gameCfgs.statePlanId
		local reward = Run2023Config.instance:getGameStateCfgsById(planId, stateId).rewardTime

		self._sprintTime = self._sprintTime + reward

		for i, v in ipairs(self._goEffectItemList) do
			GameUtil.SetActive(v, i == stateId)
		end
	end
end

return Run2023MainView
