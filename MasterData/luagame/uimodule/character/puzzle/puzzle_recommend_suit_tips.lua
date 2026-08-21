local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LocalStorage = require("utils.localstorage")
local STORAGE_KEY = "PUZZLE_RECOMMEND_SUIT_TIPS_STORAGE_KEY"
local ATTR_TEMP_KEY = "PUZZLE_RECOMMEND_SUIT_TIPS_TEMP_KEY_ATTR"
local PUZZLE_ITEM_TEMP_KEY = "PUZZLE_RECOMMEND_SUIT_TIPS_TEMP_KEY_PUZZLE_ITEM"
local PuzzleItemClass = require("uimodule.character.puzzle.puzzle_recommend_suit_tips_item")

function ui:ui_finish_load()
  self:set_button("BtnBgClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
  self:set_button("BtnShowAttrNum", function()
    self:switch_attr_num_trigger()
  end)
  self:set_button("BtnEquip", function()
    self:auto_set()
  end)
  self:register_exist_auto_template(ATTR_TEMP_KEY, self.v_uiobjects.AttrTem, self.v_uiobjects.AttrContent)
  self:register_exist_auto_template(PUZZLE_ITEM_TEMP_KEY, self.v_uiobjects.PluginsTem, self.v_uiobjects.PluginContent)
end

function ui:switch_attr_num_trigger()
  self.v_show_attr_num = not self.v_show_attr_num
  LocalStorage:save_int(STORAGE_KEY, self.v_show_attr_num and 1 or 0)
  self:set_attr_num_trigger()
  self:refresh_attr_num_show()
end

function ui:auto_set()
  if self.v_auto_set_tbl and #self.v_auto_set_tbl > 0 then
    local function install_puzzle()
      PuzzleMgr:batch_install_puzzle(self.v_auto_set_tbl, self.v_buddy_id, function()
        self:ui_hide()
      end)
    end
    
    if #self.v_auto_set_tbl < #self.v_base_recommend_puzzles then
      Util.show_notify_popup_message(install_puzzle, "当前方案存在未获得古痕，是否进行装配？", nil, "确定", "取消")
    else
      install_puzzle()
    end
  else
    Util.show_message_tip(2077)
  end
end

function ui:on_jump_to_sys()
  self:ui_hide()
end

function ui:ui_on_hide()
  self:clear_wrap_items()
end

function ui:ui_on_show(buddy_id)
  self.v_buddy_id = buddy_id
  local buddy_info = CharacterMgr:get_buddy_by_id(self.v_buddy_id)
  local puzzle_graph = buddy_info.puzzle_graph
  local map_graph_id = puzzle_graph.id
  local recommend_suit_cfg = ShareRes.get_recommend_puzzle_suit_cfg(buddy_id, map_graph_id)
  local no_recommend_suit = nil == recommend_suit_cfg
  self:show_empty_recommend(no_recommend_suit)
  if no_recommend_suit then
    return
  end
  self.v_show_attr_num = 1 == LocalStorage:load_int(STORAGE_KEY, 1)
  local recommend_attr_cfg = ShareRes.get_recommend_puzzle_cfg(buddy_id, map_graph_id)
  self.v_base_recommend_puzzles = recommend_suit_cfg.Param
  self.v_base_recommend_attrs = recommend_attr_cfg.RecommendAttrs
  self.v_recommend_attr_id_map = {}
  for _, recommend_attr_id in ipairs(self.v_base_recommend_attrs) do
    self.v_recommend_attr_id_map[recommend_attr_id] = true
  end
  self.v_free_puzzle_data = PuzzleMgr:get_all_free_puzzle(self.v_buddy_id)
  self:set_head_icon()
  self:set_graph_list()
  self:set_attr_list()
  self:set_attr_num_trigger()
  self:bind_auto_mq(Const.MSG_ON_JUMP_TO_SYS, self.on_jump_to_sys, self)
end

function ui:set_head_icon()
  local path = CharacterMgr:get_buddy_icon_path(self.v_buddy_id)
  ResMgr:load_set_icon(self.v_uicompents.Profile_img, path)
end

function ui:set_attr_num_trigger()
  self.v_uiobjects.AttrOn:SetActive(self.v_show_attr_num)
  self.v_uiobjects.AttrOff:SetActive(not self.v_show_attr_num)
end

function ui:show_empty_recommend(is_empty)
  self.v_uiobjects.Info:SetActive(not is_empty)
  self.v_uiobjects.NoRecommend:SetActive(is_empty)
end

function ui:set_graph_list()
  self.v_recommend_attr_id_map = {}
  for _, recommend_attr_id in ipairs(self.v_base_recommend_attrs) do
    self.v_recommend_attr_id_map[recommend_attr_id] = true
  end
  self:clear_wrap_items()
  self:give_back_auto_cache(PUZZLE_ITEM_TEMP_KEY)
  self.v_auto_set_tbl = {}
  self.v_puzzle_item_list = {}
  local id_2_free_puzzle = {}
  local id_2_used_times = {}
  for _, param in ipairs(self.v_base_recommend_puzzles) do
    local puzzle_id = param[4]
    local temp_tbl = {}
    if id_2_free_puzzle[puzzle_id] then
    else
      id_2_free_puzzle[puzzle_id] = temp_tbl
      for _, data in ipairs(self.v_free_puzzle_data) do
        if data.id == puzzle_id then
          local count = 0
          for _, own_attr_cfg_id in ipairs(data.attr_list) do
            local own_attr_id = ShareRes.get_buddy_puzzle_attr_cfg(own_attr_cfg_id).AttrId
            if self.v_recommend_attr_id_map[own_attr_id] then
              count = count + 1
            end
          end
          temp_tbl[#temp_tbl + 1] = {
            id = puzzle_id,
            uuid = data.uuid,
            count = count,
            quality = data.quality
          }
        end
      end
      table.sort(temp_tbl, function(a, b)
        if a.count ~= b.count then
          return a.count > b.count
        end
        if a.quality ~= b.quality then
          return a.quality > b.quality
        end
        return a.uuid > b.uuid
      end)
    end
    local get_idx = id_2_used_times[puzzle_id]
    get_idx = get_idx and get_idx + 1 or 1
    id_2_used_times[puzzle_id] = get_idx
    local data_tbl = id_2_free_puzzle[puzzle_id]
    local get_data = data_tbl and data_tbl[get_idx]
    self:show_puzzle_item(get_data, puzzle_id)
    if get_data then
      self.v_auto_set_tbl[#self.v_auto_set_tbl + 1] = {
        uuid = get_data.uuid,
        position = {
          param[1],
          param[2],
          param[3]
        },
        rotate_count = param[5] or 0,
        buddy_id = self.v_buddy_id
      }
    end
  end
  self:refresh_attr_num_show()
end

function ui:show_puzzle_item(data, puzzle_id)
  local obj = self:get_auto_cache(PUZZLE_ITEM_TEMP_KEY)
  local item = PuzzleItemClass:ui_wrap_ex(self, obj, true)
  item:set_data(data, puzzle_id)
  self.v_puzzle_item_list[#self.v_puzzle_item_list + 1] = item
end

function ui:refresh_attr_num_show()
  if self.v_puzzle_item_list then
    for _, item in ipairs(self.v_puzzle_item_list) do
      item:set_attr_num_show(self.v_show_attr_num)
    end
  end
end

function ui:set_attr_list()
  if not self.v_base_recommend_attrs then
    self.v_uiobjects.AttrLayout:SetActive(false)
    return
  end
  self.v_uiobjects.AttrLayout:SetActive(true)
  self:give_back_auto_cache(ATTR_TEMP_KEY)
  for _, attr_id in ipairs(self.v_base_recommend_attrs) do
    local item = self:get_auto_cache(ATTR_TEMP_KEY)
    local txt = Util.get_text("AttrName", item)
    local icon = Util.get_image("AttrIcon", item)
    txt.text = ShareRes.get_attr_name(attr_id)
    Util.load_attr_icon(icon, ShareRes.get_attr_icon(attr_id))
  end
end

function ui:clear_wrap_items()
  if self.v_puzzle_item_list then
    for _, item in pairs(self.v_puzzle_item_list) do
      item:ui_hide()
      item:ui_destroy()
    end
    self.v_puzzle_item_list = nil
  end
end

return ui
