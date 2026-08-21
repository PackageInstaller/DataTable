-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipMakeRangeDlg.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local ResEquipCustomize = require("ClientData/ResEquipCustomize")
local ResEquip = require("ClientData/ResEquip")
local RANGE_TYPE = {
	Suit = 1,
	Prop = 2
}
local strClassName = "EquipRangeCell"
local EquipRangeCell = Class(strClassName, UIControls.Child)

function EquipRangeCell:ctor()
	self.attrPanel = UIControls.Panel(self, "AttrPanel")
	self.suitPanel = UIControls.Panel(self, "SuitPanel")
	self.iconSuit = UIControls.Image(self, "SuitPanel/IconSuit")
	self.textSuit = UIControls.Label(self, "SuitPanel/TextSuit")
	self.icon = UIControls.Image(self, "AttrPanel/Icon")
	self.textName = UIControls.Label(self, "AttrPanel/TextName")
end

function EquipRangeCell:setData(type, data)
	local state = Const.MAKE_EQUIP_RAND_TYPE.None

	if type == RANGE_TYPE.Suit then
		self.suitPanel:setVisible(true)
		self.attrPanel:setVisible(false)

		self.suitId = data

		self.iconSuit:setImage("Atlas/CommonAtlas/" .. ResEquipSuit[self.suitId].big_icon_path, ResEquipSuit[self.suitId].big_icon)
		self.textSuit:setText(ResEquipSuit[self.suitId].name)

		state = self.mParent.randSuits[self.suitId] or Const.MAKE_EQUIP_RAND_TYPE.None
	else
		self.suitPanel:setVisible(false)
		self.attrPanel:setVisible(true)

		self.mainProp = data

		local zhName = ClientUtils.getRolePropZhNameByType(self.mainProp)
		local attriconInfo = ClientUtils.getRolePropIconByType(self.mainProp)

		self.textName:setText(zhName)
		self.icon:setImage(attriconInfo[1], attriconInfo[2])

		state = self.mParent.randMainProps[self.mainProp] or Const.MAKE_EQUIP_RAND_TYPE.None
	end

	local aniStateName = {
		"CustomRangeCellNml",
		"CustomRangeCellMiss",
		"CustomRangeCellChoose",
		"CustomRangeCellSel"
	}

	self:playStateAnimator(aniStateName[state + 1])
end

local strClassName = "ActivityEquipMakeRangeDlg"
local ActivityEquipMakeRangeDlg = Class(strClassName, UIControls.Window)

function ActivityEquipMakeRangeDlg:ctor()
	self:initUI()
end

function ActivityEquipMakeRangeDlg:initUI()
	self.textPart = UIControls.Label(self, "BgPanel/PartPanel/TextPart")
	self.iconPart = UIControls.Image(self, "BgPanel/PartPanel/IconPart")
	self.textRule = UIControls.Label(self, "BgPanel/BgRule/TextRule")
	self.btn1 = UIControls.Button(self, "BgPanel/TabPanel/Btn1")

	self.btn1:addEventClick(self.onBtn1Click)

	self.btn2 = UIControls.Button(self, "BgPanel/TabPanel/Btn2")

	self.btn2:addEventClick(self.onBtn2Click)

	self.attrRangeInfo = UIControls.Panel(self, "BgPanel/AttrRangeInfo")
	self.suitRangeInfo = UIControls.Panel(self, "BgPanel/SuitRangeInfo")
	self.suitRangeCells = {}
	self.propRangeCells = {}
end

function ActivityEquipMakeRangeDlg:setData(actData)
	self.actData = actData
	self.equipId = actData.equipMakeData.resid
	self.pos = ResEquip[self.equipId].position
	self.randSuits = {}

	for i, v in pairs(self.actData.equipMakeData.rand_suit or {}) do
		self.randSuits[v.suit] = v.state
	end

	self.randMainProps = {}

	for i, v in pairs(self.actData.equipMakeData.rand_prop or {}) do
		self.randMainProps[v.main_prop] = v.state
	end

	self.iconPart:setImage("Atlas/CommonAtlas/IconAtlas/EquipAtlas/00", string.format("0%dSel", self.pos - 1))
	self.textPart:setText(UIConst.EQUIP_PART_CONFIG2[self.pos])

	if self.actData.equipMakeData.suit ~= 0 then
		self.btn1:setEnable(true)
		self.btn2:setEnable(false)
		self:refreshAttrRangePanel()
	else
		self.btn1:setEnable(false)
		self.btn2:setEnable(true)
		self:refreshSuitRangePanel()
	end
end

function ActivityEquipMakeRangeDlg:refreshSuitRangePanel()
	self.attrRangeInfo:setVisible(false)
	self.suitRangeInfo:setVisible(true)
	self.textRule:setText(ClientUtils.getClientNotice(742))

	if ResEquipCustomize[self.equipId] and ResEquipCustomize[self.equipId].suit_range then
		local suitRangeData = ResEquipCustomize[self.equipId].suit_range

		for i, v in ipairs(suitRangeData) do
			local cell = self.suitRangeCells[i]

			if cell == nil then
				cell = EquipRangeCell(self, "BgPanel/SuitRangeInfo", "System/Activity/ActivityEquipWash/CustomRangeCell", 0, 0, true)
			end

			cell:setData(RANGE_TYPE.Suit, v)

			self.suitRangeCells[i] = cell
		end
	end
end

function ActivityEquipMakeRangeDlg:refreshAttrRangePanel()
	self.attrRangeInfo:setVisible(true)
	self.suitRangeInfo:setVisible(false)
	self.textRule:setText(ClientUtils.getClientNotice(743))

	if ResEquipCustomize[self.equipId] and ResEquipCustomize[self.equipId].prop_range then
		local propRangeData = ResEquipCustomize[self.equipId].prop_range

		for i, v in ipairs(propRangeData) do
			local cell = self.propRangeCells[i]

			if cell == nil then
				cell = EquipRangeCell(self, "BgPanel/AttrRangeInfo", "System/Activity/ActivityEquipWash/CustomRangeCell", 0, 0, true)
			end

			cell:setData(RANGE_TYPE.Prop, v)

			self.propRangeCells[i] = cell
		end
	end
end

function ActivityEquipMakeRangeDlg:onBtn1Click()
	self.btn1:setEnable(false)
	self.btn2:setEnable(true)
	self:refreshSuitRangePanel()
end

function ActivityEquipMakeRangeDlg:onBtn2Click()
	self.btn1:setEnable(true)
	self.btn2:setEnable(false)
	self:refreshAttrRangePanel()
end

return ActivityEquipMakeRangeDlg
