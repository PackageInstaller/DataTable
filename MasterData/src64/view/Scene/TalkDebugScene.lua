local TalkDebug = class("TalkDebug", function()
	return cc.Scene:create()
end)

function TalkDebug:create()
	local var_2_0 = TalkDebug.new()

	var_2_0:init()

	return var_2_0
end

function TalkDebug:init()
	require("data.constants")
	require("controller.helper")
	require("controller.global_func")
	require("view.Layer.TalkLayer")
	self:addChild(TalkLayer:create(1000, nil, TALK_TYPE_NORMAL, "", nil, 1))
end

return TalkDebug
