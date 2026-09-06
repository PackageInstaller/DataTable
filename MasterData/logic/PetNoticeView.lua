-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetNoticeView.lua

module("logic.extensions.recommendfmt.view.PetNoticeView", package.seeall)

local PetNoticeView = class("PetNoticeView", ViewComponent)
local PageIndex

function PetNoticeView:ctor()
	PetNoticeView.super.ctor(self)
end

function PetNoticeView:unbindEvents()
	PetNoticeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnMore:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnWish)
end

function PetNoticeView:bindEvents()
	PetNoticeView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		PageIndex = nil

		self:close()
	end, self)
	self._btnMore:AddClickListener(self._onClickMore, self)
	GameUtil.addClickHandler(self._btnWish, self._onClickBtnWish, self)
end

function PetNoticeView:buildUI()
	PetNoticeView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btn_close")
	self._tabs = {}

	local tabs = self:getGo("tabGroup")

	for i = 1, 7 do
		local tab = {}
		local go = goutil.findChild(tabs, "tab_" .. i)

		tab.btn = Framework.ButtonAdapter.Get(go)
		tab.uiChange = go:GetComponent("UIChangeGroup")

		tab.btn:AddClickListener(function()
			self:_onClickTab(i)
		end)

		tab.redPoint = goutil.findChild(go, "imgPoint")

		table.insert(self._tabs, tab)
	end

	self._container = self:getGo("container")
	self._scrollObj = self:getGo("tableview")
	self._tableCell = self:getGo("cell")

	self._tableCell:SetActive(false)

	self._tableview = ScrollerList.create(self._scrollObj, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearTableview, self))
	self._bg = self:getGo("bg")
	self._scrollObj1 = self:getGo("tableview1")
	self._tableCell1 = self:getGo("cell1")

	self._tableCell1:SetActive(false)

	self._tableview1 = ScrollerList.create(self._scrollObj1, self._tableCell1, GameUtil.handler(self._updateCell1, self), GameUtil.handler(self._clearTableview1, self))
	self._pageScrollObj = self:getGo("pagescrollview")
	self._pageCell = self:getGo("pagecell")
	self._pagetableview = ScrollerList.create(self._pageScrollObj, self._pageCell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageTableview, self))

	self._pagetableview:regGetCellSize(function(view, index)
		return self:_pageCellSize(view, index)
	end)

	self._dropLineRectTrans = self:getGo("pagescrollview/viewport/content/dropLine"):GetComponent(goutil.Type_RectTransform)

	self:_initScrollBgParam()

	self._btnMore = self:getBtn("btnMore")
	self._emptyTip = self:getGo("emptyTip")
	self._btnWish = goutil.findChild(self.mainGO, "btnWish")

	GameUtil.saveUserDayData("petnoticered", "1")
end

function PetNoticeView:onExit()
	PetNoticeView.super.onExit(self)
	self._tableview:dispose()
	self._tableview1:dispose()
	self._pagetableview:dispose()
end

function PetNoticeView:onEnter()
	PetNoticeView.super.onEnter(self)

	local param = self:getFirstParam()

	param = checknumber(param)
	param = param > 0 and param or PageIndex or 1

	self:_onClickTab(param)
	self:_initTabList(param)
	self:_updateTabList(self:_getClickIndexByChildIndex(param))
end

function PetNoticeView:_onClickMore()
	UIStateManager.instance:push(ViewName.ContractBookView)
end

function PetNoticeView:_setPetList(index)
	printInfo("test _setPetList", index)

	local infoList = PetNoticeConfig.instance:getPetNewCfgs(index)

	self._scrollObj:SetActive(true)
	self._tableview:reloadData(infoList)
	self._tableview:refresh()
end

function PetNoticeView:_clearTableview(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "container"))
	GameUtil.rmClickHandler(goutil.findChild(cell, "container/imgBook"))
	RedPointController.instance:unregRedPoint(goutil.findChild(cell, "container/imgPoint"))
end

function PetNoticeView:_onClickTab(index)
	self._scrollObj:SetActive(false)
	self._scrollObj1:SetActive(false)
	self._bg:SetActive(index ~= 5)
	self:_resetContractGo()

	PageIndex = index

	local cfgBigTab = PetNoticeConfig.instance:getBigTabCfgBySmallTabIndex(index)

	if cfgBigTab and cfgBigTab.isHide then
		if ViewMgr.instance:isOpen(cfgBigTab.tabViewName) then
			ViewMgr.instance:close(cfgBigTab.tabViewName)
		end

		self:showTabAt(self._container, cfgBigTab.tabViewName, cfgBigTab.index)
	else
		local config = PetNoticeConfig.instance:getSmallTabCfg(index)

		if checknumber(config.reportBehavior) > 0 then
			SurveyController.instance:reportBehavior(config.reportBehavior)
		end

		self:showTabAt(self._container, config.viewName)

		if config.listIndex == 1 then
			self:_setPetList(index)
		elseif config.listIndex == 2 then
			self._scrollObj1:SetActive(true)

			local infoList = PetNoticeConfig.instance:getContractCfgs()

			self._tableview1:reloadData(infoList)
			self._tableview1:refresh()
			self:_updateContractGo(#infoList == 0)
		end
	end
end

function PetNoticeView:_resetContractGo()
	goutil.setActive(self._emptyTip, false)
	goutil.setActive(self._btnMore.gameObject, false)
end

function PetNoticeView:_updateContractGo(isShowTip)
	goutil.setActive(self._emptyTip, isShowTip)
	goutil.setActive(self._btnMore.gameObject, true)
end

function PetNoticeView:_getOpenDateStr(leftTime)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime > 0 and leftTime or 0)

	return day > 0 and string.format("活动剩余：%d天 %d小时", day, hour) or hour > 0 and string.format("活动剩余：%d小时", hour) or "活动剩余：1小时"
end

function PetNoticeView:_updateCell(index, cell, data)
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(data.skinId)
	local maxPower = FightingPowerFormula.instance:getPetMaxFightingPower(infoPet.raceId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId) % 10 - 1
	local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(data.skinId)
	local isOpen = GameUtil.getTimePeriodType(data.startTime, data.endTime, false) ~= GameUtil.beforeTimePeriod
	local isSkin = data.type == 2
	local rare = CharacterConfig.instance:getInitRare(infoPet.raceId)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(data.skinId).quality
	local ModelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))
	local imgPath = data.resources == "" and GameUrl.getPetImgUrl(ModelCo.cardName) or data.resources .. ".png"
	local styCfg = PetStrategyConfig.instance:getStrategyById(infoPet.raceId)

	if isSkin then
		local var_17_0 = data.getDescription

		if not data.getDescription then
			if styCfg then
				var_17_0 = styCfg.resume

				if not styCfg.resume then
					local downTxt = "请配置精灵攻略表"
					local haveEq = data.sqContent ~= nil and data.sqContent ~= ""
					local openDateStr = "永久开放"
					local dateTimeGo = goutil.findChild(cell, "container/showDate")
					local power = goutil.findChild(cell, "container/txtPower")
					local txtPower = goutil.findChildTextComponent(cell, "container/txtPower/txt")
					local imgPower = goutil.findChild(cell, "container/txtPower"):GetComponent("UIImageSpriteChange")

					txtPower.text = ""

					if data.juCombat and checknumber(data.juCombat) > 0 and checknumber(data.reCombat) > 0 then
						local isEnough = RoleModel.instance:getMaxPower() > checknumber(data.juCombat)

						if isEnough then
							txtPower.text = "推荐战力:" .. data.reCombat or "挑战难度:噩梦"
						end

						imgPower:SetState(isEnough and 0 or 1)
						goutil.setActive(power, true)
					else
						goutil.setActive(power, false)
					end

					if data.startTime and data.endTime then
						local timestamp1 = GameUtil.string2time(data.startTime)
						local timestamp2 = GameUtil.string2time(data.endTime)

						if timestamp1 <= ServerTime.now() then
							goutil.setActive(dateTimeGo, true)

							local leftTime = timestamp2 - ServerTime.now()

							openDateStr = self:_getOpenDateStr(leftTime)
						else
							goutil.setActive(dateTimeGo, false)
						end
					else
						goutil.setActive(dateTimeGo, true)
					end

					goutil.findChildTextComponent(cell, "container/showDate/txt").text = openDateStr

					local btnObj = goutil.findChild(cell, "container")

					goutil.findChildTextComponent(btnObj, "namebg/txt").text = infoPet.skinName
					goutil.findChildTextComponent(btnObj, "imgDown/txt").text = downTxt

					local mark = checknumber(data.mark)

					goutil.findChild(btnObj, "imgDown/mode"):SetActive(mark > 0)

					if mark > 0 then
						GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "imgDown/mode/imgMode")):SetState(mark - 1)
					end

					if not isOpen then
						local day = GameUtil.getDaysByTimestamp(ServerTime.now(), GameUtil.string2time(data.startTime)) - 1

						goutil.findChildTextComponent(btnObj, "openTime/txt").text = string.format("%s天后开启", day)
					end

					goutil.findChild(btnObj, "openTime"):SetActive(not isOpen)
					goutil.findChild(btnObj, "noGet"):SetActive(not isGet)

					if haveEq then
						goutil.findChildTextComponent(btnObj, "tag/txt").text = data.sqContent
					end

					goutil.findChild(btnObj, "tag"):SetActive(haveEq)
					goutil.findChild(btnObj, "layout/Nego_Skin"):SetActive(isSkin)

					local attrIcon = goutil.findChildComponent(btnObj, "layout/Nego_Attr/Img_attr", "UIImageSpriteChange")

					attrIcon:SetState(race)

					local imageObj = goutil.findChild(btnObj, "mask/con")

					uGuiUtil.setSpriteToImage(imageObj, uGuiUtil.SpriteType.BigBg, imgPath)

					local btnBook = goutil.findChild(btnObj, "imgBook")
					local attrObj = goutil.findChild(btnObj, "layout/Nego_Attr")

					GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "bg")):SetState(rare)
					GameUtil.getUIImageSpriteChange(attrObj):SetState(rare)
					GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "layout/Nego_Skin/skin")):SetState(rareSkin)
					btnBook:SetActive(not isSkin and PageIndex ~= 1)
					attrObj:SetActive(not isSkin)

					GameUtil.asBtn(btnBook).enabled = isOpen

					GameUtil.asBtn(btnBook):AddClickListener(function()
						PetbookController.instance:openPetinfoView(infoPet.raceId)
					end, self)
					GameUtil.asBtn(btnObj):AddClickListener(function()
						self:_onClickPetNew(isOpen, data)
					end, self)

					local redPoint = goutil.findChild(btnObj, "imgPoint")

					RedPointController.instance:unregRedPoint(redPoint)
					RedPointController.instance:regRedPoint(redPoint, unpack(string.splitToNumber(data.redPoint or "", "#")))
				end
			end
		end
	end
end

function PetNoticeView:_onClickPetNew(isOpen, data)
	if not isOpen then
		FloatWordMgr.instance:show("暂未开放")

		return
	end

	if checknumber(data.reportBehavior) > 0 then
		SurveyController.instance:reportBehavior(checknumber(data.reportBehavior))
	end

	if data.jumpType == 1 then
		if data.type == 1 then
			local raceId = PetSkinConfig.instance:getPetSkinCfg(data.skinId).raceId

			MaterialMgr.openGetSource(MatType.Pet, raceId)
		elseif data.type == 2 then
			MaterialMgr.openGetSource(MatType.PET_SKIN, data.skinId)
		end
	else
		GotoMgr.gotoByString(data.funcId)
	end
end

function PetNoticeView:_updateCell1(index, cell, data)
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(data.skinId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId) % 10 - 1
	local rare = CharacterConfig.instance:getInitRare(infoPet.raceId)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(data.skinId).quality
	local ModelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))
	local imgPath = GameUrl.getPetImgUrl(ModelCo.cardName)
	local downTxt = PetStrategyConfig.instance:getStrategyById(infoPet.raceId).resume

	goutil.findChildTextComponent(cell, "showDate").text = data.contractTital

	local btnObj = goutil.findChild(cell, "container")

	goutil.findChildTextComponent(btnObj, "namebg/txt").text = infoPet.skinName
	goutil.findChildTextComponent(btnObj, "imgDown/txt").text = downTxt

	local attrIcon = goutil.findChildComponent(btnObj, "layout/Nego_Attr/Img_attr", "UIImageSpriteChange")

	attrIcon:SetState(race)

	local imageObj = goutil.findChild(btnObj, "mask/con")

	uGuiUtil.setSpriteToImage(imageObj, uGuiUtil.SpriteType.BigBg, imgPath)

	local tipBtn = goutil.findChild(cell, "showDate/tipbtn")
	local btnBook = goutil.findChild(btnObj, "imgBook")
	local attrObj = goutil.findChild(btnObj, "layout/Nego_Attr")

	GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "bg")):SetState(rare)
	GameUtil.getUIImageSpriteChange(attrObj):SetState(rare)
	GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "layout/Nego_Skin/skin")):SetState(rareSkin)
	GameUtil.asBtn(tipBtn):AddClickListener(function()
		TipsFacade.instance:openTipWindowNoX(data.contractTital, data.contractDescription, nil, "确定")
	end, self)
	GameUtil.asBtn(btnBook):AddClickListener(function()
		PetbookController.instance:openPetinfoView(infoPet.raceId)
	end, self)
	GameUtil.asBtn(btnObj):AddClickListener(function()
		self:_onClickPetContract(data)
	end, self)

	local item = goutil.findChild(cell, "contract")

	self:_setContractItem(item, data)
end

function PetNoticeView:_clearTableview1(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "container"))
	GameUtil.rmClickHandler(goutil.findChild(cell, "container/imgBook"))

	local listTran = goutil.findChild(cell, "contract/tableview/Viewport/Content").transform

	for i = 1, listTran.childCount do
		MaterialMgr.resetAll(listTran:GetChild(i - 1).gameObject)
	end
end

function PetNoticeView:_setContractItem(cell, data)
	local getBtn = goutil.findChild(cell, "btnget")

	local function fun()
		TipsFacade.instance:openCommonTips("功能未开放")
	end

	GameUtil.asBtn(getBtn):AddClickListener(fun, self)

	local itemObj = goutil.findChild(cell, "item")
	local listTran = goutil.findChild(cell, "tableview/Viewport/Content").transform

	for i = 1, listTran.childCount do
		listTran:GetChild(i - 1).gameObject:SetActive(false)
	end

	for index, v in ipairs(data.cPets) do
		tran = index > listTran.childCount and goutil.cloneAndSetParent(itemObj, listTran, tostring(index)).transform or listTran:GetChild(index - 1)

		self:_setPetCell(tran.gameObject, v, table.indexof(data.nPets, v))
	end
end

function PetNoticeView:_setPetCell(cell, id, isNew)
	cell:SetActive(true)

	local con = goutil.findChild(cell, "con")
	local new = goutil.findChild(cell, "new")
	local top = goutil.findChild(cell, "top")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	new:SetActive(isNew ~= false)
	MaterialMgr.setCell(MatType.Pet, id, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, id)

	GameUtil.addClickHandler(top, function()
		CommonTipsMgr.instance:showMaxLvlPetTips(id)
	end)
end

function PetNoticeView:_onClickPetContract(data)
	if data.jumpType == 1 then
		if data.type == 1 then
			local raceId = PetSkinConfig.instance:getPetSkinCfg(data.skinId).raceId

			MaterialMgr.openGetSource(MatType.Pet, raceId)
		elseif data.type == 2 then
			MaterialMgr.openGetSource(MatType.PET_SKIN, data.skinId)
		end
	elseif not string.nilorempty(data.funcId) then
		GotoMgr.gotoByString(data.funcId)
	end
end

function PetNoticeView:_pageCellSize(view, index)
	if self._pagetableview:getData()[index + 1].isParentTag then
		return 178, 60
	else
		return 178, 60
	end
end

function PetNoticeView:_updatePageCell(view, cell, data)
	local imgBigBgChange = goutil.findChild(cell, "imgBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local imgSmallBgChange = goutil.findChild(cell, "click/imgSmallBg"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtNameChange = txtName.gameObject:GetComponent(ComponentType.UITextColorChange)
	local redPoint = goutil.findChild(cell, "dot")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "click")

	btn:AddClickListener(function()
		if not data.isParentTag then
			if self._curSelectClickIndex ~= data.index then
				self:_updateTabList(data.index)
				self:_onClickTab(data.cfg.index)
			end
		else
			if data.cfg.isHide and self._curSelectClickIndex ~= data.index then
				self:_onClickTab(data.cfg.childIndex[1])
			end

			if not data.isUnfold and data.childIndexList[1] then
				local childFirstIndex = self._saveList[data.childIndexList[1]].cfg.index

				self:_onClickTab(childFirstIndex)
			end

			if not data.isSingleChild or self._curSelectClickIndex ~= data.index then
				self:_updateTabList(data.index)
			end
		end
	end)
	imgBigBgChange:SetState(data.isParentTag and (data.isUnfold and 1 or 0) or 2)
	imgSmallBgChange:SetState(data.isParentTag and 2 or data.isSelect and 1 or 0)

	txtName.text = data.name

	txtNameChange:SetState(data.isParentTag and (data.isUnfold and 1 or 0) or data.isSelect and 3 or 2)
	RedPointController.instance:unregRedPoint(redPoint)

	if #data.redPointIds > 0 then
		RedPointController.instance:regRedPoint(redPoint, unpack(data.redPointIds))
	else
		goutil.setActive(redPoint, false)
	end
end

function PetNoticeView:_clearPageTableview(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "click")
	local redPoint = goutil.findChild(cell, "dot")

	btn:RemoveClickListener()
	RedPointController.instance:unregRedPoint(redPoint)
end

function PetNoticeView:_initTabList(selectChildIndex)
	self._curSelectClickIndex = 1

	local list = {}
	local index = 1
	local ParentPageInfo = PetNoticeConfig.instance:getBigTabSortList()

	for i, v in ipairs(ParentPageInfo) do
		local parentElement = {}

		parentElement.index = index
		parentElement.parentIndex = v.index
		parentElement.name = v.name
		parentElement.cfg = v
		parentElement.isParentTag = true
		parentElement.isUnfold = false
		parentElement.childIndexList = {}
		parentElement.redPointIds = {}

		table.insert(list, parentElement)

		index = index + 1

		if not v.isHide then
			for j, childIndex in ipairs(v.childIndex) do
				if selectChildIndex == childIndex then
					parentElement.isUnfold = true
					self._curSelectClickIndex = index
				end

				local isAddChild = true
				local petCgs
				local redPointIds = {}
				local childCfg = PetNoticeConfig.instance:getSmallTabCfg(childIndex)

				if not string.nilorempty(childCfg.config_name) then
					petCgs = PetNoticeConfig.instance:getPetNoticCfgs(childCfg.config_name)

					if petCgs and #petCgs == 0 then
						isAddChild = false
					elseif petCgs and #petCgs > 0 then
						for j, v in pairs(petCgs) do
							if not string.nilorempty(v.redPoint) then
								local ids = string.splitToNumber(v.redPoint or "", "#")

								for k, id in pairs(ids) do
									table.insert(redPointIds, id)
									table.insert(parentElement.redPointIds, id)
								end
							end
						end
					end
				end

				if isAddChild then
					local info = childCfg
					local childElement = {}

					childElement.index = index
					childElement.parentIndex = parentElement.index
					childElement.name = info.name
					childElement.cfg = info
					childElement.isParentTag = false
					childElement.isSelect = selectChildIndex == childIndex
					childElement.redPointIds = redPointIds

					table.insert(list, childElement)
					table.insert(parentElement.childIndexList, index)

					index = index + 1
				end
			end
		end

		parentElement.isSingleChild = #parentElement.childIndexList == 1
	end

	self._saveList = list
end

function PetNoticeView:_getClickIndexByChildIndex(childIndex)
	local index = 1

	for i, v in ipairs(self._saveList) do
		if v.isParentTag then
			if v.isSingleChild and self._saveList[v.childIndexList[1]].cfg.index == childIndex then
				index = v.index

				break
			end

			if v.cfg.isHide and v.cfg.childIndex then
				local isEnd = false

				for i2, v2 in ipairs(v.cfg.childIndex) do
					if v2 == childIndex then
						index = v.index

						break
					end
				end

				if isEnd then
					break
				end
			end
		elseif v.cfg.index == childIndex then
			index = v.index

			break
		end
	end

	return index
end

function PetNoticeView:_updateTabList(clickIndex)
	self._curSelectClickIndex = clickIndex
	self._filterList = self._filterList or {}

	table.clear(self._filterList)

	local isClickParent = self._saveList[clickIndex].isParentTag
	local selectParentIndex = 1
	local isSelectParentUnfold = false

	if isClickParent then
		selectParentIndex = clickIndex
		isSelectParentUnfold = self._saveList[clickIndex].isUnfold

		for i, v in ipairs(self._saveList) do
			if v.isParentTag then
				if clickIndex == v.index then
					v.isUnfold = (v.isSingleChild or v.cfg.isHide) and true or not v.isUnfold
					isSelectParentUnfold = v.isUnfold
				else
					v.isUnfold = false
				end

				table.insert(self._filterList, v)
			else
				local parentElement = self._saveList[v.parentIndex]

				if parentElement.isUnfold then
					if parentElement.isSingleChild then
						v.isSelect = true
					else
						v.isSelect = v.index == parentElement.childIndexList[1]

						table.insert(self._filterList, v)
					end
				else
					v.isSelect = false
				end
			end
		end
	else
		for i, v in ipairs(self._saveList) do
			if v.isParentTag then
				table.insert(self._filterList, v)
			else
				v.isSelect = clickIndex == v.index

				if self._saveList[v.parentIndex].isUnfold then
					table.insert(self._filterList, v)
				end

				if v.isSelect then
					selectParentIndex = v.parentIndex
					isSelectParentUnfold = self._saveList[v.parentIndex].isUnfold
				end
			end
		end
	end

	self._pagetableview:reloadData(self._filterList)
	self:_updateScrollBg(self:_getSelectedIndex(selectParentIndex), isSelectParentUnfold, self:_getChildCellCount(selectParentIndex))
end

function PetNoticeView:_getSelectedIndex(parentIndex)
	local index = 1

	for i, v in ipairs(self._filterList) do
		if v.isParentTag and v.index == parentIndex then
			index = i

			break
		end
	end

	return index
end

function PetNoticeView:_getChildCellCount(parentIndex)
	local parentElement = self._saveList[parentIndex]

	if parentElement.isUnfold then
		return #parentElement.childIndexList
	else
		return 0
	end
end

function PetNoticeView:_initScrollBgParam()
	local tableview = self._pagetableview:getView()

	self._cellSpaceingY = tableview.cellSpacing.y
	self._cellOffsetY = tableview.cellOffset.y
	self._cellHeight = 60
end

function PetNoticeView:_updateScrollBg(index, isUnfold, childCellCount)
	local posY = 0 - (self._cellOffsetY + (index - 1) * (self._cellHeight + self._cellSpaceingY))

	posY = posY - 35

	local height = 0

	if isUnfold then
		local count = childCellCount

		if count > 1 then
			height = count * (self._cellHeight + self._cellSpaceingY) + self._cellHeight * 0.5
		end
	end

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._dropLineRectTrans, 0, 0)

	Framework.TransformUtil.SetAnchoredPos(self._dropLineRectTrans, x, posY)
	goutil.setHeight(self._dropLineRectTrans, height)
end

function PetNoticeView:_onClickBtnWish()
	local ruleCo = RulesConfig.instance:getRuleCo("CheckinBuff_rule")

	if ruleCo then
		TipsFacade.instance:openTipWindowNoX(ruleCo.title, ruleCo.rules, nil, "确定")
	end
end

return PetNoticeView
