-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryMaterialView.lua

module("logic.extensions.lottery.view.LotteryMaterialView", package.seeall)

local LotteryMaterialView = class("LotteryMaterialView", ViewComponent)

function LotteryMaterialView:ctor()
	LotteryMaterialView.super.ctor(self)

	self._matItemList = nil
	self._prizeInfo = nil
end

function LotteryMaterialView:bindEvents()
	LotteryMaterialView.super.bindEvents(self)
	self._shopBtn:AddClickListener(self._onClickShopBtn, self)
	self._bigPrizeBtn:AddClickListener(self._onClickBigPrizeBtn, self)

	for i = 1, #self._matItemList do
		if self._matItemList[i] and #self._matItemList[i] > 0 then
			for j = 1, #self._matItemList[i] do
				if self._matItemList[i][j] then
					if self._matItemList[i][j].clickGo then
						GameUtil.asBtn(self._matItemList[i][j].clickGo):AddClickListener(function()
							self:_onClickPositionBtn(i, j, false)
						end, self)
					end

					if self._matItemList[i][j].resetGo then
						GameUtil.asBtn(self._matItemList[i][j].resetGo):AddClickListener(function()
							self:_onClickPositionBtn(i, j, true)
						end, self)
					end
				end
			end
		end
	end
end

function LotteryMaterialView:unbindEvents()
	LotteryMaterialView.super.unbindEvents(self)
	self._shopBtn:RemoveClickListener()
	self._bigPrizeBtn:RemoveClickListener()

	for _, list in pairs(self._matItemList or {}) do
		for _, go in pairs(list or {}) do
			if go then
				if go.clickGo then
					GameUtil.asBtn(go.clickGo):RemoveClickListener()
				end

				if go.resetGo then
					GameUtil.asBtn(go.resetGo):RemoveClickListener()
				end
			end
		end
	end
end

function LotteryMaterialView:onExit()
	LotteryMaterialView.super.onExit(self)
	removetimer(self._showSettimePopup, self)
	GlobalDispatcher:removeListener(GlobalNotify.LotteryGetPrizeInfo, self._showAllPositionMat, self)
	GlobalDispatcher:removeListener(GlobalNotify.LotterySetPrizeInfo, self._showAllPositionMat, self)
	GlobalDispatcher:removeListener(GlobalNotify.LotteryResetPrizeInfo, self._showAllPositionMat, self)
	GlobalDispatcher:removeListener(GlobalNotify.QingGuGiftInfoRes, self._isLightRed, self)
	removetimer(self._calculationSurplusTime, self)
end

function LotteryMaterialView:destroyUI()
	LotteryMaterialView.super.destroyUI(self)

	self._matItemList = nil
	self._prizeInfo = nil
	self._isAllGain = nil
end

function LotteryMaterialView:buildUI()
	LotteryMaterialView.super.buildUI(self)

	local materialInfoGo = self:getGo("materialInfoGo")

	self._bigPrizeBtn = Framework.ButtonAdapter.GetFrom(materialInfoGo, "bigPrizeBtn")
	self._bigPrizeTxtGo = goutil.findChild(materialInfoGo, "bigPrizeBtn/bigPrizeTxt")
	self._timeTxt = goutil.findChildTextComponent(materialInfoGo, "timeTxt")
	self._matItemList = {}

	for i = 1, 2 do
		self._matItemList[i] = self._matItemList[i] or {}

		local go = goutil.findChild(materialInfoGo, "matTran_" .. i)

		self._matItemList[i][1] = {
			itemGo = goutil.findChild(go, "goodsGo_1"),
			goodsPos = goutil.findChild(go, "goodsGo_1/goodsPos"),
			clickGo = goutil.findChild(go, "goodsGo_1/clickBtn"),
			redPointGo = goutil.findChild(go, "goodsGo_1/redPoint"),
			resetGo = goutil.findChild(go, "goodsGo_1/resetBtn"),
			getGo = goutil.findChild(go, "goodsGo_1/getGo")
		}
		self._matItemList[i][2] = {
			itemGo = goutil.findChild(go, "goodsGo_2"),
			goodsPos = goutil.findChild(go, "goodsGo_2/goodsPos"),
			clickGo = goutil.findChild(go, "goodsGo_2/clickBtn"),
			redPointGo = goutil.findChild(go, "goodsGo_2/redPoint"),
			resetGo = goutil.findChild(go, "goodsGo_2/resetBtn"),
			getGo = goutil.findChild(go, "goodsGo_2/getGo")
		}
		self._matItemList[i][3] = {
			itemGo = goutil.findChild(go, "goodsGo_3"),
			goodsPos = goutil.findChild(go, "goodsGo_3/goodsPos"),
			clickGo = goutil.findChild(go, "goodsGo_3/clickBtn"),
			redPointGo = goutil.findChild(go, "goodsGo_3/redPoint"),
			resetGo = goutil.findChild(go, "goodsGo_3/resetBtn"),
			getGo = goutil.findChild(go, "goodsGo_3/getGo")
		}
	end

	self._shopBtn = self:getBtn("shopBtn")
end

function LotteryMaterialView:onEnter()
	LotteryMaterialView.super.onEnter(self)

	self._poolId = checknumber(self:getFirstParam())

	if self._poolId <= 0 then
		printError("sr---抽卡  LotteryMaterialView:onEnter()  为撒没有传参数？？")
		self:close()

		return
	end

	GlobalDispatcher:addListener(GlobalNotify.LotteryGetPrizeInfo, self._showAllPositionMat, self)
	GlobalDispatcher:addListener(GlobalNotify.LotterySetPrizeInfo, self._showAllPositionMat, self)
	GlobalDispatcher:addListener(GlobalNotify.LotteryResetPrizeInfo, self._showAllPositionMat, self)

	local cfg = LotteryConfig.instance:GetSelectPrizePoolCfg(self._poolId)

	GameUtil.SetActive(self._shopBtn, not string.nilorempty(cfg.jumpTo))

	local isReset, ci = LotteryModel.instance:getLotteryBigPrizeResult(self._poolId, false)

	if isReset or ci > 0 then
		settimer(0.8, self._showSettimePopup, self, false)
	end

	self:_showActivityTimer()
	self:_showAllPositionMat()
	LotteryController.instance:csGetLotterySelectPrizeInfoReq(self._poolId)
end

function LotteryMaterialView:_showSettimePopup()
	removetimer(self._showSettimePopup, self)

	local isReset, ci = LotteryModel.instance:getLotteryBigPrizeResult(self._poolId, true)

	if ci > 0 then
		MaterialController.instance:showChangeSetInTemp(ci, MaterialController.SHOW_TYPE_NO_PET)
	end

	if isReset then
		TipsFacade.instance:openCommonTips(lang("text_lottery_desc_40"))
		self:_showAllPositionMat()
	end
end

function LotteryMaterialView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	local cfg = LotteryConfig.instance:GetPoolCfg(self._poolId)

	if cfg == nil then
		self._timeTxt.text = lang("text_lottery_desc_6")

		return
	end

	self._supTime = 0

	if cfg.countdown then
		local isOpen, isPre, endTime = LotteryModel.instance:getPoolIsOpenParams(cfg)

		if not isOpen or endTime <= ServerTime.nowServerLook() then
			self._timeTxt.text = lang("text_lottery_desc_6")

			return
		else
			self._supTime = endTime - ServerTime.nowServerLook()

			self:_calculationSurplusTime()
		end
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)

	settimer(1, self._calculationSurplusTime, self, true)
end

function LotteryMaterialView:_calculationSurplusTime()
	self._supTime = self._supTime - 1

	if self._supTime <= 0 then
		self._timeTxt.text = lang("text_lottery_desc_6")

		removetimer(self._calculationSurplusTime, self)

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._supTime)

	self._timeTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function LotteryMaterialView:_showAllPositionMat()
	local allCfgs = LotteryConfig.instance:getPoolSelectPrizeCfgs(self._poolId)

	self._prizeInfo = LotteryModel.instance:getLotteryBigPrizeInfo(self._poolId)

	for i = 1, #self._matItemList do
		local rowList = {}

		if allCfgs and allCfgs[i] and #allCfgs[i] > 0 then
			rowList = allCfgs[i]
		end

		if self._matItemList[i] and #self._matItemList[i] > 0 then
			for j = 1, #self._matItemList[i] do
				MaterialMgr.resetAll(self._matItemList[i][j].goodsPos)

				if rowList and rowList[j] then
					GameUtil.SetActive(self._matItemList[i][j].itemGo, true)
					self:_setSinglePositionMat(self._matItemList[i][j], rowList[j])
				else
					GameUtil.SetActive(self._matItemList[i][j].itemGo, false)
				end
			end
		end
	end

	self._isAllGain = LotteryModel.instance:isAllLotteryBigPrizeGain(self._poolId)

	uGuiUtil.setTextGrayState(self._bigPrizeTxtGo, self._isAllGain)
	uGuiUtil.setImageGrayState(self._bigPrizeBtn.gameObject, self._isAllGain)
end

function LotteryMaterialView:_setSinglePositionMat(item, posId)
	posId = checknumber(posId)

	if item == nil or item.goodsPos == nil or posId <= 0 then
		return
	end

	local posInfo

	if self._prizeInfo.posInfo and self._prizeInfo.posInfo[posId] then
		posInfo = self._prizeInfo.posInfo[posId]
	end

	local isRed = LotteryModel.instance:getSubRedpointByPosId(self._poolId, posId)

	GameUtil.SetActive(item.redPointGo, isRed)

	if posInfo == nil or posInfo.posId == nil then
		GameUtil.SetActive(item.resetGo, false)
		GameUtil.SetActive(item.getGo, false)
		GameUtil.SetActive(item.clickGo, true)

		return
	end

	local cfgs = LotteryConfig.instance:getPoolSelectItemCfgs(self._poolId, posId)
	local matStr

	for _, v in pairs(cfgs or {}) do
		if v and v.id == posInfo.prizeId then
			matStr = v.prize

			break
		end
	end

	if string.nilorempty(matStr) then
		printError("sr---抽卡  LotteryMaterialView:_setSinglePositionMat() 检查配置！！")

		return
	end

	GameUtil.SetActive(item.clickGo, false)
	GameUtil.SetActive(item.resetGo, not posInfo.isGain)
	GameUtil.SetActive(item.getGo, posInfo.isGain)

	local proxy = MaterialMgr.setCellByCfg(matStr, item.goodsPos)

	proxy.binder:setGray(posInfo.isGain)
end

function LotteryMaterialView:_onClickShopBtn()
	local cfg = LotteryConfig.instance:GetSelectPrizePoolCfg(self._poolId)

	if cfg == nil or string.nilorempty(cfg.jumpTo) then
		return
	end

	GotoMgr.gotoByString(cfg.jumpTo)
end

function LotteryMaterialView:_onClickMultipleGift()
	return
end

function LotteryMaterialView:_onClickBigPrizeBtn()
	local cfg = LotteryConfig.instance:GetPoolCfg(self._poolId)

	if cfg == nil then
		return
	end

	local function callback()
		if self._isAllGain then
			FloatWordMgr.instance:show(lang("text_lottery_desc_38"))

			return
		end

		if not LotteryModel.instance:isHaveSetBigPrizeGain(self._poolId) then
			FloatWordMgr.instance:show(lang("text_lottery_desc_46"))

			return
		end

		if not string.nilorempty(cfg.selectPrizeResetCost) then
			local list = string.split(cfg.selectPrizeResetCost, ":")
			local have = MaterialModel.instance:getMaterialsNumber(checknumber(list[1]), checknumber(list[2]))

			if have < checknumber(list[3]) then
				FloatWordMgr.instance:show(langPara("text_mirror_desc_6", MaterialMgr.getMaterialsName(checknumber(list[1]), checknumber(list[2]))))

				return
			end
		end

		LotteryController.instance:csGetLotterySelectPrizeResetReq(self._poolId)
	end

	if string.nilorempty(cfg.selectPrizeResetCost) then
		callback()

		return
	end

	local arr = string.split(cfg.selectPrizeResetCost, ":")
	local des = langPara("text_lottery_desc_47", arr[3], MaterialMgr.getMaterialsName(checknumber(arr[1]), checknumber(arr[2])), cfg.name)

	TipsFacade.instance:openPopupWindow(lang("text_lottery_desc_39"), des, callback, nil, lang("mail_confirm"), lang("mail_cancel"))
end

function LotteryMaterialView:_onClickPositionBtn(row, num, isReset)
	local cfgs = LotteryConfig.instance:getPoolSelectPrizeCfgs(self._poolId)
	local posId = 1

	if cfgs and cfgs[row] and cfgs[row][num] then
		posId = cfgs[row][num]
	end

	if not LotteryModel.instance:isSinglePosCanSetBigPrize(self._poolId, posId) then
		FloatWordMgr.instance:show(lang("text_lottery_desc_41"))

		return
	end

	if self._matItemList == nil or self._matItemList[row] == nil or self._matItemList[row][num] == nil then
		return
	end

	local item = self._matItemList[row][num]

	if not item.goodsPos.activeSelf then
		return
	end

	UIStateManager.instance:push(ViewName.LotteryPrize, {
		poolId = self._poolId,
		row = row,
		num = num,
		posId = posId
	})
end

function LotteryMaterialView:_isLightRed()
	local info = MultiplegiftpacksController.instance:getGiftInfo()

	if not checkbool(info.bought) then
		-- block empty
	else
		RedPointController.instance:saveUserDayRedPoint("c8")
	end
end

return LotteryMaterialView
