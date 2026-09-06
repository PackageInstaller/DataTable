-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportBirthdayView.lua

module("logic.extensions.passport.view.PassportBirthdayView", package.seeall)

local PassportBirthdayView = class("PassportBirthdayView", PassportshowView)
local UnlockEffectPath = "20221125/shijianjuanzhou/fx_ui_jiesuo_sjjz.prefab"
local CanUnlockEffectPath = "20221125/shijianjuanzhou/fx_ui_kejiesuo_sjjz.prefab"
local MainEffectPath = "20221125/shijianjuanzhou/fx_ui_shijianjuanzhou.prefab"
local PrizeEffectPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function PassportBirthdayView:ctor()
	PassportBirthdayView.super.ctor(self)
end

function PassportBirthdayView:unbindEvents()
	PassportBirthdayView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function PassportBirthdayView:bindEvents()
	PassportBirthdayView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnGet, self._onClickTask, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickPetInfo, self)
end

function PassportBirthdayView:buildUI()
	PassportBirthdayView.super.buildUI(self)

	self._btnClose = self:getGo("container/leftTop/btnClose")
	self._txtProgress = self:getTxt("container/txtProgress")
	self._btnBuyPassport = self:getBtn("container/btnBuyPassport")
	self._rdTask = self:getGo("container/btnGet/redpoint")
	self._btnGet = self:getGo("container/btnGet")
	self._countTips = self:getGo("container/countTips")
	self._discountGo = self:getGo("container/btnBuyPassport/discountGo")
	self._txtBuyPassport = self:getTxt("container/btnBuyPassport/Text")
	self._advertisementGo = self:getGo("container/advertisement")
	self._txtADDesc = self:getTxt("container/advertisement/tip/txtDesc")
	self._advertisement = AI_Advertisement.New(self._advertisementGo)

	self._advertisement:stop()

	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._rare = self:getGo("petInfo/rare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._effectGo = self:getGo("effect")
end

function PassportBirthdayView:onExit()
	PassportBirthdayView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._rdTask)
	self._advertisement:stop()
	ClockMgr.instance:removeListener(ClockMgr.TickHour, self._updateDiscountState, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)

	self._isFirstEnter = false

	self:_removeSgEffect()
end

function PassportBirthdayView:onEnter()
	PassportBirthdayView.super.onEnter(self)

	self._passPortFuncId = checknumber(self._openparam)

	self.addGEvent(self, GlobalNotify.PassportStateUpdate, self._refreshUI, self)
	ClockMgr.instance:addListener(ClockMgr.TickHour, self._updateDiscountState, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_FORMULATASKRES, self._sendInfoReq, self)

	self._isFirstEnter = true

	RedPointController.instance:regRedPoint(self._rdTask, 328)

	self._txtTime.text = ""

	self._sldProgress:SetValue(0)

	self._txtProgress.text = ""

	self:_playSgEffect()
end

function PassportBirthdayView:_sendInfoReq()
	PassportController.instance:sendGetInfoReq(self._passPortFuncId)
end

function PassportBirthdayView:_getTimeScrollerConf()
	self._timeScrollConf = self._timeScrollConf or TimeScrollerConfig.instance:getActConfig(self._curData.actId)

	return self._timeScrollConf
end

function PassportBirthdayView:_refreshUI()
	self._timeScrollConf = nil

	PassportBirthdayView.super._refreshUI(self)

	if self._curData == nil or self._curData.funcCfg == nil then
		return
	end

	if self._isFirstEnter then
		self:_updateTime()
		self:_tryPlayFirstEnterStory()
		self:_setAdvertisement()

		local skinId = self:_getTimeScrollerConf().taskShowPetRaceId

		MaterialMgr.setCell(MatType.PetSkin_Rare, skinId, self._rare)

		self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)
		self._isFirstEnter = false
	end

	self:_updateDiscountState()
end

function PassportBirthdayView:_setAdvertisement()
	local configs = TimeScrollerConfig.instance:getAdArray(self:_getTimeScrollerConf().adPlanId)
	local picImgs = {}

	for i, v in ipairs(configs) do
		table.insert(picImgs, GameUrl.getPassportBGUrl(v.imgPath))
	end

	self._advertisement:play({
		showLen = 1,
		duration = 5,
		dataList = picImgs,
		pageType = AI_Advertisement.PageType2,
		selectOneCallback = function(index)
			self._txtADDesc.text = configs[index].strContent
		end
	})
end

function PassportBirthdayView:_updateDiscountState()
	if not self._curData then
		return
	end

	local isTimeDiscount = not string.nilorempty(self._curData.actCfg.discountTime) and GameUtil.checkTimeStr(self._curData.actCfg.discountTime)

	GameUtil.SetActive(self._countTips, isTimeDiscount)
	GameUtil.SetActive(self._discountGo, isTimeDiscount)

	local goodsId
	local price = PayConfig.instance:getPayMoneyYuan(isTimeDiscount and self._curData.actCfg.discountGoodsId or self._curData.actCfg.goodsId)

	GameUtil.SetGray(self._btnBuyPassport, self._curData.hasPay)

	self._txtBuyPassport.text = self._curData.hasPay and lang("已购买") or langPara("%s元", price)
end

function PassportBirthdayView:_updateTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(math.floor(self._curData.actId / 1000), self._curData.actId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)

	GameUtil.SetActive(self._timeTips, true)
end

function PassportBirthdayView:_tryPlayFirstEnterStory()
	local userDataKey = "passportbirthdayview" .. self._curData.actId
	local userData = GameUtil.getUserData(userDataKey)

	if checkint(userData) <= 0 then
		GameUtil.saveUserData(userDataKey, 1)

		if checknumber(self:_getTimeScrollerConf().storyId) > 0 then
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, checknumber(self:_getTimeScrollerConf().storyId), StoryModel.StoryType.SCCopy)
		end
	end
end

function PassportBirthdayView:_afterPlayUnlockEffect(data, isGainBoth, progressConfig)
	PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false)

	if isGainBoth and self._curData.hasPay then
		PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, true)
	end

	UIStateManager.instance:push(ViewName.PassportBirthdayPopupView, progressConfig)
end

function PassportBirthdayView:_updateCell(view, cell, data)
	self:_clearTableview(cell)

	local petIcon = goutil.findChild(cell, "petIcon")
	local petMask = goutil.findChild(cell, "petMask")
	local click = goutil.findChild(cell, "click")
	local maskLock = goutil.findChild(cell, "maskLock")
	local priezCon = goutil.findChild(cell, "priezCon")
	local payPriezCon = goutil.findChild(cell, "payPriezCon")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtProgress = goutil.findChildTextComponent(cell, "txtProgress")
	local progressConfig = TimeScrollerConfig.instance:getProgressConfigByValue(self:_getTimeScrollerConf().progressPlanId, self:_getTimeScrollerConf().activityId, checknumber(data.progressKey))

	if not progressConfig then
		printError("progressConfig=nil", checknumber(data.progressKey))
	end

	local isUnlockFree = self._curData.normalPrizeState[data.id]
	local isUnlockPay = self._curData.superPrizeState[data.id]
	local isCanUnlockFree = not data.freeState and data.id < self._curData.unlockIndex
	local isCanUnlockPay = not data.superState and data.id < self._curData.unlockIndex

	GameUtil.SetActive(petIcon, isUnlockFree)
	GameUtil.SetActive(petMask, not isUnlockFree)

	if isUnlockFree then
		txtName.text = progressConfig.petName

		local imgPath = GameUrl.getPassportBGUrl(progressConfig.imgPath)

		uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, imgPath)
	else
		txtName.text = "???"
	end

	if isCanUnlockFree then
		self:_playCellEff(petMask, CanUnlockEffectPath, 3, 49, true)
	end

	GameUtil.addClickHandler(click, function()
		if isCanUnlockFree then
			self:_playCellEff(cell.gameObject, UnlockEffectPath, 0, 44, false, function()
				self:_afterPlayUnlockEffect(data, true, progressConfig)
			end)
		elseif isUnlockFree then
			UIStateManager.instance:push(ViewName.PassportBirthdayPopupView, progressConfig)
		end
	end)

	txtProgress.text = data.progressKey

	GameUtil.SetActive(maskLock, self._curData.progress < checknumber(data.progressKey))

	local freePrizeArray = string.split(data.freePrize, "#")

	for i = 1, 3 do
		local item = goutil.findChild(priezCon, "prizeItemCon" .. i)
		local prizeItem = goutil.findChild(item, "prizeItem")
		local receive = goutil.findChild(item, "receive")

		if not GameUtil.isEmptyString(freePrizeArray[i]) then
			GameUtil.SetActive(item, true)
			GameUtil.SetActive(receive, isUnlockFree)

			local proxy = MaterialMgr.setCellByCfg(freePrizeArray[i], prizeItem)

			if isCanUnlockFree then
				self:_playCellEff(prizeItem, PrizeEffectPath, 0, 0, true)
				proxy:setAutoTips(false)
				proxy:setCallBack(function()
					self:_playCellEff(petMask, UnlockEffectPath, 0, 44, false, function()
						self:_afterPlayUnlockEffect(data, false, progressConfig)
					end)
				end)
			else
				proxy:setCallBack(nil)
			end
		end
	end

	local payedPrizeArray = string.split(data.payedPrize, "#")

	for i = 1, 3 do
		local item = goutil.findChild(payPriezCon, "prizeItemCon" .. i)
		local prizeItem = goutil.findChild(item, "prizeItem")
		local receive = goutil.findChild(item, "receive")

		if not GameUtil.isEmptyString(payedPrizeArray[i]) then
			GameUtil.SetActive(item, true)
			GameUtil.SetActive(receive, isUnlockPay)

			local proxy = MaterialMgr.setCellByCfg(payedPrizeArray[i], prizeItem)

			if isCanUnlockPay then
				self:_playCellEff(prizeItem, PrizeEffectPath, 0, 0, true)
				proxy:setAutoTips(false)
				proxy:setCallBack(function()
					if self._curData.hasPay then
						PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, true)
					else
						self:_onClickBtnBuyPassport()
					end
				end)
			else
				proxy:setCallBack(nil)
			end
		end
	end
end

function PassportBirthdayView:_clearTableview(cell)
	local petIcon = goutil.findChild(cell, "petIcon")
	local petMask = goutil.findChild(cell, "petMask")
	local click = goutil.findChild(cell, "click")
	local priezCon = goutil.findChild(cell, "priezCon")
	local payPriezCon = goutil.findChild(cell, "payPriezCon")

	uGuiUtil.clearImage(petIcon)
	GameUtil.rmClickHandler(click)
	self:_removeCellEff(petMask)

	for i = 1, 3 do
		local item = goutil.findChild(priezCon, "prizeItemCon" .. i)
		local prizeItem = goutil.findChild(item, "prizeItem")

		MaterialMgr.resetAll(prizeItem)

		local receive = goutil.findChild(item, "receive")

		GameUtil.SetActive(receive, false)
		GameUtil.SetActive(item, false)
		self:_removeCellEff(prizeItem)
	end

	for i = 1, 3 do
		local item = goutil.findChild(payPriezCon, "prizeItemCon" .. i)
		local prizeItem = goutil.findChild(item, "prizeItem")
		local receive = goutil.findChild(item, "receive")

		MaterialMgr.resetAll(prizeItem)
		GameUtil.SetActive(receive, false)
		GameUtil.SetActive(item, false)
		self:_removeCellEff(prizeItem)
	end
end

function PassportBirthdayView:_playCellEff(go, path, x, y, isLoop, callback)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local function loadCallBack(view, uiEffect)
		uiEffect:setScrollRectClipping(self._scrollRect)
		uiEffect:setParent(go.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(x, y, 0)

		uiEffect.hideEffWhileNotOnTop = true
	end

	self._effs[go] = UIEffectManager.instance:playEffect(self, path, nil, x, y, isLoop, nil, callback, loadCallBack)
end

function PassportBirthdayView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function PassportBirthdayView:_playSgEffect()
	self:_removeSgEffect()

	local eff = UIEffectManager.instance:playEffect(self, MainEffectPath, self._effectGo.transform, 0, 0, true)

	eff:setParent(self._effectGo.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._sgEffect = eff
end

function PassportBirthdayView:_removeSgEffect()
	if self._sgEffect then
		UIEffectManager.instance:stopEffect(self._sgEffect)

		self._sgEffect = nil
	end
end

function PassportBirthdayView:_onClickTask()
	UIStateManager.instance:push(ViewName.PassportBirthdayTaskView, self._curData.actId, self._curData.funcId)
end

function PassportBirthdayView:_onClickPetInfo()
	PetbookController.instance:openPetinfoView(self:_getTimeScrollerConf().taskShowPetRaceId)
end

function PassportBirthdayView:_onClickSkill()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self:_getTimeScrollerConf().taskShowPetRaceId)

	if cfg then
		PetbookController.instance:previewBattle(cfg.raceId, self:_getTimeScrollerConf().taskShowPetRaceId)
	end
end

return PassportBirthdayView
