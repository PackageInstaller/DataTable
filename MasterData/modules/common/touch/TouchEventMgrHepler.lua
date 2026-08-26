-- chunkname: @modules/common/touch/TouchEventMgrHepler.lua

module("modules.common.touch.TouchEventMgrHepler", package.seeall)

local TouchEventMgrHepler = class("TouchEventMgrHepler")
local TouchEventMgr = ZProj.TouchEventMgr
local _allMgrs = {}

function TouchEventMgrHepler.getTouchEventMgr(gameObject)
	local touchMgr = TouchEventMgr.Get(gameObject)

	if SDKNativeUtil.isGamePad() and tabletool.indexOf(_allMgrs, touchMgr) == nil then
		table.insert(_allMgrs, touchMgr)
		touchMgr:SetDestroyCb(TouchEventMgrHepler._remove, nil)
	end

	return touchMgr
end

function TouchEventMgrHepler.getAllMgrs()
	return _allMgrs
end

function TouchEventMgrHepler.remove(touchMgr)
	if not gohelper.isNil(touchMgr) then
		touchMgr:ClearAllCallback()
		TouchEventMgrHepler._remove(touchMgr)
	end
end

function TouchEventMgrHepler._remove(touchMgr)
	tabletool.removeValue(_allMgrs, touchMgr)
end

return TouchEventMgrHepler
