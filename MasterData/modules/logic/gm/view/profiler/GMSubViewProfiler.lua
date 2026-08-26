-- chunkname: @modules/logic/gm/view/profiler/GMSubViewProfiler.lua

module("modules.logic.gm.view.profiler.GMSubViewProfiler", package.seeall)

local GMSubViewProfiler = class("GMSubViewProfiler", GMSubViewBase)

function GMSubViewProfiler:ctor()
	self.tabName = "Profiler"
end

function GMSubViewProfiler:addLineIndex()
	self.lineIndex = self.lineIndex + 1
end

function GMSubViewProfiler:getLineGroup()
	return "L" .. self.lineIndex
end

function GMSubViewProfiler:initViewContent()
	if self._inited then
		return
	end

	GMSubViewBase.initViewContent(self)

	self.lineIndex = 1

	self:addTitleSplitLine("Lua内存占用")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "Lua开始统计", self.luaMemoryCalBegin, self)
	self.addButton(self, self:getLineGroup(), "Lua结束统计", self.luaMemoryCalEnd, self)
	self:addTitleSplitLine("Lua函数内存消耗统计")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "函数内存开始统计", self.luaFunMemoryCalBegin, self)
	self.addButton(self, self:getLineGroup(), "函数内存结束统计", self.luaFunMemoryCalEnd, self)
	self:addTitleSplitLine("LuaEvent调用分析")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "Event开始统计", self.eventCalBegin, self)
	self.addButton(self, self:getLineGroup(), "Event结束统计", self.eventCalEnd, self)
	self:addTitleSplitLine("PROFILER")
	self:addLineIndex()
	self.addButton(self, self:getLineGroup(), "性能文件输出", self.profilerCalOut, self)
	self.addButton(self, self:getLineGroup(), "清空记录", self.clearRecord, self)
	self:addTitleSplitLine("性能数据")
	self:addLineIndex()

	self._recordText = self.addButton(self, self:getLineGroup(), "开启连接", self.initProfilerConnection, self)[2]
end

function GMSubViewProfiler:luaFunMemoryCalBegin()
	LuaProfilerController.instance:luaFunMemoryCalBegin()
end

function GMSubViewProfiler:luaFunMemoryCalEnd()
	LuaProfilerController.instance:luaFunMemoryCalEnd()
end

function GMSubViewProfiler:luaMemoryCalBegin()
	LuaProfilerController.instance:luaMemoryCalBegin()
end

function GMSubViewProfiler:luaMemoryCalEnd()
	LuaProfilerController.instance:luaMemoryCalEnd()
end

function GMSubViewProfiler:eventCalBegin()
	LuaProfilerController.instance:collectEventParamsState()
end

function GMSubViewProfiler:eventCalEnd()
	LuaProfilerController.instance:collectEventParamsState()
end

function GMSubViewProfiler:profilerCalOut()
	ZProj.ProfilerMan.Instance.IsProfiler = false

	ZProj.ProfilerMan.Instance:outCsv()
end

function GMSubViewProfiler:clearRecord()
	ZProj.ProfilerMan.Instance.IsProfiler = true

	ZProj.ProfilerMan.Instance:BeginRecord()
end

function GMSubViewProfiler:_onLangDropChange(index)
	ZProj.ProfilerMan.Instance.IsProfiler = index == 1
end

function GMSubViewProfiler:initProfilerConnection()
	PerformanceRecorder.initProfilerConnection()

	self._recordText.text = "已开启"
end

return GMSubViewProfiler
