-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadmainView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadmainView", package.seeall)

local ChuangjingroadmainView = class("ChuangjingroadmainView", ViewComponent)

function ChuangjingroadmainView:ctor()
	ChuangjingroadmainView.super.ctor(self)
end

function ChuangjingroadmainView:unbindEvents()
	ChuangjingroadmainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnTeam)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
end

function ChuangjingroadmainView:bindEvents()
	ChuangjingroadmainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnTeam, self._onClickTeam, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnRes1, self._onClickResBoss, self)
	GameUtil.addClickHandler(self._btnRes2, self._onClickResBoss, self)
end

function ChuangjingroadmainView:buildUI()
	ChuangjingroadmainView.super.buildUI(self)

	self._btnTip = self:getGo("topleft/btnTip")
	self._btnClose = self:getGo("topleft/btnClose")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnRank = self:getGo("btnRank")
	self._btnPrize = self:getGo("btnPrize")
	self._btnTeam = self:getGo("btnTeam")
	self._btnHelp = self:getGo("topTips/btnHelp")
	self._cell = self:getGo("cell")
	self._challengeList = self:getGo("challengeList")
	self._bubble = self:getGo("bubble")
	self._con = self:getGo("bubble/con")
	self._txtDesc = self:getTxt("bubble/txtDesc")
	self._btnRes1 = self:getGo("resCell/btn")
	self._btnRes2 = self:getGo("resCell/btn_last")
	self._goldBarCon = self:getGo("goldBarCon")

	GameUtil.SetActive(self._cell, false)
end

function ChuangjingroadmainView:onExit()
	ChuangjingroadmainView.super.onExit(self)
end

function ChuangjingroadmainView:onEnter()
	ChuangjingroadmainView.super.onEnter(self)

	self._activityId = 396001

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetInfo(self._activityId)
	self:_onRefershUI()

	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId)

	if cfg and not string.nilorempty(cfg.mainCost) then
		local list = string.split(cfg.mainCost, "#")
		local objList = {}

		for i, v in ipairs(list) do
			local tem = {
				showAdd = true,
				id = v
			}

			table.insert(objList, tem)
		end

		MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	end
end

function ChuangjingroadmainView:_onRefershUI()
	local info = ChuangJingRoadModel.instance:getInfo(self._activityId) or {}

	if not info.zones then
		local zones = {}
		local isBossUp = false
		local isAllFinish = true
		local hasOneFinish = false

		self._zoneMap = {}

		for i, v in ipairs(zones) do
			self._zoneMap[v.zoneId] = v

			if checkbool(v.isFinishBoss) == false then
				isAllFinish = false
			else
				hasOneFinish = true
			end
		end

		isBossUp = isAllFinish == false and hasOneFinish

		local list = ChuangJingRoadConfig.instance:getZoneListById(self._activityId) or {}

		self._cellMap = {}

		goutil.clearChildren(self._challengeList)

		for i, v in ipairs(list) do
			local cell = goutil.cloneAndSetParent(self._cell, self._challengeList.transform, "cell_" .. i)

			GameUtil.SetActive(cell, true)

			if not self._zoneMap[v.zoneId] then
				self:_updateCellByCfg(cell, v, self._zoneMap[v.zoneId], isBossUp)

				self._cellMap[v.zoneId] = cell
			end
		end

		self._txtTime.text = GameUtil.getActTimeDesc(ActivityDefineController.instance:getActTypeByActId(self._activityId), self._activityId)
	end
end

function ChuangjingroadmainView:_updateCellByCfg(cell, cfg, data, isBossUp)
	local btn = goutil.findChild(cell, "btn")
	local txtShow = goutil.findChildTextComponent(cell, "btn/txt")
	local btnLast = goutil.findChild(cell, "btn_last")
	local txtShowLast = goutil.findChildTextComponent(cell, "btn_last/txt")
	local time = goutil.findChild(cell, "time")
	local txtTime = goutil.findChildTextComponent(cell, "time/txt")
	local mark = goutil.findChild(cell, "mark")
	local bossup = goutil.findChild(cell, "bossup")
	local icon = goutil.findChild(cell, "head/icon")
	local redPoint = goutil.findChild(cell, "redPoint")

	MaterialMgr.setIcon(icon, MatType.Pet, cfg.faceId)

	if not cfg.hudPos then
		local goPos = {}
		local var_8_1

		if goPos then
			var_8_1 = goPos[1] or 0

			local var_8_2

			if goPos then
				var_8_2 = goPos[2] or 0
			end
		end

		GameUtil.setAnchoredPos(cell, var_8_1, var_8_2)

		txtShow.text = cfg.desc
		txtShowLast.text = cfg.desc
		txtTime.text = "首通玩家未产生"

		if data.first and not string.nilorempty(data.first.userName) then
			txtTime.text = "首通:" .. data.first.userName
		end

		GameUtil.SetActive(mark, checkbool(data.isFinishBoss))
		GameUtil.SetActive(bossup, checkbool(data.isFinishBoss) == false and isBossUp)

		local isLastCfg = false

		GameUtil.SetActive(btn, not isLastCfg)
		GameUtil.SetActive(btnLast, isLastCfg)
		GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickHud, self, cfg))

		local stageId = checknumber(data.stageId)

		if not data.gainProgressPrizeId then
			local gainProgressPrizeId = {}
			local bossStage = checkbool(data.isFinishBoss) and 1 or 0
			local stageProgress = stageId + bossStage
			local prizeList = ChuangJingRoadConfig.instance:getChallengePorgressById(self._activityId, cfg.zoneId) or {}

			GameUtil.SetActive(redPoint, false)

			for i, v in ipairs(prizeList) do
				local isCanGet = stageProgress >= v.stageNum
				local isGainPrize = table.indexof(gainProgressPrizeId, v.prizeId) ~= false

				if isCanGet and not isGainPrize then
					GameUtil.SetActive(redPoint, true)

					break
				end
			end
		end
	end
end

function ChuangjingroadmainView:_onClickRule()
	TipsFacade.instance:openRulesView("ChuangjingroadmainView_rule")
end

function ChuangjingroadmainView:_onClickHud(cfg)
	UIStateManager.instance:push(ViewName.ChuangjingroadlistView, self._activityId, cfg.zoneId)
end

function ChuangjingroadmainView:_onClickResBoss()
	UIStateManager.instance:push(ViewName.ChuangjingroadresbossView, self._activityId)
end

function ChuangjingroadmainView:_onClickHelp()
	UIStateManager.instance:push(ViewName.ChuangjingroaddebuffView, self._activityId)
end

function ChuangjingroadmainView:_onClickTeam()
	UIStateManager.instance:push(ViewName.ChuangjingroadpetView, self._activityId)
end

function ChuangjingroadmainView:_onClickRank()
	UIStateManager.instance:push(ViewName.ChuangjingroadrankView, self._activityId)
end

function ChuangjingroadmainView:_onClickPrize()
	local cfg = ChuangJingRoadConfig.instance:getActivityCfgById(self._activityId) or {}

	GotoMgr.gotoByString(cfg.jumpTo)
end

return ChuangjingroadmainView
