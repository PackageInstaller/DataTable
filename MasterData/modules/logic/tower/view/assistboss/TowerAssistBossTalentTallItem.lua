-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentTallItem.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentTallItem", package.seeall)

local TowerAssistBossTalentTallItem = class("TowerAssistBossTalentTallItem", ListScrollCellExtend)

function TowerAssistBossTalentTallItem:onInitView()
	self.imgTalent = gohelper.findChildImage(self.viewGO, "Title/#image_TalentIcon")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Title/#txt_Title")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "#txt_Descr")

	SkillHelper.addHyperLinkClick(self.txtDesc, self._onHyperLinkClick, self)

	self.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtDesc.gameObject, FixTmpBreakLine)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossTalentTallItem:addEvents()
	return
end

function TowerAssistBossTalentTallItem:removeEvents()
	return
end

function TowerAssistBossTalentTallItem:_editableInitView()
	return
end

function TowerAssistBossTalentTallItem:onUpdateMO(mo)
	self._mo = mo

	if not mo then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	local config = self._mo.config

	self.txtTitle.text = config.nodeName
	self.txtDesc.text = SkillHelper.buildDesc(config.nodeDesc)

	self.descFixTmpBreakLine:refreshTmpContent(self.txtDesc)
	TowerConfig.instance:setTalentImg(self.imgTalent, config)
end

function TowerAssistBossTalentTallItem:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function TowerAssistBossTalentTallItem:onDestroyView()
	return
end

return TowerAssistBossTalentTallItem
