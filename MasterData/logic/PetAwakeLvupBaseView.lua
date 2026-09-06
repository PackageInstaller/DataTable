-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/stack/PetAwakeLvupBaseView.lua

module("logic.extensions.bag.view.stack.PetAwakeLvupBaseView", package.seeall)

local PetAwakeLvupBaseView = class("PetAwakeLvupBaseView", ViewComponent)
local AttrName = {
	[GameEnum.AttrType.Attack] = "_attack",
	[GameEnum.AttrType.DefensePhysical] = "_physicalDefence",
	[GameEnum.AttrType.DefenseMagic] = "_magicDefence",
	[GameEnum.AttrType.Hp] = "_maxHp",
	[GameEnum.AttrType.Speed] = "_speed",
	[GameEnum.AttrType.HitRate] = "_hitRate",
	[GameEnum.AttrType.DodgeRate] = "_dodgeRate",
	[GameEnum.AttrType.StrikeRate] = "_strikeRate",
	[GameEnum.AttrType.BlockRate] = "_blockRate",
	[GameEnum.AttrType.CriticalRate] = "_criticalRate",
	[GameEnum.AttrType.AntiCriticalRate] = "_antiCriticalRate"
}

function PetAwakeLvupBaseView:buildUI()
	self._skillUpBg = self:getGo("Bg/skillUpBg2")
	self._textList = GameUtil.getChildren(self._skillUpBg)
end

function PetAwakeLvupBaseView:_updateAttrs()
	local list = {}

	table.insert(list, -1)
	table.insert(list, GameEnum.AttrType.Attack)
	table.insert(list, GameEnum.AttrType.DefensePhysical)
	table.insert(list, GameEnum.AttrType.DefenseMagic)
	table.insert(list, GameEnum.AttrType.Hp)
	table.insert(list, GameEnum.AttrType.Speed)
	self:setAttrs(list)
end

function PetAwakeLvupBaseView:_updateSkillUp()
	goutil.setActive(self._skillUpBg, false)
end

function PetAwakeLvupBaseView:setAttrs(list)
	for _, v in ipairs(self._attrs) do
		goutil.setActive(v, false)
	end

	for i = 1, #list do
		local attrType = list[i]
		local go = self._attrs[i]

		if go == nil then
			local cloneGo = self._attrs[1]

			go = goutil.cloneAndSetParent(cloneGo, self._attrsLayout.transform, "attr" .. attrType)

			Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalRotation(go.transform, 0, 0, 0)
			table.insert(self._attrs, go)
		end

		goutil.setActive(go, true)

		local txtBefore = goutil.findChildTextComponent(go, "Txt_Upgrade/Txt_Before")
		local txtAfter = goutil.findChildTextComponent(go, "Txt_Upgrade/Txt_After")
		local txtName = goutil.findChildTextComponent(go, "TxtC_Name")
		local imgAttrColorChange = goutil.findChildComponent(go, "imgAttr", typeof(UIImageColorChange))
		local txtAttrColorChange = txtName:GetComponent(typeof(UITextColorChange))

		if attrType == -1 then
			txtBefore.text = self:getAwakenAllAttrAdd(self._preMo.awakenLv)
			txtAfter.text = self:getAwakenAllAttrAdd(self._mo.awakenLv)
			txtName.text = "全属性"

			imgAttrColorChange:SetState(1)
			txtAttrColorChange:SetState(1)
		else
			local attrField = AttrName[attrType]

			txtBefore.text = self._preMo[attrField]
			txtAfter.text = self._mo[attrField]
			txtName.text = ConstString.Attr[attrType]

			imgAttrColorChange:SetState(0)
			txtAttrColorChange:SetState(0)
		end
	end

	self._attrsLayout:Layout()
end

function PetAwakeLvupBaseView:getAwakenAllAttrAdd(awakenLv)
	local cfg = CharacterConfig.instance:getPetCo(self._mo.raceId)
	local rareCfg = CharacterConfig.instance:getAwakenRareCfg(awakenLv)
	local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(cfg.awakenCostStrategyId, awakenLv)

	return 100 + costCfg.allPropertyWanPercent / 100 .. "%"
end

return PetAwakeLvupBaseView
