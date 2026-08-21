local Base = require("uimodule.pop_up_widget.ui_popup_base")
local ui = Util.create_child_mt(Base)
local SDK_POP_TYPE = {Banner = 1, News = 2}

function ui:ui_finish_load()
  self:set_button("BtnCloseBg", function()
  end)
end

function ui:ui_on_show(widget_id)
  self.v_widget_id = widget_id
  self.v_widget_cfg = ShareRes.get_pop_widget_cfg(widget_id)
  local arg = self.v_widget_cfg.Arg
  if not arg or not arg[1] then
    Log.Error("未配置SDK弹窗的Arg[1]")
    Base:manual_close()
    return
  end
  
  local function on_closed()
    PopUpWindowMgr:pop_widget_up(widget_id)
    Base:manual_close()
  end
  
  if arg[1] == SDK_POP_TYPE.Banner then
    if SDKManager.display_banner then
      SDKManager:display_banner(on_closed)
      return
    end
  elseif arg[1] == SDK_POP_TYPE.News and SDKManager.show_news then
    SDKManager:show_news(on_closed)
    return
  end
  on_closed()
end

return ui
