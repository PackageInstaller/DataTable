local Base = require("gamelogic.base_system")
local Seri = require("seri")
local _tinsert = table.insert
local M = Util.create_child_mt(Base)
local CSCheckUpdate = CS.GameToLua.CheckUpdate
local CSCheckUpdate2 = CS.GameToLua.CheckUpdate2
local Setting_Cfg = require("uimodule.battle_setting.battle_setting_cfg")
local download_type = {
  CheckRes = 1,
  CheckFinish = 2,
  BeginDownload = 3,
  Downloading = 4,
  DownloadPause = 5,
  DownloadFinish = 6,
  DownloadError = 7
}
local currSize, maxSize, progress, speed, checkDownloadParams, downloadingParams, curr_type, check_res_infos

function M:get_check_res_infos()
  return check_res_infos
end

function M:download_other_res(check_finish_cb)
  self:refresh_download_type(download_type.CheckRes)
  checkDownloadParams = nil
  CSCheckUpdate2.OnLeave()
  CSCheckUpdate2.OnEnter(Util.get_patch_uuid(), function(checkParams)
    self:refresh_download_type(download_type.CheckFinish)
    checkDownloadParams = checkParams
    maxSize = checkParams.MaxSize
    local res_infos = checkParams.ChapterResInfos
    check_res_infos = {}
    for i, res_info in pairs(res_infos) do
      local data = {}
      data.chapter_index = res_info.ChapterIndex
      data.need_patch_files = res_info.NeedPatchFiles
      data.max_size = res_info.MaxSize
      table.insert(check_res_infos, data)
    end
    table.sort(check_res_infos, function(a, b)
      return a.chapter_index < b.chapter_index
    end)
    MsgGame:mq_publish2(Const.MSG_ON_OTHER_RES_CHECK_FINISH)
    if check_finish_cb then
      check_finish_cb()
    end
  end, function()
    self:refresh_download_type(download_type.DownloadFinish)
    CSCheckUpdate.AllResDownloadFinish()
    Log.Info("全部下载完毕")
    UIMgr:get_ui("uimessagetip"):ui_show(Util.format_str("全部下载完毕"))
    require("manager.res.runtime_package").reset()
    CSCheckUpdate2.OnLeave()
    MsgGame:mq_publish2(Const.MSG_ON_OTHER_RES_DOWNLOAD_FINISH)
    self:refresh_ui_main_tips()
  end, function(downloadParams)
    downloadingParams = downloadParams
    if downloadParams.MaxSize ~= nil and downloadParams.MaxSize ~= "" then
      self:refresh_download_type(download_type.Downloading)
      progress = downloadParams.Progress
      currSize = downloadParams.CurrSize
      maxSize = downloadParams.MaxSize
      speed = downloadParams.Speed
      local res_infos = downloadParams.ChapterResInfos
      local res_table = {}
      local is_pause = true
      local is_all_finish = true
      for i, res_info in pairs(res_infos) do
        local data = {}
        data.chapter_index = res_info.ChapterIndex
        data.need_patch_files = res_info.NeedPatchFiles
        data.max_size = res_info.MaxSize
        data.curr_size = res_info.CurrSize
        data.progress = res_info.Progress
        data.download_type = res_info.DownloadType
        data.speed = res_info.Speed
        table.insert(res_table, data)
        if 1 == data.download_type then
          is_pause = false
        end
        if 3 ~= data.download_type then
          is_all_finish = false
        end
      end
      if not is_all_finish and is_pause then
        self:refresh_download_type(download_type.DownloadPause)
      end
      table.sort(res_table, function(a, b)
        return a.chapter_index < b.chapter_index
      end)
      local msg = MsgGame:mq_publish2(Const.MSG_ON_OTHER_RES_DOWNLOAD_PROGRESS_REFRESH)
      msg.mm_obj = res_table
      return
    end
    local confirmCb = downloadParams.Confirm
    local cancelCb = downloadParams.Cancel
    local message = downloadParams.Message
    local title = downloadParams.Title
    local confirmTxt = downloadParams.ConfirmText
    local cancelTxt = downloadParams.CancelText
    UIMgr:get_ui("uinotice_tips"):ui_show(confirmCb, cancelCb, message, confirmTxt, cancelTxt, title)
    self:refresh_download_type(download_type.DownloadError)
  end)
end

function M:get_check_params()
  return checkDownloadParams
end

function M:get_download_params()
  return downloadingParams
end

function M:get_curr_size()
  return currSize
end

function M:get_max_size()
  return maxSize
end

function M:get_progress()
  return progress
end

function M:get_speed()
  return speed
end

function M:get_is_downloading()
  return curr_type == download_type.Downloading
end

function M:get_is_need_request_other_download_info()
  return nil == checkDownloadParams
end

function M:refresh_download_type(type)
  if curr_type ~= type then
    curr_type = type
    self:refresh_ui_main_tips()
  end
end

function M:on_begin_download_with_setting(chapter_index)
  if 0 == chapter_index then
    checkDownloadParams.Confirm()
  else
    local need_download_chapter_list = {}
    local is_need_tips = false
    for i, v in pairs(checkDownloadParams.ChapterResInfos) do
      if chapter_index > v.ChapterIndex and 3 ~= v.DownloadType and 1 ~= v.DownloadType and 4 ~= v.DownloadType and v.chapter_index ~= chapter_index then
        need_download_chapter_list[v.ChapterIndex] = 1
        is_need_tips = true
      end
    end
    need_download_chapter_list[chapter_index] = 1
    
    local function cb()
      for i, v in pairs(checkDownloadParams.ChapterResInfos) do
        if 1 == need_download_chapter_list[v.ChapterIndex] then
          v.Confirm()
        end
      end
    end
    
    if is_need_tips then
      local msg = Util.format_str("需要先下载前置章节资源，是否进行下载")
      Util.show_notify_popup_message(function()
        cb()
      end, msg, "提示", "确定", "取消", nil, false)
    else
      cb()
    end
  end
end

function M:on_begin_download(chapter_index)
  if 0 == chapter_index then
    checkDownloadParams.Confirm()
  else
    for i, v in pairs(checkDownloadParams.ChapterResInfos) do
      if v.ChapterIndex == chapter_index then
        v.Confirm()
        break
      end
    end
  end
end

function M:on_pause_download(chapter_index)
  for i, v in pairs(checkDownloadParams.ChapterResInfos) do
    if v.ChapterIndex == chapter_index then
      v.Pause()
      break
    end
  end
end

function M:on_continue_download(chapter_index)
  local need_download_chapter_list = {}
  for i, v in pairs(checkDownloadParams.ChapterResInfos) do
    if chapter_index >= v.ChapterIndex and 2 == v.DownloadType then
      need_download_chapter_list[v.ChapterIndex] = 1
    end
  end
  for i, v in pairs(checkDownloadParams.ChapterResInfos) do
    if 1 == need_download_chapter_list[v.ChapterIndex] then
      v.Continue()
    end
  end
end

function M:check_res_is_integrity()
  local is_res_integrity = CS.GameToLua.CheckUpdate.GetResIntegrity()
  return is_res_integrity
end

function M:is_chapter_res_downloading(chapter_index)
  if not checkDownloadParams then
    return false
  end
  for i, v in pairs(checkDownloadParams.ChapterResInfos) do
    if v.ChapterIndex == chapter_index then
      return 1 == v.DownloadType
    end
  end
  return true
end

function M:is_checked()
  return nil ~= checkDownloadParams
end

function M:check_chapter_other_res(cb)
  if not Game_AssetBundle then
    return
  end
  local is_checked = self:is_checked()
  if is_checked then
    return
  end
  if self:check_res_is_integrity() then
    return
  end
  self:download_other_res(cb)
end

function M:is_can_fight(chapter_index, is_show_tip, use_new_tips)
  if curr_type == download_type.DownloadFinish then
    return true
  end
  if not checkDownloadParams then
    return true
  end
  local is_download_finish = true
  local need_download_size = 0
  local need_download_chapter_list = {}
  for i, v in pairs(checkDownloadParams.ChapterResInfos) do
    if chapter_index >= v.ChapterIndex and 3 ~= v.DownloadType then
      is_download_finish = false
      need_download_size = need_download_size + v.TotalUpdateSize
      need_download_chapter_list[#need_download_chapter_list + 1] = v.ChapterIndex
    end
  end
  if not is_download_finish and is_show_tip then
    local size = string.format("%.2f", need_download_size / 1024 / 1024)
    local msg
    if use_new_tips then
      msg = Util.format_str("当前游戏资源未下载，请下载对应游戏资源后可进入（资源大小：{1}M）", size)
    else
      msg = Util.format_str("当前章节资源未下载，请下载当前及前置章节资源后可进入章节（资源大小：{1}M）", size)
    end
    Util.show_notify_popup_message(function()
      UIMgr:get_ui("battle_setting"):ui_show(Setting_Cfg.PageTag.Download)
      for _, index in ipairs(need_download_chapter_list) do
        DownloadMgr:on_begin_download(index)
      end
    end, msg, "提示", "确定", "取消", nil, false)
  end
  return is_download_finish
end

function M:show_tips(chapter_index, info)
  if 0 == info.DownloadType then
    local msg = "当前章节资源不完整无法体检该关卡，是否下载该章节资源"
    msg = msg .. info.MaxSize
    Util.show_notify_popup_message(function()
      Log.Info("前往下载")
      DownloadMgr:on_begin_download(chapter_index)
    end, msg, "提示", "确定", "取消", nil, false)
  elseif 1 == info.DownloadType then
    local tips = Util.format_str("已下载:{1}/{2}", info.CurrSize, info.MaxSize)
    UIMgr:get_ui("uimessagetip"):ui_show(tips)
  elseif 2 == info.DownloadType then
    local msg = "当前章节资源下载已暂停，是否恢复下载"
    Util.show_notify_popup_message(function()
      DownloadMgr:on_continue_download(chapter_index)
    end, msg, "提示", "确定", "取消", nil, false)
  end
end

function M:refresh_ui_main_tips()
  local ui_main = UIMgr:try_get_visible_ui("uimain")
  if not ui_main then
    return
  end
  local visible = false
  local tips = ""
  if DownloadMgr:check_res_is_integrity() then
    visible = false
  elseif curr_type == download_type.Downloading then
    visible = true
    tips = "下载中..."
  elseif curr_type == download_type.DownloadPause then
    visible = true
    tips = "暂停中"
  end
  ui_main:refresh_res_download(visible, tips)
end

return M
