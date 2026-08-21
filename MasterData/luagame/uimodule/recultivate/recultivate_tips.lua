local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local GIVE_BACK_ITEM_TEMP_KEY = "GIVE_BACK_ITEM_TEMP_KEY"
local RECULTIVATE_TIPS_SKILL_TEMP_KEY = "RECULTIVATE_TIPS_SKILL_TEMP_KEY"
local PREVIEW_OBJ_CLASS = require("uimodule.recultivate.recultivate_tips_preview_obj")
local GIVE_BACK_ROW_CLASS = require("uimodule.recultivate.recultivate_tips_row_item")
local ITEM_CFG = ShareRes.create("item.item")
local BagCfg = require("uimodule.uibag.uibag_configs")

function ui:on_click_Confirm()
  if not self.v_target_id then
    return
  end
  
  local function confirm_cb()
    local function callback()
      self:ui_hide()
    end
    
    local consume_list = {
      bag_type = BagCfg.ITEM_TYPE.COMSUME,
      item_list = {
        {
          uuid = self.v_item_uuid,
          count = 1,
          param = self.v_target_id
        }
      }
    }
    BagMgr:request_use_item(consume_list, callback)
  end
  
  local msg
  if self.v_is_weapon then
    local equip_data = CharacterMgr:get_equip_info(self.v_weapon_uuid)
    if 1 == equip_data.lock then
      msg = "确定解锁并重置该武器养成进度？"
    else
      msg = "确认重置该武器养成进度？"
    end
  else
    msg = "确认重置该角色养成进度？"
  end
  Util.show_notify_popup_message(confirm_cb, msg)
end

function ui:on_skill_btn_click()
  self.v_is_showing_skill = not self.v_is_showing_skill
  self:set_skill_info_view()
  return self.v_is_showing_skill
end

function ui:ui_finish_load()
  self:set_button("Cancel", function()
    self:ui_hide()
  end)
  self:set_button("ChangeBtn", function()
    if self.v_is_weapon then
      UIMgr:get_ui("recultivate_select_list_weapon"):ui_show(self.v_item_id, self.v_target_id)
    else
      UIMgr:get_ui("recultivate_select_list_char"):ui_show(self.v_item_id, self.v_target_id)
    end
  end)
  self:set_button("Confirm", function()
    self:on_click_Confirm()
  end)
  self:set_button("FullBg", function()
  end)
  self.v_weapon_exp_exchange_tb = self:build_exp_exchange_tb(ShareRes.create("equip.equip_exp"))
  self.v_char_exp_exchange_tb = self:build_exp_exchange_tb(ShareRes.create("buddy.buddy_exp"))
  self:register_exist_auto_template(GIVE_BACK_ITEM_TEMP_KEY, self.v_uiobjects.GiveBackItem, self.v_uiobjects.GiveBackItemContent)
  self:register_exist_auto_template(RECULTIVATE_TIPS_SKILL_TEMP_KEY, self.v_uiobjects.SkillItem, self.v_uiobjects.SkillItemContent)
end

function ui:build_exp_exchange_tb(exp_item_cfg)
  local tb = {}
  for _, v in pairs(exp_item_cfg) do
    local item_cfg = ITEM_CFG[v.Id]
    local data = {
      Exp = item_cfg.Arg[1],
      Id = v.Id
    }
    table.insert(tb, data)
  end
  table.sort(tb, function(a, b)
    return a.Exp > b.Exp
  end)
  return tb
end

function ui:ui_on_show(item_id, item_uuid, is_weapon)
  self.v_item_id = item_id
  self.v_item_uuid = item_uuid
  self.v_is_weapon = is_weapon
  self.v_is_showing_skill = false
  self.v_target_id = nil
  self:init_view()
  self:bind_auto_mq(Const.MSG_ON_CHANGE_RECULTIVATE_TARGET, self.on_change_select, self)
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

function ui:init_view()
  local objs = self.v_uiobjects
  objs.TitleChar:SetActiveEx(not self.v_is_weapon)
  objs.TitleWeapon:SetActiveEx(self.v_is_weapon)
  objs.NoSelectChar:SetActiveEx(not self.v_is_weapon)
  objs.NoSelectWeapon:SetActiveEx(self.v_is_weapon)
  objs.CharOtherInfo:SetActiveEx(not self.v_is_weapon)
  objs.WeaponOtherInfo:SetActiveEx(self.v_is_weapon)
  objs.PreviewInfo:SetActiveEx(false)
  objs.SkillLayout:SetActiveEx(false)
  objs.ChangeBtnIcon:SetActiveEx(false)
  objs.ChangeBtnEmptyIcon:SetActiveEx(true)
  objs.ChangeBtnCharText:SetActiveEx(not self.v_is_weapon)
  objs.ChangeBtnWeaponText:SetActiveEx(self.v_is_weapon)
  self:clear_wrap_items()
  self.v_preview_obj_before = PREVIEW_OBJ_CLASS:ui_wrap_ex(self, self.v_uiobjects.BeforeObj, false)
  self.v_preview_obj_after = PREVIEW_OBJ_CLASS:ui_wrap_ex(self, self.v_uiobjects.AfterObj, false)
  self:give_back_auto_cache(GIVE_BACK_ITEM_TEMP_KEY)
  self.v_lv_line_obj = GIVE_BACK_ROW_CLASS:ui_wrap_ex(self, self:get_auto_cache(GIVE_BACK_ITEM_TEMP_KEY), false)
  self.v_lv_line_obj:set_type("等级")
  self.v_break_line_obj = GIVE_BACK_ROW_CLASS:ui_wrap_ex(self, self:get_auto_cache(GIVE_BACK_ITEM_TEMP_KEY), false)
  self.v_break_line_obj:set_type("突破")
  if not self.v_is_weapon then
    self.v_skill_line_obj = GIVE_BACK_ROW_CLASS:ui_wrap_ex(self, self:get_auto_cache(GIVE_BACK_ITEM_TEMP_KEY), false)
    self.v_skill_line_obj:set_type("技能", true)
  end
end

function ui:clear_wrap_items()
  if self.v_preview_obj_before then
    self.v_preview_obj_before:ui_destroy()
    self.v_preview_obj_before = nil
  end
  if self.v_preview_obj_after then
    self.v_preview_obj_after:ui_destroy()
    self.v_preview_obj_after = nil
  end
  if self.v_lv_line_obj then
    self.v_lv_line_obj:ui_destroy()
    self.v_lv_line_obj = nil
  end
  if self.v_break_line_obj then
    self.v_break_line_obj:ui_destroy()
    self.v_break_line_obj = nil
  end
  if self.v_skill_line_obj then
    self.v_skill_line_obj:ui_destroy()
    self.v_skill_line_obj = nil
  end
end

function ui:on_change_select(msg)
  local target_id = msg.mm_x
  self.v_target_id = target_id
  if self.v_preview_obj_before then
    self.v_preview_obj_before:set_data(target_id, self.v_is_weapon)
  end
  if self.v_preview_obj_after then
    self.v_preview_obj_after:set_data(target_id, self.v_is_weapon, true)
  end
  if self.v_is_weapon then
    self.v_weapon_uuid = target_id
    local equip_info = CharacterMgr:get_equip_info(target_id)
    local equip_cfg = ShareRes.get_equip(equip_info.id)
    local path = string.format("Icon/Item/%s", equip_cfg.Icon)
    ResMgr:load_set_icon(self.v_uicompents.ChangeBtnIcon_img, path)
  else
    self.v_buddy_id = target_id
    local buddy_info = CharacterMgr:get_buddy_by_id(target_id)
    local path = UtilUI.get_hero_images(target_id, 1, buddy_info.fashion_id)
    ResMgr:load_set_icon(self.v_uicompents.ChangeBtnIcon_img, path)
  end
  if self.v_lv_line_obj then
    self.v_lv_line_obj:set_item_list(self:get_lv_item_list())
  end
  if self.v_break_line_obj then
    self.v_break_line_obj:set_item_list(self:get_break_item_list())
  end
  if self.v_skill_line_obj then
    local skill_item_list = self:get_skill_item_list()
    self.v_skill_line_obj:set_item_list(self:get_skill_item_list())
    self.v_is_showing_skill = self.v_is_showing_skill and skill_item_list and next(skill_item_list) ~= nil
    self.v_skill_line_obj:set_arrow_dir(self.v_is_showing_skill)
  end
  local objs = self.v_uiobjects
  objs.PreviewInfo:SetActiveEx(true)
  objs.NoSelectChar:SetActiveEx(false)
  objs.NoSelectWeapon:SetActiveEx(false)
  objs.ChangeBtnIcon:SetActiveEx(true)
  objs.ChangeBtnEmptyIcon:SetActiveEx(false)
  self:set_skill_info_view()
end

function ui:get_lv_item_list()
  return self.v_is_weapon and self:get_weapon_lv_item_list() or self:get_char_lv_item_list()
end

function ui:get_break_item_list()
  return self.v_is_weapon and self:get_weapon_break_item_list() or self:get_char_break_item_list()
end

function ui:get_skill_item_list()
  if not self.v_is_weapon then
    return self:get_char_skill_item_list()
  end
end

function ui:get_weapon_lv_item_list()
  local equip_data = CharacterMgr:get_equip_info(self.v_weapon_uuid)
  if not equip_data then
    return {}
  end
  local lv = equip_data.lv
  local break_lv = equip_data.break_lv
  local exp = equip_data.exp
  local quality = ShareRes.get_equip(equip_data.id).Quality
  local all_level_cfgs = ShareRes.get_equip_lv_up_cfg(quality)
  local lv_rebate_table = {}
  local flow_exp = lv >= ShareRes.get_equip_max_level(break_lv) and 0 or exp
  local coin_cost, exp_cost = self:calcu_weapon_level_up_cost(quality, lv, break_lv, all_level_cfgs)
  local total_exp = flow_exp + exp_cost
  if coin_cost > 0 then
    lv_rebate_table[1] = {
      id = Config.COIN_ITEMID,
      count = coin_cost
    }
  end
  self:exchange_weapon_exp(lv_rebate_table, total_exp)
  return lv_rebate_table
end

function ui:calcu_weapon_level_up_cost(quality, lv, break_lv, all_level_cfgs)
  local star_lv = 1
  local end_lv
  local coin_cost, exp_cost = 0, 0
  all_level_cfgs = all_level_cfgs or ShareRes.get_equip_lv_up_cfg(quality)
  for bl, single_bl_cfgs in ipairs(all_level_cfgs) do
    if bl <= break_lv then
      if bl < break_lv then
        end_lv = ShareRes.get_equip_max_level(bl)
      else
        end_lv = lv
      end
      for l = star_lv, end_lv do
        local sbcfg = single_bl_cfgs[l]
        coin_cost = coin_cost + sbcfg.Coin
        exp_cost = exp_cost + sbcfg.Exp
      end
      star_lv = end_lv + 1
    else
      break
    end
  end
  return coin_cost, exp_cost
end

function ui:exchange_weapon_exp(rebate_table, exp_cost)
  for index, item_info in ipairs(self.v_weapon_exp_exchange_tb) do
    local count = 0
    local item_count = math.floor(exp_cost / item_info.Exp)
    if item_count > 0 then
      exp_cost = exp_cost % item_info.Exp
      count = count + item_count
    end
    if index == #self.v_weapon_exp_exchange_tb and exp_cost > 0 then
      count = count + 1
    end
    if count > 0 then
      rebate_table[#rebate_table + 1] = {
        id = item_info.Id,
        count = count
      }
    end
  end
end

function ui:get_weapon_break_item_list()
  local equip_data = CharacterMgr:get_equip_info(self.v_weapon_uuid)
  if not equip_data then
    return {}
  end
  local equip_id = equip_data.id
  local break_lv = equip_data.break_lv
  if break_lv <= 1 then
    return {}
  end
  local equip_break_cfgs = ShareRes.create("equip.equip_break", equip_id)
  local coin_cost = 0
  local list = {}
  local cost_items = {}
  for i = 2, break_lv do
    local equip_break_cfg = equip_break_cfgs[i - 1]
    if equip_break_cfg then
      coin_cost = equip_break_cfg.Coin + coin_cost
      if equip_break_cfg.Item then
        for index, use_item_id in pairs(equip_break_cfg.Item) do
          if use_item_id > 0 then
            cost_items[use_item_id] = (cost_items[use_item_id] or 0) + equip_break_cfg.ItemCount[index]
          end
        end
      end
    end
  end
  for item_id, count in pairs(cost_items) do
    list[#list + 1] = {id = item_id, count = count}
  end
  self:sort_items(list)
  table.insert(list, 1, {
    id = Config.COIN_ITEMID,
    count = coin_cost
  })
  return list
end

function ui:sort_items(list)
  table.sort(list, function(a, b)
    local cfg_a = ITEM_CFG[a.id]
    local cfg_b = ITEM_CFG[b.id]
    if cfg_a.Quality ~= cfg_b.Quality then
      return cfg_a.Quality > cfg_b.Quality
    end
    if cfg_a.Priority ~= cfg_b.Priority then
      return cfg_a.Priority > cfg_b.Priority
    end
    return a.id > b.id
  end)
end

function ui:get_char_lv_item_list()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  if not buddy_info then
    return {}
  end
  local lv = buddy_info.lv
  local break_lv = buddy_info.break_lv
  local exp = buddy_info.exp
  local all_level_cfgs = ShareRes.create("buddy.buddy_level")
  local max_level = ShareRes.get_buddy_max_level(break_lv)
  local lv_rebate_table = {}
  local flow_exp = lv >= max_level and 0 or exp
  local coin_cost, exp_cost = self:calcu_char_level_up_cost(lv, break_lv, all_level_cfgs)
  local total_exp = flow_exp + exp_cost
  if coin_cost > 0 then
    lv_rebate_table[1] = {
      id = Config.COIN_ITEMID,
      count = coin_cost
    }
  end
  self:exchange_char_exp(lv_rebate_table, total_exp)
  return lv_rebate_table
end

function ui:calcu_char_level_up_cost(lv, break_lv, all_level_cfgs)
  local coin_cost, exp_cost = 0, 0
  local star_lv = 1
  for bl, single_bl_cfgs in ipairs(all_level_cfgs) do
    local max_level = ShareRes.get_buddy_max_level(bl)
    for i = star_lv, max_level do
      local lv_cfg = single_bl_cfgs[i]
      if lv_cfg and lv >= lv_cfg.Lv then
        coin_cost = coin_cost + lv_cfg.Coin
        exp_cost = exp_cost + lv_cfg.Exp
      else
        break
      end
    end
    star_lv = max_level + 1
    if break_lv < bl then
      break
    end
  end
  return coin_cost, exp_cost
end

function ui:exchange_char_exp(lv_rebate_table, exp_cost)
  for index, item_info in ipairs(self.v_char_exp_exchange_tb) do
    local count = 0
    local item_count = math.floor(exp_cost / item_info.Exp)
    if item_count > 0 then
      exp_cost = exp_cost % item_info.Exp
      count = count + item_count
    end
    if index == #self.v_char_exp_exchange_tb and exp_cost > 0 then
      count = count + 1
    end
    if count > 0 then
      lv_rebate_table[#lv_rebate_table + 1] = {
        id = item_info.Id,
        count = count
      }
    end
  end
end

function ui:get_char_break_item_list()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  if not buddy_info then
    return {}
  end
  local break_lv = buddy_info.break_lv
  if break_lv <= 1 then
    return {}
  end
  local buddy_break_cfgs = ShareRes.create("buddy.buddy_break", self.v_buddy_id)
  local coin_cost = 0
  local cost_items = {}
  for i = 2, break_lv do
    local buddy_break_cfg = buddy_break_cfgs[i - 1]
    if buddy_break_cfg then
      coin_cost = buddy_break_cfg.Coin + coin_cost
      if buddy_break_cfg.Item then
        for index, use_item_id in pairs(buddy_break_cfg.Item) do
          local use_num = buddy_break_cfg.ItemCount[index] or 0
          if use_num > 0 then
            cost_items[use_item_id] = (cost_items[use_item_id] or 0) + use_num
          end
        end
      end
    end
  end
  local list = {}
  for item_id, count in pairs(cost_items) do
    list[#list + 1] = {id = item_id, count = count}
  end
  self:sort_items(list)
  if coin_cost > 0 then
    table.insert(list, 1, {
      id = Config.COIN_ITEMID,
      count = coin_cost
    })
  end
  return list
end

function ui:get_char_skill_item_list()
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  if not buddy_info then
    return {}
  end
  local coin_cost = 0
  local cost_items = {}
  for _, v in pairs(buddy_info.lSkill) do
    local skill_lv_cfgs = ShareRes.get_buddy_skill_lv_cfg_list(v.id)
    for _, lv_cfg in ipairs(skill_lv_cfgs) do
      if lv_cfg.Lv < v.virtual_level then
        coin_cost = lv_cfg.GoldConsume + coin_cost
        for index, use_item_id in ipairs(lv_cfg.ItemId) do
          local use_num = lv_cfg.ItemCount[index] or 0
          if use_num > 0 then
            cost_items[use_item_id] = (cost_items[use_item_id] or 0) + use_num
          end
        end
      else
        break
      end
    end
  end
  local list = {}
  for item_id, count in pairs(cost_items) do
    list[#list + 1] = {id = item_id, count = count}
  end
  self:sort_items(list)
  if coin_cost > 0 then
    table.insert(list, 1, {
      id = Config.COIN_ITEMID,
      count = coin_cost
    })
  end
  return list
end

local skill_order = {
  1,
  5,
  3,
  4,
  2,
  6
}

function ui:set_skill_info_view()
  if self.v_is_showing_skill then
    self.v_uiobjects.SkillLayout:SetActiveEx(true)
  else
    if self.v_uiobjects.SkillLayout.activeSelf then
      self:play_playable_director("Ani_UIBagResetPanel_SkillLayout_Out")
    end
    return
  end
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  if not buddy_info then
    self.v_uiobjects.SkillLayout:SetActiveEx(false)
    return
  end
  local skill_lv_data = {}
  for _, v in pairs(buddy_info.lSkill) do
    local skill_id = v.id
    local now_lv = v.lv or 1
    local after_lv = now_lv - (v.virtual_level or 1) + 1
    skill_lv_data[skill_id] = {now_lv = now_lv, after_lv = after_lv}
  end
  self:give_back_auto_cache(RECULTIVATE_TIPS_SKILL_TEMP_KEY)
  local all_skill_id_list = ShareRes.get_buddy_skill_list_cfg(self.v_buddy_id).Skill
  for _, idx in ipairs(skill_order) do
    local skill_id = all_skill_id_list[idx]
    local obj = self:get_auto_cache(RECULTIVATE_TIPS_SKILL_TEMP_KEY)
    local detail_cfg = ShareRes.get_buddy_skill_details_cfg(skill_id)
    Util.get_text("TittleBg/SkillText", obj).text = detail_cfg.Name
    Util.get_text("LvGroup/LeftLv_", obj).text = skill_lv_data[skill_id].now_lv
    Util.get_text("LvGroup/RightLv_", obj).text = skill_lv_data[skill_id].after_lv
    Util.load_skill_icon(detail_cfg.Icon, Util.get_image("SkillBg/Mask/Skill_", obj))
  end
  local talent_lv = buddy_info.talent_lv or 0
  if talent_lv > 0 then
    local talent_detail_cfg = ShareRes.get_buddy_talent_lv_cfg_list(self.v_buddy_id)[talent_lv]
    local obj = self:get_auto_cache(RECULTIVATE_TIPS_SKILL_TEMP_KEY)
    Util.get_text("TittleBg/SkillText", obj).text = talent_detail_cfg.Type
    Util.get_text("LvGroup/LeftLv_", obj).text = talent_lv
    Util.get_text("LvGroup/RightLv_", obj).text = 0
    Util.load_talent_icon(talent_detail_cfg.Icon, Util.get_image("SkillBg/Mask/Skill_", obj))
  end
end

return ui
