local helper = {}
helper.DEFAULT = 1
helper.ExitToDelete = 2
helper.DeleteType = {
  [1] = helper.DEFAULT,
  [2] = helper.ExitToDelete
}
helper.ex_shop_cfg = ShareRes.create("shop.exchange_shop")
helper.ex_goods_cfg = ShareRes.create("shop.exchange_goods")
helper.item_cfg = ShareRes.create("item.item")

function helper.get_card_destory_type()
  local cfg = ChallengeRingPlusMgr:get_cur_card_cfg_info()
  local type = cfg.Type
  local type_cfg = ShareRes.get_curse_ring_card_type_cfg(type)
  return helper.DeleteType[type_cfg.RemoveType] == helper.DEFAULT
end

function helper.get_card_type()
  local cfg = ChallengeRingPlusMgr:get_cur_card_cfg_info()
  local type = cfg.Type
  return type
end

function helper.confirm_quit_ui(parent_ui, tips_str)
  if helper.get_card_destory_type() then
    if parent_ui then
      parent_ui:ui_hide()
    end
    return
  end
  local type = helper.get_card_type()
  if ChallengeRingPlusMgr:is_notify_card(type) then
    local function cb()
      if parent_ui then
        parent_ui:ui_hide()
      end
    end
    
    ChallengeRingPlusMgr:req_remove_card(cb)
    return
  end
  local tip = Util.format_str(tips_str or "是否退出，不可返回")
  
  local function sure_cb()
    local function cb()
      if parent_ui then
        parent_ui:ui_hide()
      end
    end
    
    ChallengeRingPlusMgr:req_remove_card(cb)
  end
  
  UIMgr:get_ui("uinotice_tips"):ui_show(sure_cb, nil, tip, Util.format_str("确定"), Util.format_str("取消"), nil, nil, nil, nil, nil, true)
end

return helper
