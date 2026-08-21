local M = {}

function M.init()
  if M.v_has_init then
    return
  end
  M.v_has_init = true
end

function M.login(callback, cbdata)
  local function login_cb(ok, resp, is_reconnect)
    callback(cbdata, ok, resp, is_reconnect)
  end
  
  local function reconnect_cb()
    UIMgr:get_ui("reconnecting"):ui_show(Config.CONNECT.LOBBY)
    return true
  end
  
  Network:init(login_cb, reconnect_cb)
end

M.init()
return M
