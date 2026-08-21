local Base = require("gamelogic.base_system")
local Seri = require("seri")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
M.icon_list = {
  ["1"] = {
    choose = "UIEventSelection/sj_icon_xxhao",
    result = "UIEventSelection/sj_icon_sj2",
    result_title = "UIEventSelection/sj_icon_title_hao"
  },
  ["2"] = {
    choose = "UIEventSelection/sj_icon_xxhuai",
    result = "UIEventSelection/sj_icon_sj3",
    result_title = "UIEventSelection/sj_icon_title_huai"
  },
  ["3"] = {
    choose = "UIEventSelection/sj_icon_xxsj",
    result = "UIEventSelection/sj_icon_sj4",
    result_title = "UIEventSelection/sj_icon_title_zl"
  },
  ["4"] = {
    choose = "UIEventSelection/sj_icon_xxtp2",
    result = "UIEventSelection/sj_icon_sj1",
    result_title = "UIEventSelection/sj_icon_title_zl"
  }
}
M.npc_id = 0
M.choose_option_index = 0
M.temp_choose_option_index = 0

function M:set_choose_option_index(value)
  self.choose_option_index = value
end

function M:get_choose_option_index()
  return self.choose_option_index
end

function M:set_temp_choose_option_index(value)
  self.temp_choose_option_index = value
end

function M:get_temp_choose_option_index()
  return self.temp_choose_option_index
end

function M:set_npc_id(value)
  self.npc_id = value
end

function M:get_npc_id()
  return self.npc_id
end

function M:get_fun_npc_info(npc_id)
  local list = ShareRes.create("npc.functional_npc")
  if npc_id then
    return list[npc_id]
  end
  return list
end

function M:get_npc_title_info(npc_id)
  local info = self:get_fun_npc_info(npc_id)
  local result_table = {}
  if info.EventTitleText then
    result_table = Util.split_trim_str(info.EventTitleText, "|")
  end
  if not result_table or #result_table < 3 then
    Log.Error("npc.functional_npc 表 info.EventTitleText 无法转换为icon,标题,文本 id:", npc_id)
  end
  return result_table
end

function M:get_npc_option_list(npc_id)
  local info = self:get_fun_npc_info(npc_id)
  local result_table = {}
  if info.EventOptions then
    for i, v in ipairs(info.EventOptions) do
      if nil ~= v and #v > 0 then
        local data_table = Util.split_trim_str(info.EventOptions[i], "|")
        result_table[i] = data_table
      end
    end
  end
  return result_table
end

function M:get_npc_result_info(npc_id, index)
  local info = self:get_fun_npc_info(npc_id)
  local result_table = {}
  if info.EventResult then
    for i, v in ipairs(info.EventResult) do
      if nil ~= v and #v > 0 then
        local data_table = Util.split_trim_str(info.EventResult[i], "|")
        result_table[i] = data_table
      end
    end
  end
  return result_table[index]
end

function M:choose_option(callback)
  local index = self.choose_option_index
  local temp = {option_index = index}
  local pack_args = Seri.packstring(temp)
  local send_data = {
    id = self.npc_id,
    pack_args = pack_args
  }
  Network:call("c2gs_interact_with_npc", send_data, function(ok, resp)
    if ok then
      self:set_choose_option_index(index)
      if callback then
        callback(resp)
      else
      end
    end
  end)
end

return M
