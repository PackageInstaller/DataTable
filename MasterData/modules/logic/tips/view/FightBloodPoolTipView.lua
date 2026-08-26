-- chunkname: @modules/logic/tips/view/FightBloodPoolTipView.lua

module("modules.logic.tips.view.FightBloodPoolTipView", package.seeall)

local FightBloodPoolTipView = class("FightBloodPoolTipView", BaseView)

function FightBloodPoolTipView:onInitView()
	self._txttitle = gohelper.findChildText(self.viewGO, "root/layout/#txt_title")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/layout/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightBloodPoolTipView:addEvents()
	return
end

function FightBloodPoolTipView:removeEvents()
	return
end

function FightBloodPoolTipView:_editableInitView()
	self.click = gohelper.findChildClickWithDefaultAudio(self.viewGO, "close_block")

	self.click:AddClickListener(self.closeThis, self)
end

function FightBloodPoolTipView:onOpen()
	self._txttitle.text = lua_fight_xcjl_const.configDict[6].value2

	local desc = lua_fight_xcjl_const.configDict[7].value2
	local bloodSkillId = FightHelper.getBloodPoolSkillId()
	local skillCo = lua_skill.configDict[bloodSkillId]
	local name = string.format("【%s】", skillCo.name)

	desc = GameUtil.getSubPlaceholderLuaLangTwoParam(desc, lua_fight_xcjl_const.configDict[3].value, name)

	local skillDesc = FightConfig.instance:getSkillEffectDesc(nil, skillCo)

	self._txtdesc.text = string.format("%s\n\n%s:%s", desc, name, skillDesc)
end

function FightBloodPoolTipView:onDestroyView()
	if self.click then
		self.click:RemoveClickListener()

		self.click = nil
	end
end

return FightBloodPoolTipView
