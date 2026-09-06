-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/freescuffle/view/FreeScuffleBookView.lua

module("logic.extensions.freescuffle.view.FreeScuffleBookView", package.seeall)

local FreeScuffleBookView = class("FreeScuffleBookView", ViewComponent)
local Tag_WorkPet = 1
local Tag_BattlePet = 2
local Tag_Skill = 3
local ScrCellTags = {
	[FreeScuffleEnum.BookPages_WorkPet] = Tag_WorkPet,
	[FreeScuffleEnum.BookPages_BattlePet] = Tag_BattlePet,
	[FreeScuffleEnum.BookPages_NormalSkill] = Tag_Skill,
	[FreeScuffleEnum.BookPages_UltSkill] = Tag_Skill,
	[FreeScuffleEnum.BookPages_HeroSkill] = Tag_Skill
}

function FreeScuffleBookView:ctor()
	FreeScuffleBookView.super.ctor(self)

	self._unitInfoLists = {}
	self._curBookTab = FreeScuffleEnum.BookTabs[1]

	if self._curBookTab then
		self._curBookPage = self._curBookTab and self._curBookTab[1]
		self._isShowTips = {}
	end
end

function FreeScuffleBookView:buildUI()
	FreeScuffleBookView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnPrize = self:getGo("btnPrize")
	self._redBtnPrize = self:getGo("btnPrize/red")

	local tabScrView = self:getGo("tabCol/scrView")
	local tabScrCell = self:getGo("tabCol/scrCell")

	self._tabScrollerList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	local pageScrView = self:getGo("pageCol/scrView")
	local pageScrCell = self:getGo("pageCol/scrCell")

	self._pageScrollerList = ScrollerList.create(pageScrView, pageScrCell, GameUtil.handler(self._updatePageCell, self), GameUtil.handler(self._clearPageCell, self))

	local unitScrView = self:getGo("unitCol/scrView")
	local workScrCell = self:getGo("unitCol/workScrCell")
	local battleScrCell = self:getGo("unitCol/battleScrCell")
	local skillScrCell = self:getGo("unitCol/skillScrCell")
	local scrCellList = {
		workScrCell,
		battleScrCell,
		skillScrCell
	}

	self._sizeList = {}

	for tag, go in ipairs(scrCellList) do
		local width, height = GameUtil.getWidth(go), GameUtil.getHeight(go)

		self._sizeList[tag] = {
			width,
			height
		}
	end

	self._unitScrollerList = ScrollerList.create(unitScrView, scrCellList, GameUtil.handler(self._updateUnitCell, self), GameUtil.handler(self._clearUnitCell, self))

	self._unitScrollerList:regGetTagByIdx(GameUtil.handler(self._getTagByIdx, self))
	self._unitScrollerList:regGetCellSize(GameUtil.handler(self._getCellSize, self))
end

function FreeScuffleBookView:bindEvents()
	FreeScuffleBookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
end

function FreeScuffleBookView:unbindEvents()
	FreeScuffleBookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPrize)
end

function FreeScuffleBookView:onEnter()
	FreeScuffleBookView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, true)
	FreeScuffleController.instance:enterWorkScene(self._activityId, true)

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = FreeScuffleController.instance:getSubMo(self._activityId)
	self._actData = FreeScuffleConfig.instance:getActData(self._activityId)

	local redIdTaskBook = FreeScuffleController.instance:getTaskGroupRedId(self._activityId, FreeScuffleEnum.TaskGroup_Book)

	RedPointController.instance:regRedPoint(self._redBtnPrize, redIdTaskBook)
	self:_onUpdate()
end

function FreeScuffleBookView:onExit()
	FreeScuffleBookView.super.onExit(self)

	for bookPage, infoList in pairs(self._unitInfoLists) do
		for _, info in ipairs(infoList) do
			if info.isActive then
				self._subMo:setNotNewItem(bookPage, info.id)
			end
		end
	end

	self._subMo:saveNewRecord()
	FreeScuffleController.instance:enterFreeScuffleRunning(self._activityId, false)
	FreeScuffleController.instance:enterWorkScene(self._activityId, false)
	RedPointController.instance:unregRedPoint(self._redBtnPrize)
	self._tabScrollerList:dispose()
	self._pageScrollerList:dispose()
	self:_onClearUnitCol()
	table.clear(self._isShowTips)
end

function FreeScuffleBookView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function FreeScuffleBookView:_onUpdateData()
	table.clear(self._unitInfoLists)

	local bookPageList = {}

	for bookTab, bookPages in pairs(FreeScuffleEnum.BookPagesInTabs) do
		for idx, bookPage in pairs(bookPages) do
			table.insert(bookPageList, bookPage)
		end
	end

	for _, bookPage in ipairs(bookPageList) do
		local infoList = {}

		if bookPage == FreeScuffleEnum.BookPages_WorkPet then
			local cfg = FreeScuffleConfig.instance:getPetCfg(self._activityId) or {}

			for _, data in ipairs(cfg) do
				local info = {}

				info.id = data.raceId
				info.data = data
				info.isActive = self._subMo:isWithPet(data.raceId)
				info.isNewItem = self._subMo:isNewItem(bookPage, info.id)
				info.quality = data.quality

				table.insert(infoList, info)
			end
		elseif bookPage == FreeScuffleEnum.BookPages_BattlePet then
			local cfg = FreeScuffleConfig.instance:getScuffleBattlePetCfg(self._activityId) or {}

			for _, data in pairs(cfg) do
				local info = {}

				info.id = data.creepsId
				info.data = data
				info.isActive = self._subMo:isWithBatPet(data.creepsId)
				info.isNewItem = self._subMo:isNewItem(bookPage, info.id)

				local petCo = CharacterConfig.instance:getPetCo(data.raceId)

				info.quality = petCo.rare

				table.insert(infoList, info)
			end
		elseif bookPage == FreeScuffleEnum.BookPages_NormalSkill or bookPage == FreeScuffleEnum.BookPages_UltSkill or bookPage == FreeScuffleEnum.BookPages_HeroSkill then
			local skillType = FreeScuffleEnum.SkillTypeInBookPages[bookPage]
			local dataList = FreeScuffleConfig.instance:getSkillDataListByType(self._activityId, skillType)

			for _, data in ipairs(dataList) do
				local info = {}

				info.id = data.skillId
				info.data = data
				info.isActive = self._subMo:isWithSkill(data.skillId)
				info.isNewItem = self._subMo:isNewItem(bookPage, info.id)
				info.quality = 0

				table.insert(infoList, info)
			end
		end

		table.sort(infoList, function(a, b)
			if a.quality ~= b.quality then
				return a.quality > b.quality
			end

			if a.isActive ~= b.isActive then
				return a.isActive
			end

			return a.id > b.id
		end)

		self._unitInfoLists[bookPage] = infoList or {}
	end
end

function FreeScuffleBookView:_onUpdateUI()
	self._tabScrollerList:reloadData(FreeScuffleEnum.BookTabs)

	if self._curBookTab then
		if not FreeScuffleEnum.BookPagesInTabs[self._curBookTab] then
			local pageList = {}

			self._pageScrollerList:reloadData(pageList)
			self:_onUpdateUnitColUI()
		end
	end
end

function FreeScuffleBookView:_updateTabCell(view, cell, bookTab, tag)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")

	txtName.text = FreeScuffleEnum.BookTabNames[bookTab]

	GameUtil.setUIGroupIdx(mainGo, self._curBookTab == bookTab and 1 or 0)
	btn:GetComponent(goutil.Type_UIImage):SetNativeSize()
	GameUtil.addClickHandler(btn, function()
		self._curBookTab = bookTab

		if self._curBookTab then
			self._curBookPage = self._curBookTab and self._curBookTab[1]

			self:_onUpdateUI()
		end
	end)
end

function FreeScuffleBookView:_clearTabCell(cell)
	local mainGo = cell.gameObject
	local btn = goutil.findChild(mainGo, "btn")

	GameUtil.rmClickHandler(btn)
end

function FreeScuffleBookView:_updatePageCell(view, cell, bookPage, tag)
	local mainGo = cell.gameObject
	local btnGo = goutil.findChild(mainGo, "btn")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")

	txtName.text = FreeScuffleEnum.BookPageNames[bookPage]

	GameUtil.setUIGroupIdx(mainGo, self._curBookPage == bookPage and 1 or 0)
	btnGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
	GameUtil.addClickHandler(btnGo, function()
		self._curBookPage = bookPage

		self:_onUpdateUI()
	end)
end

function FreeScuffleBookView:_clearPageCell(cell)
	local mainGo = cell.gameObject
	local btnGo = goutil.findChild(mainGo, "btn")

	GameUtil.rmClickHandler(btnGo)
end

function FreeScuffleBookView:_onUpdateUnitColUI()
	if self._curBookPage then
		if not self._unitInfoLists[self._curBookPage] then
			local unitInfoList = {}

			self._unitScrollerList:reloadData(unitInfoList)
		end
	end
end

function FreeScuffleBookView:_onClearUnitCol()
	self._unitScrollerList:dispose()
end

function FreeScuffleBookView:_updateUnitCell(view, cell, info, tag)
	self:_clearUnitCell(cell)

	local index = cell.data
	local tag = self:_getTagByIdx(info, index)

	if tag == Tag_WorkPet then
		self:_updateUnitCellWorkPet(view, cell, info, tag)
	elseif tag == Tag_BattlePet then
		self:_updateUnitCellBattlePet(view, cell, info, tag)
	elseif tag == Tag_Skill then
		self:_updateUnitCellSkill(view, cell, info, tag)
	end
end

function FreeScuffleBookView:_clearUnitCell(cell)
	self:_clearUnitCellWorkPet(cell)
	self:_clearUnitCellBattlePet(cell)
	self:_clearUnitCellSkill(cell)
end

function FreeScuffleBookView:_updateUnitCellWorkPet(view, cell, info, tag)
	local data = info.data
	local isActive = info.isActive
	local isNewItem = info.isNewItem
	local raceId = data.raceId
	local mainGo = cell.gameObject
	local btnGo = goutil.findChild(mainGo, "btn")
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
	local tagNew = goutil.findChild(mainGo, "btn/tagNew")
	local tips = goutil.findChild(mainGo, "tips")
	local txtTips = goutil.findChildTextComponent(mainGo, "tips/txt")
	local path = GameUrl.getCharacterIconUrl(string.format("icon_%s", data.lihui))

	uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, path)
	GameUtil.SetGray(con, not isActive)

	txtName.text = data.name

	local idList = self._subMo:getShipInPet(raceId)
	local desc = ""

	for idx, relationshipId in ipairs(idList) do
		local data = FreeScuffleConfig.instance:getShipData(self._activityId, relationshipId)

		desc = desc .. data.desc .. (idx ~= #idList and "\n" or "")
	end

	if not data.effectIds then
		local effectIds = {}

		for idx, effectId in ipairs((not data.effectIds or nil) and {}) do
			local data = FreeScuffleConfig.instance:getIncreaseEffectData(self._activityId, effectId)

			desc = desc .. data.desc .. (idx ~= #effectIds and "\n" or "")
		end

		txtTips.text = desc

		GameUtil.SetActive(tips, (self._isShowTips[tag] or nil) and (self._isShowTips[tag][raceId] or false))

		local function showTipsFunc()
			self._isShowTips[tag] = self._isShowTips[tag] or {}
			self._isShowTips[tag][raceId] = not self._isShowTips[tag][raceId]

			GameUtil.SetActive(tips, (self._isShowTips[tag] or nil) and (self._isShowTips[tag][raceId] or false))
		end

		GameUtil.addClickHandler(btnGo, showTipsFunc)
		GameUtil.addClickHandler(tips, showTipsFunc)
		GameUtil.SetActive(tagNew, isActive and isNewItem)
	end
end

function FreeScuffleBookView:_clearUnitCellWorkPet(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local btnGo = goutil.findChild(mainGo, "btn")
	local tips = goutil.findChild(mainGo, "tips")

	if con then
		GameUtil.SetGray(con, false)
		uGuiUtil.clearImage(con)
	end

	GameUtil.rmClickHandler(btnGo)
	GameUtil.rmClickHandler(tips)
end

function FreeScuffleBookView:_updateUnitCellBattlePet(view, cell, info, tag)
	local data = info.data
	local isActive = info.isActive
	local isNewItem = info.isNewItem
	local skinId = checknumber(data.faceId)

	if skinId <= 0 then
		skinId = data.raceId
	end

	local mainGo = cell.gameObject
	local btnGo = goutil.findChild(mainGo, "btn")
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
	local tagNew = goutil.findChild(mainGo, "btn/tagNew")

	MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, skinId)

	GameUtil.SetGray(con, not isActive)
	GameUtil.addClickHandler(btnGo, function()
		CommonTipsMgr.instance:showMaxLvlPetTips(skinId, data.lv, data.awakenLv)
	end)
	GameUtil.SetActive(tagNew, isActive and isNewItem)
end

function FreeScuffleBookView:_clearUnitCellBattlePet(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local btnGo = goutil.findChild(mainGo, "btn")

	if con then
		GameUtil.SetGray(con, false)
		MaterialMgr.clearIcon(con)
	end

	GameUtil.rmClickHandler(btnGo)
end

function FreeScuffleBookView:_updateUnitCellSkill(view, cell, info, tag)
	local data = info.data
	local isActive = info.isActive
	local isNewItem = info.isNewItem
	local matSkillId = data.battleSkillId
	local mainGo = cell.gameObject
	local btnGo = goutil.findChild(mainGo, "btn")
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local txtName = goutil.findChildTextComponent(mainGo, "btn/txtName")
	local tagNew = goutil.findChild(mainGo, "btn/tagNew")

	MaterialMgr.setIcon(con, MatType.Skill, matSkillId, nil, nil)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Skill, matSkillId)

	GameUtil.SetGray(con, not isActive)
	GameUtil.addClickHandler(btnGo, function()
		CommonTipsMgr.instance:openMaterialTips(mainGo, MatType.Skill, matSkillId)
	end)
	GameUtil.SetActive(tagNew, isActive and isNewItem)
end

function FreeScuffleBookView:_clearUnitCellSkill(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "btn/mask/con")
	local btnGo = goutil.findChild(mainGo, "btn")
	local tips = goutil.findChild(mainGo, "tips")

	if con then
		GameUtil.SetGray(con, false)
		MaterialMgr.clearIcon(con)
	end

	GameUtil.rmClickHandler(btnGo)
	GameUtil.rmClickHandler(tips)
end

function FreeScuffleBookView:_getTagByIdx(info, idx)
	return ScrCellTags[self._curBookPage]
end

function FreeScuffleBookView:_getCellSize(view, idx)
	local list = self._unitScrollerList:getData()
	local info = list[idx + 1]
	local tag = self:_getTagByIdx(info, idx)

	return self._sizeList[tag][1], self._sizeList[tag][2]
end

function FreeScuffleBookView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function FreeScuffleBookView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.FreeScuffleBookPrizeView, self._activityId, FreeScuffleEnum.TaskGroup_Book)
end

return FreeScuffleBookView
