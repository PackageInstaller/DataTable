-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/RelationInfoWidget.lua

RelationInfoWidget = class("RelationInfoWidget", BaseWidget, _M)

local kActiveImg = {
	"yh_jh2.png",
	"yh_ksj.png"
}

function RelationInfoWidget.class:createWidgetNode()
	local resFile = "asset/ui/relationWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function RelationInfoWidget:initialize(view, data)
	super.initialize(self, view)

	data = data or {}
	self._index = data.index or 5
	self._config = data.config
	self._clickInfoFunc = data.clickInfoFunc
	self._clickUpFunc = data.clickUpFunc

	self:initSubviews(view)
end

function RelationInfoWidget:dispose()
	super.dispose(self)
end

function RelationInfoWidget:initSubviews(view)
	self._view = view
end

function RelationInfoWidget:updateView(level, lockState, data)
	if data.config then
		self._config = data.config or self._config
	end

	if self._config.Type == RelationType.kEquip then
		return
	end

	local maxLevel = self._config.EffectLevel

	self._isMaxlevel = level == maxLevel

	self:createInfoPanel(level, lockState, data)
	self:createBgImg(level, lockState, data)
	self:updateNamePanel(level, lockState)
	self:refreshDescPanel(level)
end

function RelationInfoWidget:updateNamePanel(level, lockState)
	local name = self._showNode:getChildByName("name")

	self._showNode:getChildByName("name"):setString(Relation:getName(level, self._config))
	name:disableEffect(1)

	if level == 0 then
		name:setTextColor(cc.c3b(172, 165, 160))
	else
		name:setTextColor(cc.c3b(255, 213, 202))
		name:enableOutline(cc.c4b(27, 25, 24, 173), 2)
	end
end

function RelationInfoWidget:createInfoPanel(level, lockState, data)
	self._view:getChildByName("node_hero"):setVisible(false)
	self._view:getChildByName("node_equip"):setVisible(false)
	self._view:getChildByName("node_global"):setVisible(false)

	if self._config.Type == RelationType.kHero and data.heroes then
		self._showNode = self._view:getChildByName("node_hero")

		self:createHeroRelationPanel(data.heroes, level)
	elseif self._config.Type == RelationType.kEquip and data.equip then
		self._showNode = self._view:getChildByName("node_equip")

		self:createEquipRelationPanel(data.equip, level)
	else
		self._showNode = self._view:getChildByName("node_global")

		self:createBasicPanel(level, lockState, data)
	end

	self._showNode:setVisible(true)
	self._showNode:getChildByName("name"):enableOutline(cc.c4b(81, 56, 38, 147.89999999999998), 2)
end

local descLabelTag = 222

function RelationInfoWidget:refreshDescPanel(level, lockState, data)
	self._showNode:getChildByName("text"):setString("")
	self._showNode:getChildByName("text"):removeAllChildren()
	self._view:removeChildByTag(descLabelTag)

	local developSystem = self:getInjector():getInstance("DevelopSystem")

	local function createShortCondDesc(level, config, developSystem, parent, width, offsetY)
		local maxLevel = self._config.EffectLevel

		level = maxLevel < level and maxLevel or level

		local color = Relation:getFontColorByLevel(level, 1)

		level = level == 0 and 1 or level

		local descLabel = ccui.RichText:createWithXML(Relation:getShortEffectDesc(level, config, {
			fontColor = color,
			developSystem = developSystem
		}, 1), {})

		descLabel:addTo(parent, 1, descLabelTag):offset(0, offsetY)
		descLabel:renderContent(cc.size(width, 0))
		descLabel:setAnchorPoint(cc.p(0, 1))

		return descLabel
	end

	local width = 210
	local offsetY = 50

	if self._config.Type == RelationType.kGlobal then
		width = 586
		offsetY = 35
	elseif self._config.Type == RelationType.kHero then
		width = 330
		offsetY = 35
	end

	createShortCondDesc(level, self._config, developSystem, self._showNode:getChildByName("text"), width, offsetY)
end

function RelationInfoWidget:createHeroRelationPanel(heros, level)
	for i = 1, 5 do
		self._showNode:getChildByFullName("node_" .. i):setVisible(heros[i] and true or false)
	end

	for i = 1, #heros do
		local panel = self._showNode:getChildByFullName("node_" .. i)
		local panel1 = self._showNode:getChildByFullName("node_" .. i .. ".bg")
		local panel2 = self._showNode:getChildByFullName("node_" .. i .. ".unlockBg")

		panel1:setVisible(level == 0)
		panel2:setVisible(level ~= 0)
		panel:removeChildByTag(12138)

		local heroData = heros[i]
		local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroData.id)
		local info = {
			clipType = 2,
			id = roleModel
		}
		local heroImg = IconFactory:createRoleIconSpriteNew(info)

		heroImg = IconFactory:addStencilForIcon(heroImg, info.clipType, cc.size(120, 120))

		heroImg:setScale(0.41)
		heroImg:addTo(panel):center(panel:getContentSize())
		heroImg:setGray(heroData.star == 0)
		heroImg:setTag(12138)

		for j = 1, 7 do
			panel:removeChildByTag(12138 + j)
		end

		if heroData.star ~= 0 then
			local pos1 = {
				cc.p(30, 3),
				cc.p(17, 6),
				cc.p(43, 6),
				cc.p(7, 14),
				cc.p(53, 14),
				cc.p(4, 27),
				cc.p(56, 27)
			}
			local pos2 = {
				cc.p(22, 6),
				cc.p(38, 6),
				cc.p(9, 14),
				cc.p(51, 14),
				cc.p(4, 27),
				cc.p(56, 27)
			}
			local pos = heroData.star % 2 == 0 and pos2 or pos1

			for index = 1, heroData.star do
				local starImg = cc.Sprite:createWithSpriteFrameName("yh_bg_xing_2.png")

				starImg:setPosition(pos[index])
				panel:addChild(starImg)
				starImg:setTag(12138 + index)
			end
		end
	end
end

function RelationInfoWidget:createEquipRelationPanel(equipData, level)
	local panel1 = self._showNode:getChildByFullName("node.bg")
	local panel2 = self._showNode:getChildByFullName("node.unlockBg")

	panel1:setVisible(level == 0)
	panel2:setVisible(level ~= 0)

	local panel = self._showNode:getChildByFullName("node")

	panel:removeChildByTag(12138)

	local info = {
		clipType = 2,
		star = equipData.star,
		id = equipData.id
	}
	local icon = IconFactory:createEquipPic(info)

	icon = IconFactory:addStencilForIcon(icon, info.clipType, cc.size(100, 100))

	icon:setScale(0.58)
	icon:addTo(panel):center(panel:getContentSize())
	icon:setTag(12138)
	icon:offset(1, -1)
end

function RelationInfoWidget:createBasicPanel(level, lockState, data)
	local unlockNum = data.unlockNum

	for i = 1, 7 do
		local panel = self._showNode:getChildByName("icon_" .. i)

		panel:getChildByName("image"):setVisible(i <= unlockNum)
	end
end

function RelationInfoWidget:createBgImg(level, lockState, data)
	local animPanel = self._showNode:getChildByFullName("animPanel")

	if animPanel then
		if not animPanel:getChildByFullName("ActiveAnim") then
			local anim = cc.MovieClip:create("dh_kejihuo")

			anim:addTo(animPanel)
			anim:setName("ActiveAnim")

			local label1 = anim:getChildByFullName("label_1")
			local label2 = anim:getChildByFullName("label_2")
			local image1 = ccui.ImageView:create(kActiveImg[1], 1)

			image1:addTo(label1)

			local image2 = ccui.ImageView:create(kActiveImg[1], 1)

			image2:addTo(label2)
		end

		animPanel:setVisible(lockState == RelationLockState.kCanDevelop)
	end

	self._showNode:getChildByName("activeTip"):removeAllChildren()
	self._showNode:getChildByName("activeTip"):setVisible(lockState == RelationLockState.kCanDevelop)
	self._showNode:getChildByName("stateImg"):setVisible(level ~= 0)
	self._showNode:getChildByName("lockImg"):setVisible(level == 0)

	if level ~= 0 then
		-- block empty
	end

	self:bindTouchEventListener(self._showNode, lockState)

	if not self._isMaxlevel then
		-- block empty
	end
end

function RelationInfoWidget:bindTouchEventListener(sender, lockState)
	sender:setTouchEnabled(true)
	sender:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			if lockState == RelationLockState.kCanDevelop then
				if self._clickUpFunc then
					self._clickUpFunc(self._index, self._anim)
				end
			elseif self._clickInfoFunc then
				self._clickInfoFunc(self._index)
			end
		end
	end)
end
