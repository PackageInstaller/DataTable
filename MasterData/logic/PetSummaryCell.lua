-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/PetSummaryCell.lua

module("logic.extensions.recommendfmt.view.PetSummaryCell", package.seeall)

local PetSummaryCell = class("PetSummaryCell")

function PetSummaryCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._rectTransGo = go:GetComponent(goutil.Type_RectTransform)
	self._txtName = goutil.findChildTextComponent(go, "txtName")
	self._tableviewGo = goutil.findChild(go, "childtableview")
	self._rectTrans = self._tableviewGo:GetComponent(goutil.Type_RectTransform)
	self._tablecellGo = goutil.findChild(go, "childtablecell")
	self._scrollList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regGetCellSize(GameUtil.handler(self._cellSize, self))
	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._uiTableGrid = self._tableviewGo:GetComponent(typeof(UITableGrid))
	self._tableviewGo2 = goutil.findChild(go, "childtableview2")
	self._rectTrans2 = self._tableviewGo2:GetComponent(goutil.Type_RectTransform)
	self._tablecellGo2 = goutil.findChild(go, "childtablecell2")
	self._scrollList2 = ScrollerList.create(self._tableviewGo2, self._tablecellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self._clearCell2, self))

	self._scrollList2:regGetCellSize(GameUtil.handler(self._cellSize2, self))
	self._scrollList2:regReloadFinish(GameUtil.handler(self._onReloadFinish2, self))

	self._uiTableGrid2 = self._tableviewGo2:GetComponent(typeof(UITableGrid))
end

function PetSummaryCell:init(data)
	self._myData = data
	self._txtName.text = data.name

	local list = data.smallTabList

	goutil.setWidth(self._rectTransGo, (data.isUnfold or nil) and (PetSummaryView.UnfoldWidth or PetSummaryView.FoldWidth))
	self:_setSingleLineNum()

	if not data.isSimplify then
		goutil.setActive(self._tableviewGo, true)
		goutil.setActive(self._tableviewGo2, false)
		self._scrollList:reloadData(list)
		self._scrollList:dragNotifyParent()
		goutil.setHeight(self._rectTrans, self:_getHeight())
	else
		goutil.setActive(self._tableviewGo, false)
		goutil.setActive(self._tableviewGo2, true)
		self._scrollList2:reloadData(list)
		self._scrollList2:dragNotifyParent()
		goutil.setHeight(self._rectTrans2, self:_getHeight())
	end
end

function PetSummaryCell:_setSingleLineNum()
	if not self._myData.isSimplify then
		if self._myData.isUnfold then
			self._uiTableGrid.numRowsOrCols = PetSummaryView.BigUnfoldCount or PetSummaryView.FoldCount
		end
	elseif self._myData.isUnfold then
		self._uiTableGrid2.numRowsOrCols = PetSummaryView.SmallUnfoldCount or PetSummaryView.FoldCount
	end
end

function PetSummaryCell:_getHeight()
	local totalCount = #self._myData.smallTabList

	if self._myData.isUnfold then
		if self._myData.isSimplify then
			local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.SmallUnfoldCount) + 1

			return PetSummaryView.SmallHeight * lineNum
		else
			local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.BigUnfoldCount) + 1

			return PetSummaryView.BigHeight * lineNum
		end
	elseif self._myData.isSimplify then
		local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.FoldCount) + 1

		return PetSummaryView.SmallHeight * lineNum
	else
		local lineNum = Mathf.Floor(Mathf.Max(totalCount - 1, 0) / PetSummaryView.FoldCount) + 1

		return PetSummaryView.BigHeight * lineNum
	end
end

function PetSummaryCell:clear()
	self._scrollList:dispose()
	self._scrollList2:dispose()
end

function PetSummaryCell:_updateCell(view, cell, data, tag)
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(data.skinId)
	local maxPower = FightingPowerFormula.instance:getPetMaxFightingPower(infoPet.raceId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId) % 10 - 1
	local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(data.skinId)
	local isOpen = true
	local isSkin = data.type == 2
	local rare = CharacterConfig.instance:getInitRare(infoPet.raceId)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(data.skinId).quality
	local ModelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))
	local imgPath = data.resources == "" and GameUrl.getPetImgUrl(ModelCo.cardName) or data.resources .. ".png"
	local styCfg = PetStrategyConfig.instance:getStrategyById(infoPet.raceId)

	if isSkin then
		local var_6_0 = data.getDescription

		if not data.getDescription then
			if styCfg then
				var_6_0 = styCfg.resume

				if not styCfg.resume then
					local downTxt = "请配置精灵攻略表"
					local haveEq = data.sqContent ~= nil and data.sqContent ~= ""
					local selectGo = goutil.findChild(cell, "container/select")
					local openDateStr = "永久开放"
					local dateTimeGo = goutil.findChild(cell, "container/showDate")
					local power = goutil.findChild(cell, "container/txtPower")
					local txtPower = goutil.findChildTextComponent(cell, "container/txtPower/txt")
					local imgPower = goutil.findChild(cell, "container/txtPower"):GetComponent("UIImageSpriteChange")
					local startTimeStamp = data.startTime and GameUtil.string2time(data.startTime) or 0

					if data.startTime and data.endTime then
						isOpen = GameUtil.getTimePeriodType(data.startTime, data.endTime, false) == GameUtil.inTimePeriod
					elseif data.startTime and not data.endTime then
						isOpen = startTimeStamp <= ServerTime.now()
					end

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
						local timestamp2 = GameUtil.string2time(data.endTime)

						if startTimeStamp <= ServerTime.now() then
							goutil.setActive(dateTimeGo, true)

							local leftTime = timestamp2 - ServerTime.now()

							openDateStr = self:_getOpenDateStr(leftTime)
						else
							goutil.setActive(dateTimeGo, false)
						end
					else
						goutil.setActive(dateTimeGo, startTimeStamp == 0 or startTimeStamp <= ServerTime.now())
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
						local leftTime = GameUtil.string2time(data.startTime) - ServerTime.now()
						local str = self:_getOpenDateStr(leftTime)

						goutil.findChildTextComponent(btnObj, "openTime/txt").text = string.format("%s后开启", str)
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
					local starObj = goutil.findChild(btnObj, "layout/star")

					GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "bg")):SetState(rare)
					GameUtil.getUIImageSpriteChange(attrObj):SetState(rare)
					GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "layout/Nego_Skin/skin")):SetState(rareSkin)
					btnBook:SetActive(not isSkin and PageIndex ~= 1)
					attrObj:SetActive(not isSkin)
					starObj:SetActive(data.isStar == 1)

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

function PetSummaryCell:_clearCell(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "container"))
	GameUtil.rmClickHandler(goutil.findChild(cell, "container/imgBook"))
	RedPointController.instance:unregRedPoint(goutil.findChild(cell, "container/imgPoint"))
end

function PetSummaryCell:_updateCell2(view, cell, data, tag)
	local infoPet = PetSkinConfig.instance:getPetSkinCfg(data.skinId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(data.skinId) % 10 - 1
	local isGet = PetskinController.instance:checkHasForeverSkinBySkinId(data.skinId)
	local isOpen = true
	local isSkin = data.type == 2
	local rare = CharacterConfig.instance:getInitRare(infoPet.raceId)
	local rareSkin = PetSkinConfig.instance:getPetSkinCfg(data.skinId).quality
	local ModelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))
	local imgPath = data.resources == "" and GameUrl.getCharacterIconUrl(ModelCo.headName) or data.resources .. ".png"
	local selectGo = goutil.findChild(cell, "container/select")
	local openDateStr = "永久开放"
	local dateTimeGo = goutil.findChild(cell, "container/showDate")
	local startTimeStamp = data.startTime and GameUtil.string2time(data.startTime) or 0

	if data.startTime and data.endTime then
		isOpen = GameUtil.getTimePeriodType(data.startTime, data.endTime, false) == GameUtil.inTimePeriod
	elseif data.startTime and not data.endTime then
		isOpen = startTimeStamp <= ServerTime.now()
	end

	if data.startTime and data.endTime then
		local timestamp2 = GameUtil.string2time(data.endTime)

		if startTimeStamp <= ServerTime.now() then
			goutil.setActive(dateTimeGo, true)

			local leftTime = timestamp2 - ServerTime.now()

			openDateStr = self:_getOpenDateStr(leftTime)
		else
			goutil.setActive(dateTimeGo, false)
		end
	else
		goutil.setActive(dateTimeGo, startTimeStamp == 0 or startTimeStamp <= ServerTime.now())
	end

	goutil.findChildTextComponent(cell, "container/showDate/txt").text = openDateStr

	local btnObj = goutil.findChild(cell, "container")
	local mark = checknumber(data.mark)

	if not isOpen then
		local leftTime = GameUtil.string2time(data.startTime) - ServerTime.now()
		local str = self:_getOpenDateStr(leftTime)

		goutil.findChildTextComponent(btnObj, "openTime/txt").text = string.format("%s后开启", str)
	end

	goutil.findChild(btnObj, "openTime"):SetActive(not isOpen)
	goutil.findChild(btnObj, "noGet"):SetActive(not isGet)
	goutil.findChild(btnObj, "layout/Nego_Skin"):SetActive(isSkin)

	local attrIcon = goutil.findChildComponent(btnObj, "layout/Nego_Attr/Img_attr", "UIImageSpriteChange")

	attrIcon:SetState(race)

	local imageObj = goutil.findChild(btnObj, "mask/con")

	uGuiUtil.setSpriteToImage(imageObj, uGuiUtil.SpriteType.BigBg, imgPath)

	local attrObj = goutil.findChild(btnObj, "layout/Nego_Attr")
	local starObj = goutil.findChild(btnObj, "layout/star")

	GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "bg")):SetState(rare)
	GameUtil.getUIImageSpriteChange(attrObj):SetState(rare)
	GameUtil.getUIImageSpriteChange(goutil.findChild(btnObj, "layout/Nego_Skin/skin")):SetState(rareSkin)
	attrObj:SetActive(not isSkin)
	starObj:SetActive(data.isStar == 1)
	GameUtil.asBtn(btnObj):AddClickListener(function()
		self:_onClickPetNew(isOpen, data)
	end, self)

	local redPoint = goutil.findChild(btnObj, "imgPoint")

	RedPointController.instance:unregRedPoint(redPoint)
	RedPointController.instance:regRedPoint(redPoint, unpack(string.splitToNumber(data.redPoint or "", "#")))
end

function PetSummaryCell:_clearCell2(cell)
	GameUtil.rmClickHandler(goutil.findChild(cell, "container"))
	RedPointController.instance:unregRedPoint(goutil.findChild(cell, "container/imgPoint"))
end

function PetSummaryCell:_getOpenDateStr(leftTime)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(leftTime > 0 and leftTime or 0)

	return day > 0 and (hour == 0 and string.format("%d天", day) or string.format("%d天%d小时", day, hour)) or hour > 0 and string.format("%d小时", hour) or "1小时"
end

function PetSummaryCell:_onClickPetNew(isOpen, data)
	if self._myData.isUnfold then
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
	else
		self:_onClickEvent(isOpen, data)
	end
end

function PetSummaryCell:_onClickEvent(isOpen, data)
	RecommendFmtController.instance:localNotify(RecommendFmtController.PetSummaryClickPet, data)
end

function PetSummaryCell:_cellSize(view, index)
	return PetSummaryView.BigWidth, PetSummaryView.BigHeight
end

function PetSummaryCell:_cellSize2(view, index)
	return PetSummaryView.SmallWidth, PetSummaryView.SmallHeight
end

function PetSummaryCell:_onReloadFinish()
	self._scrollList:getView():GetScrollRect().verticalNormalizedPosition = 1.01
end

function PetSummaryCell:_onReloadFinish2()
	self._scrollList2:getView():GetScrollRect().verticalNormalizedPosition = 1.01
end

return PetSummaryCell
