local Const = require("const")
local Base = require("gamemode.base")
local PathDefine = require("utils.path_define")
local Json = require("utils.json")
local UnityWebRequest = UnityEngine.Networking.UnityWebRequest
local RETRY_TIME = 3
local URL_TIME_OUT = 10
local UnityLoad = UnityEngine.Resources.Load
local MD5_KEY = "update_version_md5_key"
local RES_URL = "http://fxcdn.mingzhougame.com/%s"
local VERSION_URL = {
  [1] = RES_URL,
  [2] = RES_URL,
  [3] = RES_URL
}
local PATCH_RES_URL = {
  [1] = RES_URL,
  [2] = RES_URL,
  [3] = RES_URL
}
local REAPIR_STATE = {
  NONE = 0,
  CHECK = 1,
  CHECK_END = 2,
  REPAIRING = 3,
  REPAIR_END = 4
}
local M = setmetatable({}, Base)
M.__index = M

local function get_platform_dir()
  local dir
  if GAME_RELEASE then
    if UNITY_ANDROID then
      dir = "/release/Android/"
    elseif UNITY_IOS then
      dir = "/release/iOS/"
    else
      dir = "/release/Win/"
    end
  elseif UNITY_ANDROID then
    dir = "/Android/"
  elseif UNITY_IOS then
    dir = "/iOS/"
  else
    dir = "/Win/"
  end
  return string.format("%s%s", Uuid, dir)
end

local function get_version_url(name, url)
  local dir = get_platform_dir()
  local random = string.format("?p=%s", os.time())
  url = string.format(url, dir .. name) .. random
  return url
end

local function do_request_version(path, timeout)
  local request
  local success = false
  for i = 1, #VERSION_URL do
    local version_url = VERSION_URL[i]
    local version_address = get_version_url(path, version_url)
    for j = 1, RETRY_TIME do
      request = UnityWebRequest.Get(version_address)
      request.timeout = timeout or 0
      coroutine.yield(request:SendWebRequest())
      if Util.is_net_work_error(request) then
        if i >= #VERSION_URL and j >= RETRY_TIME then
          return request, false
        end
      else
        success = true
        break
      end
    end
    if success then
      break
    end
  end
  return request, success
end

local function get_patch_url(self, filepath, md5, url)
  local dir = get_platform_dir() .. "assetbundles/"
  local res = self.v_remote_relative_dir .. dir .. string.format("%s.%s", filepath, md5)
  return CSHelper.EscapeUriString(string.format(url, res))
end

local MEGABYTE = 1048576

local function format_size(size)
  if size < MEGABYTE then
    return string.format("%.2fK", size / 1024)
  else
    return string.format("%.2fM", size / MEGABYTE)
  end
end

function M:on_start()
  self.v_local_version_tbl = nil
  self.v_remote_relative_dir = nil
  self.v_remote_version_tbl = nil
  self.v_repair_content_size = 0
  self.v_update_content_size = 0
  self.v_repair_state = REAPIR_STATE.NONE
  self.v_callback = nil
  self.v_repair_game_tip = nil
  self:update_tip("是否检查文件", 0, self.v_repair_state)
end

function M:update_tip(tip, content_size)
  self.v_repair_game_tip = UIMgr:try_get_visible_ui("repair_game_tip")
  if not self.v_repair_game_tip then
    self.v_repair_game_tip = UIMgr:get_ui("repair_game_tip")
  end
  self.v_repair_game_tip:ui_show()
  self.v_repair_game_tip:update_content(tip, content_size, self.v_repair_state, self.v_callback)
end

function M:refresh_check_progress(curr_count, total_count)
  self.v_repair_game_tip:refresh_check_progress(curr_count, total_count)
end

function M:_read_remote_version_tbl()
  local remote_version_md5 = CSHelper.ReadFileText(PathDefine.remote_version_md5)
  if remote_version_md5 then
    remote_version_md5 = Json.decode(remote_version_md5)
  else
    remote_version_md5 = {}
  end
  return remote_version_md5
end

function M:check_update()
  self.v_repair_state = REAPIR_STATE.CHECK
  self:update_tip("检查资源中")
  Coroutine.start(function()
    local md5_tbl
    local request, success = do_request_version(PathDefine.update_version_md5, 0)
    if not success then
      self.v_repair_state = REAPIR_STATE.REPAIR_END
      self:update_tip("暂无文件修正")
      return
    end
    local bytes = request.downloadHandler.data
    local text = CSHelper.DecompressText(bytes)
    md5_tbl = Json.decode(text)
    self.v_remote_relative_dir = md5_tbl.relativeDir or ""
    self.v_remote_md5_tbl = md5_tbl
    self:get_local_version_info()
    local need_download_list = {}
    local clear_local_list = {}
    local is_pathch = false
    if md5_tbl.Versions then
      local total_count = 0
      for i, v in pairs(md5_tbl.Versions) do
        total_count = total_count + 1
      end
      local check_count = 0
      local one_frame_check_count = 12
      local curr_frame_check_count = 0
      for version_key, version in pairs(md5_tbl.Versions) do
        local local_version = self.v_local_version_tbl.Versions[version_key]
        local bundle_version = self.v_bundle_version_tbl.Versions[version_key]
        local remote_md5 = version.Md5
        local is_repair = false
        if version.Language == Global.curr_text_language or version.Language == Global.default_language then
          if local_version then
            if local_version.Md5 ~= remote_md5 then
              if not bundle_version or bundle_version.Md5 ~= remote_md5 then
                is_repair = true
              else
                clear_local_list[version_key] = true
              end
            else
              local local_file_md5 = self:get_local_file_md5(version_key)
              if not local_file_md5 or local_file_md5 ~= remote_md5 then
                is_repair = true
              end
            end
          elseif not bundle_version then
            is_repair = true
          elseif bundle_version.Md5 ~= remote_md5 then
            is_repair = true
          end
        end
        if is_repair then
          is_pathch = true
          need_download_list[version_key] = remote_md5
          self.v_repair_content_size = self.v_repair_content_size + version.Size
        end
        curr_frame_check_count = curr_frame_check_count + 1
        if one_frame_check_count <= curr_frame_check_count then
          coroutine.yield(UnityEngine.WaitForSeconds(0.001))
          curr_frame_check_count = 0
        end
        check_count = check_count + 1
        self:refresh_check_progress(check_count, total_count)
      end
      self:clear_local_version_info(md5_tbl, clear_local_list)
    end
    if not is_pathch or self.v_repair_content_size <= 0 then
      self.v_repair_state = REAPIR_STATE.REPAIR_END
      self:update_tip("暂无文件修正")
      return
    end
    
    local function callback()
      self.v_need_download_patch = need_download_list
      self:_check_download_patch()
    end
    
    self.v_callback = callback
    local size = format_size(self.v_repair_content_size)
    self.v_repair_state = REAPIR_STATE.CHECK_END
    self:update_tip("本次修正需要{1}", size)
    self.v_repair_game_tip:refresh_btn_state()
  end)
end

function M:get_local_file_md5(filepath)
  local update_path = PathDefine.update_dir .. filepath
  if CSHelper.IsFileExist(update_path) then
    local md5 = MD5Helper.ComputeFileHash(update_path)
    return md5
  end
end

function M:clear_local_version_info(md5_tbl, clear_local_list)
  for filepath, version in pairs(self.v_local_version_tbl.Versions) do
    if not md5_tbl.Versions[filepath] or clear_local_list[filepath] then
      self.v_local_version_tbl.Versions[filepath] = nil
      local update_path = PathDefine.update_dir .. filepath
      CSHelper.RemoveFile(update_path)
      self:_save_json_file()
    end
  end
end

function M:get_local_version_info()
  if CSHelper.IsFileExist(PathDefine.local_version_file) then
    local local_version_tbl = CSHelper.ReadFileText(PathDefine.local_version_file)
    if local_version_tbl then
      self.v_local_version_tbl = Json.decode(local_version_tbl)
    else
      self.v_local_version_tbl = {}
    end
  else
    self.v_local_version_tbl = {}
  end
  if not self.v_local_version_tbl.Versions then
    self.v_local_version_tbl.Versions = {}
  end
  local bundle_version_tbl = UnityLoad(PathDefine.bundle_version_file, typeof(UnityEngine.TextAsset))
  if bundle_version_tbl and bundle_version_tbl.text then
    local decrypt_bytes = CS.Game.CryptoHelper.DESDecrypt(bundle_version_tbl.text)
    self.v_bundle_version_tbl = Json.decode(decrypt_bytes)
  else
    self.v_bundle_version_tbl = {}
  end
  if not self.v_bundle_version_tbl.Versions then
    self.v_bundle_version_tbl.Versions = {}
  end
end

function M:_check_download_patch()
  local filepath, md5 = next(self.v_need_download_patch)
  if not filepath then
    self.v_repair_state = REAPIR_STATE.REPAIR_END
    self:update_tip("资源修正完成")
    return
  end
  self.v_repair_state = REAPIR_STATE.REPAIRING
  self:update_tip("资源修复中")
  local update_path = PathDefine.update_dir .. filepath
  local download_path = PathDefine.download_dir .. filepath
  Coroutine.start(function()
    self.dummy_cnt = 1
    local download_success = false
    local err_msg = ""
    local remote_path
    for i = 1, #PATCH_RES_URL do
      remote_path = get_patch_url(self, filepath, md5, PATCH_RES_URL[i])
      self.v_download_request = UnityWebRequest.Get(remote_path)
      coroutine.yield(self.v_download_request:SendWebRequest())
      local continue = false
      if Util.is_net_work_error(self.v_download_request) then
        err_msg = self.v_download_request.error
        continue = true
      end
      if not continue then
        local bytes = self.v_download_request.downloadHandler.data
        if nil == bytes then
          err_msg = "empty bytes"
          continue = true
        end
      end
      if not continue then
        local download_md5 = CSHelper.WriteWebRequestAndComputeMd5(download_path, self.v_download_request)
        if md5 == download_md5 then
          CSHelper.MoveFile(download_path, update_path)
          download_success = true
          self.v_download_request = nil
          break
        else
          err_msg = [[
diff md5: 
 ]] .. md5 .. "\n" .. download_md5
        end
      end
      self.v_download_request = nil
    end
    if not download_success then
      local msg = "文件下载失败"
      if GAME_DEBUG then
        msg = msg .. ": " .. err_msg
      end
      print("download fail:", remote_path, update_path, download_path)
      print(msg)
      self.v_repair_state = REAPIR_STATE.REPAIR_END
      self:update_tip("文件下载失败")
      return
    end
    local remote_res_size = self.v_remote_md5_tbl.Versions[filepath].Size
    if CSHelper.IsFileExist(update_path) then
      if not self.v_local_version_tbl.Versions[filepath] then
        self.v_local_version_tbl.Versions[filepath] = {}
      end
      self.v_local_version_tbl.Versions[filepath].Md5 = md5
      self.v_local_version_tbl.Versions[filepath].Size = remote_res_size
    end
    self:_save_json_file()
    self.v_need_download_patch[filepath] = nil
    self.v_update_content_size = self.v_update_content_size + remote_res_size
    self:_check_download_patch()
  end)
end

function M:_save_json_file()
  local str = Json.encode(self.v_local_version_tbl)
  CSHelper.WriteAllText(PathDefine.local_version_file, str)
end

function M:get_cur_download_size()
  local download_size = 0
  if self.v_download_request then
    download_size = self.v_download_request.downloadedBytes
  end
  local cur_size = self.v_update_content_size + download_size
  return cur_size, self.v_repair_content_size
end

function M:_check_clear_patch()
  for filepath, _ in pairs(self.v_need_clear_patch) do
    self.v_local_version_tbl.Versions[filepath] = nil
    local update_path = PathDefine.update_dir .. filepath
    CSHelper.RemoveFile(update_path)
    self:_save_json_file()
  end
  self.v_need_clear_patch = {}
end

return M
