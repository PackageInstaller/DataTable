-- chunkname: @modules/versionactivitybase/enterview/define/VersionActivityEnterViewEnum.lua

module("modules.versionactivitybase.enterview.define.VersionActivityEnterViewEnum", package.seeall)

local VersionActivityEnterViewEnum = _M

VersionActivityEnterViewEnum.ActLevel = {
	Second = 2,
	First = 1
}
VersionActivityEnterViewEnum.ActType = {
	Multi = 2,
	Single = 1
}

return VersionActivityEnterViewEnum
