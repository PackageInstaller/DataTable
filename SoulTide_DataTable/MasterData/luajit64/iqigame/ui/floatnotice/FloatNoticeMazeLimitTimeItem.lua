-- chunkname: @IQIGame\\UI\\FloatNotice\\FloatNoticeMazeLimitTimeItem.lua

local m = {
	IsExpired = false,
	Type = 0
}
local FloatNoticeItemBase = require("IQIGame.UI.FloatNotice.FloatNoticeItemBase")

m = extend(FloatNoticeItemBase, m)

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:OnInit()
	return
end

function m:__GetType()
	return Constant.Notice.FloatTypeMazeLimitTimeChange
end

function m:SetData(param)
	self.AddView:SetActive(param.addValue >= 0)
	self.ReduceView:SetActive(param.addValue < 0)

	if param.addValue >= 0 then
		UGUIUtil.SetText(self.AddText, FloatNoticeUIApi:GetString("AddMazeLimitTimeText", param.addValue))
	else
		UGUIUtil.SetText(self.ReduceText, FloatNoticeUIApi:GetString("AddMazeLimitTimeText", param.addValue))
	end
end

function m:OnReset()
	return
end

function m:OnDispose()
	return
end

return m
