-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/view/PetEquipInfoView.lua

module("logic.extensions.equipment.view.PetEquipInfoView", package.seeall)

local PetEquipInfoView = class("PetEquipInfoView", ViewComponent)

function PetEquipInfoView:ctor()
	PetEquipInfoView.super.ctor(self)

	self.attrEquipList = nil
	self.attrDectList = nil
end

function PetEquipInfoView:onExit()
	return
end

function PetEquipInfoView:destroyUI()
	PetEquipInfoView.super.destroyUI(self)

	for _, item in pairs(self.attrEquipList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.attrEquipList = nil

	for _, item in pairs(self.attrDectList or {}) do
		if item and item.itemGo then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self.attrDectList = nil
end

function PetEquipInfoView:bindEvents()
	PetEquipInfoView.super.bindEvents(self)
	GameUtil.asBtn(self.viewBoxGo):AddClickListener(self.close, self)
end

function PetEquipInfoView:unbindEvents()
	PetEquipInfoView.super.unbindEvents(self)
	self.unloadBtn:RemoveClickListener()
	self._unloadShowBtn:RemoveClickListener()
	self.replaceBtn:RemoveClickListener()
	self.strengthenBtn:RemoveClickListener()
	self.tupoBtn:RemoveClickListener()
	GameUtil.asBtn(self.viewBoxGo):RemoveClickListener()
end

function PetEquipInfoView:buildUI()
	PetEquipInfoView.super.buildUI(self)

	self.viewBoxGo = self:getGo("viewBox")
	self.viewInfoGo = self:getGo("viewInfoGo")
	self.viewBgRect = goutil.findChildComponent(self.viewInfoGo, "viewBgRect", "RectTransform")
	self.quaChangSpt = goutil.findChildComponent(self.viewInfoGo, "quaChangSpt", "UIImageSpriteChange")
	self.equipNameTxt = goutil.findChildTextComponent(self.viewInfoGo, "equipNameTxt")
	self.equipItemGo = goutil.findChild(self.viewInfoGo, "equipItemGo")
	self.powerTxt = goutil.findChildTextComponent(self.viewInfoGo, "powerTxt")
	self.oppLimitTxt = goutil.findChildTextComponent(self.viewInfoGo, "oppLimitTxt")
	self.lvLimitTxt = goutil.findChildTextComponent(self.viewInfoGo, "lvLimitTxt")

	local btns = goutil.findChild(self.viewInfoGo, "btns")

	self.unloadBtn = Framework.ButtonAdapter.GetFrom(btns, "unloadBtn")
	self._unloadShowBtn = Framework.ButtonAdapter.GetFrom(self.viewInfoGo, "unloadShowBtn")
	self.replaceBtn = Framework.ButtonAdapter.GetFrom(btns, "replaceBtn")
	self.replaceTxt = self:getTxt("viewInfoGo/btns/replaceBtn/replaceTxt")
	self.strengthenBtn = Framework.ButtonAdapter.GetFrom(btns, "strengthenBtn")
	self.stRedPoint = goutil.findChild(btns, "strengthenBtn/stRedPoint")
	self.tupoBtn = Framework.ButtonAdapter.GetFrom(btns, "tupoBtn")

	GameUtil.SetActive(self.stRedPoint, false)
	GameUtil.SetActive(self.tupoBtn, false)

	self.equipShowGo = goutil.findChild(self.viewInfoGo, "scrollview/viewport/equipShowGo")
	self._equipShowGoRect = self.equipShowGo:GetComponent(goutil.Type_RectTransform)
	self.attrEquipItem = goutil.findChild(self.viewInfoGo, "attrEquipItem")
	self.attrEquipPos = goutil.findChild(self.equipShowGo, "attrEquipPos").transform
	self.attributesTxt = goutil.findChildTextComponent(self.equipShowGo, "attributesGo/attributesTxt")
	self.additionTxt = goutil.findChildTextComponent(self.equipShowGo, "additionGo/additionTxt")
	self.attrDesTxt = goutil.findChildTextComponent(self.equipShowGo, "attrDesTxt")
	self.exclbgGo = goutil.findChild(self.equipShowGo, "exclbgGo")
	self.exclDesTxt = goutil.findChildTextComponent(self.exclbgGo, "exclDesTxt")
	self.exclStageIma1 = goutil.findChild(self.exclbgGo, "exclStageIma1"):GetComponent("UIImageColorChange")
	self.exclStageIma2 = goutil.findChild(self.exclbgGo, "exclStageIma2"):GetComponent("UIImageColorChange")
	self.exclStageTxt = goutil.findChildTextComponent(self.exclbgGo, "exclStageTxt")
	self.attrListTxt = goutil.findChildTextComponent(self.equipShowGo, "attrListTxt")
	self.additionalGo = goutil.findChild(self.equipShowGo, "additionalGo")
	self.addlDescTxt = goutil.findChildTextComponent(self.additionalGo, "addlDescTxt")
	self.lvLimitTxt.text = ""
	self.attributesTxt.text = ""
	self.additionTxt.text = ""
	self.attrDesTxt.text = ""
	self.exclDesTxt.text = ""
	self.exclStageTxt.text = ""

	self.attrEquipItem:SetActive(false)
	self.equipShowGo:SetActive(false)
	GameUtil.SetActive(self.exclbgGo, false)

	self.attrListTxt.text = ""

	GameUtil.SetActive(self.attrListTxt.gameObject, false)
end

function PetEquipInfoView:onEnter()
	local param = self._viewPresentor._openParam

	self.stRedPoint:SetActive(false)

	if param == nil or param[1] == nil then
		self:close()

		return
	end

	self.params = param[1]
	self.infoMo = nil

	if self.params.isSeeInfo then
		self.viewInfoGo:GetComponent("UIAdjustPosition").enabled = true

		GameUtil.SetActive(self.unloadBtn, false)
		GameUtil.SetActive(self._unloadShowBtn, false)
		GameUtil.SetActive(self.replaceBtn, false)
		GameUtil.SetActive(self.strengthenBtn, false)
		GameUtil.SetActive(self.tupoBtn, false)

		self.viewBgRect.sizeDelta = Vector2.New(520, 575)
		self.infoMo = PetEquipModel.instance:GetTemporaryEquip(self.params.baseId, self.params.starCount, self.params.param)

		local pos = self._viewPresentor._openParam[2]

		if not self._viewPresentor._openParam[3] then
			local sizeDelta = {
				0,
				0
			}

			if pos then
				Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
				self.viewInfoGo:GetComponent("UIAdjustPosition"):AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
			end

			Framework.TransformUtil.SetLocalPos(self.viewInfoGo.transform, 0, -25, 0)

			self.replaceTxt.text = lang("替换")
		end
	else
		self.viewInfoGo:GetComponent("UIAdjustPosition").enabled = false
		self.viewBgRect.sizeDelta = Vector2.New(520, 620)
		self.infoMo = self.params

		local curPetId = BagPetsController.instance:GetCurPetId()
		local isChangeEquipView = ViewMgr.instance:isOpen(ViewName.PetEquipChangeBagView)

		GameUtil.SetActive(self.unloadBtn, self.infoMo.equipPetId == curPetId and isChangeEquipView == true)
		GameUtil.SetActive(self._unloadShowBtn, self.infoMo.equipPetId == curPetId and isChangeEquipView ~= true)
		GameUtil.SetActive(self.replaceBtn, self.infoMo.equipPetId ~= curPetId or isChangeEquipView ~= true)

		self.replaceTxt.text = lang("替换")

		if PetEquipController.instance.isEquipInit then
			local equipInfoList = PetEquipModel.instance:GetWearEquipInfosByPetInfo(BagPetsController.instance:GetCurPetMo())

			if equipInfoList[self.infoMo.wearPos].isWear == false then
				self.replaceTxt.text = lang("装备")
			end
		end

		Framework.TransformUtil.SetLocalPos(self.viewInfoGo.transform, 0, 0, 0)

		local isRed = PetEquipModel.instance:isKeyiStrengthenInfoMo(self.infoMo)

		self.stRedPoint:SetActive(isRed)

		local posx = 0
		local isCanTupo = self.infoMo:isCanTupo()

		GameUtil.SetActive(self.tupoBtn, isCanTupo)

		if isCanTupo then
			posx = -110

			self.tupoBtn:AddClickListener(function()
				PetEquipController.instance:setCurrentEquipInfoMo(self.infoMo)
				self:close()
				UIStateManager.instance:popByName(ViewName.PetEquipChangeBagView)
				UIStateManager.instance:push(ViewName.EquipFunction, PetEquipModel.FunctionType.TupoType)
			end, self)
		end

		local isCanStrengthen = self.infoMo:isCanStrengthen()
		local isInStengView = ViewMgr.instance:isOpen(ViewName.EquipFunction)

		if isCanStrengthen and not isInStengView then
			GameUtil.SetActive(self.strengthenBtn, true)
			self.strengthenBtn:AddClickListener(function()
				PetEquipController.instance:setCurrentEquipInfoMo(self.infoMo)
				self:close()
				UIStateManager.instance:popByName(ViewName.PetEquipChangeBagView)
				UIStateManager.instance:push(ViewName.EquipFunction, PetEquipModel.FunctionType.SttnType)
			end, self)

			posx = -110
		else
			GameUtil.SetActive(self.strengthenBtn, false)
		end

		Framework.TransformUtil.SetLocalPos(self.replaceBtn.gameObject.transform, posx, -258, 0)
		self.unloadBtn:AddClickListener(function()
			self:close()
			PetEquipController.instance:CSUnloadOneEquipReq(self.infoMo.equipPetId, self.infoMo.onlyId)
		end, self)
		self._unloadShowBtn:AddClickListener(function()
			self:close()
			PetEquipController.instance:CSUnloadOneEquipReq(self.infoMo.equipPetId, self.infoMo.onlyId)
		end, self)
		self.replaceBtn:AddClickListener(function()
			self:close()

			local petInfo = BagPetsController.instance:GetCurPetMo()

			if isChangeEquipView then
				self:_onClickReplace(petInfo, self.infoMo)
			else
				UIStateManager.instance:open(ViewName.PetEquipChangeBagView, self.infoMo.wearPos)
			end
		end, self)
	end

	self.quaChangSpt:SetState(self.infoMo.qualityBase)

	local _, colorStr = PetEquipController.instance:GetQualityStrByNum(self.infoMo.qualityBase, true)

	self.equipNameTxt.text = string.format("<color=%s>%s</color>", colorStr, self.infoMo.name)
	self.powerTxt.text = tostring(self.infoMo.commPower)

	MaterialMgr.resetAll(self.equipItemGo)

	self.oppLimitTxt.text = self.infoMo:isEquipArtifact() and "精灵限制：" .. MaterialMgr.getMaterialsName(MatType.PET_SKIN, self.infoMo.sqSkinId) or lang("text_equip_desc_29") .. table.concat(self.infoMo.jobTypeList, "、")

	self.equipShowGo:SetActive(true)
	self:ShowEquipAttr()

	self.lvLimitTxt.text = checknumber(self.infoMo.limitLevel) > 0 and langPara("text_equip_desc_31", self.infoMo.limitLevel) or langPara("text_equip_desc_31", "无")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._equipShowGoRect)
end

function PetEquipInfoView:ShowEquipAttr()
	local proxy = MaterialMgr.setCellByData(MatType.Equipment, self.infoMo, self.equipItemGo)

	if proxy then
		proxy.binder:PlayAttrTypeEffect(true)
		proxy:setAutoTips(false)
	end

	local baseInfo, nowInfo = PetEquipModel.instance:GetEquipNowBaseAttrInfoById(self.infoMo)
	local nowAttrList = nowInfo.attrList
	local baseAttrList = baseInfo.attrList
	local ratioStr = self.infoMo:getEquipAddPercent()

	if self.infoMo:isEquipArtifact() then
		self.exclDesTxt.text = ""
		self.exclStageTxt.text = ""

		GameUtil.SetActive(self.exclbgGo, false)

		self.additionTxt.text = "神器套装"
		self.attributesTxt.text = "神器属性"

		local str, isMulti = PetEquipModel.instance:getArtifactAttrDescShow(self.infoMo, self.params.isSeeInfo)

		self.attrDesTxt.text = ""

		GameUtil.SetActive(self.attrListTxt.gameObject, true)

		self.attrListTxt.text = str
	else
		self.attrListTxt.text = ""

		GameUtil.SetActive(self.attrListTxt.gameObject, false)

		self.additionTxt.text = "属性加成"
		self.attributesTxt.text = "装备属性"

		if checknumber(self.infoMo.exclRaceId) > 0 then
			GameUtil.SetActive(self.exclbgGo, true)

			self.attrDesTxt.text = ""

			if self.infoMo:isEnableWearExcl() then
				self.exclStageIma1:SetState(1)
				self.exclStageIma2:SetState(1)

				self.exclStageTxt.text = lang("text_equip_desc_32")
				self.powerTxt.text = tostring(self.infoMo.exclPower)
			else
				self.exclStageIma1:SetState(0)
				self.exclStageIma2:SetState(0)

				self.exclStageTxt.text = lang("text_equip_desc_33")
			end

			nowAttrList = nowInfo.attrExclList

			local petCfg = MaterialMgr.getMatCfg(MatType.Pet, self.infoMo.exclRaceId)

			if petCfg then
				if not petCfg.name then
					local petName = "精灵"

					self.exclDesTxt.text = langPara("text_equip_desc_34", petName, ratioStr)
				end
			end
		else
			self.exclDesTxt.text = ""
			self.exclStageTxt.text = ""

			GameUtil.SetActive(self.exclbgGo, false)

			if string.nilorempty(self.infoMo.attrType) or self.infoMo.attrType == "无" then
				self.attrDesTxt.text = lang("text_equip_desc_35")
			else
				local isAdd = false

				if self.params.isSeeInfo then
					if self.params.param and checknumber(self.params.param.wearFaceId) > 0 then
						isAdd = PetSkinConfig.instance:checkHasEleAttr(self.params.param.wearFaceId, self.infoMo.attrType)
					end
				else
					local petInfo = BagPetsController.instance:GetCurPetMo(self.infoMo.equipPetId)

					if petInfo then
						isAdd = PetSkinConfig.instance:checkHasEleAttr(petInfo.curFaceId, self.infoMo.attrType) or AttrMo.checkHasYuanEle(petInfo.curFaceId, self.infoMo.attrType)
					end
				end

				if not isAdd then
					self.attrDesTxt.text = langPara("text_equip_desc_36", self.infoMo.attrType, ratioStr)
				else
					if proxy then
						proxy.binder:SetView(self)
						proxy.binder:PlayAttrTypeEffect()
					end

					nowAttrList = nowInfo.attrAddList
					self.powerTxt.text = tostring(self.infoMo.addPower)
					self.attrDesTxt.text = langPara("text_equip_desc_37", self.infoMo.attrType, ratioStr)
				end
			end
		end
	end

	local txt = self.attrDesTxt.text

	goutil.setActive(self.attrDesTxt.gameObject, not string.nilorempty(txt))

	if self.infoMo.quality >= 10 then
		GameUtil.SetActive(self.additionalGo, true)

		local equipCfg = EquipmentConfig.instance:GetEquipDefineInfoById(self.infoMo.baseId)
		local lvCfg = EquipmentConfig.instance:GetEquipInfoByLvl(equipCfg.equipmentLvStrategy, self.infoMo.starCount)
		local resExt = {}
		local attrs = string.split(lvCfg.attributeDisplay or "", "#")

		for i, attr in ipairs(attrs) do
			local attrName, attrVal = FightingPowerFormula.instance:getAttrNameValue(attr)

			if not string.nilorempty(attrName) then
				resExt[attrName] = attrVal
			end
		end

		local list = {}

		for k, v in pairs(resExt) do
			local preStr = "+"

			if v < 0 then
				preStr = "-"
			end

			local str = k .. preStr .. ((v ~= 0 and math.abs(v) < 1 or nil) and string.format("%.2f", math.abs(v) * 100) .. "%")

			table.insert(list, str)
		end

		self.addlDescTxt.text = table.concat(list, " ")
	else
		GameUtil.SetActive(self.additionalGo, false)
	end

	if nowAttrList then
		if not #nowAttrList then
			local count = 0

			count = math.ceil(count / 2)

			if self.attrEquipList and count < #self.attrEquipList then
				for i = count + 1, #self.attrEquipList do
					if self.attrEquipList[i].itemGo and self.attrEquipList[i].itemGo.activeSelf then
						self.attrEquipList[i].itemGo:SetActive(false)
					end
				end
			end

			if count < 1 then
				return
			end

			self.attrEquipList = self.attrEquipList or {}

			for i = 1, count do
				if self.attrEquipList[i] == nil then
					self.attrEquipList[i] = {}

					local attrGo = UnityEngine.GameObject.Instantiate(self.attrEquipItem, self.attrEquipPos)

					self.attrEquipList[i].itemGo = attrGo
					self.attrEquipList[i].iconSptL = goutil.findChildComponent(attrGo, "iconSptL", "UIImageSpriteChange")
					self.attrEquipList[i].countTxtL = goutil.findChildTextComponent(attrGo, "countTxtL")
					self.attrEquipList[i].iconSptR = goutil.findChildComponent(attrGo, "iconSptR", "UIImageSpriteChange")
					self.attrEquipList[i].countTxtR = goutil.findChildTextComponent(attrGo, "countTxtR")
				end

				local go = self.attrEquipList[i]

				go.name = "attrGo_" .. i

				if nowAttrList == nil or nowAttrList[i * 2 - 1] == nil then
					go.itemGo:SetActive(false)
				else
					go.itemGo:SetActive(true)

					local info = nowAttrList[i * 2 - 1]

					go.iconSptL:SetState(info.index - 1)

					local baseCount = baseAttrList[i * 2 - 1].extCount

					if baseCount >= info.extCount then
						local countStr = tostring(info.extCount)

						go.countTxtL.text = string.format("<color=#323232FF>%s %s</color>", info.name, (string.find(info.name, lang("text_equip_lv")) or nil) and info.extCount * 100 .. "%")
					else
						local baseStr = tostring(baseCount)
						local countStr = tostring(info.extCount - baseCount)

						if string.find(info.name, lang("text_equip_lv")) then
							baseStr = baseCount * 100 .. "%"
							countStr = (info.extCount - baseCount) * 100 .. "%"
						end

						go.countTxtL.text = string.format("<color=#323232FF>%s %s</color><color=#398502FF>+%s</color>", info.name, baseStr, countStr)
					end

					local info2 = nowAttrList[i * 2]

					if info2 then
						baseCount = baseAttrList[i * 2] and baseAttrList[i * 2].extCount or info2.extCount

						go.iconSptR.gameObject:SetActive(true)
						go.iconSptR:SetState(info2.index - 1)

						if baseCount >= info2.extCount then
							local countStr = tostring(info2.extCount)

							go.countTxtR.text = string.format("<color=#323232FF>%s %s</color>", info2.name, (string.find(info2.name, lang("text_equip_lv")) or nil) and info2.extCount * 100 .. "%")
						else
							local baseStr = tostring(baseCount)
							local countStr = tostring(info2.extCount - baseCount)

							if string.find(info2.name, lang("text_equip_lv")) then
								baseStr = baseCount * 100 .. "%"
								countStr = (info2.extCount - baseCount) * 100 .. "%"
							end

							go.countTxtR.text = string.format("<color=#323232FF>%s %s</color><color=#398502FF>+%s</color>", info2.name, baseStr, countStr)
						end
					else
						go.iconSptR.gameObject:SetActive(false)

						go.countTxtR.text = ""
					end
				end
			end
		end
	end
end

function PetEquipInfoView:_onClickReplace(petMo, equipMo)
	local isWear = equipMo.isWear

	if petMo then
		if not petMo.petId then
			local petId = 1

			if petMo then
				if not petMo.level then
					local petLv = 1
					local matType = equipMo.matType

					if petLv < equipMo.limitLevel then
						if matType == MatType.Equipment then
							FloatWordMgr.instance:show(lang("text_equip_desc_43"))
						elseif matType == MatType.Decoration then
							FloatWordMgr.instance:show(lang("text_equip_desc_44"))
						end

						return
					end

					local function sureClick()
						self:close()

						if matType == MatType.Equipment then
							PetEquipController.instance:CSWearOneEquipReq(petId, equipMo.onlyId)
						elseif matType == MatType.Decoration then
							PetEquipController.instance:CSWearDecorationReq(petId, equipMo.onlyId)
						end
					end

					if isWear then
						local tempPetInfo = BagPetsController.instance:getPet(equipMo.equipPetId)

						if tempPetInfo then
							if not tempPetInfo.name then
								local tempPetName = tostring(equipMo.equipPetId)

								if petMo then
									if not petMo.name then
										local curPetName = tostring(equipMo.baseId)
										local desStr = langPara("text_equip_desc_45", tempPetName, equipMo.name, curPetName)

										UIStateManager.instance:open(ViewName.PetEquipTips, lang("text_equip_desc_46"), desStr, sureClick)
									end
								end
							end
						end
					else
						sureClick()
					end
				end
			end
		end
	end
end

return PetEquipInfoView
