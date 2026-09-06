-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PtNewYearInvestCell.lua

module("logic.extensions.passport.view.PtNewYearInvestCell", package.seeall)

local PtNewYearInvestCell = class("PtNewYearInvestCell")

function PtNewYearInvestCell:ctor(luaComponentContainer)
	self._mainGO = luaComponentContainer.gameObject
	self._txtName = goutil.findChildTextComponent(self._mainGO, "title/txtName")
	self._itemList = {}

	for i = 1, 6 do
		local itemCell = {}

		itemCell.go = goutil.findChild(self._mainGO, "com/item_" .. i)
		itemCell.rp = goutil.findChild(itemCell.go, "rp")
		itemCell.mark = goutil.findChild(itemCell.go, "mark")
		itemCell.item = goutil.findChild(itemCell.go, "cell")

		goutil.setActive(itemCell.mark, false)
		goutil.setActive(itemCell.rp, false)
		table.insert(self._itemList, itemCell)
	end
end

function PtNewYearInvestCell:init(data, curData, scrollRect, view)
	self._data = data
	self._curData = curData
	self._scrollRect = scrollRect
	self._view = view

	self:reset()
	self:_initNormalReward(data)
	self:_initPayReward1(data)
	self:_initPayReward2(data)

	self._txtName.text = string.format("第%d天", data.progressKey)
end

function PtNewYearInvestCell:reset()
	self._txtName.text = ""

	for i, v in ipairs(self._itemList) do
		MaterialMgr.resetAll(v.item)
		goutil.setActive(v.mark, false)
		goutil.setActive(v.rp, false)
		self:_removeCellEff(v.item)
	end
end

function PtNewYearInvestCell:_initNormalReward(data)
	if not string.nilorempty(data.freePrize) then
		local prizeArr = string.split(data.freePrize, "#")
		local proxy_1 = MaterialMgr.setCellByCfg(prizeArr[1], self._itemList[1].item)
		local proxy_2 = MaterialMgr.setCellByCfg(prizeArr[2], self._itemList[2].item)

		goutil.setActive(self._itemList[1].mark, data.freeState)
		goutil.setActive(self._itemList[2].mark, data.freeState)

		if not data.freeState and data.id < self._curData.unlockIndex then
			goutil.setActive(self._itemList[1].rp, true)
			self:_playCellEff(self._itemList[1].item)
			proxy_1:setAutoTips(false)
			proxy_1:setCallBack(function()
				PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false)
			end)
			goutil.setActive(self._itemList[2].rp, true)
			self:_playCellEff(self._itemList[2].item)

			if proxy_2 then
				proxy_2:setAutoTips(false)
				proxy_2:setCallBack(function()
					PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, data.id - 1, false)
				end)
			end
		end
	end
end

function PtNewYearInvestCell:_initPayReward1(data)
	if not string.nilorempty(data.payedPrize) then
		local prizeArr = string.split(data.payedPrize, "#")
		local proxy_3 = MaterialMgr.setCellByCfg(prizeArr[1], self._itemList[3].item)
		local proxy_4 = MaterialMgr.setCellByCfg(prizeArr[2], self._itemList[4].item)

		goutil.setActive(self._itemList[3].mark, data.superState)
		goutil.setActive(self._itemList[4].mark, data.superState)

		if not data.superState and data.id < self._curData.unlockIndex then
			goutil.setActive(self._itemList[3].rp, true)
			proxy_3:setAutoTips(false)
			self:_playCellEff(self._itemList[3].item)
			proxy_3:setCallBack(function()
				self:_onClickPay1()
			end)
			goutil.setActive(self._itemList[4].rp, true)

			if proxy_4 then
				proxy_4:setAutoTips(false)
				self:_playCellEff(self._itemList[4].item)
				proxy_4:setCallBack(function()
					self:_onClickPay1()
				end)
			end
		end
	end
end

function PtNewYearInvestCell:_initPayReward2(data)
	if not string.nilorempty(data.additionalPaymentPrize) then
		local prizeArr = string.split(data.additionalPaymentPrize, "#")
		local proxy_5 = MaterialMgr.setCellByCfg(prizeArr[1], self._itemList[5].item)
		local proxy_6 = MaterialMgr.setCellByCfg(prizeArr[2], self._itemList[6].item)

		goutil.setActive(self._itemList[5].mark, data.addState)
		goutil.setActive(self._itemList[6].mark, data.addState)

		if not data.addState and data.id < self._curData.unlockIndex then
			goutil.setActive(self._itemList[5].rp, true)
			proxy_5:setAutoTips(false)
			self:_playCellEff(self._itemList[5].item)
			proxy_5:setCallBack(function()
				self:_onClickPay2()
			end)
			goutil.setActive(self._itemList[6].rp, true)

			if proxy_6 then
				proxy_6:setAutoTips(false)
				self:_playCellEff(self._itemList[6].item)
				proxy_6:setCallBack(function()
					self:_onClickPay2()
				end)
			end
		end
	end
end

function PtNewYearInvestCell:_playCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	self:_removeCellEff(go)

	local resPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	local function loadedCallback(view, eff)
		eff:setScrollRectClipping(self._scrollRect)
	end

	local uiEffect = UIEffectManager.instance:playEffect(self._view, resPath, nil, nil, nil, true, nil, nil, loadedCallback)

	uiEffect:setParent(go.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	uiEffect.hideEffWhileNotOnTop = true
	self._effs[go] = uiEffect
end

function PtNewYearInvestCell:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function PtNewYearInvestCell:_onClickPay1()
	if self._curData.hasPay then
		PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, self._data.id - 1, true)
	else
		if not string.nilorempty(self._curData.actCfg.ordinaryBuyStartTime) then
			local timeNow = ServerTime.now()

			if timeNow < GameUtil.string2time(self._curData.actCfg.ordinaryBuyStartTime) then
				FloatWordMgr.instance:show(langPara("%s后开启售卖", string.gsub(self._curData.actCfg.ordinaryBuyStartTime, "T", " ")))

				return
			end
		end

		PassportController.instance:_buyPassportWithDifferentPayType(self._curData.actId, false, false)
	end
end

function PtNewYearInvestCell:_onClickPay2()
	if self._curData.hasPayAdd then
		PassportController.instance:sendGainPrizeReq(self._curData.actId, self._curData.funcId, self._data.id - 1, false, true)
	else
		if not string.nilorempty(self._curData.actCfg.additionalBuyStartTime) then
			local timeNow = ServerTime.now()

			if timeNow < GameUtil.string2time(self._curData.actCfg.additionalBuyStartTime) then
				FloatWordMgr.instance:show(langPara("%s后开启售卖", string.gsub(self._curData.actCfg.ordinaryBuyStartTime, "T", " ")))

				return
			end
		end

		PassportController.instance:_buyPassportWithDifferentPayType(self._curData.actId, false, true)
	end
end

return PtNewYearInvestCell
