-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/explore/view/ExploreMapZombieMediator.lua

ExploreMapZombieMediator = class("ExploreMapZombieMediator", DmPopupViewMediator, _M)

ExploreMapZombieMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ExploreMapZombieMediator:has("_exploreSystem", {
	is = "r"
}):injectWith("ExploreSystem")

local maxSkillCount = 3
local kBtnHandlers = {
	["main.bg_node.backBtn"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}
local kAttrType = {
	"ATK",
	"HP",
	"DEF",
	"SPEED"
}

function ExploreMapZombieMediator:initialize()
	super.initialize(self)
end

function ExploreMapZombieMediator:dispose()
	super.dispose(self)
end

function ExploreMapZombieMediator:onRemove()
	super.onRemove(self)
end

function ExploreMapZombieMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._sureBtn = self:bindWidget("main.Node_item.sureBtn", TwoLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickSure, self)
		}
	})
end

function ExploreMapZombieMediator:enterWithData(data)
	self._pointId = data.pointId
	self._pointObj = self._exploreSystem:getMapPointObjById(self._pointId)
	self._itemSelectIndex = 1

	self:initView()
	self:updateView()
end

function ExploreMapZombieMediator:initView()
	self._main = self:getView():getChildByName("main")
	self._Node_roleInfo = self._main:getChildByName("Node_roleInfo")
	self._Node_item = self._main:getChildByName("Node_item")
	self._Text_name = self._Node_roleInfo:getChildByName("Text_name")
	self._Text_des = self._Node_roleInfo:getChildByName("Text_des")
	self._Node_role = self._Node_roleInfo:getChildByName("Node_role")
	self._Node_power = self._Node_roleInfo:getChildByName("Node_power")
	self._attrPanel = self._Node_roleInfo:getChildByName("attrPanel")
	self._Node_lv = self._Node_roleInfo:getChildByName("Node_lv")
	self._Node_skill = self._Node_roleInfo:getChildByName("Node_skill")
	self._Node_mutation = self._Node_roleInfo:getChildByName("Node_mutation")
	self._attrTipNode = self._main:getChildByFullName("attrtipnode")

	self._attrTipNode:setVisible(false)

	self._attrShowWidget = self:autoManageObject(self:getInjector():injectInto(MasterAttrShowTipWidget:new(self._attrTipNode)))
	self._skillTipNode = self._main:getChildByFullName("skillTipNode")

	self._skillTipNode:setVisible(false)
	self._attrPanel:setTouchEnabled(true)
	self._attrPanel:addClickEventListener(function(sender, eventType)
		self:onClickAttribute(sender, eventType)
	end)

	for i = 1, 6 do
		local panel = self._Node_item:getChildByFullName("Node_item.Panel_" .. i)
		local index = i

		panel:addClickEventListener(function()
			self:clickToSelect(index)
		end)

		local quaRectImg = IconFactory:createSprite(GameStyle:getItemQuaRectFile(1, 1))

		quaRectImg:setScale(0.6)
		quaRectImg:addTo(panel, 1):center(panel:getContentSize())
	end

	for i = 1, #kAttrType do
		local node = self._attrPanel:getChildByFullName("des_" .. i)
		local text = node:getChildByFullName("text")
		local name = node:getChildByFullName("name")
		local image = node:getChildByFullName("image")

		GameStyle:setCommonOutlineEffect(text, 142.8)
		GameStyle:setCommonOutlineEffect(name)
		name:setString(getAttrNameByType(kAttrType[i]))
		image:loadTexture(AttrTypeImage[kAttrType[i]], 1)
	end

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(129, 118, 113, 255)
		}
	}

	self._Node_power:getChildByName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
end

function ExploreMapZombieMediator:updateView()
	self:updateRoleInfo()
	self:updateAttrInfo()
	self:updateLvInfo()
	self:updateSkillInfo()
	self:updateSpecialSkillInfo()
	self:updateItemInfo()
end

function ExploreMapZombieMediator:updateRoleInfo()
	local zombieData = self._pointObj:getMechanism()
	local configId = zombieData._configId
	local key = ConfigReader:getDataByNameIdAndKey("MapPoint", self._pointId, "MechanismValue").ZombiesValue
	local data = ConfigReader:getDataByNameIdAndKey("MapMechanismValue", key, "content")
	local config = data[configId]
	local translate = config.translate

	if self._Node_role:getChildByName("hero") then
		self._Node_role:removeChildByName("hero")
	end

	self._Text_name:setString(Strings:get(translate[1]))
	self._Text_des:setString(Strings:get(translate[2]))

	local rolemodelid = ConfigReader:getDataByNameIdAndKey("EnemyHero", configId, "RoleModel")
	local hero = RoleFactory:createHeroAnimation(rolemodelid)

	hero:setName("hero")
	hero:setScale(1)
	hero:addTo(self._Node_role, 1):center(self._Node_role:getContentSize())
	hero:setAnchorPoint(cc.p(0.5, 0))
end

function ExploreMapZombieMediator:updateAttrInfo()
	local zombieData = self._pointObj:getMechanism()
	local configId = zombieData._configId
	local attrDegree = zombieData._attrDegree
	local level = zombieData._level
	local key = ConfigReader:getDataByNameIdAndKey("MapPoint", self._pointId, "MechanismValue").ZombiesValue
	local data = ConfigReader:getDataByNameIdAndKey("MapMechanismValue", key, "content")
	local config = data[configId]
	local atk = config.atk
	local hp = config.hp
	local def = config.def
	local speed = config.speed
	local combat = config.combat
	local text_power = self._Node_power:getChildByName("text")

	text_power:setString(math.floor(combat[level] * attrDegree))

	local text_atk = self._attrPanel:getChildByFullName("des_1.text")
	local text_hp = self._attrPanel:getChildByFullName("des_2.text")
	local text_def = self._attrPanel:getChildByFullName("des_3.text")
	local text_speed = self._attrPanel:getChildByFullName("des_4.text")

	text_atk:setString(math.floor(atk[level] * attrDegree))
	text_hp:setString(math.floor(hp[level] * attrDegree))
	text_def:setString(math.floor(def[level] * attrDegree))
	text_speed:setString(math.floor(speed[level] * attrDegree))

	self._levelAnim = self._levelAnim or level
	self._oldCombat = self._oldCombat or math.floor(combat[level] * attrDegree)

	if level > self._levelAnim then
		local atkNum = math.floor(atk[level] * attrDegree) - math.floor(atk[self._levelAnim] * attrDegree)
		local hpNum = math.floor(hp[level] * attrDegree) - math.floor(hp[self._levelAnim] * attrDegree)
		local defNum = math.floor(def[level] * attrDegree) - math.floor(def[self._levelAnim] * attrDegree)
		local speedNum = math.floor(speed[level] * attrDegree) - math.floor(speed[self._levelAnim] * attrDegree)
		local attData = {}

		if atkNum > 0 then
			attData[#attData + 1] = {
				Strings:get("Hero_SkillAttrName_ATK"),
				"+" .. atkNum
			}
		end

		if defNum > 0 then
			attData[#attData + 1] = {
				Strings:get("Hero_SkillAttrName_DEF"),
				"+" .. defNum
			}
		end

		if hpNum > 0 then
			attData[#attData + 1] = {
				Strings:get("Hero_SkillAttrName_HP"),
				"+" .. hpNum
			}
		end

		if speedNum > 0 then
			attData[#attData + 1] = {
				Strings:get("Hero_SkillAttrName_SPEED"),
				"+" .. speedNum
			}
		end

		if #attData > 0 then
			self:showAddAttrAnim(attData, self._Node_role)
		end

		local combatAdd = math.floor(combat[level] * attrDegree) - self._oldCombat

		self._levelAnim = level
		self._oldCombat = math.floor(combat[level] * attrDegree)

		local effectAnim = self._Node_role:getChildByName("effextAnim")

		if not effectAnim then
			effectAnim = cc.MovieClip:create("zhuangbei_yinglingzhuangbei")

			effectAnim:addTo(self._Node_role, 3):center(self._Node_role:getContentSize()):offset(0, 30)
			effectAnim:setName("effextAnim")
			effectAnim:addCallbackAtFrame(80, function()
				effectAnim:stop()
			end)
		end

		effectAnim:gotoAndPlay(0)

		if combatAdd > 0 then
			local combatAddAnim = cc.MovieClip:create("shuzi_yinglingzhuangbei")

			combatAddAnim:gotoAndPlay(0)
			combatAddAnim:addTo(text_power, 10)
			combatAddAnim:addCallbackAtFrame(30, function()
				combatAddAnim:removeFromParent()
			end)
			combatAddAnim:setPosition(cc.p(50, 10))

			local panel = combatAddAnim:getChildByName("num")
			local num = cc.Label:createWithTTF("+" .. combatAdd, TTF_FONT_FZYH_M, 24)

			num:setAnchorPoint(cc.p(0, 0.5))
			num:addTo(panel)
			num:setPosition(0, 1)
			GameStyle:setGreenCommonEffect(num, true)
		end
	end
end

function ExploreMapZombieMediator:updateLvInfo()
	local zombieData = self._pointObj:getMechanism()
	local level = zombieData._level
	local exp = zombieData._exp
	local key = ConfigReader:getDataByNameIdAndKey("MapPoint", self._pointId, "MechanismValue").ZombiesLevelExp
	local data = ConfigReader:getDataByNameIdAndKey("MapMechanismValue", key, "content")
	local text_lv = self._Node_lv:getChildByName("Text_lv")
	local text_des = self._Node_lv:getChildByName("Text_des")
	local text_des1 = self._Node_lv:getChildByName("Text_des_1")
	local loadingBar = self._Node_lv:getChildByName("LoadingBar")

	text_lv:setString("Lv." .. level)

	if data[level] then
		text_des:setString(exp)
		text_des1:setString("/" .. data[level])
		loadingBar:setPercent(exp / data[level] * 100)
	else
		loadingBar:setPercent(100)
		text_des:setString(Strings:get("EXPLORE_Mechanism_UI4"))
		text_des1:setString("")
	end

	text_des:setPositionX(text_des1:getPositionX() - text_des1:getContentSize().width)
end

function ExploreMapZombieMediator:updateSkillInfo()
	local zombieData = self._pointObj:getMechanism()
	local configId = zombieData._configId
	local config = ConfigReader:getRecordById("EnemyHero", configId)

	self._skillIds = {}

	if config.NormalSkill and config.NormalSkill ~= "" then
		self._skillIds[#self._skillIds + 1] = config.NormalSkill
	end

	if config.ProudSkill and config.ProudSkill ~= "" then
		self._skillIds[#self._skillIds + 1] = config.ProudSkill
	end

	if config.UniqueSkill and config.UniqueSkill ~= "" then
		self._skillIds[#self._skillIds + 1] = config.UniqueSkill
	end

	self:createSkillListPanel()
end

function ExploreMapZombieMediator:createSkillListPanel()
	self._skillNodes = {}

	for i = 1, maxSkillCount do
		local panel = self._Node_skill:getChildByFullName("node_" .. i)

		panel:addTouchEventListener(function(sender, eventType)
			self:onClickSkillIcon(i, eventType)
		end)
		panel:removeAllChildren()

		local skillId = self._skillIds[i]
		local isLock = false
		local newSkillNode = IconFactory:createHeroSkillIcon({
			id = skillId,
			isLock = isLock
		}, {
			hideLevel = true,
			isWidget = true
		})

		newSkillNode:addTo(panel):center(panel:getContentSize())

		newSkillNode.id = skillId

		newSkillNode:setScale(0.68)
		newSkillNode:offset(0, -2)

		self._skillNodes[#self._skillNodes + 1] = newSkillNode
	end
end

function ExploreMapZombieMediator:onClickSkillIcon(index, eventType)
	if eventType == ccui.TouchEventType.began then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._skillTipNode:setVisible(true)
		self:refreshInnerSkillPanel(index)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self._skillTipNode:setVisible(false)
	end
end

function ExploreMapZombieMediator:refreshInnerSkillPanel(index)
	local text_name = self._skillTipNode:getChildByFullName("image.textName")
	local text_Des = self._skillTipNode:getChildByFullName("Text_des")
	local skillId = self._skillIds[index]
	local skillName = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")
	local skillDesc = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc")

	text_Des:setString((skillDesc and skillDesc ~= "" or nil) and ConfigReader:getEffectDesc("Skill", skillDesc, skillId, 1))
	text_name:setString(Strings:get(skillName))
end

function ExploreMapZombieMediator:updateItemInfo()
	local zombieData = self._pointObj:getMechanism()
	local key = ConfigReader:getDataByNameIdAndKey("MapPoint", self._pointId, "MechanismValue").ZombiesIteam
	local data = ConfigReader:getDataByNameIdAndKey("MapMechanismValue", key, "content")
	local itemData = {}

	for k, v in pairs(data) do
		local itemId = k
		local count = self._exploreSystem:getCountByCurrencyType(itemId)

		if count > 0 then
			itemData[#itemData + 1] = v
			itemData[#itemData].itemId = itemId
			itemData[#itemData].count = count
		end
	end

	local text_des = self._Node_item:getChildByFullName("Text_des")
	local text_name = self._Node_item:getChildByFullName("Text_name")
	local image_Head = self._Node_item:getChildByFullName("Image_head")
	local node_item = self._Node_item:getChildByFullName("Node_item")
	local image_select = node_item:getChildByFullName("Image_select")

	if #itemData > 0 then
		image_Head:setVisible(true)
		image_select:setVisible(true)
		self._sureBtn._button:setEnabled(true)
		self._sureBtn._button:setGray(false)

		self._itemData = itemData

		if self._itemSelectIndex > #self._itemData then
			self._itemSelectIndex = #self._itemData
		end

		for i = 1, 6 do
			local panel = node_item:getChildByFullName("Panel_" .. i)

			panel:removeAllChildren()

			if itemData[i] then
				local icon = IconFactory:createIcon({
					id = itemData[i].itemId
				})
				local scale = 0.6

				icon:setScale(scale)

				if icon.getAmountLabel then
					local label = icon:getAmountLabel()

					label:setScale(0.6 / scale)
					label:enableOutline(cc.c4b(0, 0, 0, 255), 2)
				end

				icon:addTo(panel):center(panel:getContentSize())

				local numText = cc.Label:createWithTTF(itemData[i].count, TTF_FONT_FZYH_R, 16)

				numText:setAnchorPoint(cc.p(0.5, 0.5))
				numText:enableOutline(cc.c4b(35, 15, 5, 255), 1)
				numText:addTo(panel):center(panel:getContentSize()):offset(16, -18)
			else
				local quaRectImg = IconFactory:createSprite(GameStyle:getItemQuaRectFile(1, 1))

				quaRectImg:setScale(0.6)
				quaRectImg:addTo(panel, 1):center(panel:getContentSize())
			end
		end

		self:refreshItemSelect()
	else
		self._sureBtn._button:setEnabled(false)
		self._sureBtn._button:setGray(true)
		image_Head:setVisible(false)
		image_select:setVisible(false)
		text_des:setString("")
		text_name:setString("")

		for i = 1, 6 do
			local panel = node_item:getChildByFullName("Panel_" .. i)

			panel:removeAllChildren()

			local quaRectImg = IconFactory:createSprite(GameStyle:getItemQuaRectFile(1, 1))

			quaRectImg:setScale(0.6)
			quaRectImg:addTo(panel, 1):center(panel:getContentSize())
		end
	end
end

function ExploreMapZombieMediator:refreshItemSelect()
	local node_item = self._Node_item:getChildByFullName("Node_item")
	local panel = node_item:getChildByFullName("Panel_" .. self._itemSelectIndex)
	local image_Head = self._Node_item:getChildByFullName("Image_head")
	local text_des = self._Node_item:getChildByFullName("Text_des")
	local text_name = self._Node_item:getChildByFullName("Text_name")
	local image_select = node_item:getChildByFullName("Image_select")

	image_Head:setPositionX(panel:getPositionX())
	image_select:setPositionX(panel:getPositionX())

	local itemId = self._itemData[self._itemSelectIndex].itemId
	local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

	text_name:setString(Strings:get(itemConfig.Name))
	text_des:setString(Strings:get(itemConfig.FunctionDesc))
	text_des:setPositionX(text_name:getPositionX() + text_name:getContentSize().width + 5)
end

function ExploreMapZombieMediator:clickToSelect(index)
	if not self._itemData[index] then
		return
	end

	if self._itemSelectIndex == index then
		return
	end

	self._itemSelectIndex = index

	self:refreshItemSelect()
end

function ExploreMapZombieMediator:updateSpecialSkillInfo()
	local zombieData = self._pointObj:getMechanism()
	local zombieSkills = zombieData._zombieSkills

	for i = 1, 5 do
		local nodeName = "Node_" .. i
		local text = self._Node_mutation:getChildByFullName(nodeName .. ".Text")

		if zombieSkills[tostring(i - 1)] then
			local data = zombieSkills[tostring(i - 1)]
			local effectId = data.effectId
			local effectType = data.effectType
			local config = ConfigReader:getRecordById(effectType, effectId)
			local effectDesc = config.EffectDesc
			local des = ConfigReader:getEffectDesc(effectType, effectDesc, effectId, 1)

			text:setString(des)
		else
			text:setString(Strings:get("EXPLORE_Mechanism_UI5"))
		end
	end
end

function ExploreMapZombieMediator:onClickAttribute(sender, eventType)
	if self._attrTipNode:isVisible() then
		self._attrTipNode:setVisible(false)
	else
		self._attrTipNode:setVisible(true)
		self:refreshInnerAttrPanel()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function ExploreMapZombieMediator:refreshInnerAttrPanel()
	local zombieData = self._pointObj:getMechanism()

	self._attrShowWidget:showAttribute(zombieData, Strings:get("HEROS_UI22"))
end

function ExploreMapZombieMediator:onClickClose(sender, eventType)
	self:close()
end

function ExploreMapZombieMediator:onClickSure(sender, eventType)
	local zombieData = self._pointObj:getMechanism()
	local itemId = self._itemData[self._itemSelectIndex].itemId
	local type = self._itemData[self._itemSelectIndex].type
	local value = self._itemData[self._itemSelectIndex].value

	if type == "SKILL" then
		local zombieSkills = zombieData._zombieSkills
		local keyNum = ConfigReader:getDataByNameIdAndKey("MapPoint", self._pointId, "MechanismValue").ZombiesSkillNum
		local maxNum = ConfigReader:getDataByNameIdAndKey("MapMechanismValue", keyNum, "content")
		local num = 0

		for k, v in pairs(zombieSkills) do
			num = num + 1
		end

		if maxNum <= num then
			self:dispatch(ShowTipEvent({
				duration = 0.5,
				tip = Strings:get("EXPLORE_Mechanism_Tips3")
			}))

			return
		end
	elseif type == "EXP" then
		local level = zombieData._level
		local key = ConfigReader:getDataByNameIdAndKey("MapPoint", self._pointId, "MechanismValue").ZombiesLevelExp
		local data = ConfigReader:getDataByNameIdAndKey("MapMechanismValue", key, "content")

		if data[level] == nil then
			self:dispatch(ShowTipEvent({
				duration = 0.5,
				tip = Strings:get("EXPLORE_Mechanism_Tips1")
			}))

			return
		end
	elseif type == "CHANGE" then
		local configId = zombieData._configId

		if configId == value then
			self:dispatch(ShowTipEvent({
				duration = 0.5,
				tip = Strings:get("EXPLORE_Mechanism_Tips2")
			}))

			return
		end
	end

	local function refresh()
		self:updateView()
	end

	self._exploreSystem:useZombieItem(itemId, refresh)
end

function ExploreMapZombieMediator:showAddAttrAnim(attData, baseNode)
	if baseNode:getChildByFullName("attAnimNode") then
		baseNode:removeChildByName("attAnimNode")
	end

	local attAnimNode = cc.Node:create()

	attAnimNode:setName("attAnimNode")
	attAnimNode:addTo(baseNode, 4):center(baseNode:getContentSize()):offset(0, 200)

	local addAnim = cc.MovieClip:create("shuzib_yinglingzhuangbei")

	addAnim:addTo(attAnimNode)
	addAnim:addCallbackAtFrame(42, function()
		addAnim:removeFromParent()
	end)
	addAnim:setPosition(cc.p(0, 0))
	addAnim:gotoAndPlay(0)

	for i = 1, 3 do
		if attData[i] then
			local panel = addAnim:getChildByName("num_" .. i)
			local num = cc.Label:createWithTTF(attData[i][2], TTF_FONT_FZYH_M, 24)

			num:setAnchorPoint(cc.p(0, 0.5))
			num:addTo(panel)
			GameStyle:setGreenCommonEffect(num, true)

			local str = cc.Label:createWithTTF(attData[i][1], CUSTOM_TTF_FONT_1, 24)

			str:setAnchorPoint(cc.p(1, 0.5))
			str:addTo(panel)
			GameStyle:setGreenCommonEffect(str, true)

			local posX = (str:getContentSize().width + num:getContentSize().width) / 2 - num:getContentSize().width

			str:setPosition(posX, 2)
			num:setPosition(posX, 0)
		end
	end
end
