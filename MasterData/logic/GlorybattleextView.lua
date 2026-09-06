-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorybattleextView.lua

module("logic.extensions.glorybattle.view.GlorybattleextView", package.seeall)

local GlorybattleextView = class("GlorybattleextView", ViewComponent)

GlorybattleextView.Step = {
	Two = 2,
	One = 1
}

function GlorybattleextView:ctor()
	GlorybattleextView.super.ctor(self)
end

function GlorybattleextView:unbindEvents()
	GlorybattleextView.super.unbindEvents(self)
	self._btnStart:RemoveClickListener()
	self._btnTips:RemoveClickListener()
end

function GlorybattleextView:bindEvents()
	GlorybattleextView.super.bindEvents(self)
	self._btnStart:AddClickListener(self._onClickbtnStart, self)
	self._btnTips:AddClickListener(self._onClickbtnTips, self)
end

function GlorybattleextView:buildUI()
	GlorybattleextView.super.buildUI(self)

	self._txtNum = self:getTxt("coin/txtNum")
	self._btnStart = self:getBtn("btnStart")
	self._txtStage = self:getTxt("btnStart/txtStage")
	self._txtDesc = self:getTxt("topDesc/txtDesc")
	self._txtTime = self:getTxt("txtTime")
	self._btnTips = self:getBtn("coin/btnTips")
	self._opHeadConGo = self:getGo("head/con")
	self._txtOpName = self:getTxt("head/txtName")

	self:_buildCutePet()
end

function GlorybattleextView:_buildCutePet()
	self._cutePetItems = {}

	for i = 1, 2 do
		local go = goutil.findChild(self.mainGO, "cutepet" .. i)
		local con = goutil.findChild(go, "con")
		local goTableview = goutil.findChild(go, "tableviewstar")
		local goTablecell = goutil.findChild(go, "tablecellstar")
		local txtName = goutil.findChildTextComponent(go, "txtName")
		local scrollList = ScrollerList.create(goTableview, goTablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

		self._cutePetItems[i] = {
			go = go,
			con = con,
			goTableview = goTableview,
			goTablecell = goTablecell,
			scrollList = scrollList,
			txtName = txtName
		}
	end
end

function GlorybattleextView:onExit()
	GlorybattleextView.super.onExit(self)

	for i, v in ipairs(self._cutePetItems) do
		v.scrollList:dispose()
		MaterialMgr.resetAll(v.con)
	end

	removetimer(self._tickTime, self)
	HeadItemController.instance:resetHeadCell(self._opHeadConGo)
	UIStateManager.instance:popByName(ViewName.GlorybattlelwtipsView)
	UIJumper.instance:removeTopState(ViewName.GlorybattlelwtipsView)
end

function GlorybattleextView:onEnter()
	GlorybattleextView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._updateUI, self)
	self.addGEvent(self, GlobalNotify.OnMissionBattleResBack, self._onOnMissionBattleResBack, self)
	self.addGEvent(self, GlobalNotify.FormationPet_POS_FINISH, self._updateOneKeyPos, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo._activityId
	self._gainNum = GlorybattleConfig.instance:getCommonValue("NEWLY_FIELD_GAIN_CURRENCY", true)

	local info = GlorybattleModel.instance:getInfo(self._activityId)

	self._lastPvpUseCreepsIdMap = {}

	for i, v in ipairs(info.challengeInfo.lastPvpUseCreepsId or {}) do
		self._lastPvpUseCreepsIdMap[v] = v
	end

	self._stepType = GlorybattleextView.Step.One
	self._oneStepTime = GlorybattleConfig.instance:getCommonValue("ONE_STEP_TIME", true)
	self._targetOneTime = ServerTime.now() + self._oneStepTime
	self._targetTwoTime = self._targetOneTime + self._oneStepTime
	self._targetThreeTime = self._targetTwoTime + self._oneStepTime
	self._sendEnterReq = false

	settimer(1, self._tickTime, self, true)
	self:_updateUI()
end

function GlorybattleextView:_tickTime()
	local now = ServerTime.now()
	local stepType = self._fmtMo:getStepType()
	local stepOne = stepType == GlorybattleController.Step.One and now >= self._targetOneTime
	local stepTwo = stepType == GlorybattleController.Step.Two and now >= self._targetTwoTime
	local stepThree = stepType == GlorybattleController.Step.Three and now >= self._targetThreeTime

	if stepOne or stepTwo then
		self:_onClickbtnStart()
	elseif stepThree then
		removetimer(self._tickTime, self)
		self:_handleStepThree()
	end

	if now <= self._targetOneTime then
		self._txtTime.text = string.format("一阶段倒计时：%ss", self._targetOneTime - now)
	elseif now <= self._targetTwoTime then
		self._txtTime.text = string.format("二阶段倒计时：%ss", self._targetTwoTime - now)
	elseif now <= self._targetThreeTime then
		self._txtTime.text = string.format("展示倒计时：%ss", self._targetThreeTime - now)
	end
end

function GlorybattleextView:_updateUI()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local baseGain, petUpGain = self:_getCurroundGainNum()
	local userId = checknumber(info.opponent.headInfo.userId)

	HeadItemController.instance:setHeadCellByInfo(self._opHeadConGo, info.opponent.headInfo, false)

	if userId < 0 then
		local creepsMasterId = math.abs(userId)
		local masterCfg = GlorybattleConfig.instance:getMasterCfg(creepsMasterId)

		self._txtOpName.text = masterCfg.name
	else
		self._txtOpName.text = info.opponent.headInfo.userName
	end

	self._txtNum.text = baseGain + petUpGain

	self:_setFormationDesc()
	self:_updateCutepets()
end

function GlorybattleextView:_updateCutepets()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local mycutePetInfo = info.challengeInfo.cutePetInfo
	local starList = self:_getCutePetStarList(info.challengeInfo.cutePetInfo)
	local enemyStarList = {}

	if info.opponent then
		local showEnemyCutePet = info.opponent.cutePetInfo

		self:_showCutePet(mycutePetInfo.cutePetId, mycutePetInfo.level, 1)
		goutil.setActive(self._cutePetItems[2].go, showEnemyCutePet)

		if showEnemyCutePet then
			local cutePetInfo = info.opponent.cutePetInfo

			enemyStarList = self:_getCutePetStarList(cutePetInfo)

			self:_showCutePet(cutePetInfo.cutePetId, cutePetInfo.level, 2)
		end

		self._cutePetItems[1].scrollList:reloadData(starList)
		self._cutePetItems[2].scrollList:reloadData(enemyStarList)
	end
end

function GlorybattleextView:_showCutePet(cutePetId, level, idx)
	local item = self._cutePetItems[idx]
	local goCon = item.con
	local txtName = item.txtName
	local raceId = GlorybattleConfig.instance:getCutePetRaceId(cutePetId)
	local cutepetCfg = CutePetConfig.instance:getCutePetById(raceId)
	local proxy = MaterialMgr.setCell(MatType.CutePet, raceId, goCon)

	proxy.binder:setAutoTips(false)
	proxy.binder:setCallBack(function()
		UIStateManager.instance:push(ViewName.GlorycutepetsimpletipView, cutePetId, level)
	end)

	txtName.text = cutepetCfg.name
end

function GlorybattleextView:_getCutePetStarList(cutePetInfo)
	local cutePetId = cutePetInfo.cutePetId
	local cutePetLv = cutePetInfo.level
	local cutePetLvCfgs = GlorybattleConfig.instance:getCutePetCfgs(cutePetId)
	local maxStar = #cutePetLvCfgs
	local starList = {}

	for i = 1, maxStar do
		table.insert(starList, {
			starIdx = i,
			cutePetLv = cutePetLv
		})
	end

	return starList
end

function GlorybattleextView:_onClickbtnStart()
	local stepType = self._fmtMo:getStepType()

	if stepType == GlorybattleController.Step.One then
		self:_handleStepOne()
	elseif stepType == GlorybattleController.Step.Two then
		self:_handleStepTwo()
	elseif stepType == GlorybattleController.Step.Three then
		self:_handleStepThree()
	end

	self:_setFormationDesc()
end

function GlorybattleextView:_handleStepOne()
	self._fmtMo:enterNextStep()
	self._fmtMo:updateFixPos()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)

	self._targetOneTime = 0
	self._targetTwoTime = ServerTime.now() + self._oneStepTime
end

function GlorybattleextView:_handleStepTwo()
	if self._fmtMo:getCurFormation():isEmpty() then
		FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
		MissionModel.instance:setForceResetOneKey(false)
	end

	self._fmtMo:enterNextStep()
	self._fmtMo:_initEnemyData()
	self._fmtMo:updateFixPos()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)

	self._targetTwoTime = 0
	self._targetThreeTime = ServerTime.now() + self._oneStepTime
end

function GlorybattleextView:_handleStepThree()
	if self._sendEnterReq then
		return
	end

	self._sendEnterReq = true

	GlorybattleController.instance:sendPM_GloryBattleFightReq(self._activityId, self._fmtMo:getCurFormation(), true)
end

function GlorybattleextView:_setFormationDesc()
	local stepType = self._fmtMo:getStepType()

	if stepType == GlorybattleController.Step.One then
		goutil.setActive(self._btnStart.gameObject, true)

		self._txtStage.text = "阶段1/2"

		local curFormation = self._fmtMo:getCurFormation()
		local positions = curFormation and curFormation:GetPositions() or {}
		local currentCount = 0

		for _, petId in ipairs(positions) do
			if petId ~= 0 then
				currentCount = currentCount + 1
			end
		end

		self._stageOnePetCount = currentCount
		self._txtDesc.text = langPara("请上阵<color=#FF0000>%d/%d</color>只精灵", currentCount, 3)

		self._fmtMo:setNeedUpPetCount(stepType)
	elseif stepType == GlorybattleController.Step.Two then
		self._txtStage.text = "阶段2/2"

		local curFormation = self._fmtMo:getCurFormation()
		local positions = curFormation and curFormation:GetPositions() or {}
		local totalCurrentCount = 0

		for _, petId in ipairs(positions) do
			if petId ~= 0 then
				totalCurrentCount = totalCurrentCount + 1
			end
		end

		if not self._stageOnePetCount then
			local stageOneCount = 0
			local currentCount = math.max(0, totalCurrentCount - stageOneCount)

			self._txtDesc.text = langPara("请上阵<color=#FF0000>%d/%d</color>只精灵", currentCount, 2)

			self._fmtMo:setNeedUpPetCount(stepType)
		end
	elseif stepType == GlorybattleController.Step.Three then
		self._txtDesc.text = langPara("即将进入战斗")

		self._fmtMo:setNeedUpPetCount(stepType)
	else
		self._txtDesc.text = langPara("即将进入战斗")
	end
end

function GlorybattleextView:_updateCell(view, cell, data, tag)
	GameUtil.SetGray(cell.gameObject, data.starIdx > data.cutePetLv)
end

function GlorybattleextView:_clearCell(cell)
	return
end

function GlorybattleextView:_onOnMissionBattleResBack(status)
	if status ~= 0 then
		self._sendEnterReq = false
	end
end

function GlorybattleextView:_onClickbtnTips()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local baseGain, petUpGain = self:_getCurroundGainNum()
	local content = string.format("收益说明：\n基础胜利收益：%s\n上阵上一场未上阵过的精灵时额外：%s", baseGain, petUpGain)

	CommonTipsMgr.instance:showTextTips(content, self._btnTips.gameObject)
end

function GlorybattleextView:_getCurroundGainNum()
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local petUpGain = 0
	local positions = self._fmtMo:getCurFormation():GetPositions()

	for i, petId in ipairs(positions) do
		if petId ~= 0 and not self._lastPvpUseCreepsIdMap[petId] and petId < GlorybattleModel.instance:getPetCardFakePetIdAddNum() then
			petUpGain = petUpGain + self._gainNum
		end
	end

	local baseGain = GlorybattleConfig.instance:getRoundGainNum(info.challengeInfo.curRound + 1)

	if info.challengeInfo.curRound <= 0 then
		petUpGain = 0
	end

	return baseGain, petUpGain
end

function GlorybattleextView:_updateOneKeyPos()
	if self._fmtMo:getCurFormation():isEmpty() then
		FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
		MissionModel.instance:setForceResetOneKey(false)
	end

	self._fmtMo:enterNextStep()
	self._fmtMo:_initEnemyData()
	self._fmtMo:updateFixPos()
	GlobalDispatcher:dispatch(GlobalNotify.FormationChanged)
	GlobalDispatcher:dispatch(GlobalNotify.RefreshEnemyFmt)
	goutil.setActive(self._btnStart.gameObject, false)
end

return GlorybattleextView
