-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\GemRandomInfoPanel.lua

local ResPetGemAttrLibrary = require("ClientData/ResPetGemAttrLibrary")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "GemRandomInfoPanel"
local GemRandomInfoPanel = Class(strClassName, UIControls.Panel)
local MAIN_ATTR_MAX_NUM = 6
local SUB_ATTR_MAX_NUM = 16

function GemRandomInfoPanel:ctor()
	self:initUI()
end

function GemRandomInfoPanel:initUI()
	self.mainAttrPanel = {}

	for i = 1, MAIN_ATTR_MAX_NUM do
		local textAttr = UIControls.Label(self, self.mPath .. "/Bg/ContentAttrMain/Attr" .. i)

		table.insert(self.mainAttrPanel, {
			textAttr = textAttr
		})
	end

	self.subAttrPanel = {}

	for i = 1, SUB_ATTR_MAX_NUM do
		local textAttr = UIControls.Label(self, self.mPath .. "/Bg/ContentAttr/Attr" .. i)

		table.insert(self.subAttrPanel, {
			textAttr = textAttr
		})
	end
end

function GemRandomInfoPanel:setData(gem)
	self.gem = gem

	local level = self.gem.level or self.gem.resData.level

	self.mainRandomAttrList = {}
	self.subRandomAttrList = {}

	for i, v in pairs(ResPetGemAttrLibrary) do
		if v.library_id == level then
			local attrName = BattleConst.PROP_TYPE_CONFIG[v.attr[1].type_id]
			local zhName = ClientUtils.getRolePropZhName(attrName)

			table.insert(self.mainRandomAttrList, zhName)
		end

		if v.library_id == level + 100 then
			table.insert(self.subRandomAttrList, v.type_desc)
		end
	end

	for i, v in ipairs(self.mainAttrPanel) do
		if self.mainRandomAttrList[i] then
			v.textAttr:setText(self.mainRandomAttrList[i])
			v.textAttr:setVisible(true)
		else
			v.textAttr:setVisible(false)
		end
	end

	for i, v in ipairs(self.subAttrPanel) do
		if self.subRandomAttrList[i] then
			v.textAttr:setText(self.subRandomAttrList[i])
			v.textAttr:setVisible(true)
		else
			v.textAttr:setVisible(false)
		end
	end
end

return GemRandomInfoPanel
