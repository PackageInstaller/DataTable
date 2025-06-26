-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/skill/simproveskill.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillMapTable = (BeanManager.GetTableByName)("skill.cskillmap")
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV, CSkillMapTable, CSkillItemTable
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P3

  if (GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCity") or (DialogManager.GetDialog)("battle.battleaccount.battlelosetextdialog") then
    local skillId, skillItemId = nil, nil
    local nodeRecord = CSkillMapTable:GetRecorder(protocol.unlockNode)
    if nodeRecord then
      if ((NekoData.BehaviorManager).BM_Game):IsSkillItemId(nodeRecord.skillID) then
        local skillItemRecord = CSkillItemTable:GetRecorder(nodeRecord.skillID)
        skillId = (skillItemRecord.skillID)[nodeRecord.skillLevel]
        skillItemId = nodeRecord.skillID
      else
        do
          skillId = nodeRecord.skillID
          LogErrorFormat("SImproveSkill", "no id %s in cskillmap", protocol.unlockNode)
          ;
          ((DialogManager.CreateSingletonDialog)("skill.skillunlocksuccessdialog")):SetData(skillId, skillItemId, protocol.roleId)
          ;
          (LuaNotificationCenter.PostNotification)(Common.n_ImproveSkill, nil, protocol)
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

