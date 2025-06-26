-- chunkname: @IQIGame\\UIExternalApi\\UIGlobalApi.lua

UIGlobalApi = {
	CharactersPath = "Assets/03_Prefabs/Entity/Battle",
	UIFxRootPath = "Assets/03_Prefabs",
	ElementSpinePath = "Assets/03_Prefabs/Entity",
	UIPath = "Assets/03_Prefabs/UI",
	AnimationPath = "Assets/07_Animations",
	IconPath = "Assets/05_Images/Icon",
	ImagePath = "Assets/05_Images",
	MediaPath = "Assets/21_Media",
	TimelinePath = "Assets/14_Effect/Battle/Timeline",
	ChapterPath = "Assets/05_Images/DataResource/UIResource/",
	BattleImagePath = "Assets/05_Images/Battle",
	ArtPrefabRootPath = "Assets/03_Prefabs",
	Live2DResRootPath = "Assets/20_Live2D/Live2D_Resources",
	PrefabsRootPath = "Assets/03_Prefabs",
	QualityColorStr = {
		"#D8D8D8",
		"#57B66D",
		"#308CAE",
		"#9A59B6",
		"#FE9E38"
	},
	QualityColor = {
		14211288,
		5748333,
		3181742,
		10115510,
		16686648
	}
}

function UIGlobalApi.GetUIFxEffectPath(effectName)
	return string.format(BaseLangApi:GetResUrl(1100024), effectName)
end

function UIGlobalApi.GetUIFxEffectPathByCfg(effectID)
	local effName = CfgEffectEntityTable[CfgEffectTable[effectID].EntityID].PrefabName

	return UIGlobalApi.GetUIFxEffectPath(effName)
end

function UIGlobalApi.GetFxEffectPathByEntityId(effectEntityId)
	return UIGlobalApi.UIFxRootPath .. "/" .. CfgEffectEntityTable[effectEntityId].PrefabName .. ".prefab"
end

function UIGlobalApi.GetIconPath(iconStr)
	return UIGlobalApi.IconPath .. iconStr
end

function UIGlobalApi.GetImagePath(fileName)
	return UIGlobalApi.ImagePath .. fileName
end

function UIGlobalApi.GetArtPath(fileName)
	return UIGlobalApi.ArtPrefabRootPath .. fileName
end

function UIGlobalApi.GetCommonUIPrefabPath(fileName)
	return AssetPath.Get(GlobalKey.UIPrefabPath, "Common/" .. fileName)
end

function UIGlobalApi.GetUIPrefab(prefabName)
	return UIGlobalApi.UIPath .. prefabName .. ".prefab"
end

function UIGlobalApi.GetPrefabRoot(prefabName)
	return UIGlobalApi.PrefabsRootPath .. prefabName
end

function UIGlobalApi.GetElementPrefab(fileName)
	return UIGlobalApi.ElementSpinePath .. "/" .. fileName .. ".prefab"
end

function UIGlobalApi.GetTimelinePrefab(fileName)
	return UIGlobalApi.TimelinePath .. "/" .. fileName .. ".prefab"
end

function UIGlobalApi.GetColorStrByQuality(quality)
	return UIGlobalApi.QualityColorStr[quality]
end

function UIGlobalApi.GetColorByQuality(quality)
	return UIGlobalApi.QualityColor[quality]
end

function UIGlobalApi.GetMediaPath(fileName)
	return UIGlobalApi.MediaPath .. "/" .. fileName
end

function UIGlobalApi.GetAnimationPath(fileName)
	return UIGlobalApi.AnimationPath .. fileName
end

function UIGlobalApi.GetNoticePrefab(fileName)
	return UIGlobalApi.UIPath .. "/_NoticeUI/" .. fileName .. ".prefab"
end

function UIGlobalApi.GetChapterPrefab(fileName)
	return UIGlobalApi.UIPath .. "/_Chapter/" .. fileName .. ".prefab"
end

function UIGlobalApi.GetPathForItemId(id)
	local path = CfgItemTable[id]

	return UIGlobalApi.IconPath .. path.Icon
end

function UIGlobalApi.GetMoneyCellAssetPath()
	return AssetPath.Get(GlobalKey.UIPrefabPath, "Common/CurrencyCell")
end

function UIGlobalApi.GetNumToStr_Wan(num)
	return tostring(num) .. BaseLangApi:GetCfgText(1600062)
end

function UIGlobalApi.GetNumToStr_Yi(num)
	return tostring(num) .. BaseLangApi:GetCfgText(1600063)
end

function UIGlobalApi.DateTimeFormat_DDHH()
	return BaseLangApi:GetCfgText(1600064)
end

function UIGlobalApi.DateTimeFormat_HHMMSS()
	return "hh:mm:ss"
end

function UIGlobalApi.GetClearSplitBtnText()
	return BaseLangApi:GetCfgText(1600065)
end

function UIGlobalApi.GetPopupListEmptyText()
	return BaseLangApi:GetCfgText(1600066)
end

function UIGlobalApi.GetPopupListButtonText(isSelect, text)
	if isSelect then
		return string.format("<color=#4d4d4d>%s</color>", text)
	else
		return string.format("<color=#222222>%s</color>", text)
	end
end

function UIGlobalApi.GetPopupListItemText(isSelect, text)
	if isSelect then
		return string.format("<color=#000000>%s</color>", text)
	else
		return string.format("<color=#4c4c4c>%s</color>", text)
	end
end

function UIGlobalApi.GetStrengthenPopupListButtonText(isSelect, text)
	return string.format("<color=#ffffff>%s</color>", text)
end

function UIGlobalApi.GetStrengthenPopupListItemText(isSelect, text)
	if isSelect then
		return string.format("<color=#ffffff>%s</color>", text)
	else
		return string.format("<color=#000000>%s</color>", text)
	end
end

function UIGlobalApi.GetLevelText(lv)
	return string.format("Lv.%s", lv)
end

function UIGlobalApi.GetDescribeMatchTable(describe, textHande)
	local replaceTable = {}
	local result = describe

	ForIn(string.gmatch(describe, "%{%d%}%l"), function(match)
		if replaceTable[match] ~= nil then
			return
		end

		local indexStr = string.match(match, "%d")
		local index = TryToNumber(indexStr, 1)
		local formatType = string.match(match, "%l")

		replaceTable[match] = textHande(index, formatType)
	end)
	ForPairs(replaceTable, function(_sourceStr, _targetStr)
		result = string.gsub(result, _sourceStr, _targetStr)
	end)

	return result
end

function UIGlobalApi.AnalysisDescribeArgsWithWildcard(formatType, value)
	local exrValue = TryToNumber(value, 0)

	if formatType == "p" then
		return tostring(exrValue * 100) .. "%%"
	elseif formatType == "d" then
		return exrValue
	else
		return exrValue
	end
end

function UIGlobalApi.GetRollNoticeScrollSpeed()
	return 100
end

function UIGlobalApi.GetRollNoticeDurationTime()
	return 30
end

function UIGlobalApi.GetRollNoticeReplayTime()
	return 60
end

function UIGlobalApi.GetRollNoticeReplayCount()
	return 2
end

function UIGlobalApi.GetGlobalBuffTips(removeType)
	if removeType == 1 then
		return BaseLangApi:GetCfgText(1300073)
	elseif removeType == 2 then
		return BaseLangApi:GetCfgText(1300074)
	end

	return ""
end

function UIGlobalApi:GetNormalMonthCardTipsText()
	local textArray = {}

	table.insert(textArray, "礼包内容")
	table.insert(textArray, "购买后立即获得30玺玉")
	table.insert(textArray, "购买后30天内，每天可领取100黄泉石")

	return textArray
end
