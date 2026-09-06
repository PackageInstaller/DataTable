-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardResultView.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardResultView", package.seeall)

local FreeScuffleCardResultView = class("FreeScuffleCardResultView", ViewComponent)
local CardTags_WorkPet = 1
local CardTags_BattlePet = 2
local CardTags_Skill = 3
local CardTags_Prize = 4
local CardResultScrCellTags = {
	[FreeScuffleEnum.DrawCardTypes_WorkPet] = CardTags_WorkPet,
	[FreeScuffleEnum.DrawCardTypes_BattlePet] = CardTags_BattlePet,
	[FreeScuffleEnum.DrawCardTypes_Skill] = CardTags_Skill,
	[FreeScuffleEnum.DrawCardTypes_ExPrize] = CardTags_Prize
}

function FreeScuffleCardResultView:buildUI()
	FreeScuffleCardResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._tenCardScrView = self:getGo("cardCol/tenScrView")
	self._tenCardScrViewport = self:getGo("cardCol/tenScrView/viewport")
	self._onceCardScrView = self:getGo("cardCol/onceScrView")
	self._onceCardScrViewport = self:getGo("cardCol/onceScrView/viewport")

	local workPetScrCell = self:getGo("cardCol/workPetScrCell")
	local battlePetScrCell = self:getGo("cardCol/battlePetScrCell")
	local skillScrCell = self:getGo("cardCol/skillScrCell")
	local prizeScrCell = self:getGo("cardCol/prizeScrCell")

	self._scrCellList = {
		workPetScrCell,
		battlePetScrCell,
		skillScrCell,
		prizeScrCell
	}
	self._sizeList = {}

	for tag, go in ipairs(self._scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._tenCardScrollerList = ScrollerList.create(self._tenCardScrView, self._scrCellList, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))

	self._tenCardScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._tenCardScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))

	self._onceCardScrollerList = ScrollerList.create(self._onceCardScrView, self._scrCellList, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))

	self._onceCardScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._onceCardScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
	self._onceCardScrollerList:setCenterMode(true)

	self._starScrollerListDic = {}
end

function FreeScuffleCardResultView:bindEvents()
	FreeScuffleCardResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)

	self._tenPointerClickHandler = PointerClickHandler.Get(self._tenCardScrViewport):AddLuaHandler(function(_go, eventData)
		self:_onClickBtnClose()
	end)
	self._oncePointerClickHandler = PointerClickHandler.Get(self._onceCardScrViewport):AddLuaHandler(function(_go, eventData)
		self:_onClickBtnClose()
	end)
end

function FreeScuffleCardResultView:unbindEvents()
	FreeScuffleCardResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	PointerClickHandler.Get(self._tenCardScrViewport):RemoveLuaHandler(self._tenPointerClickHandler)
	PointerClickHandler.Get(self._onceCardScrViewport):RemoveLuaHandler(self._oncePointerClickHandler)
end

function FreeScuffleCardResultView:onEnter()
	FreeScuffleCardResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._msg = params[1]
	self._activityId = self._msg.activityId

	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, true)
	FreeScuffleController.instance:enterWorkScene(self._activityId, true)

	if self._msg == nil then
		printError("缺失传入参数，PM_FreeScuffleLotteryRes 为空")
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._poolType = self._msg.type
	self._coinItem = self._subMo:getCostCoinItem()

	if self._poolType == FreeScuffleEnum.PoolTypes_WorkPet then
		self._isNeedPushShow = true
	end

	self:_onUpdate()

	local function finishHandle(handlerTarget, eff)
		if self._isNeedPushShow then
			self:_showCard()
		end
	end

	self:playViewEffect("20250627/ziyouluandou/fx_ui_zyld_shengxing.prefab", self.mainGO, nil, false, 0, 0, finishHandle, nil)
end

function FreeScuffleCardResultView:onExit()
	FreeScuffleCardResultView.super.onExit(self)
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, false)
	FreeScuffleController.instance:enterWorkScene(self._activityId, false)

	for _, info in ipairs(self._msg.loteryInfoList) do
		if info.type ~= FreeScuffleEnum.DrawCardTypes_ExPrize then
			self._subMo:setNotNewItem(info.type, info.itemId)
		end
	end

	self._subMo:saveNewRecord()
	self._tenCardScrollerList:dispose()
	self._onceCardScrollerList:dispose()
end

function FreeScuffleCardResultView:_showCard()
	self._isNeedPushShow = false

	local infoList = {}

	for _, v in ipairs(self._msg.loteryInfoList) do
		if v.type ~= FreeScuffleEnum.DrawCardTypes_ExPrize and v.curStar > 0 and not v.isOverFlow then
			table.insert(infoList, v)
		end
	end

	if #infoList > 0 then
		UIStateManager.instance:push(ViewName.FreeScuffleCardShowView, self._activityId, self._poolType, infoList)
	end
end

function FreeScuffleCardResultView:_onUpdate()
	GameUtil.SetActive(self._tenCardScrView, false)
	GameUtil.SetActive(self._onceCardScrView, false)

	if #self._msg.loteryInfoList <= 5 then
		self._cardScrollerList = self._onceCardScrollerList

		self._tenCardScrollerList:dispose()
		GameUtil.SetActive(self._onceCardScrView, true)
	else
		self._cardScrollerList = self._tenCardScrollerList

		self._onceCardScrollerList:dispose()
		GameUtil.SetActive(self._tenCardScrView, true)
	end

	self._cardScrollerList:reloadData(self._msg.loteryInfoList)
end

function FreeScuffleCardResultView:_updateCardCell(view, cell, info, tag)
	self:_clearCardCell(cell)

	local index = cell.data
	local tag = self:_getTagByIdx(info, index)

	if tag == CardTags_WorkPet then
		self:_updateCardCellOfWorkPet(view, cell, info, tag)
	elseif tag == CardTags_BattlePet then
		self:_updateCardCellOfBattlePet(view, cell, info, tag)
	elseif tag == CardTags_Skill then
		self:_updateCardCellOfSkill(view, cell, info, tag)
	elseif tag == CardTags_Prize then
		self:_updateCardCellOfPrize(view, cell, info, tag)
	end
end

function FreeScuffleCardResultView:_updateCardCellOfPrize(view, cell, info, tag)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local itemData = FreeScuffleConfig.instance:getLotteryExtraItemData(self._activityId, self._poolType, info.itemId)
	local coinNum = checknumber(itemData.coin)

	if not string.nilorempty(itemData.prize) then
		MaterialMgr.setCellByCfg(itemData.prize, con)

		txtName.text = MaterialMgr.getMaterialsNameByCfg(itemData.prize)
	elseif coinNum > 0 then
		local proxy = MaterialMgr.setCellByCfg(self._coinItem.matStr, con)

		proxy.binder:setNum(coinNum)

		txtName.text = self._coinItem.matName
	else
		MaterialMgr.resetAll(con)
	end
end

function FreeScuffleCardResultView:_clearCardCellOfPrize(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	if not goutil.isNil(con) then
		MaterialMgr.resetAll(con)
	end
end

function FreeScuffleCardResultView:_updateCardCellOfSkill(view, cell, info, tag)
	local isOverFlow = info.isOverFlow
	local skillData = FreeScuffleConfig.instance:getSkillData(self._activityId, info.itemId)
	local isNewItem = self._subMo:isNewItem(info.type, info.itemId)
	local isNeedNew = isNewItem and not isOverFlow
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local tagNew = goutil.findChild(mainGo, "tagNew")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local overTips = goutil.findChild(mainGo, "overTips")
	local txtOverTips = goutil.findChildTextComponent(mainGo, "overTips/txt")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	if isNeedNew then
		self:playViewEffectUniGo("20250627/ziyouluandou/fx_ui_zyld_chouka.prefab", effRoot, self._cardScrView, true)
	else
		self:stopViewEffectUniGo(effRoot)
	end

	MaterialMgr.setCell(MatType.Skill, skillData.battleSkillId, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Skill, skillData.battleSkillId)

	GameUtil.SetActive(overTips, isOverFlow)

	txtOverTips.text = string.format("转化为%s：%s", self._coinItem.matName, skillData.overFlowReturn)

	GameUtil.SetActive(tagNew, isNeedNew)
end

function FreeScuffleCardResultView:_clearCardCellOfSkill(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	if not goutil.isNil(con) then
		MaterialMgr.resetAll(con)
	end

	self:stopViewEffectUniGo(effRoot)
end

function FreeScuffleCardResultView:_updateCardCellOfWorkPet(view, cell, info, tag)
	local raceId = info.itemId
	local isOverFlow = info.isOverFlow
	local petStar = info.curStar
	local maxPetStar = self._subMo:getMaxPetStar(raceId)
	local petData = FreeScuffleConfig.instance:getPetData(self._activityId, raceId)
	local isNewItem = self._subMo:isNewItem(info.type, info.itemId)
	local isNeedNew = isNewItem and not isOverFlow
	local mainGo = cell.gameObject
	local tagNew = goutil.findChild(mainGo, "tagNew")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local con = goutil.findChild(mainGo, "mask/con")
	local expSlider = goutil.findChildComponent(mainGo, "expSlider", ComponentType.Slider)
	local txtSlider = goutil.findChildTextComponent(mainGo, "txtSlider")
	local overTips = goutil.findChild(mainGo, "overTips")
	local txtOverTips = goutil.findChildTextComponent(mainGo, "overTips/txt")
	local starScrView = goutil.findChild(mainGo, "starCol/scrView")
	local starScrCell = goutil.findChild(mainGo, "starCol/scrCell")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	if isNeedNew then
		self:playViewEffectUniGo("20250627/ziyouluandou/fx_ui_zyld_chouka.prefab", effRoot, self._cardScrView, true)
	else
		self:stopViewEffectUniGo(effRoot)
	end

	txtName.text = petData.name

	local headPath = GameUrl.getCharacterIconUrl(string.format("icon_%s", petData.lihui))

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, headPath)

	if maxPetStar ~= 0 then
		if not (petStar / maxPetStar) then
			local progress = 0

			expSlider.value = progress
			txtSlider.text = progress >= 1 and "满星" or string.format("%s/%s", petStar, maxPetStar)

			local starInfoList = {}

			for idx = 1, petStar do
				table.insert(starInfoList, {
					isActive = idx <= petStar,
					isNeedEff = idx == petStar
				})
			end

			if not self._starScrollerListDic[mainGo] then
				local scrollList = ScrollerList.create(starScrView, starScrCell, GameUtil.handler(self._updateStarCell, self), GameUtil.handler(self._clearStarCell, self))

				self._starScrollerListDic[mainGo] = self._starScrollerListDic[mainGo]

				self._starScrollerListDic[mainGo]:setCenterMode(true)
				self._starScrollerListDic[mainGo]:reloadData(starInfoList)
				GameUtil.SetActive(overTips, isOverFlow)

				txtOverTips.text = string.format("转化为%s：%s", self._coinItem.matName, petData.overReturn)

				GameUtil.SetActive(tagNew, isNeedNew)
			end
		end
	end
end

function FreeScuffleCardResultView:_clearCardCellOfWorkPet(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	self:stopViewEffectUniGo(effRoot)

	if not goutil.isNil(con) then
		uGuiUtil.clearImage(con)
	end

	if not txtName then
		txtName.text = ""
	end

	local scrollList = self._starScrollerListDic[mainGo]

	if scrollList then
		scrollList:dispose()

		self._starScrollerListDic[mainGo] = nil
	end
end

function FreeScuffleCardResultView:_updateCardCellOfBattlePet(view, cell, info, tag)
	local creepsId = info.itemId
	local isOverFlow = info.isOverFlow
	local petData = FreeScuffleConfig.instance:getScuffleBattlePetData(self._activityId, creepsId)
	local skinId = checknumber(petData.faceId)

	if skinId <= 0 then
		skinId = petData.raceId
	end

	local isNewItem = self._subMo:isNewItem(info.type, info.itemId)
	local isNeedNew = isNewItem and not isOverFlow
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local tagNew = goutil.findChild(mainGo, "tagNew")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local overTips = goutil.findChild(mainGo, "overTips")
	local txtOverTips = goutil.findChildTextComponent(mainGo, "overTips/txt")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	if isNeedNew then
		self:playViewEffectUniGo("20250627/ziyouluandou/fx_ui_zyld_chouka.prefab", effRoot, self._cardScrView, true)
	else
		self:stopViewEffectUniGo(effRoot)
	end

	txtName.text = petData.creepsName

	MaterialMgr.setCell(MatType.Pet, skinId, con)
	GameUtil.SetActive(overTips, isOverFlow)

	txtOverTips.text = string.format("转化为%s：%s", self._coinItem.matName, checknumber(petData.overFlowReturn))

	GameUtil.SetActive(tagNew, isNeedNew)
end

function FreeScuffleCardResultView:_clearCardCellOfBattlePet(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	if not goutil.isNil(con) then
		MaterialMgr.resetAll(con)
	end

	self:stopViewEffectUniGo(effRoot)
end

function FreeScuffleCardResultView:_updateStarCell(view, cell, info, tag)
	local isActive = info.isActive
	local mainGo = cell.gameObject
	local icon = goutil.findChild(mainGo, "icon")
	local effRoot = goutil.findChild(mainGo, "effRoot")

	GameUtil.setUIGroupIdx(mainGo, isActive and 1 or 0)
	GameUtil.SetActive(icon, not info.isNeedEff)

	if info.isNeedEff then
		self:playViewEffectUniGo("20250627/ziyouluandou/fx_ui_zyld_liang.prefab", effRoot, self._cardScrView, true)
	else
		self:stopViewEffectUniGo(effRoot)
	end
end

function FreeScuffleCardResultView:_clearStarCell(cell)
	return
end

function FreeScuffleCardResultView:_clearCardCell(cell)
	self:_clearCardCellOfPrize(cell)
	self:_clearCardCellOfWorkPet(cell)
	self:_clearCardCellOfBattlePet(cell)
	self:_clearCardCellOfSkill(cell)
end

function FreeScuffleCardResultView:_getTagByIdx(data, idx)
	return CardResultScrCellTags[data.type]
end

function FreeScuffleCardResultView:_getCellSize(view, idx)
	local list = self._cardScrollerList:getData()
	local data = list[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function FreeScuffleCardResultView:_onClickBtnClose()
	if self._isNeedPushShow then
		self:_showCard()
	else
		self:close()
	end
end

return FreeScuffleCardResultView
