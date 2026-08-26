-- chunkname: @modules/logic/optionpackage/define/OptionPackageEvent.lua

module("modules.logic.optionpackage.define.OptionPackageEvent", package.seeall)

local OptionPackageEvent = _M

OptionPackageEvent.DownloadProgressRefresh = 10001
OptionPackageEvent.UnZipProgressRefresh = 10002
OptionPackageEvent.DownladErrorMsg = 10003
OptionPackageEvent.DownloadFinish = 10004

return OptionPackageEvent
