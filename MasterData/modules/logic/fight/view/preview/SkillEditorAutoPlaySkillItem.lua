-- chunkname: @modules/logic/fight/view/preview/SkillEditorAutoPlaySkillItem.lua

module("modules.logic.fight.view.preview.SkillEditorAutoPlaySkillItem", package.seeall)

local SkillEditorAutoPlaySkillItem = class("SkillEditorAutoPlaySkillItem", ListScrollCell)

function SkillEditorAutoPlaySkillItem:init(go)
	self._text = gohelper.findChildText(go, "Text")
	self._text1 = gohelper.findChildText(go, "imgSelect/Text")
	self._click = SLFramework.UGUI.UIClickListener.Get(go)
	self._selectGO = gohelper.findChild(go, "imgSelect")

	gohelper.setActive(go, true)
end

function SkillEditorAutoPlaySkillItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function SkillEditorAutoPlaySkillItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function SkillEditorAutoPlaySkillItem:onUpdateMO(mo)
	self._mo = mo

	local co = mo.co

	if mo.type == SkillEditorMgr.SelectType.Hero or SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.SubHero then
		self._text.text = co.skinId .. ((co.name or nil) and ("\n" .. co.name or ""))
		self._text1.text = co.skinId .. ((co.name or nil) and ("\n" .. co.name or ""))
	elseif mo.type == SkillEditorMgr.SelectType.Monster then
		local skin_config = FightConfig.instance:getSkinCO(co.skinId)

		if skin_config then
			if not skin_config.name then
				local show_name

				if not skin_config then
					logError("皮肤表找不到id,怪物模型id：", co.skinId)
				end

				self._text.text = co.skinId .. ((show_name or nil) and ("\n" .. show_name or ""))
				self._text1.text = co.skinId .. ((show_name or nil) and ("\n" .. show_name or ""))
			end
		end
	elseif mo.type == SkillEditorMgr.SelectType.Group then
		local monsterIds = string.splitToNumber(co.monster, "#")
		local monsterCO = lua_monster.configDict[monsterIds[1]]

		for i = 2, #monsterIds do
			if tabletool.indexOf(string.splitToNumber(co.bossId, "#"), monsterIds[i]) then
				monsterCO = lua_monster.configDict[monsterIds[i]]

				break
			end
		end

		self._text.text = co.id .. ((monsterCO and monsterCO.name or nil) and ("\n" .. monsterCO.name or ""))
		self._text1.text = co.id .. ((monsterCO and monsterCO.name or nil) and ("\n" .. monsterCO.name or ""))
	else
		self._text.text = co.id .. ((co.name or nil) and ("\n" .. co.name or ""))
		self._text1.text = co.id .. ((co.name or nil) and ("\n" .. co.name or ""))
	end
end

function SkillEditorAutoPlaySkillItem:onSelect(isSelect)
	gohelper.setActive(self._selectGO, isSelect)
end

function SkillEditorAutoPlaySkillItem:_onClickThis()
	self._view:selectCell(self._mo.id, true)
	SkillEditorToolAutoPlaySkillSelectModel.instance:addAtLast(self._mo)
end

return SkillEditorAutoPlaySkillItem
