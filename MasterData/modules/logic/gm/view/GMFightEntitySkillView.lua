-- chunkname: @modules/logic/gm/view/GMFightEntitySkillView.lua

module("modules.logic.gm.view.GMFightEntitySkillView", package.seeall)

local GMFightEntitySkillView = class("GMFightEntitySkillView", BaseView)

function GMFightEntitySkillView:onInitView()
	self._input = gohelper.findChildTextMeshInputField(self.viewGO, "skill/add/input")
	self._btnAdd = gohelper.findChildButton(self.viewGO, "skill/add/btnAdd")
end

function GMFightEntitySkillView:addEvents()
	self._btnAdd:AddClickListener(self._onClickAddSkill, self)
end

function GMFightEntitySkillView:removeEvents()
	self._btnAdd:RemoveClickListener()
end

function GMFightEntitySkillView:_onClickAddSkill()
	local skillId = tonumber(self._input:GetText())
	local skillCO = lua_skill.configDict[skillId]
	local entityMO = GMFightEntityModel.instance.entityMO

	if tabletool.indexOf(entityMO.skillList, skillId) then
		GameFacade.showToast(ToastEnum.IconId, "skill has exist")
	elseif skillCO then
		GMRpc.instance:sendGMRequest(string.format("fightAddPassiveSkill %s %s", tostring(entityMO.id), tostring(skillId)))
		entityMO:addPassiveSkill(skillId)
		GMFightEntityModel.instance:setEntityMO(entityMO)

		local localData = FightLocalDataMgr.instance.entityMgr:getById(entityMO.id)

		if localData then
			FightEntityDataHelper.copyEntityMO(entityMO, localData)
		end
	else
		GameFacade.showToast(ToastEnum.IconId, "skill not exist")
	end
end

return GMFightEntitySkillView
