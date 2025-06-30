-- chunkname: @IQIGame\\UIExternalApi\\RollingNoticeUIApi.lua

RollingNoticeUIApi = BaseLangApi:Extend()

function RollingNoticeUIApi:Init()
	self:RegisterApi("textGo", self.SetContent)
end

function RollingNoticeUIApi:SetContent(content)
	return content
end

RollingNoticeUIApi:Init()
