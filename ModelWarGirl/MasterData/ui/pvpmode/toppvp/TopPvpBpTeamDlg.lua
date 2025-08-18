-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpBpTeamDlg.lua

local strClassName = "TopPvpBpTeamDlg"
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local DragHeroSortPanel = require("UI/Battle/DragHeroSortPanel")
local TopPvpBpTeamDlg = Class(strClassName, UIControls.Window)
local ResBPPvpShow = require("ClientData/ResBPPvpShow")
local Hero = require("Common/Object/Hero")

function TopPvpBpTeamDlg:ctor(...)
	self:initUI()
	self:initData()
end

function TopPvpBpTeamDlg:initUI(...)
	self.btnPre = UIControls.Button(self, "InforPanel/BtnPre")

	self.btnPre:addEventClick(self.onBtnPreClick)

	self.btnNext = UIControls.Button(self, "InforPanel/BtnNext")

	self.btnNext:addEventClick(self.onBtnNextClick)

	self.btnTeam1 = UIControls.Button(self, "InforPanel/TeamPanel/BtnTeam1")

	self.btnTeam1:addEventClick(self.onBtnTeam1Click)

	self.btnTeam2 = UIControls.Button(self, "InforPanel/TeamPanel/BtnTeam2")

	self.btnTeam2:addEventClick(self.onBtnTeam2Click)

	self.btnTeam3 = UIControls.Button(self, "InforPanel/TeamPanel/BtnTeam3")

	self.btnTeam3:addEventClick(self.onBtnTeam3Click)

	self.iconNews = {}

	for i = 1, 3 do
		local newCell = UIControls.Image(self, "InforPanel/TeamPanel/BtnTeam" .. i .. "/IconNew")

		table.insert(self.iconNews, newCell)
	end

	self.btnEdit = UIControls.Button(self, "InforPanel/BtnEdit")

	self.btnEdit:addEventClick(self.onBtnEditClick)

	self.txtEdit = UIControls.Label(self, "InforPanel/BtnEdit/Text")
	self.aniInfo = UIControls.UIAni(self, "")
	self.gridHeros = {}

	for i = 1, 10 do
		self.gridHeros[i] = UIControls.GridHeroInfoChild(self, "InforPanel/CardList/GridHero" .. i, "System/Common/Grid/GridHeroInfo")
		self.gridHeros[i].mEvenClick = Slot(self.onHeroGridClick, self)
	end

	self.nowSelectPage = 1
	self.heroBag = {}

	local actData = CurAvatar:getTopPVPActivityData()
	local nowServerData = actData:getMyBPAllHeros()

	for teamType, oneBag in pairs(nowServerData) do
		local newBag = {}

		for pos, hero in ipairs(oneBag) do
			newBag[pos] = hero
		end

		self.heroBag[teamType] = newBag
	end

	self.inChooseMode = false
	self.cardListRaycast = UIControls.Panel(self, "CardListRaycast")
	self.panelChoose = UIControls.Panel(self, "CardListPanel")

	self.panelChoose:setVisible(false)

	self.btnSave = UIControls.Button(self, "CardListPanel/BtnFuncPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.txtSave = UIControls.Label(self, "CardListPanel/BtnFuncPanel/BtnSave/Text")
	self.btnCancel = UIControls.Button(self, "CardListPanel/BtnFuncPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, "CardListPanel/CardPanel")

	self.scrollView:addEventCellChanged(self.onHeroCellChanged)

	self._slot4CellSelect = Slot(self.onCellSelect, self)
	self.choosedHero = {}
	self.filterSelectPanel = FilterSelectPanel(self, "CardListPanel/BtnFuncPanel/ListSelectPanel")
	self.panelSort = DragHeroSortPanel(self, "CardListPanel/BtnFuncPanel")
	self.panelSort.mEventHeroListChanged = Slot(self.onHerosChanged, self)

	self.btnEdit:setEnable(CurAvatar:TopPvpCanChangeBpHeros())

	self.btnSetting = UIControls.Button(self, "InforPanel/BtnSetting")

	self.btnSetting:addEventClick(self.onBtnSettingClick)

	self.btnClose = UIControls.Button(self, "InforPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)
end

function TopPvpBpTeamDlg:initData(...)
	self.panelSort:initSortPanel(UIConst.HERO_DEFAULT_SORT_MAP, UIConst.HERO_DEFAULT_FILTER_PANEL_MAP)
	self:refreshUI()
end

function TopPvpBpTeamDlg:onOpen()
	TopPvpBpTeamDlg.super.onOpen(self)
end

function TopPvpBpTeamDlg:refreshUI()
	self.btnTeam1:setEnable(self.nowSelectPage ~= 1)
	self.btnTeam2:setEnable(self.nowSelectPage ~= 2)
	self.btnTeam3:setEnable(self.nowSelectPage ~= 3)

	if self.nowSelectPage == 3 then
		self.txtSave:setText(Lang.get(30151))
		self.btnNext:setEnable(false)
	else
		self.txtSave:setText(Lang.get(76439))
		self.btnNext:setEnable(true)
	end

	self:updateHeroBag(self.allHeros)

	if self.inChooseMode then
		self:refreshHeroShow(self.heroBag[self.nowSelectPage])
	else
		local actData = CurAvatar:getTopPVPActivityData()
		local heroBag = actData:getMyBPAllHeros()

		self:refreshHeroShow(heroBag[self.nowSelectPage])
	end
end

function TopPvpBpTeamDlg:refreshHeros(hero)
	local index = #self.heroBag[self.nowSelectPage]

	for i, h in pairs(self.heroBag[self.nowSelectPage]) do
		if h.gid == hero.gid then
			index = i

			break
		end
	end

	if self.choosedHero[hero.gid] then
		table.insert(self.heroBag[self.nowSelectPage], hero)
	else
		table.remove(self.heroBag[self.nowSelectPage], index)
	end

	self:refreshHeroShow(self.heroBag[self.nowSelectPage])
end

function TopPvpBpTeamDlg:refreshBtnRedDot(...)
	local actData = CurAvatar:getTopPVPActivityData()

	for i = 1, 3 do
		self.iconNews[i]:setVisible(#self.heroBag[i] ~= 10 and CurAvatar:TopPvpCanChangeBpHeros())
	end
end

function TopPvpBpTeamDlg:refreshHeroShow(heros)
	if not heros then
		-- block empty
	end

	local count = 0

	if heros then
		count = math.min(#heros, #self.gridHeros)
	end

	for i = 1, count do
		local cell = self.gridHeros[i]

		cell:setVisible(true)
		cell:setHero(heros[i])
	end

	for i = count + 1, #self.gridHeros do
		self.gridHeros[i]:setVisible(false)
	end

	self:refreshBtnRedDot()
end

function TopPvpBpTeamDlg:onHeroCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.HeroCardLoop(sender, "System/Hero/GridHeroCard", newIdx, 0, 0)

		targetCell:setSelectCallback(self._slot4CellSelect)
	else
		targetCell.mIndex = newIdx
	end

	local hero = self.showHeros[newIdx]

	if hero then
		targetCell:setHero(hero)

		targetCell.isDragTip = false

		targetCell.imgStateIcon:setVisible(false)

		targetCell.showSelect = true

		local indexS

		for index = 1, 3 do
			if self.heroBag[index] then
				for i = 1, #self.heroBag[index] do
					if hero.gid == self.heroBag[index][i].gid then
						indexS = index
					end
				end
			end
		end

		targetCell:setSelected(indexS == self.nowSelectPage or false)

		if indexS then
			if indexS ~= self.nowSelectPage then
				targetCell.imgSelBPTeam:setVisible(true)
				targetCell.btnSelf:setEnable(false)
				targetCell.imgSel:setVisible(false)

				local txt = utils.format(Lang.get(89893), indexS)

				targetCell.txtSelBPTeam:setText(txt)
			else
				targetCell.btnSelf:setEnable(true)
				targetCell.imgSelBPTeam:setVisible(false)
				targetCell.imgSel:setVisible(true)
			end
		else
			targetCell.btnSelf:setEnable(true)
			targetCell.txtSelBPTeam:setText("")
			targetCell.imgSelBPTeam:setVisible(false)
			targetCell.imgSel:setVisible(false)
		end
	end
end

function TopPvpBpTeamDlg:getHeroTeamPos(heroid)
	local pos

	for index, heros in pairs(self.heroBag) do
		for i = 1, #heros do
			if heros[i].id == heroid then
				return index
			end
		end
	end
end

function TopPvpBpTeamDlg:onCellSelect(sender)
	local gid = sender.hero.gid

	if self.choosedHero[gid] == true then
		sender:setSelected(false)

		self.choosedHero[gid] = false

		self:refreshHeros(sender.hero)
	elseif #self.heroBag[self.nowSelectPage] >= 10 then
		MsgManager.notice(Lang.get(78301))
	else
		local pos = self:getHeroTeamPos(sender.hero.id)

		if pos then
			local notice

			if pos ~= self.nowSelectPage then
				notice = ResBPPvpShow[13070001].desc
			else
				notice = ResBPPvpShow[13070002].desc
			end

			MsgManager.notice(notice)
		else
			self.choosedHero[gid] = true

			sender:setSelected(true)
			self:refreshHeros(sender.hero)
		end
	end
end

function TopPvpBpTeamDlg:onHeroGridClick(sender)
	if self.inChooseMode then
		local hero = sender.hero

		if hero and #self.heroBag[self.nowSelectPage] >= 1 then
			local gid = sender.hero.gid

			if gid then
				self.choosedHero[gid] = false
			end

			self:refreshHeros(sender.hero)
			self:updateHeroBag()
		end
	end
end

function TopPvpBpTeamDlg:updateHeroBag(allHeros, filter)
	self.allHeros = allHeros or self.allHeros
	self.filter = filter or {}
	self.showHeros = {}

	for _, hero in ipairs(self.allHeros) do
		if not self.filter[hero.gid] then
			table.insert(self.showHeros, hero)
		end
	end

	self:refreshList(true)
end

function TopPvpBpTeamDlg:refreshList(isTop)
	if isTop then
		self.scrollView:setTotalCount(#self.showHeros, 1)
	else
		self.scrollView:setTotalCount(#self.showHeros)
	end
end

function TopPvpBpTeamDlg:changeEditState(startEdit)
	self.panelChoose:setVisible(startEdit)
	self.cardListRaycast:setVisible(startEdit)

	self.inChooseMode = startEdit

	self.btnEdit:setEnable(not startEdit)

	if startEdit then
		self.txtEdit:setText(Lang.get(78802))
	else
		self.txtEdit:setText(Lang.get(392))
	end
end

function TopPvpBpTeamDlg:initChooseHero()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData then
		local heros = actData:getMyBPAllHeros()

		if heros then
			for i = 1, #heros do
				for j = 1, #heros[i] do
					if heros[i][j].gid then
						self.choosedHero[heros[i][j].gid] = true
					end
				end
			end
		end
	end
end

function TopPvpBpTeamDlg:checkMyHeroBag(gid)
	local hero = CurAvatar.heroDic[gid]

	if hero then
		return true
	end

	return false
end

function TopPvpBpTeamDlg:getClearHeroPos(oneBag)
	for i = 1, #oneBag do
		if not self:checkMyHeroBag(oneBag[i].gid) then
			return i
		end
	end
end

function TopPvpBpTeamDlg:clearHeroShow(...)
	local actData = CurAvatar:getTopPVPActivityData()
	local nowServerData = actData:getMyBPAllHeros()

	for teamType, oneBag in pairs(nowServerData) do
		local newBag = {}

		for pos, hero in ipairs(oneBag) do
			newBag[pos] = hero
		end

		self.heroBag[teamType] = newBag
	end

	for i = 1, 3 do
		for j = 1, #nowServerData[i] do
			local index = self:getClearHeroPos(self.heroBag[i])

			if index then
				table.remove(self.heroBag[i], index)
			end
		end
	end
end

function TopPvpBpTeamDlg:onBtnEditClick()
	self:initChooseHero()
	self:updateHeroBag()
	self.aniInfo:startAni("ShowHero", true)
	self:changeEditState(true)
	self:refreshUI()
end

function TopPvpBpTeamDlg:checkBpTeam(...)
	for i = 1, 3 do
		if not self.heroBag[i] or #self.heroBag[i] ~= 10 then
			return false
		end
	end

	return true
end

function TopPvpBpTeamDlg:saveBpTeamToServer()
	local actData = CurAvatar:getTopPVPActivityData()
	local actId = CurAvatar:getTopPVPActivityOpId()
	local actData = CurAvatar:getTopPVPActivityData()
	local data = {}

	for i = 1, 3 do
		for j = 1, #self.heroBag[i] do
			table.insert(data, self.heroBag[i][j].gid)
		end
	end

	RPC.bPPvpKnockoutSetBPPool(actId, actData.channel, actData.myKnockoutRoomId, data)
end

function TopPvpBpTeamDlg:onBtnSaveClick()
	if self.nowSelectPage < 3 then
		self.nowSelectPage = self.nowSelectPage + 1

		self:refreshUI()
	elseif CurAvatar:TopPvpCanChangeBpHeros() then
		local check = self:checkBpTeam()

		if check then
			self:saveBpTeamToServer()
			self.aniInfo:startAni("HideHero", true)
			self:changeEditState(false)
		else
			MsgManager.notice(Lang.get(79944))
		end
	else
		MsgManager.notice(Lang.get(80814))
	end
end

function TopPvpBpTeamDlg:onBtnCancelClick(...)
	local actData = CurAvatar:getTopPVPActivityData()
	local nowServerData = actData:getMyBPAllHeros()

	for teamType, oneBag in pairs(nowServerData) do
		local newBag = {}

		for pos, hero in ipairs(oneBag) do
			newBag[pos] = hero
		end

		self.heroBag[teamType] = newBag
	end

	self:changeEditState(false)
	self:refreshUI()

	self.choosedHero = {}

	self.aniInfo:startAni("HideHero", true)
end

function TopPvpBpTeamDlg:onBtnSettingClick()
	local notice, showFlag
	local resData = ResBPPvpShow[13070026]

	if resData then
		notice = resData.desc
	end

	if not self.heroBag then
		if notice then
			MsgManager.notice(notice)

			return
		end

		showFlag = "ban"
	else
		for i = 1, 3 do
			if not self.heroBag[i] or #self.heroBag[i] ~= 10 then
				showFlag = "ban"
			end
		end
	end

	UIManager.getUI("topPvpBpSettingDlg", true):show(showFlag)
end

function TopPvpBpTeamDlg:onHerosChanged(heros)
	self:updateHeroBag(heros, self.filter)
end

function TopPvpBpTeamDlg:onBtnTeam1Click()
	self.nowSelectPage = 1

	self:refreshUI()
end

function TopPvpBpTeamDlg:onBtnTeam2Click()
	self.nowSelectPage = 2

	self:refreshUI()
end

function TopPvpBpTeamDlg:onBtnTeam3Click()
	self.nowSelectPage = 3

	self:refreshUI()
end

function TopPvpBpTeamDlg:onBtnPreClick()
	if self.nowSelectPage == 1 then
		return
	else
		self.nowSelectPage = self.nowSelectPage - 1

		self:refreshUI()
	end
end

function TopPvpBpTeamDlg:onBtnCloseClick()
	self:setVisible(false)
end

function TopPvpBpTeamDlg:onBtnNextClick()
	if self.nowSelectPage == 3 then
		return
	else
		self.nowSelectPage = self.nowSelectPage + 1

		self:refreshUI()
	end
end

return TopPvpBpTeamDlg
