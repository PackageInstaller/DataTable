-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/StageOneKeyFinish.lua

StageOneKeyFinish = class("StageOneKeyFinish", DebugViewTemplate, _M)

function StageOneKeyFinish:initialize()
	self._opType = 124
	self._viewConfig = {
		{
			default = "M09S01",
			name = "pointId",
			title = "关卡Id",
			type = "Input"
		}
	}
end

function StageOneKeyFinish:onClick(data)
	local pointId = data.pointId

	if not pointId or pointId == "" then
		return
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:storyFinish()
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

function StageOneKeyFinish:storyFinish()
	local stageSystem = self:getInjector():getInstance(StageSystem)

	stageSystem:debugStoryAutoFinish()
end

PointOneKeyFinish = class("PointOneKeyFinish", DebugViewTemplate, _M)

function PointOneKeyFinish:initialize()
	self._opType = 293
	self._viewConfig = {
		{
			default = "M03S01",
			name = "pointId",
			title = "关卡Id",
			type = "Input"
		}
	}
end

function PointOneKeyFinish:onClick(data)
	local pointId = data.pointId

	if not pointId or pointId == "" then
		return
	end

	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
			}))
		end
	end)
end

ActivityStageFinish = class("ActivityStageFinish", DebugViewTemplate, _M)

function ActivityStageFinish:initialize()
	self._opType = 235
	self._viewConfig = {
		{
			default = "",
			name = "blockId",
			title = "指定副本(关卡ID)",
			type = "Input"
		},
		{
			default = "1",
			name = "isAll",
			title = "解锁全部:0:全部，1:不全部",
			type = "Input"
		}
	}
end

DreamChallengeFinish = class("DreamChallengeFinish", DebugViewTemplate, _M)

function DreamChallengeFinish:initialize()
	self._opType = 236
	self._viewConfig = {
		{
			default = "",
			name = "dreamId",
			title = "梦境塔id",
			type = "Input"
		},
		{
			default = "1",
			name = "mapIdx",
			title = "子章节索引（1、2、3....）",
			type = "Input"
		},
		{
			default = "1",
			name = "pointIdx",
			title = "关卡索引（1、2、3....）",
			type = "Input"
		}
	}
end

NewActivityStageFinish = class("NewActivityStageFinish", DebugViewTemplate, _M)

function NewActivityStageFinish:initialize()
	self._opType = 304
	self._viewConfig = {
		{
			default = "1",
			name = "isAll",
			title = "解锁全部:0:全部，1:不全部",
			type = "Input"
		}
	}
end
