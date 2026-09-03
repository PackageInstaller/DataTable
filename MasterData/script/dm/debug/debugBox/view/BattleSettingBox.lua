-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/BattleSettingBox.lua

BattleLoadingBox = class("BattleLoadingBox", DebugViewTemplate, _M)

function BattleLoadingBox:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "FileName",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "开启/关闭战斗开始loading",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				table.insert(ret, {
					"1",
					"开启战斗开始loading"
				})
				table.insert(ret, {
					"2",
					"关闭战斗开始loading"
				})

				return ret
			end
		}
	}
end

function BattleLoadingBox:onClick(data)
	local mText = self._viewConfig[1].mtext

	GameConfigs.CloseBattleLoading = tostring(mText) == "1"

	self:dispatch(ShowTipEvent({
		tip = "设置完成"
	}))
end

HealthMultiBox = class("HealthMultiBox", DebugViewTemplate, _M)

function HealthMultiBox:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "FileName",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "设置血量增加倍数",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				table.insert(ret, {
					"1",
					"5倍血量"
				})
				table.insert(ret, {
					"2",
					"10倍血量"
				})
				table.insert(ret, {
					"3",
					"100倍血量"
				})

				return ret
			end
		}
	}
end

function HealthMultiBox:onClick(data)
	local mText = self._viewConfig[1].mtext

	GameConfigs.healthMulti = tostring(mText) == "1" and 5 or tostring(mText) == "2" and 10 or tostring(mText) == "3" and 100 or tonumber(mText)

	self:dispatch(ShowTipEvent({
		tip = "设置完成"
	}))
end

BattleSoundBox = class("BattleSoundBox", DebugViewTemplate, _M)

function BattleSoundBox:initialize()
	self._viewConfig = {
		{
			default = "FLYDe",
			name = "heroId",
			title = "heroId",
			type = "Input"
		},
		{
			default = "skill1,skill2,skill3",
			name = "skills",
			title = "skills",
			type = "Input"
		},
		{
			default = "",
			name = "modelId",
			title = "modelId",
			type = "Input"
		}
	}
end

function BattleSoundBox:onClick(data)
	GameConfigs.debugHeroId = data.heroId

	if data.skills and data.skills ~= "" then
		GameConfigs.debugSkills = string.split(data.skills, ",")
	end

	if data.modelId and data.modelId ~= "" then
		GameConfigs.debugModelId = data.modelId
	end

	local GuideLauncher = require("dm.battle.guide.GuideLauncher")

	GuideLauncher:enterGuideBattle(self, videoCallback, "GuideBattleDebug")

	local debugBox = self:getInjector():getInstance("DebugBox")

	debugBox:hide()
end

OtherSoundBox = class("OtherSoundBox", DebugViewTemplate, _M)

function OtherSoundBox:initialize()
	self._viewConfig = {
		{
			default = "Voice_SDTZi_67",
			name = "soundId",
			title = "soundId",
			type = "Input"
		}
	}
end

function OtherSoundBox:onClick(data)
	AudioEngine:getInstance():playEffect(data.soundId)
end

DumpUnitPropertiesBox = class("DumpUnitPropertiesBox", DebugViewTemplate, _M)

function DumpUnitPropertiesBox:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "FileName",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "开启/关闭打印实时属性",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				table.insert(ret, {
					"1",
					"开启打印实时属性"
				})
				table.insert(ret, {
					"2",
					"关闭打印实时属性"
				})

				return ret
			end
		}
	}
end

function DumpUnitPropertiesBox:onClick(data)
	local mText = self._viewConfig[1].mtext

	GameConfigs.DumpUnitProperties = tostring(mText) == "1"

	self:dispatch(ShowTipEvent({
		tip = "设置完成"
	}))
end

NoAiSetBox = class("NoAiSetBox", DebugViewTemplate, _M)

function NoAiSetBox:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "FileName",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "开启/关闭顺序出牌",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				table.insert(ret, {
					"1",
					"开启顺序出牌"
				})
				table.insert(ret, {
					"2",
					"关闭顺序出牌"
				})

				return ret
			end
		}
	}
end

function NoAiSetBox:onClick(data)
	local mText = self._viewConfig[1].mtext

	GameConfigs.ShowAiWeightBox = tostring(mText) == "1"

	self:dispatch(ShowTipEvent({
		tip = "设置完成"
	}))
end

ShowAiWeightBox = class("ShowAiWeightBox", DebugViewTemplate, _M)

function ShowAiWeightBox:initialize()
	self._viewConfig = {
		{
			default = "",
			name = "FileName",
			_selectBoxShow = true,
			type = "SelectBox",
			title = "开启/关闭AI权重显示",
			_selectBoxAutoHide = true,
			selectHandler = function(selectStr)
				local ret = {}

				table.insert(ret, {
					"1",
					"开启AI权重显示"
				})
				table.insert(ret, {
					"2",
					"关闭AI权重显示"
				})

				return ret
			end
		}
	}
end

function ShowAiWeightBox:onClick(data)
	local mText = self._viewConfig[1].mtext

	GameConfigs.ShowAiWeightBox = tostring(mText) == "1"

	self:dispatch(ShowTipEvent({
		tip = "设置完成"
	}))
end

ChangeDEBUGValue = class("ChangeDEBUGValue", DebugViewTemplate, _M)

function ChangeDEBUGValue:initialize()
	self._viewConfig = {
		{
			default = "0",
			name = "value",
			title = "DEBUG:0,1,2",
			type = "Input"
		}
	}
end

function ChangeDEBUGValue:onClick(data)
	DEBUG = tonumber(data.value)

	self:dispatch(ShowTipEvent({
		tip = "设置成功"
	}))
end
