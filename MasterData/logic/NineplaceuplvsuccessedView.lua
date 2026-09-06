-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplaceuplvsuccessedView.lua

module("logic.extensions.nineplace.view.NineplaceuplvsuccessedView", package.seeall)

local NineplaceuplvsuccessedView = class("NineplaceuplvsuccessedView", ViewComponent)

function NineplaceuplvsuccessedView:ctor()
	NineplaceuplvsuccessedView.super.ctor(self)
end

function NineplaceuplvsuccessedView:buildUI()
	NineplaceuplvsuccessedView.super.buildUI(self)

	self.bgBtn = self:getBtn("bg")
	self.preLvText = goutil.findChildTextComponent(self.mainGO, "formationPre/lv/txt")
	self.preIcon = self:getGo("formationPre/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self.preNameText = goutil.findChildTextComponent(self.mainGO, "formationPre/txtName")
	self.nowLvText = goutil.findChildTextComponent(self.mainGO, "formationAfter/lv/txt")
	self.nowIcon = self:getGo("formationAfter/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self.nowNameText = goutil.findChildTextComponent(self.mainGO, "formationAfter/txtName")
	self._active = self:getGo("attrCon/active/Attrs")
	self._activeAttrs = {}

	for i = 1, 2 do
		local attr = {}
		local go = goutil.findChild(self._active, "attr" .. i)

		attr.go = go
		attr.txtName = goutil.findChildTextComponent(go, "txtName")
		attr.txtPerValue = goutil.findChildTextComponent(go, "txtPerValue")
		attr.txtAfterValue = goutil.findChildTextComponent(go, "txtAfterValue")
		self._activeAttrs[i] = attr
	end

	self._entire = self:getGo("attrCon/entire/Attrs")
	self._entireAttrs = {}

	for i = 1, 2 do
		local attr = {}
		local go = goutil.findChild(self._entire, "attr" .. i)

		attr.go = go
		attr.txtName = goutil.findChildTextComponent(go, "txtName")
		attr.txtPerValue = goutil.findChildTextComponent(go, "txtPerValue")
		attr.txtAfterValue = goutil.findChildTextComponent(go, "txtAfterValue")
		self._entireAttrs[i] = attr
	end
end

function NineplaceuplvsuccessedView:bindEvents()
	NineplaceuplvsuccessedView.super.bindEvents(self)
	self.bgBtn:AddClickListener(self.close, self)
end

function NineplaceuplvsuccessedView:unbindEvents()
	NineplaceuplvsuccessedView.super.unbindEvents(self)
	self.bgBtn:RemoveClickListener()
end

local effPaths = {
	{
		loop = false,
		goPath = "eff1",
		path = "fx_ui_tishengchenggong/fx_ui_tishengchenggong.prefab"
	},
	{
		loop = true,
		goPath = "eff2",
		path = "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab"
	}
}

function NineplaceuplvsuccessedView:destroyUI()
	NineplaceuplvsuccessedView.super.destroyUI(self)
end

function NineplaceuplvsuccessedView:onEnter()
	NineplaceuplvsuccessedView.super.onEnter(self)
	self:initView()

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)
end

function NineplaceuplvsuccessedView:onEnterFinished()
	NineplaceuplvsuccessedView.super.onEnterFinished(self)
end

function NineplaceuplvsuccessedView:onExit()
	NineplaceuplvsuccessedView.super.onExit(self)

	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	self._effs = nil
end

function NineplaceuplvsuccessedView:onExitFinished()
	NineplaceuplvsuccessedView.super.onExitFinished(self)
end

function NineplaceuplvsuccessedView:initView()
	local info = self:getFirstParam()

	if info then
		local cfg = NinePlaceConfig.instance:getStageCfgById(info.formStrengthId)

		self.preNameText.text = cfg.name
		self.nowNameText.text = cfg.name
		self.preLvText.text = lang(info.formStrengthLv - 1 .. "级")
		self.nowLvText.text = lang(info.formStrengthLv .. "级")

		self.nowIcon:SetState(info.formStrengthId - 1)
		self.preIcon:SetState(info.formStrengthId - 1)
		self:setArrt(info)
	end
end

function NineplaceuplvsuccessedView:setArrt(info)
	local perLvCfg = BattleConfig.instance:getFormStrengthLvCfg(info.formStrengthId, info.formStrengthLv - 1)
	local nowLvCfg = BattleConfig.instance:getFormStrengthLvCfg(info.formStrengthId, info.formStrengthLv)
	local dataList = self:_dealAttrStr(perLvCfg.properties)
	local dataListAfter = self:_dealAttrStr(nowLvCfg.properties)

	for i = 1, 2 do
		goutil.setActive(self._activeAttrs[i].go, dataList[i])

		if dataList[i] then
			local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

			self._activeAttrs[i].txtName.text = name
			self._activeAttrs[i].txtPerValue.text = value
			name, value = GameUtil.getPropertyInfo(dataListAfter[i].key, dataListAfter[i].value)
			self._activeAttrs[i].txtAfterValue.text = value
		end
	end

	dataList = self:_dealAttrStr(perLvCfg.passiveProperties)
	dataListAfter = self:_dealAttrStr(nowLvCfg.passiveProperties)

	for i = 1, 2 do
		goutil.setActive(self._entireAttrs[i].go, dataList[i])

		if dataList[i] then
			local name, value = GameUtil.getPropertyInfo(dataList[i].key, dataList[i].value)

			self._entireAttrs[i].txtName.text = name
			self._entireAttrs[i].txtPerValue.text = value
			name, value = GameUtil.getPropertyInfo(dataListAfter[i].key, dataListAfter[i].value)
			self._entireAttrs[i].txtAfterValue.text = value
		end
	end
end

function NineplaceuplvsuccessedView:_dealAttrStr(str)
	local data = {}
	local attrList = FightingPowerFormula.instance:parseAttrValues(str)

	for k, value in pairs(attrList) do
		local attr = {}

		attr.key = k
		attr.value = value

		table.insert(data, attr)
	end

	return data
end

return NineplaceuplvsuccessedView
