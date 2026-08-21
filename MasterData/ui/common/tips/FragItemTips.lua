-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\FragItemTips.lua

local ItemGuidePanel = require("UI/Common/Tips/ItemGuidePanel")
local strClassName = "FragItemTips"
local FragItemTips = Class(strClassName, UIControls.Tips)

function FragItemTips:ctor()
	self:initUI()
end

function FragItemTips:initUI()
	self.gridItem = UIControls.FragItemGridChild(self, "BgPanel/GridPanel", "System/Common/Grid/GridShatterItem")

	self.gridItem:setVisible(true)

	self.gridItem.mEnableTips = false
	self.textName = UIControls.Label(self, "BgPanel/TextName")
	self.textType = UIControls.Label(self, "BgPanel/TextName/TextType")
	self.textDesc = UIControls.Label(self, "BgPanel/TextRule")
	self.textNum = UIControls.Label(self, "BgPanel/TextNum")
	self.textTime = UIControls.Label(self, "BgPanel/TextTime")
	self.textSell = UIControls.Label(self, "BgPanel/TextSell")

	self:initFuncBtn(3)

	self.panelGuide = ItemGuidePanel(self, "BgPanel/TipsWayPanel")
	self.btnGuild = UIControls.Button(self, "BgPanel/BtnWay")

	self.btnGuild:addEventClick(self.onClickGuild)
end

function FragItemTips:_setObj(grid)
	self.srcGrid = grid
	self.item = grid.object

	if not self.item or not self.item.resData then
		return
	end

	self.gridItem:setObj(BaseObject.GetObject(self.item.id))
	self.textName:setText(self.item.resData.name or "")
	self.textType:setText(self.item.resData.type_name or "")
	self.textDesc:setText(self.item.resData.desc or "")
	self.textNum:setText(string.format(Lang.get(30234), ClientUtils.getNumShortStr(CurAvatar:getItemNumById(self.item.id))))
	self.textTime:setVisible(false)

	if self.item.resData.sell_price then
		self.textSell:setText(string.format(Lang.get(30235), self.item.resData.sell_price))
	else
		self.textSell:setText(Lang.get(970))
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_ITEM_GUILD) then
		self.btnGuild:setVisible(false)
	elseif self.item.resData.get_ids and #self.item.resData.get_ids > 0 then
		self.btnGuild:setVisible(true)
	else
		self.btnGuild:setVisible(false)
	end
end

function FragItemTips:clear()
	FragItemTips.super.clear(self)
	self.gridItem:clear()
end

function FragItemTips:onClickGuild()
	self.panelGuide:show(self.item.resData.get_ids, self.srcGrid, self.uiConfig)
end

return FragItemTips
