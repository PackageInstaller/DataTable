local core = require("sproto.core")
local parser = require("network.sproto.sprotoparser")
local sproto = require("network.sproto.sproto")
local sproto_index = 1
local base_package = "BasePackage"
local SPROTO_NAME = "sproto/spb.bytes"
local M = {}
local ENCODE_TBL = {}
local SUIRVIVAL_PROTO_ID = 1567
local FS_PROTO_MAP = {
  [SUIRVIVAL_PROTO_ID] = true
}

function M:init()
  local data, bundle
  data = ResMgr:load_res(Path.get_full_prefab_path(SPROTO_NAME), UnityEngine.TextAsset)
  local sp = core.newproto(data.bytes)
  self.v_sp = sproto.sharenew(sp)
  self.v_sp_host = self.v_sp:host(base_package)
  self.v_attach_func = self.v_sp_host:attach(self.v_sp)
  ResMgr:unload_res(SPROTO_NAME, UnityEngine.TextAsset)
end

function M:encode(name, args, session)
  return self.v_attach_func(name, args, session)
end

function M:decode(data)
  return self.v_sp_host:dispatch(data)
end

function M:get_proto_id(name)
  return self.v_sp:pname2id(name)
end

function M:exist_response(name)
  return self.v_sp:exist_response(name)
end

function M:is_fs_proto(proto_id)
  if proto_id >= 600 and proto_id < 700 then
    return true
  end
  if proto_id >= 900 and proto_id < 1000 then
    return true
  end
  if proto_id >= 1100 and proto_id < 1150 then
    return true
  end
  if proto_id >= 1500 and proto_id < 1550 then
    return true
  end
  if proto_id >= 1900 and proto_id < 1950 then
    return true
  end
  if proto_id >= 2700 and proto_id < 2750 then
    return true
  end
  if proto_id >= 3200 and proto_id < 3210 then
    return true
  end
  if proto_id >= 3500 and proto_id < 3600 then
    return true
  end
  if proto_id >= 3600 and proto_id < 3700 then
    return true
  end
  if proto_id >= 4600 and proto_id < 4700 then
    return true
  end
  if proto_id >= 2600 and proto_id < 2650 then
    return true
  end
  return FS_PROTO_MAP[proto_id]
end

return M
