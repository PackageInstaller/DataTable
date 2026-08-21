local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
  self.v_mail_list = {}
  self.v_unfinish_mail_num = 0
end

function M:on_mail_list(mail_data_list)
  self.v_mail_list = {}
  self.v_mail_is_read_all = true
  for _, data in pairs(mail_data_list.mail_list) do
    local mail_id = data.uuid
    self.v_mail_list[mail_id] = data
    self.v_mail_list[mail_id].delete = false
    if false == data.read then
      self.v_unfinish_mail_num = self.v_unfinish_mail_num + 1
    end
  end
  MsgGame:mq_publish2(Const.MSG_ON_MAIL_UPDATE)
end

function M:on_mail_info_update(mail_data)
  self.v_mail_list[mail_data.mail.uuid] = mail_data.mail
  self.v_mail_list[mail_data.mail.uuid].delete = false
  self.v_unfinish_mail_num = self.v_unfinish_mail_num + 1
  MsgGame:mq_publish2(Const.MSG_ON_MAIL_UPDATE)
end

function M:get_mail_list()
  return self.v_mail_list
end

function M:get_mail_by_id(mail_id)
  return self.v_mail_list[mail_id]
end

function M:reduce_mail_unfinish_mail_num()
  self.v_unfinish_mail_num = self.v_unfinish_mail_num - 1
end

function M:on_mail_delete(mail_data)
  self.v_mail_list[mail_data.uuid].delete = true
  if self.v_mail_list[mail_data.uuid].read == false then
    self.v_unfinish_mail_num = self.v_unfinish_mail_num - 1
  end
  MsgGame:mq_publish2(Const.MSG_ON_MAIL_UPDATE)
end

function M:is_show_main_red()
  if self.v_mail_list then
    local unfinish_num = 0
    local total_mail_list = self.v_mail_list or {}
    for i, mail_data in pairs(total_mail_list) do
      if mail_data.read == false and not mail_data.delete then
        unfinish_num = unfinish_num + 1
      end
    end
    if unfinish_num > 0 then
      return true
    else
      return false
    end
  end
  if 0 ~= self.v_unfinish_mail_num then
    return true
  else
    return false
  end
end

function M:upgrade_mail_read(mail_uuid, callback)
  Network:protect_call("c2gs_mail_read", {uuid = mail_uuid}, function(ok, resp)
    if ok and resp.read == true then
      self:read_mail(resp.uuid)
      callback(resp.uuid)
    end
    MsgGame:mq_publish2(Const.MSG_ON_MAIL_UPDATE)
  end)
end

function M:upgrade_mail_important(mail_uuid, callback)
  Network:protect_call("c2gs_mail_important", {uuid = mail_uuid}, function(ok, resp)
    if ok then
      callback(resp.uuid, resp.important)
    end
  end)
end

function M:delete_all_read_mail(callback)
  Network:protect_call("c2gs_mail_delete_read", {}, function(ok, resp)
    if ok then
      Util.show_message_tip(2085)
      callback(resp.uuid_list)
    end
  end)
end

function M:get_mail_costitem_list(mail_id_list, callback)
  Network:protect_call("c2gs_mail_get_all", {uuid_list = mail_id_list}, function(ok, resp)
    if ok then
      for _, uuid in pairs(resp.mail_got_list) do
        self:read_mail(uuid)
      end
      callback(resp.mail_got_list)
      MsgGame:mq_publish2(Const.MSG_ON_MAIL_UPDATE)
    end
  end)
end

function M:read_mail(uuid)
  if not self.v_mail_list then
    return
  end
  local mail = self.v_mail_list[uuid]
  if mail and not mail.read then
    mail.read = true
    self:reduce_mail_unfinish_mail_num()
  end
end

function M:check_all_mail_award()
  if not self.v_mail_list then
    return false
  end
  for _, mail_info in pairs(self.v_mail_list) do
    if mail_info.attachment ~= nil and nil ~= next(mail_info.attachment) and not mail_info.read then
      return true
    end
  end
  return false
end

return M
