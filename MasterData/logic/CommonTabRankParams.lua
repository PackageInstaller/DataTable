-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/commontabrank/data/CommonTabRankParams.lua

module("logic.extensions.commontabrank.data.CommonTabRankParams", package.seeall)

local CommonTabRankParams = class("CommonTabRankParams")

function CommonTabRankParams:ctor()
	self._tabDataDic = {}
	self._tabKeyList = {}
end

function CommonTabRankParams:onReset()
	table.clear(self._tabDataDic)
	table.clear(self._tabKeyList)

	self._defaultTabKey = nil
end

function CommonTabRankParams:addTabData(tabKey, viewName, tabName, viewParams)
	self._tabDataDic[tabKey] = {
		viewName = viewName,
		tabName = tabName,
		viewParams = viewParams
	}

	table.insert(self._tabKeyList, tabKey)
end

function CommonTabRankParams:getTabKeyList()
	return self._tabKeyList
end

function CommonTabRankParams:getTabData(key)
	return key and self._tabDataDic[key]
end

function CommonTabRankParams:setDafaultOpenTab(key)
	self._defaultTabKey = key
end

function CommonTabRankParams:getDafaultOpenTab()
	return self._defaultTabKey
end

function CommonTabRankParams:setOnEnterCallBackInFather(onEnterCallBack)
	self._onEnterCallBack = onEnterCallBack
end

function CommonTabRankParams:getOnEnterCallBackInFather()
	return self._onEnterCallBack
end

function CommonTabRankParams:setOnExitCallBackInFather(onExitCallBack)
	self._onExitCallBack = onExitCallBack
end

function CommonTabRankParams:getOnExitCallBackInFather()
	return self._onExitCallBack
end

return CommonTabRankParams
