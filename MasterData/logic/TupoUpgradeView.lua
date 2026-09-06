-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/TupoUpgradeView.lua

module("logic.extensions.equipment.view.TupoUpgradeView", package.seeall)

local TupoUpgradeView = class("TupoUpgradeView", ViewComponent)

function TupoUpgradeView:ctor()
	TupoUpgradeView.super.ctor(self)

	self._leftItemGo = nil
	self._rightItemGo = nil
	self._leftInfoMo = nil
	self._rightInfoMo = nil
end

function TupoUpgradeView:bindEvents()
	TupoUpgradeView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):AddClickListener(self.close, self)
end

function TupoUpgradeView:unbindEvents()
	TupoUpgradeView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
end

function TupoUpgradeView:buildUI()
	TupoUpgradeView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBoxGo")

	local leftEquipPos = self:getGo("leftEquipPos")

	self._leftItemGo = {
		equipPos = goutil.findChild(leftEquipPos, "equipPos"),
		nameTxt = goutil.findChildTextComponent(leftEquipPos, "nameTxt")
	}

	local rightEquipPos = self:getGo("rightEquipPos")

	self._rightItemGo = {
		equipPos = goutil.findChild(rightEquipPos, "equipPos"),
		nameTxt = goutil.findChildTextComponent(rightEquipPos, "nameTxt")
	}
	self.point_bg = self:getGo("point_bg")
	self.point_qhcg = self:getGo("point_qianghuachenggong")
end

function TupoUpgradeView:onEnter()
	TupoUpgradeView.super.onEnter(self)

	local param = self._viewPresentor._openParam

	if param[1] == nil or param[2] == nil then
		printError("sr--- TupoUpgradeView:onEnter()   装备突破参数不对！")

		return
	end

	self._leftInfoMo = param[1]
	self._rightInfoMo = param[2]

	MaterialMgr.resetAll(self._leftItemGo.equipPos)

	self._leftItemGo.nameTxt.text = self._leftInfoMo.name

	local leftLua = MaterialMgr.setCellByData(self._leftInfoMo.matType, self._leftInfoMo, self._leftItemGo.equipPos)

	leftLua.binder:setAutoTips(true)
	MaterialMgr.resetAll(self._rightItemGo.equipPos)

	self._rightItemGo.nameTxt.text = self._rightInfoMo.name

	local rightLua = MaterialMgr.setCellByData(self._rightInfoMo.matType, self._rightInfoMo, self._rightItemGo.equipPos)

	rightLua.binder:setAutoTips(true)

	local effPathCG = "fx_ui_qianghuachenggong/fx_ui_qianghuachenggong.prefab"

	self.cgEff = UIEffectManager.instance:playHUDEffect(effPathCG, self.point_qhcg)

	local effPathBG = "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab"

	self.bgEff = UIEffectManager.instance:playHUDEffect(effPathBG, self.point_bg)
end

function TupoUpgradeView:onExit()
	TupoUpgradeView.super.onExit(self)

	if self.cgEff then
		UIEffectManager.instance:stopEffect(self.cgEff)

		self.cgEff = nil
	end

	if self.bgEff then
		UIEffectManager.instance:stopEffect(self.bgEff)

		self.bgEff = nil
	end
end

function TupoUpgradeView:destroyUI()
	TupoUpgradeView.super.destroyUI(self)

	self._leftItemGo = nil
	self._rightItemGo = nil
	self._leftInfoMo = nil
	self._rightInfoMo = nil
end

return TupoUpgradeView
