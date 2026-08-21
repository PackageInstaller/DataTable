local Statdef = require("cs_share.stat_defines")
local Statmgr = require("cs_share.stat_mgr")
local logicObj = {}

function logicObj:get_npc_attrs(uuid)
  return {
    uuid + 10,
    uuid + 20,
    uuid + 30,
    uuid + 40,
    uuid + 50,
    uuid + 60
  }
end

function logicObj:net_send(sproto, mData)
  print("client net send:", sproto)
end

local oStatMgr1 = Statmgr:new(Statdef.RUN_MODE.CLIENT, 1001, 1, setmetatable({}, {__index = logicObj}))
oStatMgr1:creat_npc({uuid = 888, id = 3002})
oStatMgr1:creat_npc({uuid = 999, id = 3003})
oStatMgr1:creat_npc({uuid = 1111, id = 3004})
oStatMgr1:cast_magic({magic_id = 10001})
oStatMgr1:abort_magic({magic_id = 10001})
local oStatMgr2 = Statmgr:new(Statdef.RUN_MODE.SERVER, 1001, 1, setmetatable({}, {__index = logicObj}))
oStatMgr2:creat_npc({uuid = 888, id = 3002})
oStatMgr2:creat_npc({uuid = 999, id = 3003})
oStatMgr2:creat_npc({uuid = 1111, id = 3004})
oStatMgr2:cast_magic({magic_id = 10001})
oStatMgr2:abort_magic({magic_id = 10001})
assert(oStatMgr1:logstream_to_hash() == oStatMgr2:logstream_to_hash())
local oStatMgr3 = Statmgr:new(Statdef.RUN_MODE.SERVER, 1001, 1, setmetatable({}, {__index = logicObj}))
oStatMgr3:creat_npc({uuid = 888, id = 3002})
oStatMgr3:creat_npc({uuid = 999, id = 3002})
oStatMgr3:creat_npc({uuid = 2222, id = 3005})
oStatMgr3:cast_magic({magic_id = 10001})
oStatMgr3:abort_magic({magic_id = 10001})
assert(oStatMgr1:logstream_to_hash() ~= oStatMgr3:logstream_to_hash())
oStatMgr1:logstream_to_file("cs_share")
