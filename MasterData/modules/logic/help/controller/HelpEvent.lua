-- chunkname: @modules/logic/help/controller/HelpEvent.lua

module("modules.logic.help.controller.HelpEvent", package.seeall)

local HelpEvent = {}

HelpEvent.RefreshHelp = 1
HelpEvent.OnClickHelpViewMask = 2
HelpEvent.UIVoideFullScreenChange = 25001
HelpEvent.UIPageTabSelectChange = 25002

return HelpEvent
