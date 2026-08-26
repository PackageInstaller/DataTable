-- chunkname: @modules/versionactivitybase/fixed/VersionActivityFixedHelper.lua

module("modules.versionactivitybase.fixed.VersionActivityFixedHelper", package.seeall)

local VersionActivityFixedHelper = class("VersionActivityFixedHelper")
local _version = {
	big = 3,
	small = 9
}
local _versionTable
local foramt1 = "%s_%s"
local foramt2 = "V%sa%s"
local foramt3 = "v%sa%s"

local function _getVersion(big, small)
	return big or _version.big, small or _version.small
end

local function _getVersionFuncForamt(funcName, foramt, big, small)
	big, small = _getVersion(big, small)

	local _format = string.format(foramt, big, small)

	return string.format(funcName, _format)
end

local function _getVersionTable(big, small)
	big, small = _getVersion(big, small)
	_versionTable = _versionTable or {}
	_versionTable[big] = _versionTable[big] or {}
	_versionTable[big][small] = _versionTable[big][small] or {}

	return _versionTable[big][small]
end

function VersionActivityFixedHelper.setMainActivitySprite(image, name, setNativeSize, big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._MainActivitySpriteFunc

	if not func then
		func = big == 3 and small == 10 and "setSp02AtomicActivityIconSprite" or _getVersionFuncForamt("set%sMainActivitySprite", foramt2, big, small)
		_versionTable[big][small]._MainActivitySpriteFunc = func
	end

	UISpriteSetMgr.instance[func](UISpriteSetMgr.instance, image, name, setNativeSize)
end

function VersionActivityFixedHelper.setDungeonSprite(image, name, setNativeSize, big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonSpriteFunc

	func = func or _getVersionFuncForamt("set%sDungeonSprite", foramt2, big, small)

	if not UISpriteSetMgr.instance[func] then
		func = "setVAFixedDungeonSprite"
	end

	if func then
		_versionTable[big][small]._DungeonSpriteFunc = func
	end

	UISpriteSetMgr.instance[func](UISpriteSetMgr.instance, image, name, setNativeSize)
end

function VersionActivityFixedHelper.setCustomDungeonStore(id)
	VersionActivityFixedHelper._customDungeonStore = id
end

function VersionActivityFixedHelper.getVersionActivityDungeonStore(big, small)
	if VersionActivityFixedHelper._customDungeonStore then
		return VersionActivityFixedHelper._customDungeonStore
	end

	return VersionActivityFixedHelper.getVersionActivityEnum(big, small).ActivityId.DungeonStore
end

function VersionActivityFixedHelper.getVersionActivityEnum(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._Enum

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sEnum", foramt1, big, small)

		func = _G[title]
		_versionTable[big][small]._Enum = _G[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityEnterViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._EnterViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sEnterView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._EnterViewName = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityStoreViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._StoreViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sStoreView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._StoreViewName = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityTaskViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._TaskViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sTaskView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._TaskViewName = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonEnum(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonEnum

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonEnum", foramt1, big, small)

		func = _G[title]
		_versionTable[big][small]._DungeonEnum = _G[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonMapViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonMapView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._DungeonMapViewName = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonMapLevelView

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonMapLevelView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._DungeonMapLevelView = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonFragmentInfoViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonFragmentInfoView

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonFragmentInfoView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._DungeonFragmentInfoView = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonReportFullViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonReportFullViewName

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonReportFullView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._DungeonReportFullViewName = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonReportTipsViewName(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonReportTipsView

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sDungeonReportTipsView", foramt1, big, small)

		func = ViewName[title]
		_versionTable[big][small]._DungeonReportTipsView = ViewName[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonEnterReddotId(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonEnter

	if not func then
		local title = _getVersionFuncForamt("%sDungeonEnter", foramt2, big, small)

		func = RedDotEnum.DotNode[title]
		_versionTable[big][small]._DungeonEnter = RedDotEnum.DotNode[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityDungeonTaskReddotId(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._DungeonTask

	if not func then
		local title = _getVersionFuncForamt("%sDungeonTask", foramt2, big, small)

		func = RedDotEnum.DotNode[title]
		_versionTable[big][small]._DungeonTask = RedDotEnum.DotNode[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityCurrencyType(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._CurrencyType

	if not func then
		local title = _getVersionFuncForamt("%sDungeon", foramt2, big, small)

		func = CurrencyEnum.CurrencyType[title]
		_versionTable[big][small]._CurrencyType = CurrencyEnum.CurrencyType[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityAudioBgmLayer(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._AudioBgmLayer

	if not func then
		local title = _getVersionFuncForamt("VersionActivity%sMain", foramt1, big, small)

		func = AudioBgmEnum.Layer[title]
		_versionTable[big][small]._AudioBgmLayer = AudioBgmEnum.Layer[title]
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityStoreRareIcon(big, small)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table._StoreRareIcon

	if not func then
		func = big == 3 and small == 10 and string.format("sp02_store_quality_", small) or _getVersionFuncForamt("%s_store_quality_", foramt3, big, small)
		_versionTable[big][small]._StoreRareIcon = func
	end

	return func
end

function VersionActivityFixedHelper._getFixed(big, small, name, suffix)
	big, small = _getVersion(big, small)

	local table = _getVersionTable(big, small)
	local func = table[name]

	if not func then
		local _format = "VersionActivity%s" .. name
		local title = _getVersionFuncForamt(_format, foramt1, big, small)
		local fixedTitle = string.format(_format, "Fixed")

		func = _G[title]

		if not _G[title] then
			if suffix then
				fixedTitle = fixedTitle .. suffix
			end

			func = _G[fixedTitle]
		end

		_versionTable[big][small][name] = func
	end

	return func
end

function VersionActivityFixedHelper.getVersionActivityEnterController(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterController", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonController(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonController", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapElement(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapElement", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapHoleView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapHoleView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapScene(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapScene", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapSceneElements(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapSceneElements", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapChapterLayout(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapChapterLayout", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeItem(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapEpisodeItem", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapEpisodeView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapFinishElement(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapFinishElement", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapInteractView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapInteractView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapLevelView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapLevelView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityStoreGoodsItem(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "StoreGoodsItem", suffix)
end

function VersionActivityFixedHelper.getVersionActivityStoreItem(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "StoreItem", suffix)
end

function VersionActivityFixedHelper.getVersionActivityStoreView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "StoreView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityTaskItem(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "TaskItem", suffix)
end

function VersionActivityFixedHelper.getVersionActivityTaskView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "TaskView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonEnterView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonEnterView", suffix)
end

function VersionActivityFixedHelper.getVersionActivitySubAnimatorComp(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "SubAnimatorComp", suffix)
end

function VersionActivityFixedHelper.getVersionActivityEnterBgmView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterBgmView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityEnterView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityEnterViewTabItem1(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterViewTabItem1", suffix)
end

function VersionActivityFixedHelper.getVersionActivityEnterViewTabItem2(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "EnterViewTabItem2", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonFragmentInfoView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonFragmentInfoView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapNormalInteractView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapNormalInteractView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapControlView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapControlView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapTaskInfo(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapTaskInfo", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeSceneView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapEpisodeSceneView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapElementReward(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapElementReward", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonReportFullView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonReportFullView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonReportTipsView(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonReportTipsView", suffix)
end

function VersionActivityFixedHelper.getVersionActivityDungeonMapEpisodeSceneItem(big, small, suffix)
	return VersionActivityFixedHelper._getFixed(big, small, "DungeonMapEpisodeSceneItem", suffix)
end

function VersionActivityFixedHelper.getVersionActivityScriptSuffix(big, small)
	local enum = VersionActivityFixedHelper.getVersionActivityEnum(big, small)

	return enum and enum.ScriptSuffix
end

function VersionActivityFixedHelper.isTargetVersion(big, small)
	return _version.big == big and _version.small == small
end

return VersionActivityFixedHelper
