-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryPrizeView.lua

module("logic.extensions.lottery.view.LotteryPrizeView", package.seeall)

local LotteryPrizeView = class("LotteryPrizeView", ViewComponent)

function LotteryPrizeView:ctor()
	LotteryPrizeView.super.ctor(self)
end

function LotteryPrizeView:bindEvents()
	LotteryPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnFilter, self._onClickFilter, self)
	GameUtil.addClickHandler(self._btnSort, self._onClickSort, self)
	GameUtil.addClickHandler(self._InputC_Search_Clear, self._onClearSearchClick, self)
	self._inputSearch:AddOnValueChanged(self._OnSearchTextChanged, self)
end

function LotteryPrizeView:unbindEvents()
	LotteryPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSort)
	GameUtil.rmClickHandler(self._btnFilter)
	GameUtil.rmClickHandler(self._InputC_Search_Clear)
	self._inputSearch:RemoveOnValueChanged()
end

function LotteryPrizeView:onExit()
	LotteryPrizeView.super.onExit(self)
	self._scrollListPrize:dispose()
	self._scrollListTab:dispose()
end

function LotteryPrizeView:buildUI()
	LotteryPrizeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSort = self:getGo("btnSort")
	self._imgChangeSort = goutil.findChildComponent(self._btnSort, "imgSort", "UIImageSpriteChange")
	self._btnFilter = self:getGo("btnFilter")
	self._InputC_Search_Clear = self:getGo("InputC_Search/BtnClear")
	self._inputSearch = self:getInput("InputC_Search")

	local RaceFilterGo = self:getGo("RaceFilter")

	self._raceFilter = ItemFilterExt.New(RaceFilterGo, 1, 7, false, "Cell", "Mark")
	self._tablecellTab = self:getGo("tableviewTab/tablecell")
	self._tableviewTab = self:getGo("tableviewTab")
	self._scrollListTab = ScrollerList.create(self._tableviewTab, self._tablecellTab, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._tablecellPrize = self:getGo("tableviewPrize/tablecell")
	self._tableviewPrize = self:getGo("tableviewPrize")
	self._scrollListPrize = ScrollerList.create(self._tableviewPrize, self._tablecellPrize, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function LotteryPrizeView:onEnter()
	LotteryPrizeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.LotterySetPrizeInfo, self.close, self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.poolId == nil then
		print("sr_召唤精灵    LotteryPrizeView:onEnter()  请正确传入参数！！")

		return
	end

	self._posId = checknumber(self._params.posId)
	self._poolId = checknumber(self._params.poolId)
	self._sortType = 0
	self._tabNameList = LotteryController.instance:getTabNameList()
	self._curPosTabList = LotteryConfig.instance:getTabIdxList(self._poolId, self._posId)
	self._tabId = self._curPosTabList[1]

	self:_initData()
	self:_onUpdate()
end

function LotteryPrizeView:_initData()
	self._hasGainPrizeMap = {}

	local prizeItemCfgs = LotteryConfig.instance:getPrizeItemCfgsByPosId(self._poolId, self._posId)

	for i, cfg in ipairs(prizeItemCfgs) do
		local raceId = cfg.raceId
		local matType, matId, matNum = MaterialMgr.getMatParams(cfg.prize)

		raceId = raceId > 0 and raceId or checknumber(matId)
		self._hasGainPrizeMap[raceId] = BagModel.instance:isExistRaceId(raceId)
	end
end

function LotteryPrizeView:_onUpdate()
	self._curViewDatas = LotteryConfig.instance:getPrizeCfgsSortTabList(self._poolId, self._posId, self._tabId)
	self._bigPrizeInfo = LotteryModel.instance:getBigPrizeInfo(self._poolId) or {}
	self._gainInfo = self._bigPrizeInfo.gainInfo or {}

	local finalDatas = {}

	for i, v in ipairs(self._curViewDatas) do
		local prize = v.prize
		local matType, matId, matNum = MaterialMgr.getMatParams(prize)
		local raceId = v.raceId

		if matType == MatType.Pet then
			raceId = matId
		end

		local petData = CharacterConfig.instance:getPetCo(raceId)
		local petName = CharacterConfig.instance:getPetName(raceId)

		if self:_isMatch(petData, raceId) and (not string.nilorempty(self._curSearching) or nil) and string.find(petName, self._curSearching) then
			table.insert(finalDatas, v)
		end
	end

	if self._sortType == 0 then
		-- block empty
	elseif self._sortType == 1 then
		ArraySort.sortOn(finalDatas, {
			function(data)
				return self:_getSortId(data)
			end
		}, {
			ArraySort.DESCENDING
		})
	elseif self._sortType == 2 then
		ArraySort.sortOn(finalDatas, {
			function(data)
				return self:_getSortId(data)
			end
		}, {
			ArraySort.NUMERIC
		})
	end

	self._imgChangeSort:SetState(self._sortType)
	self._scrollListPrize:reloadData(finalDatas)
	self._scrollListTab:reloadData(self._curPosTabList)
end

function LotteryPrizeView:_updatePrizeCell(view, cell, data)
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local select = goutil.findChild(cell, "select")
	local iconGo = goutil.findChild(cell, "iconGo")
	local notGain = goutil.findChild(cell, "notGain")
	local notDivine = goutil.findChild(cell, "notDivine")
	local headIconGo = goutil.findChild(cell, "headIcon")
	local headIcon = goutil.findChild(cell, "headIcon/icon")
	local awake = goutil.findChild(cell, "awake")
	local petName = goutil.findChild(cell, "petName")
	local awakeChangeComp = goutil.findChild(cell, "awake/imgLv"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local txtPetName = goutil.findChildTextComponent(cell, "petName/txt")
	local prizeStr = data.prize
	local raceId = data.raceId
	local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)
	local isPet = matType == MatType.Pet
	local hasEvolve = false
	local hasGet = false
	local awakeLv = 0
	local hasSelect = LotteryController.instance:hasSelectPrize(self._poolId, data.posId, data.id)
	local isLimit = false
	local posId = data.posId

	if checknumber(data.limit) > 0 then
		if ((self._gainInfo[posId] or nil) and checknumber(self._gainInfo[posId][data.id])) >= data.limit then
			isLimit = true
		end
	end

	if not isPet then
		hasEvolve = self._hasGainPrizeMap[raceId]

		MaterialMgr.setIcon(headIcon, MatType.Pet, raceId)
	else
		hasGet = self._hasGainPrizeMap[matId]

		if self._hasGainPrizeMap[matId] then
			awakeLv = BagModel.instance:getMaxAwakenLv(matId)
		end

		raceId = matId

		awakeChangeComp:SetState(awakeLv)
	end

	txtPetName.text = CharacterConfig.instance:getPetName(raceId)

	local proxy = MaterialMgr.setCellByCfg(prizeStr, iconGo)

	proxy.binder:setGray(isLimit)
	GameUtil.SetActive(headIconGo, not isPet)
	GameUtil.SetActive(awake, isPet and hasGet)
	GameUtil.SetActive(notGain, not hasGet and isPet)
	GameUtil.SetActive(notDivine, not hasEvolve and not isPet)
	GameUtil.SetActive(select, hasSelect)
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSelectPrize, self, data))
end

function LotteryPrizeView:_clearPrizeCell(cell)
	local btnSelect = goutil.findChild(cell, "btnSelect")
	local iconGo = goutil.findChild(cell, "iconGo")
	local headIcon = goutil.findChild(cell, "headIcon/icon")

	MaterialMgr.resetAll(iconGo)
	MaterialMgr.clearIcon(headIcon)
	GameUtil.rmClickHandler(btnSelect)
end

function LotteryPrizeView:_onClickSelectPrize(data)
	local posId = data.posId

	if self._bigPrizeInfo.posInfo then
		local posInfo = self._bigPrizeInfo.posInfo[posId]
		local hasPreSelectPrize = posInfo ~= nil
		local curPosHasGain = hasPreSelectPrize and posInfo.isGain
		local prizeStr = data.prize
		local matType, matId, matNum = MaterialMgr.getMatParams(prizeStr)
		local isPet = matType == MatType.Pet
		local isLimit = false
		local posId = data.posId

		if checknumber(data.limit) > 0 then
			if ((self._gainInfo[posId] or nil) and checknumber(self._gainInfo[posId][data.id])) >= data.limit then
				isLimit = true
			end
		end

		if curPosHasGain then
			FloatWordMgr.instance:show("当前位置已选择并领取过大奖,无法再次选择")

			return
		end

		if isLimit then
			FloatWordMgr.instance:show("已超过可选择奖励的限制次数")

			return
		end

		if hasPreSelectPrize and data.id == posInfo.prizeId then
			FloatWordMgr.instance:show("已选择该精灵座位心愿精灵")

			return
		end

		local name = ""
		local content = ""

		if isPet then
			local petData = CharacterConfig.instance:getPetCo(matId)

			if petData then
				name = string.format("%s*%s", petData.name, matNum)
			end
		else
			local matName = MaterialMgr.getMaterialsName(matType, matId)

			name = string.format("%s*%s", matName, matNum)
		end

		if hasPreSelectPrize then
			local prePrizeId = posInfo.prizeId
			local prePrizeCfg = LotteryConfig.instance:getPrizeItemCfgById(self._poolId, posId, prePrizeId)
			local preIsPet = prePrizeCfg.raceId <= 0
			local preName = ""
			local preMatType, preMatId, preMatNum = MaterialMgr.getMatParams(prePrizeCfg.prize)

			if preIsPet then
				local prePetData = CharacterConfig.instance:getPetCo(preMatId)

				if prePetData then
					preName = string.format("%s*%s", prePetData.name, preMatNum)
				end
			else
				local matName = MaterialMgr.getMaterialsName(preMatType, preMatId)

				preName = string.format("%s*%s", matName, preMatNum)
			end

			content = string.format("是否将%s更换成%s?", preName, name)
		else
			content = string.format("是否将%s设置为超级大奖?", name)
		end

		TipsFacade.instance:openPopupWindow("提示", content, function()
			local info = {}

			info[1] = {
				posId = data.posId,
				prizeId = data.id
			}

			LotteryController.instance:csGetLotterySelectPrizeSetPosReq(self._poolId, info)
		end, nil, "确定", "取消")
	end
end

function LotteryPrizeView:_updateTabCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local imgNor = goutil.findChild(cell, "imgNor")
	local txtSelectGo = goutil.findChild(cell, "txtSelectGo")
	local txtSelect = goutil.findChildTextComponent(cell, "txtSelectGo/txt")
	local txtNorGo = goutil.findChild(cell, "txtNorGo")
	local txtNor = goutil.findChildTextComponent(cell, "txtNorGo/txt")
	local isSelect = data == self._tabId
	local name = self._tabNameList[data]

	txtSelect.text = name
	txtNor.text = name

	GameUtil.SetActive(imgSelect, isSelect)
	GameUtil.SetActive(txtSelectGo, isSelect)
	GameUtil.SetActive(imgNor, not isSelect)
	GameUtil.SetActive(txtNorGo, not isSelect)
	GameUtil.addClickHandler(cell, function()
		self._tabId = data

		PetFilterMgr.instance:resetDataByType(PetFilterMgr.TYPE_LOTTERY_PRIZE)
		self:_onUpdate()
	end, self)
end

function LotteryPrizeView:_clearTabCell(cell)
	GameUtil.rmClickHandler(cell)
end

function LotteryPrizeView:_onClearSearchClick()
	self._inputSearch.input.text = ""
end

function LotteryPrizeView:_OnSearchTextChanged()
	local text = self._inputSearch:GetText()

	if text ~= self._curSearching then
		self._curSearching = text

		self:_onUpdate()
	end
end

function LotteryPrizeView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_LOTTERY_PRIZE, cfg, rare, skinId)
end

function LotteryPrizeView:_onClickFilter()
	local pos, sizeDelta = GameUtil.getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_LOTTERY_PRIZE, pos, sizeDelta, GameUtil.handler(self.updateFilterData, self))
end

function LotteryPrizeView:updateFilterData(starList, jobList, rareList)
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_LOTTERY_PRIZE)

	self._raceFilter:initData(data.raceSelectList)
	self._raceFilter:initActiveList(data.raceActiveList)
	self._raceFilter:initClickAble(data.raceClickAble)
	self:_onUpdate()
end

function LotteryPrizeView:_getSortId(data)
	local prizeStr = data and data.prize

	if GameUtil.isEmptyString(prizeStr) then
		printError("超级大奖奖励配置丢失")

		return -5
	elseif checknumber(data.raceId) > 0 then
		if self._hasGainPrizeMap[data.raceId] then
			return -3
		else
			return -4
		end
	else
		local matType, matid, matNum = MaterialMgr.getMatParams(data.prize)

		if matType == MatType.Pet then
			if BagModel.instance:isExistRaceId(matid) then
				return BagModel.instance:getMaxAwakenLv(matid)
			else
				return -1
			end
		else
			return -2
		end
	end
end

function LotteryPrizeView:_onClickSort()
	self._sortType = self._sortType + 1

	if self._sortType > 2 then
		self._sortType = 0
	end

	self:_onUpdate()
end

return LotteryPrizeView
