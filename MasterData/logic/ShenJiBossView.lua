-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenjichallenge/view/ShenJiBossView.lua

module("logic.extensions.shenjichallenge.view.ShenJiBossView", package.seeall)

local ShenJiBossView = class("ShenJiBossView", ViewComponent)

function ShenJiBossView:buildUI()
	ShenJiBossView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnReset = self:getBtn("btnReset")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnPredict = self:getBtn("btnPredict")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._con = self:getGo("con")
	self._bossHpImgSlider = self:getSlider("bossHp/slider")
	self._txtBossHp = self:getTxt("bossHp/txtHp")
	self._rewardRect = self:getGo("reward"):GetComponent(goutil.Type_RectTransform)
	self.scrollerGo = self:getGo("reward/tableview")
	self.cellGo = self:getGo("reward/tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self.scrollerGo2 = self:getGo("stageInfo/tableview")
	self.cellGo2 = self:getGo("stageInfo/tablecell")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))
	self._txtTitle = self:getTxt("stageInfo/txtTitle")
	self._txtDesc2 = self:getTxt("stageInfo/txtDesc2")
	self._txtDesc3 = self:getTxt("stageInfo/txtDesc3")
	self._toggleList = {}

	for i = 1, 3 do
		local go = goutil.findChild(self.mainGO, "clgProgress/clg" .. i)

		self._toggleList[i] = goutil.findChild(go, "toggle")
	end

	self._txtClgDesc1 = self:getTxt("clgProgress/txtClgDesc1")
	self._txtClgDesc2 = self:getTxt("clgProgress/txtClgDesc2")
	self._rewardFill = self:getImg("reward/tableview/viewport/content/slider")
end

function ShenJiBossView:bindEvents()
	ShenJiBossView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._btnPredict:AddClickListener(self._onClickPredict, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function ShenJiBossView:unbindEvents()
	ShenJiBossView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function ShenJiBossView:onEnter()
	ShenJiBossView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeGainPrizeRes, self._onGainPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ShenJiChallengeResetBossStageRes, self._onResetBossStageRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._onChangeDay, self)

	self._activityId = self:getFirstParam()
	self._bossCfgs = ShenJiChallengeConfig.instance:getBossList(self._activityId)
	self._cfgActivity = ShenJiChallengeConfig.instance:getActivityCfg(self._activityId)
	self._fightBossTimes = self._cfgActivity.fightBossTimes
	self._challengeId = self._cfgActivity.challengeId

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_refreshView()
	settimer(1, self._onSecond, self)
	self:_onSecond()
	self:_popupTipViewFirst()
	self:_showRoleModel()
end

function ShenJiBossView:onExit()
	ShenJiBossView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ShenJiChallengeGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ShenJiChallengeGainPrizeRes, self._onGainPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ShenJiChallengeResetBossStageRes, self._onResetBossStageRes, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._onChangeDay, self)
	removetimer(self._onSecond, self)
	self._scrollList:dispose()
	self._scrollList2:dispose()
	self:_resetRoleModel()
end

function ShenJiBossView:_onGetInfoRes()
	self:_refreshView()
end

function ShenJiBossView:_onGainPrizeRes()
	self:_updateRewardList()
end

function ShenJiBossView:_onResetBossStageRes()
	self:_refreshView()
end

function ShenJiBossView:_onChangeDay()
	ShenJiChallengeAgent:sendPM_ShenJiChallengeGetInfoReq(self._activityId)
end

function ShenJiBossView:_onClickTip()
	local ruleCfg = ShenJiChallengeConfig.instance:getRuleCfgs(self._activityId, 2)
	local ruleList = {}

	for i, v in ipairs(ruleCfg) do
		local obj = {}

		obj.url = v.resPath
		obj.desc = v.desc

		table.insert(ruleList, obj)
	end

	TipsFacade.instance:openImageRuleView(ruleList)
end

function ShenJiBossView:_onClickReset()
	if ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId) then
		FloatWordMgr.instance:show("您已挑战完成，无需再战")

		return
	end

	local isPass = ShenJiChallengeModel.instance:getTodayPassBoss()

	if isPass then
		FloatWordMgr.instance:show("今日已通过BOSS挑战，无法重置")

		return
	end

	local text = string.format("即将重置BOSS血量、挑战限制和挑战次数\n<color=#%s>请确认是否重置？</color>", ColorConst.Red)

	local function okFunc()
		ShenJiChallengeAgent.instance:sendPM_ShenJiChallengeResetBossStageReq(self._activityId, self._bossId)
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
end

function ShenJiBossView:_onClickBuff()
	UIStateManager.instance:push(ViewName.ShenJiBuffView, self._activityId)
end

function ShenJiBossView:_onClickPredict()
	if ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId) then
		FloatWordMgr.instance:show("您已挑战完成，无需再战")

		return
	end

	if not ShenJiChallengeModel.instance:isPassBoss(self._activityId, self._bossId) then
		local isEmulate = true

		ShenJiChallengeController.instance:openBossMissionView(self._activityId, self._bossId, isEmulate)
	else
		FloatWordMgr.instance:show("BOSS已通过")
	end
end

function ShenJiBossView:_onClickChallenge()
	if ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId) then
		FloatWordMgr.instance:show("您已挑战完成，无需再战")

		return
	end

	if ShenJiChallengeModel.instance:getTodayPassBoss() then
		FloatWordMgr.instance:show("今日Boss已挑战成功")

		return
	end

	local maxNum = self._fightBossTimes
	local curNum = ShenJiChallengeModel.instance:getBossChallengeTimes()
	local leftNum = Mathf.Max(maxNum - curNum, 0)

	if leftNum <= 0 then
		local text = string.format("本轮挑战失败，请重置挑战\n<color=#%s>提示：适合的阵型和道途buff能提高破阵概率</color>", ColorConst.Green)

		TipsFacade.instance:openTipWindowNoX(lang("tip"), text, nil, nil, UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	local isEmulate = false

	ShenJiChallengeController.instance:openBossMissionView(self._activityId, self._bossId, isEmulate)
end

function ShenJiBossView:_refreshView()
	self._bossId = ShenJiChallengeModel.instance:getBossId()
	self._leftSec = 0
	self._isShowSec = false

	self:_updateBossHp()
	self:_updateRewardList()
	self:_updateStageInfo()
	self:_updateChallengeProgress()
	self:_updateBtnStates()
end

function ShenJiBossView:_updateCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local geted = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")

	txtScore.text = string.format("第%d关", data.bossId)

	local isGeted = ShenJiChallengeModel.instance:isGetedPrizeId(data.bossId)
	local isPassBoss = ShenJiChallengeModel.instance:isPassBoss(self._activityId, data.bossId)

	printInfo("test ShenJiBossView:_updateCell", txtScore.text, data.bossId, isPassBoss, isGeted, isPassBoss and not isGeted)
	goutil.setActive(canGet, isPassBoss and not isGeted)
	goutil.setActive(geted, isGeted)
	MaterialMgr.resetAll(item)

	local matType, id, matNum = MaterialMgr.getMatParams(data.prize)
	local proxy = MaterialMgr.setCellByCfg(data.prize, item)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		if isPassBoss and not isGeted then
			ShenJiChallengeAgent.instance:sendPM_ShenJiChallengeGainPrizeReq(self._activityId, data.bossId)
		elseif not goutil.isNil(item) then
			CommonTipsMgr.instance:openMaterialTips(item, matType, id, 0)
		end
	end)
	self:_playEffect(cell, canGet)
end

function ShenJiBossView:_clearCell(cell)
	self:_removeEffect(cell)
end

function ShenJiBossView:_updateCell2(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.setCell(MatType.Pet, data.raceId, node)
end

function ShenJiBossView:_clearCell2(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function ShenJiBossView:_updateBossHp()
	local curHp = ShenJiChallengeModel.instance:getBossCurHp()
	local totalHp = ShenJiChallengeModel.instance:getBossTotalHp()

	self._txtBossHp.text = string.format("<color=#%s>%d</color>/%d", ColorConst.Yellow, curHp, totalHp)

	if totalHp > 1e-05 then
		self._bossHpImgSlider:SetValue(Mathf.Clamp01(curHp / totalHp))
	else
		self._bossHpImgSlider:SetValue(0)
	end
end

function ShenJiBossView:_updateRewardList()
	self._scrollList:reloadData(self._bossCfgs)

	local maxNum = #self._bossCfgs
	local curNum = ShenJiChallengeModel.instance:getPassBossNum(self._activityId)

	self._rewardFill.fillAmount = Mathf.Clamp01((maxNum > 0 or nil) and (curNum / maxNum or 1))
end

function ShenJiBossView:_playEffect(cell, go)
	self:_removeEffect(cell)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, go.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._rewardRect) then
			eff:setClipping(self._rewardRect)
		end
	end)

	uiEffect:setParent(go.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._uiEffect[cell] = uiEffect
end

function ShenJiBossView:_removeEffect(cell)
	self._uiEffect = self._uiEffect or {}

	if self._uiEffect[cell] then
		UIEffectManager.instance:stopEffect(self._uiEffect[cell])

		self._uiEffect[cell] = nil
	end
end

function ShenJiBossView:_updateStageInfo()
	local cfgBoss = ShenJiChallengeConfig.instance:getBoss(self._activityId, self._bossId)

	if cfgBoss then
		local cfgCreeps = ShenJiChallengeConfig.instance:getCreeps(cfgBoss.creepsMasterId)

		self._scrollList2:reloadData(cfgCreeps)

		local cfgMonster = ShenJiChallengeConfig.instance:getMaster(cfgBoss.creepsMasterId)

		if cfgMonster then
			self._txtDesc2.text = cfgMonster.ruleDesc
		end

		self._txtDesc3.text = cfgBoss.buffDesc
		self._txtTitle.text = cfgBoss.stageDesc
	end
end

function ShenJiBossView:_updateChallengeProgress()
	local maxNum = self._fightBossTimes
	local curNum = ShenJiChallengeModel.instance:getBossChallengeTimes()
	local leftNum = Mathf.Max(maxNum - curNum, 0)

	for i, v in ipairs(self._toggleList) do
		goutil.setActive(v, i <= leftNum)
	end

	local isPass = ShenJiChallengeModel.instance:getTodayPassBoss()

	if isPass then
		local curTimestamp = ServerTime.now()
		local curDate = GameUtil.time2date(curTimestamp)
		local nextDayDate

		if curDate.hour >= 5 then
			curDate.day = curDate.day + 1
		end

		curDate.hour = 5
		curDate.min = 0
		curDate.sec = 0

		local targetTimestamp = GameUtil.date2time(curDate.year, curDate.month, curDate.day, curDate.hour, curDate.min, curDate.sec)

		self._leftSec = Mathf.Max(targetTimestamp - curTimestamp, 0)
		self._txtClgDesc1.text = "挑战冷却中"
		self._txtClgDesc2.text = GameUtil.FormatTimeSymbol(self._leftSec)
		self._isShowSec = true
	else
		self._txtClgDesc1.text = "本轮次数"

		if leftNum > 0 then
			if not ColorConst.Green then
				local colorStr = ColorConst.Red

				self._txtClgDesc2.text = string.format("<color=#%s>%d</color>/%d", colorStr, leftNum, maxNum)
				self._isShowSec = false
			end
		end
	end
end

function ShenJiBossView:_onSecond()
	if self._isShowSec then
		self._txtClgDesc2.text = GameUtil.FormatTimeSymbol(self._leftSec)
		self._leftSec = Mathf.Max(self._leftSec - 1, 0)
	end
end

function ShenJiBossView:_popupTipViewFirst()
	local key = ViewName.ShenJiBossView .. self._activityId
	local isMarkedFirst = GameUtil.getUserData(key)

	if not isMarkedFirst then
		GameUtil.saveUserData(key, true)
		self:_onClickTip()
	end
end

function ShenJiBossView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function ShenJiBossView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function ShenJiBossView:_updateBtnStates()
	local isPassAll = ShenJiChallengeModel.instance:isPassAllBossStage(self._activityId)

	GameUtil.SetGray(self._btnReset.gameObject, isPassAll)
	GameUtil.SetGray(self._btnPredict.gameObject, isPassAll)
	GameUtil.SetGray(self._btnChallenge.gameObject, isPassAll)
end

return ShenJiBossView
