-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmalltaskView.lua

module("logic.extensions.companionmall.view.CompanionmalltaskView", package.seeall)

local CompanionmalltaskView = class("CompanionmalltaskView", ViewComponent)

function CompanionmalltaskView:ctor()
	CompanionmalltaskView.super.ctor(self)
end

function CompanionmalltaskView:unbindEvents()
	CompanionmalltaskView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnTip)
end

function CompanionmalltaskView:bindEvents()
	CompanionmalltaskView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGet, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function CompanionmalltaskView:buildUI()
	CompanionmalltaskView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._txtCount = self:getTxt("txtCount")
	self._cellList = {}

	for i = 1, 3 do
		local cell = self:getGo("right/cell" .. i)

		table.insert(self._cellList, cell)
	end

	self._redPoint = self:getGo("right/btnGet/redPoint")
	self._tablecell = self:getGo("right/cell3/tableview/tablecell")
	self._tableview = self:getGo("right/cell3/tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._eff = self:getGo("right/eff")
	self._txtInfo = self:getTxt("right/txtInfo")
	self._btnGet = self:getGo("right/btnGet")
	self._txtGet = self:getTxt("right/btnGet/txt")
end

function CompanionmalltaskView:onExit()
	CompanionmalltaskView.super.onExit(self)
	self._scrollList:dispose()
	self:_stopEff()
	RedPointController.instance:unregRedPoint(self._redPoint)
end

function CompanionmalltaskView:onEnter()
	CompanionmalltaskView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	self._activityId = activityId == 0 and CompanionMallController.instance:getDefaultActId() or activityId
	self._companionId = checknumber(params[2])

	local itemCfg = CompanionMallConfig.instance:getItemCfgById(self._activityId, self._companionId) or {}
	local list = string.split(itemCfg.content or "", "#")

	self._scrollList:reloadData(list)

	self._limitTimes = itemCfg.limitTimes
	self._itemCfg = itemCfg

	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GET_INFO, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GAIN_OK, self._onGainOk, self)
	CompanionMallController.instance:sendGetInfo(self._activityId)
	self:_refreshUI()

	local getRimRedPointName = string.format("%do%d", RedPointModel.ID_COMPANIONMALL_GET_RIM, self._companionId)

	RedPointController.instance:regRedPoint(self._redPoint, getRimRedPointName)
end

function CompanionmalltaskView:_onGainOk()
	self:_refreshUI()
	UIStateManager.instance:push(ViewName.CompanionMallAddressBookPopView, self._activityId, self._companionId)
end

function CompanionmalltaskView:_onClickBtnTip()
	local key = self._itemCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function CompanionmalltaskView:_refreshUI()
	local info = CompanionMallModel.instance:getInfo(self._activityId) or {}

	if not info.companionInfo then
		local companionInfoList = {}

		self._curGlobalGainCount = 0
		self._hasGainCompanion = false
		self._hasSubmitAddress = false
		self._hasFinishAll = true

		local taskMap = {}

		for i, v in ipairs(companionInfoList) do
			if v.companionId == self._companionId then
				self._hasGainCompanion = v.hasGainCompanion
				self._hasSubmitAddress = v.hasSubmitAddress
				self._curGlobalGainCount = v.curGlobalGainCount

				for j, kv in ipairs(v.taskIdAndProgress) do
					taskMap[kv.left] = kv.right
				end

				break
			end
		end

		self._txtCount.text = langPara("四周年礼盒限量：<color=#20b376>%s</color>/%s份", math.max(0, self._limitTimes - self._curGlobalGainCount), self._limitTimes)

		local bigId = 3
		local finishNum = 0
		local cfgList = CompanionMallConfig.instance:getTaskCfgById(self._activityId, self._companionId) or {}

		for i, cell in ipairs(self._cellList) do
			local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
			local btnReceive = goutil.findChild(cell, "btnReceive")
			local receivedGo = goutil.findChild(cell, "receivedGo")
			local btnGo = goutil.findChild(cell, "btnGo")

			GameUtil.SetActive(btnReceive, false)
			GameUtil.SetActive(receivedGo, false)
			GameUtil.SetActive(btnGo, false)

			txtDesc.text = ""

			local cfg = cfgList[i]

			if cfg then
				txtDesc.text = cfg.desc

				GameUtil.addClickHandler(btnGo, function()
					if i == bigId then
						if not self._itemCfg.buyPreTaskId then
							local isAll = true

							for _, taskId in ipairs(self._itemCfg.buyPreTaskId) do
								local taskCfg = CompanionMallConfig.instance:getTaskCfgByTaskId(self._activityId, self._companionId, taskId)

								if checknumber(taskMap[taskCfg.taskId]) < taskCfg.maxProgress then
									isAll = false

									TipsFacade.instance:openCommonTips("请先完成前面的任务")

									break
								end
							end

							if isAll then
								local goodsId = self._itemCfg.goodsId
								local subGoodsType = GameEnum.PaySubGoodsType.COMPANION_MALL
								local subGoodsId = self._activityId
								local para = {}

								para.cpnId = self._companionId

								local extParams = GameUtil.jsonToString(para)

								PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
							end
						end
					else
						GotoMgr.gotoByString(cfg.jumpStr)
					end
				end)

				local isOver = checknumber(taskMap[cfg.taskId]) >= cfg.maxProgress

				GameUtil.SetActive(btnGo, not isOver)
				GameUtil.SetActive(receivedGo, isOver)

				if not isOver then
					self._hasFinishAll = false
				else
					finishNum = finishNum + 1
				end

				if i == bigId then
					if self._curGlobalGainCount >= self._limitTimes then
						GameUtil.SetActive(btnGo, false)
					end

					local txtGo = goutil.findChildTextComponent(cell, "btnGo/text")
					local payCfg = PayConfig.instance:getPayGoodsCfg(self._itemCfg.goodsId)

					if payCfg then
						local cost = payCfg.payMoney / 100

						txtGo.text = "￥" .. cost
					end
				end
			end
		end

		self._txtGet.text = "领取周边"

		if self._hasGainCompanion then
			self._txtGet.text = self._hasSubmitAddress and "修改地址" or "填写地址"

			self:_stopEff()
		elseif self._hasFinishAll == true and not self._hasGainCompanion == true then
			self:_playEff()
		else
			self:_stopEff()
		end

		self._txtInfo.text = string.format("达成进度：<color=#20b376>%d</color>/%d", finishNum, #cfgList)
	end
end

local effPath = "20211217/anniu/fx_ui_anniu.prefab"

function CompanionmalltaskView:_playEff()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	self._effect = UIEffectManager.instance:playEffect(self, effPath, self._eff.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	self._effect:setParent(self._eff.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
end

function CompanionmalltaskView:_stopEff()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

function CompanionmalltaskView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function CompanionmalltaskView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function CompanionmalltaskView:_onClickGet()
	if self._hasFinishAll then
		if not self._hasGainCompanion then
			CompanionMallController.instance:sendGainCompanion(self._activityId, self._companionId)
		else
			UIStateManager.instance:push(ViewName.CompanionMallAddressBookPopView, self._activityId, self._companionId)
		end
	else
		TipsFacade.instance:openCommonTips("完成任务可以有领取周边的机会哦~")
	end
end

return CompanionmalltaskView
