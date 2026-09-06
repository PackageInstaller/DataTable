-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/components/TableviewSpineMgr.lua

module("logiccommon.common.components.TableviewSpineMgr", package.seeall)

local TableviewSpineMgr = class("TableviewSpineMgr", ViewResLoadMgr)

function TableviewSpineMgr.get(view)
	local mgr = TableviewSpineMgr.New(view)

	ViewResLoadMgr.mgrs = ViewResLoadMgr.mgrs or {}
	ViewResLoadMgr.mgrs[view.viewName] = mgr

	return mgr
end

function TableviewSpineMgr:loadSpine(cell, faceId, isAtuo, callback, callbackObj)
	local _, resPath = CharacterConfig.instance:GetCharacterResIdx(faceId, isAtuo or false)

	self:load(cell, resPath, callback, callbackObj)
end

return TableviewSpineMgr
