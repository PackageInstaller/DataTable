-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetDectnUpgradeView.lua

module("logic.extensions.equipment.view.PetDectnUpgradeView", package.seeall)

local PetDectnUpgradeView = class("PetDectnUpgradeView", ViewComponent)

function PetDectnUpgradeView:ctor()
	PetDectnUpgradeView.super.ctor(self)

	self.attrDectList = nil
end

function PetDectnUpgradeView:onExitFinished()
	PetDectnUpgradeView.super.onExitFinished(self)
end

function PetDectnUpgradeView:onEnterFinished()
	PetDectnUpgradeView.super.onEnterFinished(self)
end

function PetDectnUpgradeView:buildUI()
	PetDectnUpgradeView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBoxGo")
	self.titleImaGo = self:getGo("titleImaGo")
	self.dectGoL = self:getGo("dectGoL")
	self.dectGoR = self:getGo("dectGoR")
	self.attrItemGo = self:getGo("attrItem")
	self.attrGroupTran = self:getGo("attrGroup").transform

	self.attrItemGo:SetActive(false)
end

function PetDectnUpgradeView:bindEvents()
	PetDectnUpgradeView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):AddClickListener(self.close, self)
end

function PetDectnUpgradeView:onEnter()
	if self._viewPresentor._openParam then
		if not self._viewPresentor._openParam[1] then
			local lastInfoMo

			if lastInfoMo == nil or checknumber(lastInfoMo.onlyId) < 1 then
				printError("sr---- PetDectnUpgradeView:onEnter()    饰品强化成功传入参数错误！！！")
				self:close()

				return
			end

			local effPathCG = "fx_ui_qianghuachenggong/fx_ui_qianghuachenggong.prefab"

			self.cgEff = UIEffectManager.instance:playHUDEffect(effPathCG, self.titleImaGo)

			local effPathBG = "fx_ui_huodejiangli/fx_ui_huodejiangli_bg.prefab"

			self.bgEff = UIEffectManager.instance:playHUDEffect(effPathBG, self.mainGO)

			local nowInfoMo = PetEquipModel.instance:GetDecorationInfoByOnlyId(lastInfoMo.onlyId)

			if nowInfoMo == nil or nowInfoMo.addAttrs == nil or lastInfoMo.starCount >= nowInfoMo.starCount then
				printError("sr---- PetDectnUpgradeView:onEnter()    饰品强化的前后星级一样！！！")

				return
			end

			local subLuaL = MaterialMgr.setCellByData(lastInfoMo.matType, lastInfoMo, self.dectGoL)

			subLuaL:setAutoTips(false)

			local subLuaR = MaterialMgr.setCellByData(nowInfoMo.matType, nowInfoMo, self.dectGoR)

			subLuaR:setAutoTips(false)

			local attrList = nowInfoMo.addAttrs

			if self.attrDectList and #self.attrDectList > #attrList then
				for i = #attrList + 1, #self.attrDectList do
					if self.attrDectList[i].itemGo and self.attrDectList[i].itemGo.activeSelf then
						self.attrDectList[i].itemGo:SetActive(false)
					end
				end
			end

			self.attrDectList = self.attrDectList or {}

			for i = 1, #attrList do
				if self.attrDectList[i] == nil then
					self.attrDectList[i] = {}

					local attrGo = UnityEngine.GameObject.Instantiate(self.attrItemGo, self.attrGroupTran)

					self.attrDectList[i].itemGo = attrGo
					self.attrDectList[i].itemIma = attrGo:GetComponent("UIImageColorChange")
					self.attrDectList[i].newGo = goutil.findChild(attrGo, "newGo")
					self.attrDectList[i].iconSpt = goutil.findChildComponent(attrGo, "iconSpt", "UIImageSpriteChange")
					self.attrDectList[i].arrowGo = goutil.findChild(attrGo, "arrowGo")
					self.attrDectList[i].nameTxt = goutil.findChildTextComponent(attrGo, "nameTxt")
					self.attrDectList[i].lastCountTxt = goutil.findChildTextComponent(attrGo, "lastCountTxt")
					self.attrDectList[i].newCountTxt = goutil.findChildTextComponent(attrGo, "newCountTxt")
				end

				if attrList[i] == nil then
					self.attrDectList[i].itemGo:SetActive(false)

					return
				end

				self.attrDectList[i].itemGo:SetActive(true)
				self.attrDectList[i].itemIma:SetState(i - math.floor(i / 2) * 2)

				local isNew = lastInfoMo.addAttrs[i] == nil

				self.attrDectList[i].newGo:SetActive(isNew)

				local name = GameEnum.AttrTypeName[attrList[i].proertyType]
				local index = PetEquipModel.instance:GetChineseAttrIndex(name)

				self.attrDectList[i].iconSpt:SetState(index - 1)

				self.attrDectList[i].nameTxt.text = name

				local isHaveLv = string.find(name, lang("text_equip_lv"))

				if i == 1 then
					local value = lastInfoMo.addAttrs[1].value

					if isHaveLv then
						local str = string.format("%.2f", value)

						self.attrDectList[i].lastCountTxt.text = checknumber(str) * 100 .. "%"
					else
						self.attrDectList[i].lastCountTxt.text = tostring(value)
					end

					self.attrDectList[i].arrowGo:SetActive(true)

					value = attrList[1].value

					if isHaveLv then
						local str = string.format("%.2f", value)

						self.attrDectList[i].newCountTxt.text = checknumber(str) * 100 .. "%"
					else
						self.attrDectList[i].newCountTxt.text = tostring(value)
					end
				else
					self.attrDectList[i].newCountTxt.text = ""

					self.attrDectList[i].arrowGo:SetActive(false)

					local value = attrList[i].value

					if isHaveLv then
						local str = string.format("%.2f", value)

						self.attrDectList[i].lastCountTxt.text = checknumber(str) * 100 .. "%"
					else
						self.attrDectList[i].lastCountTxt.text = tostring(value)
					end
				end
			end
		end
	end
end

function PetDectnUpgradeView:unbindEvents()
	PetDectnUpgradeView.super.unbindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
end

function PetDectnUpgradeView:onExit()
	PetDectnUpgradeView.super.onExit(self)
end

function PetDectnUpgradeView:destroyUI()
	PetDectnUpgradeView.super.destroyUI(self)

	self.itemStarList = nil

	if self.cgEff then
		UIEffectManager.instance:stopEffect(self.cgEff)

		self.cgEff = nil
	end

	if self.bgEff then
		UIEffectManager.instance:stopEffect(self.bgEff)

		self.bgEff = nil
	end

	for _, item in pairs(self.attrDectList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.attrDectList = nil
end

return PetDectnUpgradeView
