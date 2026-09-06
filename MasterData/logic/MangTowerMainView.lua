-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTowerMainView.lua

module("logic.extensions.mangtower.view.MangTowerMainView", package.seeall)

local MangTowerMainView = class("MangTowerMainView", ViewComponent)
local SELECT_SCALE = {
	1,
	0.9,
	0.8,
	0.7,
	0.6
}
local ANIMATION_DATA_KEY = "firstopen_draw_longyan_ht"

function MangTowerMainView:ctor()
	MangTowerMainView.super.ctor(self)
end

function MangTowerMainView:buildUI()
	MangTowerMainView.super.buildUI(self)

	self._bgNormal = self:getGo("bgNormal")
	self._bgEx = self:getGo("bgEX")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnRank = self:getBtn("btnRank")
	self._btnTip = self:getBtn("btnTip")
	self._btnExchange = self:getBtn("btnShop")
	self._btnClose = self:getBtn("btnClose")
	self._btnHangUp = self:getBtn("btnHangUp")
	self._towerGroup = goutil.findChildComponent(self.mainGO, "tower", "UIChangeGroup")
	self._btnNormal = self:getBtn("challenge/btnNormal")
	self._btnEX = self:getBtn("challenge/btnEX")
	self._normalChange = self:getGo("challenge/btnNormal"):GetComponent("UIImageSpriteChange")
	self._exChange = self:getGo("challenge/btnEX"):GetComponent("UIImageSpriteChange")
	self._tableGo = self:getGo("challenge/tableview")
	self._itemGo = self:getGo("challenge/item")
	self._tableviewPrize = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._txtScoreLevel = self:getTxt("challenge/score/txtScore")
	self._goCost = self:getGo("cost")
	self._txtQuan = self:getTxt("cost/txtCost")
	self._goQuan = self:getGo("cost/txtCost/icon")
	self._txtScore = self:getTxt("info/txtScore")
	self._txtLevel = self:getTxt("info/txtLevel")
	self._hangUpRed = self:getGo("btnHangUp/red")
	self._cellEffGo = {}
	self._towerGo = {}

	for i = 1, 5 do
		table.insert(self._cellEffGo, self:getGo("tower/tower_" .. i .. "/effect"))

		local obj = {}

		obj.go = self:getGo("tower/tower_" .. i)
		obj.canvasGroup = self:getGo("tower/tower_" .. i):GetComponent("CanvasGroup")

		table.insert(self._towerGo, obj)
	end

	self._effectList = {}
	self._lineGO = {}

	for i = 1, 4 do
		local obj = {}

		obj.go = self:getGo("tower/line_" .. i)
		obj.canvasGroup = self:getGo("tower/line_" .. i):GetComponent("CanvasGroup")

		table.insert(self._lineGO, obj)
	end

	self._goldBarCon = self:getGo("goldBarCon")
	self._rankReward = self:getGo("rankReward/reward")
	self._challengeEffGo = self:getGo("challenge/effect")
	self._anniuEffGo = self:getGo("anniueffect")
	self._mainEffGo = self:getGo("effect")
	self._switchEffGo = self:getGo("switchEffGo")
	self._newUnitEffGo = self:getGo("newUnitEff")
	self._switchRedPoint = self:getGo("challenge/btnEX/red")
	self._txtTime = self:getTxt("time/txtTime")
	self._strItem = {}
end

function MangTowerMainView:bindEvents()
	MangTowerMainView.super.bindEvents(self)
	self._btnChallenge:AddClickListener(self._challenge, self)
	self._btnRank:AddClickListener(self._rank, self)
	self._btnTip:AddClickListener(self._clickTip, self)
	self._btnHangUp:AddClickListener(self._clickHangUp, self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnNormal:AddClickListener(function()
		self:_onClickSwitch(MangTowerModel.TOWER_TYPE_1V1)
	end, self)
	self._btnEX:AddClickListener(function()
		self:_onClickSwitch(MangTowerModel.TOWER_TYPE_3V3)
	end, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
end

function MangTowerMainView:unbindEvents()
	MangTowerMainView.super.unbindEvents(self)
	self._btnChallenge:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnHangUp:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnEX:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
end

function MangTowerMainView:destroyUI()
	MangTowerMainView.super.destroyUI(self)
end

function MangTowerMainView:onEnter()
	MangTowerMainView.super.onEnter(self)

	if MangTowerController.instance:refreshActId() == nil then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))
	end

	local isFirstOpen = checknumber(GameUtil.getUserData(ANIMATION_DATA_KEY))

	if isFirstOpen == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.PushStory, 5030001)
		GameUtil.saveUserData(ANIMATION_DATA_KEY, 1)
	end

	local matTicket = MangTowerConfig.instance:getCommonCfg("MAT_TICKET")

	self._strItem = string.splitToNumber(matTicket, ":")

	local list = {
		{
			showAdd = true,
			id = self._strItem[1] .. ":" .. self._strItem[2]
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, list)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)

	if MangTowerModel.instance:getHasGetInfo() then
		self:_enterRefresh()
	else
		GlobalDispatcher:addListener(GlobalNotify.MangTowerGetInfo, self._enterRefresh, self)
		MangTowerController.instance:sendGetInfo()
	end

	self:_updateTime()
	settimer(1, self._updateTime, self)
end

function MangTowerMainView:_updateTime()
	local activityId = MangTowerModel.instance:getActId()

	if checknumber(activityId) ~= 0 then
		local time = GameUtil.string2time(ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.MangTower, activityId).endTime)
		local diff = time - ServerTime.now()
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(diff)

		self._txtTime.text = diff > 0 and langPara("活动剩余时间：%d天%d小时%d分%d秒", day, hour, min, sec) or langPara("活动已结束")
	else
		self._txtTime.text = langPara("活动已结束")
	end
end

function MangTowerMainView:onEnterFinished()
	MangTowerMainView.super.onEnterFinished(self)
end

function MangTowerMainView:onExit()
	MangTowerMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.MangTowerGetInfo, self._enterRefresh, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	removetimer(self._updateTime, self)

	for i = 1, 5 do
		if self._effectList[i] then
			UIEffectManager.instance:stopEffect(self._effectList[i])

			self._effectList[i] = nil
		end
	end

	self._tableviewPrize:dispose()
	MaterialMgr.resetAll(self._goQuan)
	MaterialMgr.resetAll(self._rankReward)

	if self._challEffect then
		UIEffectManager.instance:stopEffect(self._challEffect)

		self._challEffect = nil
	end

	if self._anniuEffect then
		UIEffectManager.instance:stopEffect(self._anniuEffect)

		self._anniuEffect = nil
	end

	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end

	if self._switchEffect then
		UIEffectManager.instance:stopEffect(self._switchEffect)

		self._switchEffect = nil
	end

	if self._newUnitEffect then
		UIEffectManager.instance:stopEffect(self._newUnitEffect)

		self._newUnitEffect = nil
	end

	if self.appearEff then
		self.appearEff:Kill(false)

		self.appearEff = nil
	end
end

function MangTowerMainView:onExitFinished()
	MangTowerMainView.super.onExitFinished(self)
end

function MangTowerMainView:_enterRefresh()
	self:_refresh()

	local newUnit = MangTowerModel.instance:getNeedToShowNewUnit()

	if newUnit and self._cfg then
		self:showNewUnitEffect()
	end
end

function MangTowerMainView:_refresh()
	self._planId = 1
	self._type = MangTowerModel.instance:getSelectType()
	self._monsterCfgs = MangTowerConfig.instance:getMonsterCfg(self._planId, self._type)
	self._phase = 0
	self._phase = self._type == MangTowerModel.TOWER_TYPE_1V1 and MangTowerModel.instance:getNormalPhase() or MangTowerModel.instance:getExcitedPhase()
	self._cfg = self._monsterCfgs[self._phase + 1]

	goutil.setActive(self._bgNormal, self._type == MangTowerModel.TOWER_TYPE_1V1)
	goutil.setActive(self._bgEx, self._type == MangTowerModel.TOWER_TYPE_3V3)

	if self._cfg then
		self._txtScoreLevel.text = checknumber(self._cfg.score)

		local quanStr = self._cfg.ticket
		local quanArr = string.splitToNumber(quanStr, ":")

		self._txtQuan.text = langPara("x%s", quanArr[3])

		if #quanArr > 0 then
			goutil.setActive(self._goCost, true)
		else
			goutil.setActive(self._goCost, false)
		end

		local prizeList = string.split(self._cfg.prize, "#")

		self._tableviewPrize:reloadData(prizeList)

		self._txtLevel.text = langPara("第%s层", self._phase + 1)
	else
		self._txtScoreLevel.text = checknumber(0)
		self._txtLevel.text = langPara("已通关")

		goutil.setActive(self._goCost, false)
	end

	local showPhase = self._cfg and self._phase % 5 + 1 or 1000

	if self._strItem then
		MaterialMgr.setIcon(self._goQuan, self._strItem[1], self._strItem[2])
	end

	self._txtScore.text = langPara("已累计积分：%s", MangTowerModel.instance:getScore())

	self._towerGroup:SetState(self._type == MangTowerModel.TOWER_TYPE_1V1 and 0 or 1)
	self._normalChange:SetState(self._type == MangTowerModel.TOWER_TYPE_1V1 and 1 or 0)
	self._exChange:SetState(self._type == MangTowerModel.TOWER_TYPE_3V3 and 1 or 0)

	local matCfg2 = MangTowerConfig.instance:getCommonCfg("PET_RANK_PRIZE")
	local matArr2 = string.splitToNumber(matCfg2, ":")

	MaterialMgr.setCell(matArr2[1], matArr2[2], self._rankReward)

	for i = 1, 5 do
		goutil.setActive(self._towerGo[i].go, showPhase <= i)

		if self._lineGO[i] then
			goutil.setActive(self._lineGO[i].go, showPhase <= i)
		end
	end

	self:_refreshRedPoint()
	self:showAllEff()
end

function MangTowerMainView:_onClickSwitch(type)
	if type ~= self._type then
		self._type = type

		MangTowerModel.instance:setSelectType(type)

		if type == MangTowerModel.TOWER_TYPE_3V3 then
			MangTowerController.instance:setSwitchRedPoint(false)
		end

		self:_refresh()
		self:showSwitchEff()
	end
end

function MangTowerMainView:_challenge()
	if self._cfg then
		local type = checknumber(self._cfg.type)

		if type > 0 then
			local unlockLevel = checknumber(self._cfg.unlock)

			if unlockLevel > 0 then
				local normalPhase = MangTowerModel.instance:getNormalPhase()

				if normalPhase < unlockLevel then
					local cfg = MangTowerConfig.instance:getMonsterCfg(self._planId, MangTowerModel.TOWER_TYPE_1V1)

					FloatWordMgr.instance:show(langPara("请先通关%s", cfg[unlockLevel].name))

					return
				end
			end

			MangTowerController.instance:sendGetFormations(type, function()
				MangTowerController.instance:openMissionView(self._cfg)
			end)
		end
	else
		FloatWordMgr.instance:show("已通关!")
	end
end

function MangTowerMainView:_rank()
	UIStateManager.instance:push(ViewName.MangTowerRankView)
end

function MangTowerMainView:_clickTip()
	UIStateManager.instance:push(ViewName.RulesView, "mangpatatiaozhan")
end

function MangTowerMainView:_clickHangUp()
	if not MangTowerModel.instance:getHasGainDailyBonus() then
		local actId = MangTowerModel.instance:getActId()

		PursueDreamAgent.instance:sendPM_PursueDreamGainDailyBonusReq(actId, function(msg)
			MaterialFacade.instance:popAndShowChangeSetItems(msg.changeSetId)
			MangTowerModel.instance:setHasGainDailyBonus(true)
			self:_refreshRedPoint()
		end)
	else
		FloatWordMgr.instance:show("今日没有可领取的奖励了哦~")
	end
end

function MangTowerMainView:_refreshRedPoint()
	goutil.setActive(self._hangUpRed, not MangTowerModel.instance:getHasGainDailyBonus())
	goutil.setActive(self._switchRedPoint, RedPointModel.instance:isActive(RedPointModel.ID_MANG_TOWER_SWITCH))
end

function MangTowerMainView:_onClickExchange()
	UIStateManager.instance:push(ViewName.TLCExchangeView, 9)
end

function MangTowerMainView:showAllEff()
	local newUnit = MangTowerModel.instance:getNeedToShowNewUnit()

	if not newUnit then
		self:showSelectEff()
	end

	if self._mainEffect then
		UIEffectManager.instance:stopEffect(self._mainEffect)

		self._mainEffect = nil
	end

	local effectPath

	self._mainEffect = UIEffectManager.instance:playEffect(self, self._type == MangTowerModel.TOWER_TYPE_1V1 and "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_01.prefab" or "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_01_blue.prefab", self._mainEffGo.transform, 0, 0, true, false, nil, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._mainEffect:setParent(self._mainEffGo.transform)
	self._mainEffect:setLocalPos(0, 0, 0)
	self._mainEffect:setScale(1)

	if self._challEffect then
		UIEffectManager.instance:stopEffect(self._challEffect)

		self._challEffect = nil
	end

	local effectPath

	self._challEffect = UIEffectManager.instance:playEffect(self, self._type == MangTowerModel.TOWER_TYPE_1V1 and "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_03_red.prefab" or "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_03_blue.prefab", self._challengeEffGo.transform, 0, 0, true, false, nil, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._challEffect:setParent(self._challengeEffGo.transform)
	self._challEffect:setLocalPos(0, 0, 0)
	self._challEffect:setScale(1)

	if self._anniuEffect then
		UIEffectManager.instance:stopEffect(self._anniuEffect)

		self._anniuEffect = nil
	end

	self._anniuEffect = UIEffectManager.instance:playEffect(self, "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_anniu.prefab", self._anniuEffGo.transform, 0, 0, true, false, nil, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._anniuEffect:setParent(self._anniuEffGo.transform)
	self._anniuEffect:setLocalPos(0, 0, 0)
	self._anniuEffect:setScale(1)
end

function MangTowerMainView:showSwitchEff()
	if self._switchEffect then
		UIEffectManager.instance:stopEffect(self._switchEffect)

		self._switchEffect = nil
	end

	local effectPath

	self._switchEffect = UIEffectManager.instance:playEffect(self, self._type == MangTowerModel.TOWER_TYPE_1V1 and "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_05_blue.prefab" or "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_05_red.prefab", self._switchEffGo.transform, 0, 0, false, false, nil, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._switchEffect:setParent(self._switchEffGo.transform)
	self._switchEffect:setLocalPos(0, 0, 0)
	self._switchEffect:setScale(1)
end

function MangTowerMainView:_updatePrizeCell(view, cell, data)
	local item = goutil.findChild(cell, "itemcell")

	MaterialMgr.setCellByCfg(data, item)
end

function MangTowerMainView:_clearPrizeCell(cell)
	local item = goutil.findChild(cell, "itemcell")

	MaterialMgr.resetAll(item)
end

function MangTowerMainView:showNewUnitEffect()
	if self._newUnitEffect then
		UIEffectManager.instance:stopEffect(self._newUnitEffect)

		self._newUnitEffect = nil
	end

	ViewBlockMgr.instance:blockClick(true, self)

	for i = 1, 5 do
		if self._lineGO[i] then
			self._lineGO[i].canvasGroup.alpha = 0
		end

		self._towerGo[i].canvasGroup.alpha = 0
	end

	self._newUnitEffect = UIEffectManager.instance:playEffect(self, "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_zhuanchang.prefab", self._newUnitEffGo.transform, 0, 0, false, false, function()
		self:flashBackEffect(1, 1)
	end, function(self, uiEffect)
		uiEffect.hideEffWhileNotOnTop = true
	end, self)

	self._newUnitEffect:setParent(self._newUnitEffGo.transform)
	self._newUnitEffect:setLocalPos(0, 0, 0)
	self._newUnitEffect:setScale(1)
end

function MangTowerMainView:flashBackEffect(index, type)
	if self.appearEff then
		self.appearEff:Kill(false)

		self.appearEff = nil
	end

	if type == 1 then
		local obj = self._towerGo[index]

		if obj then
			self.appearEff = TweenUtil.ValueTo(0, 1, 0.1, function(val)
				obj.canvasGroup.alpha = val
			end, function()
				self:flashBackEffect(index, 2)
			end, self)
		end
	else
		local obj = self._lineGO[index]

		if obj then
			self.appearEff = TweenUtil.ValueTo(0, 1, 0.1, function(val)
				obj.canvasGroup.alpha = val
			end, function()
				self:flashBackEffect(index + 1, 1)
			end, self)
		else
			ViewBlockMgr.instance:blockClick(false, self)
			self:showSelectEff()
			MangTowerModel.instance:setNeedToShowNewUnit(false)
		end
	end
end

function MangTowerMainView:showSelectEff()
	for i = 1, 5 do
		if i == self._phase % 5 + 1 then
			if self._effectList[i] == nil then
				self._effectList[i] = UIEffectManager.instance:playEffect(self, "fx_ui_mangtiaozhan/fx_ui_mangtiaozhan_02.prefab", self._cellEffGo[i].transform, 0, 0, true, false, nil, function(self, uiEffect)
					uiEffect.hideEffWhileNotOnTop = true

					GoUtil.SetSortingOrder(uiEffect.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self._cellEffGo[i]) + 1)
				end, self)

				self._effectList[i]:setParent(self._cellEffGo[i].transform)
				self._effectList[i]:setLocalPos(0, 0, 0)
				self._effectList[i]:setScale(SELECT_SCALE[i])
			end
		elseif self._effectList[i] then
			UIEffectManager.instance:stopEffect(self._effectList[i])

			self._effectList[i] = nil
		end
	end
end

function MangTowerMainView:dailyRefresh()
	if MangTowerController.instance:refreshActId() == nil then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("活动已结束"), GameUtil.handler(self.close, self))
	end

	if MangTowerModel.instance:getNormalPhase() > 0 then
		MangTowerModel.instance:setHasGainDailyBonus(false)
		self:_refresh()
	end
end

return MangTowerMainView
