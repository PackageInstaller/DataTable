-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolamengmeng/view/DuoLaMainView.lua

module("logic.extensions.duolamengmeng.view.DuoLaMainView", package.seeall)

local DuoLaMainView = class("DuoLaMainView", ViewComponent)
local EVOLUTION_STATE_NO = 1
local EVOLUTION_STATE_READY = 2
local EVOLUTION_STATE_OPEN = 3
local EVOLUTION_STATE_DONE = 4

function DuoLaMainView:ctor()
	DuoLaMainView.super.ctor(self)
end

function DuoLaMainView:buildUI()
	DuoLaMainView.super.buildUI(self)

	self._challengeId = 6
	self._btnClose = self:getBtn("btnClose")
	self._getChip = self:getGo("getChip")
	self._goChip = self:getGo("chip")
	self._btnGame = self:getBtn("getChip/btnGetChip")
	self._btnAddGameTime = self:getBtn("getChip/num/add")
	self._txtNum = self:getTxt("getChip/num/txtNum")
	self._btnRank = self:getBtn("btnRank")
	self._btnTip = self:getBtn("btnTip")
	self._pieces = {}

	for i = 1, DuolaMMmodel.PIECE_NUM do
		local obj = {}

		obj.num = self:getTxt("chip/chip" .. i .. "/txtNum")
		obj.btn = self:getBtn("chip/chip" .. i .. "/btnAdd")
		obj.icon = self:getGo("chip/chip" .. i .. "/icon")

		table.insert(self._pieces, obj)
	end

	self._btnInfo = self:getBtn("info/btnInfo")
	self._btnChallenge = self:getBtn("info/btnSkill")
	self._txtTime = self:getTxt("txtTime")
	self._imgGained = self:getGo("imgGained")
	self._btnEvolution = self:getBtn("btnEvolution")
	self._roleModel = self:getGo("roleModel")
	self._rarePoint = self:getGo("info/rare")
	self._getGoEffect = self:getGo("getChip/getEffect")
	self._mainGoEffect = self:getGo("mainEffect")
	self.btnShop = self:getGo("btnShop")
	self.head = self:getGo("btnShop/head")
end

function DuoLaMainView:bindEvents()
	DuoLaMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._clickClose, self)
	self._btnGame:AddClickListener(self._sendGameKey, self)
	self._btnAddGameTime:AddClickListener(self._addGameTime, self)
	self._btnRank:AddClickListener(self._clickRank, self)
	self._btnTip:AddClickListener(self._clickTip, self)
	self._btnChallenge:AddClickListener(self._onClickSkillExplain, self)
	self._btnInfo:AddClickListener(self._onClickPetinfoExplain, self)
	self._btnEvolution:AddClickListener(self._startEvolution, self)

	for i = 1, DuolaMMmodel.PIECE_NUM do
		self._pieces[i].btn:AddClickListener(function()
			self:_buyPieceNum(i)
		end)
	end

	GameUtil.addClickHandler(self.btnShop, self.onClickShop, self)
end

function DuoLaMainView:unbindEvents()
	DuoLaMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnGame:RemoveClickListener()
	self._btnAddGameTime:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnEvolution:RemoveClickListener()

	for i = 1, DuolaMMmodel.PIECE_NUM do
		self._pieces[i].btn:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self.btnShop)
end

function DuoLaMainView:destroyUI()
	DuoLaMainView.super.destroyUI(self)
end

function DuoLaMainView:onEnter()
	DuoLaMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DuoLaMMDataRefresh, self._refresh, self)
	GlobalDispatcher:addListener(DuoLaMMClgAgent.PM_DuoLaMMClgStartGameRes, self._startGame, self)
	GlobalDispatcher:addListener(GlobalNotify.DuoLaMMGameTimesDataRefresh, self._handleBuyGameTimes, self)

	self._freeTimes = checknumber(DuolaMMconfig.instance:getCommonCfg("DAILY_FREE_GAME_TIMES"))
	self._timeLimitedCfg = TimeLimitedConfig.instance:getCfgById(6)
	self._raceId = self._timeLimitedCfg.raceId

	local scale = 0.8

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, self._raceId, self._roleModel, scale, nil, nil, 0, 0)

	local path = "fx_ui_duolamengmengtiaozhan/fx_ui_duolamengmeng_mianban.prefab"

	self._mainEffect = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._mainEffect:setParent(self._mainGoEffect.transform)
	self._mainEffect:setScale(1)

	self._mainEffect.hideEffWhileNotOnTop = true

	local path2 = "fx_ui_duolamengmengtiaozhan/fx_ui_duolamengmeng_anniu.prefab"

	self._btnEffect = UIEffectManager.instance:playEffect(self, path2, nil, 0, 0, true, nil, nil, function(finishHandlerTarget, eff)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
	end)

	self._btnEffect:setParent(self._getGoEffect.transform)
	self._btnEffect:setScale(1)

	self._btnEffect.hideEffWhileNotOnTop = true

	if DuolaMMmodel.instance:getHasGetData() then
		self:_refresh()
	else
		DuolaMMcontroller.instance:getInfo()
	end

	local root = GameEnum.RankType.DuolaMM_RANK
	local leaf = 0

	if not RankModel.instance:getIsDataInit(root, leaf) then
		RankModel.instance:sendReqRankData(root, leaf)
	end

	if self._timeLimitedCfg then
		self._endTimeStamp = GameUtil.string2time(self._timeLimitedCfg.absoluteEndDay)

		self:_updateTime()
	end

	self:updateGoShop()
end

function DuoLaMainView:updateGoShop()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	local raceId = self._challengeCfg.raceId

	MaterialMgr.setIcon(self.head, MatType.Pet, raceId)
end

function DuoLaMainView:onClickShop()
	local goodsId = DuolaMMconfig.instance:getCommonCfg("GOODS_ID")

	PayShopController.instance:buyShopItemWithTips(goodsId)
end

function DuoLaMainView:onEnterFinished()
	DuoLaMainView.super.onEnterFinished(self)
end

function DuoLaMainView:onExit()
	DuoLaMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DuoLaMMDataRefresh, self._refresh, self)
	GlobalDispatcher:removeListener(DuoLaMMClgAgent.PM_DuoLaMMClgStartGameRes, self._startGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._goToEvolution, self)
	GlobalDispatcher:removeListener(GlobalNotify.DuoLaMMGameTimesDataRefresh, self._handleBuyGameTimes, self)

	for i = 1, DuolaMMmodel.PIECE_NUM do
		MaterialMgr.resetAll(self._pieces[i].icon)
	end

	MaterialMgr.resetAll(self._rarePoint)
	UIEffectManager.instance:stopEffect(self._mainEffect)
	UIEffectManager.instance:stopEffect(self._btnEffect)
	MaterialMgr.clearIcon(self.head)
end

function DuoLaMainView:onExitFinished()
	DuoLaMainView.super.onExitFinished(self)
end

function DuoLaMainView:_refresh()
	local buyGameTime = DuolaMMmodel.instance:getBuyGameTime()
	local playGameTime = DuolaMMmodel.instance:getPlayGameTime()
	local leftTime = math.max(0, buyGameTime + self._freeTimes - playGameTime)

	self._txtNum.text = langPara("今日剩余<color=#68F2FDFF>%s</color>次", leftTime)

	goutil.setActive(self._btnAddGameTime.gameObject, not (leftTime > 0))

	for i = 1, 3 do
		local buyCount = DuolaMMmodel.instance:getBuyCount(i)
		local gameCount = DuolaMMmodel.instance:getGameGainCount(i)
		local prizeCfg = DuolaMMconfig.instance:getPieceCfg()
		local maxNum = prizeCfg[i].gainLimit

		self._pieces[i].num.text = langPara("<size=28><color=#ffffff>%d</color></size>/%s", buyCount + gameCount, maxNum)

		local proxy = MaterialMgr.setCellByCfg(prizeCfg[i].gain, self._pieces[i].icon)

		proxy.binder:setBgActive(false)
		proxy.binder:setNumStr("")
	end

	local enoughEvolution = DuolaMMcontroller.instance:checkEnoughEvolution()

	self._evolutionState = EVOLUTION_STATE_NO

	if DuolaMMmodel.instance:getEverEvolvePet() then
		self._evolutionState = EVOLUTION_STATE_DONE
	elseif DuolaMMmodel.instance:getHasOpenEvolve() then
		self._evolutionState = EVOLUTION_STATE_OPEN
	elseif enoughEvolution then
		self._evolutionState = EVOLUTION_STATE_READY
	end

	self._goChip.gameObject:SetActive(self._evolutionState == EVOLUTION_STATE_NO)
	self._getChip.gameObject:SetActive(self._evolutionState == EVOLUTION_STATE_NO)
	self._btnEvolution.gameObject:SetActive(self._evolutionState ~= EVOLUTION_STATE_DONE)
	self._imgGained.gameObject:SetActive(self._evolutionState == EVOLUTION_STATE_DONE)

	local proxy = MaterialMgr.setCell(MatType.Rare, self._raceId, self._rarePoint)

	proxy.binder:setRare(GameEnum.PetRare.SSR)
end

function DuoLaMainView:_sendGameKey()
	local buyGameTime = DuolaMMmodel.instance:getBuyGameTime()
	local playGameTime = DuolaMMmodel.instance:getPlayGameTime()
	local leftTime = math.max(0, buyGameTime + self._freeTimes - playGameTime)

	if leftTime > 0 then
		local clientKey = ServerTime.nowServerLook()

		DuolaMMmodel.instance:setClienKey(clientKey)
		DuoLaMMClgAgent.instance:sendPM_DuoLaMMClgStartGameReq(clientKey)
	else
		local curBuyTime = DuolaMMmodel.instance:getBuyGameTime()
		local planId = checknumber(DuolaMMconfig.instance:getCommonCfg("GAME_BUY_TIMES_PLAN_ID"))
		local buyPriceCfg = DuolaMMconfig.instance:getBuyTimesCfg(planId, 1)
		local buyPriceList = {}

		for k, v in pairs(buyPriceCfg) do
			table.insert(buyPriceList, v)
		end

		local maxNum = #buyPriceList
		local leftBuyNum = checknumber(maxNum - curBuyTime)

		if leftBuyNum > 0 then
			FloatWordMgr.instance:show("游戏次数不足，可购买次数继续游戏")
		else
			FloatWordMgr.instance:show("今日没有游戏次数了")
		end
	end
end

function DuoLaMainView:_startGame(status, msg)
	if status == 0 then
		local gameId = checknumber(DuolaMMconfig.instance:getCommonCfg("GAME_PLAN_ID"))
		local gameCfg = DuolaMMconfig.instance:getGameCfg(gameId)
		local dropPlanCfg = DuolaMMconfig.instance:getDropPlanCfg()
		local prizeList = {}
		local prizeCfg = DuolaMMconfig.instance:getPieceCfg()

		for k, v in pairs(prizeCfg) do
			local matCfg = MaterialMgr.getMatCfgByStr(v.gain)
			local url = GameUrl.getItemIconUrl(matCfg.icon)

			prizeList[v.id] = {
				imgPath = url
			}
		end

		local function finishCallBack(priceResList)
			local serverResList = {}

			for k, v in pairs(priceResList) do
				for j = 1, v.num do
					table.insert(serverResList, k)
				end
			end

			local clientKey = DuolaMMmodel.instance:getClienKey()
			local serverKey = GenEncryptedKeyUtil.dxor(msg.serverKey, clientKey)
			local encryptedKey = 0

			for k, num in ipairs(serverResList) do
				encryptedKey = num % 2 == 0 and encryptedKey + (num + serverKey) * 5381 or encryptedKey + (num + clientKey) * 31
			end

			DuolaMMcontroller.instance:endGame(serverResList, encryptedKey)
		end

		local planId = checknumber(DuolaMMconfig.instance:getCommonCfg("GAME_BUY_TIMES_PLAN_ID"))
		local rebornCfg = DuolaMMconfig.instance:getBuyTimesCfg(planId, 2)

		local function rebornCallBack()
			DuolaMMcontroller.instance:sendReborn()
		end

		DuolaMMcontroller.instance:openDuolaGame(prizeList, gameCfg, dropPlanCfg, rebornCfg, rebornCallBack, finishCallBack)
	end
end

function DuoLaMainView:_addGameTime()
	local curBuyTime = DuolaMMmodel.instance:getBuyGameTime()
	local planId = checknumber(DuolaMMconfig.instance:getCommonCfg("GAME_BUY_TIMES_PLAN_ID"))
	local buyPriceCfg = DuolaMMconfig.instance:getBuyTimesCfg(planId, 1)
	local buyPriceList = {}

	for k, v in pairs(buyPriceCfg) do
		table.insert(buyPriceList, v)
	end

	local maxNum = #buyPriceList
	local leftNum = checknumber(maxNum - curBuyTime)

	if leftNum > 0 then
		local strConsume = buyPriceCfg[curBuyTime + 1].consume
		local price = string.split(strConsume, ":")[3]
		local str = langPara("确定要花费%s钻石购买游戏次数吗？\n每天最多购买%d次，还能购买%d次", price, maxNum, leftNum)

		TipsFacade.instance:openPopupCostDiamondView(price, str, function()
			DuolaMMcontroller.instance:buyGameTimes()
		end, nil, nil, nil, function(tips)
			if tips == TipsFacade.STATE_FAIL then
				FloatWordMgr.instance:show("购买所需钻石不足")
			end
		end)
	else
		FloatWordMgr.instance:show("今日购买已达上限，次日5点刷新购买次数")
	end
end

function DuoLaMainView:_buyPieceNum(id)
	local prizeCfg = DuolaMMconfig.instance:getPieceCfg()
	local cfg = prizeCfg[id]
	local maxGainNum = cfg.gainLimit
	local maxBuyNum = cfg.buyLimit
	local buyCount = DuolaMMmodel.instance:getBuyCount(id)
	local gameCount = DuolaMMmodel.instance:getGameGainCount(id)
	local leftBuyNum = math.min(checknumber(maxGainNum - buyCount - gameCount), checknumber(maxBuyNum - buyCount))
	local str = langPara("最多可购买%s个", leftBuyNum)

	if leftBuyNum <= 0 then
		FloatWordMgr.instance:show("碎片已达到购买上限！")
	else
		TipsFacade.instance:openPopupCostManyView(cfg.gain, cfg.consume, leftBuyNum, str, nil, function(count)
			DuolaMMcontroller.instance:buyPiece(id, count)
		end)
	end
end

function DuoLaMainView:_clickRank()
	UIStateManager.instance:push(ViewName.DuolaMMRankView)
end

function DuoLaMainView:_clickTip()
	UIStateManager.instance:push(ViewName.RulesView, "duolammrule")
end

function DuoLaMainView:_onClickPetinfoExplain()
	PetbookController.instance:openPetinfoView(self._raceId)
end

function DuoLaMainView:_onClickSkillExplain()
	PetbookController.instance:previewBattle(self._raceId)
end

function DuoLaMainView:_updateTime()
	local diff = self._endTimeStamp - ServerTime.now()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(diff)

	self._txtTime.text = diff < 0 and langPara("活动已结束") or langPara("剩余时间：\n%d天%d小时%d分", day, hour, min)
end

function DuoLaMainView:_clickClose()
	self:close()
end

function DuoLaMainView:_startEvolution()
	if self._evolutionState == EVOLUTION_STATE_DONE then
		-- block empty
	elseif self._evolutionState == EVOLUTION_STATE_READY then
		GlobalDispatcher:addListener(GlobalNotify.OnMaterialPopEnd, self._goToEvolution, self)
		DuoLaMMClgAgent.instance:sendPM_DuoLaMMClgOpenEvolveReq(function()
			DuolaMMmodel.instance:setHasOpenEvolve(true)
			self:_refresh()
			self:_goToEvolution()
		end)
	elseif self._evolutionState == EVOLUTION_STATE_OPEN or self._evolutionState == EVOLUTION_STATE_NO then
		self:_goToEvolution()
	end
end

function DuoLaMainView:_goToEvolution()
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialPopEnd, self._goToEvolution, self)

	local evolveMo = EvolveMo.New()
	local preId = checknumber(DuolaMMconfig.instance:getCommonCfg("EVOLVE_PET_RACE_ID"))
	local postId = self._raceId

	evolveMo:setParamById(preId, postId)
	UIStateManager.instance:push(ViewName.Evolve, evolveMo)
end

function DuoLaMainView:_handleBuyGameTimes(status)
	if checknumber(status) == 0 then
		FloatWordMgr.instance:show("购买成功")
		self:_refresh()
	end
end

return DuoLaMainView
