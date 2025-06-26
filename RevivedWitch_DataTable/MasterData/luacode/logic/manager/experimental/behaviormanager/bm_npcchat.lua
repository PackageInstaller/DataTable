-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_npcchat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BM_NPCChat = class("BM_NPCChat")
local Effects = require("data.dungeondata.dialog.cdialogeffectconfig")
BM_NPCChat.CheckNormalOption = function(self, jumpid)
  -- function num : 0_0 , upvalues : _ENV, Effects
  local recorder = ((BeanManager.GetTableByName)("jump.cdialogjumpconfig")):GetRecorder(jumpid)
  local effect = (Effects[recorder.jump_value])()
  effect:Run()
end

return BM_NPCChat

