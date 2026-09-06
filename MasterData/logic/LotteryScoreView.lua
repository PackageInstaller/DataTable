-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryScoreView.lua

module("logic.extensions.lottery.view.LotteryScoreView", package.seeall)

local LotteryScoreView = class("LotteryScoreView", TableViewComponent)

function LotteryScoreView:ctor()
	LotteryScoreView.super.ctor(self)

	self.rewardGoodsList = nil
end

function LotteryScoreView:bindEvents()
	LotteryScoreView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
end

function LotteryScoreView:unbindEvents()
	LotteryScoreView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnSort)
end

function LotteryScoreView:onEnterFinished()
	return
end

function LotteryScoreView:onExitFinished()
	return
end

function LotteryScoreView:destroyUI()
	LotteryScoreView.super.destroyUI(self)
end

function LotteryScoreView:onExit()
	LotteryScoreView.super.onExit(self)
	GlobalDispatcher:removeListener("UpdataZhaohuanShop", self._updataShowScrollRect, self)
	GlobalDispatcher:removeListener(GlobalNotify.HandBookInit, self._updataShowScrollRect, self)
end

function LotteryScoreView:buildUI()
	LotteryScoreView.super.buildUI(self)

	self.viewBgImaGo = self:getGo("viewBgIma")

	local viewInfoGo = self:getGo("viewInfoGo")

	self.viewCloseBtn = Framework.ButtonAdapter.GetFrom(viewInfoGo, "viewCloseBtn")
	self.petIconIma = goutil.findChild(viewInfoGo, "petIconIma"):GetComponent("UIImageSpriteChange")
	self.scoreTxt = goutil.findChildTextComponent(viewInfoGo, "scoreTxt")
	self.tipsTxt = goutil.findChildTextComponent(viewInfoGo, "tipsShowGo/tipsTxt")
	self.scoreTxt.text = ""
	self.tipsTxt.text = ""
	self._btnSort = self:getGo("viewInfoGo/btnSort")
	self._imgChangeSort = goutil.findChildComponent(self._btnSort, "imgSort", "UIImageSpriteChange")
end

function LotteryScoreView:onEnter()
	LotteryScoreView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataZhaohuanShop", self._updataShowScrollRect, self)
	GlobalDispatcher:addListener(GlobalNotify.HandBookInit, self._updataShowScrollRect, self)

	local poolId = 0

	if self._viewPresentor._openParam and checknumber(self._viewPresentor._openParam[1]) > 0 then
		poolId = self._viewPresentor._openParam[1]
	end

	self.poolCfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if self.poolCfg == nil then
		print("sr_召唤精灵    LotteryScoreView:onEnter()  获取的池为空 poolId = ", poolId)

		return
	end

	local path = "ui/bigbg/zhaohuan/" .. self.poolCfg.petBg

	uGuiUtil.setSpriteToImage(self.viewBgImaGo, uGuiUtil.SpriteType.BigBg, path)

	self.isGodShop = false

	local count = 1

	if not string.nilorempty(self.poolCfg.pointPrize) then
		local list = string.split(self.poolCfg.pointPrize, ":")

		if list and checknumber(list[2]) == 19 then
			self.isGodShop = true
		end

		if list and checknumber(list[3]) > 0 then
			count = tonumber(list[3])
		end
	end

	self._sortType = 0

	self:_updataShowScrollRect()

	if self.isGodShop then
		self.tipsTxt.text = langPara("text_lottery_desc_15", count)

		self.petIconIma:SetState(0)
		LotteryController.instance:CSGetLotteryGodShopInfoReq(poolId)
	else
		self.tipsTxt.text = lang("text_lottery_desc_17")

		self.petIconIma:SetState(1)
		LotteryController.instance:CSGetLotteryComShopInfoReq()
	end
end

function LotteryScoreView:_updataShowScrollRect()
	local petDataList

	petDataList, self.scoreCount = LotteryModel.instance:GetAllGoodsItems(self.poolCfg.poolId)

	if self._sortType == 0 then
		self._curViewDatas = petDataList
	elseif self._sortType == 1 then
		ArraySort.sortOn(petDataList, {
			function(data)
				local matType = checknumber(data.prize[1])
				local matId = checknumber(data.prize[2])

				if matType == MatType.Pet then
					if BagModel.instance:isExistRaceId(matId) then
						return 1
					else
						return 0
					end
				else
					return -1
				end
			end,
			function(data)
				local matType = checknumber(data.prize[1])
				local matId = checknumber(data.prize[2])

				if matType == MatType.Pet then
					return BagModel.instance:getMaxAwakenLv(matId)
				else
					return -1
				end
			end
		}, {
			ArraySort.DESCENDING,
			ArraySort.DESCENDING
		})

		self._curViewDatas = petDataList
	elseif self._sortType == 2 then
		ArraySort.sortOn(petDataList, {
			function(data)
				local matType = checknumber(data.prize[1])
				local matId = checknumber(data.prize[2])

				if matType == MatType.Pet then
					if BagModel.instance:isExistRaceId(matId) then
						return 1
					else
						return 0
					end
				else
					return -1
				end
			end,
			function(data)
				local matType = checknumber(data.prize[1])
				local matId = checknumber(data.prize[2])

				if matType == MatType.Pet then
					return BagModel.instance:getMaxAwakenLv(matId)
				else
					return -1
				end
			end
		}, {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		})

		self._curViewDatas = petDataList
	else
		self._curViewDatas = {}
	end

	self._imgChangeSort:SetState(self._sortType)
	self._tableview:ReloadData()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---------  LotteryScoreView:_updataShowScrollRect()    商城配置读取0个？  poolId = " .. self.poolCfg.poolId)
	end

	self.scoreTxt.text = langPara("text_lottery_desc_20", checknumber(self.scoreCount))
end

function LotteryScoreView:_getPath()
	return {
		cellPath = "viewInfoGo/cellItem",
		viewPath = "viewInfoGo/cellItemSR"
	}
end

function LotteryScoreView:_cellSize()
	return 166, 218
end

function LotteryScoreView:_updateCell(view, cell, data)
	local iconGo = goutil.findChild(cell, "iconGo")
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local costTxt = goutil.findChildTextComponent(cell, "costTxt")
	local costImaGo = goutil.findChild(cell, "costTxt/costIma")
	local lockGo = goutil.findChild(cell, "lockGo")
	local buyBtnGo = goutil.findChild(cell, "buyBtn")
	local awake = goutil.findChild(cell, "awake")
	local imgAwake = goutil.findChildComponent(cell, "awake/imgLv", "UIImageSpriteChange")
	local goNotGain = goutil.findChild(cell, "notGain")

	GameUtil.asBtn(lockGo):RemoveClickListener()
	GameUtil.asBtn(buyBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(iconGo)
	MaterialMgr:clearIcon(costImaGo)

	local matType = checknumber(data.prize[1])
	local matId = checknumber(data.prize[2])
	local matCount = checknumber(data.prize[3])
	local matLevel = checknumber(data.prize[4])
	local hwLua = MaterialMgr.setCell(matType, matId, iconGo)

	hwLua.binder:setNum(matCount)
	hwLua.binder:setLvl(matLevel)
	hwLua.binder:setGray(not data.isHave)
	lockGo:SetActive(not data.isHave)

	limitTxt.text = langPara("text_lottery_desc_22", data.haveNum - data.useNum, data.haveNum)
	costTxt.text = data.cost[3]

	MaterialMgr.setIcon(costImaGo, tonumber(data.cost[1]), tonumber(data.cost[2]))

	if not data.isHave then
		GameUtil.asBtn(lockGo):AddClickListener(function()
			FloatWordMgr.instance:show(lang("text_lottery_desc_23"))
		end, self)
	end

	GameUtil.asBtn(buyBtnGo):AddClickListener(function()
		local needCount = tonumber(data.cost[3])
		local petCfg = MaterialMgr.getMatCfg(matType, matId)

		if petCfg then
			if not petCfg.name then
				local petName = "精灵"
				local desStr = langPara("text_lottery_desc_24", needCount, petName)

				TipsFacade.instance:openPopupWindow(lang("text_lottery_buy_tips"), desStr, function()
					if not data.isHave then
						FloatWordMgr.instance:show(lang("text_lottery_desc_23"))

						return
					end

					if checknumber(self.scoreCount) < needCount then
						FloatWordMgr.instance:show(lang("text_lottery_desc_25"))

						return
					end

					if data.haveNum - data.useNum <= 0 then
						FloatWordMgr.instance:show(lang("text_lottery_desc_26"))

						return
					end

					if self.isGodShop then
						LotteryController.instance:CSLotteryBuyGodShopReq(data.itemId, self.poolCfg.poolId)
					else
						LotteryController.instance:CSLotteryBuyCommonShopReq(data.itemId)
					end
				end, nil, lang("text_lottery_buy"), lang("mail_cancel"))
			end
		end
	end, self)

	if matType == MatType.Pet then
		if BagModel.instance:isExistRaceId(matId) then
			goutil.setActive(awake, true)
			goutil.setActive(goNotGain, false)

			local awakenLv = BagModel.instance:getMaxAwakenLv(matId)

			imgAwake:SetState(awakenLv)
		else
			goutil.setActive(awake, false)
			goutil.setActive(goNotGain, true)
		end
	else
		goutil.setActive(awake, false)
		goutil.setActive(goNotGain, false)
	end
end

function LotteryScoreView:_onClickSort()
	self._sortType = self._sortType + 1

	if self._sortType > 2 then
		self._sortType = 0
	end

	self:_updataShowScrollRect()
end

return LotteryScoreView
