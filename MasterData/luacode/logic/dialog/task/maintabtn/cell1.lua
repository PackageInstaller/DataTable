-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/task/maintabtn/cell1.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Cell1 = class("Cell1", Dialog)
Cell1.AssetBundleName = "ui/layouts.basetasklist"
Cell1.AssetName = "TaskMainGroupBtn5"
Cell1.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : Cell1
  ((Cell1.super).Ctor)(self, ...)
end

Cell1.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("BattlePassBtn")
  self._redDot = self:GetChild("BattlePassBtn/RedDot")
  ;
  (self._btn):Subscribe_PointerClickEvent(self.OnTabBtnClicked, self)
end

Cell1.OnDestroy = function(self)
  -- function num : 0_2
end

Cell1.RefreshCell = function(self, data)
  -- function num : 0_3
end

Cell1.OnTabBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):ToPage(self._cellData)
end

Cell1.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : _ENV
  if self._cellData ~= arg then
    (self._btn):SetSelected(eventName ~= "SelectedTab")
    if eventName == "RefreshRedDot" then
      if self._cellData ~= 5 then
        (self._redDot):SetActive(arg:IsIndexTrue(self._cellData))
      else
        (self._redDot):SetActive((((NekoData.BehaviorManager).BM_Activity):GetManager(2)):HasTaskUntakeAward())
      end
    end
    -- DECOMPILER ERROR: 4 unprocessed JMP targets
  end
end

return Cell1

