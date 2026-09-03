-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/popup/ComposeToEquipTipsMediator.lua

ComposeToEquipTipsMediator = class("ComposeToEquipTipsMediator", DmPopupViewMediator, _M)

ComposeToEquipTipsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local HeroEquipExpMax = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipExpMax", "content")
local HeroEquipStarMax = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipStarMax", "content")
local weaponIcon = {
	Weapon = "bb_zb_zb01.png",
	Shoes = "bb_zb_zb04.png",
	Decoration = "bb_zb_zb02.png",
	Tops = "bb_zb_zb03.png"
}

function ComposeToEquipTipsMediator:initialize()
	super.initialize(self)
end

function ComposeToEquipTipsMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function ComposeToEquipTipsMediator:onRemove()
	super.onRemove(self)
end

function ComposeToEquipTipsMediator:onRegister()
	super.onRegister(self)

	self._equipSystem = self._developSystem:getEquipSystem()
	self._main = self:getView():getChildByName("main")

	self.mapEventListener(self, self:getEventDispatcher(), EVT_SHOW_ITEMTIP, self, self.onShowContent)
end

function ComposeToEquipTipsMediator:userInject()
	return
end

function ComposeToEquipTipsMediator:enterWithData(data)
	assert(data.info ~= nil, "error:data.info=nil")
	assert(data.info.id ~= nil, "error:data.info.id=nil")
	self:setUi(data)

	local view = self:getView()
end

function ComposeToEquipTipsMediator:onShowContent(event)
	local data = event:getData()

	assert(data.info ~= nil, "error:data.info=nil")
	assert(data.info.id ~= nil, "error:data.info.id=nil")
	assert(data.icon ~= nil, "error:data.icon=nil")
	self:setUi(data)
	self:adjustPos(data.icon, data.style and data.style.direction)
end

function ComposeToEquipTipsMediator:setUi(data)
	if data.info and data.info.clipIndex then
		data.info.clipIndex = 1
	end

	self._parentMediatorSize = data.info.parentMediatorSize

	local itemId = tostring(data.info.id)
	local composeConfigData = ConfigReader:getRecordById("Compose", itemId)

	self._currency = composeConfigData.Currency

	self:setCompose(data, composeConfigData)
	self:setEquip(composeConfigData.Show.id)

	self._deltaY = -200
end

function ComposeToEquipTipsMediator:setCompose(data, composeConfigData)
	local composePanel = self._main:getChildByName("composePanel")
	local clonePanel = self._main:getChildByName("clonePanel")

	clonePanel:setVisible(false)

	local iconBg = composePanel:getChildByName("icon")
	local icon = IconFactory:createIcon(data.info, {
		showAmount = false
	})

	icon:addTo(iconBg):center(iconBg:getContentSize())
	icon:setScale(0.7)

	local nameText = composePanel:getChildByName("nameText")

	nameText:setString(RewardSystem:getName(data.info))

	local quality = RewardSystem:getQuality(data.info)

	GameStyle:setQualityText(nameText, quality)

	local descText = composePanel:getChildByName("desText")

	descText:setVisible(true)
	descText:setString(RewardSystem:getDesc(data.info))

	local countText = composePanel:getChildByName("haveText")
	local countValue = composePanel:getChildByName("haveNumText")
	local bagSystem = self._developSystem:getBagSystem()

	countValue:setString(bagSystem:getItemCount(tostring(data.info.id)))
	countValue:setPositionX(countText:getPositionX() + countText:getContentSize().width + 3)

	local useItem = {}

	for i = 1, 100 do
		local ItemData = composeConfigData["Item" .. i]

		if ItemData then
			useItem[#useItem + 1] = ItemData
		else
			break
		end
	end

	local usePanel = composePanel:getChildByName("Panel_" .. #useItem)

	if usePanel then
		for i = 1, #useItem do
			local oneItemData = useItem[i]
			local itemPanel = usePanel:getChildByName("Panel_" .. i)

			itemPanel:removeAllChildren()

			local useClonePanel = clonePanel:clone()

			useClonePanel:setVisible(true)
			useClonePanel:addTo(itemPanel):posite(30, 30)

			local Image_pos = useClonePanel:getChildByFullName("Image_pos")

			if oneItemData.id then
				local Image_62 = useClonePanel:getChildByFullName("Image_62")

				Image_62:setVisible(false)

				local pos = bagSystem:getComposePos(oneItemData.id)
				local icon = IconFactory:createIcon({
					id = oneItemData.id,
					amount = oneItemData.amount
				}, {
					showAmount = true
				})

				icon:setScale(0.8)
				icon:addTo(Image_pos):center(Image_pos:getContentSize())
			else
				Image_pos:setVisible(not not weaponIcon[oneItemData.type])

				if weaponIcon[oneItemData.type] then
					Image_pos:loadTexture(weaponIcon[oneItemData.type], ccui.TextureResType.plistType)
				end
			end
		end
	end
end

function ComposeToEquipTipsMediator:setEquip(equipId)
	local equipPanel = self._main:getChildByName("equipPanel")
	local iconBg = equipPanel:getChildByName("icon")

	equipPanel:getChildByFullName("Text_79"):setString(Strings:get("Equip_ShowUI"))

	local id = equipId
	local config = ConfigReader:requireRecordById("HeroEquipBase", id)
	local rarity = config.Rareity
	local level = ConfigReader:getDataByNameIdAndKey("HeroEquipExp", HeroEquipExpMax[tostring(rarity)], "ShowLevel")
	local star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", HeroEquipStarMax[tostring(rarity)], "StarLevel")

	if rarity >= 15 and config.StartEquipEndID then
		star = ConfigReader:getDataByNameIdAndKey("HeroEquipStar", config.StartEquipEndID, "StarLevel")
	end

	local info = {
		id = id,
		level = level,
		rarity = rarity,
		star = star,
		rewardType = RewardType.kEquip
	}
	local icon = IconFactory:createIcon(info, {
		hideLevel = true
	})

	icon:addTo(iconBg):center(iconBg:getContentSize()):offset(-2, 0)
	icon:setScale(0.7)

	local nameText = equipPanel:getChildByName("Text_name")

	nameText:setString(RewardSystem:getName(info))

	local config = ConfigReader:getRecordById("HeroEquipBase", id)

	assert(config, "装备id：%s配置错误", id)
	GameStyle:setRarityText(nameText, config.Rareity)

	local equipOccu = config.Profession
	local occupationDesc = config.ProfessionDesc
	local occupationType = config.ProfessionType
	local limitDesc = equipPanel:getChildByFullName("text")
	local limitDesc1 = equipPanel:getChildByFullName("text1")
	local limitNode = equipPanel:getChildByFullName("limit")

	limitDesc:setString("")
	limitDesc1:setString("")
	limitNode:removeAllChildren()

	if occupationDesc ~= "" then
		limitDesc1:setString(Strings:get("Equip_UI24") .. " " .. Strings:get(occupationDesc))
	else
		limitDesc:setString(Strings:get("Equip_UI24"))

		if occupationType == nil or occupationType == 0 then
			if equipOccu then
				for i = 1, #equipOccu do
					local occupationName, occupationIcon = GameStyle:getHeroOccupation(equipOccu[i])
					local image = ccui.ImageView:create(occupationIcon)

					image:setAnchorPoint(cc.p(0, 0.5))
					image:setPosition(cc.p(40 * (i - 1), 0))
					image:setScale(0.5)
					image:addTo(limitNode)
				end
			end
		elseif occupationType == 1 and equipOccu then
			for i = 1, #equipOccu do
				local heroInfo = {
					id = IconFactory:getRoleModelByKey("HeroBase", equipOccu[i])
				}
				local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

				headImgName:setScale(0.2)

				headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

				headImgName:setAnchorPoint(cc.p(0, 0.5))
				headImgName:setPosition(cc.p(40 * (i - 1), 0))
				headImgName:addTo(limitNode)
			end
		end
	end

	local nodeAttr = equipPanel:getChildByName("nodeAttr")
	local animNode1 = nodeAttr:getChildByFullName("animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -5)
	end

	animNode1:getChildByFullName("BgAnim"):gotoAndPlay(1)

	local attrList = {}
	local params = {
		level = level,
		rarity = rarity,
		star = star,
		config = config
	}
	local attrMap = HeroEquipAttr:getBaseAttrNum(nil, params)

	for i, v in pairs(attrMap) do
		if AttributeCategory:getAttNameAttend(v.attrType) == "" then
			v.attrNum = math.round(v.attrNum)
		end

		attrList[#attrList + 1] = v
	end

	table.sort(attrList, function(a, b)
		return a.index < b.index
	end)

	for i = 1, 2 do
		local attrPanel = nodeAttr:getChildByFullName("desc_" .. i)

		attrPanel:setVisible(false)

		if attrList[i] then
			attrPanel:setVisible(true)

			local attrType = attrList[i].attrType
			local attrNum = attrList[i].attrNum
			local attrImage = attrPanel:getChildByFullName("image")

			attrImage:loadTexture(AttrTypeImage[attrType], 1)

			local attrText = attrPanel:getChildByFullName("text")

			attrText:setString(attrNum)

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrText:setString(attrNum * 100 .. "%")
			end

			local name = attrPanel:getChildByFullName("name")

			name:setString(AttributeCategory:getAttName(attrType))
		end
	end

	if #attrList == 1 then
		local attrPanel = nodeAttr:getChildByFullName("desc_1")

		attrPanel:setPositionY(30)
	end

	local nodeSkill = equipPanel:getChildByName("nodeSkill")
	local animNode2 = nodeSkill:getChildByFullName("animNode")

	if not animNode2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode2)
		anim:setName("BgAnim")
		anim:offset(0, -4)
	end

	animNode2:getChildByFullName("BgAnim"):gotoAndPlay(1)

	local skillListView = nodeSkill:getChildByFullName("listView")

	skillListView:setScrollBarEnabled(false)

	if config.Skill == "" then
		nodeSkill:setVisible(false)
	else
		nodeSkill:setVisible(true)

		local skillName = nodeSkill:getChildByName("name")
		local skillLevel = nodeSkill:getChildByName("level")
		local skillPro = PrototypeFactory:getInstance():getSkillPrototype(config.Skill)
		local skillConfig = skillPro:getConfig()

		skillName:setString(Strings:get(skillConfig.Name))

		local HeroEquipSkillLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipSkillLevel", "content")
		local URUPSkillLV = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", id, "URUPSkillLV")

		if URUPSkillLV then
			HeroEquipSkillLevel = URUPSkillLV
		end

		local maxSkillLevel = #HeroEquipSkillLevel
		local tip = Strings:get("Strenghten_Text78", {
			level = maxSkillLevel
		})

		skillLevel:setString(tip)
		skillLevel:setPositionX(skillName:getPositionX() + skillName:getContentSize().width + 5)

		local title = skillConfig.Desc
		local skillId = config.Skill
		local style = {
			fontSize = 18,
			fontColor = "#7B7474",
			fontName = TTF_FONT_FZYH_M
		}
		local desc = ConfigReader:getEffectDesc("Skill", title, skillId, maxSkillLevel, style)
		local getSkillDesc = skillPro:getAttrDescs(1, style)[1]

		if getSkillDesc then
			local add = "<font face='asset/font/CustomFont_FZYH_M.TTF' size='18' color='#7B7474'>，</font>"

			desc = getSkillDesc .. add .. desc
		end

		local width = skillListView:getContentSize().width
		local label = ccui.RichText:createWithXML(desc, {})

		label:renderContent(width, 0)
		label:setAnchorPoint(cc.p(0, 0))
		label:setPosition(cc.p(0, 0))

		local height = label:getContentSize().height
		local newPanel = ccui.Layout:create()

		newPanel:setContentSize(cc.size(width, height))
		label:addTo(newPanel)
		skillListView:pushBackCustomItem(newPanel)
	end
end

function ComposeToEquipTipsMediator:adjustPos(icon, direction)
	local view = self:getView()

	view:setAnchorPoint(cc.p(0.5, 0.5))
	view:setIgnoreAnchorPointForPosition(false)

	local kUpMargin, kDownMargin, kLeftMargin, kRightMargin = 5, 5, 5, 5
	local contentSize = self._main:getContentSize()
	local viewSize = view:getContentSize()
	local iconBoundingBox = icon:getBoundingBox()
	local worldPos = icon:getParent():convertToWorldSpace(cc.p(iconBoundingBox.x, iconBoundingBox.y))
	local scene = cc.Director:getInstance():getRunningScene()
	local winSize = scene:getContentSize()

	direction = direction or worldPos.y + iconBoundingBox.height + contentSize.height + kUpMargin <= winSize.height - 30 and ItemTipsDirection.kUp or worldPos.x + iconBoundingBox.width * 0.5 < winSize.width * 0.5 and ItemTipsDirection.kRight or ItemTipsDirection.kLeft

	local iconBox = {
		x = worldPos.x,
		y = worldPos.y,
		width = icon:getContentSize().width * icon:getScale(),
		height = icon:getContentSize().height * icon:getScale()
	}
	local x, y
	local contentPosY = self._main:getPositionY()

	if not self._deltaY then
		if direction == ItemTipsDirection.kUp then
			x = iconBox.x + iconBox.width * 0.5
			y = iconBox.y + iconBox.height + kUpMargin + contentPosY - self._deltaY
		elseif direction == ItemTipsDirection.kDown then
			x = iconBox.x + iconBox.width * 0.5
			y = iconBox.y - contentSize.height * 0.5 - kDownMargin
		elseif direction == ItemTipsDirection.kLeft then
			x = iconBox.x - contentSize.width * 0.5 - kLeftMargin
			y = iconBox.y + iconBox.height - viewSize.height * 0.5
		elseif direction == ItemTipsDirection.kRight then
			x = iconBox.x + iconBox.width + contentSize.width * 0.5 + kRightMargin
			y = iconBox.y + iconBox.height - viewSize.height * 0.5
		end

		local nodePos = view:getParent():convertToWorldSpace(cc.p(0, 0))
		local kLeftMinMargin, kRightMinMargin, kUpMinMargin, kDownMinMargin = 0, 0, 0, 0

		if kLeftMinMargin >= x - contentSize.width * 0.5 then
			x = kLeftMinMargin + contentSize.width * 0.5
		elseif x + contentSize.width * 0.5 >= winSize.width - kRightMinMargin then
			x = winSize.width - kRightMinMargin - contentSize.width * 0.5
		end

		if kDownMinMargin > y - contentSize.height * 0.5 then
			y = kDownMinMargin + contentSize.height * 0.5
		elseif y + contentSize.height * 0.5 > winSize.height - kUpMinMargin then
			y = winSize.height - kUpMinMargin - contentSize.height * 0.5
		end

		dump(self._parentMediatorSize, "_parentMediatorSize---------------")
		view:setPosition(cc.p(self._parentMediatorSize.width / 2, self._parentMediatorSize.height / 2))
	end
end
