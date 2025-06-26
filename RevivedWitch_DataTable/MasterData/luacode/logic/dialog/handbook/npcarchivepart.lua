-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/npcarchivepart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CNpcHandBookCfg = (BeanManager.GetTableByName)("handbook.cnpcconfig_handbook")
local CRaceCfg = (BeanManager.GetTableByName)("role.cracecfg")
local CAffiliationCfg = (BeanManager.GetTableByName)("handbook.caffiliation_handbook")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local NpcArchivePart = class("NpcArchivePart", Dialog)
NpcArchivePart.AssetBundleName = "ui/layouts.tujian"
NpcArchivePart.AssetName = "CharBookRecord"
NpcArchivePart.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NpcArchivePart
  ((NpcArchivePart.super).Ctor)(self, ...)
end

NpcArchivePart.OnCreate = function(self)
  -- function num : 0_1
  self._artist = self:GetChild("Painter/Txt2")
  self._cv = self:GetChild("CV/Txt2")
  self._sex = self:GetChild("Sex/Txt2")
  self._race = self:GetChild("Race/Txt2")
  self._age = self:GetChild("Age/Txt2")
  self._birthday = self:GetChild("Birthday/Txt2")
  self._height = self:GetChild("Height/Txt2")
  self._weight = self:GetChild("Weight/Txt2")
  self._affiliation = self:GetChild("Belong/Txt2")
  self._hobby = self:GetChild("Hobby/Txt2")
end

NpcArchivePart.OnDestroy = function(self)
  -- function num : 0_2
end

NpcArchivePart.Refresh = function(self, npcid)
  -- function num : 0_3 , upvalues : CNpcHandBookCfg, _ENV, CRaceCfg, CStringRes, CAffiliationCfg
  local npcBookCfg = CNpcHandBookCfg:GetRecorder(npcid)
  if not npcBookCfg then
    return 
  end
  ;
  (self._artist):SetText(npcBookCfg.artist)
  ;
  (self._cv):SetText(npcBookCfg.cv)
  local text = (TextManager.GetText)(npcBookCfg.sex)
  ;
  (self._sex):SetText(text)
  local raceCfg = CRaceCfg:GetRecorder(npcBookCfg.race)
  local name = (TextManager.GetText)(raceCfg.nameTextID)
  ;
  (self._race):SetText(name)
  ;
  (self._age):SetText(npcBookCfg.age)
  ;
  (self._birthday):SetText(npcBookCfg.birthday)
  ;
  (self._height):SetText(npcBookCfg.height)
  ;
  (self._weight):SetText(npcBookCfg.weight)
  if npcBookCfg.affiliation == 0 then
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1216)).msgTextID)
    ;
    (self._affiliation):SetText(str)
  else
    do
      do
        local affiliationcfg = CAffiliationCfg:GetRecorder(npcBookCfg.affiliation)
        if affiliationcfg then
          (self._affiliation):SetText((TextManager.GetText)(affiliationcfg.nameTextID))
        else
          LogErrorFormat("NpcArchivePart", "caffiliation_handbook doesnt have id %s, npc id %s", npcBookCfg.affiliation, npcid)
        end
        text = (TextManager.GetText)(tonumber(npcBookCfg.hobby))
        ;
        (self._hobby):SetText(text)
      end
    end
  end
end

return NpcArchivePart

