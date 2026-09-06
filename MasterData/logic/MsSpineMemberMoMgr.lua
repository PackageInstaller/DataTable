-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/member/MsSpineMemberMoMgr.lua

module("logic.extensions.spineinterface.param.MsSpineMemberMoMgr", package.seeall)

local MsSpineMemberMoMgr = class("MsSpineMemberMoMgr")

function MsSpineMemberMoMgr:ctor()
	self._memberMoList = {}
	self._skinId = 0
end

function MsSpineMemberMoMgr:onReload(skeletonList, skinId)
	self:onUnReload()

	self._skinId = checknumber(skinId)

	local paramsDataList = SpineInterfaceConfig.instance:getMsSpParamsDataList(self._skinId)

	if paramsDataList then
		for _, data in ipairs(paramsDataList) do
			local spineParamId = data.spineParamId
			local mo = MsSpineMemberMo.New()

			mo:onLoad(skeletonList, self._skinId, spineParamId)

			self._memberMoList[spineParamId] = mo
		end
	end
end

function MsSpineMemberMoMgr:onUnReload()
	for _, mo in ipairs(self._memberMoList) do
		mo:onUnLoad()
	end

	table.clear(self._memberMoList)

	self._skinId = 0
end

function MsSpineMemberMoMgr:onDestroy()
	self:onUnReload()
end

function MsSpineMemberMoMgr:getMemberMo(spineParamId)
	return self._memberMoList[spineParamId]
end

function MsSpineMemberMoMgr:getMemberValue(spineParamId)
	return self:getMemberMo(spineParamId):getValue()
end

function MsSpineMemberMoMgr:setMemberValue(spineParamId, value)
	return self:getMemberMo(spineParamId):setValue(value)
end

return MsSpineMemberMoMgr
