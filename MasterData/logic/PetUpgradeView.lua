-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petupgrade/view/PetUpgradeView.lua

module("logic.extensions.petupgrade.view.PetUpgradeView", package.seeall)

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
	[GameEnum.AttrType.AntiCriticalRate] = "_antiCriticalRate",
	[GameEnum.AttrType.OriginalVigour] = "_originalVigourRate"
}
local PetUpgradeView = class("PetUpgradeView", ViewComponent)

function PetUpgradeView:ctor()
	PetUpgradeView.super.ctor(self)
end

function PetUpgradeView:bindEvents()
	return
end

function PetUpgradeView:unbindEvents()
	return
end

function PetUpgradeView:buildUI()
	self._AttrTxt = self:getGo("Info/AttrTxt"):GetComponent("Text")
	self._AttrTxtOld = self:getGo("Info/AttrTxtOld"):GetComponent("Text")
	self._Txt_oldLevel = self:getGo("Info/Txt_oldLevel"):GetComponent("Text")
	self._Txt_newLevel = self:getGo("Info/Txt_newLevel"):GetComponent("Text")
	self._attrsLayout = self:getGo("Info/attrsLayout"):GetComponent("UILayoutSingleLine")
	self._attrs = GameUtil.getChildren(self._attrsLayout.gameObject)
end

function PetUpgradeView:destroyUI()
	return
end

local effPaths = {
	{
		loop = false,
		goPath = "point_1",
		path = "fx_ui_dengjitisheng/fx_ui_dengjitisheng_saoguang.prefab"
	},
	{
		loop = false,
		goPath = "point_2",
		path = "fx_ui_tianfutisheng/fx_ui_tisheng.prefab"
	},
	{
		loop = false,
		goPath = "point_3",
		path = "fx_ui_tianfutisheng/fx_ui_tisheng.prefab"
	},
	{
		loop = false,
		goPath = "point_4",
		path = "fx_ui_dengjitisheng/fx_ui_dengjitisheng_chixu.prefab"
	}
}

function PetUpgradeView:onEnter()
	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local pets = self:getOpenParam()

	self._oldPet = pets[2]
	self._newPet = pets[1]
	self._Txt_oldLevel.text = string.format("Lv.%s", self._oldPet.level)
	self._Txt_newLevel.text = string.format("Lv.%s", self._newPet.level)
	self._AttrTxtOld.text = self._oldPet:getFightingPower()
	self._AttrTxt.text = self._oldPet:getFightingPower()

	local list = {}

	table.insert(list, GameEnum.AttrType.Attack)
	table.insert(list, GameEnum.AttrType.DefensePhysical)
	table.insert(list, GameEnum.AttrType.DefenseMagic)
	table.insert(list, GameEnum.AttrType.Hp)
	table.insert(list, GameEnum.AttrType.Speed)
	self:_addAttrToList(list, GameEnum.AttrType.HitRate)
	self:_addAttrToList(list, GameEnum.AttrType.DodgeRate)
	self:_addAttrToList(list, GameEnum.AttrType.StrikeRate)
	self:_addAttrToList(list, GameEnum.AttrType.BlockRate)
	self:_addAttrToList(list, GameEnum.AttrType.CriticalRate)
	self:_addAttrToList(list, GameEnum.AttrType.AntiCriticalRate)
	self:_addAttrToList(list, GameEnum.AttrType.OriginalVigour)

	self._list = list

	self:setAttrs(list)
	TaskController.instance:pause()
	TweenUtil.ValueTo(self._oldPet:getFightingPower(), self._newPet:getFightingPower(), 1, function(value)
		self._AttrTxt.text = math.floor(value)
	end, nil, self)
	settimer(0.09, self._startPlayAttrEffs, self, false)
	AudioPlayerEx.instance:playEffect(30223)
end

function PetUpgradeView:_addAttrToList(list, attr)
	local attrField = AttrName[attr]

	if self._oldPet[attrField] < self._newPet[attrField] then
		table.insert(list, attr)
	end
end

function PetUpgradeView:_startPlayAttrEffs()
	removetimer(self._startPlayAttrEffs, self)

	self._curShowIdx = 1

	settimer(0.02, self._playAttrEff, self, true)
end

function PetUpgradeView:_playAttrEff()
	if self._curShowIdx <= #self._list then
		print("play attr effect")

		local url = "fx_ui_dengjitisheng/fx_ui_tisheng_dengjitisheng.prefab"
		local parent = goutil.findChild(self._attrs[self._curShowIdx], "effPoint")
		local eff = UIEffectManager.instance:playEffect(self, url, parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setLocalEulerAngle(0, 0, 0)

		self._curShowIdx = self._curShowIdx + 1
	else
		removetimer(self._playAttrEff, self)
	end
end

function PetUpgradeView:onEnterFinished()
	return
end

function PetUpgradeView:setAttrs(list)
	for _, v in ipairs(self._attrs) do
		goutil.setActive(v, false)
	end

	for i = 1, #list do
		local attrType = list[i]
		local attrField = AttrName[attrType]
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

		txtBefore.text = GameUtil.GetPropertyValue(attrType, self._oldPet[attrField])
		txtAfter.text = GameUtil.GetPropertyValue(attrType, self._newPet[attrField])
		txtName.text = ConstString.Attr[attrType]
	end

	self._attrsLayout:Layout()
end

function PetUpgradeView:onExit()
	removetimer(self._startPlayAttrEffs, self)
	removetimer(self._playAttrEff, self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = nil

	TaskController.instance:resume()
	GlobalDispatcher:dispatch(GlobalNotify.OpenLevelUpView)
end

function PetUpgradeView:onExitFinished()
	return
end

return PetUpgradeView
