-- chunkname: @modules/logic/gm/view/GMFightEntitySkillItem.lua

module("modules.logic.gm.view.GMFightEntitySkillItem", package.seeall)

local GMFightEntitySkillItem = class("GMFightEntitySkillItem", ListScrollCell)

function GMFightEntitySkillItem:init(go)
	self._go = go
	self._id = gohelper.findChildTextMeshInputField(go, "id")
	self._name = gohelper.findChildTextMeshInputField(go, "name")
	self._level = gohelper.findChildText(go, "level")
	self._effect = gohelper.findChildTextMeshInputField(go, "effect")
	self._type = gohelper.findChildTextMeshInputField(go, "type")
	self._btnDel = gohelper.findChildButtonWithAudio(go, "btnDel")
end

function GMFightEntitySkillItem:addEventListeners()
	self._btnDel:AddClickListener(self._onClickDel, self)
end

function GMFightEntitySkillItem:removeEventListeners()
	self._btnDel:RemoveClickListener()
end

local EffectTagDesc = {
	"现实创伤",
	"精神创伤",
	"减益",
	"增益",
	"反制",
	"治疗"
}

function GMFightEntitySkillItem:onUpdateMO(mo)
	self._skillCO = mo

	local entityMO = GMFightEntityModel.instance.entityMO

	gohelper.setActive(self._btnDel.gameObject, entityMO:isPassiveSkill(self._skillCO.id))
	self._id:SetText(tostring(self._skillCO.id))
	self._name:SetText(self._skillCO.name)

	self._level.text = entityMO:isPassiveSkill(self._skillCO.id) and "被动" or FightCardDataHelper.isBigSkill(self._skillCO.id) and "大招" or entityMO:getSkillLv(self._skillCO.id)

	self._effect:SetText(tostring(self._skillCO.skillEffect))

	if not EffectTagDesc[self._skillCO.effectTag] then
		self._type:SetText(EffectTagDesc[self._skillCO.effectTag])
	end
end

function GMFightEntitySkillItem:_onClickDel()
	GameFacade.showToast(ToastEnum.IconId, "del skill " .. self._skillCO.name)

	local entityMO = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightDelPassiveSkill %s %s", tostring(entityMO.id), tostring(self._skillCO.id)))
	entityMO:removePassiveSkill(self._skillCO.id)
	GMFightEntityModel.instance:setEntityMO(entityMO)
end

return GMFightEntitySkillItem
