-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/SkillShowTipMediator.lua

SkillShowTipMediator = class("SkillShowTipMediator", DmPopupViewMediator, _M)

SkillShowTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	leftbtn = "onClickLeft",
	rightbtn = "onClickRight"
}
local EnoughColor = {
	cc.c4b(255, 255, 255, 255),
	cc.c4b(255, 76, 76, 255),
	(cc.c4b(229, 229, 229, 229))
}

function SkillShowTipMediator:initialize()
	super.initialize(self)
end

function SkillShowTipMediator:dispose()
	super.dispose(self)
end

function SkillShowTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function SkillShowTipMediator:mapEventListeners()
	return
end

function SkillShowTipMediator:onRemove()
	super.onRemove(self)
end

function SkillShowTipMediator:enterWithData(data)
	self._heroSystem = self._developSystem:getHeroSystem()

	self:createData(data)
	self:refreshData()
	self:setupView()
end

function SkillShowTipMediator:createData(data)
	self._heroId = data.heroId
	self._skillList = data.skillList or {}

	if data.index then
		self._curIndex = data.index or 1
	end
end

function SkillShowTipMediator:setupView()
	self._rootLayout = self:getView():getChildByFullName("main")

	local btnClose = self._rootLayout:getChildByFullName("closebtn")

	btnClose:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:close()
		end
	end)

	self._skillNameBackImg = self._rootLayout:getChildByFullName("Image_33_0")
	self._skillName = self._rootLayout:getChildByFullName("skillname")
	self._heroName = self._rootLayout:getChildByFullName("heroname")
	self._skillDesc = self._rootLayout:getChildByFullName("skilldesc")
	self._iconLayout = self._rootLayout:getChildByFullName("iconlayout")
	self._levelLabel = self._rootLayout:getChildByFullName("levellabel")
	self._levelNumLabel = self._rootLayout:getChildByFullName("levellabel_num")
	self._typeLabel = self._rootLayout:getChildByFullName("typelabel")
	self._listView = self._rootLayout:getChildByFullName("listview")

	self._listView:setLocalZOrder(999)
	self._listView:setScrollBarEnabled(false)

	self._leftBtn = self:getView():getChildByFullName("leftbtn")
	self._rightBtn = self:getView():getChildByFullName("rightbtn")

	self:refreshSkillInfo()
	self:refreshLeftAndRightVisible()
end

function SkillShowTipMediator:refreshLeftAndRightVisible()
	self._leftBtn:setVisible(self._curIndex > 1)
	self._rightBtn:setVisible(self._curIndex < #self._skillList)
end

function SkillShowTipMediator:onClickLeft(sender, eventType, oppoRecord)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:refreshByTab(-1)
	end
end

function SkillShowTipMediator:onClickRight(sender, eventType, oppoRecord)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:refreshByTab(1)
	end
end

function SkillShowTipMediator:refreshByTab(factor)
	self._curIndex = self._curIndex + 1 * factor

	if self._curIndex < 1 then
		self._curIndex = 1
	end

	if self._curIndex > #self._skillList then
		self._curIndex = #self._skillList
	end

	self:refreshData()
	self:refreshLeftAndRightVisible()
	self:refreshSkillInfo()
end

function SkillShowTipMediator:refreshSkillInfo()
	self:refreshBaseSkillNodes()
	self:refreshSkillDesc()
end

function SkillShowTipMediator:refreshData()
	self._skill = self._skillList[self._curIndex]
	self._skillId = self._skill:getSkillId()
	self._skillPro = self._skill:getSkillPro()
end

function SkillShowTipMediator:refreshBaseSkillNodes()
	local isLock = self._skill:getLock()
	local skillLevel = self._skill:getLevel()
	local skillType = self._skill:getType()
	local skillName = self._skill:getName()

	if string.len(skillName) > 27 then
		skillName = string.sub(skillName, 1, 27)
	end

	self._skillName:setString(skillName)
	self._iconLayout:removeAllChildren()

	local skillIcon = IconFactory:createHeroSkillIcon({
		levelHide = true,
		id = self._skillId,
		isLock = isLock
	})

	skillIcon:addTo(self._iconLayout):center(self._iconLayout:getContentSize())
	self._levelLabel:setString(Strings:get("heroshow_UI9"))
	self._levelNumLabel:setString(tostring(skillLevel))
	self._typeLabel:setString(tostring(self._heroSystem:getSkillTypeName(skillType)))

	local ownerHero = self._heroSystem:hasHero(self._heroId)

	self._typeLabel:setVisible(ownerHero)

	if isLock then
		self._typeLabel:setTextColor(cc.c3b(193, 193, 193))

		local skillProId = self._skill:getSkillProId()
		local unLockStar = self._heroSystem:getUnLockSkillStar(self._heroId, skillProId)

		self._typeLabel:setString(Strings:get("Digimon_UI10", {
			star = unLockStar or 5
		}))
	else
		self._typeLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))
	end
end

function SkillShowTipMediator:refreshSkillDesc()
	self._listView:removeAllItems()

	local newPanel = self:createDescPanel(self._skill:getDesc(), cc.c3b(208, 255, 246), 20)

	self._listView:pushBackCustomItem(newPanel)

	local skillProto = PrototypeFactory:getInstance():getSkillPrototype(self._skill:getSkillProId())

	if not skillProto then
		return
	end

	local attrDescs = skillProto:getAttrDescs(self._skill:getLevel()) or {}

	for i = 1, #attrDescs do
		local newPanel = self:createDescPanel(attrDescs[i], cc.c3b(255, 252, 0), 10)

		self._listView:pushBackCustomItem(newPanel)
	end

	local battleDescs = skillProto:getBattleDescs(self._skill:getLevel()) or {}

	for i = 1, #battleDescs do
		local newPanel = self:createDescPanel(battleDescs[i], cc.c3b(255, 252, 0), 10)

		self._listView:pushBackCustomItem(newPanel)
	end
end

local labelWidth = 350
local listWidth = 375

function SkillShowTipMediator:createDescPanel(title, colorNum, otherHeight, hasPoint, isSpecial)
	local otherHeight = otherHeight or 4
	local layout = ccui.Layout:create()
	local label = cc.Label:createWithTTF("", CUSTOM_TTF_FONT_1, 20)

	label:enableOutline(cc.c4b(26, 8, 1, 255), 1)

	if colorNum then
		label:setTextColor(colorNum)
	end

	label:setAnchorPoint(cc.p(0.5, 0.5))
	label:setDimensions(labelWidth - 14, 0)
	label:setString(tostring(title))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(listWidth, height + otherHeight))
	label:addTo(layout):center(layout:getContentSize())

	return layout
end
