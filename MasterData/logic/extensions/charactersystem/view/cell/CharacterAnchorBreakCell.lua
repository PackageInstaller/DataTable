-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/cell/CharacterAnchorBreakCell.lua

module("logic.extensions.charactersystem.view.cell.CharacterAnchorBreakCell", package.seeall)

local M = class("CharacterAnchorBreakCell")

function M:ctor(container)
	self._go = container.gameObject
	self._heroId = nil
	self._breakIndex = nil

	self:_buildUI()
	self:_bindEvents()
end

function M:_buildUI()
	self._btnCell = UIComponentType.ButtonAdapter(goutil.findChild(self._go, "click"))
	self._goTipsGo = goutil.findChild(self._go, "tipsPos") or self._go
end

function M:_bindEvents()
	self._btnCell:AddClickListener(self._onClickCell, self)
end

function M:_unbindEvents()
	self._btnCell:RemoveClickListener()
end

function M:destroyUI()
	self:_unbindEvents()
end

function M:setData(heroId, breakIndex)
	self._heroId = heroId
	self._breakIndex = breakIndex
end

function M:_onClickCell()
	local skillEnhanceMO, targetSkillId
	local cfgBreakAttrCO = HeroBreakConfig.instance:getAttrCO(self._heroId, self._breakIndex)

	if cfgBreakAttrCO then
		targetSkillId = cfgBreakAttrCO.skillId

		if targetSkillId > 0 then
			skillEnhanceMO = SkillEnhanceMO.New(targetSkillId)

			for i = 1, self._breakIndex do
				local cfg = HeroBreakConfig.instance:getAttrCO(self._heroId, i)

				if cfg and cfg.attrGrowEnhance <= 0 and cfg.skillId == targetSkillId and cfg.skillEnhanceId > 0 then
					skillEnhanceMO:addSkillEnhanceCode(cfg.skillEnhanceId)
				end
			end
		end
	else
		printWarn(string.format("角色[%s]没有配置合约,level[%s]", self._heroId, self._breakIndex))

		return
	end

	if skillEnhanceMO then
		skillEnhanceMO:rebuild()

		if cfgBreakAttrCO.skillEnhanceId > 0 then
			local enhanceCO = ActiveSkillConfig.instance:getSkillEnhanceCOWrapper(cfgBreakAttrCO.skillEnhanceId)
			local title = langF("anchor_break_title", CommEnum.Num2RomeNum[self._breakIndex])

			ToolTipsMgr.showAuchorBreakDesc(title, enhanceCO:getDescription(true), self._goTipsGo)
		else
			local skillInfo = ToolTipsMgr.getSkillTipsInfo()

			skillInfo.heroId = self._heroId
			skillInfo.skillId = targetSkillId
			skillInfo.hangGO = self._goTipsGo
			skillInfo.isPassEvent = true

			ToolTipsMgr.showCharacterSysSkillTips(skillInfo)
		end
	elseif cfgBreakAttrCO.attrGrowEnhance > 0 then
		local desc = langF("tip_character_anchor_tip_2", math.floor(cfgBreakAttrCO.attrGrowEnhance * 100))
		local title = langF("anchor_break_title", CommEnum.Num2RomeNum[self._breakIndex])

		ToolTipsMgr.showAuchorBreakDesc(title, desc, self._goTipsGo)
	end
end

return M
