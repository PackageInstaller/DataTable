-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TLCExchangeWndView.lua

module("logic.extensions.timelimitedchallenge.view.TLCExchangeWndView", package.seeall)

local TLCExchangeWndView = class("TLCExchangeWndView", ActivityshopexchangebuyView)

function TLCExchangeWndView:onEnter()
	self._cfg = self:getFirstParam()

	local gain = self._cfg.gain
	local proxy = MaterialMgr.setCellByCfg(gain, self._itemCon)

	proxy:setAutoTips(false)

	local matType, matId = unpack(string.splitToNumber(gain, ":"))

	self.group:SetState(0)

	if matType == MatType.Pet then
		local cfg = CharacterConfig.instance:getPetInfoCo(matId)

		self._descTxt.text = cfg.introduce
		self._nameTxt.text = cfg.name

		self.group:SetState(cfg.rare or 0)
	else
		local cfg = MaterialFacade.instance:getMatCfg(matType, matId)

		self._descTxt.text = cfg.desc
		self._nameTxt.text = cfg.name

		self.group:SetState(cfg.quality or 0)
	end

	self._haveTxt.text = "拥有：" .. MaterialFacade.instance:getMatNumber(matType, matId)

	local costType, costId, costNum = unpack(string.splitToNumber(self._cfg.cost, ":"))

	MaterialMgr.setIcon(self._useMatIcon, costType, costId)

	self._buyCount = 1

	local exchangeInfo = TLChallengeModel.instance:getExchangeInfoByIds(self._cfg.challengeId, self._cfg.id)
	local dailyTimes = self._cfg.dailyTimes
	local totalTimes = self._cfg.totalTimes

	self._sellLimitCount = 0

	if dailyTimes > 0 then
		self._sellLimitCount = dailyTimes
		self._hasBuyTime = exchangeInfo.dailyTimes
		limitFmt = "每日限兑：%s/%s"
	elseif totalTimes > 0 then
		self._sellLimitCount = totalTimes
		self._hasBuyTime = exchangeInfo.totalTimes
		limitFmt = "活动限兑：%s/%s"
	end

	self._sellLimitCount = checknumber(self._sellLimitCount)

	local hasLimit = self._sellLimitCount > 0

	print("self._sellLimitCount = " .. self._sellLimitCount)
	self._limitTxt.gameObject:SetActive(hasLimit)

	if hasLimit then
		self._limitTxt.text = string.format(limitFmt, self._sellLimitCount - self._hasBuyTime, self._sellLimitCount)
	end

	self._sellPrice = self._cfg.cost

	self:_refreshBuyCount()
end

function TLCExchangeWndView:_refreshBuyCount()
	self._buyCount = math.min(99, self._buyCount)

	TLCExchangeWndView.super._refreshBuyCount(self)
end

function TLCExchangeWndView:_onClickBuy()
	local matType, matId, matNum = unpack(string.splitToNumber(self._cfg.cost, ":"))
	local matCfg = MaterialMgr.getMatCfg(matType, matId)
	local isMatEnough = MaterialModel.instance:getMaterialsNumber(matType, matId) >= matNum * self._buyCount

	if not isMatEnough then
		FloatWordMgr.instance:show(matCfg.name .. "不足")
	else
		TLChallengeController.instance:reqDoExchange(self._cfg.challengeId, self._cfg.id, self._buyCount)
	end
end

return TLCExchangeWndView
