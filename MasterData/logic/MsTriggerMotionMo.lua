-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/motion/MsTriggerMotionMo.lua

module("logic.extensions.spineinterface.motion.MsTriggerMotionMo", package.seeall)

local MsTriggerMotionMo = class("MsTriggerMotionMo")

function MsTriggerMotionMo:ctor()
	self._motionType = nil
end

function MsTriggerMotionMo:onInit(motionData)
	self:onClear()

	self._motionData = motionData
	self._motionType = self._motionData.motionType

	if enableDebug then
		if self._motionType == nil then
			printError("motionType为空,请检查配置")
		else
			local isFit = false

			for _, v in pairs(MsEnum.MotionType) do
				if v == self._motionType then
					isFit = true

					break
				end
			end

			if not isFit then
				printError(string.format("错误：motionType类型不存在( %s )", self._motionType))
			end
		end
	end
end

function MsTriggerMotionMo:onClear()
	self._motionType = nil
end

function MsTriggerMotionMo:getMotionType()
	return self._motionType
end

function MsTriggerMotionMo:getMotionParam(key, dataType)
	local value = self._motionData[key]

	if dataType ~= nil then
		if dataType == MsEnum.DataType.Bool then
			value = checkbool(value and value == "true")
		elseif dataType == MsEnum.DataType.Int then
			value = checknumber(value)
		elseif dataType == MsEnum.DataType.Float then
			value = checknumber(value)
		end
	end

	return value
end

function MsTriggerMotionMo:isHaveMotionParam(key)
	return self._motionData[key] ~= nil
end

return MsTriggerMotionMo
