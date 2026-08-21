local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local BIND_TYPE = Config.BIND_TYPE

function ui:ui_finish_load()
  self.v_black_canvas_grp = self:get_canvas_group(nil, self.v_uiobjects.Black)
end

function ui:ui_on_show(fade_in_time, hold_time, fade_out_time, callback, is_fade_in_cb, is_white)
  self:refresh_bg_color(is_white)
  fade_in_time = fade_in_time or 0
  hold_time = hold_time or 0
  fade_out_time = fade_out_time or 0
  self.v_callback = callback
  if not self.v_black_canvas_grp then
    self:ui_hide()
    return
  end
  Joystick.on_joystick("end")
  SceneMgr:set_player_control_off()
  self:do_anim(fade_in_time, hold_time, fade_out_time, is_fade_in_cb)
end

function ui:refresh_bg_color(is_white)
  if is_white then
    self.v_uicompents.Black_img.color = UnityEngine.Color(1, 1, 1, 1)
  else
    self.v_uicompents.Black_img.color = UnityEngine.Color(0, 0, 0, 1)
  end
end

function ui:do_anim(fade_in_time, hold_time, fade_out_time, is_fade_in_cb)
  local sequence = Util.create_sequence()
  self.v_sequence = sequence
  sequence:Append(self.v_black_canvas_grp:DOFade(1, fade_in_time))
  if hold_time >= 0 then
    if is_fade_in_cb then
      sequence:AppendCallback(function()
        if self.v_callback then
          self.v_callback()
          self.v_callback = nil
        end
      end)
    end
    sequence:AppendInterval(hold_time)
    if not is_fade_in_cb then
      sequence:AppendCallback(function()
        if self.v_callback then
          self.v_callback()
          self.v_callback = nil
        end
      end)
    end
    sequence:Append(self.v_black_canvas_grp:DOFade(0, fade_out_time))
    sequence:OnComplete(function()
      self:ui_hide()
    end)
  else
    sequence:AppendCallback(function()
      if self.v_callback then
        self.v_callback()
        self.v_callback = nil
      end
    end)
  end
end

function ui:ui_on_hide()
  SceneMgr:set_player_control_on()
  if self.v_sequence then
    self.v_sequence:Kill(false)
    self.v_sequence = nil
  end
  if self.v_callback then
    self.v_callback()
  end
  self.v_callback = nil
end

function ui:ui_on_destroy()
end

return ui
