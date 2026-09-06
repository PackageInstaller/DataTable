-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/model/GMModel.lua

module("logic.extensions.gm.model.GMModel", package.seeall)

local GMModel = class("GMModel", BaseListModel)

GMModel.Notify = {}
GMModel.Notify.GMCONTROLLER_DUMP_MSG = "gmcontroller_dump_msg"
GMModel.Notify.MSGVIEW_CLICK_SHOW = "msgview_click_show"
GMModel.Notify.MSGVIEW_CLICK_ERROR_TIPS = "msgview_click_error_tips"
GMModel.Notify.RECEIVED_SHUTDOWN_SERVER_REQUEST = "received_shutdown_server_request"

function GMModel:onInit()
	self._expTilingMapPath = nil
end

function GMModel:initData()
	return
end

function GMModel:getExpedTilingMapPath()
	if self._expedLandform then
		return STilingMapConfig.configsPath .. self._expedLandform .. self._expedSize .. "x" .. self._expedSize .. "/" .. "tiling_map_" .. self._expedIndex .. ".txt", self._expedLandform
	end
end

function GMModel:setExpedTilingMapPath(landform, num, index)
	self._expedLandform = landform
	self._expedSize = num
	self._expedIndex = index
end

function GMModel:searchByStr(str)
	local ret = {}

	if str ~= "" and str ~= nil then
		for k, v in pairs(MaterialModel.instance._typeCfgs) do
			for i, vi in ipairs(MaterialModel.instance._cfgs[k]) do
				if vi.search_name and string.find(vi.search_name, str, nil, true) or vi.upName and string.find(vi.upName, string.upper(str), nil, true) then
					if k == MatType.Pet then
						if checknumber(vi.id) < 20000 then
							table.insert(ret, vi)
						end
					else
						table.insert(ret, vi)
					end
				end
			end
		end
	end

	return ret
end

function GMModel:searchPetByStr(str)
	local ret = {}

	if str ~= "" and str ~= nil then
		for i, vi in ipairs(MaterialModel.instance._cfgs[MatType.PET_SKIN]) do
			if string.find(vi.search_name, str) or string.find(vi.upName, string.upper(str)) then
				table.insert(ret, vi)
			end
		end
	end

	return ret
end

function GMModel:searchByViewStr(str)
	local ret = {}

	str = string.upper(str)

	if string.find(str, "OP ") or string.find(str, "OPEN ") then
		local arr = string.split(str, " ")
		local s = arr[2]
		local settingView = usingnow("logic.setting.setting_view")

		for k, v in pairs(settingView) do
			if type(v) == "table" then
				if v.search_name ~= nil then
					local usn = Framework.PinyinConverter.HZToPYSimple(v.search_name)

					if s == "" then
						table.insert(ret, v)
					elseif string.find(v.search_name, s) or string.find(string.upper(usn), string.upper(s)) or string.find(string.upper(k), string.upper(s)) then
						table.insert(ret, v)
					end
				elseif s ~= "" and self:fuzzySearch(string.upper(k), string.upper(s)) then
					table.insert(ret, v)
				end
			end
		end
	end

	return ret
end

function GMModel:fuzzySearch(k, s)
	local index = 1
	local isMatch = true

	string.gsub(s, ".", function(v)
		if isMatch then
			local pos = string.find(k, v, index)

			if pos and pos >= index then
				index = pos
			end

			isMatch = pos
		end
	end)

	return isMatch
end

GMModel.instance = GMModel.New()

return GMModel
