-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerBuffMediator.lua

TowerBuffMediator = class("TowerBuffMediator", DmPopupViewMediator, _M)

TowerBuffMediator:has("_towerSystem", {
	is = "rw"
}):injectWith("TowerSystem")

local kBtnHandlers = {}

function TowerBuffMediator:initialize()
	super.initialize(self)
end

function TowerBuffMediator:dispose()
	super.dispose(self)
end

function TowerBuffMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Tower_1_UI_7"),
		title1 = Strings:get("Tower_1_UI_7"),
		bgSize = {
			width = 837,
			height = 508
		}
	})
end

function TowerBuffMediator:enterWithData()
	local data = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())

	self._buffs = data:getGotBuffs()

	self:initContent()
end

function TowerBuffMediator:initContent()
	self._emptyTip = self:getView():getChildByFullName("main.emptyTip")
	self._listView = self:getView():getChildByFullName("main.listview")
	self._contentPanel = self:getView():getChildByFullName("main.content_panel")

	self._contentPanel:setVisible(false)
	self._listView:setScrollBarEnabled(false)

	self._width = self._listView:getContentSize().width

	local height = 0
	local n = #self._buffs

	for i = 1, n do
		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		panel:setPositionY(height)
		self._listView:pushBackCustomItem(panel)
		self:addSkill(panel, self._buffs[i])
	end

	self._emptyTip:setVisible(n == 0)
end

function TowerBuffMediator:addSkill(panel, skillId)
	local imageIcon = panel:getChildByFullName("image_icon")
	local title = panel:getChildByFullName("title")
	local content = panel:getChildByFullName("content")
	local info = {
		id = skillId
	}
	local newSkillNode = IconFactory:createMasterSkillIcon(info, {
		hideLevel = true
	})

	newSkillNode:setScale(0.52)
	newSkillNode:setPosition(cc.p(6, 15))
	newSkillNode:addTo(imageIcon)

	local name = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")

	title:setString(Strings:get(name))

	local text = Strings:get(ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc"))

	content:setString(text)
end

function TowerBuffMediator:createSkillDescPanel(skillId)
	local title = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc")
	local desc = ConfigReader:getEffectDesc("Skill", title, skillId, 1)
	local label = ccui.RichText:createWithXML(desc, {})

	label:renderContent(568, 0)
	label:setAnchorPoint(cc.p(0, 0.5))

	return label
end

function TowerBuffMediator:onClickBack()
	self:close()
end
