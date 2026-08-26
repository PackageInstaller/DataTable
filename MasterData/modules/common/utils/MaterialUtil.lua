-- chunkname: @modules/common/utils/MaterialUtil.lua

module("modules.common.utils.MaterialUtil", package.seeall)

local MaterialUtil = _M

MaterialUtil._MainColorId = UnityEngine.Shader.PropertyToID("_MainColor")
MaterialUtil._MaskColorId = UnityEngine.Shader.PropertyToID("_MaskColor")
MaterialUtil._NoiseMap = UnityEngine.Shader.PropertyToID("_NoiseMap")

function MaterialUtil.GetMainColor(mat)
	if not gohelper.isNil(mat) then
		return mat:GetColor(MaterialUtil._MainColorId)
	end
end

function MaterialUtil.setMainColor(mat, color)
	if not gohelper.isNil(mat) then
		mat:SetColor(MaterialUtil._MainColorId, color)
	end
end

function MaterialUtil.getLerpValue(type, originValue, targetValue, lerpValue, reuseValue)
	if type == "int" or type == "float" then
		return Mathf.Lerp(originValue, targetValue, lerpValue)
	elseif type == "Color" then
		reuseValue = reuseValue or Color.New()
		reuseValue.r = Mathf.Lerp(originValue.r, targetValue.r, lerpValue)
		reuseValue.g = Mathf.Lerp(originValue.g, targetValue.g, lerpValue)
		reuseValue.b = Mathf.Lerp(originValue.b, targetValue.b, lerpValue)
		reuseValue.a = Mathf.Lerp(originValue.a, targetValue.a, lerpValue)

		return reuseValue
	elseif type == "Vector2" then
		reuseValue = reuseValue or Vector2.New()
		reuseValue.x = Mathf.Lerp(originValue.x, targetValue.x, lerpValue)
		reuseValue.y = Mathf.Lerp(originValue.y, targetValue.y, lerpValue)

		return reuseValue
	elseif type == "Vector3" then
		reuseValue = reuseValue or Vector3.New()
		reuseValue.x = Mathf.Lerp(originValue.x, targetValue.x, lerpValue)
		reuseValue.y = Mathf.Lerp(originValue.y, targetValue.y, lerpValue)
		reuseValue.z = Mathf.Lerp(originValue.z, targetValue.z, lerpValue)

		return reuseValue
	elseif type == "Vector4" then
		reuseValue = reuseValue or Vector4.New()
		reuseValue.x = Mathf.Lerp(originValue.x, targetValue.x, lerpValue)
		reuseValue.y = Mathf.Lerp(originValue.y, targetValue.y, lerpValue)
		reuseValue.z = Mathf.Lerp(originValue.z, targetValue.z, lerpValue)
		reuseValue.w = Mathf.Lerp(originValue.w, targetValue.w, lerpValue)

		return reuseValue
	elseif type == "variant" then
		if originValue == targetValue then
			return originValue == "1" or originValue == "true" or originValue == true
		elseif lerpValue >= 1 then
			return targetValue == "1" or targetValue == "true" or targetValue == true
		else
			return originValue == "1" or originValue == "true" or originValue == true
		end
	end
end

function MaterialUtil.getPropValueFromStr(type, valueStr)
	if type == "int" or type == "float" then
		return tonumber(valueStr)
	elseif type == "Color" then
		return Color.New(unpack(string.splitToNumber(valueStr, ",")))
	elseif type == "Vector2" then
		return Vector2.New(unpack(string.splitToNumber(valueStr, ",")))
	elseif type == "Vector3" then
		return Vector3.New(unpack(string.splitToNumber(valueStr, ",")))
	elseif type == "Vector4" then
		return Vector4.New(unpack(string.splitToNumber(valueStr, ",")))
	elseif type == "variant" then
		return valueStr == "1" or string.lower(valueStr) == "true"
	end
end

function MaterialUtil.getPropValueFromMat(mat, propName, type)
	if gohelper.isNil(mat) then
		return
	end

	if type == "int" then
		return mat:GetInt(propName)
	elseif type == "float" then
		return mat:GetFloat(propName)
	elseif type == "Color" then
		return mat:GetColor(propName)
	elseif type == "Vector2" or type == "Vector3" or type == "Vector4" then
		return mat:GetVector(propName)
	elseif type == "variant" then
		return mat:IsKeywordEnabled(propName)
	end
end

function MaterialUtil.setPropValue(mat, propName, type, value)
	if gohelper.isNil(mat) then
		return
	end

	if type == "int" then
		mat:SetInt(propName, value)
	elseif type == "float" then
		mat:SetFloat(propName, value)
	elseif type == "Color" then
		mat:SetColor(propName, value)
	elseif type == "Vector2" or type == "Vector3" or type == "Vector4" then
		mat:SetVector(propName, value)
	elseif type == "variant" then
		if value == "1" or value == "true" or value == true then
			mat:EnableKeyword(propName)
		else
			mat:DisableKeyword(propName)
		end
	end
end

return MaterialUtil
