-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildupgradetips.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CGuildAttribute = (BeanManager.GetTableByName)("guild.cguildattribute")
local CGuildShop = (BeanManager.GetTableByName)("guild.cguildshop")
local GuildUpGradeTips = class("GuildUpGradeTips", Dialog)
GuildUpGradeTips.AssetBundleName = "ui/layouts.guild"
GuildUpGradeTips.AssetName = "GuildUpGradeTips"
GuildUpGradeTips.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildUpGradeTips
  ((GuildUpGradeTips.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._cellData = {}
  self._MaxLv = 0
  self._MinLv = 0
  self._pos = 0
end

GuildUpGradeTips.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._Lv = self:GetChild("Back/Level/LevelNum")
  self._maxCount = self:GetChild("Back/Max/Num")
  self._vicePresidentCount = self:GetChild("Back/VicePresident/Num")
  self._eliteCount = self:GetChild("Back/Elite/Num")
  self._shopLevel = self:GetChild("Back/ShopLevel/Num")
  self._costCount = self:GetChild("Back/Cost/Num")
  self._panel = self:GetChild("Back/Frame")
  self._frame = (GridFrame.Create)(self._panel, self, true, 4)
  self._leftArrow = self:GetChild("Back/LeftArrow")
  self._rightArrow = self:GetChild("Back/RightArrow")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  ;
  (self._leftArrow):Subscribe_PointerClickEvent(self.OnLeftArrowClicked, self)
  ;
  (self._rightArrow):Subscribe_PointerClickEvent(self.OnRightArrowClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:Init()
end

GuildUpGradeTips.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GuildUpGradeTips.Init = function(self)
  -- function num : 0_3 , upvalues : CGuildAttribute, _ENV
  local allIds = CGuildAttribute:GetAllIds()
  self._MaxLv = allIds[#allIds]
  self._MinLv = allIds[1]
  self._pos = (((NekoData.BehaviorManager).BM_Guild):GetGuildInfo()).partyLv
  self:Refresh()
end

GuildUpGradeTips.Refresh = function(self)
  -- function num : 0_4 , upvalues : CGuildAttribute, CGuildShop
  local recorder = CGuildAttribute:GetRecorder(self._pos)
  ;
  (self._Lv):SetText(self._pos)
  ;
  (self._maxCount):SetText(recorder.GuildTotal)
  ;
  (self._vicePresidentCount):SetText(recorder.VicePresidentTotal)
  ;
  (self._eliteCount):SetText(recorder.EliteTotal)
  ;
  (self._shopLevel):SetText(recorder.shoplevel)
  ;
  (self._costCount):SetText(recorder.Guildkeep)
  self._cellData = (CGuildShop:GetRecorder(recorder.shoplevel)).Commodity
  if self._pos == self._MinLv then
    (self._leftArrow):SetActive(false)
  end
  if self._pos == self._MaxLv then
    (self._rightArrow):SetActive(false)
  end
  ;
  (self._frame):ReloadAllCell()
end

GuildUpGradeTips.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._cellData
end

GuildUpGradeTips.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "guild.guildupgradetipscell"
end

GuildUpGradeTips.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._cellData)[index]
end

GuildUpGradeTips.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

GuildUpGradeTips.OnRightArrowClicked = function(self)
  -- function num : 0_9
  if self._pos == self._MinLv then
    (self._leftArrow):SetActive(true)
  end
  self._pos = self._pos + 1
  if self._pos == self._MaxLv then
    (self._rightArrow):SetActive(false)
  end
  self:Refresh(self._pos)
end

GuildUpGradeTips.OnLeftArrowClicked = function(self)
  -- function num : 0_10
  if self._pos == self._MaxLv then
    (self._rightArrow):SetActive(true)
  end
  self._pos = self._pos - 1
  if self._pos == self._MinLv then
    (self._leftArrow):SetActive(false)
  end
  self:Refresh(self._pos)
end

return GuildUpGradeTips

