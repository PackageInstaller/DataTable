-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SkinPreviewTipsInfoPanel.lua

local HeroTagChild = require("UI/Hero/HeroTagChild")
local HeroAttrPanel = require("UI/Hero/HeroAttrPanel")
local ResSkinTag = require("ClientData/ResSkinTag")
local SkinCell = require("UI/Hero/ContentPanel/SkinCell")
local HeroTagTipChild = require("UI/Hero/ContentPanel/HeroTagTipChild")
local ResHero = require("ClientData/ResHero")
local ATTR_PANEL_SKIN_MAP = {
	"e_atk",
	"e_def",
	"e_mhp"
}
local SkinPreviewTipsInfoPanel = Class("SkinPreviewTipsInfoPanel", UIControls.Panel)
local SHOW_TYPE_MODEL = 1
local SHOW_TYPE_PORTRAIT = 2
local SHOW_INFO = {
	{
		Lang.get(958),
		"BtnDrawing",
		"showOnModel"
	},
	{
		Lang.get(30236),
		"BtnModel",
		"showOn2D"
	}
}

function SkinPreviewTipsInfoPanel:ctor()
	self.tagList = {}
	self.attrList = {}
	self.tagTips = {}

	self:initUI()
end

function SkinPreviewTipsInfoPanel:initUI()
	self.txtName = UIControls.Label(self, self.mPath .. "/SkinInfoPanel/TxtPanel/TxtName")
	self.markPanel = UIControls.Panel(self, self.mPath .. "/SkinInfoPanel/MarkPanel")
	self.attrLessPanel = UIControls.Panel(self, self.mPath .. "/SkinInfoPanel/AttrLessPanel")
	self.markTipPanel = UIControls.Panel(self, self.mPath .. "/SkinInfoPanel/MarkTipsPanel")
	self.btnMarkTip = UIControls.Button(self, self.mPath .. "/SkinInfoPanel/MarkPanel")

	self.btnMarkTip:addEventClick(self.onMarkClick)

	self.btnCloseMarkTip = UIControls.Button(self, self.mPath .. "/SkinInfoPanel/MarkTipsPanel/BtnCloes")

	self.btnCloseMarkTip:addEventClick(self.onCloseMark)

	self.oriSkinPanel = UIControls.Panel(self, self.mPath .. "/SkinInfoPanel/OriSkinPanel")
	self.btnChange2d = UIControls.Button(self, self.mPath .. "/BtnChange2D", "TxtChange")

	self.btnChange2d:addEventClick(self.changeShowType)

	self.imgChange2d = UIControls.Image(self, self.mPath .. "/BtnChange2D/ImgChange")
	self.rolePortrait = UIControls.Role(self, self.mPath .. "/SkinInfoPanel/SkinDraw", 0, 0)
	self.img2D = UIControls.Panel(self, self.mPath .. "/SkinInfoPanel/SkinDraw")
	self.rulePanel = UIControls.Panel(self, self.mPath .. "/RulePanel")

	self.rulePanel:setVisible(false)
end

function SkinPreviewTipsInfoPanel:setData(data)
	self.data = data

	local svrData = CurAvatar:getSkinDataByHeroId(data.hero_id)

	self.svrData = svrData.skin or {}

	local geted = CurAvatar.handBookHeroDic[data.hero_id] ~= nil

	self.rulePanel:setVisible(not geted)
	self.rolePortrait:showRole(data.port_id, UIConst.ROLEIMAGE_SHOWTYPE_SHOW_SKIN)
	self:refreshUI(data)
end

function SkinPreviewTipsInfoPanel:refreshUI(data)
	local heroData = ResHero[data.hero_id]
	local name = data.name

	if heroData and heroData.hero_name then
		name = heroData.hero_name .. "·" .. name
	end

	self.txtName:setText(name)

	self.toShowType = SHOW_TYPE_MODEL

	self:changeShowType()
	self:refreshTagPanel(data)
	self:refreshAttrPanel(data)
	self:refreshCell(data)
end

function SkinPreviewTipsInfoPanel:refreshTagPanel(data)
	if data.tag_id then
		if #data.tag_id > #self.tagList then
			for i = #self.tagList + 1, #data.tag_id do
				local tag = HeroTagChild(self, self.mPath .. "/SkinInfoPanel/MarkPanel", "System/Hero/MarkCell", 0, 0, true)

				self.tagList[i] = tag
			end
		end

		for i = 1, #self.tagList do
			if data.tag_id[i] then
				self.tagList[i]:setVisible(true)

				local info = ResSkinTag[data.tag_id[i]]

				self.tagList[i]:setData(info)
			else
				self.tagList[i]:setVisible(false)
			end
		end
	end
end

function SkinPreviewTipsInfoPanel:refreshAttrPanel(data)
	for i = 1, 2 do
		if not self.attrList[i] then
			self.attrList[i] = HeroAttrPanel(self, self.mPath .. "/SkinInfoPanel/AttrLessPanel/Attr" .. i)
		end

		local attr = data.prop and data.prop[i] or nil

		if attr then
			local name, valueStr = ClientUtils.getRolePropZhNameByType(attr.type, attr.value)
			local attriconInfo = ClientUtils.getRolePropIconByType(attr.type)

			self.attrList[i]:setVisible(true)
			self.attrList[i]:setData(name, valueStr)
			self.attrList[i].imgIcon:setImage(attriconInfo[1], attriconInfo[2])
		else
			self.attrList[i]:setVisible(false)
		end
	end
end

function SkinPreviewTipsInfoPanel:changeShowType()
	local info = SHOW_INFO[self.toShowType]

	self.btnChange2d:setText(info[1])
	self.imgChange2d:setImage("Atlas/HeroAtlas/HeroSkinAtlas", info[2])

	local func = self[info[3]]

	if func then
		func(self)
	end
end

function SkinPreviewTipsInfoPanel:showOnModel()
	self.mWindow:hideModel(false)
	self.img2D:setVisible(false)

	self.toShowType = SHOW_TYPE_PORTRAIT
end

function SkinPreviewTipsInfoPanel:showOn2D()
	self.mWindow:hideModel(true)
	self.img2D:setVisible(true)

	self.toShowType = SHOW_TYPE_MODEL
end

function SkinPreviewTipsInfoPanel:refreshCell(data)
	if not self.skinCell then
		self.skinCell = SkinCell(self, self.mPath .. "/SkinInfoPanel/SkinCardPanel", "System/Hero/SkinCardCell", 0, 0, true)
	end

	local hasGet = false

	if self.svrData[data.id] then
		hasGet = true
	end

	local onWear = false

	self.skinCell:setVisible(true)
	self.skinCell:setData(data, hasGet, onWear)
	self.skinCell:setSelected(true)
	self.skinCell:setBtnHide(true)
end

function SkinPreviewTipsInfoPanel:onMarkClick()
	if #self.tagList > 0 then
		self.markTipPanel:setVisible(true)

		if #self.tagList > #self.tagTips then
			for i = #self.tagTips + 1, #self.tagList do
				local markTag = HeroTagTipChild(self, self.mPath .. "/SkinInfoPanel/MarkTipsPanel/MarkDesPanel/Content", "System/Hero/MarkDesCell", 0, 0, true)

				self.tagTips[i] = markTag
			end
		end

		for idx, tag in ipairs(self.tagTips) do
			if self.tagList[idx] then
				self.tagTips[idx]:setVisible(true)
				self.tagTips[idx]:setData(self.tagList[idx].data)
			else
				self.tagTips[idx]:setVisible(false)
			end
		end
	end
end

function SkinPreviewTipsInfoPanel:onCloseMark()
	self.markTipPanel:setVisible(false)
end

return SkinPreviewTipsInfoPanel
