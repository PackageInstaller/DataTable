-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/directpurchase/view/LongNvPurchaseView.lua

module("logic.extensions.directpurchase.view.LongNvPurchaseView", package.seeall)

local LongNvPurchaseView = class("LongNvPurchaseView", ViewComponent)
local json = require("cjson")

LongNvPurchaseView.targetPetId = nil

function LongNvPurchaseView:buildUI()
	LongNvPurchaseView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._panel1 = self:getGo("panel1")
	self._btnIntroduce = self:getBtn("panel1/btnIntroduce")
	self._btnSkill = self:getBtn("panel1/btnSkill")
	self._btnBuy = self:getBtn("panel1/btnBuy")
	self._btnRecommend = self:getBtn("panel1/btnRecommend")
	self._recZdl = self:getGo("panel1/zdl/imgRecZdl"):GetComponent(typeof(UIImgNumeralText))
	self._txtTime1 = self:getTxt("panel1/txtTime")
	self._txtOldPrice = self:getTxt("panel1/btnBuy/txtOldPrice")
	self._txtPrice = self:getTxt("panel1/btnBuy/txtPrice")
	self._discountShopGo = self:getGo("panel1/discountShop")
	self._itemGo = self:getGo("panel1/discountShop/item")
	self._btnShop = self:getBtn("panel1/discountShop/btnShop")
	self._selloutGo = self:getGo("panel1/discountShop/btnShop/sellout")
	self._effectGo = self:getGo("panel1/discountShop/btnShop/effect")
	self._petItems = {}

	for i = 1, 9 do
		self._petItems[i] = self:getGo(string.format("panel1/btnRecommend/pet/stand%d/con", i))

		self._petItems[i].transform.parent.gameObject:SetActive(false)
	end

	self._txtPower = self:getTxt("panel1/btnRecommend/txtPower")
	self._tagRecordPos = self:getGo("panel1/btnRecommend/tagPos"):GetComponent(typeof(TestRecordPos))
	self._xinnian = self:getGo("panel1/xinian")
	self._discountTag = self:getGo("panel1/xinian/discountTag")
	self._discountTxt = self:getTxt("panel1/xinian/discountTag/txtDiscount")
	self._txtSlogan = self:getTxt("panel1/xinian/txtSlogan")
	self._txtDiscountTip = self:getGo("panel1/xinian/txtDiscountTip")
end

function LongNvPurchaseView:bindEvents()
	LongNvPurchaseView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnShop:AddClickListener(self._onClickShop, self)
	self._btnRecommend:AddClickListener(self._onClickRecommend, self)
end

function LongNvPurchaseView:unbindEvents()
	LongNvPurchaseView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnShop:RemoveClickListener()
	self._btnRecommend:RemoveClickListener()
end

function LongNvPurchaseView:onEnter()
	LongNvPurchaseView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PetDisplayEnd, self._onPetDisplayEnd, self)

	local param = self:getFirstParam()

	self._pageId = 1
	self._idList = {
		1,
		2,
		1,
		2,
		3
	}
	self._activityCfg = self:_getActivityCfg(self._pageId)

	self:_updateView()
	self:_setTxtPower()
	settimer(1, self._onSecond, self)
	PayRaceStrengthenAgent.instance:sendPM_PayRaceStrengthenInfoReq()
end

function LongNvPurchaseView:_getDirectPurchaseType()
	return GameEnum.ActivityType.DirectPurchase
end

function LongNvPurchaseView:_getActivityCfg(pageId)
	if pageId == 1 then
		return ActivityDefineController.instance:getActivityCfgByType(self:_getDirectPurchaseType())
	else
		return ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.DirectUp)
	end
end

function LongNvPurchaseView:onExit()
	LongNvPurchaseView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PetDisplayEnd, self._onPetDisplayEnd, self)
	removetimer(self._onSecond, self)
	self:_removeFmtIcons()
	self:_removeShopPetIcon()
end

function LongNvPurchaseView:_onClickClose()
	self:close()
end

function LongNvPurchaseView:_onClickBuy()
	if self._petDirectPurchaseCfg then
		local id = self._petDirectPurchaseCfg.shopItemId
		local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(id)

		if buyTimes > 0 then
			FloatWordMgr.instance:show("已售罄")
		else
			local data = {
				id = id,
				times = buyTimes
			}

			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
		end
	else
		printError("test 配置不存在，无法购买")
	end
end

function LongNvPurchaseView:_onClickIntroduce()
	local raceId = DirectPurchaseConfig.instance:getTargetRaceId(self._activityId)

	PetbookController.instance:openPetinfoView(raceId)
end

function LongNvPurchaseView:_onClickSkill()
	PetbookController.instance:previewBattle(self:_getRaceId())
end

function LongNvPurchaseView:_onClickShop()
	if self._petDirectPurchaseCfg then
		local id = self._petDirectPurchaseCfg.jumpShopId
		local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(id)

		if buyTimes > 0 then
			FloatWordMgr.instance:show("已售罄")
		else
			local data = {
				id = id,
				times = buyTimes
			}

			UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
		end
	else
		printError("test 配置不存在，无法购买")
	end
end

function LongNvPurchaseView:_onClickRecommend()
	local raceId = DirectPurchaseConfig.instance:getTargetRaceId(self._activityId)

	printInfo("test 点击推荐", raceId, type(raceId))
	PetbookController.instance:openPetinfoView(raceId)
end

function LongNvPurchaseView:_onBuySuccessRes()
	local id = PayRaceStrenthenModel.instance:getCurBuySuccessId()

	printInfo("test 够买成功 id = " .. id)
	self:_updatePanel2LevelUpBuyCount()
end

function LongNvPurchaseView:_onPetDisplayEnd()
	self:_updateView()
end

function LongNvPurchaseView:_onSecond()
	self:_updateTime()
end

function LongNvPurchaseView:_updateView()
	if self._activityCfg then
		self._activityId = self._activityCfg.activityId

		self:_updatePanel1()
		self:_updateTime()
	else
		self._panel1:SetActive(false)

		local function func()
			self:_onClickClose()
		end

		TipsFacade.instance:openTipWindowNoX(lang("tip"), "不在活动时间内", func, "知道了")
	end
end

function LongNvPurchaseView:_updatePanel1()
	self:_showAnim()
	self._panel1:SetActive(true)

	local cfg = DirectPurchaseConfig.instance:getDirectCfgById(self._activityId, 1)

	if cfg then
		self._petDirectPurchaseCfg = cfg

		self:_setZdlNum()
		self:_setFmtIcons()
		self:_setBtnBuy(cfg)
	end

	self:_setShopIcon()
end

function LongNvPurchaseView:_getAnimRecordName()
	return ViewName.LongNvPurchaseView
end

function LongNvPurchaseView:_showAnim()
	local isShowed = GameUtil.getUserDayData(self:_getAnimRecordName())

	if not isShowed then
		GameUtil.saveUserDayData(self:_getAnimRecordName(), true)

		local path = DirectPurchaseConfig.instance:getAnimPathById(self._activityId)

		AnimationPlayer.play(path)
	end
end

function LongNvPurchaseView:_getRaceId()
	return DirectPurchaseConfig.instance:getTargetRaceId(self._activityId)
end

function LongNvPurchaseView:_setBtnBuy(cfgDirect)
	local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(cfgDirect.shopItemId)
	local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(cfgDirect.shopItemId)
	local isDiscountTime = PayShopController.instance:checkTimeStr(goodsCfg.discountTime)

	GameUtil.SetGray(self._btnBuy, buyTimes > 0)
	goutil.setActive(self._txtOldPrice.gameObject, isDiscountTime and buyTimes <= 0)

	if buyTimes > 0 then
		self._txtPrice.text = "已售罄"
	else
		goutil.setActive(self._discountTag.gameObject, isDiscountTime)
		goutil.setActive(self._txtDiscountTip.gameObject, isDiscountTime)

		if isDiscountTime then
			local oldPrice = PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId)
			local Price = PayConfig.instance:getPayMoneyYuan(goodsCfg.discountGoodsId)

			self._discountTxt.text = string.format(lang("text_discount_num"), Price / oldPrice * 10)
			self._txtOldPrice.text = oldPrice .. "元"
			self._txtPrice.text = Price .. "元"
			self._txtSlogan.text = string.format(lang("text_time_limit_rob_buy"), ConstString.ChineseNumber[math.floor(Price / oldPrice * 10)])
		else
			self._txtPrice.text = PayConfig.instance:getPayMoneyYuan(goodsCfg.originalGoodsId) .. "元"
			self._txtSlogan.text = string.format(lang("text_time_limit_buy"), StringUtil.SubUtf8String(goodsCfg.name, 1, 3))
		end
	end
end

function LongNvPurchaseView:_setZdlNum()
	local strNum = DirectPurchaseConfig.instance:getValueByKey(self._activityId, "t_direct_pos1")
	local num = checknumber(strNum)

	self._recZdl:SetNum(num)
end

function LongNvPurchaseView:_setFmtIcons()
	local fmtCfgs = DirectPurchaseConfig.instance:getRecFmtById(self._activityId)

	if fmtCfgs then
		for i, v in ipairs(self._petItems) do
			if fmtCfgs[i] and fmtCfgs[i].raceId > 0 then
				v.transform.parent.gameObject:SetActive(true)
				MaterialMgr.setIcon(v, MatType.Pet, fmtCfgs[i].raceId)

				if fmtCfgs[i].flag > 0 then
					self._tagRecordPos:LoadPlan(i - 1)
				end
			else
				v:SetActive(false)
			end
		end
	end
end

function LongNvPurchaseView:_removeFmtIcons()
	for i, v in ipairs(self._petItems) do
		Framework.ImageBigBG.Get(v):ClearImage()
	end
end

function LongNvPurchaseView:_getStartTimeAndEndTime(pageId)
	return ActivityDefineController.instance:getStartTimeAndEndTime(self:_getDirectPurchaseType(), self._activityId)
end

function LongNvPurchaseView:_updateTime()
	local leftTime = 0

	if self._activityId and self._activityId > 0 then
		local startTime, endTime = self:_getStartTimeAndEndTime(self._pageId)

		leftTime = endTime - ServerTime.now()
		leftTime = leftTime >= 0 and leftTime or 0
	else
		leftTime = 0
	end

	self._txtTime1.text = "剩余时间：" .. GameUtil.FormatTimeSymbol(leftTime)
end

function LongNvPurchaseView:_setShopIcon()
	if self._petDirectPurchaseCfg and self._petDirectPurchaseCfg.jumpShopId > 0 then
		self._discountShopGo:SetActive(true)

		local id = self._petDirectPurchaseCfg.jumpShopId
		local buyTimes = PayShopModel.instance:getMibaoBuyTimesById(id)
		local isSellOut = buyTimes > 0

		goutil.setActive(self._selloutGo, isSellOut)

		if not isSellOut then
			self:_loadGiftEffect()
		else
			self:_removeGiftEffect()
		end
	else
		self._discountShopGo:SetActive(false)
		self:_removeGiftEffect()
	end
end

function LongNvPurchaseView:_loadGiftEffect()
	self:_removeGiftEffect()

	local effName = "fx_ui_fuli/fx_ui_fuli_lingqu.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1.1)
end

function LongNvPurchaseView:_removeGiftEffect()
	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function LongNvPurchaseView:_loadShopPetIcon()
	self:_removeShopPetIcon()

	local raceId = 10098

	MaterialMgr.setCell(MatType.Pet, raceId, self._itemGo)
end

function LongNvPurchaseView:_removeShopPetIcon()
	MaterialMgr.resetAll(self._itemGo)
end

function LongNvPurchaseView:_setTxtPower()
	self._txtPower.text = DirectPurchaseConfig.instance:getValueByKey(self._activityId, "t_direct_pos2")
end

return LongNvPurchaseView
