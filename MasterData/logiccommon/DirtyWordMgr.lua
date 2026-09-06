-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/lang/DirtyWordMgr.lua

module("logiccommon.common.lang.DirtyWordMgr", package.seeall)

local DirtyWordMgr = class("DirtyWordMgr")

function DirtyWordMgr:ctor()
	self._filter = Framework.DirtyWordFilter.New()
	self._filterForName = Framework.DirtyWordFilter.New()
end

function DirtyWordMgr:init(textAsset, textAssetForName, t2sch)
	self._filter:AddContentTextAsset(textAsset)
	self._filterForName:AddContentTextAsset(textAssetForName)
	Framework.DirtyWordFilter.AddT2SChineseTextAsset(t2sch)
end

function DirtyWordMgr:filter(text)
	local isMatched, resultStr = self._filter:Filter(text, false, nil)

	if resultStr == nil then
		return text
	else
		return resultStr, isMatched
	end
end

function DirtyWordMgr:filterForName(text)
	local isMatched, resultStr = self._filterForName:Filter(text, false, nil)

	if resultStr == nil then
		return text
	else
		return resultStr, isMatched
	end
end

DirtyWordMgr.instance = DirtyWordMgr.New()

return DirtyWordMgr
