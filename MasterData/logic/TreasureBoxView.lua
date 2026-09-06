-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/view/TreasureBoxView.lua

module("logic.extensions.sevendays.view.TreasureBoxView", package.seeall)

local TreasureBoxView = class("TreasureBoxView", TableViewComponent)

function TreasureBoxView:ctor()
	TreasureBoxView.super.ctor(self)

	self.updataTimer = 0.1
	self.timedTimer = 60
	self.newsItemList = nil
	self.newsInfoList = nil
	self.newsItemCount = 4
	self.newsSlideIndex = 0
	self.consumeInfo = nil
	self.newsItemPos = nil
	self.isNewsReset = false
	self.isClickWishBtn = true
	self.newsFormat1 = "<color=#8A93A8FF>恭喜</color>%s<color=#8A93A8FF>在许愿池活动中获得了</color>%s<color=#8A93A8FF>，真的是人品爆发呀！</color>"
	self.newsFormat2 = "<color=#8A93A8FF>恭喜</color>%s<color=#8A93A8FF>从</color>%s<color=#8A93A8FF>中，获得</color>%s<color=#8A93A8FF>，大家快来吸吸欧气！</color>"
	self.isPlayEff = false
	self.effWaitTime = 1
end

function TreasureBoxView:onExitFinished()
	return
end

function TreasureBoxView:onEnterFinished()
	return
end

function TreasureBoxView:buildUI()
	TreasureBoxView.super.buildUI(self)

	self.viewCloseBtn = self:getBtn("upInfoTran/viewCloseBtn")
	self.diabiItemBtn = self:getBtn("upInfoTran/diabiItem")

	local diabiItemGo = self:getGo("upInfoTran/diabiItem")

	self.daibiIconGo = goutil.findChild(diabiItemGo, "daibiIconIma")
	self.daibiCountTxt = goutil.findChild(diabiItemGo, "daibiCountTxt"):GetComponent("Text")
	self.xiaohaoItemBtn = self:getBtn("upInfoTran/xiaohaoItem")

	local xiaohaoItemGo = self:getGo("upInfoTran/xiaohaoItem")

	self.xiaohaoIconGo = goutil.findChild(xiaohaoItemGo, "xiaohaoIconIma")
	self.xiaohaoCountTxt = goutil.findChild(xiaohaoItemGo, "xiaohaoCountTxt"):GetComponent("Text")

	local leftInfoGo = self:getGo("leftInfoTran")

	self.supTimeTxt = goutil.findChildTextComponent(leftInfoGo, "supTimeTxt")
	self.desTxt = goutil.findChildTextComponent(leftInfoGo, "desTxt")
	self.noNewsTxt = goutil.findChildTextComponent(leftInfoGo, "noNewsTxt")
	self.itemMaskTran = goutil.findChild(leftInfoGo, "itemMaskTran").transform
	self.newsItemGo = goutil.findChild(leftInfoGo, "itemMaskTran/newsItem")

	local middleInfoGo = self:getGo("middleInfoTran")

	self.kcTitleGo = goutil.findChild(middleInfoGo, "kcTitleGo")
	self.kcTitleTex = goutil.findChildTextComponent(self.kcTitleGo, "kcTitleTex")
	self.kcCountTxt = goutil.findChildTextComponent(middleInfoGo, "kcCountTxt")
	self.kcAddBtn = Framework.ButtonAdapter.GetFrom(middleInfoGo, "kcAddBtn")
	self.tenClickBtn = Framework.ButtonAdapter.GetFrom(middleInfoGo, "tenClickBtn")
	self.tenRedpointGo = goutil.findChild(middleInfoGo, "tenClickBtn/tenRedpointGo")
	self.oneClickBtn = Framework.ButtonAdapter.GetFrom(middleInfoGo, "oneClickBtn")
	self.oneRedpointGo = goutil.findChild(middleInfoGo, "oneClickBtn/oneRedpointGo")

	local ysBagGo = self:getGo("ysBagGo")

	self.ycNoShowGo = goutil.findChild(ysBagGo, "ycNoShowGo")
	self.ycClickBtn = Framework.ButtonAdapter.GetFrom(ysBagGo, "ycClickBtn")
	self.ycRedpointGo = goutil.findChild(ysBagGo, "ycClickBtn/ycRedpointGo")
	self.jldhClickBtn = Framework.ButtonAdapter.GetFrom(ysBagGo, "jldhClickBtn")
	self.kclbClickBtn = Framework.ButtonAdapter.GetFrom(ysBagGo, "kclbClickBtn")
	self.kclbRedpointGo = goutil.findChild(ysBagGo, "kclbClickBtn/kclbRedpointGo")
	self.viewEffPos = self:getGo("viewEffPos")

	self.kclbRedpointGo:SetActive(false)

	self.daibiCountTxt.text = ""
	self.xiaohaoCountTxt.text = ""
	self.supTimeTxt.text = ""
	self.desTxt.text = ""
	self.noNewsTxt.text = ""
	self.kcTitleTex.text = ""

	self.kcTitleGo:SetActive(false)

	self.kcCountTxt.text = ""

	self.tenRedpointGo:SetActive(false)
	self.oneRedpointGo:SetActive(false)
	self.ycNoShowGo:SetActive(false)
	self.ycRedpointGo:SetActive(false)
end

function TreasureBoxView:bindEvents()
	TreasureBoxView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.diabiItemBtn:AddClickListener(function()
		if self.consumeInfo == nil or checknumber(self.consumeInfo.useType) < 1 then
			return
		end

		CommonTipsMgr.instance:openMaterialTips(self.diabiItemBtn, self.consumeInfo.useType, self.consumeInfo.useId)
	end, self)
	self.xiaohaoItemBtn:AddClickListener(function()
		if self.consumeInfo == nil or checknumber(self.consumeInfo.goodsType) < 1 then
			return
		end

		CommonTipsMgr.instance:openMaterialTips(self.xiaohaoItemBtn, self.consumeInfo.goodsType, self.consumeInfo.goodsId)
	end, self)
	self.kcAddBtn:AddClickListener(function()
		if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
			FloatWordMgr.instance:show("活动已结束！")

			return
		end

		UIStateManager.instance:push(ViewName.TreasureShop)
	end, self)
	self.oneClickBtn:AddClickListener(function()
		self:OnClickOneOrTenBtn(true)
	end, self)
	self.tenClickBtn:AddClickListener(self.OnClickOneOrTenBtn, self)
	self.ycClickBtn:AddClickListener(function()
		if not self.isClickWishBtn then
			FloatWordMgr.instance:show("正在许愿中，请稍后再试！")

			return
		end

		if self._curViewDatas == nil or #self._curViewDatas == 0 then
			FloatWordMgr.instance:show("当前没有可打开的赠礼哦！")

			return
		end

		if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
			FloatWordMgr.instance:show("活动已结束，请前往背包中兑换！")

			return
		end

		SevenDaysController.instance:CSRequestOneclickCollection()
	end, self)
	self.jldhClickBtn:AddClickListener(function()
		local activityId = SevenDaysModel.instance:GetFunctionActivityId()

		if activityId <= 0 then
			FloatWordMgr.instance:show("活动已结束，无法兑换！")

			return
		end

		ActivityshopController.instance:getAllShopItemInfo(SevenDaysModel.instance.trboxActivityType, activityId)
		UIStateManager.instance:push(ViewName.TreasureExchange)
	end, self)
	self.kclbClickBtn:AddClickListener(function()
		if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
			FloatWordMgr.instance:show("活动已结束，无法购买礼包！")

			return
		end

		UIStateManager.instance:push(ViewName.TreasureShop)
	end, self)
end

function TreasureBoxView:unbindEvents()
	TreasureBoxView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.diabiItemBtn:RemoveClickListener()
	self.xiaohaoItemBtn:RemoveClickListener()
	self.kcAddBtn:RemoveClickListener()
	self.oneClickBtn:RemoveClickListener()
	self.tenClickBtn:RemoveClickListener()
	self.ycClickBtn:RemoveClickListener()
	self.jldhClickBtn:RemoveClickListener()
	self.kclbClickBtn:RemoveClickListener()
end

function TreasureBoxView:onExit()
	TreasureBoxView.super.onExit(self)
	GlobalDispatcher:removeListener("UpdataTreBoxBuyInfo", self.UpdataTreBoxBuyInfo, self)
	GlobalDispatcher:removeListener("UpdataNewsInfoList", self.UpdataNewsInfoList, self)
	GlobalDispatcher:removeListener("UpdataWishingWellInfo", self.UpdataWishingWellInfo, self)
	GlobalDispatcher:removeListener("UpdataExchangeBuyInfo", self.UpdataTreBoxDaibiInfo, self)
	removetimer(self.CalculationSurplusTime, self)
	removetimer(self.CalculationNewsPosition, self)

	if self.wishEff then
		UIEffectManager.instance:stopEffect(self.wishEff)
	end

	self.wishEff = nil

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil
	self.isClickWishBtn = true
end

function TreasureBoxView:destroyUI()
	TreasureBoxView.super.destroyUI(self)

	for _, item in pairs(self.newsItemList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.newsItemList = nil
	self.newsInfoList = nil
	self.timedTimer = 60
	self.newsSlideIndex = 0
	self.consumeInfo = nil
	self.newsItemPos = nil
	self.isNewsReset = false
	self.newsFormat1 = nil
	self.newsFormat2 = nil
end

function TreasureBoxView:onEnter()
	TreasureBoxView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataTreBoxBuyInfo", self.UpdataTreBoxBuyInfo, self)
	GlobalDispatcher:addListener("UpdataNewsInfoList", self.UpdataNewsInfoList, self)
	GlobalDispatcher:addListener("UpdataWishingWellInfo", self.UpdataWishingWellInfo, self)
	GlobalDispatcher:addListener("UpdataExchangeBuyInfo", self.UpdataTreBoxDaibiInfo, self)

	self.timedTimer = 60

	local activityId = SevenDaysModel.instance:GetFunctionActivityId()

	if activityId <= 0 then
		print("sr----天外飞石     TreasureBoxView:onEnter()    当前活动时间错误 = " .. activityId)

		activityId = 7001
	end

	self.supTimer = SevenDaysModel.instance:GetFunctionSupTimer()

	self:StartCreatNewsItems()
	self:UpdataWishingWellInfo(true)
	settimer(1, self.CalculationSurplusTime, self, true)
	settimer(self.updataTimer, self.CalculationNewsPosition, self, true)

	local effPath = "fx_ui_xuyuanchi/fx_ui_shuimian_xuyuanchi.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewEffPos, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewEffPos.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
	SevenDaysController.instance:CSRequestWishingWellInfo()
end

function TreasureBoxView:CalculationSurplusTime()
	self.supTimer = self.supTimer - 1

	if self.supTimer < 0 then
		self.supTimeTxt.text = "活动结束"

		self.tenRedpointGo:SetActive(false)
		self.oneRedpointGo:SetActive(false)
		self.ycRedpointGo:SetActive(false)
		removetimer(self.CalculationSurplusTime, self)

		return
	end

	if self.isPlayEff then
		self.effWaitTime = self.effWaitTime - 1

		if self.effWaitTime < 0 then
			self.isPlayEff = false

			self:UpdataTreBoxBuyInfo()
			MaterialController.instance:showChangeSetInTemp(SevenDaysModel.instance.boxChengeId)

			SevenDaysModel.instance.boxChengeId = nil
		end
	end

	if self.timedTimer <= 0 then
		self.timedTimer = 60

		SevenDaysController.instance:CSRequestWishingWellBroadcast()
	end

	self.timedTimer = self.timedTimer - 1

	local days = 0

	if self.supTimer >= 86400 then
		days = math.floor(self.supTimer / 86400)
	end

	local hour = 0

	if self.supTimer - days * 86400 >= 3600 then
		hour = math.floor((self.supTimer - days * 86400) / 3600)
	end

	local min = 0

	if self.supTimer - days * 86400 - hour * 3600 >= 60 then
		min = math.floor((self.supTimer - days * 86400 - hour * 3600) / 60)
	end

	local sec = self.supTimer - days * 86400 - hour * 3600 - min * 60

	self.supTimeTxt.text = days > 0 and string.format("%s天%s小时%s分", days, hour, min) or string.format("%s小时%s分%s秒", hour, min, sec)
end

function TreasureBoxView:StartCreatNewsItems()
	removetimer(self.CalculationNewsPosition, self)

	if self.newsItemList == nil or #self.newsItemList < self.newsItemCount then
		self.newsItemList = self.newsItemList or {}

		for i = 1, self.newsItemCount do
			if self.newsItemList[i] == nil then
				local go = UnityEngine.GameObject.Instantiate(self.newsItemGo, self.itemMaskTran)

				go.name = "newsItem_" .. i
				self.newsItemList[i] = {
					itemGo = go,
					itemTxt = goutil.findChildTextComponent(go, "newsTxt")
				}
			end
		end
	end

	self.newsItemPos = {
		69,
		69,
		69,
		69
	}

	for i = 1, self.newsItemCount do
		if self.newsItemList[i] and self.newsItemList[i].itemGo then
			if self.newsItemList[i].itemTxt then
				self.newsItemList[i].itemTxt.text = ""
			end

			if self.newsItemList[i].itemGo.activeSelf then
				self.newsItemList[i].itemGo:SetActive(false)
			end
		end
	end

	self:UpdataNewsInfoList()
end

function TreasureBoxView:UpdataNewsInfoList(lastList)
	local boxInfo = SevenDaysModel.instance:GetWishingWellInfo()
	local newsNextTime = checknumber(boxInfo.nextNewsTime) - ServerTime.now()

	self.timedTimer = newsNextTime <= 0 and 10 or newsNextTime

	if boxInfo then
		self.newsInfoList = boxInfo.newsInfoList or {}
	end

	if self.newsInfoList then
		if not #self.newsInfoList then
			local newsHaveCount = 0

			if newsHaveCount == 0 then
				self.noNewsTxt.text = "还没有玩家获得神秘奖励哦"

				if newsNextTime <= 0 then
					SevenDaysController.instance:CSRequestWishingWellBroadcast()
				end

				return
			end

			self.noNewsTxt.text = ""

			if lastList and #lastList >= self.newsItemCount then
				return
			end

			if newsHaveCount > self.newsItemCount then
				if not self.newsItemCount then
					local nowIndex = newsHaveCount

					self.newsSlideIndex = nowIndex

					for i = 1, nowIndex do
						self:SetNewsItemInfo(i, i)
					end
				end
			end
		end
	end
end

function TreasureBoxView:SetNewsItemInfo(index, newsIndex, isSlide)
	if checknumber(index) <= 0 or checknumber(newsIndex) <= 0 then
		return
	end

	if self.newsItemList then
		if not self.newsItemList[index] then
			local item

			if item == nil or item.itemGo == nil then
				return
			end

			if not item.itemGo.activeSelf then
				item.itemGo:SetActive(true)
			end

			if self.newsInfoList then
				if not self.newsInfoList[newsIndex] then
					local info
					local goodsType, goodsId = 0, 0

					if info then
						local roleName = "<color=#49B8FFFF>" .. info.name .. "</color>"

						if info.type == 0 then
							local list = string.split(info.param, ":")

							goodsType = checknumber(list[1])
							goodsId = checknumber(list[2])

							local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

							if cfg then
								if not cfg.name then
									local boxName = "info.param"

									if cfg then
										local _, colorStr = PetEquipController.instance:GetQualityStrByNum(cfg.quality or 1)

										boxName = string.format("<color=%s>%s</color>", colorStr, boxName)
										item.itemTxt.text = string.format(self.newsFormat1, roleName, boxName)
									end
								end
							end
						else
							local goodsList = string.split(info.param, "_")

							if goodsList == nil or #goodsList ~= 2 then
								error("sr----天外飞石  TreasureBoxView:SetNewsItemInfo()    服务端下发的参数不对 : " .. info.param)

								return
							end

							local list = string.split(goodsList[1], ":")
							local cfg = MaterialMgr.getMatCfg(checknumber(list[1]), checknumber(list[2]))

							if cfg then
								if not cfg.name then
									local boxName = goodsList[1]

									if cfg then
										local _, colorStr1 = PetEquipController.instance:GetQualityStrByNum(cfg.quality or 1)

										boxName = string.format("<color=%s>%s</color>", colorStr1, boxName)
										list = string.split(goodsList[2], ":")
										goodsType = checknumber(list[1])
										goodsId = checknumber(list[2])
										cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

										if cfg then
											if not cfg.name then
												local goodsName = goodsList[2]

												if cfg then
													local _, colorStr2 = PetEquipController.instance:GetQualityStrByNum(cfg.quality or 1)

													goodsName = string.format("<color=%s>%s</color>", colorStr2, goodsName)
													item.itemTxt.text = string.format(self.newsFormat2, roleName, boxName, goodsName)
												end
											end
										end
									end
								end
							end
						end
					end

					local pox = 0

					if isSlide then
						pox = pox + 5

						for i = 1, self.newsItemCount do
							if self.newsItemPos[i] and self.newsItemPos[i] > 0 and i ~= index then
								pox = pox + self.newsItemPos[i]
							end
						end
					elseif index > 1 then
						for i = 1, index - 1 do
							if self.newsItemPos[i] and self.newsItemPos[i] > 0 then
								pox = pox + self.newsItemPos[i]
							end
						end
					end

					pox = 105 - pox

					GameUtil.setLocalPos(item.itemGo, 0, pox)

					self.newsItemPos[index] = item.itemTxt.preferredHeight + 15

					GameUtil.asBtn(item.itemGo):AddClickListener(function()
						if info == nil then
							return
						end

						if goodsType <= 0 or goodsId <= 0 then
							error("sr----天外飞石   TreasureBoxView:SetNewsItemInfo()   参数错误 = " .. info.param)

							return
						end

						CommonTipsMgr.instance:openMaterialTips(item.itemTxt, goodsType, goodsId, 0)
					end, self)
				end
			end
		end
	end
end

function TreasureBoxView:CalculationNewsPosition()
	if self.newsItemList == nil or #self.newsItemList ~= self.newsItemCount then
		removetimer(self.CalculationNewsPosition, self)

		return
	end

	if self.newsInfoList == nil or #self.newsInfoList < self.newsItemCount then
		return
	end

	for i = 1, self.newsItemCount do
		local pos = GameUtil.getLocalPos(self.newsItemList[i].itemGo).y - 105 + 2

		if pos < 0 then
			if i - 1 <= 0 then
				if not self.newsItemCount then
					local index = i - 1
					local prePos = GameUtil.getLocalPos(self.newsItemList[index].itemGo).y - 105
					local nowPos = prePos - self.newsItemPos[index]

					GameUtil.setLocalPos(self.newsItemList[i].itemGo, 0, nowPos + 105)
				end
			end
		else
			GameUtil.setLocalPos(self.newsItemList[i].itemGo, 0, pos + 105)
		end

		if pos >= self.newsItemPos[i] - 5 then
			if not self.isNewsReset then
				self.isNewsReset = true
				self.newsSlideIndex = self.newsSlideIndex + 1

				if self.newsInfoList == nil or self.newsInfoList[self.newsSlideIndex] == nil then
					local boxInfo = SevenDaysModel.instance:GetWishingWellInfo()

					self.newsInfoList = boxInfo.newsInfoList
					self.newsSlideIndex = 1
				end
			end

			if pos >= self.newsItemPos[i] then
				self:SetNewsItemInfo(i, self.newsSlideIndex, true)

				self.isNewsReset = false
			end
		end
	end
end

function TreasureBoxView:OnClickOneOrTenBtn(isOne)
	if SevenDaysModel.instance:GetFunctionActivityId() <= 0 then
		FloatWordMgr.instance:show("活动已结束，无法许愿！")

		return
	end

	if not self.isClickWishBtn then
		FloatWordMgr.instance:show("正在许愿中，请稍后再试！")

		return
	end

	local count = isOne and 1 or 10

	if self.consumeInfo == nil or self.consumeInfo.haveCount < count * self.consumeInfo.goodsCount then
		UIStateManager.instance:push(ViewName.TreasureShop)

		return
	end

	self.isClickWishBtn = false

	SevenDaysController.instance:CSRequestWishingWellDraw(count)
end

function TreasureBoxView:UpdataWishingWellInfo(isWish, wishCount)
	if self.wishEff then
		UIEffectManager.instance:stopEffect(self.wishEff)
	end

	self.wishEff = nil

	if isWish then
		local effPath = ""

		if checknumber(wishCount) == 1 then
			effPath = "fx_ui_xuyuanchi/fx_ui_xuyuan_1_xuyuanchi.prefab"
		elseif checknumber(wishCount) == 10 then
			effPath = "fx_ui_xuyuanchi/fx_ui_xuyuan_10_xuyuanchi.prefab"
		end

		if not string.nilorempty(effPath) then
			self.kcTitleTex.text = ""

			self.kcTitleGo:SetActive(false)

			self.wishEff = UIEffectManager.instance:playEffect(self, effPath, self.viewEffPos, 0, 0, false, nil, function()
				self:UpdataGiftGoodsList()
			end, nil, self)

			self.wishEff:setParent(self.viewEffPos.transform)
			self.wishEff:setLocalPos(0, 0, 0)
			self.wishEff:setScale(1)

			self.isPlayEff = true
			self.effWaitTime = 1
		else
			self:UpdataTreBoxBuyInfo()
			self:UpdataGiftGoodsList()
		end
	else
		self:UpdataGiftGoodsList()
	end

	local isRed = SevenDaysModel.instance:GetWishCountRedpoint()

	self.oneRedpointGo:SetActive(isRed)
end

function TreasureBoxView:UpdataTreBoxBuyInfo()
	self.isClickWishBtn = true

	local boxInfo = SevenDaysModel.instance:GetWishingWellInfo()

	if boxInfo and boxInfo.isShowTen then
		self.tenClickBtn.gameObject:SetActive(true)
		GameUtil.setLocalPos(self.oneClickBtn.gameObject, -150, -265)
	else
		self.tenClickBtn.gameObject:SetActive(false)
		GameUtil.setLocalPos(self.oneClickBtn.gameObject, 0, -265)
	end

	local isRed = SevenDaysModel.instance:GetShopViewRedpoint()

	self.kclbRedpointGo:SetActive(isRed)

	isRed = SevenDaysModel.instance:GetWishCountRedpoint()

	self.oneRedpointGo:SetActive(isRed)
	self:UpdataTreBoxDaibiInfo()

	local goodsList, supCount = SevenDaysModel.instance:GetBaodiGoodsInfo()

	if goodsList == nil or #goodsList < 2 then
		self.kcTitleTex.text = ""

		self.kcTitleGo:SetActive(false)

		return
	end

	local str = "再许愿<color=#EBAD32FF>%s</color>次，必定出现%s！"
	local cfg = MaterialMgr.getMatCfg(checknumber(goodsList[1]), checknumber(goodsList[2]))

	if cfg == nil then
		error("sr----天外飞石   TreasureBoxView:UpdataTreBoxBuyInfo()()   没有物品 = " .. goodsList[1] .. "， " .. goodsList[2])

		self.kcTitleTex.text = ""

		self.kcTitleGo:SetActive(false)

		return
	end

	local _, colorStr = PetEquipController.instance:GetQualityStrByNum(cfg.quality)
	local goodsName = string.format("<color=%s>%s</color>", colorStr, cfg.name)

	self.kcTitleGo:SetActive(true)

	self.kcTitleTex.text = string.format(str, supCount, goodsName)
end

function TreasureBoxView:UpdataTreBoxDaibiInfo()
	local activityId = SevenDaysModel.instance:GetFunctionActivityId()
	local consumeCfg = TreasureBoxConfig.instance:GetConsumeCfg(activityId)

	if consumeCfg == nil then
		error("sr----天外飞石    View:UpdataTreBoxDaibiInfo()   策划未配置这个活动 activityId = " .. activityId)

		return
	end

	self.desTxt.text = consumeCfg.rules

	if string.nilorempty(consumeCfg.prize) or string.nilorempty(consumeCfg.consume) then
		error("sr----天外飞石    View:UpdataTreBoxDaibiInfo()   未配置正确消耗and获得 activityId = " .. activityId)

		return
	end

	local goodsList = string.split(consumeCfg.consume, ":")
	local goodsType = checknumber(goodsList[1])
	local goodsId = checknumber(goodsList[2])
	local goodsCount = checknumber(goodsList[3])
	local cfg = MaterialMgr.getMatCfg(goodsType, goodsId)

	if cfg == nil then
		error("sr----天外飞石   View:UpdataTreBoxDaibiInfo()   没有消耗品 = " .. consumeCfg.consume)

		return
	end

	local haveCount = MaterialModel.instance:getMaterialsNumber(goodsType, goodsId)
	local str = "剩余%s数：%s"

	self.kcCountTxt.text = string.format(str, cfg.name, haveCount)
	self.consumeInfo = {
		goodsType = goodsType,
		goodsId = goodsId,
		goodsCount = goodsCount,
		haveCount = haveCount
	}

	MaterialMgr.setIcon(self.xiaohaoIconGo, goodsType, goodsId)

	self.xiaohaoCountTxt.text = tostring(haveCount)
	goodsList = string.split(consumeCfg.prize, ":")
	goodsType = checknumber(goodsList[1])
	goodsId = checknumber(goodsList[2])
	self.consumeInfo.useType = goodsType
	self.consumeInfo.useId = goodsId

	MaterialMgr.setIcon(self.daibiIconGo, goodsType, goodsId)

	haveCount = MaterialModel.instance:getMaterialsNumber(goodsType, goodsId)
	self.daibiCountTxt.text = tostring(haveCount)
end

function TreasureBoxView:UpdataGiftGoodsList()
	self._curViewDatas = SevenDaysModel.instance:GetAllGiftGoodsList()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		self.ycNoShowGo:SetActive(true)
	else
		self.ycNoShowGo:SetActive(false)
	end

	self._tableview:ReloadData()
end

function TreasureBoxView:_getPath()
	return {
		cellPath = "ysBagGo/ycItem",
		viewPath = "ysBagGo/ycShowSR"
	}
end

function TreasureBoxView:_cellSize()
	return 100, 100
end

function TreasureBoxView:_updateCell(view, cell, data)
	local cellTxt = goutil.findChildTextComponent(cell, "cellTxt")
	local subLua = MaterialMgr.setCell(data.goodsType, data.goodsId, cell)

	subLua.binder:setNum(data.goodsCount)
	GameUtil.setLocalScale(subLua.view, 0.82, 0.82, 0.82)
	Framework.TransformUtil.SetLocalPos(subLua.view.transform, 0, 11, 0)

	cellTxt.text = data.goodsName
end

return TreasureBoxView
