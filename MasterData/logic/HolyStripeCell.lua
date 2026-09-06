-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/HolyStripeCell.lua

module("logic.extensions.material.proxy.item.HolyStripeCell", package.seeall)

local HolyStripeCell = class("HolyStripeCell", MaterialCell)

function HolyStripeCell:ctor(target)
	HolyStripeCell.super.ctor(self, target)

	self.icon = goutil.findChild(self.target, "ImgIcon")
	self.iconBg = goutil.findChild(self.target, "ImgBg"):GetComponent(ComponentType.UIImageSpriteChange)
	self.txtNum = goutil.findChild(self.target, "layout/TxtNum"):GetComponent(goutil.Type_UIText)
	self.Image = goutil.findChild(self.target, "Image")
	self.selected = goutil.findChild(self.target, "Select")
	self.imgBg = goutil.findChildComponent(self.target, "ImgBg", "Image")
	self.topGo = goutil.findChild(self.target, "topGo")
	self.quality = goutil.findChild(self.target, "quality")
	self.qualityColor = goutil.findChildComponent(self.target, "quality", "UIImageSpriteChange")
	self.tag = goutil.findChild(self.target, "tag")
	self._petIconRoot = goutil.findChild(self.target, "petIconGo")
	self._petIconGo = goutil.findChild(self.target, "petIconGo/petIcon")
	self._txtLv = goutil.findChildTextComponent(self.target, "layout/txtLv")
	self.hasDestroy = goutil.findChild(self.target, "hasDestroy")

	self:dispose()
end

function HolyStripeCell:setBgActive(isActive)
	self.imgBg.enabled = isActive
end

function HolyStripeCell:setData(data)
	self.data = data

	self:setNum(0)

	if data ~= nil then
		self:setNum(data.num)

		if data.getEquipPetId and data:getEquipPetId() > 0 then
			self:setPetIcon(data:getEquipRaceId())
		else
			self:setPetIcon(0)
		end
	end

	self:_setLv()
end

function HolyStripeCell:setNum(allNum, useNum)
	self.num = allNum or 1

	if self.num <= 0 then
		self.txtNum.text = ""

		GameUtil.SetActive(self.Image, false)
		GameUtil.SetActive(self.txtNum, false)

		return
	end

	GameUtil.SetActive(self.Image, true)
	GameUtil.SetActive(self.txtNum, true)

	self.txtNum.text = useNum and useNum >= 0 and useNum .. "/" .. self.num or tostring(self.num)
end

function HolyStripeCell:setNumStr(str)
	GameUtil.SetActive(self.Image, str and str ~= "")
	GameUtil.SetActive(self.txtNum, str and str ~= "")

	self.txtNum.text = str
end

function HolyStripeCell:setNumBg(torf)
	GameUtil.SetActive(self.Image, torf)
end

function HolyStripeCell:setCfgData(cfg)
	HolyStripeCell.super.setCfgData(self, cfg)
	GameUtil.addClickHandler(self.target, self._OnClick, self)
	self:_setLv()
	self.icon:SetActive(false)
	self.iconBg:SetState(0)

	if self._effSSR then
		UIEffectManager.instance:stopEffect(self._effSSR)

		self._effSSR = nil
	end

	if cfg then
		MaterialMgr.setIcon(self.icon, self.type, cfg.id)

		self.id = cfg.id

		self.icon:SetActive(true)
		self.iconBg:SetState(1 + (cfg.quality or 0))

		self._effSSR = self:playRareEffect(1 + (cfg.quality or 0), self.topGo)

		Framework.TransformUtil.SetLocalRotation(self.quality.transform, 0, 0, 90 - 45 * (cfg.positionType - 1))
		self.qualityColor:SetState(cfg.quality)
		self:setPetIcon(0)
	end
end

function HolyStripeCell:OnDestroy()
	HolyStripeCell.super.OnDestroy(self)

	self.target = nil
	self.data = nil
	self._clickBack = nil
end

function HolyStripeCell:setSelected(isSelected)
	self.selected.gameObject:SetActive(isSelected)
end

function HolyStripeCell:setTag(status)
	self.tag.gameObject:SetActive(status)
end

function HolyStripeCell:setCallBack(cb)
	self._clickBack = cb
end

function HolyStripeCell:_OnClick()
	GameUtil.callBack(self._clickBack, self)

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.imgBg, self.type, self.id, self.data)
	end
end

function HolyStripeCell:setGray(isGray)
	uGuiUtil.setImageGrayStateRecursive(self.target, isGray)
	self:setEffStatus(not isGray)
end

function HolyStripeCell:setEffStatus(flag)
	GameUtil.SetActive(self.topGo, flag)
end

function HolyStripeCell:dispose()
	HolyStripeCell.super.dispose(self)

	self._clickBack = nil

	self:setSelected(false)
	self.icon:SetActive(false)
	self.iconBg:SetState(0)
	self:setBgActive(true)
	self:setUiOfMock(false)
	self:setNum(0)
	MaterialMgr.clearIcon(self.icon)
	MaterialMgr.clearIcon(self._petIconGo)
	UIEffectManager.instance:stopEffect(self._effSSR)

	self._effSSR = nil

	goutil.setActive(self.selected, false)
	self:setEffStatus(true)

	self.data = nil
end

function HolyStripeCell:setPetIcon(raceId)
	self._raceId = checknumber(raceId)

	if self._raceId <= 0 then
		goutil.setActive(self._petIconRoot, false)

		return
	end

	goutil.setActive(self._petIconRoot, true)
	MaterialMgr.setIcon(self._petIconGo, MatType.Pet, self._raceId)
end

function HolyStripeCell:setCellEfectOnTop(status)
	if self._effSSR then
		self._effSSR.hideEffWhileNotOnTop = not status
	end
end

function HolyStripeCell:_setLv()
	if self.data and self.data.getLv then
		local lv = self.data:getLv()

		self._txtLv.text = lv > 0 and "Lv." .. self.data:getLv() or ""
	else
		self._txtLv.text = ""
	end
end

function HolyStripeCell:setUiOfMock(isMock)
	GameUtil.SetActive(self.hasDestroy, isMock)
end

return HolyStripeCell
