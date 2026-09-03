-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/AddMyEquip.lua

AddMyEquip = class("AddMyEquip", DebugViewTemplate, _M)

function AddMyEquip:initialize()
	self._opType = 274
	self._viewConfig = {
		{
			title = "添加所有装备",
			name = "AddMyEquip",
			type = "Label"
		}
	}
end

OneKeyEquip = class("OneKeyEquip", DebugViewTemplate, _M)

function OneKeyEquip:initialize()
	self._opType = 119
	self._viewConfig = {
		{
			default = "10",
			name = "count",
			title = "装备数量",
			type = "Input"
		},
		{
			default = "30",
			name = "strongerLv",
			title = "强化",
			type = "Input"
		},
		{
			default = "14",
			name = "quality",
			title = "资质",
			type = "Input"
		}
	}
end

OneKeyDownEquip = class("OneKeyDownEquip", DebugViewTemplate, _M)

function OneKeyDownEquip:initialize()
	self._opType = 121
	self._viewConfig = {}
end

OneKeyAwake = class("OneKeyAwake", DebugViewTemplate, _M)

function OneKeyAwake:initialize()
	self._opType = 120
	self._viewConfig = {
		{
			default = "",
			name = "heroId",
			title = "指定英魂ID,默认all",
			type = "Input"
		}
	}
end

OneKeyBestEquip = class("OneKeyBestEquip", DebugViewTemplate, _M)

function OneKeyBestEquip:initialize()
	self._opType = 275
	self._viewConfig = {
		{
			default = "",
			name = "level",
			title = "强化等级",
			type = "Input"
		}
	}
end
