local UnityWebRequest = UnityEngine.Networking.UnityWebRequest
local _make_url_func
local M = {}
M.__index = M

function M.new()
  local t = setmetatable({}, M)
  t:_init()
  return t
end

local Task = {}
Task.__index = Task

function Task.new(...)
  local t = setmetatable({}, Task)
  t:_init(...)
  return t
end

function Task:_init(filepath, md5, prefix_url_list, uid, cb, cb_self)
  self.v_file_path = filepath
  self.v_md5 = md5
  self.v_prefix_url_list = prefix_url_list
  self.v_uid = uid
  self.v_cb = cb
  self.v_cb_self = cb_self
  self.v_request = nil
  self:_do_download()
end

function Task:_do_download()
  Coroutine.start(function()
    local remote_path, err_msg
    for i = 1, #self.v_prefix_url_list do
      remote_path = _make_url_func(self.v_file_path, self.v_md5, self.v_prefix_url_list[i])
      self.v_request = UnityWebRequest.Get(remote_path)
      coroutine.yield(self.v_request:SendWebRequest())
      if self.v_request == nil then
        return
      end
      if Util.is_net_work_error(self.v_request) then
        err_msg = self.v_request.error
        self.v_request:Dispose()
        self.v_request = nil
        print("down isHttpError,  url = ", remote_path)
      else
        local bytes = self.v_request.downloadHandler.data
        if nil == bytes then
          err_msg = "empty bytes"
          self.v_request:Dispose()
          self.v_request = nil
          print("down bytes nil,  url = ", remote_path)
        else
          self.v_cb(self.v_cb_self, self, true, self.v_request, nil)
          if self.v_request then
            self.v_request:Dispose()
            self.v_request = nil
          end
          return
        end
      end
    end
    self.v_cb(self.v_cb_self, self, false, nil, err_msg)
  end)
end

function Task:get_file_path()
  return self.v_file_path
end

function Task:get_uid()
  return self.v_uid
end

function Task:get_target_md5()
  return self.v_md5
end

function Task:get_downloaded_bytes()
  if self.v_request then
    return self.v_request.downloadedBytes
  end
  return 0
end

function Task:abort()
  if self.v_request then
    self.v_request:Abort()
    self.v_request:Dispose()
    self.v_request = nil
  end
end

function M:_init()
end

function M:_on_error(file_path, err_msg)
  self:abort()
  if self.v_error_cb then
    self.v_error_cb(file_path, err_msg)
  end
end

local function _list_delete_by_value(list, value)
  for i = #list, 1, -1 do
    if list[i] == value then
      table.remove(list, i)
      break
    end
  end
end

function M:_on_one_task_finish(task, is_success, request, err_msg)
  local file_path = task:get_file_path()
  local uid = task:get_uid()
  local target_md5 = task:get_target_md5()
  if self.v_is_finish or uid ~= self.v_uid then
    return
  end
  if not is_success then
    self:_on_error(file_path, err_msg)
    return
  end
  local download_path = self.v_download_dir .. file_path
  local download_md5 = CSHelper.WriteWebRequestAndComputeMd5(download_path, request)
  if target_md5 ~= download_md5 then
    self:_on_error(file_path, [[
diff md5: 
 ]] .. target_md5 .. "\n" .. download_md5)
    return
  end
  _list_delete_by_value(self.v_cur_task_list, task)
  if self.v_single_finish_cb then
    self.v_single_finish_cb(file_path, download_path, download_md5)
  end
  self.v_running_task_cnt = self.v_running_task_cnt - 1
  self:_add_new_task()
end

function M:_add_new_task()
  local file_path, md5 = next(self.v_need_patch_files)
  if nil == file_path then
    if 0 == self.v_running_task_cnt then
      self.v_is_finish = true
      if self.v_all_finish_cb then
        self.v_all_finish_cb()
      end
    end
    return
  end
  self.v_running_task_cnt = self.v_running_task_cnt + 1
  self.v_need_patch_files[file_path] = nil
  local task = Task.new(file_path, md5, self.v_prefix_url_list, self.v_uid, self._on_one_task_finish, self)
  table.insert(self.v_cur_task_list, task)
end

local _uid = 0

local function _next_uid()
  _uid = _uid + 1
  return _uid
end

function M:download(params)
  _make_url_func = params.make_url_func
  self.v_single_finish_cb = params.on_single_file_finish_cb
  self.v_all_finish_cb = params.on_all_file_finish_cb
  self.v_error_cb = params.on_error_cb
  self.v_need_patch_files = params.res_map
  self.v_prefix_url_list = params.prefix_url_list
  self.v_download_dir = params.download_dir
  self.v_max_task_num = params.max_task_num or 3
  self.v_uid = _next_uid()
  self.v_cur_task_list = {}
  print("start download")
  self.v_is_finish = false
  self.v_running_task_cnt = 0
  for i = 1, self.v_max_task_num do
    self:_add_new_task()
  end
end

function M:abort()
  self.v_is_finish = true
  local len = #self.v_cur_task_list
  for i = 1, len do
    local task = self.v_cur_task_list[i]
    task:abort()
  end
end

function M:get_downloaded_bytes()
  local sum = 0
  local len = #self.v_cur_task_list
  for i = 1, len do
    local task = self.v_cur_task_list[i]
    sum = sum + task:get_downloaded_bytes()
  end
  return sum
end

return M
