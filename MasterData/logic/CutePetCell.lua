-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/cute/CutePetCell.lua

module("logic.extensions.material.proxy.cute.CutePetCell", package.seeall)

local CutePetCell = class("CutePetCell", MaterialCell)

function CutePetCell:ctor(target)
	CutePetCell.super.ctor(self, target)

	self._imgBg = goutil.findChildImageComponent(self.target, "ImgBg")
	self._iconBg = goutil.findChild(self.target, "ImgBg"):GetComponent("UIImageSpriteChange")
	self._icon = goutil.findChild(self.target, "ImgIcon")
	self._txtName = goutil.findChildTextComponent(self.target, "TxtName")
	self._txtNum = goutil.findChildTextComponent(self.target, "TxtNum")
	self._Image = goutil.findChild(self.target, "Image")
	self._imgType = goutil.findChild(self.target, "imgType"):GetComponent("UIImageSpriteChange")
	self._selected = goutil.findChild(self.target, "Select")
	self._topGo = goutil.findChild(self.target, "topGo")
	self._txtLv = goutil.findChildTextComponent(self.target, "txtLv")
end

function CutePetCell:setData(data)
	self.data = data

	self:setNum(0)

	if data ~= nil and (checknumber(data.equippedPetId) <= 0 or true) then
		self._star = data.curStar

		self:setQuality(data.curQuality)
	end
end

function CutePetCell:setCfgData(cfg)
	CutePetCell.super.setCfgData(self, cfg)
	GameUtil.addClickHandler(self.target, self._OnClick, self)
	self._icon:SetActive(false)
	self._iconBg:SetState(2)
	self._imgType:SetState(0)
	self:setName("")

	if cfg then
		self:setName(cfg.name)
		self._imgType:SetState(cfg.type - 1)
		MaterialMgr.setIcon(self._icon, self.type, cfg.raceId)
		self._icon:SetActive(true)
	end
end

function CutePetCell:setName(name)
	return
end

function CutePetCell:setNum(allNum, useNum)
	self.num = allNum or 1

	if self.num <= 0 then
		self._txtNum.text = ""

		GameUtil.SetActive(self._Image, false)

		return
	end

	GameUtil.SetActive(self._Image, true)

	self._txtNum.text = useNum and useNum >= 0 and useNum .. "/" .. self.num or tostring(self.num)
end

function CutePetCell:setQuality(quality)
	self._quality = quality

	if checknumber(quality) > 0 then
		self._iconBg:SetState(quality + 1)
	else
		self._iconBg:SetState(2)
	end
end

function CutePetCell:setLvl(lvl)
	return
end

function CutePetCell:setPetIcon(equippedPetId)
	self._equippedPetId = checknumber(equippedPetId)

	if self._equippedPetId <= 0 then
		goutil.setActive(self._petIconRoot, false)

		return
	end

	goutil.setActive(self._petIconRoot, true)
	MaterialMgr.setIcon(self._petIconGo, MatType.Pet, self._equippedPetId)
end

function CutePetCell:setSelected(isSelected)
	GameUtil.SetActive(self._selected, isSelected)
end

function CutePetCell:_OnClick()
	GameUtil.callBack(self.callback, self)

	if self.autoTips then
		if self.data then
			CommonTipsMgr.instance:openMaterialTips(self._icon, self.type, self.id, self.data.curLvl, checknumber(self.data.curQuality), self.data)
		else
			CommonTipsMgr.instance:openMaterialTips(self._icon, self.type, self.id, 1, checknumber(self._quality))
		end
	end
end

return CutePetCell
