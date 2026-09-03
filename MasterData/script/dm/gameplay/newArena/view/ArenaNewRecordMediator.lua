-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/newArena/view/ArenaNewRecordMediator.lua

require("dm.gameplay.arena.view.component.ArenaReportCell")

ArenaNewRecordMediator = class("ArenaNewRecordMediator", DmPopupViewMediator, _M)

ArenaNewRecordMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ArenaNewRecordMediator:has("_arenaNewSystem", {
	is = "r"
}):injectWith("ArenaNewSystem")

local kCellHeight = 97
local kPicUp = "asset/common/st_img_up.png"
local kPicDown = "asset/common/common_icon_jt_2.png"

function ArenaNewRecordMediator:initialize()
	super.initialize(self)
end

function ArenaNewRecordMediator:dispose()
	super.dispose(self)
end

function ArenaNewRecordMediator:onRegister()
	super.onRegister(self)
end

function ArenaNewRecordMediator:enterWithData(data)
	self._data = data

	self:setupView()
end

function ArenaNewRecordMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._cloneCell = self:getView():getChildByName("cellclone")
	self._bgWidget = bindWidget(self, "main.bg_node", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("EXPLORE_UI16"),
		title1 = Strings:get("UITitle_EN_Guizeshuoming"),
		bgSize = {
			width = 1126,
			height = 614
		}
	})
	self._sureBtn = self:bindWidget("main.sure_btn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClickSure, self)
		}
	})
	self._scrollLayer = self._main:getChildByName("Panel_8")
	self._noImg = self._main:getChildByFullName("Image_1")
	self._changeBg = self._main:getChildByFullName("changeBg")
	self._desc_text = self._main:getChildByFullName("desc_text")

	if self._data.state == 1 then
		self._changeBg:setVisible(false)
		self._desc_text:setVisible(false)
		self._scrollLayer:setVisible(false)

		local textRank = self._main:getChildByFullName("text_rank")

		textRank:setString(Strings:get("StageArena_MainUI19"))
	else
		self._noImg:setVisible(false)
		self:createTableView()

		local textRank = self._main:getChildByFullName("text_rank")

		textRank:setString(self._arenaNewSystem:getArenaNew():getCurRankStr())
	end

	self._main:getChildByFullName("bg_node.title_node"):setVisible(false)
end

function ArenaNewRecordMediator:createTableView()
	self._reportList = self._arenaNewSystem:getArenaNew():getReportOfflineList()

	local textIncrease = self._changeBg:getChildByFullName("increase")
	local offlineRank = self._developSystem:getPlayer():getChessArena().offLineRank
	local curRank = self._arenaNewSystem:getArenaNew():getCurRank()

	if offlineRank <= curRank then
		textIncrease:setTextColor(cc.c3b(255, 0, 0))
		self._changeBg:getChildByFullName("sign"):loadTexture(kPicDown)
	end

	textIncrease:setString(Strings:get("RANK_UI13", {
		num = math.abs(curRank - offlineRank)
	}))

	local var_6_0 = "ClassArena_UI17"
	local var_6_1 = {
		fontName = TTF_FONT_FZYH_M
	}

	var_6_1.Num = self._arenaNewSystem:getArenaNew():getBeBattleTimes()

	local richText = ccui.RichText:createWithXML(Strings:get(var_6_0, var_6_1), {})

	richText:setAnchorPoint(self._desc_text:getAnchorPoint())
	richText:setPosition(cc.p(self._desc_text:getPosition()))
	richText:addTo(self._desc_text:getParent())

	if #self._reportList == 0 then
		return
	end

	local viewSize = self._scrollLayer:getContentSize()
	local tableView = cc.TableView:create(viewSize)

	local function numberOfCells(view)
		return #self._reportList
	end

	local function cellSize(table, idx)
		return self._cellWidth, kCellHeight
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			local rankCell = self._cloneCell:clone()

			rankCell:setVisible(true)

			cell.renderNode = rankCell

			cell:addChild(rankCell)
			rankCell:setPosition(-32, 0)
		end

		self:updateTableCell(cell, idx)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setAnchorPoint(cc.p(0, 0))
	tableView:setPosition(cc.p(0, 0))
	tableView:setDelegate()
	self._scrollLayer:addChild(tableView)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
end

function ArenaNewRecordMediator:updateTableCell(cell, idx)
	local view = cell.renderNode
	local iconBg = view:getChildByName("icon_bg")
	local iconBg_r = view:getChildByName("icon_bg1")
	local panel = view:getChildByFullName("panel1")
	local name = panel:getChildByName("role_name")
	local levelText = panel:getChildByName("level")
	local name_r = panel:getChildByName("role_name1")
	local level_r = panel:getChildByName("level1")
	local changeBg = panel:getChildByFullName("changeBg")
	local sign = panel:getChildByFullName("changeBg.sign")
	local increase = panel:getChildByFullName("changeBg.increase")
	local imgResult = panel:getChildByName("result")
	local tipsText = ccui.Text:create("", TTF_FONT_FZYH_M, 16)

	tipsText:addTo(panel):posite(85, 20)
	GameStyle:setCommonOutlineEffect(levelText)
	GameStyle:setCommonOutlineEffect(level_r)

	local realIndex = idx + 1
	local data = self._reportList[realIndex]
	local btnVideo = view:getChildByName("button_video")

	btnVideo:addClickEventListener(function()
		self:onClickVideo(data:getId())
	end)

	local attackerData = data:getAttacker()
	local defenseData = data:getDefender()
	local showData, showMyData
	local raise = data:getRankChange()
	local result

	if self._developSystem:getRid() == attackerData:getId() then
		showData = defenseData
		showMyData = attackerData
		result = data:getAttackerWin()
	else
		showMyData = defenseData
		showData = attackerData
		result = not data:getAttackerWin()
	end

	local headId = showMyData:getHeadImg() or "YFZZhu"
	local level = showMyData:getLevel()
	local nickName = showMyData:getNickname()

	iconBg:removeAllChildren()

	local headicon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		id = headId
	})

	headicon:addTo(iconBg):center(iconBg:getContentSize())
	name:setString(nickName)
	levelText:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. level)

	local headId = showData:getHeadImg() or "Master_XueZhan"
	local level = showData:getLevel()
	local nickName = showData:getNickname()

	iconBg_r:removeAllChildren()

	local headicon = IconFactory:createPlayerIcon({
		frameStyle = 3,
		id = headId
	})

	headicon:addTo(iconBg_r):center(iconBg_r:getContentSize())
	name_r:setString(nickName)
	level_r:setString(Strings:get("CUSTOM_FIGHT_LEVEL") .. level)

	if raise <= 0 then
		changeBg:setVisible(false)
	else
		changeBg:setVisible(true)
		sign:loadTexture(kPicUp)
		increase:setString(Strings:get("RANK_UI13", {
			num = raise
		}))
	end

	if result then
		imgResult:getChildByName("text"):setString(Strings:get("Arena_Victory"))
		imgResult:setGray(false)
	else
		imgResult:getChildByName("text"):setString(Strings:get("Arena_Defeat"))
		imgResult:setGray(true)
	end
end

function ArenaNewRecordMediator:onClickVideo(id)
	self._arenaNewSystem:setShowViewAfterBattle("homeView")
	self._arenaNewSystem:requestReportDetail(id)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
end

function ArenaNewRecordMediator:onClickClose()
	self:close()
end

function ArenaNewRecordMediator:onClickSure()
	self:close()
end
