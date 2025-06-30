-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/levelbosscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelStateEnum = (LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local LevelBossCell = class("LevelBossCell", Dialog)
LevelBossCell.AssetBundleName = "ui/layouts.activitystar2"
LevelBossCell.AssetName = "ActivityStar2CellBoss"
LevelBossCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelBossCell
  ((LevelBossCell.super).Ctor)(self, ...)
end

LevelBossCell.OnCreate = function(self)
  -- function num : 0_1
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

LevelBossCell.OnDestroy = function(self)
  -- function num : 0_2
end

LevelBossCell.SetData = function(self, delegate, data)
  -- function num : 0_3 , upvalues : _ENV, LevelStateEnum
  self._delegate = delegate
  self._data = data
  self._levelId = (data.data).levelId
  self._status = (data.data).status
  local nodeStr = tostring((data.record).levelanim)
  local node = self:GetChild(nodeStr)
  node:SetActive(true)
  self._select = self:GetChild(nodeStr .. "/SelectBack")
  self._limit = self:GetChild(nodeStr .. "/Lock")
  self._limit_txt = self:GetChild(nodeStr .. "/Lock/Txt")
  self._new = self:GetChild(nodeStr .. "/New")
  self._title = self:GetChild(nodeStr .. "/Title")
  self._name = self:GetChild(nodeStr .. "/Back/Name")
  self._effect = self:GetChild(nodeStr .. "/UI_TX_xingchen_boss")
  if self._status == LevelStateEnum.LOCK then
    (self._select):SetActive(false)
    ;
    (self._limit):SetActive(false)
    ;
    (self._new):SetActive(false)
  else
    if self._levelId == (self._delegate)._selectLevelId then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
    ;
    (self._limit):SetActive(false)
    if self._status ~= LevelStateEnum.PASSED then
      (self._new):SetActive(true)
      if self._status == LevelStateEnum.UNSTART then
        (self._limit):SetActive(true)
        local levelStartStr = (string.sub)((data.record).levelstart, 6, 16)
        local monthStr = (string.sub)(levelStartStr, 1, 2)
        local dayStr = (string.sub)(levelStartStr, 4, 5)
        local hourStr = (string.sub)(levelStartStr, 7, -1)
        local str = (string.gsub)((TextManager.GetText)(1900882), "%$parameter1%$", tonumber(monthStr))
        str = (string.gsub)(str, "%$parameter2%$", tonumber(dayStr))
        str = (string.gsub)(str, "%$parameter3%$", hourStr)
        ;
        (self._limit_txt):SetText(str)
      end
    else
      do
        ;
        (self._new):SetActive(false)
        ;
        (self._title):SetText((TextManager.GetText)((data.record).leveltitle))
        ;
        (self._name):SetText((TextManager.GetText)((data.record).levelname))
      end
    end
  end
end

LevelBossCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SelectLevelById(self._levelId)
end

LevelBossCell.OnEvent = function(self, eventName)
  -- function num : 0_5
  if eventName == "SetSelected" then
    if self._levelId == (self._delegate)._selectLevelId then
      (self._select):SetActive(true)
      self:PlayAnimation()
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

LevelBossCell.PlayAnimation = function(self)
  -- function num : 0_6
  (self._rootWindow):PlayAnimation("ActivityStarCellBoss_show")
end

return LevelBossCell

