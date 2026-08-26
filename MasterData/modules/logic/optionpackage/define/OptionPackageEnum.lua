-- chunkname: @modules/logic/optionpackage/define/OptionPackageEnum.lua

module("modules.logic.optionpackage.define.OptionPackageEnum", package.seeall)

local OptionPackageEnum = _M

OptionPackageEnum.SourceType = {
	OptResVoice = 3,
	Voice = 1,
	OptRes = 2
}
OptionPackageEnum.UpdateState = {
	NeedUpdate = 3,
	NotDownload = 1,
	AlreadyLatest = 4,
	InDownload = 2
}
OptionPackageEnum.Package = {
	Explore = "opexplore",
	VersionActivity = "opveract",
	PartyGame = "oppartygame",
	Sodache = "opsodache"
}
OptionPackageEnum.NeedPackLangList = {
	"res",
	"media"
}
OptionPackageEnum.NeedPackLangDict = {}

for _, lang in ipairs(OptionPackageEnum.NeedPackLangList) do
	OptionPackageEnum.NeedPackLangDict[lang] = true
end

OptionPackageEnum.PackageNameList = {}
OptionPackageEnum.HasPackageNameDict = {}

for k, packageName in pairs(OptionPackageEnum.Package) do
	OptionPackageEnum.HasPackageNameDict[packageName] = true

	table.insert(OptionPackageEnum.PackageNameList, packageName)
end

return OptionPackageEnum
