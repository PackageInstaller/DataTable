-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jisummoner/view/JiSummonerLotteryView.lua

module("logic.extensions.jisummoner.view.JiSummonerLotteryView", package.seeall)

local JiSummonerLotteryView = class("JiSummonerLotteryView", ViewComponent)

function JiSummonerLotteryView:ctor()
	JiSummonerLotteryView.super.ctor(self)

	self._progressCfgs = nil
end

function JiSummonerLotteryView:bindEvents()
	JiSummonerLotteryView.super.bindEvents(self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(JiSummonerController.instance.jiPetRaceId)
	end, self)
	self._infoBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(JiSummonerController.instance.jiPetRaceId)
	end, self)
	self._lotteryBtn:AddClickListener(function()
		if checknumber(self._lotteryTime) > 0 then
			FloatWordMgr.instance:show(lang("text_dragon_desc_7"))

			return
		end

		local params = {
			actId = self._paramCfg.poolActyId,
			dailyTime = self._baseInfo.dailyTime,
			poolCfg = self._poolCfg
		}

		UIStateManager.instance:push(ViewName.DragonBuy, params)
	end, self)
	self._bonusBtn:AddClickListener(function()
		FuncOpenController.instance:openFunc(191, GameEnum.ActivityType.JiSummoner, self._paramCfg.activityId)
	end, self)
	self._juexingBtn:AddClickListener(function()
		PetAwakenVerificationController.instance:gotoPetAwakenByKey("jisummoner")
	end, self)
	self._JackpotBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.DragonPreview, self._poolCfg)
	end, self)
	self._progressBtn:AddClickListener(function()
		local params = {
			bgPath = "ui/bigbg/zhaohuan/zhaohuan_jindu_ji.png",
			itemList = self._progressCfgs,
			progressCount = self._baseInfo.totalTimes
		}

		UIStateManager.instance:push(ViewName.JiSummonerPrize, params)
	end, self)
	self._gotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.JiSummonerGift, self._paramCfg, self._shopTime)
	end, self)
end

function JiSummonerLotteryView:unbindEvents()
	JiSummonerLotteryView.super.unbindEvents(self)
	self._skillBtn:RemoveClickListener()
	self._infoBtn:RemoveClickListener()
	self._lotteryBtn:RemoveClickListener()
	self._bonusBtn:RemoveClickListener()
	self._juexingBtn:RemoveClickListener()
	self._JackpotBtn:RemoveClickListener()
	self._progressBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
end

function JiSummonerLotteryView:onExit()
	JiSummonerLotteryView.super.onExit(self)
	removetimer(self._calculationSurplusTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataDragonInfo, self._updataViewProgressInfo, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._handleNotifyPayResultRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataDragonInfo, self._updataViewProgressInfo, self)

	self._progressCfgs = nil
	self._lotteryTime = nil
	self._shopTime = nil

	PetAwakenVerificationController.instance:unRegRedAboutPetAwken(self._jxRedpoint)
end

function JiSummonerLotteryView:destroyUI()
	JiSummonerLotteryView.super.destroyUI(self)

	for _, item in pairs(self._goodsItems or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	self._goodsItems = nil

	uGuiUtil.clearImage(self._countImaGo)
	MaterialMgr.resetAll(self._goodsGo)
end

function JiSummonerLotteryView:buildUI()
	JiSummonerLotteryView.super.buildUI(self)

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._petNameTxt = goutil.findChildTextComponent(sprintInfoGo, "petNameTxt")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "skillBtn")
	self._infoBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "infoBtn")

	local viewDownGo = self:getGo("viewDownGo")

	self._cycleNum_1 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_1"):GetComponent("UIImageSpriteChange")
	self._cycleNum_2 = goutil.findChild(viewDownGo, "cycleCountGo/cycleNum_2"):GetComponent("UIImageSpriteChange")
	self._lotteryBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "lotteryBtn")
	self._countImaGo = goutil.findChild(viewDownGo, "countGo/countIma")
	self._countTxt = goutil.findChild(viewDownGo, "countGo/countTxt"):GetComponent("Text")
	self._bonusBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "bonusBtn")
	self._juexingBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "juexingBtn")
	self._jxRedpoint = goutil.findChild(viewDownGo, "juexingBtn/jxRedpoint")
	self._JackpotBtn = Framework.ButtonAdapter.GetFrom(viewDownGo, "JackpotBtn")
	self._openTimeGo = goutil.findChild(viewDownGo, "openTimeGo")
	self._openTimeTxt = goutil.findChildTextComponent(self._openTimeGo, "openTimeTxt")

	local progressGo = self:getGo("progressGo")

	self._proogSlid = goutil.findChild(progressGo, "proogSlid"):GetComponent("Slider")
	self._proogTxt = goutil.findChild(progressGo, "proogTxt"):GetComponent("Text")
	self._startTxt = goutil.findChild(progressGo, "startTxt"):GetComponent("Text")
	self._endTxt = goutil.findChild(progressGo, "endTxt"):GetComponent("Text")
	self._finishTxt = goutil.findChild(progressGo, "finishTxt"):GetComponent("Text")
	self._progressBtn = Framework.ButtonAdapter.GetFrom(progressGo, "progressBtn")
	self._goodsGo = goutil.findChild(progressGo, "goodsGo")
	self._discountGo = self:getGo("discountGo")
	self._goodsItems = {
		goutil.findChild(self._discountGo, "allGoodsTran/goodsGo_1"),
		goutil.findChild(self._discountGo, "allGoodsTran/goodsGo_2"),
		goutil.findChild(self._discountGo, "allGoodsTran/goodsGo_3")
	}
	self._gotoBtn = Framework.ButtonAdapter.GetFrom(self._discountGo, "gotoBtn")
	self._sellOutGo = goutil.findChild(self._discountGo, "sellOutGo")
	self._tagTxt = goutil.findChildTextComponent(self._discountGo, "tagGo/tagTxt")
	self._openTimeTxt.text = ""
	self._tagTxt.text = ""

	GameUtil.SetActive(self._openTimeGo, false)
	GameUtil.SetActive(self._jxRedpoint, false)
end

function JiSummonerLotteryView:onEnter()
	JiSummonerLotteryView.super.onEnter(self)

	self._paramCfg = self:getFirstParam()

	if self._paramCfg == nil then
		printError("sr----  JiSummonerLotteryView:onEnter() y运营-极召唤师    未传入参数！！")

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataDragonInfo, self._updataViewProgressInfo, self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._handleNotifyPayResultRes, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataDragonInfo, self._updataViewProgressInfo, self)

	local actCfg = DragonConfig.instance:getActivityCfg(112006)

	if actCfg then
		if not actCfg.poolGroupId then
			local groupId = 6

			self._poolCfg = DragonConfig.instance:getDragonPoolCfg(groupId)

			MaterialMgr.updateItemByStr(self._countImaGo, self._poolCfg.lotteryCost, self._countTxt)

			self._petNameTxt.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._paramCfg.skinId)
			self._lotteryTime = 0
			self._shopTime = 0

			self:_showActivityTimer()
			self:_updataViewProgressInfo()

			if checknumber(self._lotteryTime) > 0 then
				return
			end

			PetAwakenVerificationController.instance:regRedAboutPetAwken(self._jxRedpoint, "jisummoner")
			DragonController.instance:csGodLotteryGetInfoReq(self._paramCfg.poolActyId, DragonController.DragonActType.JiSummoner)
		end
	end
end

function JiSummonerLotteryView:_showActivityTimer()
	GameUtil.SetActive(self._lotteryBtn, false)
	GameUtil.SetActive(self._bonusBtn, false)
	removetimer(self._calculationSurplusTime, self)

	local nowTime = ServerTime.now()

	if string.nilorempty(self._poolCfg.startTime) then
		GameUtil.SetActive(self._lotteryBtn, true)
		GameUtil.SetActive(self._bonusBtn, true)
		GameUtil.SetActive(self._openTimeGo, false)
	else
		local openTime = GameUtil.string2time(self._poolCfg.startTime)

		self._lotteryTime = openTime - nowTime

		if self._lotteryTime <= 0 then
			GameUtil.SetActive(self._lotteryBtn, true)
			GameUtil.SetActive(self._bonusBtn, true)
			GameUtil.SetActive(self._openTimeGo, false)
		end

		if self._lotteryTime > 0 then
			local time = GameUtil.time2date(openTime)

			self._openTimeTxt.text = string.format("%02d.%02d %s:00 开启", time.month, time.day, time.hour)

			GameUtil.SetActive(self._openTimeGo, true)
		end
	end

	self:_updataDiscountInfo(nowTime)

	if self._lotteryTime > 0 or self._shopTime > 0 then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function JiSummonerLotteryView:_calculationSurplusTime()
	if self._lotteryTime >= 0 then
		self._lotteryTime = self._lotteryTime - 1

		if self._lotteryTime <= 0 then
			GameUtil.SetActive(self._lotteryBtn, true)
			GameUtil.SetActive(self._bonusBtn, true)

			self._openTimeTxt.text = ""

			GameUtil.SetActive(self._openTimeGo, false)
		end
	end

	if self._shopTime >= 0 then
		self._shopTime = self._shopTime - 1

		if self._shopTime <= 0 then
			self._tagTxt.text = "0秒"

			for _, item in pairs(self._goodsItems or {}) do
				if item then
					MaterialMgr.resetAll(item)
				end
			end

			GameUtil.SetActive(self._discountGo, false)
		elseif self._shopTime >= 86400 then
			local d = math.ceil(self._shopTime / 86400)

			self._tagTxt.text = d .. "天"
		elseif self._shopTime >= 3600 then
			local h = math.ceil(self._shopTime / 3600)

			self._tagTxt.text = h .. "时"
		elseif self._shopTime >= 60 then
			local m = math.ceil(self._shopTime / 60)

			self._tagTxt.text = m .. "分"
		else
			self._tagTxt.text = self._shopTime .. "秒"
		end
	end

	if self._lotteryTime <= 0 and self._shopTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		return
	end
end

function JiSummonerLotteryView:_updataViewProgressInfo(str, param)
	self._baseInfo = DragonModel.instance:getDragonBaseInfo(DragonController.DragonActType.JiSummoner)

	self:_showCycleNumberInfo()
	self:_showProgressInfo()

	if checknumber(param) > 0 then
		ViewMgr.instance:open(ViewName.DragonEffect, param)
	end
end

function JiSummonerLotteryView:_showCycleNumberInfo()
	local supCount = self._poolCfg.floorTime - self._baseInfo.accumulateTime

	if supCount <= 0 then
		supCount = self._poolCfg.floorTime
	end

	GameUtil.SetActive(self._cycleNum_1, true)

	if supCount > 9 then
		GameUtil.SetActive(self._cycleNum_2, true)

		local shi = math.floor(supCount / 10)
		local ge = supCount - shi * 10

		self._cycleNum_1:SetState(shi)
		self._cycleNum_2:SetState(ge)
	else
		self._cycleNum_1:SetState(supCount)
		GameUtil.SetActive(self._cycleNum_2, false)
	end
end

function JiSummonerLotteryView:_showProgressInfo()
	if self._progressCfgs == nil or #self._progressCfgs == 0 then
		self._progressCfgs = {}

		local allCfgs = DragonConfig.instance:getDragonProgressCfgs(self._poolCfg.progressPlanId)

		for _, cfg in pairs(allCfgs or {}) do
			if cfg and not string.nilorempty(cfg.prize) then
				table.insert(self._progressCfgs, cfg)
			end
		end

		if #self._progressCfgs > 1 then
			ArraySort.sortOn(self._progressCfgs, "times")
		end
	end

	local isFinish = self._progressCfgs[#self._progressCfgs].times <= self._baseInfo.totalTimes

	MaterialMgr.resetAll(self._goodsGo)

	if isFinish then
		GameUtil.SetActive(self._proogSlid, false)

		self._proogTxt.text = ""
		self._startTxt.text = ""
		self._endTxt.text = ""
		self._finishTxt.text = "已完成所有奖励"

		GameUtil.SetActive(self._progressBtn, false)
	else
		self._finishTxt.text = ""

		GameUtil.SetActive(self._proogSlid, true)
		GameUtil.SetActive(self._progressBtn, true)

		local endNum = #self._progressCfgs

		for i = 1, #self._progressCfgs do
			if self._progressCfgs[i].times > self._baseInfo.totalTimes then
				endNum = i

				break
			end
		end

		local startNum = endNum - 1
		local count = self._progressCfgs[endNum].times

		self._proogTxt.text = string.format("再召唤%s次可获得", count - self._baseInfo.totalTimes)
		self._endTxt.text = tostring(count)

		if startNum <= 0 then
			self._startTxt.text = "0"
			self._proogSlid.value = self._baseInfo.totalTimes / count
		else
			self._startTxt.text = tostring(self._progressCfgs[startNum].times)
			self._proogSlid.value = (self._baseInfo.totalTimes - self._progressCfgs[startNum].times) / (count - self._progressCfgs[startNum].times)
		end

		MaterialMgr.setCellByCfg(self._progressCfgs[endNum].prize, self._goodsGo)
	end
end

function JiSummonerLotteryView:_updataDiscountInfo(nowTime)
	self._shopTime = 0

	for _, item in pairs(self._goodsItems or {}) do
		if item then
			MaterialMgr.resetAll(item)
		end
	end

	local shopId = checknumber(self._paramCfg.shopId)
	local shopCfg = PayShopConfig.instance:getPayShopGoodsCfgById(shopId)
	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(shopId)

	if shopCfg == nil or not isCanBuy then
		GameUtil.SetActive(self._discountGo, false)

		return
	end

	local startTime = GameUtil.string2time(shopCfg.onlineTime)
	local endTime = GameUtil.string2time(shopCfg.offlineTime)

	if nowTime < startTime or endTime <= nowTime then
		GameUtil.SetActive(self._discountGo, false)

		return
	end

	local times = PayShopModel.instance:getMibaoBuyTimesById(shopId)
	local isSellOut = shopCfg.limitType ~= "none" and shopCfg.limitTimes > 0 and checknumber(times) >= shopCfg.limitTimes

	self._shopTime = endTime - nowTime

	GameUtil.SetActive(self._discountGo, true)

	if isSellOut then
		GameUtil.SetActive(self._gotoBtn, false)
		GameUtil.SetActive(self._sellOutGo, true)
	else
		GameUtil.SetActive(self._sellOutGo, false)
		GameUtil.SetActive(self._gotoBtn, true)
	end

	local goodsList = {}

	if shopCfg and not string.nilorempty(shopCfg.content) then
		goodsList = string.split(shopCfg.content, "#")
	end

	for i = 1, #self._goodsItems do
		if goodsList and not string.nilorempty(goodsList[i]) then
			GameUtil.SetActive(self._goodsItems[i], true)
			MaterialMgr.setCellByCfg(goodsList[i], self._goodsItems[i])
		else
			GameUtil.SetActive(self._goodsItems[i], false)
		end
	end
end

function JiSummonerLotteryView:_handleNotifyPayResultRes()
	self:_updataDiscountInfo(ServerTime.now())
end

return JiSummonerLotteryView
