local Base = require("ui.widget.widget_base")
local Progress = require("ui.widget.progress")
local Math = require("base.mathx")
local M = Util.create_child_mt(Base)
local DEFAULT_FADING_SPEED = 1
local MIN_THRESHOLD = 0.2

function M:_init(image_up, image_bottom, speed, threshold)
  Base._init(self)
  self.v_image_up = image_up
  self.v_obj_up = self.v_image_up.gameObject
  self.v_progress_up = Progress:new(self.v_obj_up)
  self.v_progress_up:update_progress(1)
  if nil ~= image_bottom then
    self.v_image_bottom = image_bottom
    self.v_obj_bottom = self.v_image_bottom.gameObject
    self.v_progress_bottom = Progress:new(self.v_obj_bottom)
    self.v_progress_bottom:update_progress(0)
  end
  self.v_mask_percent = 0
  self.v_percent = 0
  self.v_mask_speed = speed or DEFAULT_FADING_SPEED
  self.v_min_threshold = threshold or MIN_THRESHOLD
end

function M:reset_image(image_up, image_bottom)
  self.v_image_up = image_up
  self.v_obj_up = self.v_image_up.gameObject
  self.v_progress_up:reset_obj(self.v_obj_up)
  self.v_percent = 1
  self.v_progress_up:update_progress(1)
  if nil ~= image_bottom then
    self.v_image_bottom = image_bottom
    self.v_obj_bottom = self.v_image_bottom.gameObject
    self.v_progress_bottom:reset_obj(self.v_obj_bottom)
    self.v_progress_bottom:update_progress(1)
    self.v_mask_percent = 1
  end
end

function M:set_init_info(percent)
  percent = Math.Clamp(percent, 0, 1)
  self.v_percent = percent
  self.v_progress_up:update_progress(percent)
  if self.v_progress_bottom == nil then
    return
  end
  self.v_mask_percent = self.v_percent
  self.v_progress_bottom:update_progress(0)
end

function M:update_force(percent)
  self:set_init_info(percent)
end

function M:update(percent)
  percent = Math.Clamp(percent, 0, 1)
  if self.v_percent ~= percent then
    self.v_percent = percent
    self.v_progress_up:update_progress(self.v_percent)
  end
  if self.v_progress_bottom == nil then
    return
  end
  if self.v_percent < self.v_mask_percent then
    self.v_mask_percent = self.v_mask_percent - math.max(math.abs(self.v_mask_percent - self.v_percent), self.v_min_threshold) * self.v_mask_speed * Date.delta_time()
    if self.v_percent > self.v_mask_percent then
      self.v_mask_percent = self.v_percent
    end
    self.v_progress_bottom:update_progress(self.v_mask_percent)
  else
    self.v_mask_percent = self.v_percent
  end
end

function M:set_fading_speed(speed)
  self.v_mask_speed = speed
end

function M:set_fading_threshold(threshold)
  self.v_min_threshold = threshold
end

return M
