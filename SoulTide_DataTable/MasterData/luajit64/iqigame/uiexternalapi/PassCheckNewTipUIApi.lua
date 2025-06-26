-- chunkname: @IQIGame\\UIExternalApi\\PassCheckNewTipUIApi.lua

PassCheckNewTipUIApi = BaseLangApi:Extend()

function PassCheckNewTipUIApi:Init()
	self:RegisterApi("btnCloseTxt", self.GetBtnCloseTxt)
	self:RegisterApi("desc1", self.GetDesc1)
	self:RegisterApi("desc2", self.GetDesc2)
	self:RegisterApi("desc3", self.GetDesc3)
	self:RegisterApi("lastLv", self.GetLastLv)
	self:RegisterApi("curLv", self.GetCurLv)
end

function PassCheckNewTipUIApi:GetCurLv(lv)
	return lv
end

function PassCheckNewTipUIApi:GetLastLv(lv)
	return lv
end

function PassCheckNewTipUIApi:GetDesc1()
	return self:GetCfgText(3501501)
end

function PassCheckNewTipUIApi:GetDesc2()
	return self:GetCfgText(3501502)
end

function PassCheckNewTipUIApi:GetDesc3()
	return self:GetCfgText(3501503)
end

function PassCheckNewTipUIApi:GetBtnCloseTxt()
	return self:GetCfgText(3501504)
end

PassCheckNewTipUIApi:Init()
