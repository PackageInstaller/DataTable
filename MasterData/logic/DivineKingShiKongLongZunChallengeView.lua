-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingshikongllongzun/view/DivineKingShiKongLongZunChallengeView.lua

module("logic.extensions.divinekingshikongllongzun.view.DivineKingShiKongLongZunChallengeView", package.seeall)

local DivineKingShiKongLongZunChallengeView = class("DivineKingShiKongLongZunChallengeView", ViewComponent)
local BTN_Y = -42.3
local PASS_Y = -29.94
local LINE_Y = -80.9
local LINE_ROTATION_Y_List = {
	180,
	0
}
local LINE_POSITION_X_List = {
	-31,
	-51
}
local PASS_POSITION_X_List = {
	-109.8,
	20.3
}
local BTN_POSITION_X_List = {
	-65,
	65
}

function DivineKingShiKongLongZunChallengeView:ctor()
	DivineKingShiKongLongZunChallengeView.super.ctor(self)
end

function DivineKingShiKongLongZunChallengeView:unbindEvents()
	DivineKingShiKongLongZunChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnReset)
end

function DivineKingShiKongLongZunChallengeView:bindEvents()
	DivineKingShiKongLongZunChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function DivineKingShiKongLongZunChallengeView:buildUI()
	DivineKingShiKongLongZunChallengeView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnReset = self:getGo("btnReset")
	self._txtRule = self:getTxt("tip/scrView/Viewport/Content")
	self._reward = self:getGo("tip/reward")
	self._geted = self:getGo("tip/geted")
	self._stageList = {}

	for i = 1, 2 do
		local stageGo = self:getGo("challengeCells/challengeCell" .. i)

		table.insert(self._stageList, stageGo)
	end

	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineKingShiKongLongZunChallengeView:onExit()
	DivineKingShiKongLongZunChallengeView.super.onExit(self)
	self:clearStageUI()
	MaterialMgr.resetAll(self._reward)
	self._scrollList:dispose()
end

function DivineKingShiKongLongZunChallengeView:onEnter()
	DivineKingShiKongLongZunChallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineKingSpaceDragonInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineKingSpaceDragonResetFloorRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 521001
	end

	self._curPassFloor = DivineKingShiKongLongZunModel.instance:getCurPassFloor(self._activityId)
	self._info = DivineKingShiKongLongZunModel.instance:getInfo(self._activityId)
	self._actCfg = DivineKingShiKongLongZunConfig.instance:getActCfg(self._activityId)
	self._floorCfgs = DivineKingShiKongLongZunConfig.instance:getFloorCfgs(self._activityId)

	self:_onSetUI()
	DivineKingShiKongLongZunController.instance:sendPM_DivineKingSpaceDragonInfoReq(self._activityId)
end

function DivineKingShiKongLongZunChallengeView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	self._curPassFloor = DivineKingShiKongLongZunModel.instance:getCurPassFloor(self._activityId)

	local hasFirstPass = DivineKingShiKongLongZunModel.instance:hasFirstPass(self._activityId)
	local canShowFloor = math.min(self._curPassFloor + 1, #self._floorCfgs)

	self._selectFLoor = self._curPassFloor == 0 and 1 or canShowFloor

	if hasFirstPass then
		local canChallengeFloor = DivineKingShiKongLongZunController.instance:getCanChallengeFloor(self._activityId)
		local SELECT_FLOOR_KEY = "DivineKingShiKongLongZunChallengeView" .. self._activityId
		local preChooseFloor = GameUtil.getUserData(SELECT_FLOOR_KEY)

		preChooseFloor = preChooseFloor or 1

		local preFLoorIsPass = DivineKingShiKongLongZunModel.instance:floorIsPass(self._activityId, preChooseFloor)

		if canChallengeFloor > 0 then
			self._selectFLoor = canChallengeFloor
		end

		if preChooseFloor and not preFLoorIsPass then
			self._selectFLoor = preChooseFloor
		end

		self._scrollList:MoveCellToCenter(self._selectFLoor)
	else
		self._scrollList:MoveCellToCenter(self._curPassFloor)
	end

	local floorHasFirstPass = DivineKingShiKongLongZunController.instance:floorHasFirstPass(self._activityId, self._selectFLoor)
	local floorNum = #self._floorCfgs

	self._curFloor = math.min(self._curPassFloor + 1, floorNum)
	self._curFloorCfg = self._floorCfgs[self._curFloor]
	self._txtRule.text = self._actCfg.showRule

	MaterialMgr.setCellByCfg(self._curFloorCfg.prize, self._reward)
	GameUtil.SetActive(self._geted, floorHasFirstPass)
	self._scrollList:reloadData(self._floorCfgs)
	self:_updateStageUI()
end

function DivineKingShiKongLongZunChallengeView:_onUpdate()
	self._info = DivineKingShiKongLongZunModel.instance:getInfo(self._activityId)
	self._curPassFloor = DivineKingShiKongLongZunModel.instance:getCurPassFloor(self._activityId)

	local floorHasFirstPass = DivineKingShiKongLongZunController.instance:floorHasFirstPass(self._activityId, self._selectFLoor)
	local hasFirstPass = DivineKingShiKongLongZunModel.instance:hasFirstPass(self._activityId)

	if not hasFirstPass then
		local canShowFloor = math.min(self._curPassFloor + 1, #self._floorCfgs)

		self._selectFLoor = math.min(self._selectFLoor, canShowFloor)
	end

	self._curFloor = math.min(self._curPassFloor + 1, #self._floorCfgs)
	self._curFloorCfg = self._floorCfgs[self._selectFLoor]
	self._txtRule.text = self._actCfg.showRule

	MaterialMgr.setCellByCfg(self._curFloorCfg.prize, self._reward)
	GameUtil.SetActive(self._geted, floorHasFirstPass)
	self._scrollList:reloadData(self._floorCfgs)
	self:_updateStageUI()
end

function DivineKingShiKongLongZunChallengeView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DivineKingShiKongLongZunChallengeView:_updateStageUI()
	for i, stageGo in ipairs(self._stageList) do
		local pass = goutil.findChild(stageGo, "stageFmt/pass")
		local fmt = goutil.findChild(stageGo, "stageFmt/fmt")
		local btnChallenge = goutil.findChild(stageGo, "btnChallenge")
		local curStagePlanId = DivineKingShiKongLongZunConfig.instance:getStagePlanId(self._activityId, self._selectFLoor)
		local curStageCfg = DivineKingShiKongLongZunConfig.instance:getStageCfgByStageId(curStagePlanId, i)
		local creepMasterId = curStageCfg.creepsMasterId
		local creepCfg = DivineKingShiKongLongZunConfig.instance:getCreepCfg(creepMasterId)

		if self._info then
			local curFloorInfo = self._info.floorInfos[self._selectFLoor]
			local passStageId = curFloorInfo.maxPassStageId
			local isPass = passStageId >= curStageCfg.stageId
			local preStageHasPass = passStageId >= curStageCfg.stageId - 1
			local preFloor = self._selectFLoor - 1
			local preFloorHasPass = preFloor <= self._curPassFloor
			local isFirstStage = curStageCfg.stageId == 1
			local isLastStage = curStageCfg.stageId == DivineKingShiKongLongZunModel.FLOOR_TOTAL_CHALLENGE_NUM

			self:_setFmt(fmt, creepCfg)
			GameUtil.SetGray(btnChallenge, not preStageHasPass and isLastStage)
			GameUtil.SetActive(pass, isPass)
			GameUtil.addClickHandler(btnChallenge, function()
				local allFloorHasFirstPass = DivineKingShiKongLongZunController.instance:allFloorHasFirstPass(self._activityId)

				if self._selectFLoor ~= 1 and not preFloorHasPass and not allFloorHasFirstPass then
					FloatWordMgr.instance:show("请先通过之前层")

					return
				end

				if isPass then
					FloatWordMgr.instance:show("已通过，无需重复挑战")

					return
				end

				if not preStageHasPass and not isFirstStage then
					FloatWordMgr.instance:show("请先通过上一关")

					return
				end

				DivineKingShiKongLongZunController.instance:enterBattleClg(self._activityId, self._selectFLoor, i)
			end, self)
		end
	end
end

function DivineKingShiKongLongZunChallengeView:clearStageUI()
	for i, stageGo in ipairs(self._stageList) do
		local btnChallenge = goutil.findChild(stageGo, "btnChallenge")
		local fmt = goutil.findChild(stageGo, "stageFmt/fmt")

		GameUtil.rmClickHandler(btnChallenge)
		self:_clearFmt(fmt)
	end
end

function DivineKingShiKongLongZunChallengeView:_setFmt(fmtView, cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = fmtView.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setCell(MatType.Pet, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId), con)
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function DivineKingShiKongLongZunChallengeView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.resetAll(con)
	end
end

function DivineKingShiKongLongZunChallengeView:_updateCell(view, cell, data)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local imgSelect = goutil.findChild(cell, "btnChallenge/imgSelect")
	local imgLine = goutil.findChild(cell, "imgLine")
	local pass = goutil.findChild(cell, "pass")
	local txtNameGray = goutil.findChildTextComponent(cell, "btnChallenge/txtNameGray")
	local txtName = goutil.findChildTextComponent(cell, "btnChallenge/txtName")
	local curIndex = data.floorId % 2 + 1
	local lineRotationY = LINE_ROTATION_Y_List[curIndex]
	local linePositionX = LINE_POSITION_X_List[curIndex]
	local passPositionX = PASS_POSITION_X_List[curIndex]
	local btnPositionX = BTN_POSITION_X_List[curIndex]
	local curFloorPass = DivineKingShiKongLongZunModel.instance:floorIsPass(self._activityId, data.floorId)
	local isCanFightFloor = self._curPassFloor + 1 == data.floorId
	local isLastFloor = data.floorId == #self._floorCfgs
	local numStr = GameUtil.getChineseNumber(data.floorId)
	local hasFirstPass = DivineKingShiKongLongZunModel.instance:hasFirstPass(self._activityId)
	local canSetGray = false

	canSetGray = hasFirstPass and curFloorPass or curFloorPass or not isCanFightFloor
	txtName.text = string.format("第%s层", numStr)
	txtNameGray.text = string.format("第%s层", numStr)

	GameUtil.setLocalRotation(imgLine, 0, checknumber(lineRotationY), 0)
	GameUtil.setAnchoredPos(imgLine, linePositionX, LINE_Y)
	GameUtil.setAnchoredPos(btnChallenge, btnPositionX, BTN_Y)
	GameUtil.setAnchoredPos(pass, passPositionX, PASS_Y)
	GameUtil.SetActive(pass, curFloorPass)
	GameUtil.SetActive(imgLine, not isLastFloor)
	GameUtil.SetActive(imgSelect, self._selectFLoor == data.floorId)
	GameUtil.SetActive(txtNameGray.gameObject, canSetGray)
	GameUtil.SetActive(txtName.gameObject, not canSetGray)
	GameUtil.SetGray(btnChallenge, canSetGray)
	GameUtil.SetGray(imgSelect, canSetGray)
	GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self._onClickBtnChallengeFloor, self, data.floorId))
end

function DivineKingShiKongLongZunChallengeView:_clearCell(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)
end

function DivineKingShiKongLongZunChallengeView:_onClickBtnChallengeFloor(floorId)
	local hasFirstPass = DivineKingShiKongLongZunModel.instance:hasFirstPass(self._activityId)
	local canNotChoose = false

	if not hasFirstPass then
		canNotChoose = floorId ~= self._curPassFloor + 1
	else
		local SELECT_FLOOR_KEY = "DivineKingShiKongLongZunChallengeView" .. self._activityId

		GameUtil.saveUserData(SELECT_FLOOR_KEY, floorId)
	end

	if canNotChoose then
		FloatWordMgr.instance:show("首通后可选择其他关卡")

		return
	end

	self._selectFLoor = floorId

	self:_onUpdate()
end

function DivineKingShiKongLongZunChallengeView:_onClickBtnReset()
	local curFloorIsPass = DivineKingShiKongLongZunModel.instance:floorIsPass(self._activityId, self._selectFLoor)
	local allFloorPass = DivineKingShiKongLongZunController.instance:allFloorHasPass(self._activityId)

	if curFloorIsPass and not allFloorPass then
		FloatWordMgr.instance:show("已通过当前关卡，无需重置")

		return
	end

	if self._info then
		local curFloorInfo = self._info.floorInfos[self._selectFLoor]

		if curFloorInfo then
			if not curFloorInfo.maxPassStageId then
				local maxPassStageId = 0

				if maxPassStageId <= 0 then
					FloatWordMgr.instance:show("未挑战，无需重置")

					return
				end

				local content = "是否将本层重置为未挑战，重置精灵血量"

				local function okFunc()
					DivineKingShiKongLongZunController.instance:sendPM_DivineKingSpaceDragonResetFloorReq(self._activityId, self._selectFLoor)
				end

				TipsFacade.instance:openPopupWindow("wishing", content, okFunc, nil, "确认", "取消")
			end
		end
	end
end

return DivineKingShiKongLongZunChallengeView
