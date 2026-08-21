local CSHelper = _ENV.CSHelper
local NOT_REACHABLE = 0
local NET_CHECK_COUNTER = 20
local NET_CHECK_MAX_CNT = 3
local M = Util.create_class()

function M:_init()
  self.v_net_reachable = true
  self.v_net_check_counter = 0
  self.v_net_disable_cnt = 0
end

function M:_check_network_reachability()
  if self.v_net_reachable then
    self.v_net_check_counter = self.v_net_check_counter + 1
    if self.v_net_check_counter <= NET_CHECK_COUNTER then
      return
    end
    self.v_net_check_counter = 0
  end
  local cur = CSHelper.GetNetworkReachability()
  if cur == NOT_REACHABLE then
    self.v_net_disable_cnt = self.v_net_disable_cnt + 1
    if self.v_net_disable_cnt >= NET_CHECK_MAX_CNT then
      self.v_net_reachable = false
    end
  else
    self.v_net_reachable = true
    self.v_net_disable_cnt = 0
  end
end

function M:update()
  self:_check_network_reachability()
end

function M:is_net_reachable()
  return self.v_net_reachable
end

function M:get_ip_address()
  return CSHelper.GetIPAddress("http://checkip.amazonaws.com/")
end

return M
