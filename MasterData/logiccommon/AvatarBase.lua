-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatar/AvatarBase.lua

module("logiccommon.common.avatar.avatar.AvatarBase", package.seeall)

local AvatarBase = class("AvatarBase", AvatarObject)

function AvatarBase:ctor()
	NotifyDispatcher.extend(self)
	AvatarBase.super.ctor(self)

	self.useType = AvatarUseType.UI
	self.avatarmo = nil
	self._ownerId = nil
end

function AvatarBase:setOwnerUserId(ownerId)
	self._ownerId = ownerId
end

function AvatarBase:getOwnerUserId()
	return self._ownerId
end

function AvatarBase:getAvatarCreateType()
	return AvatarCreateType.Base
end

function AvatarBase:addCtrl(ctrlType, ctrl)
	if ctrlType == AvatarControllerType.Init then
		printError(self:getAvatarCreateType() .. " Add Init Ctrl")
	end

	self._ctrls = self._ctrls or {}

	if self._ctrls[ctrlType] then
		printError(self:getAvatarCreateType() .. " Add SameType Ctrl" .. ctrlType)
		self._ctrls[ctrlType]:onDestory()
	end

	self._ctrls[ctrlType] = ctrl
end

function AvatarBase:loadedHandle(loader)
	self:_initSkeletonMap()

	if self._ctrls then
		for _, v in pairs(self._ctrls) do
			v:onAvatarLoaded()
		end
	end

	AvatarBase.super.loadedHandle(self, loader)
end

function AvatarBase:callBackHandle(loader)
	if self._inCallBackHandle then
		return
	end

	self._inCallBackHandle = true

	AvatarBase.super.callBackHandle(self, loader)

	if self:isObjLoaded() then
		if self._ctrls then
			for _, v in pairs(self._ctrls) do
				v:onAvatarLoadedCallBack()
			end
		end

		local resObject = self:getGameObject()

		GameUtil.SetActive(resObject, self._visible)
	end

	self._inCallBackHandle = false
end

function AvatarBase:updateByMo(mo)
	if not mo then
		return
	end

	mo:setDefaultState()

	if mo and mo:isAllSame(self.avatarmo) and self:getGameObject() then
		return
	end

	if self.avatarmo then
		if self.avatarmo.skeleton ~= mo.skeleton then
			self:reset(true)
		end
	else
		self.avatarmo = self:getNewUseMo()
	end

	self.avatarmo:copyDataByMo(mo)
	self:updateState()
end

function AvatarBase:getNewUseMo()
	return AvatarModel.New()
end

function AvatarBase:preSetMo(mo)
	if not mo then
		printError("avatarBase Pre Set Nil MO")

		return
	end

	if self.avatarmo then
		self.avatarmo:copyDataByMo(mo)
	else
		self.avatarmo = self:getNewUseMo()

		self.avatarmo:copyDataByMo(mo)
	end
end

function AvatarBase:updateState()
	if not self.avatarmo then
		return
	end

	local skecfg = AvatarConfig.instance:getSkeletonCfgById(self.avatarmo.skeleton)
	local skePath = GameUrl.getAvatarSkeleton(skecfg.asset, self.useType)

	if self._visible then
		self:load(skePath)
	end
end

function AvatarBase:_initSkeletonMap()
	self._skeletonMap = nil

	local skeletonGo = self:getGameObject()

	if skeletonGo then
		GoUtil.TravelTransform(skeletonGo.transform, function(tf)
			self._skeletonMap = self._skeletonMap or {}

			if self._skeletonMap[tf.name] then
				print(self:getResPath() .. "Exit Same Name Bone.." .. tf.name)

				return
			end

			self._skeletonMap[tf.name] = tf
		end)
	else
		printError(self:getResPath() .. " Get Empty skeletonGo")
	end
end

function AvatarBase:getSkeletonMap()
	return self._skeletonMap
end

function AvatarBase:getBoneByName(bonesName)
	if self._skeletonMap == nil then
		self:_initSkeletonMap()
	end

	if self._skeletonMap then
		return self._skeletonMap[bonesName]
	end
end

function AvatarBase:getBoneByPointType(PointType)
	local pointName = AvatarHangPointName[PointType]

	return self:getBoneByName(pointName)
end

function AvatarBase:setVisible(visible)
	if visible == self._visible then
		return
	end

	self._visible = checkbool(visible)

	local resObject = self:getGameObject()

	if resObject then
		GameUtil.SetActive(resObject, checkbool(visible))
	else
		self:updateState()

		return
	end

	if checkbool(visible) then
		for _, v in pairs(self._ctrls) do
			v:onAvatarVisible()
		end
	else
		for _, v in pairs(self._ctrls) do
			v:onAvatarInvisible()
		end
	end
end

function AvatarBase:destroy()
	self:reset()

	if self._ctrls then
		for _, v in pairs(self._ctrls) do
			v:onAvatarDestroy()
		end
	end

	self._ctrls = nil

	AvatarBase.super.destroy(self)
end

function AvatarBase:reset(isNotResetData)
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
		self.avatarmo = nil
		self._visible = true
	end

	self._ownerId = nil
end

return AvatarBase
