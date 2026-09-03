-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattlePassiveSkillTip.lua

BattlePassiveSkillTip = class("BattlePassiveSkillTip", BattleWidget, _M)

function BattlePassiveSkillTip:initialize(view)
	super.initialize(self, view)
	self:_setupView()
end

function BattlePassiveSkillTip:_setupView()
	local touch = self:getView():getChildByName("touch")

	touch:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickHide()
		end
	end)

	self._panelBase = self:getView():getChildByName("Panel_base")
	self._node_left = self:getView():getChildByName("Node_left")
	self._node_right = self:getView():getChildByName("Node_right")
	self._panel_1 = self:getView():getChildByName("Panel_1")

	self._panel_1:setVisible(false)

	self._panel_2 = self:getView():getChildByName("Panel_2")

	self._panel_2:setVisible(false)
	self:hide()
end

function BattlePassiveSkillTip:setListener(listener)
	self._listener = listener
end

function BattlePassiveSkillTip:show(passiveSkill, isLeft)
	self:getView():setVisible(true)
	self._node_right:removeAllChildren()
	self._node_left:removeAllChildren()

	local baseShowNode = self._node_right

	if isLeft then
		baseShowNode = self._node_left
	end

	self._panelBase:setPosition(baseShowNode:getPosition())

	local function refreshSkillCell(cell, info)
		local skillId = info.id
		local skillLv = info.lv
		local descLabel = cell:getChildByName("Text_des")

		descLabel:setVisible(false)

		local text_name = cell:getChildByName("Text_name")
		local panel_skill = cell:getChildByName("Panel_skill")
		local Image_skillBg = cell:getChildByName("Image_skillBg")
		local offsetY = 0
		local adjustNs = {}

		if skillId then
			local lineCount = 0
			local icon = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Icon")
			local image = ccui.ImageView:create("asset/skillIcon/" .. icon .. ".png")

			image:addTo(panel_skill):center(panel_skill:getContentSize())

			local rich

			if info.lock then
				image:setGray(true)

				local richText = ccui.RichText:createWithXML(Strings:get("BATTLE_SectSkill_Unactivated_Detail", {
					fontSize = 16,
					fontName = TTF_FONT_FZYH_M
				}), {})

				richText:setAnchorPoint(descLabel:getAnchorPoint())
				richText:setPosition(cc.p(descLabel:getPosition()))
				richText:addTo(descLabel:getParent())
				richText:renderContent(descLabel:getContentSize().width, 0, true)
				text_name:setString(Strings:get("BATTLE_SectSkill_Unactivated"))

				lineCount = richText:getLineCount()
				rich = richText
			else
				local descKey = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc_short")
				local name = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")
				local desc = ConfigReader:getEffectDesc("Skill", descKey, skillId, skillLv, {
					fontSize = 16,
					fontColor = "#DFDFDF",
					fontName = TTF_FONT_FZYH_M
				})
				local richText = ccui.RichText:createWithXML(desc, {})

				richText:setAnchorPoint(descLabel:getAnchorPoint())
				richText:setPosition(cc.p(descLabel:getPosition()))
				richText:addTo(descLabel:getParent())
				richText:renderContent(descLabel:getContentSize().width, 0, true)

				rich = richText

				local designHeight = 38

				if designHeight < richText:getContentSize().height then
					offsetY = richText:getContentSize().height - designHeight
					adjustNs[#adjustNs + 1] = richText
				end

				text_name:setString(Strings:get(name))

				lineCount = richText:getLineCount()
			end

			adjustNs[#adjustNs + 1] = panel_skill
			adjustNs[#adjustNs + 1] = text_name
			adjustNs[#adjustNs + 1] = Image_skillBg

			if lineCount > 2 then
				cell:setContentSize(cell:getContentSize().width, cell:getContentSize().height + 10)

				local children = cell:getChildren()

				for k, v in pairs(children) do
					v:setPositionY(v:getPositionY() + 10)
				end
			end

			if info.master then
				local tagImg = cell:getChildByName("Image_master")

				tagImg:setVisible(true)
				tagImg:setPositionX(text_name:getPositionX() + text_name:getContentSize().width + 4)

				adjustNs[#adjustNs + 1] = tagImg
			else
				local tempTagImg = cell:getChildByName("Image_temp")
				local heroTagImg = cell:getChildByName("Image_hero")

				tempTagImg:setPositionX(text_name:getPositionX() + text_name:getContentSize().width + 4)
				heroTagImg:setPositionX(text_name:getPositionX() + text_name:getContentSize().width + 4)

				if info.temp then
					tempTagImg:setVisible(true)
					heroTagImg:setVisible(false)
				end

				adjustNs[#adjustNs + 1] = heroTagImg
				adjustNs[#adjustNs + 1] = tempTagImg
			end

			if offsetY > 0 then
				local size = cell:getContentSize()

				size.height = size.height + offsetY

				cell:setContentSize(size)

				for k, v in pairs(adjustNs) do
					v:offset(0, offsetY)
				end
			end

			return image, lineCount
		end
	end

	local listview = self:createListView(baseShowNode)
	local height = 0

	for index = 1, #passiveSkill do
		local skillInfo = passiveSkill[index]

		if skillInfo.master then
			local panelClone = self._panel_1:clone()

			panelClone:setVisible(true)

			if #passiveSkill == 1 then
				panelClone:getChildByName("Image_line"):setVisible(false)
			end

			local icon = refreshSkillCell(panelClone, skillInfo)

			if icon then
				icon:setScale(0.33)
			end

			height = height + panelClone:getContentSize().height

			listview:pushBackCustomItem(panelClone)
		else
			local panelClone = self._panel_2:clone()

			panelClone:setVisible(true)

			if #passiveSkill == index then
				panelClone:getChildByName("Image_line"):setVisible(false)
			end

			local icon = refreshSkillCell(panelClone, skillInfo)

			if icon then
				icon:setScale(0.33)
			end

			height = height + panelClone:getContentSize().height

			listview:pushBackCustomItem(panelClone)
		end
	end

	local viewHeight = #passiveSkill > 3 and 300 or height
	local image_bg1 = self._panelBase:getChildByName("Image_bg1")
	local image_bg = self._panelBase:getChildByName("Image_bg")

	image_bg1:setContentSize(cc.size(image_bg1:getContentSize().width, viewHeight + 3))
	image_bg:setContentSize(cc.size(image_bg:getContentSize().width, viewHeight + 18))
	listview:setContentSize(cc.size(image_bg:getContentSize().width - 10, viewHeight))
	listview:setPosition(cc.p(-3, -viewHeight))
end

function BattlePassiveSkillTip:hide()
	self:getView():setVisible(false)
end

function BattlePassiveSkillTip:onClickHide()
	self._listener:hidePassiveSkillTip()
end

function BattlePassiveSkillTip:createListView(parent)
	local listview = ccui.ListView:create()

	parent:addChild(listview)
	listview:setAnchorPoint(cc.p(0, 0))
	listview:setScrollBarEnabled(false)
	listview:setItemsMargin(0)
	listview:setDirection(ccui.ListViewDirection.vertical)

	return listview
end
