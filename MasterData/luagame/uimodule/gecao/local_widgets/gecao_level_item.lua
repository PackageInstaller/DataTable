local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)
local chapter_bg_show_time = 0.2
local chapter_text_show_time = 0.3
local chapter_bg_and_text_interval_time = 0.05
local chapter_show_all_time = chapter_bg_show_time + chapter_text_show_time + chapter_bg_and_text_interval_time
local generate_chapter_interval_time = 0.1
local Stars = {
  "Star1",
  "Star2",
  "Star3"
}

local function _set_star(self)
  local star_num = ChapterMgr:get_cut_grass_epi_star_num(self.v_data.Id)
  local uobj = self.v_uiobjects
  for i = 1, 3 do
    local star_obj = uobj[Stars[i]]
    star_obj:SetActive(i <= star_num)
  end
end

local function _play_anim(self)
  local uobj = self.v_uiobjects
  local main_bg_canvas_group = self:get_canvas_group(nil, uobj.MainBg)
  local main_text_canvas_group = self:get_canvas_group(nil, uobj.MainText)
  local lock_image_canvas_group = self:get_canvas_group(nil, uobj.LockImagePart)
  local lock_text_canvas_group = self:get_canvas_group(nil, uobj.LockTextPart)
  local item_canvas = self:get_canvas_group(nil, self.go)
  item_canvas.alpha = 1
  main_bg_canvas_group.alpha = 0
  main_text_canvas_group.alpha = 0
  lock_image_canvas_group.alpha = 0
  lock_text_canvas_group.alpha = 0
  local sequence = Util.create_sequence()
  sequence:AppendInterval((self.v_data.index - 1) * generate_chapter_interval_time)
  sequence:Append(lock_image_canvas_group:DOFade(1, 0))
  sequence:Join(main_bg_canvas_group:DOFade(1, chapter_bg_show_time))
  sequence:AppendInterval(chapter_bg_and_text_interval_time)
  sequence:Append(main_text_canvas_group:DOFade(1, chapter_text_show_time))
  sequence:Join(lock_text_canvas_group:DOFade(1, chapter_text_show_time))
  table.insert(self.v_sequences, sequence)
end

function M:set_data(data)
  self:on_clear(false)
  self.v_data = data
  local net_data = ChapterMgr:get_cut_grass_epi_data_by_id(data.Id)
  local ucom = self.v_uicompents
  local uobj = self.v_uiobjects
  ResMgr:load_set_icon(ucom.ChapterIcon_img, data.BgName, nil, true, self)
  ucom.ChapterName_txt.text = data.Name
  ucom.Difficulty_txt.text = data.LevelName
  uobj.Locked:SetActive(net_data.is_lock or false)
  if net_data.is_lock then
    ucom.LockText_txt.text = data.OpenStar
  end
  _set_star(self)
  local select_btn = self:get_button(nil, nil)
  self:set_button_listener(select_btn, function()
    local parent_ui = UIMgr:try_get_ui("gecao_main")
    if parent_ui then
      parent_ui:move_level_item_to_first(data)
    end
  end)
  _play_anim(self)
end

function M:get_width()
  return self.rect_trans.sizeDelta.x
end

function M:remove_sequences(is_nil)
  if self.v_sequences then
    for k, sequence in pairs(self.v_sequences) do
      sequence:Kill(false)
    end
  end
  if is_nil then
  end
  self.v_sequences = {}
end

function M:on_clear(is_nil)
  self:unbind_all_auto_mq()
  self:remove_sequences(is_nil)
end

return M
