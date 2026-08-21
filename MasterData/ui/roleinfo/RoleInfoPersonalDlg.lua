-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoPersonalDlg.lua

local RoleInfoPanelMixin = require("UI/RoleInfo/RoleInfoPanelMixin")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local DragHeroSortPanel = require("UI/Battle/DragHeroSortPanel")
local HeadHelper = require("UI/RoleInfo/HeadHelper")
local RoleInfoTab = require("UI/RoleInfo/RoleInfoTab")
local strClassName = "RoleInfoPersonalDlg"
local RoleInfoPersonalDlg = Class(strClassName, UIControls.Window)

MixinClass(RoleInfoPersonalDlg, RoleInfoPanelMixin, true)

function RoleInfoPersonalDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
	self:initData()
end

function RoleInfoPersonalDlg:onOpen(...)
	RoleInfoPersonalDlg.super.onOpen(self)

	local ui = UIManager.getUI("mainMenu", nil, false)

	if ui == nil or not ui:isInShow() then
		ui = UIManager.getUI("mainStageDlg", nil, false)
	end

	if ui and ui:isInShow() then
		self:bindWindow(ui)
	end

	local result, desc = ClientUtils.isForbideModifyInfo()

	if result then
		RedDotManager.setKeyState(UIConst.RD_HINT_NEW_HEAD, false)

		return
	end
end

function RoleInfoPersonalDlg:initUI(...)
	self.inforPanel = UIControls.Panel(self, "InforPanel")
	self.btnHead = UIControls.Button(self, "InforPanel/BtnHead")

	self.btnHead:addEventClick(self.onBtnHeadClick)

	self.btnSex = UIControls.Button(self, "InforPanel/BtnSex")

	self.btnSex:addEventClick(self.onBtnSexClick)

	self.btnName = UIControls.Button(self, "InforPanel/BtnName")

	self.btnName:addEventClick(self.onBtnNameClick)

	self.btnSign = UIControls.Button(self, "InforPanel/BtnSign", "TextSign")

	self.btnSign:addEventClick(self.onBtnSignClick)

	self.btnEdit = UIControls.Button(self, "InforPanel/BtnEdit")

	self.btnEdit:addEventClick(self.onBtnEditClick)

	self.panelChoose = UIControls.Panel(self, "CardListPanel")
	self.panelRayCast = UIControls.Panel(self, "InforPanel/Raycast")
	self.btnSave = UIControls.Button(self, "CardListPanel/BtnFuncPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnCancel = UIControls.Button(self, "CardListPanel/BtnFuncPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.redHint = UIControls.RedDot(self, "InforPanel/BtnHead/IconNew")

	self.redHint:addHint({
		UIConst.RD_HINT_NEW_ROLE_DRESS
	})

	self.scrollView = UIControls.ScrollViewLoopV(self, "CardListPanel/CardPanel")

	self.scrollView:addEventCellChanged(self.onHeroCellChanged)

	self._slot4CellSelect = Slot(self.onCellSelect, self)
	self.filterSelectPanel = FilterSelectPanel(self, "CardListPanel/BtnFuncPanel/ListSelectPanel")
	self.panelSort = DragHeroSortPanel(self, "CardListPanel/BtnFuncPanel")
	self.panelSort.mEventHeroListChanged = Slot(self.onHerosChanged, self)
	self.choosedHero = {}
	self.btnVipHide = UIControls.Button(self, "InforPanel/VIPPanel/BtnSet")
	self.imgVipHide = UIControls.Image(self, "InforPanel/VIPPanel/BtnSet/Img")

	self.btnVipHide:addEventClick(self.onBtnVipHideClick)

	self.txtId = UIControls.Label(self, "InforPanel/DetailPanel/TextID/Text")
	self.inChooseMode = false
	self.btnVipNew = UIControls.Button(self, "InforPanel/BtnVIP")

	self.btnVipNew:addEventClick(self.onBtnVipClick)

	self.redHintVip = UIControls.RedDot(self, "InforPanel/BtnVIP/IconNew")

	self.redHintVip:addHint({
		UIConst.RD_HINT_FUNCENTRY_DIAMOND
	})

	self.panelNothing = UIControls.Panel(self, "InforPanel/CardList/BgNothing")

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_DIAMOND_BUY_JUMP) then
		self.btnVipNew:setVisible(false)
	else
		self.btnVipNew:setVisible(true)
	end

	if RegionUtils.isJP() then
		self.btnSex:setVisible(false)
	end
end

function RoleInfoPersonalDlg:checkEmpty(count)
	self.panelNothing:setVisible(count == 0)
end

function RoleInfoPersonalDlg:onBtnVipClick()
	local ui = UIManager.getUI("rechargeVipDlg", true)

	if ui then
		ui:onShow(31, 61)
	end

	self:setVisible(false)
end

function RoleInfoPersonalDlg:initData(...)
	self.panelSort:initSortPanel(UIConst.HERO_DEFAULT_SORT_MAP, UIConst.HERO_DEFAULT_FILTER_PANEL_MAP)
	self:setHeroCellClickCallBack(Slot(self.onHeroCellClick, self))
end

function RoleInfoPersonalDlg:updateHeroBag(allHeros, filter)
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

function RoleInfoPersonalDlg:refreshList(isTop)
	if isTop then
		self.scrollView:setTotalCount(#self.showHeros, 1)
	else
		self.scrollView:setTotalCount(#self.showHeros)
	end
end

function RoleInfoPersonalDlg:changeEditState(startEdit)
	self.btnEdit:setVisible(not startEdit)
	self.panelChoose:setVisible(startEdit)

	self.inChooseMode = startEdit

	self.panelRayCast:setVisible(startEdit)
end

function RoleInfoPersonalDlg:setRoleInfo(roleInfo, orderCell)
	self:setRoleInfoMixin(roleInfo, orderCell)
	self:initChoosedHero()
	self:setCommInfo()
	self:_refreshBtnVipHide()
	self.txtId:setText(CurAvatar.shortUid or "")

	local checkShowTab = roleInfo.vow and next(roleInfo.vow) or CurAvatar:checkSignetOpen()

	if checkShowTab then
		if not self.tabPanel then
			self.tabPanel = RoleInfoTab(self, "TabPanel")

			self.tabPanel:setTabData(true, roleInfo.vow, roleInfo.commInfo.uid, roleInfo.signet)
		end

		self.tabPanel:setVisible(true)
	end
end

function RoleInfoPersonalDlg:showTab(tabName)
	if not self.tabPanel or not self.tabPanel:getVisible() then
		return
	end

	if tabName == "Signet" then
		self.tabPanel:onSelectTabClick("Signet")
	end
end

function RoleInfoPersonalDlg:hideSignetPanelBtnAll()
	if self.tabPanel and self.tabPanel.signetPanel then
		self.tabPanel.signetPanel:hideBtnAll()
	end
end

function RoleInfoPersonalDlg:onVipHideResp(vipHide)
	self.roleInfo.commInfo.vip_hide = vipHide

	self:_refreshBtnVipHide()
end

function RoleInfoPersonalDlg:_refreshBtnVipHide()
	if self.roleInfo.commInfo.vip == nil or self.roleInfo.commInfo.vip == 0 then
		self.btnVipHide:setVisible(false)
	else
		self.btnVipHide:setVisible(true)
		self.panelVip:setData(self.roleInfo.commInfo.vip)

		if self.roleInfo.commInfo.vip_hide == 1 then
			self.imgVipHide:setImage("Atlas/PlayerInforAtlas/PlayerInforAtlas", "IconVIPHide")
		else
			self.imgVipHide:setImage("Atlas/PlayerInforAtlas/PlayerInforAtlas", "IconVIPShow")
		end
	end

	self.btnVipHide:setVisible(false)
end

function RoleInfoPersonalDlg:onBtnVipHideClick()
	if self.roleInfo.commInfo.vip_hide == 1 then
		CurAvatar:setVipShowState(0)
	else
		CurAvatar:setVipShowState(1)
	end
end

function RoleInfoPersonalDlg:setCommInfo(...)
	if self.roleInfo.signature and self.roleInfo.signature ~= "" then
		-- block empty
	elseif CurAvatar:playerNameInited() then
		self.btnSign:setText(Lang.get(1554))
	end
end

function RoleInfoPersonalDlg:refreshUI(...)
	self:setRoleInfo(self.roleInfo, self.orderCell)
end

function RoleInfoPersonalDlg:initChoosedHero(...)
	self.choosedHero = {}

	for _, hero in ipairs(self.heros) do
		self.choosedHero[hero.gid] = true
	end
end

function RoleInfoPersonalDlg:refreshHeros(hero)
	local index = #self.heros

	for i, h in ipairs(self.heros) do
		if h.gid == hero.gid then
			index = i

			break
		end
	end

	if self.choosedHero[hero.gid] then
		table.insert(self.heros, hero)
	else
		table.remove(self.heros, index)
	end

	self:refreshHeroShow(self.heros)
end

function RoleInfoPersonalDlg:onHerosChanged(heros)
	self:updateHeroBag(heros, self.filter)
end

function RoleInfoPersonalDlg:onHeroCellChanged(sender, targetCell, newIdx)
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

		targetCell:setSelected(self.choosedHero[hero.gid] or false)
	end
end

function RoleInfoPersonalDlg:onCellSelect(sender)
	local gid = sender.hero.gid

	if self.choosedHero[gid] == true then
		sender:setSelected(false)

		self.choosedHero[gid] = false

		self:refreshHeros(sender.hero)
	elseif #self.heros >= 5 then
		MsgManager.notice(Lang.get(30755))
	else
		self.choosedHero[gid] = true

		sender:setSelected(true)
		self:refreshHeros(sender.hero)
	end
end

function RoleInfoPersonalDlg:onHeroCellClick(sender)
	if self.inChooseMode == false then
		return
	end

	local hero = sender.hero

	self.choosedHero[hero.gid] = false

	self:refreshHeros(hero)
	self:refreshList()
end

function RoleInfoPersonalDlg:onBtnCancelClick(...)
	self:changeEditState(false)
	self:refreshHeroShow()
	self:refreshMyHeros()
	self:playAni("HideGridHeroCard", nil)
end

function RoleInfoPersonalDlg:onBtnSaveClick(...)
	if #self.heros < 5 then
		MsgManager.notice(Lang.get(30756))

		return
	end

	self:playAni("HideGridHeroCard", nil)
	self:changeEditState(false)

	local gids = {}

	for _, hero in ipairs(self.heros) do
		if #gids < 5 then
			table.insert(gids, hero.gid)
		end
	end

	RPC.roleCommEditFormation(gids)
	self.roleInfo:setHeros(self.heros)
end

function RoleInfoPersonalDlg:onBtnHeadClick(...)
	if self:_checkFuncOpen() then
		UIManager.getUI("editHeadDlg", true)
	end
end

function RoleInfoPersonalDlg:onBtnSexClick(...)
	if not self:_checkFuncOpen() then
		return
	end

	local result, hint = CurAvatar:canResex()

	if not result then
		MsgManager.notice(hint)

		return
	end

	UIManager.getUI("editSexDlg", true):setData(self.roleInfo.commInfo)
end

function RoleInfoPersonalDlg:onBtnNameClick(...)
	CurAvatar:canRename()
end

function RoleInfoPersonalDlg:onBtnSignClick(...)
	local result, desc = ClientUtils.isForbideModifyInfo()

	if result then
		MsgManager.notice(desc)

		return
	end

	if not self:_checkFuncOpen() then
		return
	end

	if CurAvatar.editedSignTimes >= Const.EDIT_SIGN_DAY_TIMES then
		MsgManager.notice(Lang.get(31309))

		return
	end

	UIManager.getUI("editSignDlg", true):setData(self.roleInfo)
end

function RoleInfoPersonalDlg:onBtnEditClick(...)
	if utils.getTableElemCount(CurAvatar.heroDic) <= 5 then
		MsgManager.notice(Lang.get(30757))

		return
	end

	self:initChoosedHero()
	self:updateHeroBag()
	self:playAni("ShowGridHeroCard", nil)
	self:changeEditState(true)
	self:onBtnClickThroughClick()
end

function RoleInfoPersonalDlg:_checkFuncOpen(...)
	return CurAvatar:checkRoleInfoOpen()
end

function RoleInfoPersonalDlg:onRoleCommEditSignetResp()
	if self.tabPanel then
		self.tabPanel:setTabData(true, self.roleInfo.vow, self.roleInfo.commInfo.uid, self.roleInfo.signet)
	end
end

return RoleInfoPersonalDlg
