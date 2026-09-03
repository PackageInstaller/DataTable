-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterLeadStageSkillTip.lua

MasterLeadStageSkillTip = class("MasterLeadStageSkillTip", BaseWidget, _M)

local listWidth = 0

function MasterLeadStageSkillTip.class:createWidgetNode()
	local resFile = "asset/ui/MasterLeadStageSkillTip.csb"

	return cc.CSLoader:createNode(resFile)
end

function MasterLeadStageSkillTip:initialize(view, data)
	super.initialize(self, view)

	self._skillId = data.skillId
	self._masterData = data.masterData
	self._leadStageLevel = data.stageLevel
	self._mediator = data.mediator
	self._skillIndex = data.skillIndex
	self._configPro = PrototypeFactory:getInstance():getSkillPrototype(self._skillId)
	self._config = self._configPro:getConfig()

	self:initSubviews(view)
end

function MasterLeadStageSkillTip:dispose()
	super.dispose(self)
end

function MasterLeadStageSkillTip:initSubviews(view)
	self._view = view
	self._skillTipPanel = self._view:getChildByName("skillTipPanel")
	self._line = self._skillTipPanel:getChildByFullName("line")

	self._line:setVisible(false)

	local desc = self._skillTipPanel:getChildByName("desc")

	listWidth = desc:getContentSize().width

	local skillTouchPanel = self._skillTipPanel:getChildByFullName("skillTouchPanel")

	skillTouchPanel:setSwallowTouches(false)
	skillTouchPanel:addClickEventListener(function()
		self:hide()
	end)
end

function MasterLeadStageSkillTip:refreshInfo(data)
	self._masterData = data.masterData
	self._skillId = data.skillId
	self._leadStageLevel = data.stageLevel
	self._isShowCurLv = data.isShowCurLv
	self._skillIndex = data.skillIndex
	self._configPro = PrototypeFactory:getInstance():getSkillPrototype(self._skillId)
	self._config = self._configPro:getConfig()

	local stageData = self._masterData:getLeadStageData():getConfigInfo()

	if self._leadStageLevel == 0 then
		self._skillLevel = 0
		self._skillState = MasterLeadStageSkillState.KLOCK
	else
		self._skillLevel = stageData[self._leadStageLevel].skills[self._skillId].level
		self._skillState = stageData[self._leadStageLevel].skills[self._skillId].state
	end

	local infoNode = self._skillTipPanel:getChildByFullName("infoNode")
	local iconPanel = infoNode:getChildByFullName("iconPanel")

	iconPanel:removeAllChildren()

	local skillType = self._config.Type
	local skillIcon = IconFactory:createMasterLeadStageSkillIcon({
		id = self._skillId,
		isLock = self._skillState == MasterLeadStageSkillState.KLOCK
	})

	skillIcon:addTo(iconPanel):posite(10, 16)
	skillIcon:setScale(0.5)

	local skillAnimPanel = infoNode:getChildByFullName("skillAnim")
	local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")
	local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")
	local icon1, icon2 = self._mediator._heroSystem:getSkillTypeIcon(skillType)
	local skillTypeIcon = skillPanel1:getChildByFullName("icon")

	skillTypeIcon:loadTexture(icon1)

	local skillTypeBg = skillPanel2:getChildByFullName("bg")

	skillTypeBg:loadTexture(icon2)
	skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

	local typeNameLabel = skillPanel2:getChildByFullName("skillType")

	typeNameLabel:setString(self._mediator._heroSystem:getSkillTypeName(skillType))
	typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))

	local width = typeNameLabel:getContentSize().width + 30

	skillTypeBg:setContentSize(cc.size(width, 38))
	skillAnimPanel:setContentSize(cc.size(width + 25, 46))

	local name = infoNode:getChildByFullName("name")

	name:setString(Strings:get(self._config.Name))

	local bg = self._skillTipPanel:getChildByName("Image_bg")
	local desc = self._skillTipPanel:getChildByName("desc")

	desc:setString("")
	desc:removeAllChildren()

	local descStr = {}
	local height = 0

	if self._skillState == MasterLeadStageSkillState.KLOCK then
		local lockLevel

		for i, v in ipairs(stageData) do
			if v.skills[self._skillId].level == 1 then
				lockLevel = i

				break
			end
		end

		local newPanel = self:createPanel(lockLevel, 1, true, false)

		if newPanel then
			newPanel:setAnchorPoint(cc.p(0, 0))
			newPanel:addTo(desc)
			table.insert(descStr, {
				newPanel = newPanel,
				height = newPanel:getContentSize().height
			})

			height = height + newPanel:getContentSize().height
		end
	else
		local isMax = self._skillLevel == stageData[#stageData].skills[self._skillId].level
		local newPanel = self:createPanel(self._leadStageLevel, self._skillLevel, false, isMax)

		if newPanel then
			newPanel:setAnchorPoint(cc.p(0, 0))
			newPanel:addTo(desc)
			table.insert(descStr, {
				newPanel = newPanel,
				height = newPanel:getContentSize().height
			})

			height = height + newPanel:getContentSize().height
		end
	end

	local attrEffects = self._config.AttrEffects
	local effects = {}

	if attrEffects and type(attrEffects) == "table" then
		local effectId = attrEffects[1]
		local config = ConfigReader:getRecordById("SkillAttrEffect", effectId)

		assert(config ~= nil, "effectId =" .. tostring(effectId) .. " is not in SkillAttrEffect Config")

		effects = config.EffectRange or {}
	end

	if next(effects) then
		local newPanel = self:createIncludePanel(effects)

		newPanel:setAnchorPoint(cc.p(0, 0))
		newPanel:addTo(desc)
		table.insert(descStr, {
			newPanel = newPanel,
			height = newPanel:getContentSize().height
		})

		height = height + newPanel:getContentSize().height
	end

	for i = #descStr, 1, -1 do
		local newPanel = descStr[i].newPanel

		if i == #descStr then
			newPanel:setPositionY(0)
		else
			local posY = descStr[i + 1].height

			newPanel:setPositionY(posY)
		end
	end

	height = height + 100

	bg:setContentSize(cc.size(bg:getContentSize().width, height))
	infoNode:setPositionY(height - 80)
end

function MasterLeadStageSkillTip:createPanel(leadStageLevel, skillLevel, isLock, isMax)
	local str = "<font face='asset/font/CustomFont_FZYH_R.TTF' size='18' color='#ffffff'>%s:</font>"
	local stageData = self._masterData:getLeadStageData():getConfigInfo()
	local strWidth = listWidth

	if isLock then
		local showText

		if self._masterData:getLeadStageData():getSkillKind(self._skillId) == "Skill" then
			showText = SkillPrototype:getSkillEffectDesc(self._skillId, skillLevel, {})
		else
			local style = {
				fontName = TTF_FONT_FZYH_M
			}

			showText = SkillPrototype:getAttrEffectDesc(stageData[leadStageLevel].SkillName[self._skillIndex], skillLevel, style)
		end

		local lockStr = string.format(str, Strings:get("LeadStage_SkillLock", {
			stageName = Strings:get(stageData[leadStageLevel].RomanNum) .. Strings:get(stageData[leadStageLevel].StageName) .. " "
		}))

		if showText ~= "" then
			return (self:createSkillDesPanel(lockStr, showText))
		end
	else
		local layout = ccui.Layout:create()
		local desTable = {}

		for i = 1, (self._isShowCurLv or isMax) and 1 do
			local lockStr

			if self._isShowCurLv then
				lockStr = string.format(str, Strings:get(stageData[leadStageLevel + i - 1].RomanNum) .. Strings:get(stageData[leadStageLevel + i - 1].StageName))
			else
				local tr = Strings:get(i == 1 and "LeadStage_SkillName01" or "LeadStage_SkillName02", {
					stage = Strings:get(stageData[leadStageLevel + i - 1].RomanNum) .. Strings:get(stageData[leadStageLevel + i - 1].StageName)
				})
				local trstr = "<font face='asset/font/CustomFont_FZYH_R.TTF' size='18' color='#ffffff'>%s</font>"

				lockStr = string.format(trstr, tr)
			end

			if self._masterData:getLeadStageData():getSkillKind(self._skillId) == "Skill" then
				showText = SkillPrototype:getSkillEffectDesc(self._skillId, skillLevel + i - 1, {})
			else
				local style = {
					fontName = TTF_FONT_FZYH_M
				}

				showText = SkillPrototype:getAttrEffectDesc(stageData[leadStageLevel].SkillName[self._skillIndex], skillLevel + i - 1, style)
			end

			if showText ~= "" then
				local l = self:createSkillDesPanel(lockStr, showText)

				table.insert(desTable, {
					panel = l,
					height = l:getContentSize().height
				})
			end
		end

		local height = 0
		local space = 10

		for i = #desTable, 1, -1 do
			desTable[i].panel:addTo(layout):posite(0, height)

			height = height + desTable[i].height
			height = height + space
		end

		layout:setContentSize(cc.size(strWidth, height))

		return layout
	end

	return nil
end

function MasterLeadStageSkillTip:createSkillDesPanel(title, showdes)
	local layout = ccui.Layout:create()
	local strWidth = listWidth
	local label1 = ccui.RichText:createWithXML(title, {})

	label1:setColor(cc.c3b(250, 190, 100))
	label1:setVerticalSpace(1)
	label1:renderContent(strWidth, 0)
	label1:setAnchorPoint(cc.p(0, 0))

	local label2 = ccui.RichText:createWithXML(showdes, {})

	label2:setVerticalSpace(1)
	label2:renderContent(strWidth, 0)
	label2:setAnchorPoint(cc.p(0, 0))
	layout:setContentSize(cc.size(strWidth, label1:getContentSize().height + label2:getContentSize().height))
	label2:addTo(layout):posite(0, 0)
	label1:addTo(layout):posite(0, label2:getContentSize().height)

	return layout
end

function MasterLeadStageSkillTip:createIncludePanel(effects)
	effects = ConfigReader:getDataByNameIdAndKey("ConfigValue", "LeadStage_EffectiveTranslate", "content")

	local str = "<font face='asset/font/CustomFont_FZYH_R.TTF' size='18' color='#ffffff'>%s</font>"
	local des = {}

	for i, v in pairs(effects) do
		table.insert(des, Strings:get(v))
	end

	des = table.concat(des, "，")
	des = string.format(str, Strings:get("LeadStage_SkillTip", {
		name = des
	}))

	local strWidth = listWidth
	local layout = ccui.Layout:create()
	local label = ccui.RichText:createWithXML(des, {})

	label:setVerticalSpace(1)
	label:renderContent(strWidth, 0)
	label:setAnchorPoint(cc.p(0, 0))

	local line = self._line:clone()

	line:setVisible(true)

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(strWidth, height + 30))
	label:addTo(layout):posite(0, 0)
	line:addTo(layout):posite(0, height + 10)

	return layout
end

function MasterLeadStageSkillTip:getWidth()
	return self._bg:getContentSize().width
end

function MasterLeadStageSkillTip:getHeight()
	return self._bg:getContentSize().height
end

function MasterLeadStageSkillTip:show()
	self._view:setVisible(true)
end

function MasterLeadStageSkillTip:hide()
	self._view:setVisible(false)
end
