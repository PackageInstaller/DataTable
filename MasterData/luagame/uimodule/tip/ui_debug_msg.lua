local Base = require("ui.uibase")
local ui = Util.create_child_mt(Base)
local LoopListClass = require("ui.widget.infinite_loop_list")
local DebugMsgClass = require("uimodule.tip.debug_msg_item")

function ui:ui_finish_load()
  self.v_msg_list = LoopListClass:new(self, self.v_uiobjects.MsgList, DebugMsgClass)
  self:set_button("BtnFind", function()
    local text = self.v_uicompents.FindStr_txt.text
    self:update_msg_list(text)
  end)
  self:set_button("BtnClose", function()
    self:ui_hide()
  end)
end

function ui:ui_on_show()
  self:update_msg_list()
end

function ui:update_msg_list(grep_str)
  local function callback(info)
    if not grep_str or string.find(info.msg, grep_str) then
      return true
    end
  end
  
  local msg_list = Global.debug_msg_list:filter_back_list(callback)
  self.v_msg_list:refresh_data(msg_list)
end

function ui:ui_on_hide()
end

return ui
