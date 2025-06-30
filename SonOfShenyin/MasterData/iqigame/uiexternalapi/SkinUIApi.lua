-- chunkname: @IQIGame\\UIExternalApi\\SkinUIApi.lua

SkinUIApi = BaseLangApi:Extend()

function SkinUIApi:GetSkinCountStr(hasCount, allCount)
	return hasCount .. "/" .. allCount
end

function SkinUIApi:GetSkinFunctionButtonDesc(skinState)
	if skinState == Constant.SkinState.OwnedAndEquipping then
		return self:GetCfgText(5100002)
	elseif skinState == Constant.SkinState.OwnedAndNotEquipping then
		return self:GetCfgText(5100003)
	elseif skinState == Constant.SkinState.NotOwnAndCanGet then
		return self:GetCfgText(5100001)
	elseif skinState == Constant.SkinState.NotOwnAndCanNotGet then
		return self:GetCfgText(5100000)
	end
end

function SkinUIApi:GetSkinObtainDesc(skinCid)
	local skinConfig = SkinModule.GetSkinConfigBySkinCid(skinCid)

	if skinConfig ~= nil then
		return skinConfig.SkinObtainDesc
	end

	return ""
end
