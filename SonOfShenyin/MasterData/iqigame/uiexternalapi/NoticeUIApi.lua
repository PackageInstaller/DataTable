-- chunkname: @IQIGame\\UIExternalApi\\NoticeUIApi.lua

NoticeUIApi = BaseLangApi:Extend()

function NoticeUIApi:GetTextUnlockCook()
	return self:GetCfgText(2300080) .. "|" .. self:GetCfgText(2300081) .. "|%s"
end

function NoticeUIApi:GetTextBtn()
	return self:GetCfgText(1111105)
end

function NoticeUIApi:GetTextTitle()
	return self:GetCfgText(190001)
end

function NoticeUIApi:GetTextTitleEng()
	return self:GetCfgText(190002)
end

function NoticeUIApi:GetTabStr()
	return {
		self:GetCfgText(190003),
		self:GetCfgText(190004)
	}
end

function NoticeUIApi:GetEmptyNoticeText()
	return self:GetCfgText(190005)
end

function NoticeUIApi:GetStateImgPath(state)
	return string.format(self:GetResUrl(2500), state)
end

function NoticeUIApi:GetTipsText()
	return self:GetCfgText(401)
end
