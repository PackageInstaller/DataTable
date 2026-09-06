-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryWishView.lua

module("logic.extensions.lottery.view.LotteryWishView", package.seeall)

local LotteryWishView = class("LotteryWishView", TableViewComponent)

function LotteryWishView:ctor()
	LotteryWishView.super.ctor(self)

	self.rewardGoodsList = nil
end

function LotteryWishView:bindEvents()
	LotteryWishView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
end

function LotteryWishView:unbindEvents()
	LotteryWishView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnSort)
end

function LotteryWishView:onEnterFinished()
	return
end

function LotteryWishView:onExitFinished()
	return
end

function LotteryWishView:destroyUI()
	LotteryWishView.super.destroyUI(self)
end

function LotteryWishView:onExit()
	LotteryWishView.super.onExit(self)
	GlobalDispatcher:removeListener("UpdataLotteryWishPets", self.close, self)
end

function LotteryWishView:buildUI()
	LotteryWishView.super.buildUI(self)

	self.viewBgImaGo = self:getGo("viewBgIma")

	local viewInfoGo = self:getGo("viewInfoGo")

	self.viewCloseBtn = Framework.ButtonAdapter.GetFrom(viewInfoGo, "viewCloseBtn")
	self.desStrTxt = goutil.findChildTextComponent(viewInfoGo, "desStrTxt")
	self.tipsShowGo = goutil.findChild(viewInfoGo, "tipsShowGo")
	self.choiPetGo = goutil.findChild(viewInfoGo, "choiPetGo")
	self.desStrTxt.text = ""

	GameUtil.SetActive(self.tipsShowGo, false)

	self._btnSort = self:getGo("viewInfoGo/btnSort")
	self._imgChangeSort = goutil.findChildComponent(self._btnSort, "imgSort", "UIImageSpriteChange")
end

function LotteryWishView:onEnter()
	LotteryWishView.super.onEnter(self)
	GlobalDispatcher:addListener("UpdataLotteryWishPets", self.close, self)

	local poolId = 0

	if self._viewPresentor._openParam and checknumber(self._viewPresentor._openParam[1]) > 0 then
		poolId = self._viewPresentor._openParam[1]
	end

	self.poolCfg = LotteryConfig.instance:GetPoolCfg(poolId)

	if self.poolCfg == nil then
		print("sr_召唤精灵    LotteryWishView:onEnter()  获取的池为空 poolId = ", poolId)

		return
	end

	local path = "ui/bigbg/zhaohuan/" .. self.poolCfg.petBg

	uGuiUtil.setSpriteToImage(self.viewBgImaGo, uGuiUtil.SpriteType.BigBg, path)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.LOTTERY_WITH_VIEW_OPEN)

	self._sortType = 0

	self:_updataShowScrollRect()
end

function LotteryWishView:_updataShowScrollRect()
	local petDataList

	petDataList, self.wishPetId = LotteryModel.instance:GetWishLegendList(self.poolCfg.poolId)

	if self._sortType == 0 then
		self._curViewDatas = petDataList
	elseif self._sortType == 1 then
		ArraySort.sortOn(petDataList, {
			function(data)
				if BagModel.instance:isExistRaceId(data) then
					return 1
				else
					return 0
				end
			end,
			function(data)
				return BagModel.instance:getMaxAwakenLv(data)
			end
		}, {
			ArraySort.DESCENDING,
			ArraySort.DESCENDING
		})

		self._curViewDatas = petDataList
	elseif self._sortType == 2 then
		ArraySort.sortOn(petDataList, {
			function(data)
				if BagModel.instance:isExistRaceId(data) then
					return 1
				else
					return 0
				end
			end,
			function(data)
				return BagModel.instance:getMaxAwakenLv(data)
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

	self._curMoveToId = 0

	for i, data in ipairs(self._curViewDatas) do
		if data == checknumber(self.wishPetId) then
			self._curMoveToId = i - 1

			break
		end
	end

	self._tableview:ReloadData()

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---------  LotteryWishView:_updataShowScrollRect()    召唤配置读取0个？  poolId = " .. self.poolCfg.poolId)
	end

	self.desStrTxt.text = langPara("text_lottery_desc_27", self.poolCfg.wishRatio)

	MaterialMgr.resetAll(self.choiPetGo)

	if checknumber(self.wishPetId) > 0 then
		local hwLua = MaterialMgr.setCell(MatType.Pet, self.wishPetId, self.choiPetGo)

		hwLua.binder:setNum(1)
		hwLua.binder:setLvl(1)
	end
end

function LotteryWishView:_getPath()
	return {
		cellPath = "viewInfoGo/cellItem",
		viewPath = "viewInfoGo/cellItemSR"
	}
end

function LotteryWishView:_cellSize()
	return 166, 218
end

function LotteryWishView:_onReloadFinish()
	self._tableview:MoveCellInView(self._curMoveToId, false)
end

function LotteryWishView:_updateCell(view, cell, data)
	local iconGo = goutil.findChild(cell, "iconGo")
	local stageGo = goutil.findChild(cell, "stageGo")
	local buyBtnGo = goutil.findChild(cell, "buyBtn")
	local awake = goutil.findChild(cell, "awake")
	local imgAwake = goutil.findChildComponent(cell, "awake/imgLv", "UIImageSpriteChange")
	local goNotGain = goutil.findChild(cell, "notGain")

	GameUtil.asBtn(buyBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(iconGo)

	local hwLua = MaterialMgr.setCell(MatType.Pet, data, iconGo)

	hwLua.binder:setNum(1)
	hwLua.binder:setLvl(1)
	stageGo:SetActive(data == checknumber(self.wishPetId))
	GameUtil.asBtn(buyBtnGo):AddClickListener(function()
		if data == checknumber(self.wishPetId) then
			FloatWordMgr.instance:show(lang("text_lottery_desc_28"))

			return
		end

		local petCfg = MaterialMgr.getMatCfg(MatType.Pet, data)

		if petCfg then
			if not petCfg.name then
				local petName = "精灵"
				local desStr = langPara("text_lottery_desc_29", petName)

				TipsFacade.instance:openPopupWindow(lang("text_lottery_wish_tips"), desStr, function()
					LotteryController.instance:CSLotterySelectWishPetReq(self.poolCfg.poolId, data)
				end, nil, lang("mail_confirm"), lang("mail_cancel"))
			end
		end
	end, self)

	if BagModel.instance:isExistRaceId(data) then
		goutil.setActive(awake, true)
		goutil.setActive(goNotGain, false)

		local awakenLv = BagModel.instance:getMaxAwakenLv(data)

		imgAwake:SetState(awakenLv)
	else
		goutil.setActive(awake, false)
		goutil.setActive(goNotGain, true)
	end
end

function LotteryWishView:_onClickSort()
	self._sortType = self._sortType + 1

	if self._sortType > 2 then
		self._sortType = 0
	end

	self:_updataShowScrollRect()
end

return LotteryWishView
