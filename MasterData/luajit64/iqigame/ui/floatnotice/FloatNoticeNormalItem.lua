-- chunkname: @IQIGame\\UI\\FloatNotice\\FloatNoticeNormalItem.lua

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
	return Constant.Notice.FloatTypeNormal
end

function m:SetData(param)
	local cfgNoticeData = CfgNoticeTable[param.cid]
	local args = param.args
	local argsHasContent = false

	for i, v in pairs(args) do
		argsHasContent = true

		break
	end

	local content

	if argsHasContent then
		content = string.format(cfgNoticeData.Describe, unpack(args))
	else
		content = cfgNoticeData.Describe
	end

	UGUIUtil.SetText(self.Text, content)
end

function m:OnReset()
	return
end

function m:OnDispose()
	return
end

return m
