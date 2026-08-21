local helper = {}
local SpineController = typeof(CS.Game.SpineController)
local CSScreen = UnityEngine.Screen
local _randomseed = math.randomseed
local _random = math.random
local _time = os.time
local DESIGN_RATIO = 1.7777777777777777
helper.UPDATE_TIME = 0
helper.ANIM_TYPE = {
  CLICK = 1,
  INTERVAL = 2,
  SINGLE = 3
}
helper.TRACK_TYPE = {
  BODY = 1,
  EYES = 2,
  MOUTH = 3
}
helper.TRACK_TYPE_LOOP = {
  [helper.TRACK_TYPE.BODY] = false,
  [helper.TRACK_TYPE.EYES] = false,
  [helper.TRACK_TYPE.MOUTH] = true
}
helper.TRACK_TYPE_TO_NAME = {
  [helper.TRACK_TYPE.BODY] = "BodyAnim",
  [helper.TRACK_TYPE.EYES] = "EyeAnim",
  [helper.TRACK_TYPE.MOUTH] = "MouthAnim"
}

function helper.load_char_spine_res(rt_view, spine_id, img_obj, is_sync_load)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  local role_res = spine_cfg.SpineRes
  local loop_anim_name = spine_cfg.DefaultAnim
  local pos_info = spine_cfg.Pos
  local scale = pos_info[4]
  if 1 == spine_cfg.IfFitScreen and CSScreen.width / CSScreen.height > DESIGN_RATIO then
    scale = scale * (CSScreen.width * 1080 / (CSScreen.height * 1920))
  end
  
  local function load_cb(obj)
    if img_obj and not img_obj:IsNull() then
      img_obj:SetActive(true)
      obj:ResetAttr()
      obj.transform:SetLocalScaleA(scale, scale, scale)
      obj.transform:SetLocalPositionA(pos_info[1], pos_info[2], pos_info[3])
      local spine_component = obj:GetComponent(SpineController)
      if spine_component and not spine_component:IsNull() then
        spine_component:ClearTrackIndex()
        rt_view:play_loop_anim(role_res, loop_anim_name)
      else
        return
      end
    end
  end
  
  rt_view:load_spine_res(role_res, load_cb, is_sync_load)
end

function helper.check_play_anim(rt_view, anim_data)
  if not anim_data.spine_group_anim then
    return
  end
  if not rt_view then
    return
  end
  local res_name = anim_data.record_data.res_name
  local start_time = anim_data.record_data.start_time
  local now_time = Global.real_time
  local record_data = anim_data.record_data
  local spine_group_anim = anim_data.spine_group_anim
  local interval_time = now_time - start_time
  record_data.BodyAnim = record_data.BodyAnim or 1
  record_data.EyeAnim = record_data.EyeAnim or 1
  record_data.MouthAnim = record_data.MouthAnim or 1
  record_data.BodyAnimTotalTime = record_data.BodyAnimTotalTime or 0
  record_data.EyeAnimTotalTime = record_data.EyeAnimTotalTime or 0
  record_data.MouthAnimTotalTime = record_data.MouthAnimTotalTime or 0
  for _, track_index in pairs(helper.TRACK_TYPE) do
    local name = helper.TRACK_TYPE_TO_NAME[track_index]
    local index = record_data[name]
    if spine_group_anim[name] and spine_group_anim[name][index] then
      local anim_name = spine_group_anim[name][index]
      local is_loop = helper.TRACK_TYPE_LOOP[track_index]
      if spine_group_anim.NoLoopAnim ~= nil then
        for _, data in pairs(spine_group_anim.NoLoopAnim) do
          if anim_name == data then
            is_loop = false
          end
        end
      end
      local time_cfg = spine_group_anim[name .. "Time"]
      local delay_time = time_cfg[index][1]
      local anim_time = time_cfg[index][2]
      if interval_time > delay_time + record_data[name .. "TotalTime"] and not record_data[name .. "Start"] then
        rt_view:play_anim(res_name, anim_name, is_loop, track_index)
        record_data[name .. "Start"] = true
      end
      if interval_time > delay_time + anim_time + record_data[name .. "TotalTime"] then
        record_data[name] = record_data[name] + 1
        record_data[name .. "Start"] = nil
        record_data[name .. "TotalTime"] = delay_time + anim_time
        if is_loop then
          rt_view:play_anim(res_name, anim_name, false, track_index)
        end
      end
    end
  end
  if not spine_group_anim.TotalTime or interval_time > spine_group_anim.TotalTime + 0.3 then
    record_data.play_end = true
    record_data.play_start = false
    anim_data.spine_group_anim = nil
  end
end

function helper.get_anim_interval(spine_id)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  if spine_cfg.OpenStyle2 then
    return spine_cfg.Param2
  end
  return nil
end

function helper.get_single_anim_delay(spine_id)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  if spine_cfg.OpenStyle3 then
    return spine_cfg.Param3
  end
  return nil
end

function helper.get_anim_click(spine_id)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  return spine_cfg.OpenStyle1
end

function helper.get_anim_group(spine_id, type)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  local id
  if type == helper.ANIM_TYPE.CLICK then
    id = spine_cfg.AnimGroup1[helper.get_random_wight(spine_cfg.Wight1)]
  elseif type == helper.ANIM_TYPE.INTERVAL then
    id = spine_cfg.AnimGroup2[helper.get_random_wight(spine_cfg.Wight2)]
  elseif type == helper.ANIM_TYPE.SINGLE then
    id = spine_cfg.AnimGroup3[helper.get_random_wight(spine_cfg.Wight3)]
  end
  return ShareRes.get_spine_anim_group_cfg(id)
end

function helper.get_random_wight(wight_table)
  local sum_wight = 0
  for _, wight in pairs(wight_table) do
    sum_wight = sum_wight + wight
  end
  local select_index = 0
  local cur_wight = 0
  _randomseed(_time())
  local random_wight = _random(1, sum_wight)
  for _, wight in ipairs(wight_table) do
    cur_wight = cur_wight + wight
    select_index = select_index + 1
    if random_wight <= cur_wight then
      return select_index
    end
  end
  return select_index
end

function helper.get_spine_res(spine_id)
  local spine_cfg = ShareRes.get_spine_cfg(spine_id)
  return spine_cfg.SpineRes
end

function helper.init_anim_info(spine_id, anim_info, anim_trigger_type)
  if anim_trigger_type == helper.ANIM_TYPE.CLICK and not helper.get_anim_click(spine_id) then
    return
  end
  anim_info.record_data = {}
  anim_info.record_data.play_end = false
  anim_info.record_data.play_start = true
  anim_info.record_data.play_style = anim_trigger_type
  anim_info.record_data.res_name = helper.get_spine_res(spine_id)
  anim_info.record_data.start_time = Global.real_time
  anim_info.spine_group_anim = helper.get_anim_group(spine_id, anim_trigger_type)
  anim_info.record_data.play_interrupt = anim_info.spine_group_anim.Interrupt
end

function helper.get_init_anim_info()
  local res = {}
  res.record_data = {}
  res.record_data.play_end = true
  res.record_data.play_start = false
  return res
end

return helper
