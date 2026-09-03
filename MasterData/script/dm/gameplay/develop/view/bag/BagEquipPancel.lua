-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/bag/BagEquipPancel.lua

BagEquipPancel = class("BagEquipPancel", _G.DisposableObject, _M)

local _G = _G
local Strings = _G.Strings
local kAttrPosY = {
	{
		32
	},
	{
		47,
		17
	},
	{
		47,
		17,
		16
	}
}

function BagEquipPancel:initialize(view, uiNode)
	super.initialize(self)

	self._view = view
	self._uiNode = uiNode
	self._equipSystem = self._view._equipSystem

	self:onInitUI()
end

function BagEquipPancel:dispose()
	super.dispose(self)
end

function BagEquipPancel:show(entry)
	if not entry then
		return
	end

	local item = entry.item

	self._entryId = item:getId()
	self._equipData = item:getEquipData()
	self._equipId = self._equipData:getId()

	self._uiNode:setVisible(true)
	self:refreshView()
end

function BagEquipPancel:hide()
	self._uiNode:setVisible(false)
end

function BagEquipPancel:onInitUI()
	local view = self._view
	local uiNode = self._uiNode

	view:mapEventListener(view:getEventDispatcher(), EVT_EQUIP_LOCK_SUCC, self, self.refreshViewByLock)

	local this = self

	function view.onClickLock()
		this:onClickLock()
	end

	self._strengthenWidget = view:bindWidget("mainpanel.equipPanel.btnPanel.strengthenBtn", TwoLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthen, self)
		}
	})
	self._resolveWidget = view:bindWidget("mainpanel.equipPanel.btnPanel.resolveBtn", TwoLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickResolve, self)
		}
	})
	self._nodeDesc = uiNode:getChildByFullName("nodeDesc")
	self._nodeAttr = uiNode:getChildByFullName("nodeAttr")
	self._nodeSkill = uiNode:getChildByFullName("nodeSkill")
	self._strengthenBtn = uiNode:getChildByFullName("btnPanel.strengthenBtn")
	self._resolveBtn = uiNode:getChildByFullName("btnPanel.resolveBtn")

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:enableOutline(cc.c4b(69, 35, 6, 140), 2)

	local limitDesc = self._nodeDesc:getChildByFullName("text")

	limitDesc:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local levelTxt = self._nodeDesc:getChildByFullName("level")

	levelTxt:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	local desc = self._nodeSkill:getChildByFullName("desc")
	local size = desc:getContentSize()
	local x, y = desc:getPosition()
	local descScrollView = ccui.ScrollView:create()

	descScrollView:setTouchEnabled(true)
	descScrollView:setBounceEnabled(true)
	descScrollView:setDirection(ccui.ScrollViewDir.vertical)
	descScrollView:setContentSize(size)
	descScrollView:setPosition(cc.p(x, y))
	descScrollView:setAnchorPoint(cc.p(0, 1))
	self._nodeSkill:addChild(descScrollView, desc:getLocalZOrder())

	self._descScrollView = descScrollView

	desc:setVisible(false)
end

function BagEquipPancel:isShow()
	return self._uiNode:getVisible()
end

function BagEquipPancel:refreshView()
	self:refreshEquipBaseInfo()
	self:refreshAttr()
	self:refreshSkill()
	self:refreshBtn()
end

function BagEquipPancel:refreshViewByLock(event)
	local data = event:getData()

	if self._equipData then
		local equipData = self._equipData

		if equipData:getUnlock() then
			if not kLockImage[2] then
				local image = kLockImage[1]
				local lockBtn = self._nodeDesc:getChildByFullName("lockBtn")

				lockBtn:getChildByName("image"):loadTexture(image)

				if data.viewtype == 1 then
					if equipData:getUnlock() then
						local var_9_1 = Strings:get("Equip_Success_Unlock")

						if not var_9_1 then
							var_9_1 = Strings:get("Equip_Success_Lock")

							local tip = var_9_1

							self._view:dispatch(ShowTipEvent({
								tip = tip
							}))
						end
					end
				end
			end
		end
	end
end

function BagEquipPancel:refreshEquipBaseInfo()
	local name = self._equipData:getName()
	local rarity = self._equipData:getRarity()
	local level = self._equipData:getLevel()
	local star = self._equipData:getStar()
	local equipOccu = self._equipData:getOccupation()
	local occupationDesc = self._equipData:getOccupationDesc()
	local occupationType = self._equipData:getOccupationType()
	local iconpanel = self._nodeDesc:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local param = {
		id = self._equipData:getEquipId(),
		level = level,
		star = star,
		rarity = rarity
	}
	local equipIcon = IconFactory:createEquipPic(param, {
		ignoreScaleSize = true
	})

	equipIcon:addTo(iconpanel):center(iconpanel:getContentSize())

	local starPanel = self._nodeDesc:getChildByFullName("star")
	local starNode = starPanel:getChildByName("StarImage")

	if not starNode then
		starNode = ccui.Widget:create()

		starNode:addTo(starPanel):posite(0, -5)
		starNode:setAnchorPoint(cc.p(0.5, 0))
		starNode:setScale(0.9)
		starNode:setName("StarImage")
	end

	starNode:removeAllChildren()

	local index = 0
	local posXOffset

	for i = 1, 5 do
		if star - i >= 5 then
			index = index + 1

			local image = ccui.ImageView:create("asset/common/yinghun_img_star_color.png")

			image:addTo(starNode)
			image:setPosition(cc.p(13 + 30 * (index - 1), 19.5))
		elseif star - i >= 0 then
			posXOffset = posXOffset or index == 0 and 17 or 13
			index = index + 1

			local image = ccui.ImageView:create("img_yinghun_img_star_full.png", 1)

			image:addTo(starNode):setScale(0.625)
			image:setPosition(cc.p(posXOffset + 32 * (index - 1), 21.5))
		end
	end

	starNode:setContentSize(cc.size(32 * index, 43))

	local rarityPanel = self._nodeDesc:getChildByFullName("rarity")

	rarityPanel:removeAllChildren()

	if rarity >= 15 then
		local flashFile = GameStyle:getEquipRarityFlash(rarity)
		local anim = cc.MovieClip:create(flashFile)

		anim:addTo(rarityPanel)
	else
		local imageFile = GameStyle:getEquipRarityImage(rarity)
		local rarityImage = rarityPanel:getChildByName("RarityImage")

		if not rarityImage then
			rarityImage = ccui.ImageView:create(imageFile)

			rarityImage:addTo(rarityPanel)
			rarityImage:setName("RarityImage")
			rarityImage:ignoreContentAdaptWithSize(true)
			rarityImage:setScale(0.9)
		end

		rarityImage:loadTexture(imageFile)
	end

	local levelTxt = self._nodeDesc:getChildByFullName("level")

	levelTxt:setString(Strings:get("Strenghten_Text78", {
		level = level
	}))

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:setString(name)
	GameStyle:setRarityText(nameLabel, rarity)

	local lockBtn = self._nodeDesc:getChildByFullName("lockBtn")
	local position = self._equipData:getPosition()

	lockBtn:setVisible(position ~= HeroEquipType.kStarItem)

	if lockBtn:isVisible() then
		if self._equipData:getUnlock() then
			if not kLockImage[2] then
				do
					local image = kLockImage[1]
					local lockBtn = self._nodeDesc:getChildByFullName("lockBtn")

					lockBtn:getChildByName("image"):loadTexture(image)
				end

				local limitDesc = self._nodeDesc:getChildByFullName("text")
				local limitNode = self._nodeDesc:getChildByFullName("limit")

				limitNode:removeAllChildren()

				if occupationDesc ~= "" then
					limitDesc:setString(Strings:get("Equip_UI24") .. " " .. Strings:get(occupationDesc))
				else
					limitDesc:setString(Strings:get("Equip_UI24"))

					local width = 0

					if getCurrentLanguage() ~= GameLanguageType.CN then
						width = 40

						if getCurrentLanguage() ~= GameLanguageType.ES then
							width = 55
						end
					end

					if occupationType == nil or occupationType == 0 then
						if equipOccu then
							for i = 1, #equipOccu do
								local occupationName, occupationIcon = GameStyle:getHeroOccupation(equipOccu[i])
								local image = ccui.ImageView:create(occupationIcon)

								image:setAnchorPoint(cc.p(0, 0.5))
								image:setPosition(cc.p(40 * (i - 1) + width, 0))
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
							headImgName:setPosition(cc.p(40 * (i - 1) + width, 0))
							headImgName:addTo(limitNode)
						end
					end
				end
			end
		end
	end
end

function BagEquipPancel:refreshAttr()
	local position = self._equipData:getPosition()
	local descLabel = self._nodeAttr:getChildByName("desc")

	if position == HeroEquipType.kStarItem then
		self._nodeAttr:getChildByName("text"):setString(Strings:get("Equip_UI59"))

		for i = 1, 3 do
			local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

			attrPanel:setVisible(false)
		end

		descLabel:setString(self._equipData:getDesc())
	else
		local attrList = self._equipData:getAttrListShow()

		descLabel:setString("")
		self._nodeAttr:getChildByName("text"):setString(Strings:get("HEROS_UI46"))

		local length = #attrList
		local posY = kAttrPosY[length]

		for i = 1, 3 do
			local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

			attrPanel:setVisible(false)

			if attrList[i] then
				attrPanel:setVisible(true)

				if posY and posY[i] then
					attrPanel:setPositionY(posY[i])
				end

				local attrType = attrList[i].attrType
				local attrNum = attrList[i].attrNum
				local attrName = AttributeCategory:getAttName(attrType)
				local attrTypeImage = AttrTypeImage[attrType]
				local attrImage = attrPanel:getChildByFullName("image")

				attrImage:loadTexture(attrTypeImage, 1)

				local name = attrPanel:getChildByFullName("name")

				name:setString(attrName)

				local attrText = attrPanel:getChildByFullName("text")

				attrText:setString(attrNum)

				if AttributeCategory:getAttNameAttend(attrType) ~= "" then
					attrText:setString(attrNum * 100 .. "%")
				end
			end
		end
	end
end

function BagEquipPancel:refreshSkill()
	local equipData = self._equipData
	local position = equipData:getPosition()

	if position == HeroEquipType.kStarItem then
		self._nodeSkill:setVisible(false)

		return
	end

	local nodeSkill = self._nodeSkill

	nodeSkill:setVisible(true)

	local skillName = nodeSkill:getChildByFullName("name")
	local skillDesc = self._descScrollView
	local skillLock = nodeSkill:getChildByFullName("skillLock")
	local skillBg = nodeSkill:getChildByFullName("skillBg")
	local isHaveSkill = equipData:isHaveSkill()

	skillLock:setVisible(not isHaveSkill)
	skillName:setVisible(isHaveSkill)
	skillDesc:setVisible(isHaveSkill)
	skillBg:setVisible(isHaveSkill)

	local strSpace = ""
	local language = getCurrentLanguage()

	if language ~= GameLanguageType.CN then
		strSpace = " "
	end

	local skillAttr = equipData:getSkill()

	if isHaveSkill and skillAttr then
		local name = skillAttr:getName()
		local level = skillAttr:getLevel()

		skillName:setString(name)

		local width = skillDesc:getContentSize().width
		local height = skillDesc:getContentSize().height

		skillDesc:removeAllChildren()

		local desc = skillAttr:getSkillDesc()

		if level == 0 then
			desc = skillAttr:getSkillDesc({
				fontColor = "#C1C1C1"
			})

			local unlockLevel = equipData:getUnLockSkillLevel()
			local tip = Strings:get("Equip_UI47") .. strSpace .. Strings:get("Strenghten_Text78", {
				level = unlockLevel
			}) .. strSpace .. Strings:get("Equip_UI48")

			skillName:setString(name .. " " .. tip)
		else
			skillName:setString(name .. " " .. (equipData:isSkillMaxLevel() and Strings:get("Strenghten_Text79") or Strings:get("Strenghten_Text78", {
				level = level
			})))
		end

		local label = ccui.RichText:createWithXML(desc, {})

		label:renderContent(width, 0)
		label:setAnchorPoint(cc.p(0, 1))
		label:addTo(skillDesc)
		label:setPosition(cc.p(0, height))

		local descScrollView = skillDesc
		local size = skillDesc:getContentSize()

		size.height = label:getContentSize().height

		if size.height > descScrollView:getContentSize().height then
			descScrollView:setTouchEnabled(true)
		else
			size = descScrollView:getContentSize()

			descScrollView:setTouchEnabled(false)
		end

		descScrollView:setInnerContainerSize(size)
		label:setPositionY(size.height)
	end
end

function BagEquipPancel:refreshBtn()
	local equipData = self._equipData
	local position = equipData:getPosition()

	if equipData:getHeroId() ~= "" or not equipData:getUnlock() then
		self._resolveBtn:setVisible(false)
		self._strengthenBtn:setVisible(true)
		self._strengthenBtn:setPositionX(171)
	elseif position == HeroEquipType.kStarItem then
		self._resolveBtn:setVisible(false)
		self._strengthenBtn:setVisible(false)
	else
		self._resolveBtn:setVisible(false)
		self._strengthenBtn:setVisible(true)
		self._strengthenBtn:setPositionX(171)
	end

	self._strengthenBtn:setVisible(CommonUtils.GetSwitch("fn_equip_strengthen"))
end

function BagEquipPancel:onClickStrengthen(sender, eventType)
	local param = {
		equipId = self._equipId
	}

	self._equipSystem:tryEnter(param)
end

function BagEquipPancel:onClickResolve(sender, eventType)
	local equipData = self._equipData

	if not equipData:getUnlock() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI60")
		}))

		return
	end

	local param = {
		equipId = self._equipId
	}
	local EquipMainView = self._view:getInjector():getInstance("EquipResolveView")

	self._view:dispatch(ViewEvent:new(EVT_PUSH_VIEW, EquipMainView, nil, param))
end

function BagEquipPancel:onClickLock()
	local params = {
		viewtype = 1,
		equipId = self._equipId
	}

	self._equipSystem:requestEquipLock(params)
end
