-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luabehavior/actions/battleai/changename.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Task = require("luabehavior.base.task")
local TaskStatus = require("luabehavior.base.taskstatus")
local ChangeName = class("ChangeName", Task)
ChangeName.Ctor = function(self, context, nameid)
  -- function num : 0_0 , upvalues : ChangeName, _ENV
  ((ChangeName.super).Ctor)(self)
  self._context = context
  self._nameId = nameid
  self._protocolUtility = (BattleECS.Utility).ProtocolUtility
end

ChangeName.OnStart = function(self)
  -- function num : 0_1
end

ChangeName.OnUpdate = function(self, deltaTime)
  -- function num : 0_2 , upvalues : TaskStatus
  ((self._protocolUtility).ChangeEntityNameTextId)((self._context)._entityId, self._nameId, (self._context)._battleworld)
  return TaskStatus.Success
end

ChangeName.OnEnd = function(self)
  -- function num : 0_3
end

return ChangeName

