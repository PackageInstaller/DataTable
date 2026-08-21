-- chunkname: @IQIGame\\UI\\WebNotice\\WebNoticeTabController.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view
end

function m:SetData(noticeData)
	self.View:GetComponent("ToggleHelperComponent").text = noticeData.title
end

function m:Dispose()
	self.View = nil
end

return m
