-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingciyuanchallenge/view/KingciyuanchallengebossView.lua

module("logic.extensions.kingciyuanchallenge.view.KingciyuanchallengebossView", package.seeall)

local KingciyuanchallengebossView = class("KingciyuanchallengebossView", ViewComponent)
local OneDaySec = 86400

function KingciyuanchallengebossView:ctor()
	KingciyuanchallengebossView.super.ctor(self)
end

function KingciyuanchallengebossView:unbindEvents()
	KingciyuanchallengebossView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._buffIcon)
	self._drag:RemoveEndDragListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
end

function KingciyuanchallengebossView:bindEvents()
	KingciyuanchallengebossView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._buffIcon, self._onClickBuff, self)
	self._drag:AddEndDragListener(self._onDragEnd, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
end

function KingciyuanchallengebossView:buildUI()
	KingciyuanchallengebossView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._txtTime = self:getTxt("time/txt")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtRemain = self:getTxt("remain/txt")
	self._btnAdd = self:getGo("remain/btnAdd")
	self._buffIcon = self:getGo("buff/txt/buffIcon")
	self._con = self:getGo("con")

	local playerRoot = self:getGo("playerRoot")

	self._playerSliderMo = PlayerSliderMo.New(playerRoot)
	self._txtTotal = self:getTxt("playerRoot/txtTotal")

	local scrollerGo = self:getGo("level/tableview")
	local cellGo = self:getGo("level/cell")

	GameUtil.SetActive(cellGo, false)

	self._scrollList = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._drag = Framework.UIDragTrigger.Get(goutil.findChild(scrollerGo, "uidrag"))
	self._content = goutil.findChild(scrollerGo, "Viewport/Content")
	self._scrollrect = scrollerGo:GetComponent("ScrollRect")

	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinishEnd, self))
	self._scrollList:regValueChanged(GameUtil.handler(self._onScrollValueChanged, self))
end

function KingciyuanchallengebossView:onExit()
	KingciyuanchallengebossView.super.onExit(self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanBossGetPrizeRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:unregisterLocalNotify(KingCiYuanChallengeController.E_KingCiYuanBossBuyCountRes, self._invalidateAll, self)
	self._playerSliderMo:onExit()
	self._scrollList:dispose()

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	uGuiUtil.clearImage(self._buffIcon)
end

function KingciyuanchallengebossView:onEnter()
	KingciyuanchallengebossView.super.onEnter(self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanGetInfoRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanBossGetPrizeRes, self._invalidateAll, self)
	KingCiYuanChallengeController.instance:registerLocalNotify(KingCiYuanChallengeController.E_KingCiYuanBossBuyCountRes, self._invalidateAll, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.KING_CI_YUAN_CHALLENGE)
	end

	self._activityConfig = KingCiYuanChallengeConfig.instance:getActivityConfig(self._activityId)
	self._curSelectId = 3

	local _, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.KING_CI_YUAN_CHALLENGE, self._activityId)
	local startDate = GameUtil.string2date(self._activityConfig.bossChallengeTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)

	self:_invalidateAll()

	self._curSelectId = table.indexof(self._bossArray, self._todayBossData)

	self:_onClickCell(self._bossArray[self._curSelectId])
	self._scrollList:MoveCellToBegin(self._curSelectId - 3)
end

function KingciyuanchallengebossView:_updateCell(view, cell, data, tag)
	local con = goutil.findChild(cell, "con")
	local openGo = goutil.findChild(cell, "con/open")
	local txtOpen = goutil.findChildTextComponent(openGo, "txtOpen")
	local icon = goutil.findChild(cell, "con/icon")

	if data.bossId then
		local planData = KingCiYuanChallengeConfig.instance:getBossChallengePlan(self._activityConfig.bossPlanId, data.bossId)

		MaterialMgr.setIcon(icon.gameObject, MatType.PET_SKIN, planData.raceId)
		GameUtil.SetActive(openGo, data.day > 0)

		if data.day > 0 then
			txtOpen.text = langPara("%s天后开启", data.day)
		end

		GameUtil.addClickHandler(cell.gameObject, function()
			self:_onClickCell(data)
		end)
		GameUtil.SetActive(con.gameObject, true)
	else
		GameUtil.SetActive(con.gameObject, false)
	end
end

function KingciyuanchallengebossView:_clearCell(cell)
	local icon = goutil.findChild(cell, "con/icon")

	MaterialMgr.resetAll(icon)
	GameUtil.rmClickHandler(cell.gameObject)
end

function KingciyuanchallengebossView:_onClickCell(data)
	if not data then
		return
	end

	self._planData = KingCiYuanChallengeConfig.instance:getBossChallengePlan(self._activityConfig.bossPlanId, data.bossId)
	self._curSelectId = table.indexof(self._bossArray, data)

	self._scrollList:reloadData(self._bossArray)
	self._scrollList:refresh()
	self:_invalidatePet()
end

function KingciyuanchallengebossView:_getBossOpenConfigs()
	local configs = KingCiYuanChallengeConfig.instance:getBossOpenDayConfigs()
	local timeStart = GameUtil.string2time(self._activityConfig.bossChallengeTime)
	local now = ServerTime.now()
	local days = math.ceil(math.max(now - timeStart, 0) / OneDaySec)

	if days > #configs then
		days = 1
		configs = {
			configs[#configs]
		}
	end

	local hasPassDay = days
	local map = {}

	for i = hasPassDay, #configs do
		local config = configs[i]

		if map[config.bossId] == nil then
			map[config.bossId] = {
				day = i - hasPassDay,
				bossId = config.bossId
			}
		end
	end

	local array = {}

	for i, v in pairs(map) do
		table.insert(array, v)
	end

	ArraySort.sortOn(array, "bossId")
	table.insert(array, 1, {})
	table.insert(array, 1, {})
	table.insert(array, {})
	table.insert(array, {})

	return array
end

function KingciyuanchallengebossView:_invalidateRewardSlider()
	local playerParam = {}

	playerParam.view = self
	playerParam.playerSliderCellClass = PlayerSliderCell
	playerParam.prizeCfgs = KingCiYuanChallengeConfig.instance:getBossPrizeConfigs(self._todayPlanData.dmgPlanId)

	function playerParam.getPlayerProgress()
		return KingCiYuanChallengeModel.instance:getBossMaxDamage()
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.damage
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return KingCiYuanChallengeModel.instance:isProgressPrizeCanGain(rewardCfg.id, rewardCfg.damage)
	end

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return KingCiYuanChallengeModel.instance:isProgressPrizeGain(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		KingCiYuanChallengeController.instance:reqGainBossProgressPrize(self._activityId, rewardCfg.id)
	end

	function playerParam.parseGetProgress(rewardCfg)
		return rewardCfg.damage
	end

	local isSkipAnimation = false

	if self._playerSliderMo then
		self._playerSliderMo:onExit()
	end

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function KingciyuanchallengebossView:_invalidateAll()
	self._bossArray = self:_getBossOpenConfigs()

	local bossData

	for i, v in ipairs(self._bossArray) do
		if v and v.day == 0 then
			bossData = v

			break
		end
	end

	self._todayBossData = bossData
	self._todayPlanData = KingCiYuanChallengeConfig.instance:getBossChallengePlan(self._activityConfig.bossPlanId, bossData.bossId)

	self._scrollList:reloadData(self._bossArray)
	self._scrollList:refresh()
	self:_invalidateRewardSlider()
	self:_invalidatePet()

	local remainCount = KingCiYuanChallengeModel.instance:getBossChallengeRemain()

	self._txtRemain.text = langPara("今日剩余挑战数：%s", remainCount)
	self._txtTotal.text = tostring(KingCiYuanChallengeModel.instance:getBossMaxDamage())

	self:_invalidateBuff()
end

function KingciyuanchallengebossView:_invalidateBuff()
	local bossBuffId = KingCiYuanChallengeModel.instance:getTodayBossBuff()
	local config = KingCiYuanChallengeConfig.instance:getBossBuffConfig(self._todayPlanData.buffPlanId, bossBuffId)

	uGuiUtil.clearImage(self._buffIcon)
	uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(config.icon))
end

function KingciyuanchallengebossView:_invalidatePet()
	if not self._planData then
		return
	end

	self._loader = RoleObjectPool.instance:removeRole(self._loader)

	local skinId = self._planData.raceId
	local x, y, scale = self._planData.rolePos[1], self._planData.rolePos[2], self._planData.rolePos[3]

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, scale, nil, true, x, y)
end

function KingciyuanchallengebossView:_onDrag(eventData)
	self._scrollrect:OnDrag(eventData)
end

function KingciyuanchallengebossView:_onBeginDrag(eventData)
	self._scrollrect:OnBeginDrag(eventData)
end

function KingciyuanchallengebossView:_onDragEnd(eventData)
	local pos = GameUtil.getAnchoredPos(self._content)

	if pos then
		if not pos.y then
			local conY = 0
			local curId = checknumber((conY + 28) / -158) + 1

			curId = MathUtil.clamp(curId, 1, #self._bossArray)

			self:_onClickCell(self._bossArray[curId])
		end
	end
end

function KingciyuanchallengebossView:_onReloadFinishEnd()
	return
end

function KingciyuanchallengebossView:_onScrollValueChanged(tableview)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local conX, conY, conZ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local height = goutil.getHeight(viewPortTrans)
	local ofh = 100
	local hh = height * 0.5
	local R = ofh + hh * hh / ofh
	local r = R * 0.5
	local a = hh
	local b = -r + ofh
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofy = conY + locy
			local yy = ofy - a
			local ta = math.atan2(-b, yy)
			local xx = r * math.sin(ta) + b
			local cellContent = goutil.findChild(cell, "con")

			GameUtil.setLocalPos(cellContent.transform, xx - 45, 0, 0)
		end
	end
end

function KingciyuanchallengebossView:_onClickRule()
	local ruleKey = KingCiYuanChallengeConfig.instance:getCommonValue("A6")

	if not string.nilorempty(ruleKey) then
		UIStateManager.instance:open(ViewName.RulesView, ruleKey)
	end
end

function KingciyuanchallengebossView:_onClickAdd()
	local remainCount = KingCiYuanChallengeModel.instance:getBossChallengeRemain()

	if remainCount > 0 then
		FloatWordMgr.instance:show(lang("还有剩余挑战次数，无需购买次数"))

		return
	end

	local times = KingCiYuanChallengeModel.instance:getHasBuyBossChallenge()
	local cost = KingCiYuanChallengeConfig.instance:getBuyBossCountCost(times + 1)

	if string.nilorempty(cost) then
		FloatWordMgr.instance:show(lang("今日已无次数可购买"))

		return
	end

	local maxBuy = KingCiYuanChallengeConfig.instance:getMaxBuyBossCount()
	local type, id, num = MaterialMgr.getMatParams(cost)
	local content = langPara("确定花费<color=#ebad32>%s%s</color>购买挑战次数吗？\n每天最多可购买：<color=#ebad32>%s次</color>，还能购买<color=#ebad32>%s次</color>", num, MaterialMgr.getMaterialsName(type, id), maxBuy, math.max(maxBuy - times, 0))

	TipsFacade.instance:openPopupCostMatViewNew(type, id, num, content, function()
		KingCiYuanChallengeAgent.instance:sendPM_KingCiYuanBossBuyCountReq(self._activityId)
	end)
end

function KingciyuanchallengebossView:_onClickChallenge()
	local remainCount = KingCiYuanChallengeModel.instance:getBossChallengeRemain()

	if remainCount <= 0 then
		FloatWordMgr.instance:show(lang("无挑战次数"))

		return
	end

	KingCiYuanChallengeModel.instance:clearViewInfos()
	KingCiYuanChallengeModel.instance:addViewInfo(ViewName.KingciyuanchallengemainView)
	KingCiYuanChallengeModel.instance:addViewInfo(self._viewPresentor.viewName, self._activityId)

	local fmtMo = KingCiYuanChallengeModel.instance.bossFmtMo

	fmtMo:initParams(self._activityId, self._todayPlanData.bossId)
	CustomFmtController.instance:showMissionView(fmtMo)
end

function KingciyuanchallengebossView:_onClickBuff()
	local bossBuffId = KingCiYuanChallengeModel.instance:getTodayBossBuff()
	local config = KingCiYuanChallengeConfig.instance:getBossBuffConfig(self._todayPlanData.buffPlanId, bossBuffId)

	TipsFacade.instance:openTipWindow(lang("tip"), config.desc)
end

return KingciyuanchallengebossView
