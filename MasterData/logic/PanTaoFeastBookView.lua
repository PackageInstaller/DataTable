-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pantaofeast/view/PanTaoFeastBookView.lua

module("logic.extensions.pantaofeast.view.PanTaoFeastBookView", package.seeall)

local PanTaoFeastBookView = class("PanTaoFeastBookView", ViewComponent)
local ROW_HEIGHT = 120
local TITLE_HEIGHT = 40
local PRIZE_COUNT_PER_ROW = 7

function PanTaoFeastBookView:ctor()
	PanTaoFeastBookView.super.ctor(self)
end

function PanTaoFeastBookView:unbindEvents()
	PanTaoFeastBookView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PanTaoFeastBookView:bindEvents()
	PanTaoFeastBookView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PanTaoFeastBookView:buildUI()
	PanTaoFeastBookView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, {
		goCell
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableView:regGetCellSize(GameUtil.handler(self._getSourceCellSizeCallBack, self))
	self._tableView:regValueChanged(GameUtil.handler(self._closeBubble, self))

	self._item = self:getGo("item")

	goutil.setActive(self._item, false)
end

function PanTaoFeastBookView:onExit()
	PanTaoFeastBookView.super.onExit(self)
	self._tableView:dispose()
	self:_closeBubble()
end

function PanTaoFeastBookView:onEnter()
	PanTaoFeastBookView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_PanTaoFeastGainBookPrizeRes, self._handleGainBookPrize, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PanTaoFeastController.instance:getDefaultActivityId() or 0
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	PanTaoFeastController.instance:getInfo(self._activityId)
end

function PanTaoFeastBookView:_updateUIByCfg()
	self._curShowDatalist = PanTaoFeastConfig.instance:getAllBookPrizeDataByActId(self._activityId)
end

function PanTaoFeastBookView:_updateUIByInfo()
	self._tableView:reloadData(self._curShowDatalist)
end

function PanTaoFeastBookView:_handleGainBookPrize()
	TipsFacade.instance:openCommonTips(lang("奖励领取成功，已存入仓库"))
	self:_updateUIByInfo()
end

function PanTaoFeastBookView:_updateCell(view, cell, data)
	if not data.prizeList then
		local prizeList = {}
		local prizeCount = #prizeList
		local go = cell.gameObject
		local bg = goutil.findChild(go, "bg")
		local totalHeight = self:_getCellHeightByPrizeCount(prizeCount) - TITLE_HEIGHT

		GameUtil.setHeight(bg, totalHeight)

		for i = 1, 4 do
			local goBoard = goutil.findChild(go, "bg/board" .. i)

			GameUtil.setHeight(goBoard, totalHeight / 2)
		end

		local txtTitle = goutil.findChildTextComponent(go, "txtTitle")

		txtTitle.text = data.subTitle or ""

		local conItemList = goutil.findChild(go, "conItemList")

		GameUtil.updateCellsList(conItemList, self._item, prizeList, self._updateItemCell, self)
	end
end

function PanTaoFeastBookView:_clearCell(cell)
	local go = cell.gameObject
	local conItemList = goutil.findChild(go, "conItemList")

	GameUtil.clearCells(conItemList, self._clearItemCell, self)
end

function PanTaoFeastBookView:_getSourceCellSizeCallBack(view, idx)
	local datalist = self._tableView:getData()
	local data = datalist[idx + 1]

	if not data.prizeList then
		local prizeList = {}
		local prizeCount = #prizeList

		return 100, self:_getCellHeightByPrizeCount(prizeCount)
	end
end

function PanTaoFeastBookView:_updateItemCell(mainGo, data, tabIdx)
	if not data.elementId then
		local elementId = 0
		local elementCfg = PanTaoFeastConfig.instance:getElementCfgByElementId(self._activityId, elementId)
		local isGained = PanTaoFeastModel.instance:hasGainBookPrize(self._activityId, elementId)
		local isUnlocked = PanTaoFeastModel.instance:hasUnlockedBook(self._activityId, elementId)
		local markEmpty = goutil.findChild(mainGo, "empty")
		local btnGain = goutil.findChild(mainGo, "btnGain")
		local icon = goutil.findChild(mainGo, "icon")
		local markNext = goutil.findChild(mainGo, "markNext")
		local nextElementCfg = PanTaoFeastConfig.instance:getNextElementCfgByElementId(self._activityId, elementId)

		uGuiUtil.clearImage(icon)
		goutil.setActive(markNext, nextElementCfg ~= nil)

		if isUnlocked then
			goutil.setActive(markEmpty, false)

			if isGained then
				goutil.setActive(icon, true)
				goutil.setActive(btnGain, false)

				local iconPath = PanTaoFeastController.instance:getElementIconPathById(self._activityId, elementId)

				if not GameUtil.isEmptyString(iconPath) then
					local spriteName = GameUrl.getItemIconUrl(iconPath)

					uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, spriteName)
				end

				local offset = Vector3.New(140, 0, 0)

				if elementCfg then
					if not elementCfg.showDesc then
						local showDesc = ""

						GameUtil.addClickHandler(icon, function()
							self:_closeBubble()

							local suitablePos = BubbleController.instance:getSuitablelPosByGo(icon, showDesc) or Vector3.zero

							BubbleController.instance:OpenView(showDesc, suitablePos, true)
							settimer(3, self._closeBubble, self, false)
						end, self)
					end
				end
			else
				goutil.setActive(icon, false)
				goutil.setActive(btnGain, true)
				GameUtil.addClickHandler(btnGain, function()
					local isUnlocked = PanTaoFeastModel.instance:hasUnlockedBook(self._activityId, elementId)

					if not isUnlocked then
						TipsFacade.instance:openCommonTips(lang("图鉴未解锁，无法领取"))

						return
					end

					PanTaoFeastController.instance:gainBookPrize(self._activityId)
				end, self)
			end
		else
			goutil.setActive(markEmpty, true)
			goutil.setActive(btnGain, false)
			goutil.setActive(icon, false)
		end
	end
end

function PanTaoFeastBookView:_clearItemCell(mainGo)
	local btnGain = goutil.findChild(mainGo, "btnGain")

	GameUtil.rmClickHandler(btnGain)

	local icon = goutil.findChild(mainGo, "icon")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(icon)
end

function PanTaoFeastBookView:_getCellHeightByPrizeCount(prizeCount)
	local rowCount = math.ceil(prizeCount / PRIZE_COUNT_PER_ROW)

	return TITLE_HEIGHT + rowCount * ROW_HEIGHT
end

function PanTaoFeastBookView:_closeBubble()
	removetimer(self._closeBubble, self)
	BubbleController.instance:CloseView()
end

return PanTaoFeastBookView
