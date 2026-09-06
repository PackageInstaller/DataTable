-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetTalentLvupView.lua

module("logic.extensions.bag.view.stack.PetTalentLvupView", package.seeall)

local PetTalentLvupView = class("PetTalentLvupView", ViewComponent)

function PetTalentLvupView:ctor()
	PetTalentLvupView.super.ctor(self)
end

function PetTalentLvupView:destroyUI()
	PetTalentLvupView.super.destroyUI(self)
end

function PetTalentLvupView:onExitFinished()
	PetTalentLvupView.super.onExitFinished(self)
end

function PetTalentLvupView:onEnterFinished()
	PetTalentLvupView.super.onEnterFinished(self)
	PetCvController.instance:playPetCv(self._mo.curFaceId, GameEnum.PetCvType.PetUp)
end

function PetTalentLvupView:unbindEvents()
	PetTalentLvupView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PetTalentLvupView:bindEvents()
	PetTalentLvupView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function PetTalentLvupView:onExit()
	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	self._effs = nil

	PetTalentLvupView.super.onExit(self)
	PetCvController.instance:turnOffCurCv()
end

function PetTalentLvupView:_onClickClose()
	self:close()

	if MaterialModel.instance:getMaterialsNumber(4, 2) == 0 and MaterialModel.instance:getMaterialsNumber(4, 3) == 0 and MaterialModel.instance:getMaterialsNumber(4, 25) == 0 then
		return
	end

	GlobalDispatcher:dispatch(GlobalNotify.OpenLevelUpView)
end

function PetTalentLvupView:buildUI()
	PetTalentLvupView.super.buildUI(self)

	self._txtLeftLv = goutil.findChildTextComponent(self.mainGO, "txt_left_lv")
	self._txtRightLv = goutil.findChildTextComponent(self.mainGO, "txt_right_lv")
	self._txtLeftPower = goutil.findChildTextComponent(self.mainGO, "Power/txt_left_lv")
	self._txtRightPower = goutil.findChildTextComponent(self.mainGO, "Power/txt_right_lv")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txt_description")
	self._btnClose = self:getBtn("bg")
	self._txtSkillDes = goutil.findChildTextComponent(self.mainGO, "skillDes")
	self._txtSkill = goutil.findChildTextComponent(self.mainGO, "txtskill")
	self._skillIcon = self:getGo("skillicon")
	self._lvlimit = self:getGo("lvlimit")
	self._txtLeftLvLimit = goutil.findChildTextComponent(self._lvlimit, "txt_left_lv")
	self._txtRightLvLimit = goutil.findChildTextComponent(self._lvlimit, "txt_right_lv")
end

local effPaths = {
	{
		loop = true,
		goPath = "point_tishengchenggong",
		path = "fx_ui_tishengchenggong/fx_ui_tishengchenggong.prefab"
	},
	{
		loop = true,
		goPath = "point_bg",
		path = "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab"
	}
}

function PetTalentLvupView:onEnter()
	PetTalentLvupView.super.onEnter(self)

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local params = self:getOpenParam()

	self._mo = params[1]
	self._preMo = params[2]

	local talentLevel = self._mo.talentLevel
	local cfg = CharacterConfig.instance:getPetTalentCfg(self._mo.raceId, talentLevel)

	self._txtLeftLv.text = CharacterConfig.instance:getTalentName(self._mo.raceId, talentLevel - 1)
	self._txtRightLv.text = CharacterConfig.instance:getTalentName(self._mo.raceId, talentLevel)

	local t = CharacterConfig.instance:getPetTalentSkillAdd(self._mo.raceId, talentLevel, self._mo.curFaceId)

	self._txtSkill.text = ""
	self._txtSkillDes.text = ""

	for skillId, mo in pairs(t) do
		self._txtSkill.text = mo.title
		self._txtSkillDes.text = mo.desc

		MaterialMgr.setSkillByFaceId(skillId, self._mo.curFaceId, self._skillIcon)
	end

	self._txtLeftPower.text = self._preMo:getFightingPower()
	self._txtRightPower.text = self._mo:getFightingPower()

	local preMaxLv = CharacterConfig.instance:getMaxLvByTalentLv(talentLevel - 1)
	local maxLv = CharacterConfig.instance:getMaxLvByTalentLv(talentLevel)

	self._txtLeftLvLimit.text = preMaxLv
	self._txtRightLvLimit.text = maxLv

	goutil.setActive(self._lvlimit, preMaxLv ~= maxLv)
end

return PetTalentLvupView
