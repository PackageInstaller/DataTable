-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonBadgeView.lua

module("logic.extensions.season.view.SeasonBadgeView", package.seeall)

local SeasonBadgeView = class("SeasonBadgeView", ViewComponent)

function SeasonBadgeView:ctor()
	SeasonBadgeView.super.ctor(self)
end

function SeasonBadgeView:unbindEvents()
	SeasonBadgeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i, v in ipairs(self._btnSlot) do
		GameUtil.rmClickHandler(v)
	end
end

function SeasonBadgeView:bindEvents()
	SeasonBadgeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i, v in ipairs(self._btnSlot) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._selectSlot, self, i))
	end
end

function SeasonBadgeView:buildUI()
	SeasonBadgeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtZdl = self:getTxt("power/txtPower")
	self._btnSlot = {}
	self._txtSlot = {}
	self._img = {}
	self._seasonId = SeasonModel.instance:getSeasonId()

	for i = 1, 10 do
		self._btnSlot[i] = self:getBtn(string.format("badgeslots/btnslot_%d", i))
		self._txtSlot[i] = self:getTxt(string.format("badgeslots/btnslot_%d/txt", i))

		local son = {}
		local img = self:getGo(string.format("badgeslots/btnslot_%d/icon", i))
		local config = SeasonMainCampConfig.instance:getBadgeConfig(self._seasonId, i).icon

		GameUtil.getUIImageSpriteChange(img):ChangeSprite(config)
		table.insert(son, img)
		table.insert(son, self:getGo(string.format("badgeslots/btnslot_%d/effect", i)))
		table.insert(son, self:getGo(string.format("badgeslots/btnslot_%d/lock", i)))
		table.insert(self._img, son)
	end

	self._emptyBadge = self:getGo("attrLook/empty")
	self._tableview = self:getGo("suit/tableview")
	self._tablecell = self:getGo("suit/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewAttr = self:getGo("attrLook/tableview")
	self._tablecellAttr = self:getGo("attrLook/tablecell")
	self._scrollListAttr = ScrollerList.create(self._tableviewAttr, self._tablecellAttr, GameUtil.handler(self._updateCellAttr, self), GameUtil.handler(self._clearCellAttr, self))
end

function SeasonBadgeView:onExit()
	SeasonBadgeView.super.onExit(self)
	self._scrollList:dispose()
	self._scrollListAttr:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonBadgeInfoUpdated, self._updateAll, self)
end

function SeasonBadgeView:onEnter()
	SeasonBadgeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonBadgeInfoUpdated, self._updateAll, self)
	SeasonMainCampController.instance:sendGetBudgeInfo()

	self._suitCfgs = SeasonMainCampConfig.instance:getBadgeSuitConfig(self._seasonId)
end

function SeasonBadgeView:_updateAll()
	local attrs = SeasonBadgeModel.instance:getAttrs()

	goutil.setActive(self._emptyBadge, SeasonBadgeModel.instance:getActiveBadgeNum() == 0)
	self:_updateSlotState()
	self:_reloadDataSuit()
	self:_reloadDataAttr(attrs)
	self:_updateZdl(attrs)
end

function SeasonBadgeView:_reloadDataSuit()
	self._scrollList:reloadData(self._suitCfgs)
	self._scrollList:refresh()
end

function SeasonBadgeView:_reloadDataAttr(attrs)
	self._scrollListAttr:reloadData(SeasonMainCampController.instance:toAttrList(attrs))
	self._scrollListAttr:refresh()
end

function SeasonBadgeView:_updateSlotState()
	for i, v in ipairs(self._btnSlot) do
		self:_updateSlotInfo(i, SeasonBadgeModel.instance:getSlotStateById(i))
	end
end

function SeasonBadgeView:_selectSlot(idx)
	local slotState = SeasonBadgeModel.instance:getSlotStateById(idx)

	if slotState == SeasonBadgeModel.SlotInActive then
		SeasonMainCampController.instance:sendActiviteBudge(idx)
	elseif slotState == SeasonBadgeModel.SlotActive then
		-- block empty
	end
end

function SeasonBadgeView:_updateSlotInfo(idx, state)
	for k, v in ipairs(self._img[idx]) do
		goutil.setActive(v, k == state)
	end

	local conf = SeasonMainCampConfig.instance:getBadgeConfig(self._seasonId, idx)

	self._txtSlot[idx].text = conf.name or ""
end

function SeasonBadgeView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)
	local activeBadgeNum = SeasonBadgeModel.instance:getActiveBadgeNum()

	cell.txt_desc.text = langPara("徽章收集（%s/%s）：%s", Mathf.Min(activeBadgeNum, data.num), data.num, data.suitDesc)

	GameUtil.setUITextColorIdx(cell.txt_desc, activeBadgeNum >= data.num and 0 or 1)
end

function SeasonBadgeView:_updateCellAttr(view, goCell, data, tag)
	local cell = self:_clearCellAttr(goCell)

	cell.txt_desc.text = data
end

function SeasonBadgeView:_updateZdl(attrs)
	local zdl = AttrMo.calcFightPowerByAttrs(attrs)

	self._txtZdl.text = langPara("战力\n<size=36><color=#ffffff>%s</color></size>", zdl or 0)
end

function SeasonBadgeView:_closeView()
	self:close()
end

function SeasonBadgeView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txt_desc = goutil.findChildTextComponent(goCell, "txt_desc")

	return cell
end

function SeasonBadgeView:_clearCellAttr(goCell)
	local cell = {}

	cell.go = goCell
	cell.txt_desc = goutil.findChildTextComponent(goCell, "txt_desc")

	return cell
end

return SeasonBadgeView
