-- chunkname: @modules/logic/fight/view/preview/SkillEditorHeroSelectItem.lua

module("modules.logic.fight.view.preview.SkillEditorHeroSelectItem", package.seeall)

local SkillEditorHeroSelectItem = class("SkillEditorHeroSelectItem", ListScrollCell)

function SkillEditorHeroSelectItem:init(go)
	self._text = gohelper.findChildText(go, "Text")
	self._text1 = gohelper.findChildText(go, "imgSelect/Text")
	self._click = SLFramework.UGUI.UIClickListener.Get(go)
	self._selectGO = gohelper.findChild(go, "imgSelect")
end

function SkillEditorHeroSelectItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function SkillEditorHeroSelectItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function SkillEditorHeroSelectItem:onUpdateMO(mo)
	self._mo = mo

	local co = mo.co

	if SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Hero or SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.SubHero then
		self._text.text = co.skinId .. ((co.name or nil) and ("\n" .. co.name or ""))
		self._text1.text = co.skinId .. ((co.name or nil) and ("\n" .. co.name or ""))
	elseif SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Monster then
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
	elseif SkillEditorHeroSelectModel.instance.selectType == SkillEditorMgr.SelectType.Group then
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

function SkillEditorHeroSelectItem:onSelect(isSelect)
	gohelper.setActive(self._selectGO, isSelect)
end

function SkillEditorHeroSelectItem:_onClickThis()
	self._view:selectCell(self._mo.id, true)

	local selectType = SkillEditorHeroSelectModel.instance.selectType
	local side = SkillEditorHeroSelectModel.instance.side
	local stancePosId = SkillEditorHeroSelectModel.instance.stancePosId
	local oldType, info = SkillEditorMgr.instance:getTypeInfo(side)
	local co = self._mo.co
	local newId = self._mo.co.id

	if selectType == SkillEditorMgr.SelectType.Group then
		info.ids = {}
		info.skinIds = {}
		info.groupId = newId

		local monsterGroupCO = lua_monster_group.configDict[newId]
		local monsterIds = string.splitToNumber(monsterGroupCO.monster, "#")

		for _, monsterId in ipairs(monsterIds) do
			local monsterCO = lua_monster.configDict[monsterId]

			if monsterCO then
				local skinCO = FightConfig.instance:getSkinCO(monsterCO.skinId)

				if skinCO then
					if string.nilorempty(skinCO.spine) then
						GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, co.skinId or co.id)

						return
					end
				end

				table.insert(info.ids, monsterId)
				table.insert(info.skinIds, monsterCO.skinId)
			end
		end

		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectStance, side, monsterGroupCO.stanceId, false)
	elseif selectType == SkillEditorMgr.SelectType.SubHero then
		SkillEditorMgr.instance:addSubHero(self._mo.co.id, self._mo.co.skinId)

		return
	else
		local firstId = info.ids[1]

		if selectType == SkillEditorMgr.SelectType.Hero then
			if not self._mo.co then
				local co = lua_monster.configDict[newId]
				local skinCO = FightConfig.instance:getSkinCO(co.skinId)

				if skinCO then
					if string.nilorempty(skinCO.spine) then
						GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, co.skinId or co.id)

						return
					end

					if stancePosId then
						info.ids[stancePosId] = newId
						info.skinIds[stancePosId] = co.skinId

						goto label_6_0
					end
				end

				for i, id in ipairs(info.ids) do
					if id == firstId or oldType ~= selectType then
						info.ids[i] = newId
						info.skinIds[i] = co.skinId
					end
				end

				::label_6_0::

				info.groupId = nil
			end
		end
	end

	SkillEditorMgr.instance:setTypeInfo(side, selectType, info.ids, info.skinIds, info.groupId)
	SkillEditorMgr.instance:refreshInfo(side)
	SkillEditorMgr.instance:rebuildEntitys(side)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, side)
end

return SkillEditorHeroSelectItem
