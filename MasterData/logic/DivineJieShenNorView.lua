-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejieshen/view/DivineJieShenNorView.lua

module("logic.extensions.divinejieshen.view.DivineJieShenNorView", package.seeall)

local DivineJieShenNorView = class("DivineJieShenNorView", ViewComponent)

function DivineJieShenNorView:ctor()
	DivineJieShenNorView.super.ctor(self)
end

function DivineJieShenNorView:buildUI()
	DivineJieShenNorView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._puzzleView = goutil.findChild(self.mainGO, "puzzleCol/puzzleView")
	self._puzzleCell = goutil.findChild(self.mainGO, "puzzleCol/puzzleCell")
	self._btnClg = goutil.findChild(self.mainGO, "puzzleCol/btnClg")
	self._txtBuff = goutil.findChildTextComponent(self.mainGO, "puzzleCol/buff/txt")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "stageCol/tips/txt")

	local stageScrView = goutil.findChild(self.mainGO, "stageCol/scrView")
	local stageScrCell1 = goutil.findChild(self.mainGO, "stageCol/scrCell1")
	local stageScrCell2 = goutil.findChild(self.mainGO, "stageCol/scrCell2")
	local stageScrCellList = {
		stageScrCell1,
		stageScrCell2
	}

	self._sizeList = {}

	for tag, go in ipairs(stageScrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCellList, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._stageScrollerList:regGetTagByIdx(function(data, idx)
		return idx % 2 + 1
	end)
	self._stageScrollerList:regGetCellSize(function(view, idx)
		local tag = idx % 2 + 1

		return self._sizeList[tag][1], self._sizeList[tag][2]
	end)

	self._puzzleGoList = {}
	self._flyEffRoot = goutil.findChild(self.mainGO, "flyEffRoot")
	self._flyStart = goutil.findChild(self.mainGO, "flyStart")
	self._flyEnd = goutil.findChild(self.mainGO, "flyEnd")
end

function DivineJieShenNorView:bindEvents()
	DivineJieShenNorView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function DivineJieShenNorView:unbindEvents()
	DivineJieShenNorView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
end

function DivineJieShenNorView:onEnter()
	DivineJieShenNorView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = DivineJieShenController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._divineJieShenMo = DivineJieShenModel.instance:getDivineJieShenMo(self._activityId)
	self._stageCfg = DivineJieShenConfig.instance:getNorStageCfg(self._activityId) or {}

	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgNormalRandomTrialRes, self._handlePM_DivineJieShenClgNormalRandomTrialRes, self)
	self.addGEvent(self, GlobalNotify.HandlePM_DivineJieShenClgNormalFinishGameRes, self._handlePM_DivineJieShenClgNormalFinishGameRes, self)
	self.addGEvent(self, GlobalNotify.DivineJieShenNorViewUpdate, self._onUpdate, self)
	self:_onUpdate()
end

function DivineJieShenNorView:onExit()
	DivineJieShenNorView.super.onExit(self)
	self:_onClear()
end

function DivineJieShenNorView:_handlePM_DivineJieShenClgNormalRandomTrialRes(msg)
	return
end

function DivineJieShenNorView:_handlePM_DivineJieShenClgNormalFinishGameRes(status, msg)
	self:close()
end

function DivineJieShenNorView:_onUpdate()
	self:_onUpdatePuzzleData()
	self:_onUpdateStageColUI()
	self:_onUpdatePuzzleColUI()

	if self._isNeedPuzzleAnim then
		self:_playFlyEff()
	end
end

function DivineJieShenNorView:_onClear()
	self:_onClearStageColUI()
	self:_onClearPuzzleColUI()
end

function DivineJieShenNorView:_onUpdatePuzzleData()
	self._isNeedPuzzleAnim = false
	self._puzzleLightTags = {}

	local key = string.format("djs_nor_lastPassStageId_in_%s", self._activityId)
	local lastPassStageId = checknumber(GameUtil.getUserData(key))
	local newestPassStageId = lastPassStageId

	for stageId, data in ipairs(self._stageCfg) do
		local isPass = self._divineJieShenMo:isPassedStageInNor(stageId)

		self._puzzleLightTags[stageId] = isPass and stageId <= lastPassStageId or false

		if isPass and lastPassStageId < stageId then
			newestPassStageId = stageId
			self._isNeedPuzzleAnim = true
		end
	end

	if lastPassStageId ~= newestPassStageId then
		GameUtil.saveUserData(key, newestPassStageId)
	end
end

function DivineJieShenNorView:_onUpdateStageColUI()
	local actData = DivineJieShenConfig.instance:getActData(self._activityId)
	local maxPassTimes = actData.normalClgMaxTimes
	local left = self._divineJieShenMo:getLeftClgTimesInNor()

	self._txtTips.text = string.format("每个试炼通关可获得镜灵碎片*<color=#ffffc5>1</color>，每日登录可累计<color=#ffffc5>2</color>次通关次数，当前剩余<color=#ffffc5>%s</color>/%s次", left, maxPassTimes)

	self._stageScrollerList:reloadData(self._stageCfg)
end

function DivineJieShenNorView:_onClearStageColUI()
	self._stageScrollerList:dispose()
end

function DivineJieShenNorView:_updateStageCell(view, cell, data, tag)
	local stageId = data.stageId
	local isPass = self._divineJieShenMo:isPassedStageInNor(stageId)
	local isInTime = self._divineJieShenMo:isInTimePeriodStageInNor(stageId)
	local isPassPreStage = self._divineJieShenMo:isPassPreStageInNor(stageId)
	local isLock = not isInTime or not isPassPreStage
	local nextStageData = DivineJieShenConfig.instance:getNorStageData(self._activityId, stageId + 1)
	local isHaveNextStage = nextStageData ~= nil
	local mainGo = cell.gameObject
	local imgLine = goutil.findChild(mainGo, "imgLine")
	local btnStage = goutil.findChild(mainGo, "btnStage")
	local txtName = goutil.findChildTextComponent(mainGo, "btnStage/txtName")
	local txtStage = goutil.findChildTextComponent(mainGo, "btnStage/txtStage")
	local imgPass = goutil.findChild(mainGo, "btnStage/imgPass")
	local imgLockCond = goutil.findChild(mainGo, "btnStage/imgLockCond")
	local imgLockTime = goutil.findChild(mainGo, "btnStage/imgLockTime")
	local txtLockTime = goutil.findChildTextComponent(mainGo, "btnStage/imgLockTime/txt")
	local imgSelect = goutil.findChild(mainGo, "btnStage/imgSelect")

	txtName.text = data.name
	txtStage.text = string.format("%02d", stageId)
	txtLockTime.text = not string.nilorempty(data.openTime) and GameUtil.formatTimeString("%m.%d %H:%M\n后开启", data.openTime) or ""

	GameUtil.SetActive(imgPass, isPass)
	GameUtil.SetActive(imgLockTime, not isInTime)
	GameUtil.SetActive(imgLockCond, not isPassPreStage and isInTime)
	GameUtil.SetActive(imgSelect, not isPass and not isLock)
	GameUtil.SetActive(imgLine, isHaveNextStage)
	GameUtil.addClickHandler(btnStage, GameUtil.handler(self._onClickStageCell, self, stageId))
end

function DivineJieShenNorView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnStage = goutil.findChild(mainGo, "btnStage")

	GameUtil.rmClickHandler(btnStage)
end

function DivineJieShenNorView:_onClickStageCell(stageId)
	local result, tips = self:_getTryStartStageResultAndTips(self._activityId, stageId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.DivineJieShenDrawView, self._activityId, stageId)
end

function DivineJieShenNorView:_onUpdatePuzzleColUI()
	local passStageId = self._divineJieShenMo:getPassedStageIdInNor()
	local buffData = DivineJieShenConfig.instance:getNorBuffData(self._activityId, passStageId)

	self._txtBuff.text = buffData and buffData.desc or "暂无\nBUFF"

	local bossStageResult = self:_getTryStartBossStageResultAndTips(self._activityId)

	GameUtil.SetGray(self._btnClg, bossStageResult ~= GameEnum.ResultCode.Success)

	local parentTran = self._puzzleView.transform
	local childGo = self._puzzleCell
	local childCount = parentTran.childCount

	for idx = 1, childCount do
		local mainGo = parentTran.transform:GetChild(idx - 1).gameObject

		GameUtil.SetActive(mainGo, false)
	end

	for stageId = 1, #self._stageCfg do
		local mainGo = stageId <= childCount and parentTran.transform:GetChild(stageId - 1).gameObject or goutil.cloneAndSetParent(childGo, parentTran, childGo.name .. stageId)

		GameUtil.SetActive(mainGo, true)

		self._puzzleGoList[stageId] = mainGo

		self:_updatePuzzleCell(mainGo, stageId)
	end
end

function DivineJieShenNorView:_onClearPuzzleColUI()
	self._puzzleGoList = {}

	GameUtil.clearCells(self._puzzleView, self._clearPuzzleCell, self)
end

function DivineJieShenNorView:_updatePuzzleCell(mainGo, stageId)
	local data = DivineJieShenConfig.instance:getNorStageData(self._activityId, stageId)
	local isLight = checkbool(self._puzzleLightTags[stageId])
	local imgPuzzle = goutil.findChild(mainGo, "imgPuzzle")

	if isLight then
		self:_loadBigBg(imgPuzzle, string.format("ui/bigbg/%s", data.puzzleImgUrl), true)

		if not data.puzzlePos then
			local pos = {}
			local x, y = checknumber(pos[1]), checknumber(pos[2])

			GameUtil.setLocalPos(mainGo, x, y, 0)
			GameUtil.SetActive(imgPuzzle, true)
		end
	else
		self:_unLoadBigBg(imgPuzzle)
		GameUtil.SetActive(imgPuzzle, false)
	end
end

function DivineJieShenNorView:_clearPuzzleCell(mainGo)
	local imgPuzzle = goutil.findChild(mainGo, "imgPuzzle")

	self:_unLoadBigBg(imgPuzzle)
end

function DivineJieShenNorView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = path .. ".png"

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function DivineJieShenNorView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function DivineJieShenNorView:_playFlyEff()
	local formPos = GameUtil.getPos(self._flyStart)
	local toPos = GameUtil.getPos(self._flyEnd)
	local effParent = self._flyEffRoot
	local pathName = "20240628/qijiyongzhe/fx_ui_qjyz_tuowei2"

	self:_stopFlyEff()
	GameUtil.setPos(effParent, formPos.x, formPos.y, formPos.z)
	GameUtil.SetActive(self._puzzleGoList[stageId], false)

	if not goutil.isNil(effParent) and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true

			GameUtil.SetActive(effParent, true)

			local tweener = effParent.transform:DOMove(toPos, 1.5)

			tweener:SetEase(DG.Tweening.Ease.Linear)

			local sequence = DG.Tweening.DOTween.Sequence()

			sequence:Join(tweener)
			sequence:AppendInterval(0.3)
			sequence:OnComplete(function()
				self:_onUpdatePuzzleData()
				self:_onUpdatePuzzleColUI()
				self:_stopFlyEff()
			end)

			self._flySequence = sequence
		end

		local handlerTarget

		self._flyEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end
end

function DivineJieShenNorView:_stopFlyEff()
	GameUtil.SetActive(effParent, false)
	UIEffectManager.instance:stopEffect(self._flyEff)

	if self._flySequence then
		self._flySequence:Kill(true)

		self._flySequence = nilorempty
	end
end

function DivineJieShenNorView:_getTryStartStageResultAndTips(activityId, stageId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._divineJieShenMo

	if mo:isPassedStageInNor(stageId) then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif not mo:isInTimePeriodStageInNor(stageId) then
		result = GameEnum.ResultCode.ErrorTime
		tips = "未开放"
	elseif not mo:isPassPreStageInNor(stageId) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "未通关前置关卡"
	end

	return result, tips
end

function DivineJieShenNorView:_getTryStartBossStageResultAndTips(activityId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = self._divineJieShenMo

	if mo:isPassBossInNor() then
		result = GameEnum.ResultCode.IsPass
		tips = "已通关"
	elseif not mo:isPassedStageInNor(mo:getStageCountInNor()) then
		result = GameEnum.ResultCode.NotPassLast
		tips = "未通关前置试炼关卡"
	end

	return result, tips
end

function DivineJieShenNorView:_onClickBtnTip()
	local key = DivineJieShenConfig.instance:getCommonValue(self._activityId, "ruleKeyNor")

	TipsFacade.instance:openRulesView(key)
end

function DivineJieShenNorView:_onClickBtnClg()
	local result, tips = self:_getTryStartBossStageResultAndTips(self._activityId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	DivineJieShenController.instance:enterBattleInNorBoss(self._activityId)
end

return DivineJieShenNorView
