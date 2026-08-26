-- chunkname: @modules/logic/versionactivity2_5/challenge/view/dungeon/detail/Act183DungeonCompMgr.lua

module("modules.logic.versionactivity2_5.challenge.view.dungeon.detail.Act183DungeonCompMgr", package.seeall)

local Act183DungeonCompMgr = class("Act183DungeonCompMgr", LuaCompBase)
local StatusEnum = {
	Running = 3,
	Idle = 2,
	Init = 1
}

function Act183DungeonCompMgr:init(go)
	self:__onInit()

	self.go = go
	self.compInstMap = {}
	self.compInstList = {}
	self.layoutCompInstMap = {}
	self.layoutCompInstList = {}
	self._scrolldetail = gohelper.findChildScrollRect(self.go, "#scroll_detail")
	self._goScrollContent = gohelper.findChild(self.go, "#scroll_detail/Viewport/Content")
	self._status = StatusEnum.Init
end

function Act183DungeonCompMgr:addComp(go, clsDefine, useLayout)
	if self.compInstMap[clsDefine] then
		logError(string.format("重复挂载 clsDefine = %s", clsDefine))

		return
	end

	local clsInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, clsDefine)

	clsInst.mgr = self
	self.compInstMap[clsDefine] = clsInst

	table.insert(self.compInstList, clsInst)

	if useLayout then
		self.layoutCompInstMap[clsDefine] = clsInst

		table.insert(self.layoutCompInstList, clsInst)
	end
end

function Act183DungeonCompMgr:onUpdateMO(episodeMo)
	self._status = StatusEnum.Running

	for _, detailComp in ipairs(self.compInstList) do
		detailComp:onUpdateMO(episodeMo)
	end

	self._status = StatusEnum.Idle

	self:_reallyFocus()
end

function Act183DungeonCompMgr:getComp(clsDefine)
	local compInst = self.compInstMap[clsDefine]

	if not compInst then
		logError("组件不存在" .. clsDefine.__cname)
	end

	return compInst
end

function Act183DungeonCompMgr:getFuncValue(clsDefine, funcName, ...)
	local compInst = self:getComp(clsDefine)

	if compInst then
		local func = compInst[funcName]

		if not func then
			logError(string.format("方法不存在 clsDefine = %s, funcName = %s", clsDefine.__cname, funcName))

			return
		end

		return func(compInst, ...)
	end
end

function Act183DungeonCompMgr:getFieldValue(clsDefine, fieldName)
	local compInst = self:getComp(clsDefine)

	return compInst and compInst[fieldName]
end

function Act183DungeonCompMgr:isCompVisible(clsDefine)
	local compInst = self:getComp(clsDefine)

	return compInst and compInst:checkIsVisible()
end

function Act183DungeonCompMgr:focus(targetCompCls, ...)
	local focusTargetInst = self.layoutCompInstMap[targetCompCls]

	if not focusTargetInst then
		local clsDefName = targetCompCls and targetCompCls.__cname

		logError(string.format("定位失败, 定位目标组件不存在!!! cls = %s", clsDefName))

		return
	end

	self._focusTargetInst = focusTargetInst
	self._focusParams = {
		...
	}
	self._waitFocus = true

	if self._status ~= StatusEnum.Idle then
		return
	end

	self:_reallyFocus()
end

function Act183DungeonCompMgr:_reallyFocus()
	if not self._waitFocus then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self._goScrollContent.transform)

	local scrollPixelY = 0
	local find = false

	for _, compInst in ipairs(self.layoutCompInstList) do
		if compInst == self._focusTargetInst then
			local offset = compInst:focus(unpack(self._focusParams)) or 0

			scrollPixelY = scrollPixelY + offset
			find = true

			break
		end

		local height = compInst:getHeight() or 0

		scrollPixelY = scrollPixelY + height
	end

	scrollPixelY = find and scrollPixelY or 0

	local scrollContentHeight = recthelper.getHeight(self._goScrollContent.transform)
	local scrollHeight = recthelper.getHeight(self._scrolldetail.transform)

	self._scrolldetail.verticalNormalizedPosition = 1 - math.abs(scrollPixelY) / (scrollContentHeight - scrollHeight)
	self._waitFocus = false
	self._focusTargetInst = nil
	self._focusParams = nil
end

function Act183DungeonCompMgr:onDestroy()
	self:__onDispose()
end

return Act183DungeonCompMgr
