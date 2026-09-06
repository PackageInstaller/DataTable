-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/waterdraktower/view/formation/WLTowerFmtRightView.lua

module("logic.extensions.waterdraktower.view.formation.WLTowerFmtRightView", package.seeall)

local WLTowerFmtRightView = class("WLTowerFmtRightView", FormationRightView)

function WLTowerFmtRightView:_getCurFormation()
	return WaterdraktowerModel.instance:getCurFormation()
end

function WLTowerFmtRightView:_setJobLabelStr()
	self._jobLabelStr = nil

	local params = self:getFirstParam()

	if params == nil or params.formCondition <= 0 then
		return
	end

	local cfg = FormationValidatorConfig.instance:getFormationValidatorCfg(params.formCondition)

	if cfg == nil or string.nilorempty(cfg.desc) then
		return
	end

	self._jobLabelStr = cfg.desc
end

function WLTowerFmtRightView:setCurViewDatas()
	local params = self:getFirstParam()

	if params == nil or params.formCondition <= 0 then
		WLTowerFmtRightView.super.setCurViewDatas(self)

		return
	end

	local label = FormationValidatorController.instance:getAllLabelByConditionId(params.formCondition)

	if string.nilorempty(label) then
		WLTowerFmtRightView.super.setCurViewDatas(self)

		return
	end

	local attList = string.split(label, ",")

	if attList == nil or #attList == 0 then
		WLTowerFmtRightView.super.setCurViewDatas(self)

		return
	end

	self._curViewDatas = {}

	local pets = self:getAllShowPetList()

	for _, petMo in pairs(pets) do
		self._curPetMap[petMo.petId] = petMo

		if self:onFilter(petMo) and self:_isAccordHasRace(petMo, attList) then
			self._curViewDatas[#self._curViewDatas + 1] = petMo
		end
	end
end

function WLTowerFmtRightView:_isAccordHasRace(petMo, attList)
	if petMo == nil then
		return false
	end

	if attList == nil then
		return true
	end

	for _, att in pairs(attList) do
		if not string.nilorempty(att) and petMo:checkHasRace(att) then
			return true
		end
	end

	return false
end

return WLTowerFmtRightView
