-- chunkname: @modules/logic/versionactivity3_1/gaosiniao/model/GaoSiNiaoMapBag.lua

module("modules.logic.versionactivity3_1.gaosiniao.model.GaoSiNiaoMapBag", package.seeall)

local GaoSiNiaoMapBag = class("GaoSiNiaoMapBag")

function GaoSiNiaoMapBag:ctor(mapMO, ePathType, count)
	self._mapMO = mapMO
	self.type = ePathType or GaoSiNiaoEnum.PathType.None
	self.count = count or 0
end

function GaoSiNiaoMapBag:addCnt(addNum)
	self.count = self.count + addNum
end

function GaoSiNiaoMapBag:in_ZoneMask()
	return GaoSiNiaoEnum.PathInfo[self.type].inZM
end

function GaoSiNiaoMapBag:out_ZoneMask()
	return GaoSiNiaoEnum.PathInfo[self.type].outZM
end

return GaoSiNiaoMapBag
