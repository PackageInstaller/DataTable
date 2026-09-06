-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/VipPrivilegeTips.lua

module("logiccommon.common.components.VipPrivilegeTips", package.seeall)

local VipPrivilegeTips = class("VipPrivilegeTips")

function VipPrivilegeTips:ctor(parent)
	self:_createInstance()
	self:attachToParent(parent)
end

function VipPrivilegeTips:attachToParent(parent)
	self.parent = parent

	self:_createInstance()

	if goutil.isNil(self.mainGo) then
		return
	end

	if not goutil.isNil(parent) then
		self.mainGo:SetActive(true)
		self.mainGo.transform:SetParent(parent.transform)
		Framework.TransformUtil.SetLocalPos(self.mainGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(self.mainGo.transform, 1, 1, 1)

		if self.mainGo.layer ~= parent.layer then
			Framework.GameObjectUtil.SetLayerRecursively(self.mainGo, parent.layer)
		end
	else
		self.mainGo:SetActive(false)
	end
end

function VipPrivilegeTips:detachFromParent()
	self.parent = nil

	if not goutil.isNil(self.mainGo) then
		self.mainGo:SetActive(false)
		self.mainGo.transform:SetParent(nil)
	end
end

function VipPrivilegeTips:setPrivilege(privilege)
	self:_createInstance()

	self._txtPrivilege.text = privilege
end

function VipPrivilegeTips:setActive(active)
	if not goutil.isNil(self.mainGo) then
		self.mainGo:SetActive(active)
	end
end

function VipPrivilegeTips:destroy()
	goutil.destroy(self.mainGo)
end

function VipPrivilegeTips:_createInstance()
	if not goutil.isNil(self.mainGo) then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(CommonResPath.VipPrivilegeTips)

	if not res then
		return
	end

	local mainAsset = res:GetMainAsset()

	if not mainAsset then
		return
	end

	self.mainGo = goutil.clone(mainAsset)
	self._txtPrivilege = goutil.findChildTextComponent(self.mainGo, "privilege")
end

VipPrivilegeTips.instance = VipPrivilegeTips.New()

return VipPrivilegeTips
