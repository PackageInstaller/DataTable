local Helper = require("uimodule.ui_draw_card.drawcard_helper")
local BagCfg = require("gamelogic.character.fight_bag_configs")
local Base = require("ui.uiobject")
local Math = require("base.mathx")
local _clamp = Math.Clamp
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE
local MODEL = {
  v_btn_left = {
    "BtnLeft",
    BIND_TYPE.BUTTON
  },
  v_btn_right = {
    "BtnRight",
    BIND_TYPE.BUTTON
  },
  v_content = {
    "Content",
    BIND_TYPE.IMAGE
  },
  v_guaruntee_cur = {
    "GuarunteeCur",
    BIND_TYPE.TEXT
  },
  v_guaruntee_desc = {
    "GuarunteeDesc",
    BIND_TYPE.TEXT
  },
  v_guaruntee_max = {
    "GuarunteeMax",
    BIND_TYPE.TEXT
  },
  v_page = {
    "Page",
    BIND_TYPE.TEXT
  },
  v_tpl = {
    "Tpl",
    BIND_TYPE.OBJECT
  },
  v_txt_bottom = {
    "TxtBottom",
    BIND_TYPE.TEXT
  },
  v_txt_no_record = {
    "TxtNoRecord",
    BIND_TYPE.TEXT
  }
}
local DRAWCARD_HISTORY_TEMPLATE_KEY = "DRAWCARD_HISTORY_TEMPLATE_KEY"

function ui:ui_finish_load()
  self:init_model(MODEL)
  self:set_button("BtnLeft", function()
    self:switch_page(-1)
  end)
  self:set_button("BtnRight", function()
    self:switch_page(1)
  end)
  self.v_btn_left_cg = self:get_canvas_group(nil, self.v_uiobjects.BtnLeft)
  self.v_btn_right_cg = self:get_canvas_group(nil, self.v_uiobjects.BtnRight)
  self:register_exist_auto_template(DRAWCARD_HISTORY_TEMPLATE_KEY, self.v_tpl, self.v_uiobjects.Content)
end

function ui:set_data(group_id, pool_id)
  self.v_guaruntee_desc.text = ShareRes.get_draw_base_rule(pool_id).RecordTxt
  local pool_vo = DrawCardMgr:get_pool_vo(group_id, pool_id)
  self.v_guaruntee_cur.text = pool_vo.guarantee_cur
  self.v_guaruntee_max.text = pool_vo.guarantee_max
  local records = DrawCardMgr:get_last_history_record(group_id)
  self.v_record_list = UtilTable.table_reverse(records)
  self.v_total_num = #records
  self.v_page_num = math.ceil(self.v_total_num / 10)
  self.v_page_num = self.v_page_num > 0 and self.v_page_num or 1
  self.v_cur_page = 0
  self:switch_page(1)
  local group_config = ShareRes.get_draw_pool_group(group_id)
  local save_type = group_config.SaveType
  local arg = group_config.Arg
  if 1 == save_type then
    self.v_txt_bottom.text = Util.format_str("仅显示最近{1}条记录", arg[1])
  else
    self.v_txt_bottom.text = Util.format_str("仅显示最近{1}天{2}条记录", arg[1], arg[2])
  end
end

function ui:switch_page(val)
  local page = _clamp(self.v_cur_page + val, 1, self.v_page_num)
  if page == self.v_cur_page then
    return
  end
  self.v_cur_page = page
  self:_refresh_page_num()
  self:give_back_auto_cache(DRAWCARD_HISTORY_TEMPLATE_KEY)
  local start_idx = (page - 1) * 10 + 1
  if start_idx > self.v_total_num then
    return
  end
  local end_idx = start_idx + 9
  end_idx = end_idx > self.v_total_num and self.v_total_num or end_idx
  local obj
  for idx = start_idx, end_idx do
    obj = self:get_auto_cache(DRAWCARD_HISTORY_TEMPLATE_KEY)
    self:_refresh_item(obj, self.v_record_list[idx])
  end
end

function ui:_refresh_item(obj, record_vo)
  local time = record_vo.time
  local item_id = record_vo.id
  local time_offset = Date.get_local_time_offset()
  local name_txt = self:get_text("Name_", obj)
  local type_txt = self:get_text("Type_", obj)
  local time_txt = self:get_text("Time_", obj)
  name_txt.text = Helper.get_item_name(item_id)
  type_txt.text = Helper.get_item_type_str(item_id)
  time_txt.text = os.date("%Y-%m-%d %H:%M:%S", time + time_offset)
  local quality = UtilUI.get_item_qulity(item_id)
  name_txt.color = BagCfg.Quality_Color_New[quality]
end

function ui:_refresh_page_num()
  self.v_page.text = string.format("%s/%s", self.v_cur_page, self.v_page_num)
  local is_left_limit = self.v_cur_page <= 1
  local is_right_limit = self.v_cur_page >= self.v_page_num
  self.v_btn_left_cg.alpha = is_left_limit and 0.6 or 1
  self.v_btn_right_cg.alpha = is_right_limit and 0.6 or 1
end

function ui:ui_on_hide()
end

function ui:ui_on_destroy()
end

return ui
