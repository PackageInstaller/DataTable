-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/crusade/view/CrusadePowerMediator.lua

CrusadePowerMediator = class("CrusadePowerMediator", DmPopupViewMediator, _M)

CrusadePowerMediator:has("_crusadeSystem", {
	is = "r"
}):injectWith("CrusadeSystem")
CrusadePowerMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")

function CrusadePowerMediator:initialize()
	super.initialize(self)
end

function CrusadePowerMediator:dispose()
	super.dispose(self)
end

function CrusadePowerMediator:onRegister()
	super.onRegister(self)

	self._bgWidget = bindWidget(self, "bg.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Crusade_Point_9"),
		title1 = Strings:get("Crusade_Point_10"),
		bgSize = {
			width = 800,
			height = 610
		}
	})
end

function CrusadePowerMediator:enterWithData(data)
	self._rewards = data.rewards
	self._currencyId = CurrencyIdKind.kCrusadeEnergy
	self._buffData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Crusade_Energy_Buff", "content")
	self._energyRecoveryData = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Crusade_Energy_Recovery", "content")

	self:initWidgetInfo()
	self:initContent()
	self._bagSystem:bindSchedulerOnView(self)
end

function CrusadePowerMediator:initWidgetInfo()
	self._mainPanel = self:getView():getChildByFullName("bg")
	self._viewPanel1 = self._mainPanel:getChildByName("viewPanel1")
	self._viewPanel2 = self._mainPanel:getChildByName("viewPanel2")
	self._viewPanel3 = self._mainPanel:getChildByName("viewPanel3")
	self._viewPanelCell = self._mainPanel:getChildByName("viewPanelCell")

	self._viewPanelCell:setVisible(false)
end

function CrusadePowerMediator:setViewData()
	return
end

function CrusadePowerMediator:initContent()
	local viewSize = self._viewPanel1:getContentSize()
	local tableView = cc.TableView:create(viewSize)
	local kCellHeight = self._viewPanelCell:getContentSize().height

	local function numberOfCells(view)
		return #self._buffData
	end

	local function cellSize(table, idx)
		return viewSize.width, kCellHeight + 6
	end

	local function cellAtIndex(table, idx)
		local cell = table:dequeueCell()

		if cell == nil then
			cell = cc.TableViewCell:new()

			cell:setContentSize(cc.size(viewSize.width, kCellHeight))
		end

		local index = idx + 1
		local data = self._buffData[index]

		self:addPanel(cell, data)

		return cell
	end

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setDelegate()
	tableView:addTo(self._viewPanel1)
	tableView:registerScriptHandler(numberOfCells, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(cellSize, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(cellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:setMaxBounceOffset(20)
	tableView:reloadData()
	tableView:setTouchEnabled(#self._buffData > 4)
end

function CrusadePowerMediator:addPanel(cell, awardInfo)
	cell:removeAllChildren()

	local panel = self._viewPanelCell:clone()

	panel:setVisible(true)
	panel:addTo(cell):posite(0, cell:getContentSize().height)

	local textlbl_1 = panel:getChildByName("textlbl_1")
	local textlbl_4 = panel:getChildByName("textlbl_4")
	local textlbl_5 = panel:getChildByName("textlbl_5")
	local numlbl_1 = panel:getChildByName("numlbl_1")
	local isLast = tonumber(awardInfo.Max) == 0 and tonumber(awardInfo.Min) == 0

	textlbl_4:setVisible(isLast)
	textlbl_1:setVisible(not isLast)
	textlbl_5:setVisible(not isLast)
	numlbl_1:setVisible(false)
	textlbl_1:setString(awardInfo.Min .. "-" .. awardInfo.Max)

	local buff = ConfigReader:getDataByNameIdAndKey("SkillAttrEffect", awardInfo.Buff, "EffectDesc")

	textlbl_4:setString(Strings:get(buff))
	textlbl_5:setString(Strings:get(buff))
end

function CrusadePowerMediator:onClickClose()
	self:close()
end
