-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/npc/npcuidialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NpcUIDialog = class("NpcUIDialog", Dialog)
NpcUIDialog.AssetBundleName = "ui/layouts.npc"
NpcUIDialog.AssetName = "NPC"
NpcUIDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcUIDialog
  ((NpcUIDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._childs = {}
end

NpcUIDialog.OnCreate = function(self)
  -- function num : 0_1
end

NpcUIDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for _,v in ipairs(self._childs) do
    (v.dialog):Destroy()
  end
  self._childs = {}
end

NpcUIDialog.OnUpdate = function(self)
  -- function num : 0_3
end

NpcUIDialog.CreateChild = function(self, dialogName, sceneId, npcId)
  -- function num : 0_4 , upvalues : _ENV
  local dialog = (DialogManager.CreateDialog)(dialogName, (self:GetRootWindow())._uiObject)
  dialog:SetData(sceneId, npcId)
  local temp = {}
  temp.dialog = dialog
  temp.sceneId = sceneId
  temp.npcId = npcId
  ;
  (table.insert)(self._childs, temp)
end

NpcUIDialog.UpdateChild = function(self, sceneId, npcId)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in ipairs(self._childs) do
    -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

    if sceneId and v.sceneId == sceneId and npcId and v.npcId == npcId then
      (v.dialog):Refresh()
    end
    ;
    (v.dialog):Refresh()
    ;
    (v.dialog):Refresh()
  end
end

return NpcUIDialog

