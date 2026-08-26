-- chunkname: @modules/logic/sodache/view/inside/SodacheEvilUpView.lua

module("modules.logic.sodache.view.inside.SodacheEvilUpView", package.seeall)

local SodacheEvilUpView = class("SodacheEvilUpView", BaseView)

function SodacheEvilUpView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtLv = gohelper.findChildTextMesh(self.viewGO, "#go_evil/#txt_level")
	self._txteffect = gohelper.findChildTextMesh(self.viewGO, "#go_effectTips/#txt_effectTips")
end

function SodacheEvilUpView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function SodacheEvilUpView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SodacheEvilUpView:onOpen()
	self._txtLv.text = SodacheUtil.getAttr(SodacheEnum.AttrId.EvilValue)

	local skillIds = SodacheModel.instance:getInsideMo().prop.altarSkillIds
	local skillId = skillIds[#skillIds]
	local skillCo = lua_sodache_skill.configDict[skillId]

	if not skillCo then
		return
	end

	self._txteffect.text = skillCo.desc
end

function SodacheEvilUpView:onClickModalMask()
	self:closeThis()
end

return SodacheEvilUpView
