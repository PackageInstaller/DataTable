-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipStrengthenMediator.lua

EquipStrengthenMediator = class("EquipStrengthenMediator", DmAreaViewMediator, _M)

EquipStrengthenMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local HeroEquipSkillLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipSkillLevel", "content")
local kBtnHandlers = {}

function EquipStrengthenMediator:initialize()
	super.initialize(self)
end

function EquipStrengthenMediator:dispose()
	super.dispose(self)
end

function EquipStrengthenMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function EquipStrengthenMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_LEVELUP_SUCC, self, self.onStrengthenSuccCallback)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._strengthenSucc = self:getView():getChildByName("strengthenSucc")

	self._strengthenSucc:setVisible(false)

	self._main = self:getView():getChildByName("main")
	self._nodeDesc = self._main:getChildByFullName("nodeDesc")
	self._nodeAttr = self._main:getChildByName("nodeAttr")
	self._nodeSkill = self._main:getChildByName("nodeSkill")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		self._SkillImage = self._nodeSkill:getChildByName("Image_125")

		self._SkillImage:setContentSize(cc.size(643, 120))
	end

	self._itemPanel = self._main:getChildByName("itemPanel")
	self._levelLimit = self._main:getChildByName("levelLimit")

	self._levelLimit:setVisible(false)

	self._levelMaxPanel = self._main:getChildByName("levelMax")

	self._levelMaxPanel:setVisible(false)

	self._strengthenBtn = self._itemPanel:getChildByName("strengthenBtn")
	self._strengthenTenBtn = self._itemPanel:getChildByName("strengthenTenBtn")
	self._strengthenWidget = self:bindWidget("main.itemPanel.strengthenBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthen, self)
		},
		btnSize = {
			width = 222,
			height = 108
		}
	})
	self._strengthenTenWidget = self:bindWidget("main.itemPanel.strengthenTenBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthenTen, self)
		},
		btnSize = {
			width = 222,
			height = 108
		}
	})

	local animNode1 = self._nodeAttr:getChildByFullName("animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -3)
	end

	self._bgAnim1 = animNode1:getChildByFullName("BgAnim")

	local animNode1 = self._nodeSkill:getChildByFullName("animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -3)
	end

	self._bgAnim2 = animNode1:getChildByFullName("BgAnim")

	local goldCost = self._itemPanel:getChildByFullName("goldCost")
	local panel = goldCost:getChildByFullName("costBg")
	local addImg = panel:getChildByFullName("addImg")

	addImg:getChildByFullName("touchPanel"):addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kGold)
	end)

	local desc1 = self._nodeAttr:getChildByFullName("desc_1")
	local desc2 = self._nodeAttr:getChildByFullName("desc_2")

	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("name"), 219.29999999999998)
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("name"), 219.29999999999998)
	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("text"), 142.8)
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("text"), 142.8)
	GameStyle:setCostNodeEffect(self._itemPanel:getChildByFullName("goldCost"))
end

function EquipStrengthenMediator:setupView(data)
	self:initData(data)
end

function EquipStrengthenMediator:initData(data)
	self._addExp = 0
	self._oldSkillLevel = 0
	self._equipId = data.equipId
	self._mediator = data.mediator
	self._equipData = self._equipSystem:getEquipById(self._equipId)
	self._oldLevel = self._equipData:getLevel()
	self._preLevel = self._oldLevel + 1
end

function EquipStrengthenMediator:refreshData()
	self._equipData = self._equipSystem:getEquipById(self._equipId)
	self._preLevel = self._equipData:getLevel() + 1
end

function EquipStrengthenMediator:refreshView()
	self:refreshData()
	self:refreshEquipBaseInfo()
	self:refreshEquipInfo()
end

function EquipStrengthenMediator:refreshEquipByClick()
	self:refreshData()
	self:refreshEquipInfo()
end

function EquipStrengthenMediator:refreshEquipBaseInfo()
	local name = self._equipData:getName()
	local rarity = self._equipData:getRarity()
	local level = self._equipData:getLevel()
	local star = self._equipData:getStar()
	local node = self._nodeDesc:getChildByFullName("node")

	node:removeAllChildren()

	local param = {
		id = self._equipData:getEquipId(),
		level = level,
		star = star,
		rarity = rarity
	}
	local equipIcon = IconFactory:createEquipIcon(param)

	equipIcon:addTo(node):center(node:getContentSize())
	equipIcon:setScale(0.84)

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:setString(name)
end

function EquipStrengthenMediator:refreshEquipInfo()
	self:refreshItems()
	self:refreshExp()
	self:refreshAttr()
	self:refreshSkill()
end

function EquipStrengthenMediator:refreshExp()
	local level = self._equipData:getLevel()
	local levelMax = self._equipData:getMaxLevel()
	local previewNode = self._nodeDesc:getChildByFullName("previewNode")
	local levelLabel = self._nodeDesc:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = level .. "/" .. levelMax
	}))

	if self._equipData:isMaxLevel() or self._equipData:isStarMaxExp() then
		previewNode:setVisible(false)
	else
		previewNode:setVisible(true)

		local levelLabel = previewNode:getChildByFullName("level")

		levelLabel:setString(Strings:get("Strenghten_Text78", {
			level = self._preLevel .. "/" .. levelMax
		}))
	end
end

function EquipStrengthenMediator:refreshAttr()
	local attrList = self._equipData:getAttrListShow()
	local attrPreMap = self._equipData:getAttrPreListByLevel(self._preLevel)

	for i = 1, 2 do
		local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

		attrPanel:setVisible(false)

		if attrList[i] then
			attrPanel:setVisible(true)

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

			local extendText = attrPanel:getChildByFullName("extendText")

			if attrPreMap[attrType] then
				local preAttrNum = attrPreMap[attrType].attrNum
				local addAttrNum = preAttrNum - attrNum

				if addAttrNum > 0 then
					extendText:setString("+" .. addAttrNum)

					if AttributeCategory:getAttNameAttend(attrType) ~= "" then
						extendText:setString("+" .. addAttrNum * 100 .. "%")
					end
				end
			else
				extendText:setString("")
			end
		end
	end
end

function EquipStrengthenMediator:refreshSkill()
	local skill = self._equipData:getSkill()

	if skill then
		self._nodeSkill:setVisible(true)

		local skillName = self._nodeSkill:getChildByFullName("name")
		local skillNameBg = self._nodeSkill:getChildByFullName("nameBg")
		local skillLevel = self._nodeSkill:getChildByFullName("level")
		local skillDesc = self._nodeSkill:getChildByFullName("desc")

		skillDesc:removeAllChildren()

		local style = {
			fontSize = 20
		}
		local name = skill:getName()
		local level = skill:getLevel()
		local desc = skill:getSkillDesc(style)

		skillName:setString(name)
		skillLevel:setString(Strings:get("Strenghten_Text78", {
			level = level
		}))
		skillNameBg:setContentSize(cc.size(skillName:getContentSize().width + 25, 50))

		local canSkillUp = self._equipData:canSkillUp()
		local skillTip = self._nodeSkill:getChildByFullName("skillTip")
		local levelTip = skillTip:getChildByFullName("levelTip")
		local text = skillTip:getChildByFullName("text")

		skillTip:setString(Strings:get("Equip_UI36"))
		levelTip:setVisible(not self._equipData:isSkillMaxLevel())
		text:setVisible(not self._equipData:isSkillMaxLevel())

		if self._equipData:isSkillMaxLevel() then
			skillTip:setString(Strings:get("Strenghten_Text78", {
				level = "Max"
			}))
		else
			desc = skill:getSkillDesc(style, level + 1)

			skillTip:setString(Strings:get("Equip_UI47"))

			local equipLevel = self._equipData:getLevel()
			local upLevel = equipLevel
			local skillUpLV = HeroEquipSkillLevel
			local URUPSkillLV = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", self._equipData:getEquipId(), "URUPSkillLV")

			if URUPSkillLV then
				skillUpLV = URUPSkillLV
			end

			for i = 1, #skillUpLV do
				upLevel = math.max(upLevel, skillUpLV[i])

				if upLevel ~= equipLevel then
					break
				end
			end

			levelTip:setString(Strings:get("Strenghten_Text78", {
				level = upLevel
			}))

			if canSkillUp then
				text:setString(Strings:get("Equip_UI49"))
			else
				text:setString(Strings:get("Equip_UI48"))
			end

			local tipWidth = skillTip:getContentSize().width

			levelTip:setPositionX(tipWidth + 2)
			text:setPositionX(tipWidth + levelTip:getContentSize().width + 4)

			local color = level == 0 and cc.c3b(195, 195, 195) or cc.c3b(255, 255, 255)

			skillTip:setColor(color)
			levelTip:setColor(color)
			text:setColor(color)
		end

		if level == 0 then
			skillLevel:setVisible(false)
			skillTip:setPositionX(skillNameBg:getPositionX() + skillNameBg:getContentSize().width + 10)
		else
			skillLevel:setPositionX(skillNameBg:getPositionX() + skillNameBg:getContentSize().width + 10)
			skillTip:setPositionX(skillLevel:getPositionX() + skillLevel:getContentSize().width + 10)
		end

		skillDesc:setString("")

		local width = skillDesc:getContentSize().width
		local height = skillDesc:getContentSize().height
		local label = ccui.RichText:createWithXML(desc, {})

		label:renderContent(width, 0)
		label:setAnchorPoint(cc.p(0, 1))
		label:setPosition(cc.p(0, height))
		label:addTo(skillDesc)

		local posY = label:getContentSize().height > 30 and 58 or 51

		skillDesc:setPositionY(posY)
	else
		self._nodeSkill:setVisible(false)
	end
end

function EquipStrengthenMediator:refreshItems()
	self._addExp = 0

	if self._equipData:isMaxLevel() then
		self._levelMaxPanel:setVisible(true)
		self._itemPanel:setVisible(false)

		return
	end

	local noUp = not self._equipData:isMaxLevel() and self._equipData:isStarMaxExp()

	self._levelLimit:setVisible(noUp)
	self._strengthenWidget:getButton():setTouchEnabled(not noUp)
	self._strengthenTenWidget:getButton():setTouchEnabled(not noUp)
	self._strengthenWidget:getView():setGray(noUp)
	self._strengthenTenWidget:getView():setGray(noUp)
	self._levelMaxPanel:setVisible(false)
	self._itemPanel:setVisible(true)

	local goldCost = self._itemPanel:getChildByFullName("goldCost")
	local ownCount = CurrencySystem:getCurrencyCount(self, CurrencyIdKind.kGold)
	local needCount = self._equipData:getLevelGold()

	self._goldEnough = needCount <= ownCount

	local panel = goldCost:getChildByFullName("costBg")
	local iconpanel = panel:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local icon = IconFactory:createPic({
		scaleRatio = 0.7,
		id = CurrencyIdKind.kGold
	}, {
		largeIcon = true
	})

	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local enoughImg = panel:getChildByFullName("bg.enoughImg")
	local cost = panel:getChildByFullName("cost")

	cost:setVisible(true)
	cost:setString(needCount)

	local colorNum1 = self._goldEnough and 1 or 7

	cost:setTextColor(GameStyle:getColor(colorNum1))
	enoughImg:setVisible(self._goldEnough)

	local addImg = panel:getChildByFullName("addImg")

	addImg:setVisible(not self._goldEnough)
	icon:setGray(not self._goldEnough)
end

function EquipStrengthenMediator:onClickStrengthen(sender, eventType)
	local equipData = self._equipData

	if equipData:isMaxLevel() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI61")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end

	if equipData:isStarMaxExp() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI44")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._goldEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010010")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local skill = equipData:getSkill()

	if skill then
		self._oldSkillLevel = skill:getLevel()
	end

	local param = {
		equipIntensifyId = self._equipId
	}

	self._equipSystem:requestEquipIntensify(param)
end

function EquipStrengthenMediator:onClickStrengthenTen(sender, eventType)
	local equipData = self._equipData

	if equipData:isMaxLevel() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI61")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end

	if equipData:isStarMaxExp() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI44")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._goldEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010010")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local skill = equipData:getSkill()

	if skill then
		self._oldSkillLevel = skill:getLevel()
	end

	local param = {
		equipIntensifyId = self._equipId
	}

	self._equipSystem:requestEquipIntensifyTen(param)
end

function EquipStrengthenMediator:onStrengthenSuccCallback(event)
	local level = self._equipData:getLevel()
	local skill = self._equipData:getSkill()
	local showUpAnim = false

	for i = 1, #HeroEquipSkillLevel do
		if self._oldLevel < HeroEquipSkillLevel[i] and level >= HeroEquipSkillLevel[i] then
			showUpAnim = true

			break
		end
	end

	self._oldLevel = level

	if showUpAnim and skill then
		local view = self:getInjector():getInstance("EquipSkillUpView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			equipId = self._equipId,
			oldSkillLevel = self._oldSkillLevel
		}))
	else
		AudioEngine:getInstance():playRoleEffect("Se_Alert_Equip_Powerup", false)
		self._strengthenSucc:setVisible(true)
		performWithDelay(self:getView(), function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self._strengthenSucc:setVisible(false)
		end, 1)
	end
end

function EquipStrengthenMediator:runStartAction()
	self:showInfoAni()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/EquipStrengthen.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 51, false)
	action:setTimeSpeed(2)

	local costNode1 = self._itemPanel:getChildByFullName("goldCost")

	costNode1:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "CostAnim1" then
			costNode1:setOpacity(255)
			GameStyle:runCostAnim(costNode1)
		end

		if str == "EndAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function EquipStrengthenMediator:showInfoAni()
	self._bgAnim1:gotoAndPlay(1)
	self._bgAnim2:gotoAndPlay(1)
	self._strengthenBtn:stopAllActions()
	self._strengthenBtn:setScale(1)
	self._strengthenBtn:setOpacity(255)
	self._strengthenTenBtn:stopAllActions()
	self._strengthenTenBtn:setScale(1)
	self._strengthenTenBtn:setOpacity(255)
	self._levelLimit:stopAllActions()
	self._levelLimit:setScale(1)
	self._levelLimit:setOpacity(255)

	local node = self._nodeDesc:getChildByFullName("node")

	node:setScale(1)
	node:setOpacity(255)
	node:stopAllActions()
	self._equipSystem:runIconShowAction(node, 1)
	self._equipSystem:runIconShowAction(self._strengthenBtn, 4)
	self._equipSystem:runIconShowAction(self._strengthenTenBtn, 5)
	self._equipSystem:runIconShowAction(self._levelLimit, 5)

	local pancel1 = self._nodeAttr:getChildByFullName("Image_125")

	pancel1:setOpacity(0)
	pancel1:setScaleX(0.4)
	pancel1:runAction(cc.FadeIn:create(0.3))
	pancel1:runAction(cc.Sequence:create({
		cc.ScaleTo:create(0.2, 1.05, 1),
		cc.ScaleTo:create(0.1, 1, 1)
	}))

	local pancel1 = self._nodeSkill:getChildByFullName("Image_125")

	pancel1:setOpacity(0)
	pancel1:setScaleX(0.4)
	pancel1:runAction(cc.FadeIn:create(0.3))
	pancel1:runAction(cc.Sequence:create({
		cc.ScaleTo:create(0.2, 1.05, 1),
		cc.ScaleTo:create(0.1, 1, 1)
	}))

	for i = 1, 2 do
		local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

		if attrPanel:isVisible() then
			attrPanel:setOpacity(0)
			attrPanel:runAction(cc.Sequence:create({
				cc.DelayTime:create(0.3),
				cc.FadeIn:create(0.15)
			}))

			local attrText = attrPanel:getChildByFullName("text")

			attrText:setOpacity(0)
			attrText:runAction(cc.Sequence:create({
				cc.DelayTime:create(0.4),
				cc.FadeIn:create(0.15)
			}))
		end
	end
end
