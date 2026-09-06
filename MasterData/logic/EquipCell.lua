-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/equip/EquipCell.lua

module("logic.extensions.material.proxy.equip.EquipCell", package.seeall)

local EquipCell = class("EquipCell", MaterialCell)

function EquipCell:ctor(target)
	EquipCell.super.ctor(self, target)

	self.starGoList = {}
	self.qualitySpt = goutil.findChildComponent(self.target, "qualitySpt", "UIImageSpriteChange")
	self.baseQualitySpt = goutil.findChildComponent(self.target, "baseQualitySpt", "UIImageSpriteChange")
	self.iconSptGo = goutil.findChild(self.target, "iconSpt")
	self.typeBgGo = goutil.findChild(self.target, "typeBgGo")
	self.typeSpt = goutil.findChildComponent(self.target, "typeBgGo/typeSpt", "UIImageSpriteChange")
	self.starShowTran = goutil.findChild(self.target, "starShow").transform
	self.countGo = goutil.findChild(self.target, "countGo")
	self.countTxt = goutil.findChild(self.target, "countGo/countTxt"):GetComponent("Text")
	self.choiseGo = goutil.findChild(self.target, "choiseGo")
	self.redPointGo = goutil.findChild(self.target, "redPointGo")
	self.topGo = goutil.findChild(self.target, "topGo")
	self.exclSptGo = goutil.findChild(self.target, "exclSptGo")
	self.exclIconGo = goutil.findChild(self.exclSptGo, "exclIcon")
	self.qualityGo = goutil.findChild(self.target, "qualityGo")
	self.qualityTxt = goutil.findChild(self.qualityGo, "qualityTxt"):GetComponent("Text")

	for i = 1, self.starShowTran.childCount do
		local starGo = self.starShowTran:GetChild(i - 1).gameObject
		local names = string.split(starGo.name, "_")

		self.starGoList[tonumber(names[2])] = starGo:GetComponent("UIImageSpriteChange")

		if starGo.activeSelf then
			starGo:SetActive(false)
		end
	end

	self.countTxt.text = ""
	self.qualityTxt.text = ""

	GameUtil.SetActive(self.qualityGo, false)
	GameUtil.SetActive(self.countGo, false)
	GameUtil.SetActive(self.choiseGo, false)
	GameUtil.SetActive(self.redPointGo, false)
	GameUtil.SetActive(self.exclSptGo, false)
end

function EquipCell:setCallBack(cb)
	self.callback = cb
end

function EquipCell:_OnClick()
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		if self.type == MatType.Decoration then
			CommonTipsMgr.instance:openMaterialTips(self.iconSptGo, self.type, self.id, self.startCount, self.attrParams)
		elseif self.type == MatType.Equipment then
			local exclInfo = {
				exclRaceId = self.exclRaceId,
				wearOnlyId = self.wearOnlyId,
				wearFaceId = self.wearFaceId
			}

			CommonTipsMgr.instance:openMaterialTips(self.iconSptGo, self.type, self.id, self.startCount, exclInfo)
		end
	end
end

function EquipCell:setData(data)
	EquipCell.super.setData(self, data)

	if data then
		if not data.starCount then
			local count = 0

			self:setLvl(count)

			local id = 0

			if data then
				if data:isEquipArtifact() then
					id = data.sqSkinId
				elseif checknumber(data.exclRaceId) > 0 then
					id = data.exclRaceId
				end
			end

			self:setExclIcon(id)

			if data == nil then
				return
			end

			if data.matType == MatType.Decoration then
				self.attrParams = data.addAttrs
			end
		end
	end
end

function EquipCell:setCfgData(cfg)
	EquipCell.super.setCfgData(self, cfg)
	self:setExclIcon()
	GameUtil.SetActive(self.starShowTran.gameObject, false)
	GameUtil.SetActive(self.countGo, false)
	GameUtil.SetActive(self.choiseGo, false)
	GameUtil.SetActive(self.redPointGo, false)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	self.qualityTxt.text = ""

	if cfg == nil then
		self.qualitySpt:SetState(0)
		self.baseQualitySpt:SetState(0)
		GameUtil.SetActive(self.iconSptGo, false)
		GameUtil.SetActive(self.typeBgGo, false)
		GameUtil.SetActive(self.qualityGo, false)

		return
	end

	GameUtil.addClickHandler(self.target, self._OnClick, self)
	self.qualitySpt:SetState((cfg.qualityBase or 0) + 1)

	self._effSSR = self:playRareEffect((cfg.qualityBase or 0) + 1, self.topGo)

	local str = PetEquipModel.instance:_getEquipQualityDesc(cfg.quality)

	if string.nilorempty(str) then
		GameUtil.SetActive(self.qualityGo, false)
	else
		GameUtil.SetActive(self.qualityGo, true)

		self.qualityTxt.text = str
	end

	if (cfg.positionType == 5 or cfg.positionType == 6) and cfg.throneRelatedSkinId > 0 then
		self:setExclIcon(cfg.throneRelatedSkinId)
	end

	if cfg.quality == nil or cfg.quality == 99 then
		if self.baseQualitySpt.gameObject.activeSelf then
			self.baseQualitySpt.gameObject:SetActive(false)
		end
	else
		if not self.baseQualitySpt.gameObject.activeSelf then
			self.baseQualitySpt.gameObject:SetActive(true)
		end

		self.baseQualitySpt:SetState(cfg.quality - 1)
	end

	if self.iconSptGo and not self.iconSptGo.activeSelf then
		self.iconSptGo:SetActive(true)
	end

	MaterialMgr.setIcon(self.iconSptGo, self.type, cfg.id)

	if string.nilorempty(cfg.additionRaceType) or checknumber(self.exclRaceId) > 0 then
		self.typeBgGo:SetActive(false)
	else
		self.typeBgGo:SetActive(true)
		self.typeSpt:SetState(checknumber(GameEnum.Races[cfg.additionRaceType]) - 1)
	end

	self:setLvl(0)
end

function EquipCell:setLvl(count)
	self.startCount = count

	if count == nil or count == 0 then
		GameUtil.SetActive(self.starShowTran.gameObject, false)

		return
	end

	GameUtil.SetActive(self.starShowTran.gameObject, true)

	for i = 1, #self.starGoList do
		if i <= self.startCount then
			GameUtil.SetActive(self.starGoList[i], true)
			self.starGoList[i]:SetState(0)
		else
			GameUtil.SetActive(self.starGoList[i], false)
		end

		if i == 1 and self.startCount >= #self.starGoList then
			self.starGoList[i]:SetState(1)
		end
	end
end

function EquipCell:setExclIcon(raceId)
	self.exclRaceId = checknumber(raceId)

	if self.exclRaceId <= 0 then
		GameUtil.SetActive(self.exclSptGo, false)

		return
	end

	self.typeBgGo:SetActive(false)

	if not self.exclSptGo.activeSelf then
		GameUtil.SetActive(self.exclSptGo, true)
	end

	MaterialMgr.setIcon(self.exclIconGo, MatType.Pet, self.exclRaceId)
end

function EquipCell:setBewearPetIds(onlyId, faceId)
	self.wearOnlyId = checknumber(onlyId)
	self.wearFaceId = checknumber(faceId)
end

function EquipCell:setSelected(isShow)
	self.choiseGo:SetActive(isShow)
end

function EquipCell:setNum(allNum, useNum)
	self.num = allNum or 1

	if self.num <= 1 then
		self.countTxt.text = ""

		GameUtil.SetActive(self.countGo, false)
	else
		GameUtil.SetActive(self.countGo, true)

		self.countTxt.text = useNum and useNum >= 0 and useNum .. "/" .. self.num or tostring(self.num)
	end
end

function EquipCell:CancelBtnClick()
	self.target:GetComponent(typeof(UnityEngine.UI.Button)).enabled = false
end

function EquipCell:PlayAttrTypeEffect(isStop)
	if isStop then
		if self.attrEff then
			UIEffectManager.instance:stopEffect(self.attrEff)

			self.attrEff = nil
		end

		return
	end

	if self.attrEff or not self.typeBgGo.activeSelf then
		return
	end

	local effPath = "fx_ui_zhuangbeijiemian/fx_ui_zhuangbeijiemian_quan.prefab"

	self.attrEff = UIEffectManager.instance:playEffect(self.view, effPath, self.typeBgGo, 0, 0, true, false, nil, function(finishHandlerTarget, eff)
		if goutil.isNil(self.typeBgGo) then
			UIEffectManager.instance:stopEffect(eff)

			return
		end

		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self.typeBgGo) + 1)
		eff.effGo.transform:SetParent(self.typeBgGo.transform)

		eff.effGo.transform.localScale = Vector3.New(0.9, 0.9, 1)
		eff.effGo.transform.localPosition = Vector3.New(-0.8, 1.4, 0)
	end)
end

function EquipCell:dispose()
	EquipCell.super.dispose(self)

	self.attrParams = nil
	self.exclRaceId = nil
	self.wearOnlyId = nil

	if self.attrEff then
		UIEffectManager.instance:stopEffect(self.attrEff)

		self.attrEff = nil
	end

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	self.callback = nil

	self:setSelected(false)

	self.countTxt.text = ""

	GameUtil.SetActive(self.starShowTran.gameObject, false)
	GameUtil.SetActive(self.countGo, false)
	GameUtil.SetActive(self.choiseGo, false)
	GameUtil.SetActive(self.redPointGo, false)
	MaterialMgr.clearIcon(self.iconSptGo)

	self.target:GetComponent(typeof(UnityEngine.UI.Button)).enabled = true
end

function EquipCell:destroy()
	self:dispose()
end

function EquipCell:OnDestroy()
	EquipCell.super.OnDestroy(self)
	self:dispose()
end

return EquipCell
