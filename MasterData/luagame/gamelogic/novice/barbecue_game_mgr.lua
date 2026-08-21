local Base = require("gamelogic.base_system")
local UpgradeCfg = ShareRes.create("activity.barbecue_stall_sys_update")
local AllStageCfg = ShareRes.create("activity.barbecue_stall_episode")
local LocalStorage = require("utils.localstorage")
local M = Util.create_child_mt(Base)
local BASE_STAGE_READ_RECOED_STORAGE_KEY = "BBQ_STAGE_READ_RECOED_STORAGE_KEY"

function M:init_sys()
  Base.init_sys(self)
  self:sys_mq_bind(Const.MSG_ON_NOVICE_ACTIVITY_OPEN, self.update_new_stage_red, self)
end

function M:on_reconnect()
end

function M:on_gs2c_activity_barbecue_episode_data(data)
  self.v_activity_id = data.activity_id
  self.STAGE_READ_RECOED_STORAGE_KEY = BASE_STAGE_READ_RECOED_STORAGE_KEY .. self.v_activity_id
  self.v_stage_datas = {}
  for _, episode_data in pairs(data.episode_data) do
    self.v_stage_datas[episode_data.episode_id] = episode_data
  end
  self.v_lv_datas = {}
  for _, sys_data in pairs(data.sys_data) do
    self.v_lv_datas[sys_data.id] = sys_data.lv
  end
  self.v_finish_lv_task_record = {}
  for _, finish_sys_task_id in pairs(data.finish_sys_task_id) do
    self.v_finish_lv_task_record[finish_sys_task_id] = true
  end
  self:update_new_stage_red()
  MsgGame:mq_publish2(Const.MSG_ON_BBQ_GAME_DATA_UPDATE)
end

function M:on_gs2c_activity_update_barbecue_episode_data(data)
  if data.activity_id ~= self.v_activity_id then
    Log.Error("错误的烧烤摊活动id:", data.activity_id, self.v_activity_id)
  end
  local episode_data = data.episode_data
  self.v_stage_datas[episode_data.episode_id] = episode_data
  self:update_new_stage_red()
  MsgGame:mq_publish2(Const.MSG_ON_BBQ_GAME_DATA_UPDATE)
end

function M:on_gs2c_barbecue_stall_update_sys_data(data)
  if data.activity_id ~= self.v_activity_id then
    Log.Error("错误的烧烤摊活动id:", data.activity_id, self.v_activity_id)
  end
  local sys_data = data.sys_data
  self.v_lv_datas[sys_data.id] = sys_data.lv
  for k, finish_sys_task_id in pairs(data.finish_sys_task_id) do
    self.v_finish_lv_task_record[finish_sys_task_id] = true
  end
  MsgGame:mq_publish2(Const.MSG_ON_BBQ_SYS_UPDATE)
end

function M:report_score(stage_id, score, cb)
  Network:call("c2gs_barbecue_stall_game_set_score", {
    activity_id = self.v_activity_id,
    episode_id = stage_id,
    score = score
  }, function()
    cb()
  end)
end

function M:send_upgrade(sys_task_id, cb)
  Network:call("c2gs_barbecue_stall_update_sys_grade", {
    activity_id = self.v_activity_id,
    sys_task_id = sys_task_id
  }, function(ok)
    cb(ok)
  end)
end

function M:get_activity_id()
  return self.v_activity_id
end

function M:get_stage_data(stage_id)
  return stage_id and self.v_stage_datas and self.v_stage_datas[stage_id]
end

function M:is_stage_pass(stage_id)
  return self.v_stage_datas and self.v_stage_datas[stage_id] and self.v_stage_datas[stage_id].score > 0
end

function M:is_sys_upgrade_finish(upgrade_id)
  return self.v_finish_lv_task_record and self.v_finish_lv_task_record[upgrade_id]
end

function M:get_val_by_sys_id(sys_id)
  local lv = self:get_sys_lv(sys_id)
  local cfg = ShareRes.create("activity.barbecue_stall_sysid", sys_id)
  if not cfg or not cfg[lv] then
    Log.Error("烧烤小游戏等级配置错误，sysid、lv:", sys_id, lv)
    return
  end
  return cfg[lv].Param
end

function M:get_sys_lv(sys_id)
  return self.v_lv_datas and self.v_lv_datas[sys_id] or 1
end

function M:get_stage_list(activity_id)
  local cfgs = ShareRes.create("activity.barbecue_stall_episode_activity_group")[activity_id]
  if not cfgs then
    Log.Error("烧烤小游戏无对应所属活动id配置：", activity_id)
    return {}
  end
  local stage_list = {}
  for _, cfg in pairs(cfgs) do
    stage_list[#stage_list + 1] = cfg
  end
  table.sort(stage_list, function(a, b)
    return a.Order < b.Order
  end)
  return stage_list
end

function M:update_new_stage_red()
  local is_active = NoviceMgr:get_novice_activity_active(self.v_activity_id)
  if not is_active then
    RedPointMgr:enable_redpoint(RedEnum.BBQ_GAME_NEW_STAGE, false)
    return
  end
  local any_new = false
  local history = LocalStorage:load_table(self.STAGE_READ_RECOED_STORAGE_KEY, true) or {}
  if self.v_stage_datas then
    for _, data in pairs(self.v_stage_datas) do
      local act_data = AllStageCfg[data.episode_id]
      if act_data and act_data.ActivityId == self.v_activity_id and data.is_challenge and not data.is_lock and 0 == data.score and not history[data.episode_id] then
        any_new = true
        break
      end
    end
  end
  RedPointMgr:enable_redpoint(RedEnum.BBQ_GAME_NEW_STAGE, any_new)
end

function M:is_stage_new(stage_id)
  local data = self:get_stage_data(stage_id)
  if data and data.is_challenge and not data.is_lock and 0 == data.score then
    local history = LocalStorage:load_table(self.STAGE_READ_RECOED_STORAGE_KEY, true) or {}
    if not history[data.episode_id] then
      return true
    end
  end
  return false
end

function M:read_stage(stage_id)
  local is_new = false
  local data = self:get_stage_data(stage_id)
  if data and data.is_challenge and not data.is_lock and 0 == data.score then
    local history = LocalStorage:load_table(self.STAGE_READ_RECOED_STORAGE_KEY, true) or {}
    if not history[data.episode_id] then
      history[data.episode_id] = 1
      LocalStorage:save_table(self.STAGE_READ_RECOED_STORAGE_KEY, history, true)
      is_new = true
    end
  end
  self:update_new_stage_red()
  return is_new
end

function M:is_any_upgrade()
  for _, cfg in pairs(UpgradeCfg) do
    local sys_id = cfg.EffectSys
    local cur_lv = BarbecueGameMgr:get_sys_lv(sys_id)
    local is_finish = BarbecueGameMgr:is_sys_upgrade_finish(cfg.Id) == true
    if cfg.LimitationLv == cur_lv and not is_finish then
      local own_num = BagMgr:get_item_num(cfg.CostItem)
      if own_num >= cfg.CostCount then
        return true
      end
    end
  end
end

return M
