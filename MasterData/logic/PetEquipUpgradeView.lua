-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipUpgradeView.lua

module("logic.extensions.equipment.view.PetEquipUpgradeView", package.seeall)

local PetEquipUpgradeView = class("PetEquipUpgradeView", ViewComponent)

function PetEquipUpgradeView:ctor()
	PetEquipUpgradeView.super.ctor(self)

	self.itemStarList = nil
	self.effList = nil
	self.isClose = false
end

function PetEquipUpgradeView:onExitFinished()
	PetEquipUpgradeView.super.onExitFinished(self)
end

function PetEquipUpgradeView:onEnterFinished()
	PetEquipUpgradeView.super.onEnterFinished(self)
end

function PetEquipUpgradeView:buildUI()
	PetEquipUpgradeView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBoxGo")
	self.equipItemGo = self:getGo("equipItemGo")
	self.equipNameTxt = self:getGo("equipNameTxt"):GetComponent(typeof(UnityEngine.UI.Text))
	self.starAllTran = self:getGo("starAllTran").transform
	self.point_bg = self:getGo("point_bg")
	self.point_qhcg = self:getGo("point_qianghuachenggong")
	self.djkbjxSptGo = self:getGo("djkbjxSptGo")

	self.djkbjxSptGo:SetActive(false)

	if self.itemStarList == nil or #self.itemStarList == 0 then
		self.itemStarList = {}

		for i = 1, self.starAllTran.childCount do
			local go = self.starAllTran:GetChild(i - 1).gameObject
			local names = string.split(go.name, "_")

			self.itemStarList[tonumber(names[2])] = go
		end
	end
end

function PetEquipUpgradeView:bindEvents()
	PetEquipUpgradeView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):AddClickListener(function()
		if self.isClose then
			self:close()
		end
	end, self)
end

function PetEquipUpgradeView:onEnter()
	local param = self._viewPresentor._openParam

	if param == nil or param[1] == nil then
		self:close()

		return
	end

	local effPathCG = "fx_ui_qianghuachenggong/fx_ui_qianghuachenggong.prefab"

	self.cgEff = UIEffectManager.instance:playHUDEffect(effPathCG, self.point_qhcg)

	local effPathBG = "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab"

	self.bgEff = UIEffectManager.instance:playHUDEffect(effPathBG, self.point_bg)

	local infoMo = param[1]

	self.nowLevel = infoMo.starCount
	self.index = 0

	local showCount = PetEquipModel.instance:GetInfoMoMaxLevel(infoMo.onlyId, infoMo.matType)

	if infoMo.matType == MatType.Decoration then
		if self.nowLevel > 12 then
			showCount = 3
			self.nowLevel = self.nowLevel - 12
		elseif self.nowLevel > 6 and self.nowLevel <= 12 then
			showCount = 6
			self.nowLevel = self.nowLevel - 6
		else
			showCount = 6
		end
	end

	if self.itemStarList and #self.itemStarList > 0 then
		for i = 1, #self.itemStarList do
			if self.itemStarList[i] then
				self.itemStarList[i].gameObject:SetActive(i <= showCount)
			end
		end
	end

	local subLua = MaterialMgr.setCellByData(infoMo.matType, infoMo, self.equipItemGo)

	subLua:setAutoTips(false)

	self.equipNameTxt.text = infoMo.name
	self.effList = {}

	self:PlayStarEffect()
end

function PetEquipUpgradeView:PlayStarEffect()
	self.index = self.index + 1

	if self.index > self.nowLevel then
		self.djkbjxSptGo:SetActive(true)

		self.isClose = true
	end

	if self.index <= self.nowLevel then
		local effPath = "fx_ui_shengxingchenggong_02/fx_ui_shengxing01_huang.prefab"
		local starEff = UIEffectManager.instance:playHUDEffect(effPath, self.itemStarList[self.index].gameObject, true, nil, nil, function(finishHandlerTarget, eff)
			GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self.itemStarList[self.index].gameObject) + 1)
			Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
			Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		end, nil, false)

		table.insert(self.effList, starEff)
		settimer(0.1, self.PlayStarEffect, self, false)
	end
end

function PetEquipUpgradeView:unbindEvents()
	PetEquipUpgradeView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
end

function PetEquipUpgradeView:onExit()
	removetimer(self.PlayStarEffect, self)

	if self.cgEff then
		UIEffectManager.instance:stopEffect(self.cgEff)

		self.cgEff = nil
	end

	if self.bgEff then
		UIEffectManager.instance:stopEffect(self.bgEff)

		self.bgEff = nil
	end

	for _, eff in pairs(self.effList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	self.effList = nil
end

function PetEquipUpgradeView:destroyUI()
	PetEquipUpgradeView.super.destroyUI(self)

	self.itemStarList = nil

	if self.cgEff then
		UIEffectManager.instance:stopEffect(self.cgEff)

		self.cgEff = nil
	end

	if self.bgEff then
		UIEffectManager.instance:stopEffect(self.bgEff)

		self.bgEff = nil
	end

	if self.effList == nil then
		return
	end

	for _, eff in pairs(self.effList or {}) do
		if eff then
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	self.effList = nil
end

return PetEquipUpgradeView
