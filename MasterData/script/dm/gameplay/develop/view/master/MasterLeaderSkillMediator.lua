-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterLeaderSkillMediator.lua

MasterLeaderSkillMediator = class("MasterLeaderSkillMediator", DmPopupViewMediator, _M)

MasterLeaderSkillMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MasterLeaderSkillMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

local kHandlerBtn = {
	["main.BG.btn_close"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onCloseBtnClick"
	},
	["main.BG"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onCloseBtnClick"
	}
}
local kTabBtnsNames = {
	{
		"LeadStage_MainPage_Text01",
		"LeadStage_SkillPage_EnText01"
	},
	{
		"LeadStage_MainPage_Text02",
		"LeadStage_SkillPage_EnText02"
	}
}

function MasterLeaderSkillMediator:initialize()
	super.initialize(self)
end

function MasterLeaderSkillMediator:dispose()
	super.dispose(self)
end

function MasterLeaderSkillMediator:onRegister()
	super.onRegister(self)

	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kHandlerBtn)
end

function MasterLeaderSkillMediator:enterWithData(data)
	self:initNode()
	self:initData(data)
	self:initTab()
	self:setListViewVisible()
	self:refreshView()
	self:createMasterStandRole()
	self:setupClickEnvs()
end

function MasterLeaderSkillMediator:initTab()
	local config = {}
	local data = {}

	for i = 1, #kTabBtnsNames do
		data[#data + 1] = {
			tabText = Strings:get(kTabBtnsNames[i][1]),
			tabTextTranslate = Strings:get(kTabBtnsNames[i][2]),
			tabImage = {
				"asset/ui/mastercultivate/common_btn_fy3.png",
				"asset/ui/mastercultivate/common_btn_fy4.png"
			}
		}

		if self._ownSkills then
			break
		end
	end

	config.btnDatas = data

	function config.onClickTab(name, tag)
		self:onClickTab(name, tag)
	end

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode2()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(0, 180)
	self._tabBtnWidget:initTabBtn(config, {
		ignoreSound = true,
		hideBtnAnim = true,
		ignoreRedSelectState = true,
		imageType = ccui.TextureResType.localType
	})
	self._tabBtnWidget:selectTabByTag(self._curTabIdx)

	local view = self._tabBtnWidget:getMainView()

	view:addTo(self._tabPanel):posite(0, 0)
end

function MasterLeaderSkillMediator:initNode()
	self._masterSystem:getMasterLeaderSkillNum()

	self._mainPanel = self:getView():getChildByFullName("main")
	self._skillList = self._mainPanel:getChildByFullName("infoList")
	self._cloneSkill = self:getView():getChildByFullName("cellClone")
	self._rolePanel = self._mainPanel:getChildByFullName("BG.role_panel")
	self._tabPanel = self._mainPanel:getChildByFullName("tab_panel")
	self._leadSkillClone = self:getView():getChildByFullName("cellClone_leadStage")
	self._listView = self._mainPanel:getChildByFullName("ListView_1")
	self._masterBg = self._mainPanel:getChildByFullName("BG.Image_bg1")
	self._leasStageBg = self._mainPanel:getChildByFullName("BG.Image_bg_leadStage")

	self._listView:setScrollBarEnabled(false)
	self._listView:setSwallowTouches(false)
	self._leadSkillClone:setVisible(false)

	self._infoLab = self._mainPanel:getChildByName("info")
end

function MasterLeaderSkillMediator:initData(data)
	if data.index then
		self._curTabIdx = data.index or 1
	end

	self._towerMaster = data.towerMaster or false
	self._ownSkills = data.ownSkills
	self._ownMasterRoleModel = data.ownMasterRoleModel

	if self._towerMaster then
		self._master = data.master
	else
		self._masterId = data.masterId
		self._masterShowList = self._masterSystem:getShowMasterList()
		self._master = nil

		for _, v in ipairs(self._masterShowList) do
			if v:getId() == self._masterId then
				self._master = v
			end
		end
	end

	self._active = data.active

	if self._active == nil then
		self._active = {}
	end

	self._isFromDream = false

	if data.isFromDream then
		self._isFromDream = true
	end
end

function MasterLeaderSkillMediator:setListViewVisible()
	if self._towerMaster then
		self._tabPanel:setVisible(false)

		return
	end

	if #(self._ownSkills and self._ownSkills or self._masterSystem:getMasterActiveSkills(self._masterId)) == 0 then
		self._tabPanel:setVisible(false)
	end
end

function MasterLeaderSkillMediator:onClickTab(name, tag)
	self._curTabIdx = tag

	self:refreshView()
end

function MasterLeaderSkillMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end
end

function MasterLeaderSkillMediator:refreshView()
	self._skillList:setVisible(self._curTabIdx == 1)
	self._masterBg:setVisible(self._curTabIdx == 1)
	self._listView:setVisible(self._curTabIdx == 2)
	self._leasStageBg:setVisible(self._curTabIdx == 2)

	if self._curTabIdx == 1 then
		self:createSkillList()
	else
		self:createLeadStageSkillList()
	end

	self._infoLab:setVisible(self._isFromDream and self._curTabIdx == 1)
end

function MasterLeaderSkillMediator:createSkillList()
	if self._tableView then
		self._tableView:reloadData()

		return
	end

	local function scrollViewDidScroll(table)
		if table:isTouchMoved() then
			-- block empty
		end
	end

	local function tableCellTouch(table, cell)
		return
	end

	local function cellSizeForTable(table, idx)
		return self._cloneSkill:getContentSize().width, self._cloneSkill:getContentSize().height + 7
	end

	local function tableCellAtIndex(table, idx)
		local cell = table:dequeueCell()
		local isActive = self._active[idx + 1]

		if cell == nil then
			cell = cc.TableViewCell:new()

			local sprite = self._cloneSkill:clone()

			sprite:setPosition(0, 0)
			cell:addChild(sprite)
			sprite:setVisible(true)
			sprite:setTag(10000)

			local cell_Old = cell:getChildByTag(10000)

			self:refreshSkillCell(cell_Old, idx + 1, isActive)
			cell:setTag(idx + 1)
		else
			local cell_Old = cell:getChildByTag(10000)

			self:refreshSkillCell(cell_Old, idx + 1, isActive)
			cell:setTag(idx + 1)
		end

		return cell
	end

	local function numberOfCellsInTableView(table)
		return self._masterSystem:getMasterLeaderSkillNum()
	end

	local size, pos = self:getTableViewSize()
	local tableView = cc.TableView:create(size)

	tableView:setTag(1234)

	self._tableView = tableView

	tableView:setDirection(cc.SCROLLVIEW_DIRECTION_VERTICAL)
	tableView:setVerticalFillOrder(cc.TABLEVIEW_FILL_TOPDOWN)
	tableView:setPosition(pos)
	tableView:setAnchorPoint(0, 0)
	tableView:setDelegate()
	self._skillList:addChild(tableView, 1)
	tableView:registerScriptHandler(numberOfCellsInTableView, cc.NUMBER_OF_CELLS_IN_TABLEVIEW)
	tableView:registerScriptHandler(scrollViewDidScroll, cc.SCROLLVIEW_SCRIPT_SCROLL)
	tableView:registerScriptHandler(cellSizeForTable, cc.TABLECELL_SIZE_FOR_INDEX)
	tableView:registerScriptHandler(tableCellAtIndex, cc.TABLECELL_SIZE_AT_INDEX)
	tableView:registerScriptHandler(tableCellTouch, cc.TABLECELL_TOUCHED)
	tableView:reloadData()
end

function MasterLeaderSkillMediator:getTableViewSize()
	return cc.size(700, 390), cc.p(0, 0)
end

function MasterLeaderSkillMediator:refreshSkillCell(cell, index, isActive)
	local infoPanel = cell:getChildByName("info_panel")
	local name = cell:getChildByName("skill_name")
	local iconNode = cell:getChildByName("icon_node")
	local skillTagBg = cell:getChildByName("state_di")
	local skillTagText = cell:getChildByName("state")
	local skill = (self._towerMaster and self._master:getSkillList() or self._ownSkills and self._ownSkills or self._masterSystem:getMasterLeaderSkillList(self._masterId))[index]

	if not skill then
		return
	end

	local starHeight = -7

	name:setString(skill:getName())
	infoPanel:removeAllChildren()

	if not isActive then
		::label_20_0::

		local var_20_0 = self._isFromDream

		if self._isFromDream then
			local isShowEff = self._curTabIdx == 1

			if not isActive then
				::label_20_1::

				if isActive ~= nil then
					if self._isFromDream then
						local isShowGray = self._curTabIdx == 1

						infoPanel:setLayoutType(ccui.LayoutType.VERTICAL)

						local height = self:createSkillDescPanel(infoPanel, skill, isShowGray, starHeight)

						self:createEffectDescPanel(infoPanel, skill, isShowGray, height)

						if isShowGray then
							name:setColor(cc.c3b(255, 165, 0))
							skillTagText:setColor(cc.c3b(255, 255, 255))
							skillTagBg:setVisible(false)
							skillTagText:setVisible(false)
						else
							name:setColor(cc.c3b(195, 195, 195))
							skillTagText:setColor(cc.c3b(195, 195, 195))
							skillTagBg:setVisible(true)
							skillTagText:setVisible(true)
						end

						local dicengEff = cc.MovieClip:create("diceng_jinengjihuo")

						dicengEff:setAnchorPoint(0.5, 0.5)
						dicengEff:setPosition(cc.p(47.5, 50))
						dicengEff:setScale(0.98)
						dicengEff:setVisible(isShowEff)

						local shangcengEff = cc.MovieClip:create("shangceng_jinengjihuo")

						shangcengEff:setAnchorPoint(0.5, 0.5)
						shangcengEff:setPosition(cc.p(47.5, 50))
						shangcengEff:setScale(0.97)
						shangcengEff:setVisible(isShowEff)

						local info = {
							levelHide = true,
							id = skill:getId(),
							skillType = skill:getSkillType()
						}
						local newSkillNode = IconFactory:createMasterSkillIcon(info)

						newSkillNode:setAnchorPoint(0.5, 0.5)
						newSkillNode:setScale(0.65)
						newSkillNode:setPosition(cc.p(17, 20))
						newSkillNode:setGray(not isShowGray)
						iconNode:removeAllChildren()
						iconNode:addChild(dicengEff)
						iconNode:addChild(newSkillNode)
						iconNode:addChild(shangcengEff)
						iconNode:setTouchEnabled(false)
					end
				end
			end
		end
	end
end

local listWidth = 520
local SKILL_EFF_TAG = 1001
local SKILL_DESC_TAG = 1000

function MasterLeaderSkillMediator:createSkillDescPanel(layout, skill, isActive, heightAdd)
	local style = {
		fontName = TTF_FONT_FZYH_M
	}
	local desc = ConfigReader:getEffectDesc("Skill", skill:getMasterSkillDescKey(), skill:getId(), skill:getLevel(), style)
	local label = layout:getChildByTag(SKILL_DESC_TAG)

	local function adjustFontSize(desc, newSize)
		return (desc:gsub("size='(%d+)'", "size='" .. newSize .. "'"))
	end

	if label == nil then
		label = ccui.RichText:createWithXML(desc, {})

		label:addTo(layout)
	else
		label:setString(desc)
	end

	local language = getCurrentLanguage()

	if language ~= GameLanguageType.CN then
		label:setVerticalSpace(1)
	else
		label:setVerticalSpace(8)
	end

	label:renderContent(listWidth, 0)

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(listWidth, height))

	if height > 100 then
		local updatedDesc = adjustFontSize(desc, 15)

		label:setString(updatedDesc)
	end

	label:setTag(SKILL_DESC_TAG)

	if isActive then
		label:setColor(cc.c3b(255, 255, 255))
	else
		label:setColor(cc.c3b(195, 195, 195))
	end

	return height
end

function MasterLeaderSkillMediator:createEffectDescPanel(layout, skill, isActive, heightAdd)
	local skillProto = PrototypeFactory:getInstance():getSkillPrototype(skill:getId())
	local attrDescs = skillProto:getAttrDescs(skill:getLevel(), style) or {}
	local desc = table.concat(attrDescs, ", ", 1, #attrDescs)
	local label = layout:getChildByTag(SKILL_EFF_TAG)

	if label == nil then
		label = ccui.RichText:createWithXML(desc, {})

		label:addTo(layout)
	else
		label:setString(desc)
	end

	local language = getCurrentLanguage()

	if language ~= GameLanguageType.CN then
		label:setVerticalSpace(1)
	else
		label:setVerticalSpace(8)
	end

	label:renderContent(listWidth, 0)

	local height = label:getContentSize().height + heightAdd

	layout:setContentSize(cc.size(listWidth, height))

	if isActive then
		label:setColor(cc.c3b(255, 255, 255))
	else
		label:setColor(cc.c3b(195, 195, 195))
	end

	return height
end

function MasterLeaderSkillMediator:createMasterStandRole()
	local var_24_0 = {
		frameId = "bustframe2_2"
	}

	var_24_0.id = self._ownMasterRoleModel or self._master:getModel()

	local info = var_24_0

	self._rolePanel:removeAllChildren()

	local rolePic = IconFactory:createRoleIconSpriteNew(info)

	if rolePic then
		rolePic:addTo(self._rolePanel):center(self._rolePanel:getContentSize())
	end
end

function MasterLeaderSkillMediator:createLeadStageSkillList()
	self._listView:removeAllChildren()

	local skills = self._masterSystem:getMasterActiveSkills(self._masterId)

	for i = 1, #skills do
		local cell = self._leadSkillClone:clone()

		cell:setVisible(true)
		self:refreshLeadStageCell(cell, skills[i])
		self._listView:pushBackCustomItem(cell)
	end
end

function MasterLeaderSkillMediator:refreshLeadStageCell(cell, skillInfo)
	local infoPanel = cell:getChildByName("info_panel")

	infoPanel:removeAllChildren()

	local name = cell:getChildByName("skill_name")
	local iconPanel = cell:getChildByName("icon_node")

	self._configPro = PrototypeFactory:getInstance():getSkillPrototype(skillInfo.skillId)
	self._config = self._configPro:getConfig()

	local skillType = self._config.Type
	local skillIcon = IconFactory:createMasterLeadStageSkillIcon({
		id = skillInfo.skillId
	})

	skillIcon:addTo(iconPanel):posite(10, 16)
	skillIcon:setScale(0.7)

	local skillAnimPanel = cell:getChildByFullName("skillAnim")
	local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")
	local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")
	local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
	local skillTypeIcon = skillPanel1:getChildByFullName("icon")

	skillTypeIcon:loadTexture(icon1)

	local skillTypeBg = skillPanel2:getChildByFullName("bg")

	skillTypeBg:loadTexture(icon2)
	skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

	local typeNameLabel = skillPanel2:getChildByFullName("skillType")

	typeNameLabel:setString(self._heroSystem:getSkillTypeName(skillType))
	typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))

	local width = typeNameLabel:getContentSize().width + 30

	skillTypeBg:setContentSize(cc.size(width, 38))
	skillAnimPanel:setContentSize(cc.size(width + 25, 46))
	name:setString(Strings:get(self._config.Name))
	name:setColor(cc.c3b(255, 165, 0))

	local showText

	if skillInfo.kind == "Skill" then
		showText = SkillPrototype:getSkillEffectDesc(skillInfo.skillId, skillInfo.level, {})
	else
		local skillProto = PrototypeFactory:getInstance():getSkillPrototype(skillInfo.skillId)
		local style = {
			fontName = TTF_FONT_FZYH_M
		}

		showText = SkillPrototype:getAttrEffectDesc(skillInfo.skillVId, skillInfo.level, style)
	end

	local label2 = ccui.RichText:createWithXML(showText, {})

	label2:setVerticalSpace(1)
	label2:renderContent(infoPanel:getContentSize().width, 0)
	label2:setAnchorPoint(cc.p(0, 1))
	label2:addTo(infoPanel):posite(0, 0)
end

function MasterLeaderSkillMediator:onCloseBtnClick()
	self:close()
end
