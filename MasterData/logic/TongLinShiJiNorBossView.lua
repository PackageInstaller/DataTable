-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiNorBossView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiNorBossView", package.seeall)

local TongLinShiJiNorBossView = class("TongLinShiJiNorBossView", ViewComponent)

function TongLinShiJiNorBossView:ctor()
	TongLinShiJiNorBossView.super.ctor(self)
end

function TongLinShiJiNorBossView:buildUI()
	TongLinShiJiNorBossView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._ruleTitle = self:getGo("ruleTitle")
	self._txtTipRule = self:getTxt("ruleTitle/scrView/Viewport/Content")
	self._cell = self:getGo("right/cell")
	self._buffcells = self:getGo("right/buffcells")
	self._cellGoList = {}
	self._txtBlood = self:getTxt("sliderBlood/blood/txtBlood")
	self._sliderBlood = self:getSlider("sliderBlood")
	self._fmt = self:getGo("challenge/bossFmt/fmt")
	self._btnChallenge = self:getGo("challenge/btnChallenge")
	self._txtBossTime = self:getTxt("challenge/bossTime/txt")
	self._btnPractice = self:getGo("btnPractice")
	self._cellList = {}

	for i = 1, 5 do
		local cur = goutil.cloneAndSetParent(self._cell, self._buffcells.transform, "cell" .. i)

		table.insert(self._cellGoList, cur)
	end

	for idx, cell in ipairs(self._cellGoList) do
		local cur = {}

		cur.itemcell = goutil.findChild(cell, "itemcell")
		cur.txtDesc = goutil.findChildTextComponent(cell, "txtDesc")

		table.insert(self._cellList, cur)
	end

	self._fmtList = {}

	for i = 1, self._fmt.transform.childCount do
		local fmtCell = {}

		fmtCell.go = self:getGo("challenge/bossFmt/fmt/cell_" .. i)
		fmtCell.con = goutil.findChild(fmtCell.go, "con")

		table.insert(self._fmtList, fmtCell)
	end
end

function TongLinShiJiNorBossView:bindEvents()
	TongLinShiJiNorBossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnPractice, self._onClickPractice, self)
end

function TongLinShiJiNorBossView:unbindEvents()
	TongLinShiJiNorBossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnPractice)
end

function TongLinShiJiNorBossView:onEnter()
	TongLinShiJiNorBossView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGainPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = TongLinShiJiController.instance:getActivityId()
	end

	self._activityType = TongLinShiJiController.instance:getActivityType()

	local isInTime = TongLinShiJiController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.dailyClgNorTimes = TongLinShiJiConfig.instance:getJiActivityData(self._activityId).dailyClgNormalStageTimes
	self.dailyClgNorBossTimes = TongLinShiJiConfig.instance:getJiActivityData(self._activityId).dailyClgNormalBossTimes
	self._norStageData = TongLinShiJiConfig.instance:getJiNormalStageData(self._activityId)
	self._buffData = TongLinShiJiConfig.instance:getJiBuffData()

	self:_onSetUI()
end

function TongLinShiJiNorBossView:onExit()
	TongLinShiJiNorBossView.super.onExit(self)
	MaterialMgr.resetAll(self._itemcell)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	for i, cell in ipairs(self._cellList) do
		MaterialMgr.resetAll(cell)
	end

	self._cellList = {}

	self:_clearFmt()
end

function TongLinShiJiNorBossView:_onSetUI()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	self._txtTipRule.text = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleNormal")

	local bossId = TongLinShiJiConfig.instance:getJiActivityData(self._activityId).normalBossId
	local fmtCfg = TongLinShiJiConfig.instance:getJiCreepsData(bossId) or {}

	GameUtil.SetActive(self._cell, false)
	self:_setBossFmt(fmtCfg)
	self:_onUpdate()
end

function TongLinShiJiNorBossView:_onUpdate()
	self:_updateData()
	self:_updateUI()
end

function TongLinShiJiNorBossView:_updateData()
	self._curBuffs = TongLinShiJiModel.instance:CurNorBossBuffs(self._activityId)
end

function TongLinShiJiNorBossView:_updateUI()
	local canGetNorReward = TongLinShiJiController.instance:CanGetNorReward(self._activityId)
	local curNorBossHP = TongLinShiJiController.instance:GetNorBossHP(self._activityId)
	local curNorBossProgress = TongLinShiJiController.instance:GetNorBossProgress(self._activityId)
	local challengeTimesClg, bossTimesClg = TongLinShiJiConfig.instance:GetNorTimesClg(self._activityId)
	local curChallengeLeftTime, curBossLeftTime = TongLinShiJiModel.instance:GetNorLeftTimes(self._activityId)

	self._txtBossTime.text = "今日剩余<color=#4BFB39FF>" .. curBossLeftTime .. "/" .. bossTimesClg .. "</color>次挑战"
	self._txtBlood.text = curNorBossHP .. "%"

	self._sliderBlood:SetValue(curNorBossProgress)

	for idx, cell in ipairs(self._cellList) do
		if self._norStageData[idx] then
			local creepsId = self._norStageData[idx].unlockSupportCreepsId
			local supportPetData = TongLinShiJiConfig.instance:getJiSupportPetData(creepsId)
			local raceId = supportPetData.raceId

			MaterialMgr.setCell(MatType.Pet, raceId, cell.itemcell)

			cell.txtDesc.text = table.indexof(self._curBuffs, idx) and (self._buffData[idx].descBossBuff or "") or "还未获得"
		end
	end
end

function TongLinShiJiNorBossView:_setBossFmt(cfg)
	local map = {}

	for _, data in ipairs(cfg) do
		map[data.posId] = data
	end

	for posId = 1, 9 do
		local creepsData = map[posId]
		local go = self._fmtList[posId].go
		local con = self._fmtList[posId].con

		MaterialMgr.clearIcon(con)
		GameUtil.SetActive(go, false)

		if creepsData then
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function TongLinShiJiNorBossView:_clearFmt()
	for posId = 1, 9 do
		local con = self._fmtList[posId].con

		MaterialMgr.clearIcon(con)
	end
end

function TongLinShiJiNorBossView:_onClickBtnChallenge()
	local curChallengeLeftTime, curBossLeftTime = TongLinShiJiModel.instance:GetNorLeftTimes(self._activityId)

	if curBossLeftTime <= 0 then
		FloatWordMgr.instance:show("今日挑战次数已用完，请明天再来吧！")

		return
	end

	local curNorBossHP = TongLinShiJiController.instance:bossLeftHP(self._activityId)

	if curNorBossHP <= 0 then
		FloatWordMgr.instance:show("已挑战成功，不需要再次挑战")

		return
	end

	TongLinShiJiController.instance:enterNorBossBattleClg(self._activityId, false)
end

function TongLinShiJiNorBossView:_onClickPractice()
	local curNorBossHP = TongLinShiJiController.instance:bossLeftHP(self._activityId)

	if curNorBossHP <= 0 then
		FloatWordMgr.instance:show("已挑战成功，不需要再次挑战")

		return
	end

	TongLinShiJiController.instance:enterNorBossBattleClg(self._activityId, true)
end

function TongLinShiJiNorBossView:_onClickBtnTip()
	local key = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleKeyNormalBoss")

	TipsFacade.instance:openRulesView(key)
end

function TongLinShiJiNorBossView:_getRaceId()
	return TongLinShiJiController.instance:getRaceId(self._activityId)
end

function TongLinShiJiNorBossView:_getSkinId()
	return TongLinShiJiController.instance:getSkinId(self._activityId)
end

return TongLinShiJiNorBossView
