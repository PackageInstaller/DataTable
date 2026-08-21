-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeInheritDlg.lua

local HeroGridSolderCard = require("UI/NewMaze/HeroGridSolderCard")
local HeroGridSolderCardChild = require("UI/NewMaze/HeroGridSolderCardChild")
local ResNewMazeInherit = require("ClientData/ResNewMazeInherit")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local strClassName = "NewMazeInheritDlg"
local NewMazeInheritDlg = Class(strClassName, UIControls.Window)

function NewMazeInheritDlg:ctor()
	self:initUI()
end

function NewMazeInheritDlg:initUI()
	self.selectCells = {}
	self.inheritPoolCells = {}
	self.selectInheritPanel = UIControls.Panel(self, "SelectInheritPanel")
	self.initialInheritPanel = UIControls.Panel(self, "InitialInheritPanel")
	self.selectNoContent = UIControls.Panel(self, "SelectInheritPanel/NoContent")
	self.inheritNoContent = UIControls.Panel(self, "InheritPondListPanel/NoContent")
	self.selectCardScroll = UIControls.ScrollViewLoopH(self, "SelectInheritPanel/CardList")

	self.selectCardScroll:addEventCellChanged(self.onHeroSelectCardChanged)

	self.inheritPoolScroll = UIControls.ScrollViewLoopV(self, "InheritPondListPanel/CardList")

	self.inheritPoolScroll:addEventCellChanged(self.onInheritPoolCardChanged)

	self.btnSave = UIControls.Button(self, "InheritPondListPanel/FuncPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnCancel = UIControls.Button(self, "InheritPondListPanel/FuncPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnAbandon = UIControls.Button(self, "InheritPondListPanel/FuncPanel/BtnAbandon")

	self.btnAbandon:addEventClick(self.onBtnAbandonClick)

	self.btnTips = UIControls.Button(self, "InheritPondListPanel/InheritRulePanel/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.textInherit = UIControls.Label(self, "InheritPondListPanel/InheritRulePanel/TextInherit")
	self.textInherit1 = UIControls.Label(self, "InheritPondListPanel/InheritRulePanel/TextInherit1")
	self.inheritPanel = {}

	for i = 1, 5 do
		local inheritPanel = UIControls.Panel(self, "InitialInheritPanel/CardList/Content/InheritPanel" .. i)

		inheritPanel:setVisible(false)

		local cardPanel = UIControls.Panel(self, "InitialInheritPanel/CardList/Content/InheritPanel" .. i .. "/CardPanel")
		local bgUnLockDes = UIControls.Panel(self, "InitialInheritPanel/CardList/Content/InheritPanel" .. i .. "/BgUnLockDes")
		local textUnLockDes = UIControls.Label(self, "InitialInheritPanel/CardList/Content/InheritPanel" .. i .. "/BgUnLockDes/TextUnLockDes")

		table.insert(self.inheritPanel, {
			inheritPanel = inheritPanel,
			cardPanel = cardPanel,
			bgUnLockDes = bgUnLockDes,
			textUnLockDes = textUnLockDes
		})
	end

	self.inheritingCards = {}
end

function NewMazeInheritDlg:setData(inheritType, settleType, isExit)
	self.actObj = CurAvatar:getNewMazeActivity()
	self.isExit = isExit

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		return
	end

	self.inheritType = inheritType
	self.settleType = settleType
	self.inheritSelHeros = self.newMazeData:getInheritSelHeros()
	self.inheritPoolCardList = self.newMazeData:getInheritPoolHeros()

	table.sort(self.inheritPoolCardList, function(a, b)
		local isInheritA = self:isInheriting(a.hero_id)
		local isInheritB = self:isInheriting(b.hero_id)

		if isInheritA ~= isInheritB then
			return isInheritA == true
		end
	end)
	self:refreshPoolUI()
	self.inheritNoContent:setVisible(#self.inheritPoolCardList == 0)

	if self.inheritType == Const.PUT_IN_INHERIT_POOL then
		self.selectInheritPanel:setVisible(true)
		self.initialInheritPanel:setVisible(false)
		self.btnSave:setVisible(false)
		self.btnCancel:setVisible(false)
		self.btnAbandon:setVisible(true)

		self.selectCardList = self.newMazeData:getAllCanInheritHeros()

		self.selectCardScroll:setTotalCount(#self.selectCardList)
		self.selectNoContent:setVisible(#self.selectCardList == 0)
	else
		self.selectInheritPanel:setVisible(false)
		self.initialInheritPanel:setVisible(true)
		self.btnSave:setVisible(true)
		self.btnCancel:setVisible(true)
		self.btnAbandon:setVisible(false)

		if self.initHeroCard == nil then
			self.initHeroCard = HeroGridSolderCardChild(self, "InitialInheritPanel/CardList/Content/GuestPanel/CardPanel", "System/Hero/GridHeroCardSolder", 0, 0, true)
		end

		local initHero = self.newMazeData:getPerfectHero(self.newMazeData.heroId)

		initHero.gid = tostring(initHero.id)

		self.initHeroCard:setHero(initHero)
		self.initHeroCard:setFormation()

		if self.auxHeroCard == nil then
			self.auxHeroCard = HeroGridSolderCardChild(self, "InitialInheritPanel/CardList/Content/GuestPanel/SupCardPanel", "System/Hero/GridHeroCardSolder", 0, 0, true)
		end

		local auxHero = self.newMazeData:getPerfectHero(self.newMazeData.auxHeroId)

		auxHero.gid = tostring(auxHero.id)

		self.auxHeroCard:setHero(auxHero)
		self.auxHeroCard:setFormation()

		if self.isManualOpen then
			self.auxHeroCard:showMazeSolderState(true)
		end

		self.inheritTable = {}
		self.maxInheritNum = 0

		for i, data in ipairs(ResNewMazeInherit[Const.NEW_MAZE_INHERIT_TYPE_HERO]) do
			if data.select_num > self.maxInheritNum then
				table.insert(self.inheritTable, data)

				self.maxInheritNum = data.select_num
			end
		end

		self:refreshInheritingUI()
	end
end

function NewMazeInheritDlg:openFromManual()
	self.isManualOpen = true
end

function NewMazeInheritDlg:refreshInheritingUI()
	for i, data in ipairs(self.inheritTable) do
		if self.inheritPanel[i] then
			self.inheritPanel[i].inheritPanel:setVisible(true)
			self.inheritPanel[i].cardPanel:setVisible(self.newMazeData.cycle >= data.cycle)
			self.inheritPanel[i].bgUnLockDes:setVisible(self.newMazeData.cycle < data.cycle)
			self.inheritPanel[i].textUnLockDes:setText(string.format(Lang.get(75767), data.cycle))

			if self.inheritSelHeros[i] then
				local card = self.inheritingCards[i]

				if card == nil then
					card = HeroGridSolderCardChild(self, "InitialInheritPanel/CardList/Content/InheritPanel" .. i .. "/CardPanel", "System/Hero/GridHeroCardSolder", 0, 0, true)
				end

				local hero = self.newMazeData:getPerfectHero(self.inheritSelHeros[i].hero_id)

				hero.gid = tostring(hero.id)

				card:setHero(hero)
				card:setFormation()
				card:setSelectCallback(Slot(self.onCancleInheritClick, self))

				if self.isManualOpen then
					card:showMazeSolderState(true)
				end

				self.inheritingCards[i] = card
			elseif self.inheritingCards[i] then
				self.inheritingCards[i]:destroy()

				self.inheritingCards[i] = nil
			end
		end
	end
end

function NewMazeInheritDlg:refreshPoolUI()
	self.maxInheritPoolHeroNum = ResNewMazeInherit[Const.NEW_MAZE_INHERIT_TYPE_HERO][self.newMazeData.cycle].pool_capacity
	self.maxInheritHeroNum = ResNewMazeInherit[Const.NEW_MAZE_INHERIT_TYPE_HERO][self.newMazeData.cycle].select_num

	self.textInherit:setText(string.format(Lang.get(75768), #self.inheritPoolCardList, self.maxInheritPoolHeroNum))
	self.textInherit1:setText(string.format(Lang.get(75769), #self.inheritSelHeros, self.maxInheritHeroNum))
	self.inheritPoolScroll:setTotalCount(#self.inheritPoolCardList)
end

function NewMazeInheritDlg:onHeroSelectCardChanged(sender, targetCell, newIdx)
	targetCell = targetCell or HeroGridSolderCard(sender, "System/Hero/GridHeroCardSolder", newIdx, 0, 0)

	if not self.selectCardList or #self.selectCardList == 0 then
		return
	end

	if self.selectCardList[newIdx] ~= nil then
		targetCell:setHero(self.selectCardList[newIdx])
		targetCell:setFormation()

		targetCell.mIndex = newIdx

		targetCell:setSelectCallback(Slot(self.onHeroSelectClick, self))
	end

	self.selectCells[newIdx] = targetCell
end

function NewMazeInheritDlg:onInheritPoolCardChanged(sender, targetCell, newIdx)
	targetCell = targetCell or HeroGridSolderCard(sender, "System/Hero/GridHeroCardSolder", newIdx, 0, 0)

	if not self.inheritPoolCardList or #self.inheritPoolCardList == 0 then
		return
	end

	if self.inheritPoolCardList[newIdx] ~= nil then
		local hero = self.newMazeData:getPerfectHero(self.inheritPoolCardList[newIdx].hero_id)

		hero.gid = tostring(hero.id)

		targetCell:setHero(hero)
		targetCell:setFormation()

		targetCell.mIndex = newIdx

		targetCell:setSelectCallback(Slot(self.onInheritPoolChooseClick, self))

		if targetCell.imgInherit then
			targetCell.imgInherit:setVisible(self:isInheriting(self.inheritPoolCardList[newIdx].hero_id))
		end

		if self.inheritType == Const.TAKE_FROM_INHERIT_POOL then
			if targetCell.imgSel then
				targetCell.imgSel:setVisible(self:isInheriting(self.inheritPoolCardList[newIdx].hero_id))
			end

			if self.isManualOpen then
				targetCell:showMazeSolderState(true)
			end
		end
	end

	self.inheritPoolCells[newIdx] = targetCell
end

function NewMazeInheritDlg:isInheriting(heroId)
	for i, hero in pairs(self.inheritSelHeros or {}) do
		if hero.hero_id == heroId then
			return true
		end
	end

	return false
end

function NewMazeInheritDlg:onCancleInheritClick(sender)
	for i, hero in pairs(self.inheritSelHeros or {}) do
		if hero.hero_id == sender.object.id then
			table.remove(self.inheritSelHeros, i)

			break
		end
	end

	self:refreshInheritingUI()
	self:refreshPoolUI()
end

function NewMazeInheritDlg:onHeroSelectClick(sender)
	if #self.inheritPoolCardList < self.maxInheritPoolHeroNum then
		local msg = ResNewMazeDisplay[13060063].desc

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msg, Functor(self.inheritHeroFunc, self, sender.object))
	else
		self.curSelHero = sender.object

		for i, cell in pairs(self.selectCells) do
			if cell.selBg1 then
				cell.selBg1:setVisible(sender == cell)
			end
		end

		for i, cell in pairs(self.inheritPoolCells) do
			if cell.imgReplace then
				cell.imgReplace:setVisible(true)
			end
		end
	end
end

function NewMazeInheritDlg:inheritHeroFunc(addObject, delObject)
	local addItem = {
		addObject.id
	}
	local delItem = {}

	if delObject then
		delItem = {
			delObject.id
		}
	end

	RPC.newMazeModifyInherit(self.actObj.opId, Const.NEW_MAZE_INHERIT_TYPE.Hero, addItem, delItem)
	self:realSettlement()
	self:setVisible(false)
end

function NewMazeInheritDlg:onInheritPoolChooseClick(sender)
	if self.inheritType == Const.PUT_IN_INHERIT_POOL then
		if sender.imgReplace and sender.imgReplace:getVisible() then
			local msg

			if self:isInheriting(sender.object.id) then
				msg = ResNewMazeDisplay[13060065].desc
			else
				msg = ResNewMazeDisplay[13060064].desc
			end

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msg, Functor(self.inheritHeroFunc, self, self.curSelHero, sender.object))
		end
	else
		if self:isInheriting(sender.object.id) then
			for i, hero in pairs(self.inheritSelHeros or {}) do
				if hero.hero_id == sender.object.id then
					table.remove(self.inheritSelHeros, i)

					break
				end
			end
		elseif #self.inheritSelHeros >= self.maxInheritHeroNum then
			MsgManager.notice(Lang.get(75770))
		else
			table.insert(self.inheritSelHeros, {
				hero_id = sender.object.id
			})
		end

		self:refreshInheritingUI()
		self:refreshPoolUI()
	end
end

function NewMazeInheritDlg:onBtnCancelClick()
	if #self.newMazeData.inheritSelHeros < self.maxInheritHeroNum and #self.inheritPoolCardList > #self.newMazeData.inheritSelHeros then
		local msg = Lang.get(75771)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msg, Slot(self.cancleInheritFunc, self))
	else
		self:cancleInheritFunc()
	end
end

function NewMazeInheritDlg:cancleInheritFunc()
	local itemList = {}

	for i, hero in ipairs(self.newMazeData.inheritSelHeros) do
		table.insert(itemList, hero.hero_id)
	end

	RPC.newMazeSelectInherit(self.actObj.opId, Const.NEW_MAZE_INHERIT_TYPE.Hero, itemList)
	self:setVisible(false)
end

function NewMazeInheritDlg:onBtnSaveClick()
	local itemList = {}

	for i, hero in ipairs(self.inheritSelHeros) do
		table.insert(itemList, hero.hero_id)
	end

	RPC.newMazeSelectInherit(self.actObj.opId, Const.NEW_MAZE_INHERIT_TYPE.Hero, itemList)
	self:setVisible(false)
end

function NewMazeInheritDlg:onBtnAbandonClick()
	if #self.selectCardList > 0 then
		local msg = Lang.get(75772)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msg, Slot(self.inheritAbandonFunc, self))
	else
		self:inheritAbandonFunc()
	end
end

function NewMazeInheritDlg:inheritAbandonFunc()
	RPC.newMazeModifyInherit(self.actObj.opId, Const.NEW_MAZE_INHERIT_TYPE.Hero, {}, {})
	self:realSettlement()
	self:setVisible(false)
end

function NewMazeInheritDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_NEW_MAZE_INHERIT)
end

function NewMazeInheritDlg:realSettlement()
	self.newMazeData:realSettlementFunc(self.settleType)
end

function NewMazeInheritDlg:setVisible(v, hideAndDestroy, noAni)
	NewMazeInheritDlg.super.setVisible(self, v, hideAndDestroy, noAni)

	if not v and not self.isManualOpen and self.inheritType == Const.TAKE_FROM_INHERIT_POOL and self.newMazeData and self.newMazeData:isTalentUnlock() then
		UIManager.getUI("newMazeTalentMainDlg", true):onShow(self.actObj)
	end
end

return NewMazeInheritDlg
