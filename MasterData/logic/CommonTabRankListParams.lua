-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/data/CommonTabRankListParams.lua

module("logic.extensions.commontabrank.data.CommonTabRankListParams", package.seeall)

local CommonTabRankListParams = class("CommonTabRankListParams")

function CommonTabRankListParams:ctor()
	self._tabDataDic = {}
	self._tabKeyList = {}
end

function CommonTabRankListParams:onReset()
	table.clear(self._tabDataDic)
	table.clear(self._tabKeyList)

	self._defaultTabKey = nil
end

function CommonTabRankListParams:addTabData(headTabId, secTabId, tabKey, viewName, tabName, viewParams)
	self._tabDataDic[tabKey] = {
		headTabId = headTabId,
		secTabId = secTabId,
		tabKey = tabKey,
		viewName = viewName,
		tabName = tabName,
		viewParams = viewParams
	}

	table.insert(self._tabKeyList, tabKey)
end

function CommonTabRankListParams:getTabKeyList()
	return self._tabKeyList
end

function CommonTabRankListParams:getTabData(key)
	return key and self._tabDataDic[key]
end

function CommonTabRankListParams:setDafaultOpenTab(key)
	self._defaultTabKey = key
end

function CommonTabRankListParams:getDafaultOpenTab()
	return self._defaultTabKey
end

function CommonTabRankListParams:setOnEnterCallBackInFather(onEnterCallBack)
	self._onEnterCallBack = onEnterCallBack
end

function CommonTabRankListParams:getOnEnterCallBackInFather()
	return self._onEnterCallBack
end

function CommonTabRankListParams:setOnExitCallBackInFather(onExitCallBack)
	self._onExitCallBack = onExitCallBack
end

function CommonTabRankListParams:getOnExitCallBackInFather()
	return self._onExitCallBack
end

return CommonTabRankListParams
