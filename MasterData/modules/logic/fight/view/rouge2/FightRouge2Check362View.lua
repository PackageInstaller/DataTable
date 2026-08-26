-- chunkname: @modules/logic/fight/view/rouge2/FightRouge2Check362View.lua

module("modules.logic.fight.view.rouge2.FightRouge2Check362View", package.seeall)

local FightRouge2Check362View = class("FightRouge2Check362View", BaseView)

FightRouge2Check362View.DurationTime = 1.5

function FightRouge2Check362View:onInitView()
	self.txtAdd = gohelper.findChildText(self.viewGO, "#txt_add")
	self.imageIcon = gohelper.findChildImage(self.viewGO, "#simage_icon")
	self.goBaseItem = gohelper.findChild(self.viewGO, "#go_baseitem")
	self.imageProgress = gohelper.findChildImage(self.goBaseItem, "#image_progress")
	self.imageIcon1 = gohelper.findChildImage(self.goBaseItem, "image_icon")
	self.goTxtLevel = gohelper.findChild(self.goBaseItem, "#txt_level")
	self.txtAdd1 = gohelper.findChildText(self.goBaseItem, "num/#txt_add")
	self.txtReduce1 = gohelper.findChildText(self.goBaseItem, "num/#txt_reduce")

	gohelper.setActive(self.goTxtLevel, false)
end

function FightRouge2Check362View:addEvents()
	return
end

function FightRouge2Check362View:removeEvents()
	return
end

function FightRouge2Check362View.blockEsc()
	return
end

function FightRouge2Check362View:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

function FightRouge2Check362View:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.DiceSucc)

	self.txtAdd.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_fight_add_value"), self.viewParam.offset)
	self.buffId = self.viewParam.buffId

	local co = self:getRelicCo()
	local typeCo = self:getTypeCo(co.attributeTag)

	UISpriteSetMgr.instance:setFightSprite(self.imageIcon, typeCo.icon)
	UISpriteSetMgr.instance:setFightSprite(self.imageProgress, typeCo.progressIcon)
	UISpriteSetMgr.instance:setFightSprite(self.imageIcon1, typeCo.icon)

	if self.viewParam.offset > 0 then
		self.txtAdd1.text = "+" .. self.viewParam.offset
		self.txtReduce1.text = ""
	else
		self.txtAdd1.text = ""
		self.txtReduce1.text = "-" .. self.viewParam.offset
	end

	TaskDispatcher.runDelay(self.closeSelf, self, FightRouge2Check362View.DurationTime)
end

function FightRouge2Check362View:closeSelf()
	self:closeThis()
end

function FightRouge2Check362View:getRelicCo()
	local customData = FightDataHelper.fieldMgr.customData
	local buffId2RelicListDict = customData and customData:getRouge2BuffId2RelicDict()

	if not buffId2RelicListDict then
		logError("rouge2Data.buffId2CheckRelicMap is nil")

		return lua_fight_rouge2_check_relic.configList[1]
	end

	local relicList = buffId2RelicListDict[tostring(self.buffId)]
	local id = relicList and relicList[1]
	local co = id and lua_fight_rouge2_check_relic.configDict[id]

	if not co then
		logError(string.format("co is nil, data : %s, buffId : %s", id, self.buffId))

		co = lua_fight_rouge2_check_relic.configList[1]
	end

	return co
end

function FightRouge2Check362View:getBigIconUrl(bigIcon)
	return string.format("singlebg/fight/rouge2/%s.png", bigIcon)
end

function FightRouge2Check362View:getTypeCo(typeId)
	local co = lua_fight_rouge2_relic_type.configDict[typeId]

	if not co then
		logError("type co is nil, typeId : " .. tostring(typeId))

		co = lua_fight_rouge2_relic_type.configList[1]
	end

	return co
end

function FightRouge2Check362View:onDestroyView()
	TaskDispatcher.cancelTask(self.closeSelf, self)
end

return FightRouge2Check362View
