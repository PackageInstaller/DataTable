local Base = require("obj.behavior.uicomponent")
local Progress = require("ui.widget.progress")
local M = Util.create_child_mt(Base)

function M:_init(char, name)
  Base._init(self, char)
  self.v_name = name
end

function M:_update_guild_icon(flag_style_idx, flag_color_idx, flag_word)
  flag_style_idx = flag_style_idx or 0
  flag_color_idx = flag_color_idx or 0
  flag_word = flag_word or ""
  if 0 ~= flag_style_idx and 0 ~= flag_color_idx and "" ~= flag_word then
    local w, h = self.v_name_text:getprintedSizeA()
    local dw = -w / 2 * Global.headbar_mgr.text_to_image_scale
    local local_scale = 0.4
    self.v_camp_title.transform:SetLocalPositionA(-w / 2 * local_scale - 20, 33, 0)
    self:get_head_image()
    self.v_camp_bg.transform:SetAnchoredPosition3DA(dw * local_scale - 30, 37, 0)
    self.v_camp_title:SetActive(true)
    self.v_camp_bg.gameObject:SetActive(true)
    local path = GuildSys:get_style_path(flag_style_idx)
    local code = GuildSys:get_color_str(flag_color_idx)
    local sprite = ResMgr:load_atlas_sprite("HeadBar", path)
    self.v_camp_bg.overrideSprite = sprite
    self.v_camp_title.text = Util.format_ngui_color(flag_word, code)
  else
    self.v_camp_title.gameObject:SetActive(false)
    if self.v_camp_bg then
      self.v_camp_bg:SetActive(false)
    end
  end
end

function M:show_hp_bar(type)
  if self.v_hpbar then
    return
  end
  local height = self.v_char:get_real_height()
  local hpbar, bind = Global.headbar_mgr:get_hp_bar(self.v_char, height)
  self.v_hpbar = hpbar
  self.v_hpbar_bind = bind
  self.v_hpbar_progress = Progress:new(Util.get_child("HPBg/HP", hpbar))
  self.v_hpbar_progress2 = Progress:new(Util.get_child("HPBg2/HP", hpbar))
  if type == Config.HPBAR_TYPE.BOSS then
    Util.get_child("HPBg", hpbar):SetActive(false)
    Util.get_child("HPBg2", hpbar):SetActive(true)
  else
    Util.get_child("HPBg", hpbar):SetActive(true)
    Util.get_child("HPBg2", hpbar):SetActive(false)
  end
  self:update_hp_bar()
end

function M:hide_hp_bar(...)
  if self.v_hpbar then
    self.v_hpbar_progress:reset_obj(Util.get_child("HPBg/HP", self.v_hpbar))
    self.v_hpbar_progress2:reset_obj(Util.get_child("HPBg2/HP", self.v_hpbar))
    Global.headbar_mgr:release_hp_bar(self.v_hpbar, self.v_hpbar_bind)
  end
  self.v_hpbar = nil
  self.v_hpbar_bind = nil
  self.v_hpbar_progress = nil
  self.v_hpbar_progress2 = nil
end

function M:update_hp_bar(...)
  if not self.v_hpbar_progress then
    return
  end
  local attr_mgr = self.v_char.attr_mgr
  self.v_hpbar_progress:update_progress(attr_mgr.hp / attr_mgr.max_hp)
  self.v_hpbar_progress2:update_progress(attr_mgr.hp / attr_mgr.max_hp)
end

function M:clean_up(...)
  Base.clean_up(self, ...)
  self:hide_hp_bar()
end

return M
