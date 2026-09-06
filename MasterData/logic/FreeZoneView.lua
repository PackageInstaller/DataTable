-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/FreeZoneView.lua

module("logic.extensions.doubleeleven.view.FreeZoneView", package.seeall)

local FreeZoneView = class("FreeZoneView", TableViewComponent)

FreeZoneView.SORT_STATE_NUM = 3
FreeZoneView.SORT_STATE = {
	ORD = 2,
	REVERSE_ORD = 1,
	NONE = 0
}

function FreeZoneView:ctor()
	FreeZoneView.super.ctor(self)

	self._isShowFree = nil
end

function FreeZoneView:bindEvents()
	FreeZoneView.super.bindEvents(self)
	GameUtil.asBtn(self._freeBtnGo):AddClickListener(function()
		self:_updataShowFreeLuckyRanks(true, true)
	end, self)
	GameUtil.asBtn(self._luckyBtnGo):AddClickListener(function()
		self:_updataShowFreeLuckyRanks(false, true)
	end, self)
	GameUtil.asBtn(self._btnTips):AddClickListener(function()
		TipsFacade:openRulesView("doubleeleven")
	end, self)
	GameUtil.addClickHandler(self._btnClear, self._onClickBtnClear, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickBtnSort, self)
	self._inputComp:AddOnValueChanged(self._inputValueChanged, self)
end

function FreeZoneView:unbindEvents()
	FreeZoneView.super.unbindEvents(self)
	GameUtil.asBtn(self._freeBtnGo):RemoveClickListener()
	GameUtil.asBtn(self._luckyBtnGo):RemoveClickListener()
	GameUtil.asBtn(self._btnTips):RemoveClickListener()
	GameUtil.rmClickHandler(self._btnClear)
	GameUtil.rmClickHandler(self._btnSort)
	self._inputComp:RemoveOnValueChanged()
end

function FreeZoneView:onExit()
	FreeZoneView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataFreeZoneInfo, self._updataViewShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataFreeZonePrize, self._updataViewShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.DE_UpdataFreeZoneRank, self._updataShowFreeLuckyRanks, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	self._loopRoller:dispose()

	self._curViewDatas = nil
end

function FreeZoneView:destroyUI()
	FreeZoneView.super.destroyUI(self)

	self._isShowFree = nil
end

function FreeZoneView:buildUI()
	FreeZoneView.super.buildUI(self)

	self._descTxt = self:getTxt("descTxt")
	self._timeTxt = self:getTxt("timeTxt")
	self._freeBtnGo = self:getGo("luckyRankGo/freeBtnGo")
	self._freeBtnGrp = self._freeBtnGo:GetComponent("UIChangeGroup")
	self._luckyBtnGo = self:getGo("luckyRankGo/luckyBtnGo")
	self._luckyBtnGrp = self._luckyBtnGo:GetComponent("UIChangeGroup")
	self._btnTips = self:getGo("btnTips")
	self._descTxt.text = ""
	self._timeTxt.text = ""
	self._txtTime2 = self:getTxt("time/txt")
	self._btnClear = self:getBtn("searchpart/btnClear")
	self._inputComp = self:getInput("searchpart/search")
	self._searchpartGo = self:getGo("searchpart")
	self._btnSort = self:getGo("btnSort")
	self._imgSortChange = self:getGo("btnSort/ImgSort"):GetComponent(ComponentType.UIImageSpriteChange)
end

function FreeZoneView:onEnter()
	FreeZoneView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DE_UpdataFreeZoneInfo, self._updataViewShow, self)
	GlobalDispatcher:addListener(GlobalNotify.DE_UpdataFreeZonePrize, self._updataViewShow, self)
	GlobalDispatcher:addListener(GlobalNotify.DE_UpdataFreeZoneRank, self._updataShowFreeLuckyRanks, self)

	self._baseCfg = DoubleElevenConfig.instance:getFreeZoneBaseCfgs()
	self._descTxt.text = lang("text_doubleeleven_desc_11")
	self._sortState = FreeZoneView.SORT_STATE.NONE
	self._isShowFree = true
	self._loopRoller = self._loopRoller or LoopRoller.New(self:getGo("luckyRankGo"))

	self._loopRoller:init({
		margin = 2,
		updateCellFunc = self._updateRollerCell,
		removeCellFunc = self._removeRollerCell,
		thisArg = self,
		direction = LoopRoller.Direction_B2T,
		weekAlign = LoopRoller.WeekAlign_LeftOrTop,
		speed = self._baseCfg.speed
	})
	self:_updataViewShow()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
	DoubleElevenController.instance:csGetFreePayStoreGetInfoReq(self._baseCfg.activityId)
end

function FreeZoneView:_updataViewShow(resultType)
	resultType = checknumber(resultType)

	if resultType == 2 or resultType == 3 then
		DoubleElevenController.instance:csGetFreePayStoreGetRanTextReq(self._baseCfg.activityId)
	else
		self:_updataShowFreeLuckyRanks()
	end

	local text = self._inputComp:GetText()
	local cfgs = DoubleElevenConfig.instance:getFreeZonePlanCfgs(self._baseCfg.itemPlan) or {}

	self._curViewDatas = {}

	if string.nilorempty(text) then
		table.insertto(self._curViewDatas, cfgs)
	else
		for i, cfg in ipairs(cfgs) do
			local name = MaterialMgr.getMaterialsNameByCfg(cfg.prize)

			if string.find(name, text) then
				table.insert(self._curViewDatas, cfg)
			end
		end
	end

	self:_sortTableDatas()
	self._tableview:ReloadData()
end

function FreeZoneView:_updataShowFreeLuckyRanks(isFree, isClick)
	if isFree ~= nil and self._isShowFree == isFree and isClick then
		return
	end

	if isFree ~= nil then
		self._isShowFree = isFree
	end

	if self._isShowFree then
		self._freeBtnGrp:SetState(1)
		self._luckyBtnGrp:SetState(0)
		self._loopRoller:reload(DoubleElevenModel.instance:getFreeZoneFreeRanks())
	else
		self._freeBtnGrp:SetState(0)
		self._luckyBtnGrp:SetState(1)
		self._loopRoller:reload(DoubleElevenModel.instance:getFreeZoneLuckyRanks())
	end

	self._loopRoller:play()
end

function FreeZoneView:_updateRollerCell(item, data, index)
	local loopIcc = goutil.findChild(item, "loopIcc"):GetComponent("UIImageColorChange")
	local loopTxt = goutil.findChildTextComponent(item, "loopTxt")

	GameUtil.asBtn(item):RemoveClickListener()

	local value = index - math.floor(index / 2) * 2

	loopIcc:SetState(value)

	loopTxt.text = langPara("text_doubleeleven_desc_14", data.areaName, data.playerName, data.freeNum)

	GameUtil.asBtn(item):AddClickListener(function()
		FriendController.instance:showInfoView(data.userId, item)
	end, self)
end

function FreeZoneView:_removeRollerCell(item)
	GameUtil.asBtn(item):RemoveClickListener()
end

function FreeZoneView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "itemListSR"
	}
end

function FreeZoneView:_cellSize()
	return 176, 252
end

function FreeZoneView:_updateCell(view, cell, data)
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local zhekouGo = goutil.findChild(cell, "zhekouGo")
	local zhekouTxt = goutil.findChildTextComponent(zhekouGo, "zhekouTxt")
	local clickGo = goutil.findChild(cell, "clickGo")
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local rateTxt = goutil.findChildTextComponent(cell, "rateTxt")
	local countTxt = goutil.findChildTextComponent(cell, "countTxt")
	local iconGo = goutil.findChild(cell, "countTxt/iconGo")
	local selloutGo = goutil.findChild(cell, "selloutGo")
	local lockGo = goutil.findChild(cell, "lockGo")

	GameUtil.asBtn(clickGo):RemoveClickListener()
	MaterialMgr.resetAll(goodsPos)
	MaterialMgr.resetAll(iconGo)
	MaterialMgr.setCellByCfg(data.prize, goodsPos)

	local name = MaterialMgr.getMaterialsNameByCfg(data.prize)

	nameTxt.text = name

	if string.nilorempty(data.cutDisplay) then
		zhekouTxt.text = ""

		GameUtil.SetActive(zhekouGo, false)
	else
		GameUtil.SetActive(zhekouGo, true)

		zhekouTxt.text = data.cutDisplay
	end

	local isSellOut = false

	if data.personLimit >= 99999 then
		limitTxt.text = "不限购"
	else
		local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(data.itemId)
		local use = info and checknumber(info.buyTime) or 0

		limitTxt.text = langPara("text_doubleeleven_desc_6", math.max(0, data.personLimit - use), data.personLimit)
		isSellOut = use >= data.personLimit
	end

	if not isSellOut then
		if self._baseCfg.activityId == 211003 and data.itemId == 9 then
			local buyCnt = 0

			for i = 7, 8 do
				local itemId = i
				local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(itemId)

				if info and info.buyTime and info.buyTime > 0 then
					local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(self._baseCfg.itemPlan, itemId)

					if info.buyTime >= cfg.personLimit then
						buyCnt = buyCnt + 1
					end
				end
			end

			isSellOut = buyCnt >= 1
		elseif self._baseCfg.activityId == 211003 and (data.itemId == 7 or data.itemId == 8) then
			local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(9)

			if info and info.buyTime and info.buyTime > 0 then
				local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(self._baseCfg.itemPlan, 9)

				if info.buyTime >= cfg.personLimit then
					isSellOut = true
				end
			end
		end

		if isSellOut and data.personLimit < 99999 then
			limitTxt.text = langPara("text_doubleeleven_desc_6", 0, data.personLimit)
		end
	end

	local openTimeStamp = GameUtil.string2time(data.startTime)
	local isInTime = openTimeStamp < ServerTime.now()

	GameUtil.SetActive(selloutGo, isSellOut)
	GameUtil.SetActive(lockGo, not isInTime)

	rateTxt.text = langPara("text_doubleeleven_desc_10", data.clientRate)

	if string.nilorempty(data.cost) then
		countTxt.text = "免费"

		GameUtil.SetActive(iconGo, false)
	else
		GameUtil.SetActive(iconGo, true)

		local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)

		countTxt.text = matNum .. MaterialMgr.getMaterialsName(matType, matId)

		MaterialMgr.setIcon(iconGo, matType, matId)
	end

	GameUtil.asBtn(clickGo):AddClickListener(function()
		if isSellOut then
			FloatWordMgr.instance:show(lang("text_doubleeleven_desc_7"))

			return
		end

		if string.nilorempty(data.cost) then
			DoubleElevenController.instance:csGetFreePayStoreBuyReq(self._baseCfg.activityId, data.itemId)
		else
			local addStr = ""

			if self._baseCfg.activityId == 211003 and data.itemId == 9 then
				addStr = "购买【弥梦离礼包】后无法购买【弥梦离精灵】和【弥梦离皮肤】。"
			elseif self._baseCfg.activityId == 211003 and (data.itemId == 7 or data.itemId == 8) then
				local hasBuyOne = false

				for i = 7, 8 do
					local itemId = i
					local info = DoubleElevenModel.instance:getFreeZoneBuyInfo(itemId)

					if info and info.buyTime and info.buyTime > 0 then
						local cfg = DoubleElevenConfig.instance:getFreeZoneItemCfg(self._baseCfg.itemPlan, itemId)

						if info.buyTime >= cfg.personLimit then
							hasBuyOne = true

							break
						end
					end
				end

				if not hasBuyOne then
					addStr = "购买【弥梦离精灵】、【弥梦离皮肤】后无法购买【弥梦离礼包】。"
				end
			end

			if not isInTime then
				local timeStr = GameUtil.formatTimeStamp("%m月%d日%H:%S后解锁购买", openTimeStamp)

				FloatWordMgr.instance:show(timeStr)

				return
			end

			local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)
			local matStr = matNum .. MaterialMgr.getMaterialsName(matType, matId)
			local content = string.format("确定花费%s购买<color=#05a62f>【%s】</color>礼包吗？%s", matStr, name, addStr)

			TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
				DoubleElevenController.instance:csGetFreePayStoreBuyReq(self._baseCfg.activityId, data.itemId)
			end)
		end
	end, self)
end

function FreeZoneView:_clearTableview(cell)
	local goodsPos = goutil.findChild(cell, "goodsPos")

	MaterialMgr.resetAll(goodsPos)
end

function FreeZoneView:_inputValueChanged(text)
	if self._inputComp:GetText() == self._lastInputTxt then
		return
	end

	self._lastInputTxt = text

	self:_updataViewShow()
end

function FreeZoneView:_sortTableDatas()
	local names = {}
	local opt = {}

	if self._sortState ~= FreeZoneView.SORT_STATE.NONE then
		local function sortFunc(cfg)
			local cost = cfg.cost
			local matType, matId, matNum = MaterialMgr.getMatParams(cost)

			if matType == MatType.GodGem then
				return 1
			end

			return 0
		end

		local function sortFunc2(cfg)
			local cost = cfg.cost
			local matType, matId, matNum = MaterialMgr.getMatParams(cost)

			return matNum
		end

		opt = self._sortState == FreeZoneView.SORT_STATE.ORD and {
			ArraySort.NUMERIC,
			ArraySort.NUMERIC
		} or {
			ArraySort.DESCENDING,
			ArraySort.DESCENDING
		}

		table.insert(names, sortFunc)
		table.insert(names, sortFunc2)
		ArraySort.sortOn(self._curViewDatas, names, opt)
	end
end

function FreeZoneView:_onClickBtnClear()
	self._lastInputTxt = ""

	self._inputComp:SetText("")
	self:_updataViewShow()
end

function FreeZoneView:_onClickBtnSort()
	self._sortState = (self._sortState + 1) % FreeZoneView.SORT_STATE_NUM

	self._imgSortChange:SetState(self._sortState)
	self:_updataViewShow()
end

return FreeZoneView
