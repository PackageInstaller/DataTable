-- chunkname: @IQIGame\\UIExternalApi\\SoulListCellApi.lua

SoulListCellApi = BaseLangApi:Extend()

function SoulListCellApi:Init()
	self:RegisterApi("goName", self.GetSoulName)
	self:RegisterApi("goClipNum", self.GetClipNum)
	self:RegisterApi("goLv", self.GetSoulLv)
	self:RegisterApi("goNo", self.GetNo)
	self:RegisterApi("goBottomBg", self.GetBottomBg)
end

function SoulListCellApi:GetBottomBg(star)
	return ""
end

function SoulListCellApi:GetNo(num)
	return ""
end

function SoulListCellApi:GetSoulName(name, isUnlock)
	if isUnlock == true then
		return name
	else
		return self.TextColor[26] .. name .. self.TextColor[0]
	end
end

function SoulListCellApi:GetClipNum(ownCount, needCount)
	return "<size=16>" .. self:GetCfgText(1211022) .. "</size>" .. "\n" .. ownCount .. "/" .. needCount
end

function SoulListCellApi:GetSoulLv(lv, isUnlock)
	if isUnlock == true then
		return lv
	else
		return ""
	end
end

SoulListCellApi:Init()
