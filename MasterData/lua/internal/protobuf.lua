local mt_cache = {}
local pb = require("pb")
pb.load(CS.ResourceManager.Instance:GetBytes("Data/descriptor"))
pb.option("use_default_values")

function ProtobufE(protobuf_type_name, lua_table)
  local ret, msg = pb.encode(protobuf_type_name, lua_table)
  if ret == nil then
    error("Protobuf", msg)
  end
  return ret
end

function ProtobufD(protobuf_type_name, bytes)
  local ret, msg = pb.decode(protobuf_type_name, bytes)
  if ret == nil then
    error("Protobuf", msg)
  end
  return ret
end

function ProtobufT(protobuf_type_name, lua_table)
  lua_table.__prototype = protobuf_type_name
  return lua_table
end

function ProtobufI(prototype, data)
  return setmetatable(data, pb.defaults(prototype))
end

return {
  ProtobufE,
  ProtobufD
}
