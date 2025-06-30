-- chunkname: @IQIGame\\Module\\Dress\\DressData.lua

DressData = {
	hasOwned = false,
	isNew = false,
	expireTime = -1
}

function DressData.New()
	local o = Clone(DressData)

	return o
end

function DressData:Initialize(dressCid, dressPOD)
	if dressPOD ~= nil and dressCid ~= dressPOD.dressCid then
		logError("[DressData] dressCid is invalid.")

		return
	end

	self.dressCid = dressCid
	self.cfgDressRow = CfgDressTable[self.dressCid]

	if dressPOD ~= nil then
		self.expireTime = dressPOD.expireTime
		self.isNew = dressPOD.isNew
		self.hasOwned = true
	else
		self:Refresh(nil)
	end
end

function DressData:Refresh(dressPOD)
	if dressPOD ~= nil then
		self.expireTime = dressPOD.expireTime
		self.isNew = dressPOD.isNew
		self.hasOwned = true
	else
		self.expireTime = -1
		self.isNew = false
		self.hasOwned = false
	end
end

function DressData:CheckIsWore()
	local soulData = DressModule.GetSoulDataBaseOnDressCid(self.dressCid)

	if soulData ~= nil then
		if soulData.dressCid2D == self.dressCid or soulData.dressCid3D == self.dressCid then
			return true
		end

		return false
	end

	return false
end

function DressData:CheckHasOwn()
	return self.hasOwned
end

function DressData:GetRemnantSeconds()
	local ret = 0

	if self.expireTime > 0 then
		ret = self.expireTime - PlayerModule.GetServerTime()

		if ret < 0 then
			ret = 0
		elseif ret > math.floor(ret) then
			ret = tonumber(string.format("%.0f", ret))
		end

		return ret
	end

	return ret
end

function DressData:GetSoulData()
	local soulCid = self.cfgDressRow.SoulID

	return SoulModule.GetSoulData(soulCid)
end
