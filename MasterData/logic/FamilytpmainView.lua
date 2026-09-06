-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/FamilytpmainView.lua

module("logic.extensions.familyteamplay.view.FamilytpmainView", package.seeall)

local FamilytpmainView = class("FamilytpmainView", ViewComponent)

function FamilytpmainView:ctor()
	FamilytpmainView.super.ctor(self)
end

function FamilytpmainView:buildUI()
	FamilytpmainView.super.buildUI(self)

	self._btnClose = self:getBtn("btns/btnClose")
	self._btnRule = self:getBtn("btns/btnRule")
	self._btnPractice = self:getBtn("btns/btnPractice")
	self._btnChallenge = self:getBtn("btns/btnChallenge")
	self._btnColorEgg = self:getBtn("btns/btnColorEgg")
	self._btnTips = self:getBtn("btns/btnTips")
	self._btnDamageRank = self:getBtn("leftRoot/btnDamageRank")
	self._btnOrder = self:getBtn("midRoot/btnOrder")
	self._btnRank = self:getBtn("rightRoot/btnRank")
	self._btnGroup = goutil.findChildComponent(self.mainGO, "leftRoot/btns", "UIChangeToggleGroup")
	self._familyRankBtn = self:getBtn("leftRoot/btns/familyRankBtn")
	self._fightRankBtn = self:getBtn("leftRoot/btns/fightRankBtn")
	self._familyRankImg = goutil.findChildComponent(self.mainGO, "leftRoot/btns/familyRankBtn", "UIImageSpriteChange")
	self._fightRankImg = goutil.findChildComponent(self.mainGO, "leftRoot/btns/fightRankBtn", "UIImageSpriteChange")
	self._txtRank = goutil.findChildTextComponent(self.mainGO, "rightRoot/txtRank")
	self._txtChallengeCountValue = goutil.findChildTextComponent(self.mainGO, "btns/btnChallenge/txtCountValue")
	self._txtMidRoleName = goutil.findChildTextComponent(self.mainGO, "midRoot/txtRoleName")
	self._tilteTxt = goutil.findChildTextComponent(self.mainGO, "leftRoot/title")
	self._ruleDesTxt = goutil.findChildTextComponent(self.mainGO, "rightRoot/ruleDesTxt")
	self._damageConGo = self:getGo("leftRoot/damageCon")
	self._damagecellGo = self:getGo("leftRoot/damageCon/cell")
	self._rewardCellGo = self:getGo("rightRoot/tablerewardcell")
	self._roleConGo = self:getGo("midRoot/roleCon")
	self._rareGo = self:getGo("midRoot/rare")
	self._tableBtnsGO = self:getGo("leftRoot/btns")
	self._btnSkill = self:getBtn("midRoot/btnSkill")
	self._minHardStar = {
		self:getGo("midRoot/starCon/star1"),
		self:getGo("midRoot/starCon/star2"),
		self:getGo("midRoot/starCon/star3"),
		self:getGo("midRoot/starCon/star4"),
		(self:getGo("midRoot/starCon/star5"))
	}
	self._imgRankComp = self:getGo("rightRoot/imgRank"):GetComponent(ComponentType.UIImgNumeralText)
	self._txtConsume = goutil.findChildTextComponent(self.mainGO, "btns/btnChallenge/consume/txtConsume")
	self._goldBarCon = self:getGo("goldBarCon")

	goutil.setActive(self._btnRule.gameObject, false)
	goutil.setActive(self._btnSkill.gameObject, false)

	self._emptyTipGo = self:getGo("rightRoot/damageCon/emptyTip")
	self._killRewardCellGo = self:getGo("rightRoot/killRewardCell")
	self._rewardInfos = {}
	self._tableCell = self:getGo("rightRoot/tablecell")
	self._rankListView = goutil.findChildComponent(self.mainGO, "leftRoot/damageCon", "UITableview")

	self._rankListView:RegisterCallback(self._rankNumInView, self._rankCellSize, self._rankCellAtIndex, self)
	self._rankListView:RegisterUpdateCellCallback(self._updateRankCell)
	self._rankListView:SetOffsetWithoutRefresh(0)

	self._tableListView = goutil.findChildComponent(self.mainGO, "rightRoot/tableview", "UITableview")

	self._tableListView:RegisterCallback(self._tableNumInView, self._tableCellSize, self._tableCellAtIndex, self)
	self._tableListView:RegisterUpdateCellCallback(self._updateTableCell)
	self._tableListView:SetOffsetWithoutRefresh(0)

	self._btnType = {
		fight = 2,
		family = 1
	}
	self._desText = {
		[self._btnType.family] = {
			title = "家族成员伤害排行"
		},
		[self._btnType.fight] = {
			title = "战区家族伤害排行"
		}
	}
end

function FamilytpmainView:bindEvents()
	FamilytpmainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRule:AddClickListener(self._onClickbtnRule, self)
	self._btnPractice:AddClickListener(self._onClickbtnPractice, self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
	self._btnColorEgg:AddClickListener(self._onClickbtnColorEgg, self)
	self._btnTips:AddClickListener(self._onClickbtnTips, self)
	self._btnDamageRank:AddClickListener(self._onClickbtnDamageRank, self)
	self._btnOrder:AddClickListener(self._onClickbtnOrder, self)
	self._btnRank:AddClickListener(self._onClickbtnRank, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._familyRankBtn:AddClickListener(self._onClickFamilyRankBtn, self)
	self._fightRankBtn:AddClickListener(self._onClickFightRankBtn, self)
end

function FamilytpmainView:unbindEvents()
	FamilytpmainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnPractice:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnColorEgg:RemoveClickListener()
	self._btnTips:RemoveClickListener()
	self._btnDamageRank:RemoveClickListener()
	self._btnOrder:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._familyRankBtn:RemoveClickListener()
	self._fightRankBtn:RemoveClickListener()
end

function FamilytpmainView:destroyUI()
	FamilytpmainView.super.destroyUI(self)
end

function FamilytpmainView:onEnter()
	FamilytpmainView.super.onEnter(self)

	local param = self:getOpenParam()

	self._teamPlayType = param[1] or 1
	self._periodId = param[2] or 1
	self._curBossId = param[3] or 1

	self:_needResetValue()
	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlayProgressInfo, self._updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilySeasonRankInfo, self._updateRankView, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlayDamageInfo, self._updateFamilyRankView, self)

	self.scrollListPool = {}
	self._txtConsume.text = FamilyteamplayConfig.instance:getPlayConsumeStrength()

	self:_updateView()
end

function FamilytpmainView:onEnterFinished()
	FamilytpmainView.super.onEnterFinished(self)

	local btn_list = {
		{
			showAdd = true,
			id = GameEnum.GoldType.Tili
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
end

function FamilytpmainView:onExit()
	FamilytpmainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._roleObj)
	MaterialMgr.resetAll(self._rareGo)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlayProgressInfo, self._updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilySeasonRankInfo, self._updateRankView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlayDamageInfo, self._updateFamilyRankView, self)
	removetimer(self._updateActLeftTime, self)
	MaterialMgr.resetAll(self._killRewardCellGo)

	self._periodId = nil
	self._curBossId = nil
	self._teamPlayType = nil
end

function FamilytpmainView:onExitFinished()
	FamilytpmainView.super.onExitFinished(self)
end

function FamilytpmainView:_onClickbtnClose()
	if self._teamPlayType == FamilyteamplayController.teamPlayType.Common then
		self:close()
	elseif self._teamPlayType == FamilyteamplayController.teamPlayType.Season then
		UIStateManager.instance:push(ViewName.FamilytpbossgroupView, 1)
		self:close()
	end
end

function FamilytpmainView:_onClickbtnRule()
	local bcfg = self:_getBossCfg(self._periodId, self._zoneId, self._curBossId)
	local mcfg = FamilyteamplayConfig.instance:getMonsterCfg(bcfg.creepMasterId)

	TipsFacade.instance:openTipWindowNoX("本关规则", mcfg.description)
end

function FamilytpmainView:_onClickbtnPractice()
	if self._leftPracticeTime <= -1 then
		FloatWordMgr.instance:show("请稍等")

		return
	end

	if self._leftPracticeTime <= 0 then
		FloatWordMgr.instance:show("暂无演习次数")

		return
	end

	if self._lastBossKill then
		FloatWordMgr.instance:show("BOSS已击败")

		return
	end

	if self._periodId > 0 and self._curBossId > 0 then
		UIStateManager.instance:push(ViewName.FamilytpMissionView, self._periodId, self._curBossId, self._teamPlayType, self._zoneId, true)
	end
end

function FamilytpmainView:_onClickbtnChallenge()
	if MaterialFacade.instance:getMatNumber(MatType.Strength, 1) < FamilyteamplayConfig.instance:getPlayConsumeStrength() then
		FloatWordMgr.instance:show("体力不足")
		FuncOpenController.instance:openFunc(57)

		return
	end

	if self._leftChallengeTime == -1 then
		FloatWordMgr.instance:show("请稍等")

		return
	elseif self._leftChallengeTime <= 0 then
		FloatWordMgr.instance:show("挑战次数不足")

		return
	end

	if self._periodId > 0 and self._curBossId > 0 then
		local nextBossCfg = self:_getBossCfg(self._periodId, self._zoneId, self._curBossId + 1)

		if not nextBossCfg and checknumber(self._leftHp) <= 0 then
			FloatWordMgr.instance:show("BOSS已击败")

			return
		end

		UIStateManager.instance:push(ViewName.FamilytpMissionView, self._periodId, self._curBossId, self._teamPlayType, self._zoneId, false)
	end
end

function FamilytpmainView:_onClickbtnColorEgg()
	local isHas = FamilyteamplayModel.instance:checkHasAvailableGames()

	if not isHas then
		FloatWordMgr.instance:show("限时彩蛋已过期")
		self:_setColorEggBtnState()
	else
		UIStateManager.instance:push(ViewName.FamilytpsmallgameView, self._btnColorEgg.gameObject.transform.position)
	end
end

function FamilytpmainView:_onClickbtnTips()
	TipsFacade.instance:openRulesView("familyteamplay1")
end

function FamilytpmainView:_onClickbtnDamageRank()
	if self._periodId > 0 then
		if self._rankType == self._btnType.family then
			UIStateManager.instance:push(ViewName.FamilytpdamagerankView, self._periodId)
		elseif self._rankType == self._btnType.fight then
			UIStateManager.instance:push(ViewName.FamilySeasonRank, self._periodId)
		end

		if self._rankType == nil then
			UIStateManager.instance:push(ViewName.FamilytpdamagerankView, self._periodId)
		end
	end
end

function FamilytpmainView:_onClickbtnOrder()
	local index = FamilyModel.instance:getMyRole()

	if index ~= 0 then
		FloatWordMgr.instance:show("您不是族长，无法任命")

		return
	end

	UIStateManager.instance:push(ViewName.FamilytporderView, self._teamPlayType, self._periodId, self._curBossId)
end

function FamilytpmainView:_onClickbtnRank()
	UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.FamilyTeamPlay)
end

function FamilytpmainView:_onClickbtnOpenChallengeView()
	if self._periodId > 0 then
		local nextBossCfg = self:_getBossCfg(self._periodId, self._zoneId, self._curBossId + 1)

		if not nextBossCfg then
			local nextPeriodId = self._periodId + 1
			local periodCfg = FamilyteamplayConfig.instance:getPeriodCfg(nextPeriodId)

			if periodCfg then
				local otime = FamilyteamplayConfig.instance:getPeriodOpenTime(nextPeriodId)
				local date = GameUtil.time2date(otime)

				FloatWordMgr.instance:show(string.format("下一期开启时间%s年%s月%s日", date.year, date.month, date.day))
			else
				FloatWordMgr.instance:show("活动已结束")
			end

			return
		end

		UIStateManager.instance:push(ViewName.FamilytpbossgroupView)
	end
end

function FamilytpmainView:_onClickbtnSkill()
	if self._curRaceId > 0 then
		PetbookController.instance:previewBattle(self._curRaceId)
	end
end

function FamilytpmainView:_needResetValue()
	self._leftPracticeTime = -1
	self._leftChallengeTime = -1
	self._leftHp = 0
	self._curRaceId = 0
	self._curSkinId = 0
	self._rewardList = {}
	self._lastBossKill = false
end

function FamilytpmainView:_updateView()
	local cfgs = FamilyteamplayModel.instance:getBaseProgressInfo()

	self._zoneId = cfgs.curZoneId
	self._progressInfo = FamilyteamplayModel.instance:getProgressInfoByType(self._teamPlayType)

	if self._progressInfo and self._periodId > 0 then
		local info = self._progressInfo

		self._leftHp = info.leftHp

		self:_setLeftPlayTime()
		self:_setRole(self._teamPlayType)
		self:_showDamageRank(info.memberDamageTop)
		self:_switchModel(self._teamPlayType)
		self:_setBossHeadInfo()
	end

	self:_showReward()
	self:_setRuleBtnState()
	self:_setOderBtnState()
end

function FamilytpmainView:_setRole(tpType)
	if self._periodId > 0 then
		local cfg = self:_getBossCfg(self._periodId, self._zoneId, self._curBossId)

		self._curSkinId = cfg.raceId
		self._curRaceId = cfg.raceId

		local modelCfg = CharacterConfig.instance:getModelUIPosAndScale("familyteamplay", self._curSkinId)

		self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._curSkinId, self._roleConGo, modelCfg[3], nil, true, modelCfg[1], modelCfg[2])

		local mcfg = CharacterConfig.instance:getPetCo(self._curRaceId)

		MaterialMgr.setCell(MatType.Rare, self._curRaceId, self._rareGo)

		self._txtMidRoleName.text = mcfg.name

		self:_setHardStar(self._minHardStar, cfg.hardStar)
	end
end

function FamilytpmainView:_setHardStar(golist, num)
	for i, go in ipairs(golist) do
		goutil.setActive(go, i <= num)
	end
end

function FamilytpmainView:_setHeadImg(imgGo, raceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(raceId))

	if not modelCo then
		return
	end
end

function FamilytpmainView:_setLeftPlayTime()
	local challengeTimes = self._progressInfo.todayChallengedTimes
	local practiceTimes = self._progressInfo.practiceTimes
	local allPlayTimes = FamilyteamplayConfig.instance:getChallengeTimes(self._teamPlayType)

	self._leftChallengeTime = math.max(0, allPlayTimes - challengeTimes)
	self._txtChallengeCountValue.text = string.format("%s/%s", self._leftChallengeTime, allPlayTimes)

	local allPractiveTimes = FamilyteamplayConfig.instance:getDailyPracticeTimes()

	self._leftPracticeTime = math.max(0, allPractiveTimes - practiceTimes)

	local nextBosscfg = self:_getBossCfg(self._periodId, self._zoneId, self._curBossId + 1)

	self._lastBossKill = not nextBosscfg and checknumber(self._leftHp) <= 0

	GameUtil.SetGray(self._btnChallenge.gameObject, self._leftChallengeTime <= 0 or self._lastBossKill)
	GameUtil.SetGray(self._btnPractice.gameObject, self._leftPracticeTime <= 0 or self._lastBossKill)

	local info = FamilyteamplayModel.instance:getProgressInfoByType(self._teamPlayType)
	local isFake = info and info.curBossId ~= info.realBossId

	goutil.setActive(self._btnChallenge.gameObject, not isFake)
	goutil.setActive(self._btnPractice.gameObject, not isFake)
end

function FamilytpmainView:_showReward()
	local cfg = self:_getBossCfg(self._periodId, self._zoneId, self._curBossId)
	local beatPrizes = string.split(cfg.beatPrize, "#")

	MaterialMgr.setCellByCfg(beatPrizes[1], self._killRewardCellGo)

	self._rewardInfos = FamilyteamplayConfig.instance:getTeamPlayFightPrize(self._teamPlayType, self._periodId, self._curBossId, self._zoneId)

	self:_switchRewardType(1)
end

function FamilytpmainView:_switchRewardType(index)
	self._curViewDatas = self.rewardInfos

	self._tableListView:ReloadData()
end

function FamilytpmainView:_showDamageRank(memberDamageTop)
	memberDamageTop = memberDamageTop or {}

	local list = {}

	table.sort(memberDamageTop, function(a, b)
		return checknumber(a.damage) > checknumber(b.damage)
	end)

	for i, v in ipairs(memberDamageTop) do
		if i > 3 then
			break
		end

		table.insert(list, v)
	end

	goutil.setActive(self._emptyTipGo, #list <= 0)

	self._rankInfos = list

	self._rankListView:ReloadData()
end

function FamilytpmainView:_updateActLeftTime()
	self._actLeftTime = self._actLeftTime - 1

	goutil.setActive(self._timebgGo, true)

	if self._actLeftTime <= 0 then
		self._txtLeftTime.text = "活动已结束"

		removetimer(self._updateActLeftTime, self)
	else
		local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._actLeftTime)

		self._txtLeftTime.text = day > 0 and string.format("时间剩余：%s天%s时%s分", day, hour, min) or string.format("时间剩余：%s时%s分%s秒", hour, min, sec)
	end
end

function FamilytpmainView:_setOderBtnState()
	local index = FamilyModel.instance:getMyRole()
	local info = FamilyteamplayModel.instance:getProgressInfoByType(self._teamPlayType)
	local nextBosscfg = self:_getBossCfg(self._periodId, self._zoneId, info.realBossId + 1)

	goutil.setActive(self._btnOrder.gameObject, checknumber(index) == 0 and (nextBosscfg or checknumber(self._leftHp) > 0) and self._teamPlayType == FamilyteamplayController.teamPlayType.Common)
end

function FamilytpmainView:_setRuleBtnState()
	goutil.setActive(self._btnRule.gameObject, false)
end

function FamilytpmainView:_tableCellSize()
	return 325, 65
end

function FamilytpmainView:_tableNumInView()
	return math.max(0, #self._rewardInfos)
end

function FamilytpmainView:_tableCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)
	cell.index = index

	self:_updateTableCell(view, cell)

	return cell
end

function FamilytpmainView:_updateTableCell(view, cell)
	local idx = cell.index
	local data = self._rewardInfos[idx + 1]
	local damageTxt = goutil.findChildTextComponent(cell, "txtDamage")
	local rewardInfo = string.split(data.prize, "#")
	local tableView = goutil.findChild(cell, "cell")
	local small = StringUtil.numberToString(data.damageRange[1])
	local big = StringUtil.numberToString(data.damageRange[2])

	damageTxt.text = string.format("%s-%s伤害可以获得:", small, big)

	local scrollList = self.scrollListPool[tableView]

	if scrollList == nil then
		scrollList = ScrollerList.create(tableView, self._rewardCellGo, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))
		self.scrollListPool[tableView] = scrollList

		scrollList:dragNotifyParent()
	end

	scrollList:reloadData(rewardInfo)
end

function FamilytpmainView:_updateItemCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "cell")

	MaterialMgr.setCellByCfg(data, item)
end

function FamilytpmainView:_clearItemCell(cell)
	local item = goutil.findChild(cell, "cell")

	MaterialMgr.resetAll(item)
end

function FamilytpmainView:_onClickFamilyRankBtn()
	FamilyteamplayController.instance:csSendViewMemberDamageListReq(self._periodId)
end

function FamilytpmainView:_onClickFightRankBtn()
	FamilyteamplayController.instance:getFamilySeasonRankList(self._periodId, self._zoneId)
end

function FamilytpmainView:_switchBtnState(btnType)
	local data = self._desText[btnType]
	local index = checknumber(btnType) - 1

	self._btnGroup:SetState(checknumber(index))

	self._tilteTxt.text = data.title
	self._rankType = btnType

	self._rankListView:ReloadData()
end

function FamilytpmainView:_updateRankView(rankList)
	local list = {}

	for i, v in ipairs(rankList) do
		if i > 3 then
			break
		end

		table.insert(list, v)
	end

	self._rankInfos = list

	self:_switchBtnState(self._btnType.fight)
end

function FamilytpmainView:_updateFamilyRankView()
	local rankList = FamilyteamplayModel.instance:getMemberDamageList()

	table.sort(rankList, function(a, b)
		return checknumber(a.damage) > checknumber(b.damage)
	end)

	local list = {}

	for i, v in ipairs(rankList) do
		if i > 3 then
			break
		end

		table.insert(list, v)
	end

	self._rankInfos = list

	self:_switchBtnState(self._btnType.family)
end

function FamilytpmainView:_switchRankInfo(btnType)
	return
end

function FamilytpmainView:_rankCellSize()
	return 340, 60
end

function FamilytpmainView:_rankNumInView()
	return math.max(0, #self._rankInfos)
end

function FamilytpmainView:_rankCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._damagecellGo)
	cell.index = index

	self:_updateRankCell(view, cell)

	return cell
end

function FamilytpmainView:_updateRankCell(view, cell)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDamage = goutil.findChildTextComponent(cell, "txtDamage")
	local txtRank = goutil.findChildTextComponent(cell, "txtRank")
	local imgRank = goutil.findChild(cell, "imgRank")
	local imgRankChange = goutil.findChild(cell, "imgRank"):GetComponent(ComponentType.UIImageSpriteChange)
	local idx = cell.index
	local data = self._rankInfos[idx + 1]

	goutil.setActive(txtRank.gameObject, cell.index >= 3)
	goutil.setActive(imgRank.gameObject, cell.index < 3)

	if data.headInfo then
		txtName.text = data.headInfo.userName or data.familyName
	end

	txtDamage.text = data.damage or data.lastBossDamage or ""

	if cell.index < 3 then
		imgRankChange:SetState(cell.index)
	elseif cell.index >= 3 then
		txtRank.text = checknumber(cell.index + 1)
	end
end

function FamilytpmainView:_switchModel(playType)
	if playType == nil or checknumber(playType) == FamilyteamplayController.teamPlayType.Common then
		self:_familyBossModel()
	elseif checknumber(playType) == FamilyteamplayController.teamPlayType.Season then
		self:_fightRankModel()
	end
end

function FamilytpmainView:_familyBossModel()
	goutil.setActive(self._tableBtnsGO, false)

	self._rankInfos = self._progressInfo.memberDamageTop
	self._tilteTxt.text = "家族成员伤害"
	self._rankType = nil
end

function FamilytpmainView:_fightRankModel()
	goutil.setActive(self._tableBtnsGO, true)
	self:_onClickFightRankBtn()
end

function FamilytpmainView:_setBossHeadInfo()
	local cfg = self:_getBossCfg(self._periodId, self._zoneId, self._curBossId)

	self._ruleDesTxt.text = FamilyteamplayConfig.instance:getBossDescription(cfg.creepMasterId)
end

function FamilytpmainView:_getBossCfg(periodId, zoneId, curBossId)
	local cfg = {}

	if self._teamPlayType == FamilyteamplayController.teamPlayType.Season then
		cfg = FamilyteamplayConfig.instance:getTeamPlayBossSeason(periodId, zoneId, curBossId)
	elseif self._teamPlayType == FamilyteamplayController.teamPlayType.Common then
		cfg = FamilyteamplayConfig.instance:getBossCfg(periodId, curBossId)
	else
		print("传进来的模式是不是有问题呀----------------------")

		return nil
	end

	return cfg
end

return FamilytpmainView
