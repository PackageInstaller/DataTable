-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthEquipMediator.lua

HeroStrengthEquipMediator = class("HeroStrengthEquipMediator", DmAreaViewMediator, _M)

HeroStrengthEquipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroStrengthEquipMediator:has("_heroSystem", {
	is = "r"
})
HeroStrengthEquipMediator:has("_equipSystem", {
	is = "r"
})

local EquipPositionToType = _G.EquipPositionToType
local kAttrPosY = {
	{
		55
	},
	{
		71,
		39
	}
}
local kBtnHandlers = {
	["mainpanel.equipPanel.tipPanel.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTip"
	}
}
local kEquipTypeToImage = {
	[HeroEquipType.kWeapon] = "yinghun_wuqi.png",
	[HeroEquipType.kDecoration] = "yinghun_peishi.png",
	[HeroEquipType.kTops] = "yinghun_yifu.png",
	[HeroEquipType.kShoes] = "yinghun_xie.png"
}
local kEquipTypeToName = {
	[HeroEquipType.kWeapon] = Strings:get("Equip_Name_Weapon"),
	[HeroEquipType.kDecoration] = Strings:get("Equip_Name_Decoration"),
	[HeroEquipType.kTops] = Strings:get("Equip_Name_Tops"),
	[HeroEquipType.kShoes] = Strings:get("Equip_Name_Shoes")
}
local HeroEquipPowerUpOrder = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipPowerUpOrder", "content")

function HeroStrengthEquipMediator:initialize()
	super.initialize(self)
end

function HeroStrengthEquipMediator:dispose()
	if self._equipInfoView then
		self._equipInfoView:dispose()

		self._equipInfoView = nil
	end

	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)
	end

	super.dispose(self)
end

function HeroStrengthEquipMediator:onRegister()
	super.onRegister(self)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_LOCK_SUCC, self, self.refreshViewByLock)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_ONEKEY_LEVELUP_SUCC, self, self.strengthEquipSucc)
	self:bindWidget("mainpanel.equipPanel.btnPanel.takeOffBtn", OneLevelMainButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickTakeOff, self)
		},
		btnSize = {
			width = 232,
			height = 108
		}
	})
	self:bindWidget("mainpanel.equipPanel.btnPanel.equipBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickEquip, self)
		},
		btnSize = {
			width = 232,
			height = 108
		}
	})
	self:bindWidget("mainpanel.equipPanel.btnPanel.strengthBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickOneKeyStrengthen, self)
		},
		btnSize = {
			width = 232,
			height = 108
		}
	})
end

function HeroStrengthEquipMediator:setupView(parentMedi, data)
	self._mediator = parentMedi

	self:refreshData(data.id)
	self:initNodes()
	self:createEquipView()
end

function HeroStrengthEquipMediator:refreshData(heroId)
	self._heroId = heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
end

function HeroStrengthEquipMediator:refreshView(hideAnim)
	if not hideAnim then
		self._equipInfo:setVisible(false)
	end

	self:refreshEquip()
end

function HeroStrengthEquipMediator:refreshViewByLock(event)
	if self._equipInfoView then
		self._equipInfoView:refreshData()
		self._equipInfoView:refreshLock()

		local data = event:getData()

		if data.viewtype == 1 then
			self._equipInfoView:showLockTip()
		end
	end
end

function HeroStrengthEquipMediator:initNodes()
	self:mapButtonHandlersClick(kBtnHandlers)

	self._mainPanel = self:getView():getChildByFullName("mainpanel")

	self._mainPanel:setSwallowTouches(false)
	self._mainPanel:setTouchEnabled(true)
	self._mainPanel:addClickEventListener(function()
		if self._equipInfo and self._equipInfo:isVisible() then
			self._equipInfo:setVisible(false)
		end
	end)

	self._equipPanel = self._mainPanel:getChildByFullName("equipPanel")
	self._equipInfo = self._mainPanel:getChildByFullName("equipInfo")

	self._equipInfo:setVisible(false)

	self._emptyNode = self._equipPanel:getChildByFullName("emptyNode")

	self._emptyNode:setVisible(false)
	self._emptyNode:ignoreContentAdaptWithSize(true)

	self._btnPanel = self._equipPanel:getChildByFullName("btnPanel")
	self._takeOffBtn = self._btnPanel:getChildByFullName("takeOffBtn")
	self._equipBtn = self._btnPanel:getChildByFullName("equipBtn")
	self._strengthBtn = self._btnPanel:getChildByFullName("strengthBtn")
	self._strengthIcon = self._strengthBtn:getChildByFullName("icon")
	self._strengthNum = self._strengthBtn:getChildByFullName("cost")

	self._strengthIcon:setPositionX(self._strengthNum:getPositionX() - self._strengthNum:getContentSize().width / 2 - 14)

	local icon = IconFactory:createPic({
		id = CurrencyIdKind.kGold
	})

	icon:offset(0, -2)
	self._strengthIcon:addChild(icon)

	local infoViewData = {
		mediator = self,
		mainNode = self._equipInfo
	}

	self._equipInfoView = self._heroSystem:enterEquipInfoView(infoViewData)

	local strengthenBtn = self._equipInfoView:getView():getChildByFullName("equipPanel.btnPanel.strengthenBtn")
	local changeBtn = self._equipInfoView:getView():getChildByFullName("equipPanel.btnPanel.changeBtn")

	self:bindWidget(strengthenBtn, ThreeLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthen, self)
		}
	})
	self:bindWidget(changeBtn, ThreeLevelMainButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickChange, self)
		}
	})
end

function HeroStrengthEquipMediator:createEquipView()
	self._equipList = {}

	for i = 1, #EquipPositionToType do
		local equipType = EquipPositionToType[i]
		local equipPanel = self._equipPanel:getChildByFullName("node_" .. i)

		equipPanel:addClickEventListener(function()
			self:onClickEquipIcon(i)
		end)

		local desc1 = equipPanel:getChildByFullName("infoNode.desc_1")
		local desc2 = equipPanel:getChildByFullName("infoNode.desc_2")

		GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("name"), 219.29999999999998)
		GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("name"), 219.29999999999998)
		GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("text"), 142.8)
		GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("text"), 142.8)

		self._equipList[i] = {
			equipPanel = equipPanel,
			equipType = equipType
		}

		equipPanel:setOpacity(0)
		equipPanel:setScaleX(0)
		equipPanel:runAction(cc.FadeIn:create(0.3))
		equipPanel:runAction(cc.Sequence:create({
			cc.ScaleTo:create(0.15, 1.2, 1),
			cc.ScaleTo:create(0.15, 1, 1)
		}))
	end

	self:refreshEquip()
end

function HeroStrengthEquipMediator:refreshEquip()
	local canStrengthen = table.nums(self._heroData:getEquipIds()) > 0

	self._takeOffBtn:setVisible(canStrengthen)
	self._strengthBtn:setVisible(canStrengthen)

	local equips = {}

	for index = 1, #EquipPositionToType do
		local panel = self._equipList[index].equipPanel
		local equipType = self._equipList[index].equipType
		local equipId = self._heroData:getEquipIdByType(equipType)
		local bg = panel:getChildByFullName("bg")
		local redPoint = panel:getChildByFullName("redPoint")
		local infoNode = panel:getChildByFullName("infoNode")
		local hasEquip = not not equipId
		local bgImg = "yinghun_bg_equi02.png"

		infoNode:setVisible(hasEquip)

		if hasEquip then
			panel:removeChildByName("EmptyNode")

			local nameLabel = infoNode:getChildByFullName("name")
			local levelLabel = infoNode:getChildByFullName("level")
			local skillName = infoNode:getChildByFullName("skillName")
			local skillLevel = infoNode:getChildByFullName("skillLevel")
			local node = infoNode:getChildByFullName("node")

			node:removeAllChildren()
			nameLabel:setContentSize(cc.size(123, 40))

			local equipData = self._equipSystem:getEquipById(equipId)

			equips[equipType] = equipData

			local name = equipData:getName()
			local rarity = equipData:getRarity()
			local level = equipData:getLevel()
			local levelMax = equipData:getMaxLevel()
			local star = equipData:getStar()
			local param = {
				id = equipData:getEquipId(),
				level = level,
				star = star,
				rarity = rarity
			}
			local equipIcon = IconFactory:createEquipIcon(param, {
				hideLevel = true
			})

			equipIcon:addTo(node):center(node:getContentSize())
			equipIcon:setScale(0.84)

			local levelStr = Strings:get("Strenghten_Text78", {
				level = level .. "/" .. levelMax
			})

			nameLabel:setString(name)
			levelLabel:setString(levelStr)

			local attrList = equipData:getAttrListShow()
			local length = #attrList
			local posY = kAttrPosY[length]

			for i = 1, 2 do
				local attrPanel = infoNode:getChildByFullName("desc_" .. i)

				attrPanel:setVisible(false)

				if attrList[i] then
					attrPanel:setVisible(true)

					if posY and posY[i] then
						attrPanel:setPositionY(posY[i])
					end

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

			local skillAttr = equipData:getSkill()

			if skillAttr then
				bgImg = "yinghun_bg_equi01.png"

				local name = skillAttr:getName()
				local level = skillAttr:getLevel()

				skillName:setString(name)

				if level == 0 then
					skillLevel:setString(Strings:get("Hero_EquipUnactive"))
					skillLevel:setColor(cc.c3b(147, 147, 147))
				else
					skillLevel:setColor(cc.c3b(255, 255, 255))

					if equipData:isSkillMaxLevel() then
						skillLevel:setString(Strings:get("Strenghten_Text79"))
					else
						skillLevel:setString(Strings:get("Strenghten_Text78", {
							level = level
						}))
					end
				end

				skillLevel:setPositionX(skillName:getPositionX() + skillName:getContentSize().width + 4)
			else
				bgImg = "yinghun_bg_equi02.png"

				skillName:setString("")
				skillLevel:setString("")
			end
		else
			bgImg = "yinghun_bg_equi02.png"

			local emptyNode = panel:getChildByFullName("EmptyNode")

			if not emptyNode then
				emptyNode = self._emptyNode:clone()

				emptyNode:addTo(panel):posite(0, 0)
				emptyNode:setName("EmptyNode")
			end

			emptyNode:setVisible(true)

			local typeIcon = emptyNode:getChildByFullName("type")

			typeIcon:loadTexture(kEquipTypeToImage[equipType], 1)
		end

		bg:loadTexture(bgImg, 1)

		local hasRed1 = self._heroSystem:hasRedPointByEquipStarUp(self._heroId, equipType)
		local hasRed2 = self._heroSystem:hasRedPointByEquipReplace(self._heroId, equipType)

		redPoint:setVisible(hasRed2)
		redPoint:setLocalZOrder(2)

		local starUpMark = panel:getChildByName("StarUpMark")

		if starUpMark then
			starUpMark:setVisible(hasRed1)
		elseif hasRed1 then
			self:createCanStarUpMark(panel)
		end
	end

	self._goldEnoughByTen = false
	self._canOneKeyStrength = false

	local totalGold = 0
	local hasGold = CurrencySystem:getCurrencyCount(self, CurrencyIdKind.kGold)

	for i = 1, #HeroEquipPowerUpOrder do
		local equipType = HeroEquipPowerUpOrder[i]
		local equip = equips[equipType]

		if equip then
			if not equip:isMaxLevel() and not equip:isStarMaxExp() then
				self._canOneKeyStrength = true
			end

			local needTotalGold = equip:getLimitLevelTotalGold()

			totalGold = totalGold + needTotalGold

			local needGold = equip:getLevelGold()

			if needGold <= hasGold then
				self._goldEnoughByTen = true
			end
		end
	end

	self._strengthNum:setVisible(self._canOneKeyStrength)
	self._strengthIcon:setVisible(self._canOneKeyStrength)
	self._strengthNum:setString(totalGold)
	self._strengthIcon:setPositionX(self._strengthNum:getPositionX() - self._strengthNum:getContentSize().width / 2 - 14)
end

function HeroStrengthEquipMediator:createCanStarUpMark(parent)
	local image = ccui.ImageView:create("zhuangbei_img_ketupo.png", 1)

	image:addTo(parent):posite(280, 114)
	image:setName("StarUpMark")

	local str = cc.Label:createWithTTF(Strings:get("heroshow_UI34"), TTF_FONT_FZYH_M, 18)

	str:setOverflow(cc.LabelOverflow.SHRINK)
	str:setDimensions(image:getContentSize().width * 0.8, 20)
	str:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
	str:addTo(image):posite(38, 23)
end

function HeroStrengthEquipMediator:refreshAllView(hideAnim)
	self:refreshView(hideAnim)
end

function HeroStrengthEquipMediator:refreshEquipInfo()
	if self._equipInfo:isVisible() then
		local equipId = self._heroData:getEquipIdByType(self._equipType)

		self._equipInfoView:refreshEquipInfo({
			heroId = self._heroId,
			equipType = self._equipType,
			equipId = equipId
		})
	end
end

function HeroStrengthEquipMediator:onClickTakeOff()
	if table.nums(self._heroData:getEquipIds()) == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI26")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._equipInfo:setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Click_Takeoff", false)

	local param = {
		heroId = self._heroId
	}

	self._equipSystem:requestOneKeyEquipDemount(param)
end

function HeroStrengthEquipMediator:onClickEquip()
	local equips = self._equipSystem:getOneKeyEquips()[self._heroId] or {}
	local heroEquipIds = self._heroData:getEquipIds()
	local heroEquips = {}

	for i, equipId in pairs(equips) do
		if heroEquipIds[i] ~= equipId then
			table.insert(heroEquips, equipId)
		end
	end

	if #heroEquips <= 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI25")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._equipInfo:setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Click_Wear", false)

	local params = {
		heroId = self._heroId,
		heroEquips = heroEquips
	}

	self._equipSystem:requestOneKeyEquipMounting(params, function()
		local soundId = self:getWearEquipSoundId()

		if soundId and soundId ~= "" then
			if self._soundId then
				AudioEngine:getInstance():stopEffect(self._soundId)
			end

			self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
				self._soundId = nil
			end)
		end
	end)
end

function HeroStrengthEquipMediator:onClickOneKeyStrengthen()
	if not self._canOneKeyStrength then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI82")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._goldEnoughByTen then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010010")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._equipInfo:setVisible(false)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local param = {
		heroId = self._heroId
	}

	self._equipSystem:requestOneKeyIntensify(param)
end

function HeroStrengthEquipMediator:onClickEquipIcon(index)
	local equipType = EquipPositionToType[index]

	if self._heroData:getEquipIdByType(equipType) then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if self._equipInfo:isVisible() and self._equipType == equipType then
			self._equipInfo:setVisible(false)
		else
			self._equipType = equipType

			self._equipInfo:setVisible(true)
			self:refreshEquipInfo()
		end
	else
		self._equipInfo:setVisible(false)

		self._equipType = equipType

		local param = {
			position = self._equipType,
			occupation = self._heroData:getType(),
			heroId = self._heroId
		}
		local equipList = self._equipSystem:getEquipList(EquipsShowType.kReplace, param)

		if #equipList <= 0 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Equip_UI45", {
					name = kEquipTypeToName[self._equipType]
				})
			}))
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end

		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("HeroEquipDressedView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			heroId = self._heroId,
			equipType = equipType
		}))
	end
end

function HeroStrengthEquipMediator:onClickStrengthen()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local equipId = self._heroData:getEquipIdByType(self._equipType)
	local param = {
		equipId = equipId
	}

	self._equipSystem:tryEnter(param)
end

function HeroStrengthEquipMediator:onClickChange()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("HeroEquipDressedView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = self._heroId,
		equipType = self._equipType
	}))
end

function HeroStrengthEquipMediator:onClickEquipLock()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local equipId = self._heroData:getEquipIdByType(self._equipType)

	if equipId then
		local params = {
			viewtype = 1,
			equipId = equipId
		}

		self._equipSystem:requestEquipLock(params)
	end
end

function HeroStrengthEquipMediator:onClickTip()
	local Hero_EquipEnergyTranslate = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_EquipEnergyTranslate", "content")
	local view = self:getInjector():getInstance("ArenaRuleView")
	local event = ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		rule = Hero_EquipEnergyTranslate
	}, nil)

	self:dispatch(event)
end

function HeroStrengthEquipMediator:strengthEquipSucc()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Equip_UI81")
	}))
end

function HeroStrengthEquipMediator:runStartAction()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StrengthenEquip.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 20, false)

	for i = 1, #EquipPositionToType do
		local node = self._equipList[i].equipPanel
		local bg = node:getChildByName("bg")

		bg:stopAllActions()
		bg:setScaleX(0.3)
		bg:setOpacity(0)

		local infoNode = node:getChildByFullName("infoNode")

		infoNode:stopAllActions()
		infoNode:setOpacity(0)

		local emptyNode = node:getChildByFullName("EmptyNode")

		if emptyNode then
			local type = emptyNode:getChildByName("type")

			type:setOpacity(0)
			type:stopAllActions()

			local addImage = emptyNode:getChildByName("addImage")

			addImage:setOpacity(0)
			addImage:stopAllActions()
		end

		local iconNode = infoNode:getChildByName("node")

		iconNode:setOpacity(0)
		iconNode:setScale(1.2)
		iconNode:stopAllActions()

		local name = infoNode:getChildByName("name")
		local redPoint = node:getChildByName("redPoint")

		name:setOpacity(0)
		redPoint:setOpacity(0)
		name:stopAllActions()
		redPoint:stopAllActions()

		local starUpMark = node:getChildByName("StarUpMark")

		if starUpMark then
			starUpMark:setOpacity(0)
			iconNode:stopAllActions()
		end
	end

	self._btnPanel:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "Node1Anim" then
			self:runNodeAction(self._equipList[1].equipPanel)
		end

		if str == "Node2Anim" then
			self:runNodeAction(self._equipList[2].equipPanel)
		end

		if str == "Node3Anim" then
			self:runNodeAction(self._equipList[3].equipPanel)
		end

		if str == "Node4Anim" then
			self:runNodeAction(self._equipList[4].equipPanel)
		end

		if str == "BtnAnim" then
			self._btnPanel:fadeIn({
				time = 0.23333333333333334
			})
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function HeroStrengthEquipMediator:runNodeAction(node)
	local bg = node:getChildByName("bg")
	local fadeIn = cc.FadeIn:create(0.3)
	local scale1 = cc.ScaleTo:create(0.2, 1.1, 1)
	local scale2 = cc.ScaleTo:create(0.1, 1, 1)
	local seq = cc.Sequence:create(scale1, scale2)
	local spawn = cc.Spawn:create(fadeIn, seq)

	bg:runAction(spawn)

	local infoNode = node:getChildByFullName("infoNode")

	infoNode:fadeIn({
		time = 0.2
	})

	local emptyNode = node:getChildByFullName("EmptyNode")

	if emptyNode then
		local type = emptyNode:getChildByName("type")
		local delay = cc.DelayTime:create(0.13333333333333333)
		local fadeIn = cc.FadeIn:create(0.2)
		local seq = cc.Sequence:create(delay, fadeIn)

		type:runAction(seq)

		local addImage = emptyNode:getChildByName("addImage")
		local delay = cc.DelayTime:create(0.13333333333333333)
		local fadeIn = cc.FadeIn:create(0.2)
		local seq = cc.Sequence:create(delay, fadeIn)

		addImage:runAction(seq)
	end

	local iconNode = infoNode:getChildByName("node")
	local delay = cc.DelayTime:create(0.1)
	local fadeIn = cc.FadeIn:create(0.16666666666666666)
	local scale = cc.ScaleTo:create(0.16666666666666666, 1)
	local spawn = cc.Spawn:create(fadeIn, scale)
	local seq = cc.Sequence:create(delay, spawn)

	iconNode:runAction(seq)

	local name = infoNode:getChildByName("name")
	local redPoint = node:getChildByName("redPoint")
	local delay = cc.DelayTime:create(0.13333333333333333)
	local fadeIn = cc.FadeIn:create(0.16666666666666666)
	local seq = cc.Sequence:create(delay, fadeIn)

	name:runAction(seq)

	local delay = cc.DelayTime:create(0.13333333333333333)
	local fadeIn = cc.FadeIn:create(0.16666666666666666)
	local seq = cc.Sequence:create(delay, fadeIn)

	redPoint:runAction(seq)

	local starUpMark = node:getChildByName("StarUpMark")

	if starUpMark then
		local delay = cc.DelayTime:create(0.13333333333333333)
		local fadeIn = cc.FadeIn:create(0.16666666666666666)
		local seq = cc.Sequence:create(delay, fadeIn)

		starUpMark:runAction(seq)
	end
end

function HeroStrengthEquipMediator:getWearEquipSoundId()
	local rarity = self._heroData:getRarity()

	return "Voice_" .. self._heroId .. GameStyle:getHeroRaritySound(rarity)
end
