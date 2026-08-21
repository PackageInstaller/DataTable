-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/favourgiftcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFavourExp = (BeanManager.GetTableByName)("role.cfavourexp")
local CFavourSkill = (BeanManager.GetTableByName)("role.cfavourskill")
local CFavourGiftType = (BeanManager.GetTableByName)("role.cfavourgifttype")
local FavourGiftCell = class("FavourGiftCell", Dialog)
FavourGiftCell.AssetBundleName = "ui/layouts.tujian"
FavourGiftCell.AssetName = "FavourGiftCell"
FavourGiftCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FavourGiftCell
  ((FavourGiftCell.super).Ctor)(self, ...)
end

FavourGiftCell.OnCreate = function(self)
  -- function num : 0_1
  self._favourLvTxt = self:GetChild("LevelNum")
  self._normalPanel = self:GetChild("Normal")
  self._normalPanel_effectTxt = self:GetChild("Normal/Txt")
  self._normalPanel_gotBtn = self:GetChild("Normal/GetBtn1")
  self._normalPanel_unlockBtn = self:GetChild("Normal/GetBtn")
  self._lockPanel = self:GetChild("Lock")
  ;
  (self._normalPanel_unlockBtn):Subscribe_PointerClickEvent(self.OnUnlockBtnClick, self)
end

FavourGiftCell.OnDestroy = function(self)
  -- function num : 0_2
end

local GetString = function(self)
  -- function num : 0_3 , upvalues : _ENV, CFavourSkill, CFavourGiftType
  local rewardType = (self._cellData).rewardType
  local rewardId = (self._cellData).rewardId
  if rewardType == (DataCommon.Favour).Skill then
    local record = CFavourSkill:GetRecorder(rewardId)
    return (TextManager.GetText)(record.skillattributiontxt)
  else
    do
      if rewardType == (DataCommon.Favour).BackgroundStory then
        local record = CFavourGiftType:GetRecorder(rewardType)
        return (TextManager.GetText)((record.storyandlineid)[rewardId])
      else
        do
          if rewardType == (DataCommon.Favour).Voice then
            local record = CFavourGiftType:GetRecorder(rewardType)
            return (TextManager.GetText)((record.storyandlineid)[rewardId])
          end
        end
      end
    end
  end
end

FavourGiftCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : GetString
  (self._favourLvTxt):SetText(data.favourLv)
  if (self._delegate)._curFavourLv < data.favourLv then
    (self._normalPanel):SetActive(false)
    ;
    (self._lockPanel):SetActive(true)
  else
    ;
    (self._normalPanel):SetActive(true)
    ;
    (self._lockPanel):SetActive(false)
    ;
    (self._normalPanel_effectTxt):SetText(GetString(self))
    if data.received then
      (self._normalPanel_gotBtn):SetActive(true)
      ;
      (self._normalPanel_unlockBtn):SetActive(false)
    else
      ;
      (self._normalPanel_gotBtn):SetActive(false)
      ;
      (self._normalPanel_unlockBtn):SetActive(true)
    end
  end
end

FavourGiftCell.OnUnlockBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local rewardType = (self._cellData).rewardType
  local csend = (LuaNetManager.CreateProtocol)("protocol.good.creceiveaward")
  csend.roleId = ((self._delegate)._role):GetId()
  csend.level = (self._cellData).favourLv
  csend:Send()
end

return FavourGiftCell

