-- chunkname: @IQIGame\\UIExternalApi\\MazeMainUIApi.lua

MazeMainUIApi = BaseLangApi:Extend()
MazeMainUIApi.MapElementPaths = {
	"/_MazeMainUI/SmallMap/Element_00",
	"/_MazeMainUI/SmallMap/Element_01",
	"/_MazeMainUI/SmallMap/Element_02",
	"/_MazeMainUI/SmallMap/Element_03",
	"/_MazeMainUI/SmallMap/Element_04",
	"/_MazeMainUI/SmallMap/Element_05",
	"/_MazeMainUI/SmallMap/Element_06",
	"/_MazeMainUI/SmallMap/Element_07",
	"/_MazeMainUI/SmallMap/Element_08",
	"/_MazeMainUI/SmallMap/Element_09",
	"/_MazeMainUI/SmallMap/Element_10",
	"/_MazeMainUI/SmallMap/Element_11",
	"/_MazeMainUI/SmallMap/Element_12",
	"/_MazeMainUI/SmallMap/Element_13",
	"/_MazeMainUI/SmallMap/Element_14",
	"/_MazeMainUI/SmallMap/Element_15",
	"/_MazeMainUI/SmallMap/Element_16",
	"/_MazeMainUI/SmallMap/Element_17",
	"/_MazeMainUI/SmallMap/Element_18",
	"/_MazeMainUI/SmallMap/Element_19",
	"/_MazeMainUI/SmallMap/Element_20",
	"/_MazeMainUI/SmallMap/Element_21",
	"/_MazeMainUI/SmallMap/Element_22",
	"/_MazeMainUI/SmallMap/Element_23",
	"/_MazeMainUI/SmallMap/Element_24",
	"/_MazeMainUI/SmallMap/Element_25",
	"/_MazeMainUI/SmallMap/Element_26",
	"/_MazeMainUI/SmallMap/Element_27",
	"/_MazeMainUI/SmallMap/Element_28",
	"/_MazeMainUI/SmallMap/Element_29",
	"/_MazeMainUI/SmallMap/Element_30",
	"/_MazeMainUI/SmallMap/Element_31",
	"/_MazeMainUI/SmallMap/Element_32",
	"/_MazeMainUI/SmallMap/Element_33",
	"/_MazeMainUI/SmallMap/Element_34",
	"/_MazeMainUI/SmallMap/Element_35",
	"/_MazeMainUI/SmallMap/Element_36",
	"/_MazeMainUI/SmallMap/Element_37",
	"/_MazeMainUI/SmallMap/Element_38",
	"/_MazeMainUI/SmallMap/Element_39",
	"/_MazeMainUI/SmallMap/Element_40",
	"/_MazeMainUI/SmallMap/Element_41",
	"/_MazeMainUI/SmallMap/Element_42",
	"/_MazeMainUI/SmallMap/Element_43",
	"/_MazeMainUI/SmallMap/Element_44",
	"/_MazeMainUI/SmallMap/Element_45",
	"/_MazeMainUI/SmallMap/Element_46"
}

function MazeMainUIApi:Init()
	self:RegisterApi("MazeNameText", self.GetMazeNameText)
	self:RegisterApi("BagBtnText", self.GetBagBtnText)
	self:RegisterApi("UpdateBuffNotice", self.GetUpdateBuffNotice)
	self:RegisterApi("TaskTargetDesc", self.GetTaskTargetDesc)
	self:RegisterApi("AddExploreValueNotice", self.GetAddExploreValueNotice)
	self:RegisterApi("MapUIAssets", self.GetMapUIAssets)
	self:RegisterApi("MapElementPath", self.GetMapElementPath)
	self:RegisterApi("MaskHeight", self.GetMaskHeight)
	self:RegisterApi("StartTitleText", self.GetStartTitleText)
	self:RegisterApi("StartTipText", self.GetStartTipText)
	self:RegisterApi("ExploreLabel", self.GetExploreLabel)
	self:RegisterApi("ExploreProgressText", self.GetExploreProgressText)
	self:RegisterApi("ServiceTriggerButtonDuration", self.GetServiceTriggerButtonDuration)
	self:RegisterApi("DollLevelText", self.GetDollLevelText)
	self:RegisterApi("ServiceTriggerNoticeBtnText", self.GetServiceTriggerNoticeBtnText)
	self:RegisterApi("QuitBtnText", self.GetQuitBtnText)
	self:RegisterApi("BigMapTitleText", self.GetBigMapTitleText)
end

function MazeMainUIApi:GetMazeNameText(chapterOrder, order, name)
	if order == 0 then
		return ""
	end

	if chapterOrder == 0 then
		return name
	elseif chapterOrder == 1 then
		if order <= 3 then
			return "0-" .. order .. " " .. name
		else
			return chapterOrder .. "-" .. order - 3 .. " " .. name
		end
	elseif chapterOrder == 16 and order <= 4 then
		return chapterOrder .. "-? " .. name
	end

	return chapterOrder .. "-" .. order .. " " .. name
end

function MazeMainUIApi:GetBagBtnText()
	return self:GetCfgText(1234002)
end

function MazeMainUIApi:GetUpdateBuffNotice(isAdd, isDebuff)
	local text

	if isAdd then
		if isDebuff then
			text = self:GetCfgText(2300040)
		else
			text = self:GetCfgText(2300041)
		end
	elseif isDebuff then
		text = self:GetCfgText(2300042)
	else
		text = self:GetCfgText(2300043)
	end

	return text
end

function MazeMainUIApi:GetTaskTargetDesc(desc, progress, totalProgress, isShowRate, isShowTotalProgress, isFinish)
	local text = ""

	if not isShowRate then
		text = desc
	elseif isShowTotalProgress then
		text = desc .. " " .. progress .. "/" .. totalProgress
	else
		text = desc .. " " .. progress
	end

	if progress == -1 then
		text = desc .. self:GetCfgText(2300153)
	end

	return text
end

function MazeMainUIApi:GetAddExploreValueNotice(percent)
	return "+" .. percent .. "%"
end

function MazeMainUIApi:GetMapUIAssets()
	local paths = {}

	for i = 1, #MazeMainUIApi.MapElementPaths do
		table.insert(paths, UIGlobalApi.GetUIPrefab(MazeMainUIApi.MapElementPaths[i]))
	end

	table.insert(paths, UIGlobalApi.GetUIPrefab("/_MazeMainUI/SmallMap/Node"))
	table.insert(paths, UIGlobalApi.GetUIPrefab("/_MazeMainUI/SmallMap/Path"))

	return paths
end

function MazeMainUIApi:GetMapElementPath(elementType, isHero)
	local path

	if isHero then
		path = MazeMainUIApi.MapElementPaths[1]
	elseif elementType == 3 then
		path = MazeMainUIApi.MapElementPaths[2]
	elseif elementType == 10 then
		path = MazeMainUIApi.MapElementPaths[2]
	elseif elementType == 11 then
		path = MazeMainUIApi.MapElementPaths[2]
	elseif elementType == 7 then
		path = MazeMainUIApi.MapElementPaths[3]
	elseif elementType == 30 then
		path = MazeMainUIApi.MapElementPaths[4]
	elseif elementType == 101 then
		path = MazeMainUIApi.MapElementPaths[5]
	elseif elementType == 50 then
		path = MazeMainUIApi.MapElementPaths[24]
	elseif elementType == 51 then
		path = MazeMainUIApi.MapElementPaths[25]
	elseif elementType == 52 then
		path = MazeMainUIApi.MapElementPaths[26]
	elseif elementType == 31 then
		path = MazeMainUIApi.MapElementPaths[27]
	elseif elementType == 70 then
		path = MazeMainUIApi.MapElementPaths[28]
	elseif elementType == 8 then
		path = MazeMainUIApi.MapElementPaths[29]
	elseif elementType == 32 then
		path = MazeMainUIApi.MapElementPaths[30]
	elseif elementType == 60 then
		path = MazeMainUIApi.MapElementPaths[31]
	elseif elementType == 5250 then
		path = MazeMainUIApi.MapElementPaths[31]
	elseif elementType == 4022 then
		path = MazeMainUIApi.MapElementPaths[32]
	elseif elementType == 4062 then
		path = MazeMainUIApi.MapElementPaths[2]
	elseif elementType == 200 then
		path = MazeMainUIApi.MapElementPaths[33]
	elseif elementType == 201 then
		path = MazeMainUIApi.MapElementPaths[34]
	elseif elementType == 202 then
		path = MazeMainUIApi.MapElementPaths[35]
	elseif elementType == 203 then
		path = MazeMainUIApi.MapElementPaths[36]
	elseif elementType == 204 then
		path = MazeMainUIApi.MapElementPaths[37]
	elseif elementType == 205 then
		path = MazeMainUIApi.MapElementPaths[38]
	elseif elementType == 206 then
		path = MazeMainUIApi.MapElementPaths[39]
	elseif elementType == 207 then
		path = MazeMainUIApi.MapElementPaths[40]
	elseif elementType == 208 then
		path = MazeMainUIApi.MapElementPaths[41]
	elseif elementType == 209 then
		path = MazeMainUIApi.MapElementPaths[42]
	elseif elementType == 3000 then
		path = MazeMainUIApi.MapElementPaths[43]
	elseif elementType == 3001 then
		path = MazeMainUIApi.MapElementPaths[44]
	elseif elementType == 3002 then
		path = MazeMainUIApi.MapElementPaths[45]
	elseif elementType == 3003 then
		path = MazeMainUIApi.MapElementPaths[46]
	elseif elementType == 210 then
		path = MazeMainUIApi.MapElementPaths[47]
	end

	if path ~= nil then
		return UIGlobalApi.GetUIPrefab(path)
	end
end

function MazeMainUIApi:GetMaskHeight()
	return 180
end

function MazeMainUIApi:GetStartTitleText()
	return self:GetCfgText(2200015)
end

function MazeMainUIApi:GetStartTipText(conditionsDesc)
	return ""
end

function MazeMainUIApi:GetExploreLabel()
	return self:GetCfgText(2300010)
end

function MazeMainUIApi:GetExploreProgressText(percent)
	return string.format("%s%%", percent)
end

function MazeMainUIApi:GetServiceTriggerButtonDuration(percent)
	return 0.2
end

function MazeMainUIApi:GetDollLevelText(level, chapterType)
	if chapterType == 7 then
		return "Lv." .. level
	end

	return ""
end

function MazeMainUIApi:GetServiceTriggerNoticeBtnText()
	return self:GetCfgText(2300150)
end

function MazeMainUIApi:GetQuitBtnText()
	return self:GetCfgText(1317007)
end

function MazeMainUIApi:GetBigMapTitleText()
	return self:GetCfgText(2300151)
end

MazeMainUIApi:Init()
