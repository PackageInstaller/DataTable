-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/DebugNewArenaSetUpRank.lua

DebugNewArenaSetUpRank = class("DebugNewArenaSetUpRank", DebugViewTemplate, _M)

function DebugNewArenaSetUpRank:initialize()
	self._opType = 415
	self._viewConfig = {
		{
			default = 100,
			name = "rank",
			title = "设置排名",
			type = "Input"
		}
	}
end

DebugNewArenaSetUpMaxRank = class("DebugNewArenaSetUpMaxRank", DebugViewTemplate, _M)

function DebugNewArenaSetUpMaxRank:initialize()
	self._opType = 416
	self._viewConfig = {
		{
			default = 100,
			name = "maxRank",
			title = "设置最大排名",
			type = "Input"
		}
	}
end

DebugNewArenaAddRole = class("DebugNewArenaAddRole", DebugViewTemplate, _M)

function DebugNewArenaAddRole:initialize()
	self._opType = 417
	self._viewConfig = {
		{
			default = 1,
			name = "groupId",
			title = "分组ID",
			type = "Input"
		},
		{
			default = 10,
			name = "num",
			title = "人数",
			type = "Input"
		}
	}
end

DebugNewArenaCheckRoleNum = class("DebugNewArenaCheckRoleNum", DebugViewTemplate, _M)

function DebugNewArenaCheckRoleNum:initialize()
	self._opType = 418
	self._viewConfig = {
		{
			default = 1,
			name = "groupId",
			title = "分组ID",
			type = "Input"
		}
	}
end

function DebugNewArenaCheckRoleNum:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = table.nums(response.data)
			}))
		end
	end)
end

DebugNewArenaGroupNum = class("DebugNewArenaGroupNum", DebugViewTemplate, _M)

function DebugNewArenaGroupNum:initialize()
	self._opType = 419
	self._viewConfig = {
		{
			default = "",
			name = "groupId",
			title = "查询",
			type = "Label"
		}
	}
end

function DebugNewArenaGroupNum:onClick(data)
	local dataModificationDS = self:getInjector():getInstance(DataModificationDS)

	dataModificationDS:requestTest(data, function(response)
		local isSucc = response.resCode == GS_SUCCESS

		self:dispatch(ShowTipEvent({
			tip = Strings:get(isSucc and "EXEC_SUCC" or "EXEC_FAIL")
		}))

		if isSucc then
			self:dispatch(ShowTipEvent({
				tip = table.nums(response.data)
			}))
			self:showAlert(response.data)
		end
	end)
end

function DebugNewArenaGroupNum:showAlert(resData)
	local text = ""

	for k, d in pairs(resData) do
		text = text .. k .. " : "

		for i, v in ipairs(d) do
			text = text .. v .. "    "
		end

		text = text .. "\n"
	end

	text = string.format("<font face='asset/font/CustomFont_FZYH_M.TTF' size='18' color='#D2D2D2'>%s</font>", text)

	local data = {
		isRich = true,
		title = table.nums(resData),
		content = text,
		sureBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, {}))
end
