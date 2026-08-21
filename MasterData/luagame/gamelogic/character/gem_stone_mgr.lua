local Base = require("gamelogic.base_system")
local _tinsert = table.insert
local _tsort = table.sort
local CommonDefine = require("cs_share.common_define")
local RELIC_ENTRY_TYPE = CommonDefine.RELIC_ENTRY_TYPE
local Timer = Global.timer
local M = Util.create_child_mt(Base)
M.GEM_SYS_ID = 55
M.SORT_TYPE = {QUALITY = 1, LEVEL = 2}
M.SORT_TYPE_ORDER = {
  [M.SORT_TYPE.QUALITY] = {
    "quality",
    "level",
    "id",
    "equip_uuid",
    "uuid"
  },
  [M.SORT_TYPE.LEVEL] = {
    "level",
    "quality",
    "id",
    "equip_uuid",
    "uuid"
  }
}

function M:init_sys()
  Base.init_sys(self)
  self.v_gem_list = {}
  self.v_gem_map = {}
  self.v_sort_type = M.SORT_TYPE.QUALITY
  self.v_is_drop = true
end

function M:on_reconnect()
  self.v_gem_list = {}
  self.v_gem_map = {}
end

function M:on_gs2c_equip_gemstone_list(gemstones)
  self.v_gem_list = gemstones
  for _, gem_data in pairs(gemstones) do
    local uuid = gem_data.uuid
    self.v_gem_map[uuid] = gem_data
  end
  MsgGame:mq_publish2(Const.MSG_ON_GEM_UPDATE)
end

function M:on_gs2c_equip_gemstone_update(gemstones)
  for i, gem_data in ipairs(gemstones) do
    local uuid = gem_data.uuid
    self.v_gem_map[uuid] = gem_data
    local is_new_uuid = true
    for index, _gem_data in ipairs(self.v_gem_list) do
      if _gem_data.uuid == uuid then
        self.v_gem_list[index] = gem_data
        is_new_uuid = false
        break
      end
    end
    if is_new_uuid then
      self.v_gem_list[#self.v_gem_list + 1] = gem_data
    end
    local msg = MsgGame:mq_publish2(Const.MSG_ON_GEM_UPDATE)
    msg.mm_x = uuid
  end
end

function M:on_gs2c_equip_gemstone_delete(uuids)
  for i, uuid in ipairs(uuids) do
    self.v_gem_map[uuid] = nil
    for index, _gem_data in ipairs(self.v_gem_list) do
      if _gem_data.uuid == uuid then
        table.remove(self.v_gem_list, index)
        break
      end
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_GEM_DELETE)
end

function M:req_c2gs_equip_gemstone_up_level(uuid, consume_uuid, callback)
  Network:call("c2gs_equip_gemstone_up_level", {uuid = uuid, consume_uuid = consume_uuid}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:req_c2gs_equip_gemstone_up(equip_uuid, uuid, pos, callback)
  Network:call("c2gs_equip_gemstone_up", {
    equip_uuid = equip_uuid,
    uuid = uuid,
    pos = pos
  }, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:req_c2gs_equip_gemstone_down(equip_uuid, pos, callback)
  Network:call("c2gs_equip_gemstone_down", {equip_uuid = equip_uuid, pos = pos}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:req_c2gs_gemstone_delete_list(uuid_list, callback)
  Network:call("c2gs_gemstone_delete_list", {uuid_list = uuid_list}, function(ok, resp)
    if ok and callback then
      callback()
    end
  end)
end

function M:get_gem_list()
  return self.v_gem_list
end

function M:get_gem_data(uuid)
  local data = self.v_gem_map[uuid]
  if data then
    data.quality = ShareRes.get_gem_quality(data.id)
  end
  return data
end

function M:get_gem_data_id(uuid)
  local data = self:get_gem_data(uuid)
  if data then
    return data.id
  end
end

function M:get_gem_num_by_id(id)
  local num = 0
  if self.v_gem_list then
    for key, data in pairs(self.v_gem_list) do
      if data.id == id then
        num = num + 1
      end
    end
  end
  return num
end

function M:reset_sort()
  self.v_sort_type = M.SORT_TYPE.QUALITY
  self.v_is_drop = true
end

function M:change_sort_drop()
  self.v_is_drop = not self.v_is_drop
end

function M:get_sort_drop()
  return self.v_is_drop
end

function M:set_sort_type(type)
  self.v_sort_type = type
end

function M:get_sort_type()
  return self.v_sort_type
end

function M:get_gem_sort_list()
  local gem_list = UtilTable.copy_table(self.v_gem_list)
  for index, data in ipairs(gem_list) do
    data.quality = ShareRes.get_gem_quality(data.id)
  end
  table.sort(gem_list, function(a, b)
    for _, order_key in ipairs(self.SORT_TYPE_ORDER[self.v_sort_type]) do
      local a_val = a[order_key] or 0
      local b_val = b[order_key] or 0
      if a_val ~= b_val then
        if self.v_is_drop and "equip_uuid" ~= order_key then
          return a_val > b_val
        else
          return a_val < b_val
        end
      end
    end
  end)
  return gem_list
end

function M:get_gem_owner(uuid)
  local gem_data = self:get_gem_data(uuid)
  local owner = 0
  local equip_uuid = gem_data.equip_uuid or 0
  if 0 ~= equip_uuid then
    local equip_info = CharacterMgr:get_equip_info(equip_uuid)
    if equip_info.owner and 0 ~= equip_info.owner then
      owner = equip_info.owner
    end
  end
  return owner
end

function M:get_gem_pos(uuid)
  local gem_data = self:get_gem_data(uuid)
  local pos = 0
  local equip_uuid = gem_data.equip_uuid or 0
  if 0 ~= equip_uuid then
    local equip_info = CharacterMgr:get_equip_info(equip_uuid)
    if equip_info and equip_info.gemstone_slot then
      for index, slot_data in ipairs(equip_info.gemstone_slot) do
        if slot_data.uuid == uuid then
          pos = slot_data.pos or 0
          break
        end
      end
    end
  end
  return pos
end

M.COST_SORT_ORDER = {
  "level",
  "equip_uuid",
  "owner"
}

function M:get_same_gem_list(uuid)
  local gem_list = UtilTable.copy_table(self.v_gem_list)
  local target_id = self:get_gem_data(uuid).id
  local same_gem_list = {}
  for _, data in ipairs(gem_list) do
    if data.id == target_id and data.uuid ~= uuid then
      table.insert(same_gem_list, data)
      data.quality = ShareRes.get_gem_quality(data.id)
      data.owner = self:get_gem_owner(data.uuid)
    end
  end
  table.sort(same_gem_list, function(a, b)
    for _, order_key in ipairs(self.COST_SORT_ORDER) do
      local a_val = a[order_key] or 0
      local b_val = b[order_key] or 0
      if "level" ~= order_key then
        a_val = 0 ~= a_val and 1 or 0
        b_val = 0 ~= b_val and 1 or 0
      end
      if a_val ~= b_val then
        return a_val < b_val
      end
    end
  end)
  return same_gem_list
end

function M:get_gem_uuid_by_pos(equip_uuid, pos)
  if not pos then
    return 0
  end
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  if not equip_info then
    return 0
  end
  local gemstone_slot = equip_info.gemstone_slot
  if not gemstone_slot then
    return 0
  end
  for key, data in pairs(gemstone_slot) do
    if data.pos == pos then
      return data.uuid or 0
    end
  end
  return 0
end

M.FREE_SORT_ORDER = {
  "quality",
  "level",
  "id",
  "uuid"
}

function M:get_free_gem_list()
  local gem_list = UtilTable.copy_table(self.v_gem_list)
  local free_gem_list = {}
  for _, data in ipairs(gem_list) do
    local equip_uuid = data.equip_uuid or 0
    if 0 == equip_uuid then
      table.insert(free_gem_list, data)
      data.quality = ShareRes.get_gem_quality(data.id)
    end
  end
  table.sort(free_gem_list, function(a, b)
    for _, order_key in ipairs(self.FREE_SORT_ORDER) do
      local a_val = a[order_key] or 0
      local b_val = b[order_key] or 0
      if a_val ~= b_val then
        return a_val > b_val
      end
    end
  end)
  return free_gem_list
end

function M:show_gem_unlock_tips(equip_info, target_pos)
  local equip_id = equip_info.id
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  for i, cfg in ipairs(advance_cfg) do
    if cfg.UnlockGemstoneSlotId then
      if type(cfg.UnlockGemstoneSlotId) == "number" then
        if target_pos == cfg.UnlockGemstoneSlotId then
          Util.show_message_tip(2316, cfg.Lv)
          return
        end
      else
        for _, pos in pairs(cfg.UnlockGemstoneSlotId) do
          if target_pos == pos then
            Util.show_message_tip(2316, cfg.Lv)
            return
          end
        end
      end
    end
  end
end

function M:get_equip_using_gem(equip_uuid)
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  local using_gem = {
    0,
    0,
    0
  }
  if not equip_info or not equip_info.gemstone_slot then
    return using_gem
  end
  local gemstone_slot = equip_info.gemstone_slot
  for _, data in pairs(gemstone_slot) do
    if data.pos > 0 then
      local gem_uuid = data.uuid or 0
      if 0 ~= gem_uuid then
        local gem_data = GemStoneMgr:get_gem_data(gem_uuid)
        if gem_data then
          using_gem[data.pos] = gem_data.id
        end
      end
    end
  end
  return using_gem
end

function M:check_is_repeat_right_unselected_gem(equip_uuid, gem_uuid, pos)
  if not (equip_uuid and 0 ~= equip_uuid and gem_uuid and 0 ~= gem_uuid and pos) or 0 == pos then
    return false
  end
  local target_gem_data = GemStoneMgr:get_gem_data(gem_uuid)
  if not target_gem_data then
    return false
  end
  local using_gem = self:get_equip_using_gem(equip_uuid)
  for _pos, data in ipairs(using_gem) do
    if _pos ~= pos and data == target_gem_data.id then
      return true
    end
  end
end

function M:set_equip_gem_red(show)
  RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_SOURCE_WEAR_BTN, true == show)
end

function M:update_equip_gem_red(equip_uuid)
  if not self:get_sys_open() then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_SOURCE_WEAR_BTN, false)
    return
  end
  local free_gem_list = self:get_free_gem_list()
  if not next(free_gem_list) then
    RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_SOURCE_WEAR_BTN, false)
    return
  end
  local gem_slots = self:get_gem_slots(equip_uuid)
  for index, data in ipairs(gem_slots) do
    if not data.is_not_use and not data.is_lock and 0 == data.gem_uuid then
      for index, free_gem in ipairs(free_gem_list) do
        if free_gem.quality <= data.quality then
          RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_SOURCE_WEAR_BTN, true)
          return
        end
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.CHAR_EQUIP_SOURCE_WEAR_BTN, false)
  return
end

function M:get_gem_slots(equip_uuid)
  do return {} end
  local equip_info = CharacterMgr:get_equip_info(equip_uuid)
  if not equip_info then
    return {}
  end
  local equip_id = equip_info.id
  local advance_lv = equip_info.advance
  local equip_cfg = ShareRes.create("equip.equip", equip_id)
  local quality_cfg = ShareRes.create("equip.equip_quality_icon", equip_cfg.Quality)
  local advance_cfg = ShareRes.create("equip.equip_advance", equip_id)
  local gem_slot_data = {}
  for i = 1, 3 do
    local slot_quality = quality_cfg.GemstoneSlotId[i]
    local is_lock = quality_cfg.BirthSlot[i] ~= true
    gem_slot_data[i] = {
      is_not_use = nil == slot_quality,
      is_lock = is_lock,
      quality = slot_quality,
      gem_uuid = 0
    }
  end
  for i, cfg in ipairs(advance_cfg) do
    local lv = cfg.Lv
    if advance_lv < lv then
      break
    end
    if cfg.UnlockGemstoneSlotId then
      if type(cfg.UnlockGemstoneSlotId) == "number" then
        local pos = cfg.UnlockGemstoneSlotId
        gem_slot_data[pos].is_lock = false
      else
        for _, pos in pairs(cfg.UnlockGemstoneSlotId) do
          gem_slot_data[pos].is_lock = false
        end
      end
    end
    if cfg.QualityChange then
      for _, data in pairs(cfg.QualityChange) do
        local pos = data[1]
        local qua = data[2]
        gem_slot_data[pos].quality = qua
      end
    end
  end
  local gemstone_slot = equip_info.gemstone_slot
  for key, data in pairs(gemstone_slot) do
    if data.pos > 0 then
      local gem_uuid = data.uuid or 0
      gem_slot_data[data.pos].gem_uuid = gem_uuid
      local gem_data = GemStoneMgr:get_gem_data(gem_uuid)
      if gem_data then
        gem_slot_data[data.pos].id = gem_data.id
        gem_slot_data[data.pos].level = gem_data.level
      end
    end
  end
  return gem_slot_data
end

function M:get_slot_red(equip_uuid)
  if not self:get_sys_open() then
    return false, {}
  end
  local have_red = false
  local gem_slot_data = self:get_gem_slots(equip_uuid)
  local free_gem_list = self:get_free_gem_list()
  local red_pos = {}
  for pos, data in ipairs(gem_slot_data) do
    if not data.is_not_use and not data.is_lock then
      if 0 == data.gem_uuid then
        for index, free_gem in ipairs(free_gem_list) do
          if free_gem.quality <= data.quality then
            red_pos[pos] = true
            have_red = true
            break
          end
        end
      else
        local same_gem_list = self:get_same_gem_list(data.gem_uuid)
        local gem_lv_cfg = ShareRes.get_gem_lv_cfg(data.id)
        if next(same_gem_list) ~= nil and data.level < #gem_lv_cfg then
          red_pos[pos] = true
          have_red = true
        end
      end
    end
  end
  return have_red, red_pos
end

function M:get_sys_open(show_tips)
  return SysOpenMgr:get_sys_is_open(M.GEM_SYS_ID, show_tips)
end

return M
