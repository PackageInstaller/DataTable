-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpk/view/RTPKBuffDetailMediator.lua

RTPKBuffDetailMediator = class("RTPKBuffDetailMediator", DmPopupViewMediator, _M)

RTPKBuffDetailMediator:has("_rtpkSystem", {
	is = "r"
}):injectWith("RTPKSystem")

local kBtnHandlers = {}

function RTPKBuffDetailMediator:initialize()
	super.initialize(self)
end

function RTPKBuffDetailMediator:dispose()
	super.dispose(self)
end

function RTPKBuffDetailMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function RTPKBuffDetailMediator:enterWithData(data)
	self:initWigetInfo()
	self:initData(data)
	self:setupInfoView()
end

function RTPKBuffDetailMediator:initWigetInfo()
	self._view = self:getView()
	self._main = self._view:getChildByName("main")
	self._listBg = self._main:getChildByFullName("listBg")
	self._list = self._main:getChildByFullName("listBg.list")
	self._content = self._view:getChildByName("content")
	self._levelPanelClone = self._view:getChildByName("levelPanelClone")
	self._myPet = self._view:getChildByName("myPetClone")
	self._contentChildClone = self._view:getChildByName("contentChildClone")
	self._infoCellClone = self._view:getChildByName("infoCellClone")
	self._contentAddClone = self._view:getChildByName("contentAddClone")
	self._contentBuffClone = self._view:getChildByName("contentBuffClone")
	self._heroClone = self._view:getChildByName("heroPanel")

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("RTPK_BonusPopUp_Title"),
		title1 = Strings:get("DreamChallenge_Point_Title_En"),
		bgSize = {
			width = 840,
			height = 538
		}
	})

	self._listBg:setContentSize(cc.size(680, 380))
	self._list:setContentSize(cc.size(680, 370))
end

function RTPKBuffDetailMediator:initData(data)
	self._ruleData = self._rtpkSystem:getSeasonBuffData()
end

function RTPKBuffDetailMediator:setupInfoView()
	self._list:removeAllChildren()
	self._list:setScrollBarEnabled(false)

	if not next(self._ruleData) then
		local f = string.format("<outline color='#000000' size = '1'><font face='%s' size='%d' color='#ffffff'>%s</font></outline>", TTF_FONT_FZYH_M, 20, Strings:get("RTPK_NoBonusTip"))
		local seasonBuffPanel = self:createSeasonSkillPanel({
			desc = f
		})

		self._list:pushBackCustomItem(seasonBuffPanel)

		return
	end

	if self._ruleData.seasonSkill then
		local seasonBuffPanel = self:createSeasonSkillPanel(self._ruleData.seasonSkill)

		self._list:pushBackCustomItem(seasonBuffPanel)
	end

	if self._ruleData.levelLimit then
		local panel = self:createConfigLevelLimitIDPanel(self._ruleData.levelLimit)

		self._list:pushBackCustomItem(panel)
	end

	if self._ruleData.hero then
		local panel = self:createHeroInfoPanel(self._ruleData.hero)

		self._list:pushBackCustomItem(panel)
	end

	if self._ruleData.starSkill or self._ruleData.awakenSkill then
		local panel = self:createStarAwakePanel(self._ruleData.starSkill, self._ruleData.awakenSkill)

		self._list:pushBackCustomItem(panel)
	end
end

function RTPKBuffDetailMediator:setInfoCellBg(view, rowHeight, rowWidth)
	local bg = view:getChildByFullName("Image_38")

	view:setContentSize(cc.size(rowWidth, rowHeight))
	bg:setContentSize(cc.size(rowWidth, rowHeight))
	bg:setPositionY(rowHeight)
	view:getChildByFullName("mTopLayout"):setPositionY(rowHeight + 8)
	view:getChildByFullName("Image_31"):setPositionY(rowHeight - 5)
end

function RTPKBuffDetailMediator:createSeasonSkillPanel(data)
	local view = self._content:clone()
	local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

	name:setString(Strings:get("RTPK_BonusPopUp_Buff"))

	local richText = ccui.RichText:createWithXML(data.desc, {})

	richText:setAnchorPoint(cc.p(0, 0))
	richText:setPosition(cc.p(40, 40))
	richText:addTo(view)
	richText:renderContent(600, 0, true)

	local size = richText:getContentSize()

	self:setInfoCellBg(view, math.floor(size.height + 90), 688)

	return view
end

function RTPKBuffDetailMediator:createConfigLevelLimitIDPanel(data)
	local view = self._content:clone()
	local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

	name:setString(Strings:get("RTPK_BonusPopUp_FairPower"))

	local f = string.format("<outline color='#000000' size = '1'><font face='%s' size='%d' color='#ffffff'>%s</font></outline>", TTF_FONT_FZYH_M, 20, data.desc)
	local richText = ccui.RichText:createWithXML(f, {})

	richText:setFontSize(20)
	richText:setAnchorPoint(cc.p(0, 0))
	richText:setPosition(cc.p(40, 40))
	richText:addTo(view)
	richText:renderContent(600, 0, true)

	local size = richText:getContentSize()

	self:setInfoCellBg(view, size.height + 90, 688)

	return view
end

function RTPKBuffDetailMediator:createHeroInfoPanel(data)
	local view = self._content:clone()
	local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

	name:setString(Strings:get("RTPK_BonusPopUp_Heros"))

	local row = math.ceil(#data / 5)

	self:setInfoCellBg(view, 100 * row + 70, 688)

	for i = 1, row do
		for j = 1, 5 do
			local realIndex = j + (i - 1) * 5

			if data[realIndex] then
				local iconNode = self._heroClone:clone()
				local attackText = iconNode:getChildByFullName("attackText")

				attackText:setString(data[realIndex].desc)

				if iconNode:getChildByFullName("iconHero") then
					iconNode:getChildByFullName("iconHero"):removeFromParent()
				end

				local config = ConfigReader:getRecordById("HeroBase", data[realIndex].hero)
				local heroImg = IconFactory:createRoleIconSpriteNew({
					id = config.RoleModel
				})

				heroImg:addTo(iconNode):center(iconNode:getContentSize()):offset(0, 6)
				heroImg:setName("iconHero")
				heroImg:setScale(0.25)
				view:addChild(iconNode)
				iconNode:setPosition(cc.p(20 + (j - 1) * 132, 100 * row - (i - 1) * 100 - 70))
				iconNode:getChildByName("Panel_7"):setLocalZOrder(5)

				local text = iconNode:getChildByName("Text_1")

				text:setLocalZOrder(15)
			end
		end
	end

	return view
end

function RTPKBuffDetailMediator:createStarAwakePanel(starData, awakeData)
	local view = self._content:clone()
	local name = view:getChildByFullName("mTopLayout.mExtraRewardLabel")

	name:setString(Strings:get("RTPK_BonusPopUp_Others"))

	local addTable = {}

	if starData then
		local recommendHero2 = self._view:getChildByFullName("recommendHero2")

		recommendHero2:changeParent(view)

		local attackText = recommendHero2:getChildByFullName("attackText")

		attackText:setString(starData.desc)
		attackText:setColor(cc.c3b(255, 159, 48))
		table.insert(addTable, recommendHero2)
	end

	if awakeData then
		local recommendHero3 = self._view:getChildByFullName("recommendHero3")
		local attackText = recommendHero3:getChildByFullName("attackText")

		attackText:setString(awakeData.desc)
		attackText:setColor(cc.c3b(255, 159, 48))
		recommendHero3:changeParent(view)
		table.insert(addTable, recommendHero3)
	end

	local size = #addTable

	for i = 1, size do
		addTable[i]:setPosition(cc.p(30 + 120 * (i - 1), 30))
	end

	self:setInfoCellBg(view, 190, 688)

	return view
end

function RTPKBuffDetailMediator:onCloseClicked()
	self:close()
end
