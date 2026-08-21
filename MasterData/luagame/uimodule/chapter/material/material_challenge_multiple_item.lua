local Base = require("ui.uiobject")
local M = Util.create_child_mt(Base)

function M:set_data(data)
  local select = Util.get_child_gameobj("Select", self.v_object)
  local num_text = Util.get_text("TimesNum", self.v_object)
  select:SetActive(data.now_num == data.num)
  num_text.text = tostring(data.num) .. "倍"
  if data.now_num == data.num then
    Util.set_color(num_text, "FFF3DE")
  else
    Util.set_color(num_text, "A19A8d")
  end
  local btn = Util.get_button(nil, self.v_object)
  self:set_button_listener(btn, function()
    local msg = MsgGame:mq_publish2(Const.MSG_UPDATE_CHALLENGE_MULTIPLE_INFO)
    msg.mm_x = data.num
  end)
end

function M:on_clear()
end

return M
