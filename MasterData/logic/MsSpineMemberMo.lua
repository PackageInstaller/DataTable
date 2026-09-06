-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/member/MsSpineMemberMo.lua

module("logic.extensions.spineinterface.member.MsSpineMemberMo", package.seeall)

local MsSpineMemberMo = class("MsSpineMemberMo")

function MsSpineMemberMo:ctor()
	return
end

function MsSpineMemberMo:onLoad(skeletonList, skinId, spineParamId)
	self._skinId = checknumber(skinId)
	self._spineParamId = checknumber(spineParamId)
	self._paramsData = SpineInterfaceConfig.instance:getMsSpParamsData(self._skinId, self._spineParamId)
	self._paramsDicData = SpineInterfaceConfig.instance:getMsSpParamsDicData(self._paramsData.spineParamDicId)
	self._targetName = self._paramsData.targetName
	self._paramType = self._paramsDicData.paramType
	self._paramName = self._paramsDicData.paramName
	self._memberType = self._paramsDicData.memberType
	self._dataType = self._paramsDicData.dataType
	self._info = nil

	if self._memberType == MsEnum.SystemMemberType.Property then
		self._info = SystemReflexHelp.getProperty(self._paramType, self._paramName)
	elseif self._memberType == MsEnum.SystemMemberType.Field then
		self._info = SystemReflexHelp.getField(self._paramType, self._paramName)
	elseif self._memberType == MsEnum.SystemMemberType.Method then
		printError("不支持Method")
	end

	if self._info == nil then
		printError(string.format("错误：无法通过反射获取对应info，请检查配置( skinId=%s, spineParamId=%s | m模型骨骼动画交互行为表.xlsx | export_spine参数配置 )", self._skinId, self._spineParamId))
	end

	local tempTarget

	for _, skeleton in ipairs(skeletonList) do
		tempTarget = nil

		if self._paramType == MsEnum.SpineParamType.PathConstraint then
			tempTarget = skeleton:FindPathConstraint(self._targetName)
		elseif self._paramType == MsEnum.SpineParamType.IkConstraint then
			tempTarget = skeleton:FindIkConstraint(self._targetName)
		elseif self._paramType == MsEnum.SpineParamType.TransformConstraint then
			tempTarget = skeleton:FindTransformConstraint(self._targetName)
		elseif self._paramType == MsEnum.SpineParamType.Bone then
			tempTarget = skeleton:FindBone(self._targetName)
		end

		if tempTarget ~= nil then
			if self._target ~= nil then
				printError(string.format("错误：spine资源中，存在同类型且同名的插槽或者附件或者骨骼之类的对象，请联系美术检查( skinId=%s, spineParamId=%s, targetName=%s )", self._skinId, self._spineParamId, self._targetName))
			end

			self._target = tempTarget
		end
	end

	if self._target == nil then
		printError(string.format("无法找到对象,请配置表( skinId=%s, spineParamId=%s, targetName=%s | m模型骨骼动画交互行为表.xlsx | export_spine参数配置 )", self._skinId, self._spineParamId, self._targetName))
	end
end

function MsSpineMemberMo:onUnLoad()
	self._skinId = 0
	self._spineParamId = 0
	self._paramsData = nil
	self._paramsDicData = nil
	self._targetName = nil
	self._paramType = nil
	self._paramName = nil
	self._memberType = nil
	self._dataType = nil
	self._info = nil
	self._target = nil
end

function MsSpineMemberMo:getValue()
	local value

	if self._memberType == MsEnum.SystemMemberType.Property then
		value = self._info:Get(self._target, nil)
	elseif self._memberType == MsEnum.SystemMemberType.Field then
		value = self._info:Get(self._target)
	elseif self._memberType == MsEnum.SystemMemberType.Method then
		printError("暂不支持Method")
	end

	return value
end

function MsSpineMemberMo:setValue(value)
	if self._memberType == MsEnum.SystemMemberType.Property then
		self._info:Set(self._target, value, nil)
	elseif self._memberType == MsEnum.SystemMemberType.Field then
		self._info:Set(self._target, value)
	elseif self._memberType == MsEnum.SystemMemberType.Method then
		printError("暂不支持Method")
	end
end

return MsSpineMemberMo
