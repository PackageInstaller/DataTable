-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerGetHeroBuffMediator.lua

TowerGetHeroBuffMediator = class("TowerGetHeroBuffMediator", DmPopupViewMediator, _M)

TowerGetHeroBuffMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerGetHeroBuffMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local kBtnHandlers = {}
local kOffset = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	0,
	0,
	-10,
	-20,
	-20
}

function TowerGetHeroBuffMediator:initialize()
	super.initialize(self)
end

function TowerGetHeroBuffMediator:dispose()
	super.dispose(self)
end

function TowerGetHeroBuffMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._heroSystem = self._developSystem:getHeroSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
end

function TowerGetHeroBuffMediator:enterWithData(data)
	self._data = data

	local roleId = self._data.heroId

	self._role = self._heroSystem:getHeroById(roleId)

	self:initView()
end

function TowerGetHeroBuffMediator:initView()
	local view = self:getView()

	self._main = view:getChildByFullName("content")
	self._buffPanel = self._main:getChildByFullName("buffPanel")
	self._infoNode = self._main:getChildByFullName("infoNode")

	local img = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = self._role:getModel()
	})

	img:addTo(self._main:getChildByFullName("roleNode"))
	img:offset(80, 100):setScale(0.8)

	local nameString = self._role:getName()
	local nameNode = self:getView():getChildByFullName("content.nameNode.heroName")

	nameNode:setString(nameString)

	local occupation = self._main:getChildByFullName("nameNode.occupation")
	local costNode = self._main:getChildByFullName("nameNode.costNode")
	local rarityAnim = IconFactory:getHeroRarityAnim(self._role:getRarity())

	rarityAnim:addTo(self._main:getChildByFullName("rarityNode")):posite(kOffset[self._role:getRarity()], 5)

	local cost = costNode:getChildByFullName("cost")

	cost:setString(self._role:getCost())

	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._role:getType())

	occupation:loadTexture(occupationImg)
	self:initInfoNode()
end

function TowerGetHeroBuffMediator:initInfoNode()
	local combat = self._role:getCombat()
	local combatLabel = self._infoNode:getChildByFullName("combatNode.combat")

	combatLabel:setString(combat)

	local nameLabel = self._buffPanel:getChildByFullName("name")

	nameLabel:setString("buff名字")

	local iconNode = self._buffPanel:getChildByFullName("icon")
	local icon = IconFactory:createIcon({
		id = "IR_Gold"
	})

	icon:addTo(iconNode):setScale(0.7)

	local listView = self._buffPanel:getChildByFullName("listView")

	listView:setScrollBarEnabled(false)
	listView:removeAllItems()

	local strWidth = listView:getContentSize().width
	local layout = ccui.Layout:create()
	local label = ccui.RichText:createWithXML("这是一个buff的描述", {})

	label:renderContent(strWidth, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(strWidth, height))
	label:addTo(layout)
	label:setPosition(cc.p(0, height))
	listView:pushBackCustomItem(layout)
end
