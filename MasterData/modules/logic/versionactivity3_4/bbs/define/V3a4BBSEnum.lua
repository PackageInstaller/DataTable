-- chunkname: @modules/logic/versionactivity3_4/bbs/define/V3a4BBSEnum.lua

module("modules.logic.versionactivity3_4.bbs.define.V3a4BBSEnum", package.seeall)

local V3a4BBSEnum = _M

V3a4BBSEnum.PostType = {
	Element = 2,
	Story = 1
}
V3a4BBSEnum.TriggerType = {
	Close = "close",
	click = "click",
	Playdialog = "playdialog",
	send = "send",
	finish = "finish",
	dialogue = "dialogue",
	refresh = "refresh"
}
V3a4BBSEnum.PrefsKey = {
	TriggerStep = "TriggerStep"
}
V3a4BBSEnum.TriggerDelayTime = 3

return V3a4BBSEnum
