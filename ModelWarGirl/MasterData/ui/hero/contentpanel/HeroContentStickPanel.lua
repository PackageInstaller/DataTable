-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\HeroContentStickPanel.lua

local ResStick = require("ClientData/ResStick")
local ResStickLevel = require("ClientData/ResStickLevel")
local strClassName = "HeroContentStickPanel"
local HeroContentStickPanel = Class(strClassName, UIControls.Child)

function HeroContentStickPanel:ctor()
	self:initUI()
end

function HeroContentStickPanel:initUI()
	self.btnUnlcok = UIControls.Button(self, "Bg/BtnUnlcok")

	self.btnUnlcok:addEventClick(self.onBtnUnlcokClick)

	self.attrLessPanel = UIControls.Panel(self, "Bg/AttrLessPanel")
	self.btnMore = UIControls.Button(self, "Bg/AttrLessPanel/BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.maxPanel = UIControls.Panel(self, "Bg/MaxPanel")
	self.gridItem = UIControls.Panel(self, "Bg/GridItem")
	self.attrPanelList = {}

	for i = 1, 5 do
		local attrPanel = UIControls.Panel(self, "Bg/AttrLessPanel/Attr0" .. i)
		local textName = UIControls.Label(self, "Bg/AttrLessPanel/Attr0" .. i .. "/TextName")
		local textLv = UIControls.Label(self, "Bg/AttrLessPanel/Attr0" .. i .. "/TextLv")

		self.attrPanelList[i] = {
			attrPanel = attrPanel,
			textName = textName,
			textLv = textLv
		}
	end

	self.lazyEfx = UIControls.LazyEffectPlayer(self, "Bg/Efx")
end

function HeroContentStickPanel:setHero(hero)
	self.hero = hero
	self.stick = self.hero:getStickData()
	self.itemId = ResStick[self.hero.id].item_id
	self.attrList = CurAvatar:getStickAttrInfo(hero.id)

	self.attrLessPanel:setVisible(true)

	for i, attrUI in ipairs(self.attrPanelList) do
		if self.attrList[i] then
			attrUI.attrPanel:setVisible(true)
			attrUI.textName:setText(self.attrList[i].zhName)
			attrUI.textLv:setText(self.attrList[i].value)
		else
			attrUI.attrPanel:setVisible(false)
		end
	end

	self.maxPanel:setVisible(CurAvatar:isStickMaxLv(hero.id))
	self.btnUnlcok:setVisible(not CurAvatar:isStickMaxLv(hero.id))

	if not CurAvatar:isStickMaxLv(hero.id) then
		self.gridItem:setVisible(true)

		if ResStickLevel[self.stick.level + 1] then
			self.costNum = ResStickLevel[self.stick.level + 1].cost
		end

		self.item = BaseObject.GetObject(self.itemId, self.costNum)
		self.itemGrid = UIControls.getGridChild(self.item, self, "Bg/GridItem")

		self.itemGrid:setObj(self.item)

		if self.itemGrid.textNum then
			local haveNum = CurAvatar:getItemNumById(self.itemId)

			self.itemGrid.textNum:setText(haveNum .. "/" .. self.costNum)
		end

		self.itemGrid:setVisible(true)
	else
		self.gridItem:setVisible(false)
	end
end

function HeroContentStickPanel:playLevelUpEfx()
	self.lazyEfx:setVisible(false)
	self.lazyEfx:setVisible(true)
end

function HeroContentStickPanel:onBtnUnlcokClick()
	if self.costNum and self.costNum > CurAvatar:getItemNumById(self.itemId) then
		MsgManager.notice(Lang.get(200))

		return
	end

	local use = {}

	use.data = {}
	use.data.id = self.itemId
	use.data.num = self.costNum

	RPC.itemUse({
		use
	})
end

function HeroContentStickPanel:onBtnMoreClick()
	return
end

return HeroContentStickPanel
