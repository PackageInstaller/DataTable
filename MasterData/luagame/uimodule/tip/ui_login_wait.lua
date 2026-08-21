local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local Vec3 = require("base.vec3")
local CONNECT_TIP = "获取连接中......"
local LOADING_TIP = "加载资源"
local COMPILE_SHADER_TIP = "编译着色器"

function ui:ui_finish_load()
  UIMgr:get_ui("ui_click_effect"):ui_show()
end

function ui:ui_on_show()
  self:to_shader_warm_stage("0%")
end

function ui:to_login_stage()
  self.v_uicompents.NoticeText_txt.text = CONNECT_TIP
end

function ui:to_shader_warm_stage(progress, is_first_compile_shader)
  local tip = is_first_compile_shader and COMPILE_SHADER_TIP or LOADING_TIP
  self.v_uicompents.NoticeText_txt.text = tip .. " " .. progress
end

function ui:ui_on_hide()
  UIMgr:get_ui("ui_click_effect"):ui_hide()
end

return ui
