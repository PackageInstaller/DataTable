-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/pettitle/PetTitleCell.lua

module("logic.extensions.material.proxy.pettitle.PetTitleCell", package.seeall)

local PetTitleCell = class("PetTitleCell", MaterialCell)

function PetTitleCell:ctor(target)
	self.target = target
	self._imgPetIcon = goutil.findChild(target, "mask/ImgPetIcon")
	self._imgIconChange = goutil.findChildComponent(target, "ImgPetTitleIcon", "UIImageSpriteChange")
	self._txtName = goutil.findChildTextComponent(target, "txtName")
	self._txtTag = goutil.findChildTextComponent(target, "txtTag")
	self._txtTagPos = GameUtil.getLocalPos(self._txtTag.gameObject)
	self._imgPetIconOri = self._imgPetIcon:GetComponent(goutil.Type_UIImage)
	self._cacheMat = self._imgPetIconOri.material
end

function PetTitleCell:setCfgData(cfg)
	PetTitleCell.super.setCfgData(self, cfg)
	GameUtil.setLocalPos(self._txtTag.gameObject, self._txtTagPos.x + (cfg.tagOffset[1] or 0), self._txtTagPos.y + (cfg.tagOffset[2] or 0), self._txtTagPos.z)
	MaterialMgr.setIcon(self._imgPetIcon, MatType.Pet, cfg.raceId)
	self._imgIconChange:ChangeSprite(cfg.icon)

	self._txtName.text = cfg.name
	self._txtTag.text = cfg.tag

	if not cfg.iconOffset then
		if not cfg.iconOffset[1] then
			local x = 0

			if not cfg.iconOffset[2] then
				local y = 0

				if not cfg.iconOffset[3] then
					local scale = 1

					GameUtil.setLocalPos(self._imgIconChange, x, y, 0)
					GameUtil.setLocalScale(self._imgIconChange, scale)
					GameUtil.addClickHandler(self.target, self._OnClick, self)

					self._imgPetIconOri.material = self._cacheMat
				end
			end
		end
	end
end

function PetTitleCell:setClick(clickFunc, obj)
	self.callback = clickFunc
	self.handler = obj
end

function PetTitleCell:removeClick()
	self.callBack = nil
	self.handler = nil
end

function PetTitleCell:setGray(isGray)
	uGuiUtil.setImageGrayStateRecursive(self.target, isGray)

	if not isGray then
		self._imgPetIconOri.material = self._cacheMat
	end
end

function PetTitleCell:dispose()
	PetTitleCell.super.dispose(self)
end

function PetTitleCell:OnDestroy()
	PetTitleCell.super.OnDestroy(self)

	self.data = nil
end

function PetTitleCell:_OnClick()
	if self.autoTips and self.cfg then
		CommonTipsMgr.instance:openMaterialTips(self.target, MatType.PetTitle, self.cfg.titleId)
	end

	GameUtil.callBack(self.callback, self.handler)
end

return PetTitleCell
