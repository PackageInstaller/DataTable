-- chunkname: @modules/logic/fight/view/preview/SkillEditorAutoPlaySkillSelectItem.lua

module("modules.logic.fight.view.preview.SkillEditorAutoPlaySkillSelectItem", package.seeall)

local SkillEditorAutoPlaySkillSelectItem = class("SkillEditorAutoPlaySkillSelectItem", ListScrollCell)

function SkillEditorAutoPlaySkillSelectItem:init(go)
	self._text = gohelper.findChildText(go, "Text")
	self._click = gohelper.findChildButtonWithAudio(go, "imgRemove")
	self._btnUseSkin = gohelper.findChildButtonWithAudio(go, "btn_skin")
	self._goNoUseImg = gohelper.findChild(go, "btn_skin/nouse")
	self._goUseImg = gohelper.findChild(go, "btn_skin/use")

	gohelper.setActive(go, true)
	gohelper.setActive(self._goNoUseImg, true)
	gohelper.setActive(self._goUseImg, false)
end

function SkillEditorAutoPlaySkillSelectItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
	self._btnUseSkin:AddClickListener(self._openSelectScroll, self)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._SelectAutoPlaySkin, self._selectSkin, self)
end

function SkillEditorAutoPlaySkillSelectItem:removeEventListeners()
	self._click:RemoveClickListener()
	self._btnUseSkin:RemoveClickListener()
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._SelectAutoPlaySkin, self._selectSkin, self)
end

function SkillEditorAutoPlaySkillSelectItem:onUpdateMO(mo)
	self._mo = mo

	local co = mo.co

	if mo.type == SkillEditorMgr.SelectType.Hero then
		self._text.text = co.skinId .. ((co.name or nil) and ("\n" .. co.name or ""))
	elseif mo.type == SkillEditorMgr.SelectType.Monster then
		local skin_config = FightConfig.instance:getSkinCO(co.skinId)

		if skin_config then
			if not skin_config.name then
				local show_name

				if not skin_config then
					logError("皮肤表找不到id,怪物模型id：", co.skinId)
				end

				self._text.text = co.skinId .. ((show_name or nil) and ("\n" .. show_name or ""))
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
	else
		self._text.text = co.id .. ((co.name or nil) and ("\n" .. co.name or ""))
	end
end

function SkillEditorAutoPlaySkillSelectItem:_openSelectScroll()
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._OpenAutoPlaySkin, self._mo)
end

function SkillEditorAutoPlaySkillSelectItem:_selectSkin(param)
	if self._mo.co.id == param.roleid then
		local isChange = self._mo.skinId ~= param.skinid

		gohelper.setActive(self._goNoUseImg, not isChange)
		gohelper.setActive(self._goUseImg, isChange)

		self._mo.skinId = isChange and param.skinid or self._mo.co.skinId

		SkillEditorToolAutoPlaySkillSelectModel.instance:addAt(self._mo, self._index)
	end
end

function SkillEditorAutoPlaySkillSelectItem:_onClickThis()
	SkillEditorToolAutoPlaySkillSelectModel.instance:removeAt(self._index)
end

return SkillEditorAutoPlaySkillSelectItem
