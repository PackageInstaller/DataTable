-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dress/model/ClotheData.lua

module("logic.extensions.dress.model.ClotheData", package.seeall)

local ClotheData = class("ClotheData")

function ClotheData:setData(data)
	if not data then
		return
	end

	self:setCfgId(checkint(data.clothesId))

	self.dateGet = tonumber(data.gainDateTime) or -1
	self.dateOut = tonumber(data.outDateTime) or -1
	self.isOwn = self.dateOut <= 0
	self.dayActive = not self.isOwn and math.ceil((self.dateOut - ServerTime.now() * 1000) / 86400000)
end

function ClotheData:ctor()
	self.id = 0
	self.sortId = 0
	self.dateGet = -1
	self.dateOut = -1
	self.dressCfg = nil
	self.isOwn = false
	self.dayActive = false
	self.matStr = ""
end

function ClotheData:setCfgId(id)
	self.id = id

	local cfg = DressConfig.instance:getDressCfgById(self.id)

	if cfg then
		self.sortId = cfg.sortId or self.id
	end

	self.dressCfg = DressConfig.instance:getDressCfgById(checkint(self.id))
	self.matStr = ""

	if self.dressCfg then
		self.matStr = string.format("1:%s:-1:1", self.id)
	end
end

function ClotheData:copyMo(mo)
	if mo then
		self.id = mo.id
		self.sortId = mo.sortId
		self.dateGet = mo.dateGet
		self.dateOut = mo.dateOut
		self.dressCfg = mo.dressCfg
		self.isOwn = mo.isOwn
		self.dayActive = mo.dayActive
		self.matStr = mo.matStr
	end
end

return ClotheData
