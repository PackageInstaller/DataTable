local Base = require("gamelogic.base_system")
local M = Util.create_child_mt(Base)

function M:init_sys()
  Base.init_sys(self)
end

function M:on_reconnect()
  self.v_liveness_gifts = {}
end

function M:on_gs2c_liveness_gift_info(data)
  self.v_liveness_gifts = data.liveness_gifts
  self:update_red()
  MsgGame:mq_publish2(Const.MSG_ON_LIVENESS_GIFT_UPDATE)
end

function M:req_get_free_award(id, callback)
  Network:protect_call("c2gs_liveness_gift_gain_free_award", {id = id}, function(ok, resp)
    if callback then
      callback()
    end
  end)
end

function M:req_get_award(id, callback)
  Network:protect_call("c2gs_liveness_gift_gain_buyed_award", {id = id}, function(ok, resp)
    if callback then
      callback()
    end
  end)
end

function M:get_liveness_gift_data(id)
  return self.v_liveness_gifts and self.v_liveness_gifts[id]
end

function M:get_id_list()
  if not self.v_liveness_gifts or not next(self.v_liveness_gifts) then
    return
  end
  local list = {}
  for id, _ in pairs(self.v_liveness_gifts) do
    local cfg = ShareRes.get_liveness_gift_cfg(id)
    if RechargeMgr:is_product_valid(cfg) then
      local order = cfg.Order
      list[#list + 1] = {id = id, order = order}
    end
  end
  table.sort(list, function(a, b)
    return a.order < b.order
  end)
  return list
end

M.red_prefix = "liveness_gifts"

function M:update_red()
  local is_red = false
  if self.v_liveness_gifts then
    for id, data in pairs(self.v_liveness_gifts) do
      local free_award_id = ShareRes.get_liveness_gift_cfg(id).FreeAwardGroupId
      local day_num = #ShareRes.create("recharge.liveness_day_award", id)
      is_red = free_award_id and data.can_gain_day_free_award or data.buyed_sign_day > data.buyed_gained_day and day_num > data.buyed_gained_day
      if is_red then
        break
      end
    end
  end
  RedPointMgr:enable_dynamic_redpoint(RedEnum.LIVENESS_GIFT, RedEnum.RECOMMOND_SHOP, is_red)
end

function M:get_gift_red(id)
  if self.v_liveness_gifts then
    local data = self.v_liveness_gifts[id]
    local free_award_id = ShareRes.get_liveness_gift_cfg(id).FreeAwardGroupId
    local day_num = #ShareRes.create("recharge.liveness_day_award", id)
    return data and (free_award_id and data.can_gain_day_free_award or data.buyed_sign_day > data.buyed_gained_day and day_num > data.buyed_gained_day)
  end
  return false
end

return M
