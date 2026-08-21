local helper = {}
local CommonDef = require("cs_share.common_define")
local Act_ID = CommonDef.ACTY_TYPE.ONLINE_BATTLE
local OnlineConfig = require("gamelogic.activity.online_config")

function helper.quit_match(cur_ui, next_cb, match_op)
  local function net_cb()
    if next_cb then
      next_cb()
    else
      cur_ui:ui_hide()
    end
    UIMgr:try_hide_ui("online_battle_match_tips")
  end
  
  local function ui_cb()
    ActivityMgr:invoke(Act_ID, "request_quit_match", net_cb)
  end
  
  match_op = match_op or OnlineConfig.MATCH_OPERATE.BREAK
  UIMgr:get_ui("online_battle_tips"):ui_show(OnlineConfig.Notice_TIPS_TYPE.MATCH, {ok_cb = ui_cb, match_op = match_op})
end

function helper.quit_room(cur_ui)
  local function net_cb()
    cur_ui:ui_hide()
  end
  
  local function ui_cb()
    ActivityMgr:invoke(Act_ID, "request_leave_room", net_cb)
  end
  
  local lab = Util.format_str("是否退出当前房间？")
  UIMgr:get_ui("online_battle_tips"):ui_show(OnlineConfig.Notice_TIPS_TYPE.ROOM, {ok_cb = ui_cb, lab = lab})
end

function helper.invite_operate(cur_ui, next_cb, info)
  local function net_cb()
    if next_cb then
      next_cb()
    else
      cur_ui:ui_hide()
    end
  end
  
  local function ok_cb()
    ActivityMgr:invoke(Act_ID, "request_invite_accept", info.id, function()
      cur_ui:ui_hide()
    end)
  end
  
  local function no_cb()
    ActivityMgr:invoke(Act_ID, "refuse_match_invited", info.id)
    net_cb()
  end
  
  local player_name = info.player_name
  local point_name = ShareRes.get_chapter_point_cfg(info.epi_id).PointName
  UIMgr:get_ui("online_battle_tips"):ui_show(OnlineConfig.Notice_TIPS_TYPE.INVITATION, {
    ok_cb = ok_cb,
    no_cb = no_cb,
    player_name = player_name,
    point_name = point_name
  })
end

return helper
