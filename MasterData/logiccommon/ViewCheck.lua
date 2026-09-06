-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewcheck/ViewCheck.lua

module("logiccommon.common.viewcheck.ViewCheck", package.seeall)

local ViewCheck = class("ViewCheck")

ViewCheck.Debug = {}
ViewCheck.Debug.viewLog = false

function ViewCheck:ctor()
	self.view_open_time_record = {}
end

function ViewCheck:recordStartTime(view_name)
	if not self:CanCheck() then
		return
	end

	if self:isWhiteView(view_name) then
		return
	end

	local record = self:hasRecord(view_name)

	if record then
		if view_name == "mainui" then
			return
		end

		if record.count and record.count > 4 then
			return
		end

		table.insert(record.start_time, os.clock())
		table.insert(record.instance_time, -1)
	else
		local temp_record = {
			count = 1,
			view_name = view_name,
			start_time = {},
			record_time = {},
			instance_time = {},
			res_load_start_time = {},
			res_load_record_time = {}
		}

		table.insert(temp_record.start_time, os.clock())
		table.insert(temp_record.instance_time, -1)
		table.insert(self.view_open_time_record, temp_record)
	end
end

function ViewCheck:recordCostTime(view_name)
	if not self:CanCheck() then
		return
	end

	view_name = string.gsub(view_name, "%(Clone%)", "")

	if self:isWhiteView(view_name) then
		return
	end

	local view_info = self:hasRecord(view_name)

	if not view_info or not view_info.start_time[view_info.count] or view_info.count > 4 then
		return
	end

	if view_info.count > 1 and view_name == "mainui" then
		return
	end

	local record_time = os.clock() - view_info.start_time[view_info.count]

	record_time, _ = math.modf(record_time * 1000)
	view_info.record_time[view_info.count] = record_time
	view_info.count = view_info.count + 1
end

function ViewCheck:recordResList(view_name, res)
	if not self:CanCheck() then
		return
	end

	local view_info = self:hasRecord(view_name)

	if view_info and view_info.count > 1 and view_name == "mainui" then
		return
	end

	if view_info and view_info.count <= 4 then
		view_info.res = res
		view_info.res_load_start_time[view_info.count] = os.clock()
	end
end

function ViewCheck:resLoaded(view_name)
	if not self:CanCheck() then
		return
	end

	local view_info = self:hasRecord(view_name)

	if view_info and view_info.count > 1 and view_name == "mainui" then
		return
	end

	if view_info and view_info.res_load_start_time[view_info.count] and view_info.count <= 4 then
		local record_time = os.clock() - view_info.res_load_start_time[view_info.count]

		record_time, _ = math.modf(record_time * 1000)
		view_info.res_load_record_time[view_info.count] = record_time
	end
end

function ViewCheck:recordInstanceTime(view_name, instance_time)
	if not self:CanCheck() then
		return
	end

	if not view_name then
		return
	end

	local view_info = self:hasRecord(view_name)

	if view_info and view_info.count > 1 and view_name == "mainui" then
		return
	end

	if view_info and view_info.count <= 4 then
		view_info.instance_time[view_info.count] = instance_time
	end
end

function ViewCheck:printAllViewTime()
	return
end

function ViewCheck:getViewOpenTimeRecord()
	if not self:CanCheck() then
		return
	end

	table.sort(self.view_open_time_record, function(a, b)
		if a.record_time[1] and b.record_time[1] then
			return a.record_time[1] > b.record_time[1]
		end
	end)

	return self.view_open_time_record
end

function ViewCheck:CanCheck()
	if enableDebug then
		return true
	end
end

function ViewCheck:isWhiteView(view_name)
	if not self:CanCheck() then
		return
	end

	local white_view = {
		"gmview",
		"virtualjoystick",
		"horselanternview",
		"viewcheckview"
	}

	for i, v in ipairs(white_view) do
		if view_name == v then
			return true
		end
	end
end

function ViewCheck:hasRecord(view_name)
	if not self:CanCheck() then
		return
	end

	for k, v in pairs(self.view_open_time_record) do
		if v and v.view_name == view_name then
			return v
		end
	end
end

function ViewCheck:common_copy(sourcefile, destinationfile)
	local temp_content = ""

	io.input(sourcefile)

	temp_content = io.read("*a")

	io.output(destinationfile)
	io.write(temp_content)
	io.flush()
	io.close()
end

function serialize(obj, oneline)
	local lua = ""
	local t = type(obj)

	if t == "number" then
		lua = lua .. obj
	elseif t == "boolean" then
		lua = lua .. tostring(obj)
	elseif t == "string" then
		lua = lua .. string.format("%q", obj)
	elseif t == "table" then
		lua = lua .. "{"

		for k, v in pairs(obj) do
			lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","

			if not oneline then
				lua = lua .. "\n"
			end
		end

		local metatable = getmetatable(obj)

		if metatable ~= nil and type(metatable.__index) == "table" then
			for k, v in pairs(metatable.__index) do
				lua = lua .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ","

				if not oneline then
					lua = lua .. "\n"
				end
			end
		end

		lua = lua .. "}"
	elseif t == "nil" then
		return nil
	else
		error("can not serialize a " .. t .. " type.")
	end

	return lua
end

function ViewCheck:table2string(tablevalue, oneline)
	return (serialize(tablevalue))
end

ViewCheck.instance = ViewCheck.New()

return ViewCheck
