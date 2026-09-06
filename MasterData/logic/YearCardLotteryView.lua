-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardlottery/view/YearCardLotteryView.lua

module("logic.extensions.yearcardlottery.view.YearCardLotteryView", package.seeall)

local YearCardLotteryView = class("YearCardLotteryView", ViewComponent)

function YearCardLotteryView:buildUI()
	YearCardLotteryView.super.buildUI(self)

	self._goldBar = self:getGo("goldBar")
	self._costItem = self:getGo("cost/item")
	self._txtNum = self:getTxt("cost/txtNum")
	self._btnLottery = self:getBtn("btnLottery")
	self._txtLottery = self:getTxt("btnLottery/Text")
	self._btnInfo = self:getBtn("btnInfo")
	self._btnSkill = self:getBtn("btnSkill")
	self._btnTip = self:getBtn("btnTip")
	self._txtInfo = self:getTxt("rank/txtInfo")
	self._tipEmpty = self:getGo("rank/tipEmpty")
	self._petCon = self:getGo("petCon")
	self._txtWishTimes = self:getTxt("txtWishTimes")
	self._fadeOut = self._txtInfo.gameObject:GetComponent("UITweenFadeOut")
	self._prizeList = {}

	for i = 1, 15 do
		local cell = {}

		cell.go = self:getGo("prizeList/cell_" .. i)
		cell.eff = goutil.findChild(cell.go, "eff")
		cell.mark = goutil.findChild(cell.go, "mask")
		cell.item = goutil.findChild(cell.go, "item")
		cell.isGain = false
		self._prizeList[i] = cell
	end

	self.skinId = 1600102
	self._aniPath = "jieshenxinyuan_dengchang"
	self._mainEffPath = "20211231/qiandao/fx_ui_xuyuan_daiji.prefab"
end

function YearCardLotteryView:initActiveId()
	self._actId = YearCardModel.instance:getCurAnnuityId()
end

function YearCardLotteryView:onEnter()
	YearCardLotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardLotteryInfoUpdate, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.YearCardFinishLottery, self._onLottery, self)

	self.isLotteryTime = false

	self:initActiveId()

	self._prizeCfgs = YearCardLotteryConfig.instance:getPrizeCfgs(self._actId)
	self._curCfg = YearCardLotteryConfig.instance:getCommonCfg(self._actId)

	if self._prizeCfgs and self._curCfg then
		self:_setViewByCfg()

		if ServerTime.now() > GameUtil.string2time(self._curCfg.startTime) then
			self.isLotteryTime = true
			self._txtLottery.text = lang("许愿1次")

			GameUtil.SetActive(self._btnInfo, true)
			GameUtil.SetActive(self._btnSkill, true)
			YearCardLotteryController.instance:sendGetInfoReq(self._actId)
		else
			local date = GameUtil.string2date(self._curCfg.startTime)

			self._txtLottery.text = langPara("%s月%s日开启", date.month, date.day)
		end
	else
		printError("当前活动配置为空")
	end

	self:_refreshView()

	local btnList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.GodDiamondCoin
		}
	}

	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, btnList)
	YearCardLotteryController.instance:setRedPointInfo()

	local aniDayKey = "yearcard_lottery_animation_daily"
	local isFirstPlay = GameUtil.getUserDayData(aniDayKey)

	if checkint(isFirstPlay) <= 0 and not string.nilorempty(self._aniPath) then
		GameUtil.saveUserDayData(aniDayKey, 1)

		local animConfig = {
			animName = self._aniPath,
			animFinishCallback = self._onfinishPlayAni,
			callbackTarget = self
		}

		ViewMgr.instance:open(ViewName.AnimationPlaying, animConfig)
	end

	if not string.nilorempty(self._mainEffPath) then
		self:_createEff(self._mainEffPath, self.mainGO, "mainEff", true)
	end

	self._isLotterying = false
end

function YearCardLotteryView:onExit()
	YearCardLotteryView.super.onExit(self)

	for k, v in ipairs(self._prizeList) do
		MaterialMgr.resetAll(v.item)
	end

	self:_removeAllEffect()
	MaterialMgr.clearIcon(self._costItem)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardLotteryInfoUpdate, self._refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.YearCardFinishLottery, self._onLottery, self)
	removetimer(self._playSingleRotateEff, self)
	removetimer(self._showNewRank, self)
	YearCardLotteryModel.instance:showCI(self._actId)
end

function YearCardLotteryView:bindEvents()
	YearCardLotteryView.super.bindEvents(self)
	self._btnLottery:AddClickListener(self._onClickLottery, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
end

function YearCardLotteryView:unbindEvents()
	YearCardLotteryView.super.unbindEvents(self)
	self._btnLottery:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function YearCardLotteryView:_onfinishPlayAni()
	return
end

function YearCardLotteryView:_setViewByCfg()
	self:_resetView()

	for i = 1, 15 do
		local prizeCfg = self._prizeCfgs[i]
		local prize = prizeCfg and prizeCfg.prize

		if string.nilorempty(prize) then
			goutil.setActive(self._prizeList[i].go, false)
		else
			MaterialMgr.setCellByCfg(prize, self._prizeList[i].item)
			goutil.setActive(self._prizeList[i].go, true)
		end
	end

	self._lotteryCost = self._curCfg.lotteryCost
	self._lotteryCoupon = self._curCfg.lotteryCoupon

	local curBigPrizeStr = self._prizeCfgs[self._curCfg.prizeId].prize

	self._prizeName = MaterialMgr.getMaterialsNameByCfg(curBigPrizeStr)
end

function YearCardLotteryView:_refreshView()
	self:_setBtnStatus()
	self:_setRankInfo()
	self:_setPrizeStatus()
	self:_setCurCost()
end

function YearCardLotteryView:_resetView()
	for i = 1, 15 do
		goutil.setActive(self._prizeList[i].mark, false)
	end

	removetimer(self._showNewRank, self)
	goutil.setActive(self._txtInfo.gameObject, false)
	goutil.setActive(self._tipEmpty, true)

	self._fadeOut.enabled = false
end

function YearCardLotteryView:_setBtnStatus()
	local lotteryTimes = YearCardLotteryModel.instance:getLotteryTimes(self._actId)

	self._txtWishTimes.text = langPara("我的许愿： %s次", lotteryTimes)
end

function YearCardLotteryView:_setCurCost()
	self._isExistCoupon = not string.nilorempty(self._lotteryCoupon) and MaterialMgr.getMatEnough(self._lotteryCoupon)

	if self._isExistCoupon then
		self._costMatStr = self._lotteryCoupon or self._lotteryCost
	end

	MaterialMgr.clearIcon(self._costItem)

	local costType, costId, costNum = MaterialMgr.getMatParams(self._costMatStr)

	self._costNum = costNum

	MaterialMgr.setIcon(self._costItem, costType, costId)

	self._txtNum.text = "X" .. self._costNum
end

function YearCardLotteryView:_setRankInfo()
	removetimer(self._showNewRank, self)

	self._curRankId = 0
	self._rankList = {}

	local info = YearCardLotteryModel.instance:getMsgInfo(self._actId)

	if checknumber(info.rankSize) == 0 then
		goutil.setActive(self._txtInfo.gameObject, false)
		goutil.setActive(self._tipEmpty, true)

		self._fadeOut.enabled = false
	else
		goutil.setActive(self._txtInfo.gameObject, true)
		goutil.setActive(self._tipEmpty, false)

		self._rankList = info.rankList

		settimer(3, self._showNewRank, self)
		self:_showNewRank()
	end
end

function YearCardLotteryView:_showNewRank()
	self._curRankId = self._curRankId + 1

	if #self._rankList < self._curRankId then
		self._curRankId = 1
	end

	local data = self._rankList[self._curRankId]

	self._txtInfo.text = langPara("%s服的%s许愿%s次获得%s", data.areaName, data.playerName, data.time, self._prizeName)
	self._fadeOut.enabled = true
end

function YearCardLotteryView:_setPrizeStatus()
	local info = YearCardLotteryModel.instance:getMsgInfo(self._actId)

	if not info.gainPrizeStatus then
		for k, v in ipairs(self._prizeList) do
			goutil.setActive(v.mark, info.gainPrizeStatus[k])

			v.isGain = info.gainPrizeStatus[k]
		end
	end
end

function YearCardLotteryView:_onLottery()
	self._isLotterying = true

	self:_playEffAni()
end

function YearCardLotteryView:_onClickLottery()
	if self._isLotterying then
		return
	end

	if self.isLotteryTime == false then
		if ServerTime.now() > GameUtil.string2time(self._curCfg.startTime) then
			TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("请稍候，等待活动刷新"))
			self:onEnter()
		else
			local date = GameUtil.string2date(self._curCfg.startTime)

			TipsFacade.instance:openCommonTips(langPara("活动将于%s年%s月%s日%s点开启", date.year, date.month, date.day, date.hour))
		end
	else
		local lotteryTimes = YearCardLotteryModel.instance:getLotteryTimes(self._actId)

		if lotteryTimes >= self._curCfg.buyLimit then
			FloatWordMgr.instance:show(lang("所有奖励已领取"))
		else
			local eType, eId, eNum = MaterialMgr.getMatParams(self._curCfg.extraPrize)
			local matType, id, num = MaterialMgr.getMatParams(self._costMatStr)
			local costName = MaterialMgr.getMaterialsName(matType, id)
			local earnName = MaterialMgr.getMaterialsName(eType, eId)
			local content = langPara("确定花费%s%s购买%s%s，并进行1次许愿吗？", num, costName, eNum, earnName)

			TipsFacade.instance:openPopupCostMatViewNew(matType, id, num, content, function()
				YearCardLotteryController.instance:sendLotteryReq(self._actId)
			end)
		end
	end
end

function YearCardLotteryView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "yearcardlotteryview")
end

function YearCardLotteryView:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId)
	end
end

function YearCardLotteryView:_onClickInfo()
	ViewAutoShowController.instance:saveCurModalView()
	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, self.skinId)
end

function YearCardLotteryView:_createEff(effPath, effParent, effKey, isLoop)
	self._exictEffs = self._exictEffs or {}

	if not effParent then
		return
	end

	local exictEff = self._exictEffs[effKey]

	if exictEff then
		UIEffectManager.instance:stopEffect(exictEff)

		self._exictEffs[effKey] = nil
	end

	self._exictEffs[effKey] = UIEffectManager.instance:playEffect(self, effPath, effParent.transform, 0, 0, isLoop, false, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
	end)
end

function YearCardLotteryView:_removeAllEffect()
	if self._exictEffs then
		for _, eff in pairs(self._exictEffs) do
			UIEffectManager.instance:stopEffect(eff)
		end

		self._exictEffs = nil
	end
end

function YearCardLotteryView:_removeEffect(key)
	if self._exictEffs then
		if self._exictEffs then
			UIEffectManager.instance:stopEffect(self._exictEffs)

			self._exictEffs[key] = nil
		end
	end
end

function YearCardLotteryView:_playEffAni()
	self:_createEff("20211231/qiandao/fx_ui_xuyuan_dianji.prefab", self._btnLottery.gameObject, "clickEff", false)
	self:_playRotateEffs()
end

function YearCardLotteryView:_playRotateEffs()
	self._playPrizeEffIds = self:_getRotateEffIds()
	self._curEffId = 1

	settimer(0.6, self._playSingleRotateEff, self, true)
end

function YearCardLotteryView:_playSingleRotateEff()
	local effId = self._playPrizeEffIds[self._curEffId]

	if effId then
		if self._curEffId == #self._playPrizeEffIds then
			self:_createEff("20211231/qiandao/fx_ui_xuyuan_jiangli.prefab", self._prizeList[effId].eff, "prizeEff" .. effId, false)
		else
			self:_createEff("20211231/qiandao/fx_ui_xuyuan_liang.prefab", self._prizeList[effId].eff, "prizeEff" .. effId, false)
		end

		self._curEffId = 1 + self._curEffId
	else
		removetimer(self._playSingleRotateEff, self)
		YearCardLotteryModel.instance:showCI(self._actId)
		self:_refreshView()

		self._isLotterying = false
	end
end

function YearCardLotteryView:_getRotateEffIds()
	local unGainedPrizeIds = {}

	for i, v in pairs(self._prizeList) do
		if not v.isGain then
			table.insert(unGainedPrizeIds, i)
		end
	end

	local effCount = math.min(#unGainedPrizeIds, 5)

	math.randomseed(os.time())

	for i = 1, #unGainedPrizeIds do
		local randomNum = math.random(i, #unGainedPrizeIds)

		unGainedPrizeIds[i] = unGainedPrizeIds[randomNum]
		unGainedPrizeIds[randomNum] = unGainedPrizeIds[i]
	end

	local effIds = {}

	for i = 1, effCount do
		table.insert(effIds, unGainedPrizeIds[i])
	end

	local info = YearCardLotteryModel.instance:getMsgInfo(self._actId)

	if checknumber(info.lastPrizeId) > 0 then
		table.insert(effIds, info.lastPrizeId)
	end

	return effIds
end

return YearCardLotteryView
