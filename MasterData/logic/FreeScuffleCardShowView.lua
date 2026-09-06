-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleCardShowView.lua

module("logic.extensions.freescuffle.view.FreeScuffleCardShowView", package.seeall)

local FreeScuffleCardShowView = class("FreeScuffleCardShowView", ViewComponent)
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
local ScrDruation = 0.25

function FreeScuffleCardShowView:buildUI()
	FreeScuffleCardShowView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._cardScrView = self:getGo("cardCol/scrView")
	self._cardScrViewport = self:getGo("cardCol/scrView/viewport")

	local workPetScrCell = self:getGo("cardCol/workPetScrCell")
	local battlePetScrCell = self:getGo("cardCol/battlePetScrCell")
	local skillScrCell = self:getGo("cardCol/skillScrCell")
	local prizeScrCell = self:getGo("cardCol/prizeScrCell")
	local scrCellList = {
		workPetScrCell,
		battlePetScrCell,
		skillScrCell,
		prizeScrCell
	}

	self._sizeList = {}

	for tag, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._cardScrollerList = ScrollerList.create(self._cardScrView, scrCellList, GameUtil.handler(self._updateCardCell, self), GameUtil.handler(self._clearCardCell, self))

	self._cardScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._cardScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
	self._cardScrollerList:setCenterMode(true)

	self._starScrollerListDic = {}
end

function FreeScuffleCardShowView:bindEvents()
	FreeScuffleCardShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FreeScuffleCardShowView:unbindEvents()
	FreeScuffleCardShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FreeScuffleCardShowView:onEnter()
	FreeScuffleCardShowView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._poolType = params[2]
	self._infoList = params[3] or {}
	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._coinItem = self._subMo:getCostCoinItem()

	self:_startPlay()
end

function FreeScuffleCardShowView:onExit()
	FreeScuffleCardShowView.super.onExit(self)
	removetimer(self._onTicking, self)
	self._cardScrollerList:dispose()
end

function FreeScuffleCardShowView:_onTicking()
	self:_nextInfo()
end

function FreeScuffleCardShowView:_startPlay()
	self._curIdx = 0
	self._totalIdx = #self._infoList

	settimer(ScrDruation, self._onTicking, self, true)
	self:_nextInfo()
end

function FreeScuffleCardShowView:_nextInfo()
	local nextIdx = self._curIdx + 1

	if nextIdx > self._totalIdx then
		removetimer(self._onTicking, self)

		return
	end

	self._curIdx = nextIdx

	local list = {}

	for idx = 1, self._curIdx do
		table.insert(list, self._infoList[idx])
	end

	self._cardScrollerList:reloadData(list)
	self._cardScrollerList:MoveCellToCenter(Mathf.Max(#list - 1, 0))
end

function FreeScuffleCardShowView:_updateCardCell(view, cell, info, tag)
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

function FreeScuffleCardShowView:_updateCardCellOfPrize(view, cell, info, tag)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local itemData = FreeScuffleConfig.instance:getLotteryExtraItemData(self._activityId, self._poolType, info.itemId)

	if not string.nilorempty(itemData.prize) then
		MaterialMgr.setCellByCfg(itemData.prize, con)

		txtName.text = MaterialMgr.getMaterialsNameByCfg(itemData.prize)
	end
end

function FreeScuffleCardShowView:_clearCardCellOfPrize(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	if not goutil.isNil(con) then
		MaterialMgr.resetAll(con)
	end
end

function FreeScuffleCardShowView:_updateCardCellOfSkill(view, cell, info, tag)
	local isOverFlow = info.isOverFlow
	local skillData = FreeScuffleConfig.instance:getSkillData(self._activityId, info.itemId)
	local isNewItem = self._subMo:isNewItem(FreeScuffleEnum.PoolTypes_Skill, info.itemId)
	local isNeedNew = isNewItem and not isOverFlow
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local tagNew = goutil.findChild(mainGo, "tagNew")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local overTips = goutil.findChild(mainGo, "overTips")
	local txtOverTips = goutil.findChildTextComponent(mainGo, "overTips/txt")

	MaterialMgr.setCell(MatType.Skill, skillData.battleSkillId, con)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Skill, skillData.battleSkillId)

	GameUtil.SetActive(tagNew, isNeedNew)
end

function FreeScuffleCardShowView:_clearCardCellOfSkill(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")

	if not goutil.isNil(con) then
		MaterialMgr.resetAll(con)
	end
end

function FreeScuffleCardShowView:_updateCardCellOfWorkPet(view, cell, info, tag)
	local raceId = info.itemId
	local isOverFlow = info.isOverFlow
	local petStar = info.curStar
	local maxPetStar = self._subMo:getMaxPetStar(raceId)
	local petData = FreeScuffleConfig.instance:getPetData(self._activityId, raceId)
	local isNewItem = self._subMo:isNewItem(FreeScuffleEnum.PoolTypes_WorkPet, raceId)
	local petLevel = self._subMo:getPetLevel(raceId)
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
	local txtDesc = goutil.findChildTextComponent(mainGo, "tips/txtDesc")
	local txtValue = goutil.findChildTextComponent(mainGo, "tips/txtValue")
	local iconTips = goutil.findChild(mainGo, "tips/icon")
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
				GameUtil.SetActive(tagNew, isNeedNew)
				MaterialMgr.setIcon(iconTips, self._coinItem.matType, self._coinItem.matId, nil, nil)

				local idList = self._subMo:getShipInPet(raceId)
				local desc = ""

				for idx, relationshipId in ipairs(idList) do
					local data = FreeScuffleConfig.instance:getShipData(self._activityId, relationshipId)

					desc = desc .. data.desc .. (idx ~= #idList and "\n" or "")
				end

				if not petData.effectIds then
					local effectIds = {}

					for idx, effectId in ipairs((not petData.effectIds or nil) and {}) do
						local data = FreeScuffleConfig.instance:getIncreaseEffectData(self._activityId, effectId)

						desc = desc .. data.desc .. (idx ~= #effectIds and "\n" or "")
					end

					txtDesc.text = desc

					local baseRatio = self._subMo:getBaseIncreaseRatioRace(raceId, petLevel, petStar)

					txtValue.text = string.format("%s/秒", MmUtil.formatNumber(baseRatio, FreeScuffleEnum.Units_Coin, 1))
				end
			end
		end
	end
end

function FreeScuffleCardShowView:_clearCardCellOfWorkPet(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local iconTips = goutil.findChild(mainGo, "tips/icon")
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

	if iconTips then
		MaterialMgr.clearIcon(iconTips)
	end
end

function FreeScuffleCardShowView:_updateCardCellOfBattlePet(view, cell, info, tag)
	local creepsId = info.itemId
	local isOverFlow = info.isOverFlow
	local petData = FreeScuffleConfig.instance:getScuffleBattlePetData(self._activityId, creepsId)
	local skinId = checknumber(petData.faceId)

	if skinId <= 0 then
		skinId = petData.raceId
	end

	local isNewItem = self._subMo:isNewItem(FreeScuffleEnum.PoolTypes_BattlePet, creepsId)
	local isNeedNew = isNewItem and not isOverFlow
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local tagNew = goutil.findChild(mainGo, "tagNew")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local overTips = goutil.findChild(mainGo, "overTips")
	local txtOverTips = goutil.findChildTextComponent(mainGo, "overTips/txt")

	txtName.text = petData.creepsName

	MaterialMgr.setCell(MatType.Pet, skinId, con)
	GameUtil.SetActive(tagNew, isNeedNew)
end

function FreeScuffleCardShowView:_clearCardCellOfBattlePet(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	if not goutil.isNil(con) then
		MaterialMgr.resetAll(con)
	end
end

function FreeScuffleCardShowView:_updateStarCell(view, cell, info, tag)
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

function FreeScuffleCardShowView:_clearStarCell(cell)
	return
end

function FreeScuffleCardShowView:_clearCardCell(cell)
	self:_clearCardCellOfPrize(cell)
	self:_clearCardCellOfWorkPet(cell)
	self:_clearCardCellOfBattlePet(cell)
	self:_clearCardCellOfSkill(cell)
end

function FreeScuffleCardShowView:_getTagByIdx(data, idx)
	return CardResultScrCellTags[data.type]
end

function FreeScuffleCardShowView:_getCellSize(view, idx)
	local list = self._cardScrollerList:getData()
	local data = list[idx + 1]
	local tag = self:_getTagByIdx(data, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

return FreeScuffleCardShowView
