-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionFormationRightView.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionFormationRightView", package.seeall)

local ChuangkongunionFormationRightView = class("ChuangkongunionFormationRightView", FormationRightView)

function ChuangkongunionFormationRightView:setCurViewDatas()
	local openParam = self:getOpenParam()
	local stageCfg, _type = openParam[1], openParam[3]

	if _type then
		ChuangkongunionFormationRightView.super.setCurViewDatas(self)
	else
		self._curViewDatas = {}

		local pets = ChuangkongunionModel.instance:getAllHelpPets(stageCfg.petPlan)

		for k, v in pairs(pets) do
			self._curPetMap[v.petId] = v

			if self:onFilter(v) then
				self._curViewDatas[#self._curViewDatas + 1] = v
			end
		end
	end
end

function ChuangkongunionFormationRightView:_getCurFormation()
	local openParam = self:getOpenParam()
	local stageCfg, _type = openParam[1], openParam[3]

	if _type then
		return ChuangkongunionFormationRightView.super._getCurFormation(self)
	else
		return ChuangkongunionModel.instance:getFormation(stageCfg.teamId)
	end
end

return ChuangkongunionFormationRightView
