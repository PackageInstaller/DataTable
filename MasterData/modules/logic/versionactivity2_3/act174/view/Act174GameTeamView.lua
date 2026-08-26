-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174GameTeamView.lua

module("modules.logic.versionactivity2_3.act174.view.Act174GameTeamView", package.seeall)

local Act174GameTeamView = class("Act174GameTeamView", BaseView)

function Act174GameTeamView:onInitView()
	self._goTeamRoot = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot")
	self._goHeroGroup = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot/go_HeroGroup")
	self._goEquipGroup = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot/go_EquipGroup")
	self._goHeroMask = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot/go_HeroMask")
	self._goLock1 = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock1")
	self._txtUnlock1 = gohelper.findChildText(self.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock1/txt_Unlock1")
	self._goLock2 = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock2")
	self._txtUnlock2 = gohelper.findChildText(self.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock2/txt_Unlock2")
	self._goLock3 = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock3")
	self._txtUnlock3 = gohelper.findChildText(self.viewGO, "#go_EditTeam/go_TeamRoot/go_Lock3/txt_Unlock3")
	self._goCharacterInfo = gohelper.findChild(self.viewGO, "go_characterinfo")
	self.animLock1 = self._goLock1:GetComponent(gohelper.Type_Animator)
	self.animLock2 = self._goLock2:GetComponent(gohelper.Type_Animator)
	self.animLock3 = self._goLock3:GetComponent(gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174GameTeamView:addEvents()
	self.addClickCb(self, self.btnCharacterBg, self.onClickCharacterBg, self)
end

function Act174GameTeamView:removeEvents()
	self:removeClickCb(self.btnCharacterBg)
end

function Act174GameTeamView:onClickCharacterBg()
	gohelper.setActive(self._goCharacterInfo, false)
end

function Act174GameTeamView:_editableInitView()
	self.btnCharacterBg = gohelper.findChildButtonWithAudio(self.viewGO, "go_characterinfo/btn_CloseCharacterInfo")
	self.characterInfo = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCharacterInfo, Act174CharacterInfo, self)

	gohelper.setActive(self._goHeroGroup, true)
	gohelper.setActive(self._goEquipGroup, false)

	self.wareType = Activity174Enum.WareType.Hero

	self:initFrame()
end

function Act174GameTeamView:onUpdateParam()
	return
end

function Act174GameTeamView:onOpen()
	self.actId = Activity174Model.instance:getCurActId()

	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	local gameCount = gameInfo.gameCount
	local turnConfig = Activity174Config.instance:getTurnCo(self.actId, gameCount)

	self.unLockTeamCnt = turnConfig.groupNum

	self:creatHeroEquipItem()
	self:refreshTeamLock()
	self:refreshTeamGroup()
	self:caculateSelectIndex()
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.WareHouseTypeChange, self.OnWareTypeChange, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.WareItemInstall, self.OnInstallItem, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.WareItemRemove, self.OnRemoveItem, self)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.UnEquipCollection, self.UnInstallCollection, self)
end

function Act174GameTeamView:onClose()
	return
end

function Act174GameTeamView:onDestroyView()
	TaskDispatcher.cancelTask(self.unlockTeamAnimEnd, self)
end

function Act174GameTeamView:initFrame()
	self.frameTrList = {}

	for i = 1, 12 do
		local go = gohelper.findChild(self.viewGO, "#go_EditTeam/go_TeamRoot/FrameRoot/frame" .. i)

		self["_goFrameSelect" .. i] = gohelper.findChild(go, "select")
		self.frameTrList[i] = go.transform
	end
end

function Act174GameTeamView:refreshTeamLock()
	for i = 1, 3 do
		gohelper.setActive(self["_goLock" .. i], i > self.unLockTeamCnt)

		local unLockLvl = Activity174Config.instance:getUnlockLevel(self.actId, i) - 1
		local unLockStr = luaLang("act174_team_unlocktip")

		self["_txtUnlock" .. i].text = GameUtil.getSubPlaceholderLuaLangOneParam(unLockStr, GameUtil.getNum2Chinese(unLockLvl))
	end

	self:checkUnlockTeamAnim(self.unLockTeamCnt)
end

function Act174GameTeamView:creatHeroEquipItem()
	self.heroItemList = {}
	self.equipItemList = {}

	local heroGo = gohelper.findChild(self._goHeroGroup, "HeroItem")
	local equipGo = gohelper.findChild(self._goEquipGroup, "EquipItem")
	local maskGo = gohelper.findChild(self._goHeroMask, "mask")

	for i = 1, 12 do
		local x, y = recthelper.getAnchor(self.frameTrList[i])
		local go = gohelper.cloneInPlace(heroGo)

		recthelper.setAnchor(go.transform, x, y)

		local heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act174HeroItem, self)

		heroItem:setIndex(i)
		heroItem:activeEquip(true)

		self.heroItemList[i] = heroItem

		local go1 = gohelper.cloneInPlace(equipGo)

		recthelper.setAnchor(go1.transform, x, y)

		local equipItem = MonoHelper.addNoUpdateLuaComOnceToGo(go1, Act174EquipItem, self)

		equipItem:setIndex(i)

		self.equipItemList[i] = equipItem

		local go3 = gohelper.cloneInPlace(maskGo)

		recthelper.setAnchor(go3.transform, x, y)
	end

	gohelper.setActive(heroGo, false)
	gohelper.setActive(equipGo, false)
end

function Act174GameTeamView:refreshTeamGroup()
	self.heroList = {}
	self.equipList = {}
	self.skillList = {}

	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	self.teamMoList = gameInfo:getTeamMoList()

	for _, teamInfo in ipairs(self.teamMoList) do
		local battleHeros = teamInfo.battleHeroInfo
		local tIndex = teamInfo.index

		for i = 1, 4 do
			local hero = battleHeros[i]

			if hero then
				local index = (tIndex - 1) * 4 + hero.index

				if hero.heroId ~= 0 then
					self.heroList[index] = hero.heroId
				end

				if hero.itemId ~= 0 then
					self.equipList[index] = hero.itemId
				end

				if hero.priorSkill ~= 0 then
					self.skillList[index] = hero.priorSkill
				end

				self:refreshHeroItem(index)
				self:refreshEquipItem(index)
			end
		end
	end
end

function Act174GameTeamView:refreshHeroItem(index)
	local heroItem = self.heroItemList[index]

	heroItem:setData(self.heroList[index], self.equipList[index], self.skillList[index])
end

function Act174GameTeamView:refreshEquipItem(index)
	local equipItem = self.equipItemList[index]

	equipItem:setData(self.equipList[index])
end

function Act174GameTeamView:OnWareTypeChange(wareType)
	self.wareType = wareType

	for _, heroItem in ipairs(self.heroItemList) do
		heroItem:activeEquip(wareType == Activity174Enum.WareType.Hero)
	end

	gohelper.setActive(self._goEquipGroup, wareType == Activity174Enum.WareType.Collection)
	self:caculateSelectIndex()
end

function Act174GameTeamView:OnInstallItem(wareId)
	local index = self.selectHeroIndex

	if self.wareType == Activity174Enum.WareType.Hero then
		if index == 0 then
			GameFacade.showToast(ToastEnum.Act174TeamGroupFull)
		else
			self.heroList[index] = wareId

			self:updateBattleHeroInfo(self.selectHeroIndex)

			local node

			for i = self.selectHeroIndex + 1, self.unLockTeamCnt * 4 do
				if not self.heroList[i] then
					node = i

					break
				end
			end

			if node then
				self.selectHeroIndex = node

				self:refreshSelect()
			else
				self:caculateSelectIndex()
			end
		end
	elseif index == 0 then
		GameFacade.showToast(ToastEnum.Act174CollectionFull)
	else
		local unique = lua_activity174_collection.configDict[wareId].unique

		if unique == 1 then
			local row = Activity174Helper.CalculateRowColumn(index)

			if not self:checkOnlyCollection(row, wareId) then
				GameFacade.showToast(ToastEnum.Act174OnlyCollection)

				return
			end
		end

		self.equipList[index] = wareId

		self:updateBattleHeroInfo(self.selectHeroIndex)

		local node

		for i = self.selectHeroIndex + 1, self.unLockTeamCnt * 4 do
			if not self.equipList[i] then
				node = i

				break
			end
		end

		if node then
			self.selectHeroIndex = node

			self:refreshSelect()
		else
			self:caculateSelectIndex()
		end
	end
end

function Act174GameTeamView:OnRemoveItem(wareId)
	local list

	if self.wareType == Activity174Enum.WareType.Hero then
		for k, id in pairs(self.heroList) do
			if id == wareId then
				self.heroList[k] = nil
				self.skillList[k] = nil

				self:updateBattleHeroInfo(k)
				self:caculateSelectIndex()

				break
			end
		end
	else
		for k, id in pairs(self.equipList) do
			if id == wareId then
				self.equipList[k] = nil

				self:updateBattleHeroInfo(k)
				self:caculateSelectIndex()

				break
			end
		end
	end
end

function Act174GameTeamView:caculateSelectIndex()
	local list = self.wareType == Activity174Enum.WareType.Hero and self.heroList or self.equipList

	for i = 1, self.unLockTeamCnt * 4 do
		if i == self.unLockTeamCnt * 4 then
			self.selectHeroIndex = list[i] and 0 or i
		elseif not list[i] then
			self.selectHeroIndex = i

			break
		end
	end

	self:refreshSelect()
end

function Act174GameTeamView:updateBattleHeroInfo(index)
	local row, column = Activity174Helper.CalculateRowColumn(index)
	local battleHero = {}

	battleHero.index = column
	battleHero.heroId = self.heroList[index]
	battleHero.itemId = self.equipList[index]
	battleHero.priorSkill = self.skillList[index]

	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	gameInfo:setBattleHeroInTeam(row, column, battleHero)
	self:refreshHeroItem(index)
	self:refreshEquipItem(index)
end

function Act174GameTeamView:clickHero(index)
	local heroId = self.heroList[index]

	if heroId then
		local config = Activity174Config.instance:getRoleCo(heroId)
		local itemId = self.equipList[index]

		if config then
			self.characterInfo:setData(config, itemId, index)
			gohelper.setActive(self._goCharacterInfo, true)
		end
	else
		self.selectHeroIndex = index

		self:refreshSelect()
	end
end

function Act174GameTeamView:clickCollection(index)
	if self.equipList[index] then
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Collection
		viewParam.co = Activity174Config.instance:getCollectionCo(self.equipList[index])
		viewParam.showMask = true
		viewParam.needUninstall = true
		viewParam.index = index

		Activity174Controller.instance:openItemTipView(viewParam)
	else
		self.selectHeroIndex = index

		self:refreshSelect()
	end
end

function Act174GameTeamView:UnInstallHero(index)
	self.heroList[index] = nil
	self.skillList[index] = nil

	self:updateBattleHeroInfo(index)
	self:caculateSelectIndex()
end

function Act174GameTeamView:UnInstallCollection(index)
	self.equipList[index] = nil

	self:updateBattleHeroInfo(index)
	self:caculateSelectIndex()
end

function Act174GameTeamView:exchangeHeroItem(from, to)
	self.heroList[from] = self.heroList[to]
	self.heroList[to] = self.heroList[from]
	self.skillList[from] = self.skillList[to]
	self.skillList[to] = self.skillList[from]

	local tempItem = self.heroItemList[from]

	self.heroItemList[from] = self.heroItemList[to]

	self.heroItemList[from]:setIndex(from)

	self.heroItemList[to] = tempItem

	self.heroItemList[to]:setIndex(to)
	self:caculateSelectIndex()
	self:updateBattleHeroInfo(from)
	self:updateBattleHeroInfo(to)
	self:caculateSelectIndex()
end

function Act174GameTeamView:exchangeEquipItem(from, to)
	self.equipList[from] = self.equipList[to]
	self.equipList[to] = self.equipList[from]

	local tempItem = self.equipItemList[from]

	self.equipItemList[from] = self.equipItemList[to]

	self.equipItemList[from]:setIndex(from)

	self.equipItemList[to] = tempItem

	self.equipItemList[to]:setIndex(to)
	self:caculateSelectIndex()
	self:updateBattleHeroInfo(from)
	self:updateBattleHeroInfo(to)
	self:caculateSelectIndex()
end

function Act174GameTeamView:checkOnlyCollection(row, collectionId)
	local node = row * 4

	for i = node, node - 3, -1 do
		local id = self.equipList[i]

		if id == collectionId then
			return false
		end
	end

	return true
end

function Act174GameTeamView:refreshSelect()
	for i = 1, 12 do
		gohelper.setActive(self["_goFrameSelect" .. i], i == self.selectHeroIndex)
	end
end

function Act174GameTeamView:getPriorSkill(heroId)
	for index, id in pairs(self.heroList) do
		if id == heroId then
			return self.skillList[index]
		end
	end

	logError("dont exsit heroId" .. heroId)
end

function Act174GameTeamView:setPriorSkill(heroId, skillId)
	for index, id in pairs(self.heroList) do
		if id == heroId then
			self.skillList[index] = skillId

			self:updateBattleHeroInfo(index)

			return
		end
	end

	logError("dont exsit heroId" .. heroId)
end

function Act174GameTeamView:checkUnlockTeamAnim(teamCnt)
	local localTeamCnt = GameUtil.playerPrefsGetNumberByUserId("Act174UnlockTeamCnt", 0)
	local unlockCnt = teamCnt - localTeamCnt

	if unlockCnt > 0 then
		for i = localTeamCnt + 1, unlockCnt do
			gohelper.setActive(self["_goLock" .. i], true)
			self["animLock" .. i]:Play("unlock")
		end

		TaskDispatcher.runDelay(self.unlockTeamAnimEnd, self, 1)
		GameUtil.playerPrefsSetNumberByUserId("Act174UnlockTeamCnt", teamCnt)
	end
end

function Act174GameTeamView:unlockTeamAnimEnd()
	for i = 1, 3 do
		gohelper.setActive(self["_goLock" .. i], i > self.unLockTeamCnt)
	end
end

function Act174GameTeamView:canEquipMove(from, to)
	local canMove = true
	local rowA = Activity174Helper.CalculateRowColumn(to)
	local rowB = Activity174Helper.CalculateRowColumn(from)

	if rowA ~= rowB then
		local idA = self.equipList[from]
		local idB = self.equipList[to]

		if idA then
			local collectionCo = Activity174Config.instance:getCollectionCo(idA)

			if collectionCo.unique == 1 and not self:checkOnlyCollection(rowA, idA) then
				canMove = false
			end
		end

		if idB then
			local collectionCo = Activity174Config.instance:getCollectionCo(idB)

			if collectionCo.unique == 1 and not self:checkOnlyCollection(rowB, idB) then
				canMove = false
			end
		end
	end

	return canMove
end

return Act174GameTeamView
