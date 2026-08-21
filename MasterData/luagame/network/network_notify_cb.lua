local Seri = require("seri")
local network_notify_cb = {}
local CommonDefine = require("cs_share.common_define")
local Account = require("gamelogic.account.account")
local LocalStorage = require("utils.localstorage")
local tb = {}

local function on_get_role_base_info(data)
  PlayerMgr:on_get_role_base_info(data.role_info)
end

local function on_get_buddy_list(data)
  CharacterMgr:on_get_buddy_list(data.buddys)
end

local function on_get_buddy_info(data)
  CharacterMgr:on_get_buddy_info(data.buddy)
end

local function on_get_equip_list(data)
  CharacterMgr:on_get_equip_list(data.equips)
end

local function on_get_equip(data)
  CharacterMgr:on_get_equip(data.equip)
end

local function on_delete_equip(data)
  CharacterMgr:on_delete_equip(data)
end

local function on_get_buddy_attribute(data)
end

local function on_get_buddy_advance(data)
end

local function on_buddy_to_advance_item(data)
  CharacterMgr:on_buddy_to_advance_item(data)
end

local function on_get_scenepos(data)
end

function tb.phone_debug_info(...)
  if GAME_DEBUG and not UNITY_EDITOR then
    Log.Info(...)
  end
end

local function on_get_bag_items(data)
  tb.phone_debug_info("gs2c_bag_items", data)
  BagMgr:on_get_item_list(data)
end

local function on_set_tower_info(data)
  TowerMgr:update_tower_info(data)
end

local function on_refresh_room_info(data)
  TowerMgr:update_room_info(data)
end

local function on_res_update(data)
  CharacterMgr:on_res_update(data)
end

local function on_res_list(data)
  CharacterMgr:on_res_list(data)
end

local function on_init_exchange_times(data)
  CharacterMgr:on_init_exchange_times(data)
end

local function on_item_update(data)
  tb.phone_debug_info("gs2c_items_update", data)
  BagMgr:on_items_update(data)
end

local function on_item_delete(data)
  tb.phone_debug_info("gs2c_item_delete", data)
  BagMgr:on_item_delete(data)
end

local function on_ret_task_list(data)
  TaskMgr:on_ret_task_list(data)
end

local function on_ret_task(data)
  TaskMgr:update_task(data)
end

local function on_task_group_list(data)
  TaskMgr:update_task_group_list(data)
end

local function on_task_group_info(data)
  TaskMgr:update_task_group_info(data)
end

function tb.on_task_group_award_list(data)
  TaskMgr:update_task_group_award_list(data)
end

local function on_create_battle_team(data)
  TowerMgr:on_create_battle_team(data)
end

local function _log_rpc(func_name, args)
  if Global.is_open_rpc_log then
    Log.Info("关卡rpc调用", func_name, args, "当前帧id", Global.frame_id)
  end
end

local function on_scene_call(data)
  local scene_rpc = SceneMgr:get_scene_rpc()
  assert(scene_rpc[data.method], "no such method[" .. data.method .. "]")
  local func_name = data.method
  local args = Seri.unpack(data.pack_args)
  _log_rpc(func_name, args)
  scene_rpc[data.method](scene_rpc, Seri.unpack(data.pack_args))
end

local function on_fight_end(data)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    scene_logic:fight_end(data.is_win)
  end
end

local function on_get_fight_time(data)
  local tower = TowerMgr:get_tower()
  tower:set_continue_fight_time(data.fight_time)
  local fight_info = TowerMgr:get_fight_info()
  if fight_info and fight_info.type == CommonDefine.CHALLENGE_TYPE.INFINITE then
    ChapterMgr:set_continue_fight_time(data.fight_time)
  end
end

local function on_newbie_info(data)
  NewbieTowerMgr:on_newbie_info(data)
end

local function on_tp_room(data)
  local scene_logic = SceneMgr:get_scene_logic()
  if scene_logic then
    Log.Info("on_tp_room start")
    scene_logic:tp_room(data.src_tp_dir)
  else
    Log.Error("on_tp_room logic null")
  end
end

local function on_ret_chapter_list(data)
  ChapterMgr:on_ret_chapter_list(data)
end

local function on_ret_cut_grass_epi_list(data)
  ChapterMgr:on_ret_cut_grass_epi_list(data)
end

local function on_ret_cut_grass_epi_data(data)
  ChapterMgr:on_ret_cut_grass_epi_data(data)
end

function tb.on_refresh_npc_shop_data(data)
  FunctionalNpcMgr:on_refresh_npc_shop_data(data)
end

local function on_chapter_update(data)
  ChapterMgr:on_chapter_update(data)
end

local function on_chapter_point_update(data)
  ChapterMgr:update_chapter_point_data(data)
end

local function on_battle_item_delete(data)
  FightBagMgr:on_item_delete(data)
end

local function on_battle_items_update(data)
  FightBagMgr:on_items_update(data)
end

local function on_battle_items(data)
  FightBagMgr:on_get_item_list(data)
end

local function on_wear_info_list(data)
  FightBagMgr:on_wear_info_list(data)
end

local function on_wear_info_update(data)
  FightBagMgr:on_wear_info_update(data)
end

local function on_virtual_res_update(data)
  FightBagMgr:on_res_update(data)
end

local function on_battle_items_init(data)
  FightBagMgr:on_get_item_list(data)
end

local function on_battle_drop_list(data)
  FightBagMgr:on_battle_drop_list(data)
end

local function on_prefab_team_list(data)
  FormationMgr:on_prefab_team_list(data.prefab_team_list)
end

local function on_prefab_team_update(data)
  FormationMgr:on_prefab_team_update(data.prefab_team)
end

local function on_fight_team_list(data)
  FormationMgr:on_fight_team_list(data.fight_team_list)
end

local function on_fight_team_update(data)
  FormationMgr:on_fight_team_update(data.fight_team)
end

local function on_tower_progress(data)
  TowerMgr:update_tower_progress(data)
end

local function on_scene_skill(data)
  TowerMgr:on_ret_scene_skill(data)
end

local function on_scene_skill_upgrade(data)
  TowerMgr:scene_skill_upgrade(data)
end

local function on_ret_award_list(data)
  BagMgr:show_reward_list(data)
end

function tb.on_gs2c_award_exchange(data)
  BagMgr:show_award_exchange(data)
end

local function on_ret_sysopen_list(open_list)
end

local function on_ret_new_sysopen(sys_id)
end

local RES_ERR_TIP = "前后台资源版本号不匹配错误"

local function on_recv_server_log(data)
  local warning_level = data.warning_level
  local prefix = data.ex_tips or ""
  if data.message == "掉落工具打印" then
    local drop_info = string.gsub(prefix, "<br>", "\n")
    Log.Info("掉落信息--", drop_info)
    return
  end
  if not warning_level or 2 == warning_level then
    Log.Error("scene_error: " .. prefix, data.message)
  elseif 1 == warning_level then
    Log.Info("scene_print: ", data.message)
  end
  if prefix == RES_ERR_TIP then
    Global.res_err = true
    Global.res_err_tip = data.message
  end
end

local function on_mail_list(data)
  MailMgr:on_mail_list(data)
end

local function on_mail_info_update(data)
  MailMgr:on_mail_info_update(data)
end

local function on_mail_delete(data)
  MailMgr:on_mail_delete(data)
end

local function on_battle_shop_item_list(data)
  BattleShopMgr:on_battle_shop_item_list(data)
end

local function on_refresh_battle_shop_discount(data)
  BattleShopMgr:on_refresh_battle_shop_discount(data)
end

local function on_battle_talent_update(data)
  BattleTalentMgr:on_battle_talent_update(data)
end

local function on_battle_talent_active_talent_ids(data)
end

local function on_hero_status_init(data)
  local data = Seri.unpack(data.pack_info)
  SceneMgr:sycn_saved_attrs(data)
end

local function on_sign_in_history(data)
  SignInMgr:on_sign_in_hisotry(data)
end

local function on_show_read_point(data)
  if data.type == CommonDefine.REDPOINT_TYPE.SIGN_IN then
    SignInMgr:on_update_red_point()
  elseif data.type == CommonDefine.REDPOINT_TYPE.FRIEND then
    FriendMgr:update_red()
  elseif data.type == CommonDefine.REDPOINT_TYPE.GUILD_BE_INVITED then
    UnionMgr:show_invitation_redpoint()
  elseif data.type == CommonDefine.REDPOINT_TYPE.GUILD_APPLICATION then
    UnionMgr:show_application_redpoint()
  end
end

local function on_notice_list(data)
  NoticeMgr:on_notice_list(data)
end

local function on_update_notice(data)
  NoticeMgr:on_update_notice(data)
end

local function on_delete_notice(data)
  NoticeMgr:on_delete_notice(data)
end

local function on_player_info(data)
  PlayerMgr:on_player_info(data)
end

local function on_draw_group_list(data)
  DrawCardMgr:recv_draw_group_list(data)
end

local function on_draw_group_update(data)
  DrawCardMgr:recv_draw_group_update(data)
end

local function on_draw_pool_close(data)
  DrawCardMgr:recv_draw_pool_close(data)
end

local function on_draw_group_close(data)
  DrawCardMgr:recv_draw_group_close(data)
end

local function on_draw_pool_update(data)
  DrawCardMgr:recv_draw_pool_update(data)
end

local function on_draw_pool_info(data)
  DrawCardMgr:recv_draw_pool_info(data)
end

function tb.on_free_draw_data_update(data)
  DrawCardMgr:recv_free_draw_data(data)
end

local function on_exchange_shop(data)
  ShopMgr:on_get_ex_shop_goods_update(data)
end

local function on_unlock_exchange_goods(data)
  ShopMgr:on_ex_shop_goods_unlock(data)
end

local function on_expire_exchange_goods(data)
  ShopMgr:on_ex_shop_goods_expire(data)
end

local function on_expire_exchange_shop(data)
  ShopMgr:on_ex_shop_expire(data)
end

local function on_reset_exchange_shop(data)
  ShopMgr:on_reset_ex_shop_data(data)
end

local function on_monitor_item_cnt(data)
  ShopMgr:on_stock_item_update(data)
end

local function on_exchange_shop_list(data)
  ShopMgr:on_get_ex_shop_data(data)
end

local function on_exchange_goods_mask_new(data)
  ShopMgr:on_goods_mark_update(data)
end

function tb.on_exchange_goods_reset(data)
  ShopMgr:on_get_ex_shop_goods_update(data)
end

local function on_ret_inf_chapter_list(data)
  ChapterMgr:on_ret_inf_chapter_list(data)
end

local function on_inf_chapter_update(data)
  ChapterMgr:on_inf_chapter_update(data)
end

local function on_inf_chapter_update_floor(data)
  ChapterMgr:on_inf_chapter_update_floor(data)
end

local function on_update_infinite_award_info(data)
  ChapterMgr:on_update_infinite_award_info(data)
end

local function on_battle_infinite_privilege(data)
  ChapterMgr:on_battle_infinite_privilege(data)
end

function tb.on_update_infinite_rank_data(data)
  ChapterMgr:on_update_infinite_rank_data(data)
end

function tb.update_unlock_entry(data)
  ChapterEndlessMgr:update_unlock_entry(data)
end

local function on_episode_archives_info(data)
  ChapterMgr:on_episode_archives_info(data)
end

local function on_add_episode_archives_id(data)
  ChapterMgr:on_add_episode_archives_id(data)
end

local function on_del_episode_archives_id(data)
  ChapterMgr:on_del_episode_archives_id(data)
end

local function on_material_list_update(data)
  ChapterMgr:on_material_list_update(data)
end

local function on_material_chapter_update_floor(data)
  ChapterMgr:on_material_chapter_update_floor(data)
end

local function on_material_data_update(data)
  ChapterMgr:on_material_data_update(data)
end

local function on_material_expire(id)
  ChapterMgr:on_material_expire(id)
end

function tb.on_material_epi_list_update(data)
  ChapterMaterialMgr:on_material_epi_list_update(data)
end

function tb.on_material_epi_data_update(data)
  ChapterMaterialMgr:on_material_epi_data_update(data)
end

local function on_player_upgrade(data)
  PlayerMgr:on_player_upgrade(data)
end

local function on_battle_treasure_info(data)
  BattleTreasureMgr:on_battle_treasure_info(data)
end

local function on_fashion_list_ret(data)
  FashionMgr:on_ret_fashion_data(data)
end

local function on_fashion_info_ret(data)
  FashionMgr:on_ret_refresh_fashion_data(data.buddy_fashion)
end

function tb.on_equip_fashion_update(data)
  FashionMgr:on_equip_fashion_update(data)
end

function tb.on_equip_fashion_list(data)
  FashionMgr:on_equip_fashion_list(data)
end

local function on_sys_list_init(data)
  SysOpenMgr:on_sys_list_init(data)
end

local function on_sys_open(data)
  SysOpenMgr:on_sys_open(data)
end

local function on_battle_skill(data)
  BattleSkillBookMgr:on_battle_skill(data)
end

local function on_battle_skill_select_list(data)
  BattleSkillBookMgr:on_battle_skill_select_list(data)
end

local function on_logout(data)
  local reason_id = tonumber(data.reason)
  Network:close()
  Util.show_notify_popup_message(function()
    Global.gamemode:gmode_set_mode(Const.MODE_CHECK_UPDATE)
  end, Util.get_error_code_msg(reason_id), "网络断开", "确定", nil, nil, true)
end

local function on_refresh_login_token(data)
  Log.Info("update_token " .. data.login_token)
  Account:update_login_token(data.login_token)
end

local function on_battle_drop_show_list(data)
  TowerMgr:set_drop_show_list(data)
  DropShowMgr:on_battle_drop_show_list(data)
end

local function on_word_chat_info(data)
  ChatMgr:sync_word_chat_info(data)
end

local function on_friend_chat_info(data)
  ChatMgr:sync_friend_chat_info(data)
end

local function on_system_notify(data)
  ChatMgr:sync_system_notify(data)
end

function tb.gs2c_del_revolve(data)
  MarqueeMgr:remove_msg(data.msg_index)
end

local function on_battle_room_data(data)
  TowerMgr:on_battle_room_data(data)
end

local function on_newbie_sign_in_history(data)
  NoviceMgr:sync_newbie_sign_in_history(data)
end

local function get_activity_seven_sign_in_data(data)
  NoviceMgr:get_activity_seven_sign_in_data(data)
end

local function on_close_activity(data)
  NoviceMgr:sync_close_activity(data)
end

local function on_guide_update(data)
  GuideMgr:sync_guide_update(data)
  GraphicGuideMgr:sync_guide_update(data)
end

local function on_battle_task_list(data)
  BattleTaskMgr:sync_battle_task_list(data)
end

local function on_battle_task_info(data)
  BattleTaskMgr:sync_battle_task_info(data)
end

local function on_battle_task_failed(data)
  BattleTaskMgr:sync_battle_task_failed(data.task_id)
end

local function on_battle_update_mark_task(data)
  BattleTaskMgr:update_track_task_id(data)
end

local function on_battle_treasure_box_list(data)
  BattleTreasureBoxMgr:on_battle_treasure_box_list(data)
end

local function on_best_conf_tower_list(data)
  local activity = ActivityMgr:get_top_version_act()
  if activity then
    activity:sync_best_conf_tower_list(data)
  end
end

local function on_best_conf_tower_data(data)
  local activity = ActivityMgr:get_top_version_act()
  if activity then
    activity:sync_best_conf_tower_data(data)
  end
end

local function on_update_acty_open(data)
  ActivityMgr:sync_update_acty_open(data)
end

local function on_acty_open_list(data)
  ActivityMgr:sync_acty_open_list(data)
end

local function on_battle_data_abnormal(data)
  Log.Error("战斗数据异常，注意查看打印信息")
end

local function on_chal_ring_tower_list(data)
  local activity = ActivityMgr:get_challenge_ring_act()
  if activity then
    activity:sync_best_conf_tower_list(data)
  end
end

local function on_best_chal_ring_tower_data(data)
  local activity = ActivityMgr:get_challenge_ring_act()
  if activity then
    activity:sync_best_conf_tower_data(data)
  end
end

local function on_get_cr_random_card(data)
  ChallengeRingMgr:on_get_cr_random_card(data)
end

local function on_get_chal_ring_cards_data(data)
  ChallengeRingMgr:on_get_chal_ring_cards_data(data)
end

local function on_update_cr_card_state(data)
  ChallengeRingMgr:on_update_cr_card_state(data)
end

local function on_update_chal_ring_emblem(data)
  ChallengeRingMgr:on_update_chal_ring_emblem(data)
end

local function on_update_lock_info(data)
  if not TowerMgr then
    return
  end
  local tower = TowerMgr:get_tower()
  if tower then
    tower:on_update_lock_info(data)
  end
end

local function on_get_init_box_info(data)
  InitBoxMgr:on_get_init_box_info(data)
end

local function on_open_floor_preview(data)
  FightBagMgr:on_open_floor_preview(data)
end

local function on_random_ans_update(data)
  FightBagMgr:on_random_ans_update(data)
end

local function on_get_netdisk_data(data)
  BattleSettingMgr:on_get_netdisk_data(data)
  GuideMgr:on_get_netdisk_data(data)
end

local function on_battle_buff_list(data)
  FightBagMgr:on_battle_buff_list(data)
end

local function on_battle_buff_info(data)
  FightBagMgr:on_battle_buff_info(data)
end

local function on_dummy_proc(data)
end

local function on_buddy_teach_list(data)
  local activity = ActivityMgr:get_skill_teach_act()
  if activity then
    activity:on_buddy_teach_list(data)
  end
end

local function on_buddy_teach_data(data)
  local activity = ActivityMgr:get_skill_teach_act()
  if activity then
    activity:on_buddy_teach_data(data)
  end
end

local function on_online_battle_list(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_online_battle_list(data)
  end
end

local function on_roominfo(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_roominfo(data)
  end
end

local function on_change_room(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_change_room(data)
  end
end

local function on_player_roomadd(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_player_roomadd(data)
  end
end

local function on_player_roomdel(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_player_roomdel(data)
  end
end

local function on_invite_message(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_invite_message(data)
  end
end

local function on_enterwar_room(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_enterwar_room(data)
  end
end

local function on_match_exit(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_match_exit(data)
  end
end

local function on_room_changebuddy(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_room_changebuddy(data)
  end
end

local function on_system_leaveroom(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_system_leaveroom(data)
  end
end

local function on_kickout_capatin_countdown(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_kickout_capatin_countdown(data)
  end
end

local function on_room_change_capatin(data)
  local activity = ActivityMgr:get_online_battle_act()
  if activity then
    activity:on_room_change_capatin(data)
  end
end

local function on_arch_open_list(data)
  ArchiveMgr:on_arch_open_list(data)
end

local function on_update_arch_open(data)
  ArchiveMgr:on_update_arch_open(data)
end

local function on_concern_net_list(data)
  ArchiveMgr:on_concern_net_list(data)
end

local function on_concern_net_data(data)
  ArchiveMgr:on_concern_net_data(data)
end

local function on_world_dictionary_list(data)
  ArchiveMgr:on_world_dictionary_list(data)
end

local function on_world_dictionary_data(data)
  ArchiveMgr:on_world_dictionary_data(data)
end

local function on_enemy_information_list(data)
  ArchiveMgr:on_enemy_information_list(data)
end

local function on_enemy_information_data(data)
  ArchiveMgr:on_enemy_information_data(data)
end

local function on_enemy_information_server_data(data)
  ArchiveMgr:on_enemy_information_server_data(data)
end

local function on_move_video_list(data)
  ArchiveMgr:on_move_video_list(data)
end

local function on_move_video_data(data)
  ArchiveMgr:on_move_video_data(data)
end

local function on_album_list(data)
  ArchiveMgr:on_album_list(data)
end

local function on_album_data(data)
  ArchiveMgr:on_album_data(data)
end

local function on_ret_tower_story_record(data)
  if TowerMgr then
    TowerMgr:on_ret_tower_story_record(data)
  end
end

local function on_init_buddy_rune_list(data)
  Rune2Mgr:on_init_buddy_rune_list(data)
end

local function on_update_buddy_rune(data)
  Rune2Mgr:on_update_buddy_rune(data)
end

local function update_ornaments_list(data)
  BattleOrnamentMgr:update_ornaments_list(data)
end

local function update_ornaments_pos(data)
  BattleOrnamentMgr:update_ornaments_pos(data)
end

function tb.on_batch_update_ornament_pos_data(data)
  BattleOrnamentMgr:on_batch_update_ornament_pos_data(data)
end

function tb.on_batch_ornaments_restore_pos_data(data)
  BattleOrnamentMgr:on_batch_ornaments_restore_pos_data(data)
end

local function on_gm_add_rune2_drop(data)
  Rune2Mgr:on_gm_add_rune2_drop(data)
end

local function on_replace_team_data(data)
  SceneMgr:replace_team_pos_data(data)
end

local function on_recharge_money_list(data)
  RechargeMgr:on_recharge_money_list(data)
end

local function on_recharge_money_data(data)
  RechargeMgr:on_recharge_money_data(data)
end

local function on_monthly_cards_info(data)
  RechargeMgr:on_monthly_cards_info(data)
end

local function on_gift_shop_list(data)
  RechargeMgr:on_gift_shop_list(data)
end

local function on_gift_shop_data(data)
  RechargeMgr:on_gift_shop_data(data)
end

function tb.on_update_gift_shop_data(data)
end

local function on_monthly_card_info_update(data)
  RechargeMgr:on_monthly_card_info_update(data)
end

local function on_monthly_card_expired(data)
  RechargeMgr:on_monthly_card_expired(data)
end

local function on_offline_recharge_award(data)
  RechargeMgr:on_offline_recharge_award(data)
end

function tb.on_first_recharge_award_data(data)
  RechargeMgr:on_first_recharge_award_data(data)
end

function tb.on_recharge_module_data(data)
  RechargeMgr:on_recharge_module_data(data)
end

function tb.on_activity_level_award(data)
  NoviceMgr:on_activity_level_award(data)
end

function tb.on_activity_gold_equip_info(data)
  NoviceMgr:on_activity_gold_equip_info(data)
end

local function on_tower_mark_statuses(data)
  TowerMgr:on_tower_mark_statuses(data)
end

local function on_tower_history_floor(data)
  TowerMgr:on_tower_history_floor(data)
end

local function on_get_all_buddy_voice_info(data)
  CharacterMgr:on_get_all_buddy_voice_info(data)
end

local function on_unlock_new_buddy_voice(data)
  CharacterMgr:unlock_new_buddy_voice(data)
end

local function on_buddy_show_info(data)
  CharacterMgr:on_buddy_show_info(data)
end

local function on_update_buddy_refine(data)
  CharacterMgr:on_update_buddy_refine(data)
end

function tb.on_buddy_archives_add(data)
  CharacterMgr:on_buddy_archives_add(data)
end

local function on_guild_chat_info(data)
  ChatMgr:sync_union_chat_info(data)
end

local function on_guild_state(data)
  UnionMgr:on_guild_state(data)
end

local function on_guild_memeber_num_change(data)
  UnionMgr:on_guild_memeber_num_change(data)
end

local function on_hero_born_position(data)
  local pos_list = data.pos_list
  local hero = Global.hero
  if hero then
    local collided = SceneMgr:check_wall_collision(hero, pos_list[1], pos_list[3], pos_list[2])
    if not collided then
      hero:set_pos(pos_list[1], pos_list[2], pos_list[3], true)
      if Global.camera then
        Global.camera:set_camera_pos()
      end
    end
  end
end

local function on_curse_ring_data(data)
  ChallengeRingPlusMgr:on_curse_data(data)
end

local function on_curse_update(data)
  ChallengeRingPlusMgr:on_update_curse(data)
end

local function on_curse_remove_current_card(data)
  ChallengeRingPlusMgr:on_remove_current_card(data)
end

local function on_chal_ring_plus_data(data)
  ChallengeRingPlusMgr:on_chal_ring_plus_data(data)
end

local function on_update_chal_ring_plus_point_data(data)
  ChallengeRingPlusMgr:on_update_chal_ring_plus_point_data(data)
end

function tb.on_update_chal_ring_plus_bless_pos_data(data)
  ChallengeRingPlusMgr:on_update_chal_ring_plus_bless_pos_data(data)
end

function tb.on_update_chal_ring_plus_acty_level(data)
  ChallengeRingPlusMgr:on_update_chal_ring_plus_acty_level(data)
end

function tb.on_update_curse_box(data)
  ChallengeRingPlusMgr:on_update_curse_box(data)
end

function tb.on_update_curse_task(data)
  ChallengeRingPlusMgr:on_update_curse_task(data)
end

function tb.on_curse_task_faild(data)
  ChallengeRingPlusMgr:on_curse_task_faild(data)
end

function tb.on_save_notify_card(data)
  ChallengeRingPlusMgr:on_save_notify_card(data)
end

function tb.on_update_curse_door_status(data)
  ChallengeRingPlusMgr:on_update_curse_door_status(data)
end

function tb.on_chapter_collection_list(data)
  ChapterMgr:on_chapter_collection_list(data)
end

function tb.on_chapter_collection_data(data)
  ChapterMgr:on_chapter_collection_data(data)
end

function tb.update_achievement_info(data)
  PlayerMgr:update_achievement_info(data)
end

function tb.update_all_titles(data)
  PlayerMgr:update_all_titles(data)
end

function tb.update_achievement_group_unlock(data)
  PlayerMgr:update_achievement_group_unlock(data)
end

function tb.update_questionnaire_list(data)
  PlayerSundryMgr:on_questionnaire_list(data)
end

function tb.update_questionnaire_data(data)
  PlayerSundryMgr:on_questionnaire_info_update(data)
end

function tb.update_player_var_value(data)
  PlayerSundryMgr:on_player_var_value_update(data)
end

function tb.update_node_list(data)
  ChapterMgr:update_node_list(data)
end

function tb.update_node_state(data)
  ChapterMgr:update_node_state(data)
end

function tb.update_chapter_throw_id_list(data)
  ChapterMgr:update_chapter_throw_id_list(data)
end

function tb.on_chapter_node_save(data)
  TowerMgr:on_chapter_node_save(data)
end

function tb.update_chapter_drop(data)
  FightBagMgr:update_chapter_drop(data)
end

function tb.update_ornament_list(data)
  PlayerMgr:update_ornament_list(data)
end

function tb.update_single_ornament(data)
  PlayerMgr:update_single_ornament(data)
end

function tb.on_ret_weekly_data(data)
  WeeklyMgr:init_hurdle_data(data)
end

function tb.on_refresh_weekly_hurdle_data(data)
  WeeklyMgr:refresh_hurdle_data(data)
end

function tb.on_init_weekly_pvp_data(data)
  WeeklyMgr:on_init_weekly_pvp_data(data)
end

function tb.on_update_week_acty_pvp_data(data)
  WeeklyMgr:on_update_week_acty_pvp_data(data)
end

function tb.on_update_week_pvp_task_data(data)
  WeeklyMgr:on_update_week_pvp_task_data(data)
end

function tb.on_update_passport_data(data)
  PassPortMgr:on_update_passport_data(data)
end

function tb.on_update_passport_exp_lv(data)
  PassPortMgr:on_update_passport_exp_lv(data)
end

function tb.on_update_random_task(data)
  PassPortMgr:on_update_random_task(data)
end

function tb.pop_widget_list(data)
  PopUpWindowMgr:pop_widget_list(data)
end

function tb.pop_widget_update(data)
  PopUpWindowMgr:pop_widget_update(data)
end

function tb.update_visiting_card(data)
  PlayerMgr:update_visiting_card(data)
end

function tb.update_single_visiting_card(data)
  PlayerMgr:update_single_visiting_card(data)
end

function tb.on_refresh_weekly_pvp_data(data)
  WeeklyMgr:on_refresh_weekly_pvp_data(data)
end

function tb.update_maze_data(data)
  TowerMgr:update_maze_data(data)
end

function tb.go_out_role(data)
  SceneMgr:on_go_out_role(data)
end

function tb.on_get_assist_fight_data(data)
  AssistMgr:on_get_assist_fight_data(data)
end

function tb.on_update_push_data(data)
  AssistMgr:on_update_push_data(data)
end

function tb.on_get_buddy_display(data)
  CharacterMgr:set_buddy_new(data)
end

function tb.on_privilege_update(data)
  NewbieTowerMgr:on_privilege_update(data)
end

function tb.on_get_journey_list(data)
  PlayerJourneyMgr:on_get_journey_list(data)
end

function tb.on_get_journey_data(data)
  PlayerJourneyMgr:on_get_journey_data(data)
end

function tb.on_delete_equip_list(data)
  CharacterMgr:on_delete_equip_list(data)
end

function tb.on_daily_reset(data)
  Date.on_daily_reset(data)
end

function tb.update_friendship_data(data)
  FriendMgr:update_friendship_data(data)
end

function tb.on_get_friend_persent(data)
  FriendMgr:on_get_friend_persent(data)
end

function tb.on_get_recommendlist(data)
  FriendMgr:on_get_recommendlist(data)
end

function tb.on_update_card_data(data)
  ChallengeRingPlusMgr:update_card_info(data)
end

function tb.on_update_recuperation_data(data)
  ChallengeRingPlusMgr:on_update_recuperation_data(data)
end

function tb.on_update_ability_data(data)
  GenresMgr:on_update_ability_data(data)
end

function tb.on_update_sect_data(data)
  GenresMgr:on_update_genres_data(data)
end

function tb.on_curse_chapter_update(data)
  FateBookMgr:on_curse_chapter_update(data)
end

function tb.on_curse_chapter_list(data)
  FateBookMgr:on_curse_chapter_list(data)
end

function tb.on_curse_illustrated_list(data)
  FateBookMgr:on_curse_illustrated_list(data)
end

function tb.on_curse_illustrated_update(data)
  FateBookMgr:on_curse_illustrated_update(data)
end

function tb.on_curse_options_data(data)
  FateBookMgr:on_curse_options_data(data)
end

function tb.on_chal_ring_plus_curse_data(data)
  ChallengeRingPlusMgr:on_chal_ring_plus_curse_data(data)
end

function tb.on_update_chain_cenre_event_data(data)
  TaskMgr:on_update_chain_cenre_event_data(data)
end

function tb.on_update_task_event_data(data)
  TaskMgr:on_update_task_event_data(data)
end

function tb.on_update_buddy_event_data(data)
  TaskMgr:on_update_buddy_event_data(data)
end

function tb.on_update_mascot_event_data(data)
  TaskMgr:on_update_mascot_event_data(data)
end

function tb.on_gs2c_relic_list(data)
  RelicMgr:on_gs2c_relic_list(data)
end

function tb.on_gs2c_relic_update(data)
  RelicMgr:on_gs2c_relic_update(data)
end

function tb.on_gs2c_relic_slot_unlock(data)
  RelicMgr:on_gs2c_relic_slot_unlock(data)
end

function tb.on_get_routine_activity(data)
  NoviceMgr:on_get_routine_activity(data)
end

function tb.on_update_routine_activity(data)
  NoviceMgr:on_update_routine_activity(data)
end

function tb.on_get_activity_journey_list(data)
  NoviceMgr:on_get_activity_journey_list(data)
end

function tb.on_update_activity_journey_list(data)
  NoviceMgr:on_update_activity_journey_list(data)
end

function tb.on_update_activity_double_challenge_info(data)
  NoviceMgr:on_update_activity_double_challenge_info(data)
end

function tb.gs2c_linear_list(data)
  LinearMgr:on_linear_list_refresh(data)
end

function tb.gs2c_linear_update(data)
  LinearMgr:on_linear_refresh(data.linear, true)
end

function tb.gs2c_climbing_tower_list(data)
  ClimbingTowerMgr:on_climbing_tower_list_refresh(data)
end

function tb.gs2c_climbing_tower_update(data)
  ClimbingTowerMgr:on_climbing_tower_refresh(data.climbing_tower)
end

function tb.on_chat_status_info(data)
  ChatMgr:on_chat_status_info(data)
end

function tb.on_buff_ability_drop(data)
  GenresMgr:on_buff_ability_drop(data)
end

function tb.on_buff_ornament_drop(data)
  BattleOrnamentMgr:on_buff_ornament_drop(data)
end

function tb.on_gs2c_equip_gemstone_list(data)
  GemStoneMgr:on_gs2c_equip_gemstone_list(data.gemstones)
end

function tb.on_gs2c_equip_gemstone_update(data)
  GemStoneMgr:on_gs2c_equip_gemstone_update(data.gemstones)
end

function tb.on_gs2c_equip_gemstone_delete(data)
  GemStoneMgr:on_gs2c_equip_gemstone_delete(data.uuids)
end

function tb.on_archive_equip_list(data)
  ArchiveMgr:on_archive_equip_list(data)
end

function tb.on_archive_equip_data(data)
  ArchiveMgr:on_archive_equip_data(data)
end

function tb.on_archive_puzzle_list(data)
  ArchiveMgr:on_archive_puzzle_list(data)
end

function tb.on_archive_puzzle_data(data)
  ArchiveMgr:on_archive_puzzle_data(data)
end

function tb.on_plot_preheat_list(data)
  ChapterMgr:on_plot_preheat_list(data)
end

function tb.on_plot_preheat_update(data)
  ChapterMgr:on_plot_preheat_update(data)
end

function tb.on_plot_preheat_group_update(data)
  ChapterMgr:on_plot_preheat_group_update(data)
end

function tb.on_gs2c_puzzle_list(data)
  PuzzleMgr:on_gs2c_puzzle_list(data)
end

function tb.on_gs2c_puzzle_update(data)
  PuzzleMgr:on_gs2c_puzzle_update(data)
end

function tb.on_gs2c_puzzle_delete(data)
  PuzzleMgr:on_gs2c_puzzle_delete(data)
end

function tb.on_gs2c_puzzle_batch_update(data)
  PuzzleMgr:on_gs2c_puzzle_batch_update(data)
end

function tb.on_item_list_delete(data)
  tb.phone_debug_info("gs2c_del_item_uuid_list", data)
  BagMgr:on_item_list_delete(data)
end

function tb.on_auto_use_reclaim_item(data)
  tb.phone_debug_info("gs2c_auto_use_reclaim_item", data)
  BagMgr:on_auto_use_reclaim_item(data)
end

function tb.on_building_list(data)
  BuildingMgr:on_building_list(data)
end

function tb.on_building_update(data)
  BuildingMgr:on_building_update(data)
end

function tb.on_building_condition_finish(data)
  BuildingMgr:on_building_condition_finish(data)
end

function tb.on_building_clue_list(data)
  BuildingMgr:on_building_clue_list(data)
end

function tb.on_building_clue_update(data)
  BuildingMgr:on_building_clue_update(data)
end

function tb.on_building_clue_delete(data)
  BuildingMgr:on_building_clue_delete(data)
end

function tb.on_scene_journey_event_list_init(data)
  JourneyEventMgr:on_scene_journey_event_list_init(data)
end

function tb.on_scene_journey_event_update(data)
  JourneyEventMgr:on_scene_journey_event_update(data)
end

function tb.on_gs2c_chartlet_list(data)
  PhotoMgr:on_gs2c_chartlet_list(data)
end

function tb.on_gs2c_chartlet_frame_update(data)
  PhotoMgr:on_gs2c_chartlet_frame_update(data)
end

function tb.on_gs2c_chartlet_update(data)
  PhotoMgr:on_gs2c_chartlet_update(data)
end

function tb.on_gs2c_update_probation_buddy_data(data)
  Log.Info("probation_buddy_data单个", data)
  BuddyTryoutMgr:on_gs2c_update_probation_buddy_data(data)
end

function tb.on_gs2c_activity_fashion_probation_info(data)
  NoviceMgr:on_gs2c_activity_fashion_probation_info(data)
end

function tb.on_gs2c_probation_buddy_list(data)
  Log.Info("probation_buddy_list列表", data)
  BuddyTryoutMgr:on_gs2c_probation_buddy_list(data)
end

function tb.on_gs2c_close_probation_buddy(data)
  Log.Info("close_probation_buddy过期", data)
  BuddyTryoutMgr:on_gs2c_close_probation_buddy(data)
end

function tb.on_gs2c_episode_box_list(data)
  TreasureChestMgr:on_scene_treasure_chest_init(data)
end

function tb.on_gs2c_episode_box_data(data)
  TreasureChestMgr:on_scene_treasure_chest_refresh(data)
end

function tb.on_curse_equation_list(data)
  FateBookMgr:on_curse_equation_list(data)
end

function tb.on_curse_equation_update(data)
  FateBookMgr:on_curse_equation_update(data)
end

function tb.on_curse_equation_drop_update(data)
  FateBookMgr:on_curse_equation_drop_update(data)
end

function tb.on_activity_curse_save_data(data)
  FateBookMgr:on_activity_curse_save_data(data)
end

function tb.on_activity_curse_save_data_update(data)
  FateBookMgr:on_activity_curse_save_data_update(data)
end

function tb.on_activity_curse_destiny_level(data)
  ChallengeRingPlusMgr:on_activity_curse_destiny_level(data)
end

function tb.on_boss_fight_list(data)
  BossChallengeMgr:on_boss_fight_list(data)
end

function tb.on_boss_fight_update(data)
  BossChallengeMgr:on_boss_fight_update(data)
end

function tb.on_gs2c_kitten_escape_list(data)
  CatchCatMgr:gs2c_kitten_escape_list(data)
end

function tb.on_gs2c_kitten_escape_update(data)
  CatchCatMgr:gs2c_kitten_escape_update(data)
end

function tb.on_gs2c_monkey_typewriter_info(data)
  MonkeyTyperMgr:gs2c_monkey_typewriter_info(data)
end

function tb.on_gs2c_monkey_typewriter_font_count_notice(data)
  MonkeyTyperMgr:gs2c_monkey_typewriter_font_count_notice(data)
end

function tb.on_gs2c_puzzle_game_list(data)
  PuzzleGameMgr:on_gs2c_puzzle_game_list(data)
end

function tb.on_gs2c_puzzle_game_update(data)
  PuzzleGameMgr:on_gs2c_puzzle_game_update(data)
end

function tb.on_gs2c_activity_music_game_info(data)
  MusicGameMgr:on_gs2c_activity_music_game_info(data)
end

function tb.on_gs2c_activity_music_game_update(data)
  MusicGameMgr:on_gs2c_activity_music_game_update(data)
end

function tb.on_gs2c_activity_barbecue_episode_data(data)
  BarbecueGameMgr:on_gs2c_activity_barbecue_episode_data(data)
end

function tb.on_gs2c_activity_update_barbecue_episode_data(data)
  BarbecueGameMgr:on_gs2c_activity_update_barbecue_episode_data(data)
end

function tb.on_gs2c_barbecue_stall_update_sys_data(data)
  BarbecueGameMgr:on_gs2c_barbecue_stall_update_sys_data(data)
end

function tb.on_gs2c_app_show_review(data)
  if SDKManager and SDKManager.show_review then
    LocalStorage:save_int("SDK_SHOW_REVIEW", 1, true)
  end
end

function tb.on_gs2c_update_recommend_player_status(data)
  FriendMgr:on_gs2c_update_recommend_player_status(data)
end

function tb.on_gs2c_activity_flyback_info(data)
  NoviceMgr:on_gs2c_activity_flyback_info(data)
end

function tb.on_gs2c_activity_compensate_info(data)
  CompensateMgr:on_gs2c_activity_compensate_info(data)
end

function tb.on_gs2c_activity_mini_game_info(data)
  TimeLimitedActMgr:on_gs2c_activity_mini_game_info(data)
end

function tb.on_gs2c_activity_mini_game_update(data)
  TimeLimitedActMgr:on_gs2c_activity_mini_game_update(data)
end

function tb.on_gs2c_activity_minesweeper_info(data)
  MineSweeperMgr:on_gs2c_activity_minesweeper_info(data)
end

function tb.on_gs2c_activity_minesweeper_grid_update(data)
  MineSweeperMgr:on_gs2c_activity_minesweeper_grid_update(data)
end

function tb.on_gs2c_brith_day_notice()
  JourneyEventMgr:on_other_journey_event_update(Config.CommonDefine.JOURNEY_EVENT_ID.BIRTHDAY_TIPS, false)
end

function tb.on_gs2c_buddy_spine_info(data)
  PlayerMgr:on_gs2c_buddy_spine_info(data)
end

function tb.on_gs2c_activity_shooting_game_info(data)
  DailyActMgr:on_gs2c_activity_shooting_game_info(data)
end

function tb.on_gs2c_activity_shooting_game_update(data)
  DailyActMgr:on_gs2c_activity_shooting_game_update(data)
end

function tb.on_gs2c_liveness_gift_info(data)
  LivenessGiftMgr:on_gs2c_liveness_gift_info(data)
end

function tb.on_gs2c_version_episode_data(data)
  TimeLimitedActMgr:on_summer_stage_info_init(data)
end

function tb.on_gs2c_update_version_episode_data(data)
  TimeLimitedActMgr:on_summer_stage_info_update(data)
end

function tb.on_gs2c_activity_summer_info(data)
end

function tb.on_gs2c_main_scene_fashion_list(data)
  FashionMgr:on_main_scene_fashion_list_init(data)
end

function tb.update_all_fish_game_data(data)
  NoviceMgr:update_all_fish_game_data(data)
end

function tb.update_single_fish_game_data(data)
  NoviceMgr:update_single_fish_game_data(data)
end

function tb.on_activity_ponder_list(data)
  NoviceMgr:on_activity_ponder_list(data)
end

function tb.on_activity_ponder_update(data)
  NoviceMgr:on_activity_ponder_update(data)
end

function tb.on_activity_ponder_pass_fight_node_update(data)
  NoviceMgr:on_activity_ponder_pass_fight_node_update(data)
end

function network_notify_cb.init()
  Network:register_cb("gs2c_role_base_info", on_get_role_base_info)
  Network:register_cb("gs2c_scene_pos", on_get_scenepos)
  Network:register_cb("gs2c_buddy_list", on_get_buddy_list)
  Network:register_cb("gs2c_buddy_info", on_get_buddy_info)
  Network:register_cb("gs2c_buddy_attribute", on_get_buddy_attribute)
  Network:register_cb("gs2c_buddy_advance", on_get_buddy_advance)
  Network:register_cb("gs2c_buddy_to_advance_item", on_buddy_to_advance_item)
  Network:register_cb("gs2c_all_buddy_voice_info", on_get_all_buddy_voice_info)
  Network:register_cb("gs2c_unlock_new_buddy_voice", on_unlock_new_buddy_voice)
  Network:register_cb("gs2c_buddy_show_info", on_buddy_show_info)
  Network:register_cb("gs2c_update_buddy_refine", on_update_buddy_refine)
  Network:register_cb("gs2c_equip_list", on_get_equip_list)
  Network:register_cb("gs2c_equip_info", on_get_equip)
  Network:register_cb("gs2c_equip_delete", on_delete_equip)
  Network:register_cb("gs2c_equip_delete_list", tb.on_delete_equip_list)
  Network:register_cb("gs2c_bag_items", on_get_bag_items)
  Network:register_cb("gs2c_res_update", on_res_update)
  Network:register_cb("gs2c_res_list", on_res_list)
  Network:register_cb("gs2c_init_exchange_times", on_init_exchange_times)
  Network:register_cb("gs2c_items_update", on_item_update)
  Network:register_cb("gs2c_item_delete", on_item_delete)
  Network:register_cb("gs2c_towerinfo", on_set_tower_info)
  Network:register_cb("gs2c_battle_tower_info", on_set_tower_info)
  Network:register_cb("gs2c_refresh_roominfo", on_refresh_room_info)
  Network:register_cb("gs2c_refresh_roominfo_battle", on_refresh_room_info)
  Network:register_cb("gs2c_npc_shop_data", tb.on_refresh_npc_shop_data)
  Network:register_cb("gs2c_task_list", on_ret_task_list)
  Network:register_cb("gs2c_task_info", on_ret_task)
  Network:register_cb("gs2c_task_group_list", on_task_group_list)
  Network:register_cb("gs2c_task_group_info", on_task_group_info)
  Network:register_cb("gs2c_task_group_award_list", tb.on_task_group_award_list)
  Network:register_cb("gs2c_call_scene", on_scene_call)
  Network:register_cb("gs2c_hero_status_init", on_hero_status_init)
  Network:register_cb("gs2c_fight_end", on_fight_end)
  Network:register_cb("gs2c_fight_time", on_get_fight_time)
  Network:register_cb("gs2c_tp_room", on_tp_room)
  Network:register_cb("gs2c_chapter_list", on_ret_chapter_list)
  Network:register_cb("gs2c_chapter_update", on_chapter_update)
  Network:register_cb("gs2c_episode_update", on_chapter_point_update)
  Network:register_cb("gs2c_cut_grass_epi_list", on_ret_cut_grass_epi_list)
  Network:register_cb("gs2c_cut_grass_epi_data", on_ret_cut_grass_epi_data)
  Network:register_cb("gs2c_create_battle_team", on_create_battle_team)
  Network:register_cb("gs2c_battle_item_delete", on_battle_item_delete)
  Network:register_cb("gs2c_battle_items_update", on_battle_items_update)
  Network:register_cb("gs2c_battle_items", on_battle_items)
  Network:register_cb("gs2c_battle_wearing_status_update", on_wear_info_update)
  Network:register_cb("gs2c_battle_wearing_status", on_wear_info_list)
  Network:register_cb("gs2c_virtual_res_update", on_virtual_res_update)
  Network:register_cb("gs2c_battle_items_init", on_battle_items_init)
  Network:register_cb("gs2c_room_drop_list", on_battle_drop_list)
  Network:register_cb("gs2c_buddy_fashion_list", on_fashion_list_ret)
  Network:register_cb("gs2c_buddy_fashion_info", on_fashion_info_ret)
  Network:register_cb("gs2c_equip_fashion_list", tb.on_equip_fashion_list)
  Network:register_cb("gs2c_equip_fashion_update", tb.on_equip_fashion_update)
  Network:register_cb("g2sc_prefab_team_list", on_prefab_team_list)
  Network:register_cb("g2sc_prefab_team_update", on_prefab_team_update)
  Network:register_cb("g2sc_fight_team_list", on_fight_team_list)
  Network:register_cb("g2sc_fight_team_update", on_fight_team_update)
  Network:register_cb("gs2c_tower_progress", on_tower_progress)
  Network:register_cb("gs2c_scene_skill", on_scene_skill)
  Network:register_cb("gs2c_scene_skill_upgrade", on_scene_skill_upgrade)
  Network:register_cb("gs2c_award_record", on_ret_award_list)
  Network:register_cb("gs2c_award_exchange", tb.on_gs2c_award_exchange)
  Network:register_cb("gs2c_sysopen_list", on_ret_sysopen_list)
  Network:register_cb("gs2c_new_sysopen", on_ret_new_sysopen)
  Network:register_cb("gs2c_send_log", on_recv_server_log)
  Network:register_cb("gs2c_mail_list", on_mail_list)
  Network:register_cb("gs2c_mail_update", on_mail_info_update)
  Network:register_cb("gs2c_mail_delete", on_mail_delete)
  Network:register_cb("gs2c_battle_shop_info", on_battle_shop_item_list)
  Network:register_cb("gs2c_battle_shop_discount", on_refresh_battle_shop_discount)
  Network:register_cb("gs2c_battle_talent_talent_update", on_battle_talent_update)
  Network:register_cb("gs2c_battle_talent_active_talent_ids", on_battle_talent_active_talent_ids)
  Network:register_cb("gs2c_sign_in_history", on_sign_in_history)
  Network:register_cb("gs2c_show_red_point", on_show_read_point)
  Network:register_cb("gs2c_player_info", on_player_info)
  Network:register_cb("gs2c_notice_list", on_notice_list)
  Network:register_cb("gs2c_notice_update", on_update_notice)
  Network:register_cb("gs2c_notice_delete", on_delete_notice)
  Network:register_cb("gs2c_exchange_shop", on_exchange_shop)
  Network:register_cb("gs2c_unlock_exchange_goods", on_unlock_exchange_goods)
  Network:register_cb("gs2c_expire_exchange_goods", on_expire_exchange_goods)
  Network:register_cb("gs2c_expire_exchange_shop", on_expire_exchange_shop)
  Network:register_cb("gs2c_reset_exchange_shop", on_reset_exchange_shop)
  Network:register_cb("gs2c_monitor_item_cnt", on_monitor_item_cnt)
  Network:register_cb("gs2c_exchange_shop_list", on_exchange_shop_list)
  Network:register_cb("gs2c_exchange_goods_mask_new", on_exchange_goods_mask_new)
  Network:register_cb("gs2c_exchange_good_reset", tb.on_exchange_goods_reset)
  Network:register_cb("gs2c_infinite_tower_list", on_ret_inf_chapter_list)
  Network:register_cb("gs2c_infinite_tower_data", on_inf_chapter_update)
  Network:register_cb("gs2c_update_infinite_pass_floor", on_inf_chapter_update_floor)
  Network:register_cb("gs2c_update_addition_award_info", on_update_infinite_award_info)
  Network:register_cb("gs2c_battle_infinite_privilege", on_battle_infinite_privilege)
  Network:register_cb("gs2c_rank_list", tb.on_update_infinite_rank_data)
  Network:register_cb("gs2c_episode_archives_info", on_episode_archives_info)
  Network:register_cb("gs2c_episode_archive_add", on_add_episode_archives_id)
  Network:register_cb("gs2c_episode_archive_delete", on_del_episode_archives_id)
  Network:register_cb("gs2c_infinite_entry_unlock", tb.update_unlock_entry)
  Network:register_cb("gs2c_material_tower_list", on_material_list_update)
  Network:register_cb("gs2c_material_tower_data", on_material_data_update)
  Network:register_cb("gs2c_update_material_pass_floor", on_material_chapter_update_floor)
  Network:register_cb("gs2c_material_tower_expire", on_material_expire)
  Network:register_cb("gs2c_new_material_epi_list", tb.on_material_epi_list_update)
  Network:register_cb("gs2c_new_material_epi_data", tb.on_material_epi_data_update)
  Network:register_cb("gs2c_player_upgrade", on_player_upgrade)
  Network:register_cb("gs2c_battle_treasure_info", on_battle_treasure_info)
  Network:register_cb("gs2c_sysopen_list", on_sys_list_init)
  Network:register_cb("gs2c_new_sysopen", on_sys_open)
  Network:register_cb("gs2c_battle_skill", on_battle_skill)
  Network:register_cb("gs2c_battle_skill_select_list", on_battle_skill_select_list)
  Network:register_cb("gs2c_logout", on_logout)
  Network:register_cb("gs2c_refresh_login_token", on_refresh_login_token)
  Network:register_cb("gs2c_battle_drop_list", on_battle_drop_show_list)
  Network:register_cb("gs2c_word_chat_info", on_word_chat_info)
  Network:register_cb("gs2c_friend_chat_info", on_friend_chat_info)
  Network:register_cb("gs2c_system_notify", on_system_notify)
  Network:register_cb("gs2c_del_revolve", tb.gs2c_del_revolve)
  Network:register_cb("gs2c_battle_room_data", on_battle_room_data)
  Network:register_cb("gs2c_chat_data", tb.on_chat_status_info)
  Network:register_cb("gs2c_draw_group_list", on_draw_group_list)
  Network:register_cb("gs2c_draw_group_update", on_draw_group_update)
  Network:register_cb("gs2c_draw_pool_close", on_draw_pool_close)
  Network:register_cb("gs2c_draw_group_close", on_draw_group_close)
  Network:register_cb("gs2c_draw_pool_update", on_draw_pool_update)
  Network:register_cb("gs2c_draw_pool_info", on_draw_pool_info)
  Network:register_cb("gs2c_free_draw_data", tb.on_free_draw_data_update)
  Network:register_cb("gs2c_newbie_sign_in_history", on_newbie_sign_in_history)
  Network:register_cb("gs2c_activity_seven_sign_in", get_activity_seven_sign_in_data)
  Network:register_cb("gs2c_close_activity", on_close_activity)
  Network:register_cb("gs2c_newbie_info", on_newbie_info)
  Network:register_cb("gs2c_guide", on_guide_update)
  Network:register_cb("gs2c_battle_task_list", on_battle_task_list)
  Network:register_cb("gs2c_battle_task_info", on_battle_task_info)
  Network:register_cb("gs2c_battle_task_failed", on_battle_task_failed)
  Network:register_cb("gs2c_update_mark_task", on_battle_update_mark_task)
  Network:register_cb("gs2c_treasure_box", on_battle_treasure_box_list)
  Network:register_cb("gs2c_best_conf_tower_list", on_best_conf_tower_list)
  Network:register_cb("gs2c_best_conf_tower_data", on_best_conf_tower_data)
  Network:register_cb("gs2c_update_acty_open", on_update_acty_open)
  Network:register_cb("gs2c_acty_open_list", on_acty_open_list)
  Network:register_cb("gs2c_battle_data_abnormal", on_battle_data_abnormal)
  Network:register_cb("gs2c_chal_ring_tower_list", on_chal_ring_tower_list)
  Network:register_cb("gs2c_chal_ring_tower_data", on_best_chal_ring_tower_data)
  Network:register_cb("gs2c_chal_ring_card_update", on_update_cr_card_state)
  Network:register_cb("gs2c_chal_ring_ans_list", on_get_cr_random_card)
  Network:register_cb("gs2c_chal_ring_cards_data", on_get_chal_ring_cards_data)
  Network:register_cb("gs2c_chal_ring_emblem_update", on_update_chal_ring_emblem)
  Network:register_cb("gs2c_update_lock_info", on_update_lock_info)
  Network:register_cb("gs2c_init_box_info", on_get_init_box_info)
  Network:register_cb("gs2c_open_floor_preview", on_open_floor_preview)
  Network:register_cb("gs2c_restore_reliable_proto", on_dummy_proc)
  Network:register_cb("gs2c_recover_done", on_dummy_proc)
  Network:register_cb("gs2c_recover_fs_done", on_dummy_proc)
  Network:register_cb("gs2c_random_ans_update", on_random_ans_update)
  Network:register_cb("gs2c_netdisk_data", on_get_netdisk_data)
  Network:register_cb("gs2c_battle_buff_list", on_battle_buff_list)
  Network:register_cb("gs2c_battle_buff_info", on_battle_buff_info)
  Network:register_cb("gs2c_buff_ability_drop", tb.on_buff_ability_drop)
  Network:register_cb("gs2c_buff_ornament_drop", tb.on_buff_ornament_drop)
  Network:register_cb("gs2c_buddy_teach_list", on_buddy_teach_list)
  Network:register_cb("gs2c_buddy_teach_data", on_buddy_teach_data)
  Network:register_cb("gs2c_online_battle_list", on_online_battle_list)
  Network:register_cb("gs2c_roominfo", on_roominfo)
  Network:register_cb("gs2c_change_room", on_change_room)
  Network:register_cb("gs2c_player_roomadd", on_player_roomadd)
  Network:register_cb("gs2c_player_roomdel", on_player_roomdel)
  Network:register_cb("gs2c_invite_message", on_invite_message)
  Network:register_cb("gs2c_enterwar_room", on_enterwar_room)
  Network:register_cb("gs2c_match_exit", on_match_exit)
  Network:register_cb("gs2c_room_changebuddy", on_room_changebuddy)
  Network:register_cb("gs2c_system_leaveroom", on_system_leaveroom)
  Network:register_cb("gs2c_kickout_capatin_countdown", on_kickout_capatin_countdown)
  Network:register_cb("gs2c_room_change_capatin", on_room_change_capatin)
  Network:register_cb("gs2c_arch_open_list", on_arch_open_list)
  Network:register_cb("gs2c_update_arch_open", on_update_arch_open)
  Network:register_cb("gs2c_concern_net_list", on_concern_net_list)
  Network:register_cb("gs2c_concern_net_data", on_concern_net_data)
  Network:register_cb("gs2c_world_dictionary_list", on_world_dictionary_list)
  Network:register_cb("gs2c_world_dictionary_data", on_world_dictionary_data)
  Network:register_cb("gs2c_enemy_information_list", on_enemy_information_list)
  Network:register_cb("gs2c_enemy_information_data", on_enemy_information_data)
  Network:register_cb("gs2c_enemy_information_server_data", on_enemy_information_server_data)
  Network:register_cb("gs2c_move_video_list", on_move_video_list)
  Network:register_cb("gs2c_move_video_data", on_move_video_data)
  Network:register_cb("gs2c_album_list", on_album_list)
  Network:register_cb("gs2c_album_data", on_album_data)
  Network:register_cb("gs2c_story_record", on_ret_tower_story_record)
  Network:register_cb("gs2c_buddy_archives_add", tb.on_buddy_archives_add)
  Network:register_cb("gs2c_battle_ornaments_pos_list", update_ornaments_list)
  Network:register_cb("gs2c_update_ornaments_pos_data", update_ornaments_pos)
  Network:register_cb("gs2c_batch_update_ornaments_pos_data", tb.on_batch_update_ornament_pos_data)
  Network:register_cb("gs2c_batch_ornaments_restore_pos_data", tb.on_batch_ornaments_restore_pos_data)
  Network:register_cb("gs2c_buddy_rune_list", on_init_buddy_rune_list)
  Network:register_cb("gs2c_buddy_rune_data", on_update_buddy_rune)
  Network:register_cb("gs2c_gm_add_rune2_drop", on_gm_add_rune2_drop)
  Network:register_cb("gs2c_replace_battle_team", on_replace_team_data)
  Network:register_cb("gs2c_recharge_money_list", on_recharge_money_list)
  Network:register_cb("gs2c_recharge_money_data", on_recharge_money_data)
  Network:register_cb("gs2c_gift_shop_list", on_gift_shop_list)
  Network:register_cb("gs2c_gift_shop_data", on_gift_shop_data)
  Network:register_cb("gs2c_update_gift_shop_data", tb.on_update_gift_shop_data)
  Network:register_cb("gs2c_monthly_cards_info", on_monthly_cards_info)
  Network:register_cb("gs2c_monthly_card_info_update", on_monthly_card_info_update)
  Network:register_cb("gs2c_monthly_card_expired", on_monthly_card_expired)
  Network:register_cb("gs2c_offline_recharge_award", on_offline_recharge_award)
  Network:register_cb("gs2c_first_recharge_award_data", tb.on_first_recharge_award_data)
  Network:register_cb("gs2c_recharge_module_data", tb.on_recharge_module_data)
  Network:register_cb("gs2c_activity_level_award", tb.on_activity_level_award)
  Network:register_cb("gs2c_activity_gold_equip_info", tb.on_activity_gold_equip_info)
  Network:register_cb("gs2c_tower_mark_statuses", on_tower_mark_statuses)
  Network:register_cb("gs2c_tower_history_floor", on_tower_history_floor)
  Network:register_cb("gs2c_guild_chat_info", on_guild_chat_info)
  Network:register_cb("gs2c_guild_state", on_guild_state)
  Network:register_cb("gs2c_born_position", on_hero_born_position)
  Network:register_cb("gs2c_guild_memeber_num_change", on_guild_memeber_num_change)
  Network:register_cb("gs2c_curse_data", on_curse_ring_data)
  Network:register_cb("gs2c_curse_update_value_and_debuff", on_curse_update)
  Network:register_cb("gs2c_curse_remove_card", on_curse_remove_current_card)
  Network:register_cb("gs2c_activity_curse_list", on_chal_ring_plus_data)
  Network:register_cb("gs2c_curse_ring_update_point_data", on_update_chal_ring_plus_point_data)
  Network:register_cb("gs2c_curse_ring_update_bless_pos", tb.on_update_chal_ring_plus_bless_pos_data)
  Network:register_cb("gs2c_curse_ring_update_level", tb.on_update_chal_ring_plus_acty_level)
  Network:register_cb("gs2c_curse_update_box_data", tb.on_update_curse_box)
  Network:register_cb("gs2c_curse_update_task", tb.on_update_curse_task)
  Network:register_cb("gs2c_curse_task_faild", tb.on_curse_task_faild)
  Network:register_cb("gs2c_curse_fight_save_notify_card", tb.on_save_notify_card)
  Network:register_cb("gs2c_update_curse_door_status", tb.on_update_curse_door_status)
  Network:register_cb("gs2c_update_card_data", tb.on_update_card_data)
  Network:register_cb("gs2c_update_sect_data", tb.on_update_sect_data)
  Network:register_cb("gs2c_update_recuperation_data", tb.on_update_recuperation_data)
  Network:register_cb("gs2c_update_ability_data", tb.on_update_ability_data)
  Network:register_cb("gs2c_activity_curse_chapter_list", tb.on_curse_chapter_list)
  Network:register_cb("gs2c_activity_curse_chapter_update", tb.on_curse_chapter_update)
  Network:register_cb("gs2c_activity_curse_illustrated_list", tb.on_curse_illustrated_list)
  Network:register_cb("gs2c_activity_curse_illustrated_update", tb.on_curse_illustrated_update)
  Network:register_cb("gs2c_activity_curse_update", tb.on_chal_ring_plus_curse_data)
  Network:register_cb("gs2c_curse_options_data", tb.on_curse_options_data)
  Network:register_cb("gs2c_activity_curse_destiny_level", tb.on_activity_curse_destiny_level)
  Network:register_cb("gs2c_chapter_collection_list", tb.on_chapter_collection_list)
  Network:register_cb("gs2c_chapter_collection_data", tb.on_chapter_collection_data)
  Network:register_cb("gs2c_achievement_info", tb.update_achievement_info)
  Network:register_cb("gs2c_achievement_group_unlock", tb.update_achievement_group_unlock)
  Network:register_cb("gs2c_title_info", tb.update_all_titles)
  Network:register_cb("gs2c_questionnaire_list", tb.update_questionnaire_list)
  Network:register_cb("gs2c_questionnaire_data", tb.update_questionnaire_data)
  Network:register_cb("gs2c_player_var_value", tb.update_player_var_value)
  Network:register_cb("gs2c_chapter_node_save", tb.on_chapter_node_save)
  Network:register_cb("gs2c_chapter_node_list", tb.update_node_list)
  Network:register_cb("gs2c_chapter_node_unlock", tb.update_node_state)
  Network:register_cb("gs2c_chapter_drop_item", tb.update_chapter_throw_id_list)
  Network:register_cb("gs2c_chapter_drop_update", tb.update_chapter_throw_id_list)
  Network:register_cb("gs2c_battle_chapter_drop", tb.update_chapter_drop)
  Network:register_cb("gs2c_ornament_list", tb.update_ornament_list)
  Network:register_cb("gs2c_ornament_update", tb.update_single_ornament)
  Network:register_cb("gs2c_week_acty_prepare_war_epi_list", tb.on_ret_weekly_data)
  Network:register_cb("gs2c_update_week_acty_prepare_war_epi", tb.on_refresh_weekly_hurdle_data)
  Network:register_cb("gs2c_week_acty_pvp_data", tb.on_init_weekly_pvp_data)
  Network:register_cb("gs2c_update_week_acty_pvp_data", tb.on_update_week_acty_pvp_data)
  Network:register_cb("gs2c_update_week_acty_task", tb.on_update_week_pvp_task_data)
  Network:register_cb("gs2c_battle_passport_data", tb.on_update_passport_data)
  Network:register_cb("gs2c_update_battle_passport_exp_lv", tb.on_update_passport_exp_lv)
  Network:register_cb("gs2c_daily_random_task", tb.on_update_random_task)
  Network:register_cb("gs2c_pop_widget_list", tb.pop_widget_list)
  Network:register_cb("gs2c_pop_widget_update", tb.pop_widget_update)
  Network:register_cb("gs2c_business_cards", tb.update_visiting_card)
  Network:register_cb("gs2c_business_card_update", tb.update_single_visiting_card)
  Network:register_cb("gs2c_update_maze_data", tb.update_maze_data)
  Network:register_cb("gs2c_go_out_role", tb.go_out_role)
  Network:register_cb("gs2c_buddy_display", tb.on_get_buddy_display)
  Network:register_cb("gs2c_new_bie_privilege_update", tb.on_privilege_update)
  Network:register_cb("gs2c_journey_list", tb.on_get_journey_list)
  Network:register_cb("gs2c_journey_update", tb.on_get_journey_data)
  Network:register_cb("gs2c_daily_reset", tb.on_daily_reset)
  Network:register_cb("gs2c_assist_fight_data", tb.on_get_assist_fight_data)
  Network:register_cb("gs2c_update_push_data", tb.on_update_push_data)
  Network:register_cb("gs2c_friend_persent_data", tb.update_friendship_data)
  Network:register_cb("gs2c_add_friend_persent", tb.on_get_friend_persent)
  Network:register_cb("gs2c_recommendlist", tb.on_get_recommendlist)
  Network:register_cb("gs2c_chain_cenre_event_data", tb.on_update_chain_cenre_event_data)
  Network:register_cb("gs2c_update_event_data", tb.on_update_task_event_data)
  Network:register_cb("gs2c_update_buddy_event", tb.on_update_buddy_event_data)
  Network:register_cb("gs2c_update_mascot_event", tb.on_update_mascot_event_data)
  Network:register_cb("gs2c_routine_activity_list", tb.on_get_routine_activity)
  Network:register_cb("gs2c_routine_activity_update", tb.on_update_routine_activity)
  Network:register_cb("gs2c_activity_journey_list", tb.on_get_activity_journey_list)
  Network:register_cb("gs2c_activity_journey_update", tb.on_update_activity_journey_list)
  Network:register_cb("gs2c_activity_double_challenge_info", tb.on_update_activity_double_challenge_info)
  Network:register_cb("gs2c_relic_list", tb.on_gs2c_relic_list)
  Network:register_cb("gs2c_relic_update", tb.on_gs2c_relic_update)
  Network:register_cb("gs2c_relic_slot_unlock", tb.on_gs2c_relic_slot_unlock)
  Network:register_cb("gs2c_linear_list", tb.gs2c_linear_list)
  Network:register_cb("gs2c_linear_update", tb.gs2c_linear_update)
  Network:register_cb("gs2c_climbing_tower_list", tb.gs2c_climbing_tower_list)
  Network:register_cb("gs2c_climbing_tower_update", tb.gs2c_climbing_tower_update)
  Network:register_cb("gs2c_equip_gemstone_list", tb.on_gs2c_equip_gemstone_list)
  Network:register_cb("gs2c_equip_gemstone_update", tb.on_gs2c_equip_gemstone_update)
  Network:register_cb("gs2c_equip_gemstone_delete", tb.on_gs2c_equip_gemstone_delete)
  Network:register_cb("gs2c_equip_arch_update", tb.on_archive_equip_data)
  Network:register_cb("gs2c_equip_arch_list", tb.on_archive_equip_list)
  Network:register_cb("gs2c_puzzle_arch_update", tb.on_archive_puzzle_data)
  Network:register_cb("gs2c_puzzle_arch_list", tb.on_archive_puzzle_list)
  Network:register_cb("gs2c_plot_preheat_list", tb.on_plot_preheat_list)
  Network:register_cb("gs2c_plot_preheat_update", tb.on_plot_preheat_update)
  Network:register_cb("gs2c_plot_preheat_group_update", tb.on_plot_preheat_group_update)
  Network:register_cb("gs2c_puzzle_list", tb.on_gs2c_puzzle_list)
  Network:register_cb("gs2c_puzzle_update", tb.on_gs2c_puzzle_update)
  Network:register_cb("gs2c_puzzle_delete", tb.on_gs2c_puzzle_delete)
  Network:register_cb("gs2c_puzzle_batch_update", tb.on_gs2c_puzzle_batch_update)
  Network:register_cb("gs2c_del_item_uuid_list", tb.on_item_list_delete)
  Network:register_cb("gs2c_auto_use_reclaim_item", tb.on_auto_use_reclaim_item)
  Network:register_cb("gs2c_building_list", tb.on_building_list)
  Network:register_cb("gs2c_building_update", tb.on_building_update)
  Network:register_cb("gs2c_building_condition_finish", tb.on_building_condition_finish)
  Network:register_cb("gs2c_building_clue_list", tb.on_building_clue_list)
  Network:register_cb("gs2c_building_clue_update", tb.on_building_clue_update)
  Network:register_cb("gs2c_building_clue_delete", tb.on_building_clue_delete)
  Network:register_cb("gs2c_scene_journey_event_list", tb.on_scene_journey_event_list_init)
  Network:register_cb("gs2c_scene_journey_event_update", tb.on_scene_journey_event_update)
  Network:register_cb("gs2c_chartlet_list", tb.on_gs2c_chartlet_list)
  Network:register_cb("gs2c_chartlet_frame_update", tb.on_gs2c_chartlet_frame_update)
  Network:register_cb("gs2c_chartlet_update", tb.on_gs2c_chartlet_update)
  Network:register_cb("gs2c_probation_buddy_list", tb.on_gs2c_probation_buddy_list)
  Network:register_cb("gs2c_close_probation_buddy", tb.on_gs2c_close_probation_buddy)
  Network:register_cb("gs2c_update_probation_buddy_data", tb.on_gs2c_update_probation_buddy_data)
  Network:register_cb("gs2c_activity_fashion_probation_info", tb.on_gs2c_activity_fashion_probation_info)
  Network:register_cb("gs2c_episode_box_list", tb.on_gs2c_episode_box_list)
  Network:register_cb("gs2c_episode_box_data", tb.on_gs2c_episode_box_data)
  Network:register_cb("gs2c_curse_equation_list", tb.on_curse_equation_list)
  Network:register_cb("gs2c_curse_equation_update", tb.on_curse_equation_update)
  Network:register_cb("gs2c_curse_equation_drop_update", tb.on_curse_equation_drop_update)
  Network:register_cb("gs2c_activity_curse_save_data", tb.on_activity_curse_save_data)
  Network:register_cb("gs2c_activity_curse_save_data_update", tb.on_activity_curse_save_data_update)
  Network:register_cb("gs2c_boss_fight_list", tb.on_boss_fight_list)
  Network:register_cb("gs2c_boss_fight_update", tb.on_boss_fight_update)
  Network:register_cb("gs2c_kitten_escape_list", tb.on_gs2c_kitten_escape_list)
  Network:register_cb("gs2c_kitten_escape_update", tb.on_gs2c_kitten_escape_update)
  Network:register_cb("gs2c_monkey_typewriter_info", tb.on_gs2c_monkey_typewriter_info)
  Network:register_cb("gs2c_monkey_typewriter_font_count_notice", tb.on_gs2c_monkey_typewriter_font_count_notice)
  Network:register_cb("gs2c_puzzle_game_list", tb.on_gs2c_puzzle_game_list)
  Network:register_cb("gs2c_puzzle_game_update", tb.on_gs2c_puzzle_game_update)
  Network:register_cb("gs2c_activity_music_game_info", tb.on_gs2c_activity_music_game_info)
  Network:register_cb("gs2c_activity_music_game_update", tb.on_gs2c_activity_music_game_update)
  Network:register_cb("gs2c_activity_barbecue_episode_data", tb.on_gs2c_activity_barbecue_episode_data)
  Network:register_cb("gs2c_activity_update_barbecue_episode_data", tb.on_gs2c_activity_update_barbecue_episode_data)
  Network:register_cb("gs2c_barbecue_stall_update_sys_data", tb.on_gs2c_barbecue_stall_update_sys_data)
  Network:register_cb("gs2c_app_show_review", tb.on_gs2c_app_show_review)
  Network:register_cb("gs2c_activity_compensate_info", tb.on_gs2c_activity_compensate_info)
  Network:register_cb("gs2c_update_recommend_player_status", tb.on_gs2c_update_recommend_player_status)
  Network:register_cb("gs2c_activity_mini_game_info", tb.on_gs2c_activity_mini_game_info)
  Network:register_cb("gs2c_activity_mini_game_update", tb.on_gs2c_activity_mini_game_update)
  Network:register_cb("gs2c_activity_minesweeper_info", tb.on_gs2c_activity_minesweeper_info)
  Network:register_cb("gs2c_activity_minesweeper_grid_update", tb.on_gs2c_activity_minesweeper_grid_update)
  Network:register_cb("gs2c_activity_flyback_info", tb.on_gs2c_activity_flyback_info)
  Network:register_cb("gs2c_brith_day_notice", tb.on_gs2c_brith_day_notice)
  Network:register_cb("gs2c_buddy_spine_info", tb.on_gs2c_buddy_spine_info)
  Network:register_cb("gs2c_activity_shooting_game_info", tb.on_gs2c_activity_shooting_game_info)
  Network:register_cb("gs2c_activity_shooting_game_update", tb.on_gs2c_activity_shooting_game_update)
  Network:register_cb("gs2c_liveness_gift_info", tb.on_gs2c_liveness_gift_info)
  Network:register_cb("gs2c_version_episode_data", tb.on_gs2c_version_episode_data)
  Network:register_cb("gs2c_update_version_episode_data", tb.on_gs2c_update_version_episode_data)
  Network:register_cb("gs2c_activity_summer_info", tb.on_gs2c_activity_summer_info)
  Network:register_cb("gs2c_main_scene_fashion_list", tb.on_gs2c_main_scene_fashion_list)
  Network:register_cb("gs2c_activity_fish_game_data", tb.update_all_fish_game_data)
  Network:register_cb("gs2c_activity_update_fish_game_episode_data", tb.update_single_fish_game_data)
  Network:register_cb("gs2c_activity_ponder_update", tb.on_activity_ponder_update)
  Network:register_cb("gs2c_activity_ponder_list", tb.on_activity_ponder_list)
  Network:register_cb("gs2c_activity_ponder_pass_fight_node_update", tb.on_activity_ponder_pass_fight_node_update)
end

return network_notify_cb
