-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summerlottery/view/SummerLotteryMainView.lua

module("logic.extensions.summerlottery.view.SummerLotteryMainView", package.seeall)

local SummerLotteryMainView = class("SummerLotteryMainView", ViewComponent)
local EffectPath = "20220701/xiarijinli/fx_ui_xiarijinli_jm1.prefab"

function SummerLotteryMainView:ctor()
	SummerLotteryMainView.super.ctor(self)
end

function SummerLotteryMainView:unbindEvents()
	SummerLotteryMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTips)
	GameUtil.rmClickHandler(self._btnJackpot)
	GameUtil.rmClickHandler(self._btnTask)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._daibiAddBtn)
	GameUtil.rmClickHandler(self._equipItemKoi)
	GameUtil.rmClickHandler(self._btnPrizeTip)
	self._btnPrizeTipUiCustonInput:RemoveListener()
end

function SummerLotteryMainView:bindEvents()
	SummerLotteryMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnJackpot, self._onClickJackPot, self)
	GameUtil.addClickHandler(self._btnTask, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._daibiAddBtn, self._onClickDaibiAddBtn, self)
	GameUtil.addClickHandler(self._equipItemKoi, self._onClickKoiItem, self)
	GameUtil.addClickHandler(self._btnPrizeTip, self._onClickBtnPrizeTip, self)
	self._btnPrizeTipUiCustonInput:AddListener(self._uiCustonInputChange, self)
end

function SummerLotteryMainView:buildUI()
	SummerLotteryMainView.super.buildUI(self)

	self._btnClose = self:getBtn("upShowTran/viewCloseBtn")
	self._txtTime = self:getTxt("upShowTran/viewTimeGo/timeTxt")
	self._btnTips = self:getBtn("upShowTran/viewNameTxt/tipsBtn")
	self._txtTip = self:getTxt("viewDownGo/txtTip")
	self._txtTipGo = self:getGo("viewDownGo/txtTip")
	self._btnLottery = self:getBtn("viewDownGo/lotteryBtn")
	self._btnPrizeTip = self:getGo("mainTranGo/equipItem_1/name/btnTip")
	self._btnPrizeTipUiCustonInput = UICustomInput.Get(self._btnPrizeTip.gameObject)
	self._bubble = self:getGo("mainTranGo/equipItem_1/name/btnTip/bubble")
	self._bubbleDesc = self:getTxt("mainTranGo/equipItem_1/name/btnTip/bubble/tableview/Viewport/Content/txtDesc")
	self._btnJackpot = self:getBtn("viewDownGo/JackpotBtn")
	self._btnTask = self:getBtn("viewDownGo/TaskBtn")
	self._imgCount = self:getGo("viewDownGo/countGo/countIma")
	self._txtCount = self:getTxt("viewDownGo/countGo/countTxt")
	self._btnTaskRed = self:getGo("viewDownGo/TaskBtn/dot")
	self._btnLotteryRed = self:getGo("viewDownGo/lotteryBtn/dot")
	self._daibiIconIma = self:getGo("upShowTran/daibiItem/daibiIconIma")
	self._daibiCountTxt = self:getTxt("upShowTran/daibiItem/daibiCountTxt")
	self._daibiAddBtn = self:getBtn("upShowTran/daibiItem/daibiAddBtn")
	self._effectGo = self:getGo("effect")
	self._btnShop = self:getBtn("btnShop")
	self._equipItemKoi = self:getGo("mainTranGo/equipItemKoi")
	self._txtKoiName = goutil.findChildTextComponent(self._equipItemKoi, "name/txt")
	self._txtKoiNum = goutil.findChildTextComponent(self._equipItemKoi, "txtNum")
	self._receiveGo = goutil.findChild(self._equipItemKoi, "receive")
	self._koiImgs = {}

	local koiPrizePlanId = SummerLotteryModel.instance.poolConfig.koiPrizePlanId
	local confs = SummerLotteryConfig.instance:getKoiPrizes(koiPrizePlanId) or {}

	for i = 1, #confs do
		local imgGo = goutil.findChild(self._equipItemKoi, string.format("equipIma_%s", i))

		if imgGo then
			local img = imgGo:GetComponent("Image")

			if img then
				GameUtil.SetActive(img, false)
				table.insert(self._koiImgs, img)
			end
		end
	end

	self._equipItems = {}

	for i = 1, 7 do
		local item = self:getGo(string.format("mainTranGo/equipItem_%d", i))

		table.insert(self._equipItems, item)
	end
end

function SummerLotteryMainView:onExit()
	SummerLotteryMainView.super.onExit(self)
	SummerLotteryController.instance:unregisterLocalNotify(SummerLotteryController.E_GetInfoRes, self._updateAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialItemChange, self._updateMaterialCountShow, self)
	MaterialMgr.clearIcon(self._imgCount)

	for i, item in ipairs(self._equipItems) do
		local equipIma = goutil.findChild(item, "equipIma")

		MaterialMgr.clearIcon(equipIma)
		GameUtil.rmClickHandler(GameUtil.asBtn(item))
	end

	self._loopRoller:dispose()
	RedPointController.instance:unregRedPoint(self._btnTaskRed)
	RedPointController.instance:unregRedPoint(self._btnLotteryRed)
	self:_removeBgEffect()
	MaterialMgr.clearIcon(self._daibiIconIma)

	if self._koiPrizeTween then
		self._koiPrizeTween:Kill(false)

		self._koiPrizeTween = nil
	end
end

function SummerLotteryMainView:onEnter()
	SummerLotteryMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self._updateMaterialCountShow, self)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_SUMMER_LOTTERY_LOGIN, false)
	SummerLotteryController.instance:registerLocalNotify(SummerLotteryController.E_GetInfoRes, self._updateAll, self)

	self._activityId = SummerLotteryModel.instance:getActivityId()

	if self._activityId <= 0 then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	local model = SummerLotteryModel.instance
	local matType, id, matNum = MaterialMgr.getMatParams(model.poolConfig.lotteryCost)

	MaterialMgr.setIcon(self._imgCount, matType, id)

	self._txtCount.text = tostring(matNum)

	MaterialMgr.setIcon(self._daibiIconIma, matType, id)
	self:_initActivityTimeText()

	self._loopRoller = self._loopRoller or LoopRoller.New(self:getGo("luckyRankGo"))

	self._loopRoller:init({
		margin = 4,
		updateCellFunc = self._updateRollerCell,
		removeCellFunc = self._removeRollerCell,
		thisArg = self,
		direction = LoopRoller.Direction_B2T,
		weekAlign = LoopRoller.WeekAlign_MiddleOrCenter,
		speed = checknumber(SummerLotteryConfig.instance:getCommonValue("RollerSpeed"))
	})
	SummerLotteryController.instance:reqGetInfo()
	goutil.setActive(self._btnTaskRed, false)
	RedPointController.instance:regRedPoint(self._btnTaskRed, 290)
	RedPointController.instance:regRedPoint(self._btnLotteryRed, 287)
	self:_playBgEffect()
	self:_updateToken()

	self._curFrame = 1

	self:_doKoiDisappearTween()

	self._bubbleDesc.text = lang("summer_prize_1")
end

function SummerLotteryMainView:_updateMaterialCountShow(mo)
	local model = SummerLotteryModel.instance

	if mo and mo.type == model.lotteryCostMaterial.matType and mo.id == model.lotteryCostMaterial.matId then
		self:_updateToken()
	end
end

function SummerLotteryMainView:_updateToken()
	local model = SummerLotteryModel.instance
	local have = MaterialMgr.getMatCount(model.poolConfig.lotteryCost)

	self._daibiCountTxt.text = tostring(have)
end

function SummerLotteryMainView:_updateRollerCell(item, data, index)
	local koiName = data.name
	local userId = data.userId
	local koiPrizePlanId = SummerLotteryModel.instance.poolConfig.koiPrizePlanId
	local config = SummerLotteryConfig.instance:getKoiPrize(koiPrizePlanId, data.koiPrizeId) or {}
	local txtDesc = goutil.findChildTextComponent(item, "txtDesc")
	local txtName = goutil.findChildTextComponent(item, "txtName")
	local clickGo = goutil.findChild(item, "txtName/click")

	txtName.text = koiName
	txtDesc.text = config.name or ""

	GameUtil.rmClickHandler(clickGo)
	GameUtil.addClickHandler(clickGo, function()
		if userId ~= nil then
			FriendController.instance:showInfoView(userId, txtName.gameObject)
		end
	end, self)
end

function SummerLotteryMainView:_removeRollerCell(item)
	local clickGo = goutil.findChild(item, "txtName/click")

	GameUtil.rmClickHandler(clickGo)
end

function SummerLotteryMainView:_initActivityTimeText()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SUMMER_LOTTERY, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function SummerLotteryMainView:_updateAll()
	local model = SummerLotteryModel.instance

	self._loopRoller:reload(model.koiInfos or {})
	self._loopRoller:play()
	goutil.setActive(self._txtTipGo, not model:isGainAllLargePrizeWithKoi())

	self._txtTip.text = langPara("SummerLotteryMainView__1", model:getRemain2NextLargePrize())

	self:_updateLargePrize()
end

function SummerLotteryMainView:_updateLargePrize()
	local configInstance = SummerLotteryConfig.instance
	local model = SummerLotteryModel.instance
	local poolPrizePlanId = model.poolConfig.poolPrizePlanId

	for i, item in ipairs(self._equipItems) do
		local conf = configInstance:getPrizeShowConfByGroupId(poolPrizePlanId, i)

		if conf then
			GameUtil.SetActive(item, true)
			self:_updateOneLargePrize(item, conf, i)
		else
			GameUtil.SetActive(item, false)
		end
	end

	self:_updateKoiPrize()
end

function SummerLotteryMainView:_doKoiAppearTween()
	local img = self._koiImgs[self._curFrame]

	Game.ImageUtil.SetImageAlpha(img, 0)
	self:_updateKoiPrize()

	local function updateTween(num)
		Game.ImageUtil.SetImageAlpha(img, num)
	end

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:Append(TweenUtil.DOTweenNum(0, 1, 0.6, updateTween, {}))
	sequence:OnComplete(function()
		Game.ImageUtil.SetImageAlpha(img, 1)
		self:_doKoiDisappearTween()
	end)

	self._koiPrizeTween = sequence
end

function SummerLotteryMainView:_doKoiDisappearTween()
	local img = self._koiImgs[self._curFrame]

	self:_updateKoiPrize()

	local function updateTween(num)
		Game.ImageUtil.SetImageAlpha(img, num)
	end

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:SetDelay(2)
	sequence:Append(TweenUtil.DOTweenNum(1, 0, 0.6, updateTween, {}))
	sequence:OnComplete(function()
		self._curFrame = self._curFrame + 1

		if self._curFrame > #self._koiImgs then
			self._curFrame = 1
		end

		Game.ImageUtil.SetImageAlpha(img, 1)
		self:_doKoiAppearTween()
	end)

	self._koiPrizeTween = sequence
end

function SummerLotteryMainView:_updateKoiPrize()
	local model = SummerLotteryModel.instance
	local koiPrizePlanId = model.poolConfig.koiPrizePlanId
	local conf = SummerLotteryConfig.instance:getKoiPrize(koiPrizePlanId, self._curFrame) or {}

	goutil.setActive(self._receiveGo, model.koiPrizeId == self._curFrame)

	self._txtKoiName.text = conf.name
	self._txtKoiNum.text = langPara("剩余：%d", math.max(model:getRemainKoiNum(self._curFrame), 0))

	for i, img in ipairs(self._koiImgs) do
		GameUtil.SetActive(img, self._curFrame == i)
	end
end

function SummerLotteryMainView:_updateOneLargePrize(item, conf, groupId)
	local equipIma = goutil.findChild(item, "equipIma")
	local receive = goutil.findChild(item, "receive")
	local txtNum = goutil.findChildTextComponent(item, "txtNum")
	local txtName = goutil.findChildTextComponent(item, "name/txt")
	local model = SummerLotteryModel.instance

	MaterialMgr.clearIcon(equipIma)

	if conf then
		local matType, id, _ = MaterialMgr.getMatParams(conf.prize)
		local cfg = MaterialMgr.getMatCfg(matType, id)

		if cfg then
			MaterialMgr.setIcon(equipIma, matType, id)

			txtName.text = conf.name
		end
	end

	local remainCount = model:getRemainByGroupId(groupId)

	if remainCount == nil then
		goutil.setActive(item, false)
	else
		goutil.setActive(item, true)
		goutil.setActive(receive, remainCount <= 0)

		txtNum.text = langPara("剩余：%d", math.max(remainCount, 0))
	end

	GameUtil.rmClickHandler(GameUtil.asBtn(item))
	GameUtil.addClickHandler(GameUtil.asBtn(item), function()
		if conf then
			local matType, id, _ = MaterialMgr.getMatParams(conf.prize)

			CommonTipsMgr.instance:openMaterialTips(item, matType, id, 0)
		end
	end)
end

function SummerLotteryMainView:_showSetLotteryNumWindow(callback)
	local model = SummerLotteryModel.instance
	local poolConfig = model.poolConfig

	UIStateManager.instance:push(ViewName.SummerLotteryBuyView, {
		notEnoughItemTips = "SummerLotteryBuyView__3",
		lotteryCost = poolConfig.lotteryCost,
		dailyLimit = poolConfig.dailyLimit,
		onceLimit = poolConfig.onceLimit,
		dailyTime = model.dailyTimes,
		questions = lang("SummerLotteryBuyView__2"),
		title = lang("SummerLotteryBuyView__1"),
		onConfirmFunc = callback
	})
end

function SummerLotteryMainView:_playBgEffect()
	self:_removeBgEffect()

	local uiEffect = UIEffectManager.instance:playEffect(self, EffectPath, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function SummerLotteryMainView:_removeBgEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function SummerLotteryMainView:_onClickJackPot()
	SurveyController.instance:reportBehavior(201014)
	UIStateManager.instance:push(ViewName.PrizeLotteryExplainView, SummerLotteryModel.instance.poolConfig.explainId)
end

function SummerLotteryMainView:_onClickTask()
	SurveyController.instance:reportBehavior(201015)
	UIStateManager.instance:push(ViewName.SummerLotteryTaskView)
end

function SummerLotteryMainView:_onClickLottery()
	if SummerLotteryController.instance.bDrawing then
		return
	end

	self:_showSetLotteryNumWindow(function(times)
		SummerLotteryController.instance:reqDraw(times)
	end)
end

function SummerLotteryMainView:_onClickTips()
	UIStateManager.instance:push(ViewName.RulesView, "summerlottery_rule")
end

function SummerLotteryMainView:_onClickShop()
	GotoMgr.gotoByString("func#701")
end

function SummerLotteryMainView:_onClickDaibiAddBtn()
	local model = SummerLotteryModel.instance

	MaterialMgr.openGetSourceByStr(model.poolConfig.lotteryCost)
end

function SummerLotteryMainView:_onClickBtnPrizeTip()
	GameUtil.SetActive(self._bubble, not GameUtil.GetActive(self._bubble))
end

function SummerLotteryMainView:_uiCustonInputChange(isHover)
	if isHover == false then
		GameUtil.SetActive(self._bubble, false)
	end
end

function SummerLotteryMainView:_onClickKoiItem()
	if self._curFrame then
		local koiPrizePlanId = SummerLotteryModel.instance.poolConfig.koiPrizePlanId
		local conf = SummerLotteryConfig.instance:getKoiPrize(koiPrizePlanId, self._curFrame) or {}

		if conf then
			local matType, id, _ = MaterialMgr.getMatParams(conf.prize)

			CommonTipsMgr.instance:openMaterialTips(self._equipItemKoi, matType, id, 0)
		end
	end
end

return SummerLotteryMainView
