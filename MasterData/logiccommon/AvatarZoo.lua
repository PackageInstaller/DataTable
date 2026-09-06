-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatar/AvatarZoo.lua

module("logiccommon.common.avatar.new.avatar.AvatarZoo", package.seeall)

local AvatarZoo = class("AvatarZoo", AvatarBase)

function AvatarZoo:ctor()
	AvatarZoo.super.ctor(self)

	self.animatorCtrl = AvatarAnimatorCtrl.New(self)
	self.pendantsCtrl = AvatarPendantsCtrl.New(self)
	self.nakesCtrl = AvatarNakePartsCtrl.New(self)
	self.partsCtrl = AvatarPartsCtrl.New(self)

	self.addListener(self, AvatarNotify.OnAllPendantsLoaded, self._onAllPartsLoaded, self)
	self.addListener(self, AvatarNotify.OnAllPartLoaded, self._onAllPartsLoaded, self)
end

function AvatarZoo:getAvatarCreateType()
	return AvatarCreateType.Zoo
end

function AvatarZoo:getNewUseMo()
	return AvatarZooMo.New()
end

function AvatarZoo:_onAllPartsLoaded()
	if self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded() then
		self.nakesCtrl:updateNakeParts()
		self:setAnimatorLayerByCoverData()
		self.dispatch(self, AvatarNotify.OnAvatarLoaded, self)
	end
end

function AvatarZoo:setVisible(visible)
	AvatarZoo.super.setVisible(self, visible)
	self:setAnimatorLayerByCoverData()
end

function AvatarZoo:setLayer(layer)
	AvatarZoo.super.setLayer(self, layer)
	self.pendantsCtrl:setLayer(layer)
	self.partsCtrl:setLayer(layer)
end

function AvatarZoo:destroy()
	AvatarZoo.super.destroy(self)

	self.avatarmo = nil

	self:removeAllListener(AvatarNotify.OnAllPendantsLoaded)
	self:removeAllListener(AvatarNotify.OnAllPartLoaded)
end

function AvatarZoo:isAllLoaded()
	return self:getGameObject() and self.pendantsCtrl:isAllPendantLoaded() and self.partsCtrl:isAllPartLoaded()
end

function AvatarZoo:setAnimatorLayerByCoverData()
	local curPartId = self.avatarmo:getCurCoverDataValue()

	for _, v in ipairs(curPartId) do
		local cfg = AvatarConfig.instance:getPartCfgById(v)
		local layerName = cfg and cfg.aniLayer

		if not GameUtil.isEmptyString(layerName) then
			return self.animatorCtrl:setLayerByLayerName(layerName)
		end
	end

	self.animatorCtrl:setLayer(0)
end

function AvatarZoo:reset(isNotResetData)
	if self._ctrls then
		for _, v in pairs(self._ctrls) do
			v:onAvatarReset()
		end
	end

	self._resLoader:clear()

	self._skeletonMap = nil

	if not isNotResetData then
		self.useType = AvatarUseType.UI
		self._layer = nil
		self._parent = nil
		self._visible = true
	end
end

return AvatarZoo
