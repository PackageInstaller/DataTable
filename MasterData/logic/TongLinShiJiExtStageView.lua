-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tonglinshiji/view/TongLinShiJiExtStageView.lua

module("logic.extensions.tonglinshiji.view.TongLinShiJiExtStageView", package.seeall)

local TongLinShiJiExtStageView = class("TongLinShiJiExtStageView", ViewComponent)

function TongLinShiJiExtStageView:ctor()
	TongLinShiJiExtStageView.super.ctor(self)
end

function TongLinShiJiExtStageView:buildUI()
	TongLinShiJiExtStageView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._ruleTitle = self:getGo("ruleTitle")
	self._txtTipRule = self:getTxt("ruleTitle/img/Text")
	self._cells = self:getGo("cells")
	self._cellGoList = {}

	for i = 1, self._cells.transform.childCount do
		local cell = goutil.findChild(self._cells, "challengeCell" .. i)

		table.insert(self._cellGoList, cell)
	end

	self._cellList = {}
end

function TongLinShiJiExtStageView:bindEvents()
	TongLinShiJiExtStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function TongLinShiJiExtStageView:unbindEvents()
	TongLinShiJiExtStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for i, cell in ipairs(self._cellList) do
		GameUtil.rmClickHandler(cell.btnChallenge)
		GameUtil.rmClickHandler(cell.btnTip)
	end
end

function TongLinShiJiExtStageView:onEnter()
	TongLinShiJiExtStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGetInfoRes, self._onSetUI, self)
	self.addGEvent(self, GlobalNotify.PM_JiClgGainPrizeRes, self._onSetUI, self)

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

	self._raceType = params[2]
	self._creepsIds = TongLinShiJiConfig.instance:GetExtCreepsIds(self._activityId, self._raceType)

	for idx, cell in ipairs(self._cellGoList) do
		local cur = {}

		cur.btnTip = goutil.findChild(cell, "btnTip")
		cur.fmt = goutil.findChild(cell, "stageFmt/fmt")
		cur.btnChallenge = goutil.findChild(cell, "btnChallenge")
		cur.title = goutil.findChildTextComponent(cell, "title")
		cur.txtPower = goutil.findChildTextComponent(cell, "power/txt")

		table.insert(self._cellList, cur)
	end

	self:_onSetUI()
	TongLinShiJiController.instance:sendPM_JiClgGetInfoReq(self._activityId)
end

function TongLinShiJiExtStageView:onExit()
	TongLinShiJiExtStageView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	for i, cell in ipairs(self._cellList) do
		self:_clearFmt(cell.fmt)
	end

	self._cellList = {}
end

function TongLinShiJiExtStageView:_onSetUI()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
	self._txtTipRule.text = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleExtrem")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._ruleTitle.transform)

	for idx, creepsId in ipairs(self._creepsIds) do
		local creepCfg = TongLinShiJiConfig.instance:getJiCreepsData(creepsId)
		local cell = self._cellList[idx]

		if cell then
			self:_setFmt(cell.fmt, creepCfg)
		end
	end

	for idx, cell in ipairs(self._cellList) do
		cell.title.text = TongLinShiJiConfig.instance:GetEtrRuleShort(self._activityId, self._raceType, idx)

		local recordPower = TongLinShiJiModel.instance:GetExtPowerTeam(self._activityId, self._raceType, idx)

		cell.txtPower.text = "记录能量：<color=#FF0000FF>" .. (recordPower ~= -1 and recordPower or 0) .. "</color>"

		GameUtil.addClickHandler(cell.btnTip, function()
			UIStateManager.instance:push(ViewName.TongLinShiJiExtRuleView, self._activityId, self._raceType, idx)
		end)
		GameUtil.addClickHandler(cell.btnChallenge, function()
			local canGetReward = TongLinShiJiController.instance:CanGetExtReward(self._activityId)

			if canGetReward then
				FloatWordMgr.instance:show("已满足聚力条件，无需再次挑战")

				return
			end

			TongLinShiJiController.instance:enterExtBattleClg(self._activityId, self._raceType, idx)
		end)
	end
end

function TongLinShiJiExtStageView:_setFmt(fmtView, cfg)
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
			MaterialMgr.setIcon(con, MatType.PET_SKIN, (checknumber(creepsData.faceId) > 0 or nil) and checknumber(creepsData.faceId))
			GameUtil.SetActive(go, true)
			GameUtil.SetActive(con, true)
		end
	end
end

function TongLinShiJiExtStageView:_clearFmt(fmt)
	for posId = 1, 9 do
		local go = fmt.transform:GetChild(posId - 1)
		local con = goutil.findChild(go, "con")

		MaterialMgr.clearIcon(con)
	end
end

function TongLinShiJiExtStageView:_onClickBtnTip()
	local key = TongLinShiJiConfig.instance:getCommonValue(self._activityId, "ruleKeyExtrem")

	TipsFacade.instance:openRulesView(key)
end

function TongLinShiJiExtStageView:_getRaceId()
	return TongLinShiJiController.instance:getRaceId(self._activityId)
end

function TongLinShiJiExtStageView:_getSkinId()
	return TongLinShiJiController.instance:getSkinId(self._activityId)
end

return TongLinShiJiExtStageView
