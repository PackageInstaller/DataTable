-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/seniorarena/view/SeniorArenaMainView.lua

module("logic.extensions.seniorarena.view.SeniorArenaMainView", package.seeall)

local SeniorArenaMainView = class("SeniorArenaMainView", ViewComponent)

function SeniorArenaMainView:unbindEvents()
	SeniorArenaMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnReport:RemoveClickListener()
	self._btnExchange:RemoveClickListener()
	self._btnReward:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function SeniorArenaMainView:bindEvents()
	SeniorArenaMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnReport:AddClickListener(self._onClickReport, self)
	self._btnExchange:AddClickListener(self._onClickExchange, self)
	self._btnReward:AddClickListener(self._onClickReward, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
end

function SeniorArenaMainView:buildUI()
	SeniorArenaMainView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._btnRule = self:getBtn("topleft/btnRule")
	self._left = self:getGo("left")
	self._txtRanking = goutil.findChildTextComponent(self._left, "rank/txtRanking")
	self._txtRank = goutil.findChildTextComponent(self._left, "rank/txtRank")
	self._txtSeason = goutil.findChildTextComponent(self._left, "rank/txtSeason")
	self._txtZone = goutil.findChildTextComponent(self._left, "rank/txtZone")
	self._txtUserName = goutil.findChildTextComponent(self._left, "txtUserName")
	self._txtForce = goutil.findChildTextComponent(self._left, "force/txtForce")
	self._pointHead = goutil.findChild(self._left, "pointHead")
	self._imgBox = goutil.findChild(self._left, "reward/imgBox")
	self._imgCoinPer = goutil.findChild(self._left, "reward/per/imgCoin")
	self._txtCoinPer = goutil.findChildTextComponent(self._left, "reward/per/Text")
	self._txtPerTitle = goutil.findChildTextComponent(self._left, "reward/per")
	self._txtPerTitle.text = lang("arena_3v3_collect_speed_title_tip")
	self._txtTotalTitle = goutil.findChildTextComponent(self._left, "reward/total")
	self._txtTotalTitle.text = lang("arena_3v3_collect_total_title_tip")
	self._imgCoinTotal = goutil.findChild(self._left, "reward/total/imgCoin")
	self._txtCoinTotal = goutil.findChildTextComponent(self._left, "reward/total/Text")
	self._defendForms = goutil.findChild(self._left, "formations")
	self._right = self:getGo("right")
	self._goLeftTime = goutil.findChild(self._right, "listRefreshTime")
	self._txtLeftTime = goutil.findChildTextComponent(self._goLeftTime, "Text")
	self._opponents = goutil.findChild(self._right, "opponents")
	self._btnReport = self:getBtn("btnReport")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnReward = self:getBtn("btnReward")
	self._btnRank = self:getBtn("left/btnRank")
	self._btnGet = self:getBtn("left/reward/btnGet")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._goldBarCon = self:getGo("goldBarCon")
	self._rewardRedPoint = goutil.findChild(self._btnReward.gameObject, "imgPoint")
	self._seasonTime = self:getGo("seasonTime")
	self._txtTime = self:getTxt("seasonTime/txtTime")
	self._redpointGo = self:getGo("left/reward/btnGet/redpoint")
end

function SeniorArenaMainView:onExit()
	SeniorArenaMainView.super.onExit(self)
	removetimer(self._onTickRefreshTime, self)
	removetimer(self._onTickHangUpPrize, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._updateRedPoints, self)

	for _, v in ipairs(self._formItems) do
		v:clear()
	end

	self._formItems = nil

	for _, v in ipairs(self._points) do
		MaterialMgr.resetAll(v)
	end

	self._points = nil

	MaterialMgr.resetAll(self._pointHead)
	SeniorArenaController.instance:clearHandler()
	RedPointController.instance:unregRedPoint(self._redpointGo)
end

function SeniorArenaMainView:onEnter()
	SeniorArenaMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SeniorArenaInfoFresh, self._updateUI, self)

	self._formItems = {}
	self._points = {}

	goutil.setActive(self._imgBox, false)

	self._hangUpLimit = SeniorArenaConfig.instance:getCommonValue("HANG_UP_UPPER_LIMIT", true)
	self._handUpTime = SeniorArenaConfig.instance:getCommonValue("HANG_UP_TIME", true)

	SeniorArenaController.instance:reqArenaInfo(self._onArena3v3InfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedPoints, self)
	self:_updateRedPoints()
	self:_updateGoldBar()
	self:_updateSeasonTime()
	RedPointController.instance:regRedPoint(self._redpointGo, 734)
end

function SeniorArenaMainView:_updateRedPoints()
	goutil.setActive(self._rewardRedPoint, RedPointModel.instance:isActive(73))
end

function SeniorArenaMainView:_onArena3v3InfoRes(msg)
	self:_updateUI()
	SeniorArenaController.instance:checkMyDefendForms(self._updateMyDefendForms, self)
end

function SeniorArenaMainView:_updateMyDefendForms()
	print("_updateMyDefendForms")
	GameUtil.updateCellsWithLen(self._defendForms, 3, self._updateOneMyDefendForm, self)

	self._txtForce.text = RoleModel.instance:getMaxPower()
end

function SeniorArenaMainView:_updateOneMyDefendForm(cell, idx)
	if not self._formItems then
		return
	end

	local data = SeniorArenaModel.instance:getMyDefendFormMoByIdx(idx)
	local item = OneFormItem.New(cell)

	item:updateWithPlayerFormMo(data, idx)
	item:setBtnClickHandler(function()
		self:_onClickDefendForm(idx)
	end)
	item:setRedPointActive(data == nil or data:getPetNum() < 5)
	table.insert(self._formItems, item)
end

function SeniorArenaMainView:_updateUI()
	goutil.setActive(self._imgBox, true)

	local info = SeniorArenaModel.instance:getArenaInfo()

	self._info = info

	if info then
		local zoneCfg = SeniorArenaConfig.instance:getZoneCfgById(info.zoneId)

		if zoneCfg then
			self._txtZone.text = zoneCfg.zoneName
		end

		self._txtSeason.text = string.format("第%s届", info.seasonId)
	end

	self:_checkTickets()
	self:_updateMyRank()
	self:_updateOpponents()

	self._txtUserName.text = RoleModel.instance:getUserName()

	HeadItemController.instance:setMyHeadCell(self._pointHead)
	self:_updateHangUp()
	self:_updateRefreshTime()
	self:_updateSeasonTime()
end

function SeniorArenaMainView:_updateMyRank()
	local myRank = SeniorArenaModel.instance:getMyRank()
	local rankCfg = SeniorArenaConfig.instance:getRankCfgByRank(myRank)

	self._txtRanking.text = myRank
	self._txtRank.text = rankCfg.rankName

	local addPerHour = SeniorArenaModel.instance:getAddPerSec() * 3600

	self._txtCoinPer.text = string.format("%s/小时", addPerHour)
end

function SeniorArenaMainView:_updateRefreshTime()
	self:_onTickRefreshTime()
	removetimer(self._onTickRefreshTime, self)
	settimer(0.2, self._onTickRefreshTime, self, true)
end

function SeniorArenaMainView:_onTickRefreshTime()
	local nextRefreshTime = SeniorArenaModel.instance:getNextRefreshTime()
	local leftTime = math.ceil(nextRefreshTime - ServerTime.now())

	goutil.setActive(self._goLeftTime, leftTime > 0)

	if leftTime > 0 then
		local min = math.floor(leftTime / 60)
		local sec = leftTime - min * 60

		self._txtLeftTime.text = min > 0 and string.format("列表自动刷新剩余时间：<color=#EEEFAEFF>%d分%02d秒</color>", min, sec) or string.format("列表自动刷新剩余时间：<color=#EEEFAEFF>%d秒</color>", sec)
	else
		removetimer(self._onTickRefreshTime, self)
		self:_onClickRefresh(true)
	end
end

function SeniorArenaMainView:_checkTickets()
	local changeSetId = SeniorArenaModel.instance:getChangeSetId()

	if checknumber(changeSetId) > 0 then
		local maxNum = SeniorArenaConfig.instance:getCommonValue("CHALLENGE_USE_LIMIT", true)
		local matId = SeniorArenaConfig.instance:getCommonValue("CHALLENGE_USE", true)
		local items = MaterialController.instance:saveChangeSetToTemp(changeSetId)

		if items then
			local data = items[1]
			local matStr = string.format("%s:%s:%s", data.type, data.id, data.num)

			print("matStr = " .. matStr)

			local content = langPara("arena_3v3_give_tickets_tip", data.num, maxNum)

			UIStateManager.instance:open(ViewName.PopupItemView, content, data.type, data.id, data.num, function()
				MaterialController.instance:showChangeSetInTemp(changeSetId)
			end)
		end
	end
end

function SeniorArenaMainView:_updateGoldBar()
	local btn_list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.SeniorArenaTicket
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.SeniorArenaCoin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function SeniorArenaMainView:_updateOpponents()
	local datas = SeniorArenaModel.instance:getAllTargets()

	GameUtil.updateCells(self._opponents, datas, self._updateOneOpponent, self, true)
end

function SeniorArenaMainView:_updateOneOpponent(cell, data)
	local go = goutil.findChild(cell, "bg")
	local pointHead = goutil.findChild(go, "pointHead")
	local txtTotalForce = goutil.findChildTextComponent(go, "totalForce/txtTotalForce")
	local txtRanking = goutil.findChildTextComponent(go, "txtRanking")
	local txtUserName = goutil.findChildTextComponent(go, "txtUserName")
	local formations = goutil.findChild(go, "formations")
	local txtAddPer = goutil.findChildTextComponent(go, "txtAddPer")
	local btn = Framework.ButtonAdapter.Get(go)

	txtUserName.text = data.headInfo.userName
	txtRanking.text = data.rank .. "名"

	local totalForce = 0

	for _, v in ipairs(data.forms) do
		totalForce = totalForce + math.max(0, v.zdl)
	end

	txtTotalForce.text = math.max(0, totalForce)

	btn:AddClickListener(function()
		self:_onClickOpponent(data)
	end)
	HeadItemController.instance:setHeadCellByInfo(pointHead, data.headInfo)
	table.sort(data.forms, function(a, b)
		return a.formId < b.formId
	end)
	GameUtil.updateCells(formations, data.forms, self._updateOneOpponentForm, self)
	table.insert(self._points, pointHead)
end

function SeniorArenaMainView:_updateOneOpponentForm(cell, data)
	local item = OneFormItem.New(cell)

	item:updateWithOpponentMo(data)
	table.insert(self._formItems, item)
end

function SeniorArenaMainView:_onClickOpponent(data)
	local challengeArr = string.split(GameEnum.GoldType.SeniorArenaTicket, ":")
	local hasChallengeTicketNum = MaterialModel.instance:getMaterialsNumber(challengeArr[1], challengeArr[2])
	local matName = MaterialMgr.getMaterialsName(challengeArr[1], challengeArr[2])

	if checknumber(hasChallengeTicketNum) <= 0 then
		FloatWordMgr.instance:show(string.format("%s不足，请收集至少一张后再进入挑战", matName))
		SeniorArenaController.instance:popBuyTicketWindow()
	else
		local isRobot = checknumber(data.headInfo.userId) <= 0

		if isRobot then
			local tipsContent = langPara("您所挑战的玩家为守卫，确认挑战后扣除1张%s，且立即获胜并刷新排名", matName)

			local function okFunc()
				SeniorArenaController.instance:setCurOpponentId(data.headInfo.userId)
				SeniorArenaController.instance:reqChallenge(nil, nil, true)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")

			return
		end

		SeniorArenaController.instance:setCurOpponentId(data.headInfo.userId)
		SeniorArenaController.instance:openOtherDefendFormsView(data.headInfo.userId)
	end
end

function SeniorArenaMainView:_onClickDefendForm(idx)
	print("click defend form idx = " .. idx)
	SeniorArenaController.instance:setCurFormTab(idx)
	SeniorArenaController.instance:initCacheForms(false)

	local fmtMo = SeniorDefendFmtMo.New()

	CustomFmtController.instance:showMissionFormationView(fmtMo)
end

function SeniorArenaMainView:_onClickOppentForm(data)
	print("click opponent form")
end

function SeniorArenaMainView:_updateHangUp()
	self:_onTickHangUpPrize()
	removetimer(self._onTickHangUpPrize, self)
	settimer(1, self._onTickHangUpPrize, self, true)
end

function SeniorArenaMainView:_onTickHangUpPrize()
	local totalNum = SeniorArenaController.instance:getShowTotalNum()
	local boxState = 1

	boxState = totalNum == self._hangUpLimit and 3 or totalNum == 0 and 1 or 2

	uGuiUtil.setSpriteToImage(self._imgBox, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_gjjjc_0" .. boxState))

	if boxState == 3 then
		self._txtCoinTotal.text = string.format("<color=#11A568FF>%s</color>", totalNum)
	end

	uGuiUtil.setImageGrayState(self._btnGet.gameObject, totalNum == 0)
end

function SeniorArenaMainView:_onClickGet()
	local num = SeniorArenaController.instance:getShowTotalNum()
	local leftTime = SeniorArenaModel.instance:getNextReceiveTime() - ServerTime.now()

	if num == 0 then
		FloatWordMgr.instance:show("当前没有奖励可领取，请稍候~")
	elseif leftTime > 0 then
		FloatWordMgr.instance:show(string.format("领取奖励太频繁了，请%s后再来~", TimeUtil.getTimeFormat(leftTime)))
	else
		SeniorArenaController.instance:reqGainHangUpPrize(self._onGainHangUpPrizeSuccess, self)
	end
end

function SeniorArenaMainView:_onGainHangUpPrizeSuccess()
	self:_updateHangUp()
end

function SeniorArenaMainView:_onClickRefresh(isForce)
	print("click btnRefresh")

	if not isForce then
		local leftTime = math.ceil(SeniorArenaModel.instance:getNextManualRefreshTime() - ServerTime.now())

		if leftTime > 0 then
			FloatWordMgr.instance:show(string.format("刷新对手太频繁了，请%s后再来~", TimeUtil.getTimeFormat(leftTime)))

			return
		end
	end

	SeniorArenaController.instance:reqRefreshOpponents(self._onRefreshSuccess, self)
end

function SeniorArenaMainView:_onRefreshSuccess()
	FloatWordMgr.instance:show("挑战对手已经刷新")
	self:_updateMyRank()
	self:_updateHangUp()
	self:_updateOpponents()
	self:_updateRefreshTime()
	ViewMgr.instance:close(ViewName.SeniorFormsView)
end

function SeniorArenaMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "seniorarena")
end

function SeniorArenaMainView:_onClickReport()
	UIStateManager.instance:push(ViewName.SeniorReportView)
end

function SeniorArenaMainView:_onClickExchange()
	GotoMgr.gotoByString("func#470#Exchange3v3")
end

function SeniorArenaMainView:_onClickReward()
	UIStateManager.instance:open(ViewName.SeniorRewardView)
end

function SeniorArenaMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.ArenaCombine, 2)
end

function SeniorArenaMainView:_updateSeasonTime()
	local cfg = SeniorArenaConfig.instance:getSeasonCfg(SeniorArenaModel.instance:getSeasonId())
	local isShow = cfg

	if isShow then
		if not cfg.desc then
			local str = ""

			goutil.setActive(self._seasonTime, isShow)

			self._txtTime.text = str
		end
	end
end

return SeniorArenaMainView
