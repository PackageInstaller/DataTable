-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErLevelView.lua

module("logic.extensions.originxiuer.view.OriginXiuErLevelView", package.seeall)

local OriginXiuErLevelView = class("OriginXiuErLevelView", ViewComponent)
local bg_pos_y_list = {
	-7.6,
	119,
	0,
	-129.9
}
local line_pos_list = {
	{
		91.2,
		24.7,
		0
	},
	{
		102.8,
		-93.5,
		-59
	},
	{
		102.8,
		-93.5,
		-59
	},
	{
		108,
		34.8,
		0
	}
}

function OriginXiuErLevelView:ctor()
	OriginXiuErLevelView.super.ctor(self)
end

function OriginXiuErLevelView:unbindEvents()
	OriginXiuErLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCloseChallenge)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnReset)
end

function OriginXiuErLevelView:bindEvents()
	OriginXiuErLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnCloseChallenge, self._onClickBtnCloseChallenge, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function OriginXiuErLevelView:buildUI()
	OriginXiuErLevelView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._reward = self:getGo("reward/item")
	self._btnReward = self:getGo("reward/btnReward")
	self._btnReset = self:getGo("btnReset")
	self._txtBuffEmptyGo = self:getGo("tableviewLock/txtEmpty")
	self._challengeBoard = self:getGo("challengeBoard")
	self._btnCloseChallenge = self:getGo("btnCloseChallenge")
	self._txtCloseChallengwName = self:getTxt("challengeBoard/txtName")
	self._fmt = self:getGo("challengeBoard/stageFmt/fmt")
	self._curLevelReward = self:getGo("challengeBoard/item")
	self._btnChallenge = self:getGo("challengeBoard/btnChallenge")
	self._tablecellBuff = self:getGo("challengeBoard/tableview/tablecell")
	self._tableviewBuff = self:getGo("challengeBoard/tableview")
	self._scrollListBuff = ScrollerList.create(self._tableviewBuff, self._tablecellBuff, GameUtil.handler(self._updateCellBuff, self), GameUtil.handler(self._clearCellBuff, self))
	self._tableviewLevel = self:getGo("tableviewLevel")
	self._tablecellLevel = self:getGo("tableviewLevel/tablecell")
	self._scrollListLevel = ScrollerList.create(self._tableviewLevel, self._tablecellLevel, GameUtil.handler(self._updateCellLevel, self), GameUtil.handler(self._clearCellLevel, self))
	self._tableviewLock = self:getGo("tableviewLock")
	self._tablecellLock = self:getGo("tableviewLock/tablecell")
	self._scrollListLock = ScrollerList.create(self._tableviewLock, self._tablecellLock, GameUtil.handler(self._updateCellLock, self), GameUtil.handler(self._clearCellLock, self))
end

function OriginXiuErLevelView:onExit()
	OriginXiuErLevelView.super.onExit(self)
	MaterialMgr.clearIcon(self._reward)
	MaterialMgr.resetAll(self._curLevelReward)
	self._scrollListLevel:dispose()
	self._scrollListLock:dispose()
	self._scrollListBuff:dispose()
end

function OriginXiuErLevelView:onEnter()
	OriginXiuErLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginXiuErInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_OriginXiuErResetRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 537001
	end

	self._selectStageId = 1
	self._actCfg = OriginXiuErConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = OriginXiuErConfig.instance:getStageCfgs(self._activityId)
	self._powerPetMo = FightingPowerPetMo.New()

	self:_onSetUI()
	OriginXiuErController.instance:sendPM_OriginXiuErInfoReq(self._activityId)
end

function OriginXiuErLevelView:_onSetUI()
	local lastStageCfg = self._stageCfgs[#self._stageCfgs]
	local prizeStr = lastStageCfg.prize
	local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._scrollListLevel:reloadData(self._stageCfgs)
	self._scrollListLevel:MoveCellToCenter(self._selectStageId - 1)
	MaterialMgr.setIcon(self._reward, matType, matId, nil, nil)
end

function OriginXiuErLevelView:_onUpdate()
	self._info = OriginXiuErModel.instance:getInfo(self._activityId)
	self._raceIdMap = OriginXiuErModel.instance:getRaceIdMap(self._activityId)

	local curPassStageId = self._info.maxPassStageId

	self._selectStageId = math.min(curPassStageId + 1, #self._stageCfgs)
	self._stageCfg = self._stageCfgs[self._selectStageId]
	self._lockPetList, self._unLockPetList = OriginXiuErController.instance:getLockAndUnlockPetPair(self._activityId)
	self._txtCloseChallengwName.text = string.format("修尔挑战-%d", self._selectStageId)

	self._scrollListLevel:reloadData(self._stageCfgs)
	self._scrollListLevel:MoveCellToCenter(self._selectStageId - 1)
	self._scrollListLock:setCenterMode(true)
	self._scrollListLock:reloadData(self._lockPetList)
	self:_updateChallengeBoard()
	GameUtil.SetActive(self._txtBuffEmptyGo, #self._lockPetList == 0)
end

function OriginXiuErLevelView:_updateCellLevel(view, cell, data)
	local bg = goutil.findChild(cell, "bg")
	local imgLine = goutil.findChild(cell, "bg/imgLine")
	local imgSelect = goutil.findChild(cell, "bg/imgSelect")
	local pass = goutil.findChild(cell, "bg/pass")
	local lock = goutil.findChild(cell, "bg/lock")
	local openTime = goutil.findChild(cell, "bg/openTime")
	local txtLockTime = goutil.findChildTextComponent(cell, "bg/openTime/txtLockTime")
	local index = cell.index
	local posIdx = index % 4 + 1
	local linePos = line_pos_list[posIdx]
	local posY = bg_pos_y_list[posIdx]

	if self._info then
		if not self._info.maxPassStageId then
			local curPassStageId = 0
			local curStageId = math.min(curPassStageId + 1, #self._stageCfgs)
			local isCurStage = data.stageId == curStageId
			local hasPassed = curPassStageId >= data.stageId
			local isLast = data.stageId == #self._stageCfgs
			local openTimeStamp = GameUtil.string2time(data.openTime)
			local isOpenTime = openTimeStamp <= ServerTime.now()
			local isLock = false

			isLock = isCurStage and not isOpenTime or not hasPassed or not isOpenTime
			txtLockTime.text = GameUtil.formatTimeStamp("%Y-%m-%d\n%H:%M:%S", openTimeStamp)

			GameUtil.setAnchoredPos(bg, 0, posY)
			GameUtil.setAnchoredPos(imgLine, linePos[1], linePos[2])
			GameUtil.setLocalRotation(imgLine, 0, 0, linePos[3])
			GameUtil.SetActive(imgLine, not isLast)
			GameUtil.SetActive(pass, hasPassed)
			GameUtil.SetActive(lock, isLock)
			GameUtil.SetActive(openTime, not isOpenTime)
			GameUtil.addClickHandler(bg, function()
				if not isOpenTime then
					local tipStr = string.format("未到开启时间， 请在%s后进入关卡", GameUtil.formatTimeStamp("%Y年%m月%d日 %H:%M:%S", openTimeStamp))

					FloatWordMgr.instance:show(tipStr)

					return
				end

				if hasPassed then
					FloatWordMgr.instance:show("已通关")

					return
				end

				if not hasPassed and not isCurStage then
					FloatWordMgr.instance:show("请先通关前置关卡")

					return
				end

				self:_onUpdate()
				GameUtil.SetActive(self._challengeBoard, true)
				GameUtil.SetActive(self._btnCloseChallenge, true)
			end, self)
		end
	end
end

function OriginXiuErLevelView:_clearCellLevel(cell)
	local bg = goutil.findChild(cell, "bg")

	GameUtil.rmClickHandler(bg)
end

function OriginXiuErLevelView:_updateCellLock(view, cell, data)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.setCell(MatType.Pet, data.left, pet)
end

function OriginXiuErLevelView:_clearCellLock(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function OriginXiuErLevelView:_updateCellBuff(view, cell, data)
	local pet = goutil.findChild(cell, "pet")

	self._powerPetMo:fromChallengeCreepCo(data)

	local bagPetMo = self._powerPetMo:toBaseBagPetMo()
	local proxy = MaterialMgr.setCellByMo(bagPetMo, pet)

	if proxy then
		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(bagPetMo)
		end)
	end
end

function OriginXiuErLevelView:_clearCellBuff(cell)
	local pet = goutil.findChild(cell, "pet")

	MaterialMgr.resetAll(pet)
end

function OriginXiuErLevelView:_openChallengeBoard()
	GameUtil.SetActive(self._challengeBoard, true)
end

function OriginXiuErLevelView:_updateChallengeBoard()
	local creepMasterId = OriginXiuErConfig.instance:getCreepMasterId(self._activityId, self._selectStageId)
	local fmtCfg = OriginXiuErConfig.instance:getCreepsCfg(creepMasterId)
	local buffEnemyList = OriginXiuErConfig.instance:getBuffEnemyList(self._activityId, self._selectStageId)

	self:_setFmt(self._fmt, fmtCfg)
	self._scrollListBuff:reloadData(buffEnemyList)
	self._scrollListBuff:setCenterMode(true)
	MaterialMgr.setCellByCfg(self._stageCfg.prize, self._curLevelReward)
end

function OriginXiuErLevelView:_setFmt(fmtView, cfg)
	local buffPosition = self._stageCfg.buffPosition
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")
		local tag = goutil.findChild(go, "tag")
		local hasBuff = buffPosition[posId] > 0

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)
		GameUtil.SetActive(tag, hasBuff)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function OriginXiuErLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function OriginXiuErLevelView:_onClickBtnCloseChallenge()
	GameUtil.SetActive(self._challengeBoard, false)
	GameUtil.SetActive(self._btnCloseChallenge, false)
end

function OriginXiuErLevelView:_onClickBtnChallenge()
	local isLast = self._selectStageId == #self._stageCfgs

	if self._selectStageId <= self._info.maxPassStageId and isLast then
		FloatWordMgr.instance:show("已完成所有关卡，无需重复挑战")

		return
	end

	OriginXiuErController.instance:enterBattleClg(self._activityId, self._selectStageId)
end

function OriginXiuErLevelView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.OriginXiuErRewardView, self._activityId)
end

function OriginXiuErLevelView:_onClickBtnReset()
	if self._info then
		if not self._info.maxPassStageId then
			local maxPassStageId = 0

			if maxPassStageId <= 0 then
				FloatWordMgr.instance:show("尚未通关关卡，无需重置")

				return
			end

			local function okFunc()
				OriginXiuErController.instance:sendPM_OriginXiuErResetReq(self._activityId)
				self:_onClickBtnCloseChallenge()
			end

			TipsFacade.instance:openPopupWindow("提示", "是否重置所有关卡", okFunc, nil, "确定", "取消")
		end
	end
end

return OriginXiuErLevelView
