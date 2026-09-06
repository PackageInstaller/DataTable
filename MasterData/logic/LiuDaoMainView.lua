-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/liudao/view/LiuDaoMainView.lua

module("logic.extensions.liudao.view.LiuDaoMainView", package.seeall)

local LiuDaoMainView = class("LiuDaoMainView", ViewComponent)

LiuDaoMainView.LoadListMax = 1
LiuDaoMainView.StartLoadCount = 3
LiuDaoMainView.RoleCount = 27
LiuDaoMainView.FirstLoadIdxs = {
	1,
	3,
	5
}

function LiuDaoMainView:ctor()
	LiuDaoMainView.super.ctor(self)

	self._roleEffectName = {
		"20220930/liudaolunhua/fx_ui_ldlh_tianrendao.prefab",
		"20220930/liudaolunhua/fx_ui_ldlh_fushendao.prefab",
		"20220930/liudaolunhua/fx_ui_ldlh_duoxindao.prefab",
		"20220930/liudaolunhua/fx_ui_ldlh_huaqidao.prefab",
		"20220930/liudaolunhua/fx_ui_ldlh_xiuluodao.prefab",
		"20220930/liudaolunhua/fx_ui_ldlh_suguidao.prefab"
	}
end

function LiuDaoMainView:buildUI()
	LiuDaoMainView.super.buildUI(self)

	self._btnReward = self:getBtn("btnReward")
	self._haveRedPoint = self:getGo("btnReward/redpoint")
	self._btnBuff = self:getBtn("btnBuff")
	self._effectGetBuffGo = self:getGo("effectGetBuff")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._effectMainGo = self:getGo("effectMain")
	self._txtActTime = self:getTxt("time/txt")
	self._conCell = self:getGo("ScrollView/Viewport/Content/emenyCell")
	self._conRoot = self:getGo("ScrollView/Viewport/Content")
	self._group = ItemGroup.New(self._conRoot, self._conCell)
	self._recordPos = self._conRoot:GetComponent("TestRecordPos")
	self._content = self:getGo("ScrollView/Viewport/Content")
	self._infoFace = self:getGo("info")
	self._infoTableView = self:getGo("info/tableview")
	self._infoCell = self:getGo("infoCell")
	self._infoScrollerList = ScrollerList.create(self._infoTableView, self._infoCell, GameUtil.handler(self._updateInfoCell, self), GameUtil.handler(self._clearInfoCell, self))
	self._txtEmpty = self:getTxt("info/txtEmpty")
	self._txtTime = self:getTxt("info/txtTime")
	self._txtStore = self:getTxt("info/txtStore")
	self._btnHideInfo = GameUtil.asBtn(self:getGo("info/btnHide"))
	self._btnShowInfo = GameUtil.asBtn(self:getGo("btnShow"))
	self._btnDaily = self:getBtn("info/btnDaily")
	self._changeDaily = self._btnDaily:GetComponent(typeof(UIImageSpriteChange))
	self._btnWeekly = self:getBtn("info/btnWeekly")
	self._changeWeekly = self._btnWeekly:GetComponent(typeof(UIImageSpriteChange))
	self._doubleRoleGo1 = self:getGo("doubleRole/headIcon_1")
	self._doubleRoleBtn1 = GameUtil.asBtn(self._doubleRoleGo1)
	self._doubleRoleGo2 = self:getGo("doubleRole/headIcon_2")
	self._doubleRoleBtn2 = GameUtil.asBtn(self._doubleRoleGo2)
end

function LiuDaoMainView:bindEvents()
	LiuDaoMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnReward, self._onClickReward, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnHideInfo, self._onClickHideInfo, self)
	GameUtil.addClickHandler(self._btnShowInfo, self._onClickShowInfo, self)
	GameUtil.addClickHandler(self._btnDaily, self._onClickDaily, self)
	GameUtil.addClickHandler(self._btnWeekly, self._onClickWeekly, self)
	GameUtil.addClickHandler(self._doubleRoleGo1, self._onDoubleClickRole1, self)
	GameUtil.addClickHandler(self._doubleRoleGo2, self._onDoubleClickRole2, self)
end

function LiuDaoMainView:unbindEvents()
	LiuDaoMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnHideInfo)
	GameUtil.rmClickHandler(self._btnShowInfo)
	GameUtil.rmClickHandler(self._btnDaily)
	GameUtil.rmClickHandler(self._btnWeekly)
	GameUtil.rmClickHandler(self._doubleRoleGo1)
	GameUtil.rmClickHandler(self._doubleRoleGo2)
end

function LiuDaoMainView:onEnter()
	LiuDaoMainView.super.onEnter(self)

	self._activityId = LiuDaoModel.instance:getCurrActId()
	self._activityCfg = LiuDaoConfig.instance:getActivityCfg(self._activityId)
	self._role = {}
	self._roleEffect = {}
	self._loadingList = {}
	self._readyLoad = {}
	self._loopShowIdx = {
		1,
		1,
		1,
		1,
		1,
		1
	}
	self._showTab = 1

	self._group:updateWithLen(LiuDaoMainView.RoleCount)
	self._recordPos:LoadPlan(0)

	self._conGroup = self._group:getItems()

	GlobalDispatcher:addListener(GlobalNotify.LiuDaoGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.LiuDaoRefreshStageRes, self._refreshStage, self)
	self:_initUI()
	LiuDaoController.instance:sendPM_LiuDaoGetInfoReq(self._activityId)
	RedPointController.instance:saveUserDayRedPoint(RedPointModel.ID_LIUDAOMAIN_RED)
end

function LiuDaoMainView:onExit()
	LiuDaoMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LiuDaoGetInfoRes, self._refreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.LiuDaoRefreshStageRes, self._refreshStage, self)
	self:recoverFreeze()

	for i, v in pairs(self._role) do
		RoleObjectPool.instance:removeRole(v)
	end

	for i, v in pairs(self._roleEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	if self._refreshEffect then
		UIEffectManager.instance:stopEffect(self._refreshEffect)
	end

	if self._effectGetBuff then
		UIEffectManager.instance:stopEffect(self._effectGetBuff)
	end

	if self._effectMain then
		UIEffectManager.instance:stopEffect(self._effectMain)
	end

	MaterialMgr.resetAll(self._doubleRoleGo1)
	MaterialMgr.resetAll(self._doubleRoleGo2)
	removetimer(self._canLoad, self)
	removetimer(self._onClockTime, self)
	self._group:dispose()
end

function LiuDaoMainView:_initUI()
	GameUtil.SetActive(self._infoFace, true)
	GameUtil.SetActive(self._btnShowInfo, false)
	MaterialMgr.setIcon(self._doubleRoleGo1, MatType.Pet, self._activityCfg.racesDoubledPrize[1])
	MaterialMgr.setIcon(self._doubleRoleGo2, MatType.Pet, self._activityCfg.racesDoubledPrize[2])

	self._txtStore.text = langPara("每日守卫最多囤积%d个", self._activityCfg.dailyStageMaxStorage)

	local mainEffectPath = "20220930/liudaolunhua/fx_ui_ldlh_jiemian.prefab"

	self._effectMain = UIEffectManager.instance:playEffect(self, mainEffectPath, nil, 0, 0, true)

	self._effectMain:setParent(self._effectMainGo.transform)
	self._effectMain:setScale(1)
	self._effectMain:setLocalPos(0)

	local timeCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.LIUDAOLUNHUA, self._activityId)
	local starTime = GameUtil.string2date(timeCfg.startTime)
	local endTime = GameUtil.string2date(timeCfg.endTime)

	self._txtActTime.text = langPara("活动时间：%d.%d %d:%02d-%d.%d %d:%02d", starTime.month, starTime.day, starTime.hour, starTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function LiuDaoMainView:_refreshUI()
	self:_refreshMap()
	self:_refreshInfo()
	GameUtil.SetActive(self._haveRedPoint, RedPointModel.instance:isActive(348))

	local tempIdx = LiuDaoModel.instance:getTempIdx()

	if tempIdx then
		local pos = GameUtil.getAnchoredPos(self._conGroup[tempIdx].mainGO)

		GameUtil.setAnchoredPos(self._content, -pos.x, -pos.y)
	else
		GameUtil.setAnchoredPos(self._content, 0, 0)
	end

	if self._isRefreshing == true and tempIdx then
		local effectCon = goutil.findChild(self._conGroup[tempIdx].mainGO, "con/typeEffect")
		local effectPath = "20220930/liudaolunhua/fx_ui_ldlh_shouweishuaxing.prefab"

		if self._refreshEffect then
			UIEffectManager.instance:stopEffect(self._refreshEffect)
		end

		self._refreshEffect = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false)

		self._refreshEffect:setParent(effectCon.transform)
		self._refreshEffect:setScale(0.5)
		self._refreshEffect:setLocalPos(0)

		self._isRefreshing = false

		LiuDaoModel.instance:resetTempIdx()
	end

	if LiuDaoModel.instance:getGetBuff() == true then
		local effectPath = "20220930/liudaolunhua/fx_ui_ldlh_huode.prefab"

		if self._effectGetBuff then
			UIEffectManager.instance:stopEffect(self._effectGetBuff)
		end

		self._effectGetBuff = UIEffectManager.instance:playEffect(self, effectPath, nil, 0, 0, false, nil, nil, function()
			GameUtil.setLocalRotation(self._effectGetBuffGo, 0, 0, 50)
		end)

		self._effectGetBuff:setParent(self._effectGetBuffGo.transform)
		self._effectGetBuff:setScale(0.8)
		self._effectGetBuff:setLocalPos(0)
		LiuDaoModel.instance:resetGetBuff()
	end
end

function LiuDaoMainView:_refreshStage(stageIndex)
	self._isRefreshing = true

	LiuDaoController.instance:sendPM_LiuDaoGetInfoReq(self._activityId)
end

function LiuDaoMainView:_refreshMap()
	local dailyStages = LiuDaoModel.instance:getDailyStage()
	local weeklyStages = LiuDaoModel.instance:getWeeklyStage()

	GameUtil.setAnchoredPos(self._content, 0, 0)

	for i, v in ipairs(self._conGroup) do
		GameUtil.SetActive(v.mainGO, false)
	end

	local firstList = {}
	local tempIdx = LiuDaoModel.instance:getTempIdx()

	if tempIdx then
		table.insert(firstList, tempIdx)
	else
		firstList = LiuDaoMainView.FirstLoadIdxs
	end

	local callLoad = {}

	for i, v in ipairs(firstList) do
		if v > #dailyStages then
			if v < #dailyStages + #weeklyStages then
				self:_updateMapCell(v, weeklyStages[v - #dailyStages])

				callLoad[v] = true
			end
		else
			self:_updateMapCell(v, dailyStages[v])

			callLoad[v] = true
		end
	end

	local stages = LiuDaoModel.instance:getStages()

	for i, v in ipairs(stages) do
		if v[1] and not callLoad[v[1].index] then
			self:_updateMapCell(v[1].index, v[1].stage)

			callLoad[v[1].index] = true
		end
	end

	for i, stageId in ipairs(dailyStages) do
		local index = i

		if not callLoad[index] then
			self:_updateMapCell(index, stageId)

			callLoad[index] = true
		end
	end

	for i, stageId in ipairs(weeklyStages) do
		local index = #dailyStages + i

		if not callLoad[index] then
			self:_updateMapCell(index, stageId)

			callLoad[index] = true
		end
	end

	self:_canLoad()
	settimer(0.2, self._canLoad, self, true)
end

function LiuDaoMainView:_refreshInfo()
	local dataList = {}
	local stages = LiuDaoModel.instance:getStages()

	if self._showTab == 1 then
		GameUtil.SetActive(self._txtStore, true)
		self._changeDaily:ChangeSprite("btn_ld_01")
		self._changeWeekly:ChangeSprite("btn_ld_02")

		for i, v in ipairs(LiuDaoModel.instance:getDailyGroupIds()) do
			if #stages[v] > 0 then
				table.insert(dataList, {
					type = v,
					name = LiuDaoConfig.instance:getStageCfg(self._activityId, stages[v][1].stage).stageName,
					num = #stages[v]
				})
			end
		end
	else
		self._changeDaily:ChangeSprite("btn_ld_02")
		self._changeWeekly:ChangeSprite("btn_ld_01")
		GameUtil.SetActive(self._txtStore, false)

		for i, v in ipairs(LiuDaoModel.instance:getWeekGroupIds()) do
			if #stages[v] > 0 then
				table.insert(dataList, {
					type = v,
					name = LiuDaoConfig.instance:getStageCfg(self._activityId, stages[v][1].stage).stageName,
					num = #stages[v]
				})
			end
		end
	end

	if #dataList <= 0 then
		GameUtil.SetActive(self._txtTime, true)
		GameUtil.SetActive(self._txtEmpty, true)

		self._tagTime = 0

		removetimer(self._onClockTime, self)

		if self._showTab == 1 then
			self._txtEmpty.text = lang("今日守卫已全部消灭")

			local startTime, endTime = GameUtil.getTimestampOnStartAndEnd(ServerTime.now(), 1, 1)

			self._tagTime = endTime

			settimer(1, self._onClockTime, self, true)
		else
			self._txtEmpty.text = lang("本周守卫已全部消灭")

			local timeObj = GameUtil.time2date(ServerTime.now())
			local weekDay = timeObj.wday
			local hour = timeObj.hour

			if hour >= 0 and hour < 5 then
				weekDay = weekDay + 6
			end

			weekDay = weekDay % 7

			local needDay = (5 - weekDay + 7) % 7

			if needDay == 0 then
				needDay = 7
			end

			local startTime, endTime = GameUtil.getTimestampOnStartAndEnd(ServerTime.now(), 1, needDay)

			self._tagTime = endTime

			settimer(1, self._onClockTime, self, true)
		end
	else
		GameUtil.SetActive(self._txtEmpty, false)
		GameUtil.SetActive(self._txtTime, false)
	end

	self._infoScrollerList:reloadData(dataList)
end

function LiuDaoMainView:_canLoad()
	for i, v in ipairs(self._loadingList) do
		if v == true then
			return
		end
	end

	if #self._readyLoad <= 0 then
		removetimer(self._canLoad, self)
	else
		for i = 1, LiuDaoMainView.LoadListMax do
			if #self._readyLoad <= 0 then
				return
			end

			local skinId = self._readyLoad[1].skinId
			local idx = self._readyLoad[1].idx
			local type = self._readyLoad[1].type

			self._loadingList[i] = true

			local con = goutil.findChild(self._conGroup[idx].mainGO, "con")
			local effectCon = goutil.findChild(self._conGroup[idx].mainGO, "con/typeEffect")

			if self._roleEffect[idx] then
				UIEffectManager.instance:stopEffect(self._roleEffect[idx])
			end

			self._roleEffect[idx] = UIEffectManager.instance:playEffect(self, self._roleEffectName[type], nil, 0, 0, true)

			self._roleEffect[idx]:setParent(effectCon.transform)
			self._roleEffect[idx]:setScale(0.8)
			self._roleEffect[idx]:setLocalPos(0)

			self._role[idx] = RoleObjectPool.instance:addRoleToParent(self._role[idx], skinId, con, 0.1, function()
				self._loadingList[i] = false

				local skeletonGraphic = con:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

				if skeletonGraphic ~= nil then
					skeletonGraphic.timeScale = 0
				end
			end, false)

			table.remove(self._readyLoad, 1)
		end
	end
end

function LiuDaoMainView:_updateMapCell(idx, stageId)
	if stageId <= 0 then
		return
	end

	local maxPower = RoleModel.instance:getMaxPower()
	local stageCfg = LiuDaoConfig.instance:getStageCfg(self._activityId, stageId)
	local weekindex = LiuDaoModel.instance:getWeekIndex()
	local typeCfg = LiuDaoConfig.instance:getGroupType(self._activityId, weekindex, stageCfg.groupId)
	local cell = self._conGroup[idx].mainGO
	local btnBody = GameUtil.asBtn(goutil.findChild(cell, "con/btnClick"))
	local btnReresh = GameUtil.asBtn(goutil.findChild(cell, "btnRefresh"))
	local typeChange = goutil.findChildComponent(cell, "recommendZdl/type", "UIImageSpriteChange")
	local txtType = goutil.findChildTextComponent(cell, "recommendZdl/type/txtName")
	local txtPower = goutil.findChildTextComponent(cell, "recommendZdl/txt")

	GameUtil.SetActive(cell, true)

	local isCanRefresh = self._activityCfg.weeklyRefreshLimit - LiuDaoModel.instance:getWeekRefreshTimes() > 0

	if isCanRefresh and typeCfg.refreshType ~= "daily" then
		GameUtil.SetActive(btnReresh, true)
	else
		GameUtil.SetActive(btnReresh, false)
	end

	typeChange:SetState(stageCfg.groupId - 1)

	txtType.text = stageCfg.stageName

	local creepsCfg = LiuDaoConfig.instance:getMonsterCfg(stageCfg.creepsMasterId)
	local recommendZdl = checkint(creepsCfg.recommendZdl * maxPower * 0.01)

	txtPower.text = langPara("推荐<size=18>战力</size><size=24>%d</size>", recommendZdl)

	local teamCfg = LiuDaoConfig.instance:getMonsterTeamCfg(stageCfg.creepsMasterId)

	if teamCfg[1] then
		table.insert(self._readyLoad, {
			skinId = teamCfg[5].raceId,
			idx = idx,
			type = stageCfg.groupId
		})
	end

	GameUtil.rmClickHandler(btnBody)
	GameUtil.addClickHandler(btnBody, function()
		self:_onClickEnemy(idx)
	end, self)
	GameUtil.rmClickHandler(btnReresh)
	GameUtil.addClickHandler(btnReresh, function()
		self:onClickRefresh(idx)
	end, self)
end

function LiuDaoMainView:_clearMapCell(idx)
	local cell = self._conGroup[idx].mainGO
	local btnBody = GameUtil.asBtn(goutil.findChild(cell, "con/btnClick"))
	local btnReresh = GameUtil.asBtn(goutil.findChild(cell, "btnRefresh"))

	GameUtil.rmClickHandler(btnBody)
	GameUtil.rmClickHandler(btnReresh)
end

function LiuDaoMainView:_updateInfoCell(view, cell, data, tag)
	local go = cell.gameObject
	local txt = goutil.findChildTextComponent(go, "txt")
	local imageChange = goutil.findChildComponent(go, "type", "UIImageSpriteChange")
	local txtType = goutil.findChildTextComponent(go, "type/txtName")
	local btn = GameUtil.asBtn(go)

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self:_onClickInfo(data.type)
	end, self)
	imageChange:SetState(data.type - 1)

	txtType.text = data.name
	txt.text = langPara("%s守卫（剩余：%d）", data.name, data.num)
end

function LiuDaoMainView:_clearInfoCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(go)

	btn:RemoveClickListener()
end

function LiuDaoMainView:_onClickReward()
	UIStateManager.instance:push(ViewName.LiuDaoRewardView, self._activityId)
end

function LiuDaoMainView:_onClickBuff()
	local content = lang("完成悬赏任务可获得属性加成\n")
	local buffList = "\n"
	local buffs = LiuDaoModel.instance:getBuffs()

	if buffs and #buffs > 0 then
		local haveBuff = false

		buffList = ""

		for i, v in ipairs(buffs) do
			local cfg = LiuDaoConfig.instance:getBuffCfg(v.buffId)

			for i = 1, v.num do
				haveBuff = true
				buffList = langPara("%s\n%s", buffList, cfg.buffDes)
			end
		end

		if haveBuff == false then
			buffList = lang("\n当前无属性加成")
		end
	else
		buffList = lang("\n当前无属性加成")
	end

	TipsFacade.instance:openTipWindow(lang("提示"), content .. buffList, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function LiuDaoMainView:_onClickInfo(idx)
	local stages = LiuDaoModel.instance:getStages()
	local tagIdx = stages[idx][self._loopShowIdx[idx]].index

	self._loopShowIdx[idx] = (self._loopShowIdx[idx] + 1) % #stages[idx]

	if self._loopShowIdx[idx] == 0 then
		self._loopShowIdx[idx] = #stages[idx]
	end

	local pos = GameUtil.getAnchoredPos(self._conGroup[tagIdx].mainGO)

	GameUtil.setAnchoredPos(self._content, -pos.x, -pos.y)
end

function LiuDaoMainView:_onClickEnemy(idx)
	local dailyStages = LiuDaoModel.instance:getDailyStage()
	local weeklyStages = LiuDaoModel.instance:getWeeklyStage()
	local customFmtMo = LiuDaoModel.instance:getCustomFmtMo()
	local step = 0
	local type = "daily"

	if idx <= #dailyStages then
		type = "daily"
		step = idx
	else
		type = "weekly"
		step = idx - #dailyStages
	end

	self:recoverFreeze()
	customFmtMo:initParams(self._activityId, type, step, idx)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function LiuDaoMainView:onClickRefresh(idx)
	local type, id, costNum = MaterialMgr.getMatParams(self._activityCfg.refreshCost)
	local haveTimes = self._activityCfg.weeklyRefreshLimit - LiuDaoModel.instance:getWeekRefreshTimes()
	local content = langPara("确定花费%d钻石，刷新一次守卫难度吗?\n本周剩余次数：%d", costNum, haveTimes)
	local refreshIdx = idx - #LiuDaoModel.instance:getDailyStage()

	TipsFacade.instance:openPopupWindow(lang("提示"), content, GameUtil.handler(function()
		LiuDaoModel.instance:readyRefresh(idx)
		LiuDaoModel.instance:saveTempIdx(idx)
		LiuDaoAgent.instance:sendPM_LiuDaoRefreshStageReq(self._activityId, refreshIdx - 1, LiuDaoModel.instance:getWeekRefreshTimes() + 1)
	end, self))
end

function LiuDaoMainView:_onClickHideInfo()
	GameUtil.SetActive(self._infoFace, false)
	GameUtil.SetActive(self._btnShowInfo, true)
end

function LiuDaoMainView:_onClickShowInfo()
	GameUtil.SetActive(self._infoFace, true)
	GameUtil.SetActive(self._btnShowInfo, false)
end

function LiuDaoMainView:_onClickDaily()
	if self._showTab ~= 1 then
		self._showTab = 1

		self:_refreshInfo()
	end
end

function LiuDaoMainView:_onClickWeekly()
	if self._showTab ~= 2 then
		self._showTab = 2

		self:_refreshInfo()
	end
end

function LiuDaoMainView:_onClickClose()
	LiuDaoModel.instance:resetTempIdx()
	self:close()
end

function LiuDaoMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, "liudaomainview_rule")
end

function LiuDaoMainView:_onDoubleClickRole1()
	CommonTipsMgr.instance:showMaxLvlPetTips(self._activityCfg.racesDoubledPrize[1])
end

function LiuDaoMainView:_onDoubleClickRole2()
	CommonTipsMgr.instance:showMaxLvlPetTips(self._activityCfg.racesDoubledPrize[2])
end

function LiuDaoMainView:_onClockTime()
	self._txtTime.text = langPara("刷新时间：%s", GameUtil.FormatTimeSymbol(self._tagTime - ServerTime.now()), self._tagTime, ServerTime.now())
end

function LiuDaoMainView:recoverFreeze()
	for i, v in pairs(self._conGroup) do
		local con = goutil.findChild(v.mainGO, "con")
		local skeletonGraphic = con:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

		if skeletonGraphic ~= nil then
			skeletonGraphic.timeScale = 1
		end
	end
end

return LiuDaoMainView
