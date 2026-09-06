-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fiveyearrecap/config/FiveYearRecapConfig.lua

module("logic.extensions.fiveyearrecap.config.FiveYearRecapConfig", package.seeall)

local FiveYearRecapConfig = class("FiveYearRecapConfig", BaseConfig)

function FiveYearRecapConfig:getNames()
	return {
		"five_year_recap_activity",
		"five_year_recap_adapter",
		"five_year_recap_adapter_rankplan",
		"five_year_recap_data_ids",
		"five_year_recap_login_days_prize",
		"five_year_recap_online_prize",
		"five_year_recap_online_unlock",
		"five_year_recap_person_tag",
		"five_year_recap_page",
		"five_year_recap_report_page",
		"five_year_recap_report_summary"
	}
end

function FiveYearRecapConfig:handleConfig(name, content)
	if name == "five_year_recap_activity" then
		self._five_year_recap_activity = content
	elseif name == "five_year_recap_adapter" then
		self._five_year_recap_adapter = content
	elseif name == "five_year_recap_adapter_rankplan" then
		self._five_year_recap_adapter_rankplan = content
	elseif name == "five_year_recap_data_ids" then
		self._five_year_recap_data_ids = content
	elseif name == "five_year_recap_login_days_prize" then
		self._five_year_recap_login_days_prize = content
	elseif name == "five_year_recap_online_prize" then
		self._five_year_recap_online_prize = content
	elseif name == "five_year_recap_online_unlock" then
		self._five_year_recap_online_unlock = content

		self:_handleOnlineUnlockConfig(content.dataList)
	elseif name == "five_year_recap_page" then
		self._five_year_recap_page = content
	elseif name == "five_year_recap_person_tag" then
		self._five_year_recap_person_tag = content
	elseif name == "five_year_recap_report_page" then
		self._five_year_recap_report_page = content
	elseif name == "five_year_recap_report_summary" then
		self._five_year_recap_report_summary = content
	end
end

function FiveYearRecapConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function FiveYearRecapConfig:getActivityData(activityId)
	return self:_safeGet(self._five_year_recap_activity, activityId)
end

function FiveYearRecapConfig:getDataIdsData(id)
	return self:_safeGet(self._five_year_recap_data_ids, id)
end

function FiveYearRecapConfig:getDataIdsDataList()
	local t = self._five_year_recap_data_ids

	return (t or nil) and (t.dataList or {})
end

function FiveYearRecapConfig:getLoginDaysPrizeDatas(activityId)
	return self:_safeGet(self._five_year_recap_login_days_prize, activityId)
end

function FiveYearRecapConfig:getLoginDaysPrizeData(activityId, prizeId)
	return self:_safeGet(self._five_year_recap_login_days_prize, activityId, prizeId)
end

function FiveYearRecapConfig:getOnlineUnlockDatas(activityId)
	return self:_safeGet(self._five_year_recap_online_unlock, activityId)
end

function FiveYearRecapConfig:getOnlineUnlockData(activityId, onlineMinute)
	return self:_safeGet(self._five_year_recap_online_unlock, activityId, onlineMinute)
end

function FiveYearRecapConfig:getOnlineUnlockDataList(activityId)
	return self._onlineUnlockDataList[activityId] or {}
end

function FiveYearRecapConfig:getOnlineUnlockDataByMinute(activityId, minute)
	local tb = self:getOnlineUnlockDatas(activityId)

	return MmUtil.unorderedSearchInSingleKey(tb, "onlineMinute", minute)
end

function FiveYearRecapConfig:_handleOnlineUnlockConfig(dataList)
	self._onlineUnlockDataList = {}

	for _, data in ipairs(dataList) do
		self._onlineUnlockDataList[data.activityId] = self._onlineUnlockDataList[data.activityId] or {}

		table.insert(self._onlineUnlockDataList[data.activityId], data)
	end

	for activityId, datas in pairs(self._onlineUnlockDataList) do
		table.sort(datas, function(a, b)
			return a.onlineMinute < b.onlineMinute
		end)
	end
end

function FiveYearRecapConfig:getOnlinePrizeDatas(activityId)
	return self:_safeGet(self._five_year_recap_online_prize, activityId)
end

function FiveYearRecapConfig:getOnlinePrizeData(activityId, pieceId)
	return self:_safeGet(self._five_year_recap_online_prize, activityId, pieceId)
end

function FiveYearRecapConfig:getAdapterData(adapterType)
	return self:_safeGet(self._five_year_recap_adapter, adapterType)
end

function FiveYearRecapConfig:getAdapterDataList()
	local t = self._five_year_recap_adapter

	return (t or nil) and (t.dataList or {})
end

function FiveYearRecapConfig:getAdapterRankplanDatas(rankPlanId)
	return self:_safeGet(self._five_year_recap_adapter_rankplan, rankPlanId)
end

function FiveYearRecapConfig:getAdapterRankplanData(rankPlanId, id)
	return self:_safeGet(self._five_year_recap_adapter_rankplan, rankPlanId, id)
end

function FiveYearRecapConfig:getAdapterRankplanDataByRank(rankPlanId, rank)
	local datas = self:getAdapterRankplanDatas(rankPlanId)

	return MmUtil.binarySearchInSingleKey(datas, "rank", rank)
end

function FiveYearRecapConfig:getAdapterRankplanValueByRank(rankPlanId, rank)
	local data = self:getAdapterRankplanDataByRank(rankPlanId, rank)

	return (data or nil) and (data.value or nil)
end

function FiveYearRecapConfig:getPageDatas(activityId)
	return self:_safeGet(self._five_year_recap_page, activityId)
end

function FiveYearRecapConfig:getPageData(activityId, pageId)
	return self:_safeGet(self._five_year_recap_page, activityId, pageId)
end

function FiveYearRecapConfig:getPersonTagDatas(activityId)
	return self:_safeGet(self._five_year_recap_person_tag, activityId)
end

function FiveYearRecapConfig:getPersonTagData(activityId, tagId)
	return self:_safeGet(self._five_year_recap_person_tag, activityId, tagId)
end

function FiveYearRecapConfig:getPersonTagDataListByPageId(activityId, pageId)
	local datas = self:getPersonTagDatas(activityId)
	local list = {}

	for _, data in ipairs(datas) do
		if data.pageId == pageId then
			table.insert(list, data)
		end
	end

	return list
end

function FiveYearRecapConfig:getReportPageDatass(activityId)
	return self:_safeGet(self._five_year_recap_report_page, activityId)
end

function FiveYearRecapConfig:getReportPageDatas(activityId, pageId)
	return self:_safeGet(self._five_year_recap_report_page, activityId, pageId)
end

function FiveYearRecapConfig:getReportPageData(activityId, pageId, barId)
	return self:_safeGet(self._five_year_recap_report_page, activityId, pageId, barId)
end

function FiveYearRecapConfig:getReportSummaryDatasss(activityId)
	return self:_safeGet(self._five_year_recap_report_summary, activityId)
end

function FiveYearRecapConfig:getReportSummaryDatass(activityId, partId)
	return self:_safeGet(self._five_year_recap_report_summary, activityId, partId)
end

function FiveYearRecapConfig:getReportSummaryDatas(activityId, partId, barId)
	return self:_safeGet(self._five_year_recap_report_summary, activityId, partId, barId)
end

function FiveYearRecapConfig:getReportSummaryData(activityId, partId, barId, index)
	return self:_safeGet(self._five_year_recap_report_summary, activityId, partId, barId, index)
end

FiveYearRecapConfig.instance = FiveYearRecapConfig.New()

return FiveYearRecapConfig
