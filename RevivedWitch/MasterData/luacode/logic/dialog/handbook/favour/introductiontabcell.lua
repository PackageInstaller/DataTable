-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/handbook/favour/introductiontabcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCardRoleBookCfg = (BeanManager.GetTableByName)("handbook.ccardroleconfig_handbook")
local CRaceCfg = (BeanManager.GetTableByName)("role.cracecfg")
local CAffiliationCfg = (BeanManager.GetTableByName)("handbook.caffiliation_handbook")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local IntroductionTabCell = class("IntroductionTabCell", Dialog)
IntroductionTabCell.AssetBundleName = "ui/layouts.tujian"
IntroductionTabCell.AssetName = "CharStoryFrame1"
IntroductionTabCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : IntroductionTabCell
  ((IntroductionTabCell.super).Ctor)(self, ...)
  self._dataList = {}
end

IntroductionTabCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._frame = (TableFrame.Create)(self._rootWindow, self, true, true, true)
end

IntroductionTabCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

IntroductionTabCell.RefreshTabCell = function(self, refreshData)
  -- function num : 0_3 , upvalues : _ENV, CCardRoleBookCfg, CStringRes, CAffiliationCfg
  if not self._init or refreshData then
    self._init = true
    while (self._dataList)[#self._dataList] do
      (table.remove)(self._dataList, #self._dataList)
    end
    local roleId = (((self._delegate)._delegate)._role):GetId()
    local roleBookCfg = CCardRoleBookCfg:GetRecorder(roleId)
    if not roleBookCfg then
      return 
    end
    ;
    (table.insert)(self._dataList, {title = (TextManager.GetText)(502723), content = (TextManager.GetText)(roleBookCfg.sexTextID)})
    ;
    (table.insert)(self._dataList, {title = (TextManager.GetText)(502724), content = roleBookCfg.age})
    ;
    (table.insert)(self._dataList, {title = (TextManager.GetText)(502725), content = roleBookCfg.height})
    ;
    (table.insert)(self._dataList, {title = (TextManager.GetText)(502727), content = (TextManager.GetText)(roleBookCfg.birthday)})
    local str = nil
    if roleBookCfg.affiliation == 0 then
      str = (TextManager.GetText)((CStringRes:GetRecorder(1216)).msgTextID)
    else
      local affiliationcfg = CAffiliationCfg:GetRecorder(roleBookCfg.affiliation)
      str = (TextManager.GetText)(affiliationcfg.nameTextID)
    end
    do
      do
        ;
        (table.insert)(self._dataList, {title = (TextManager.GetText)(502728), content = str})
        ;
        (table.insert)(self._dataList, {title = (TextManager.GetText)(502729), content = (TextManager.GetText)(roleBookCfg.hobbyTextID)})
        ;
        (self._frame):ReloadAllCell()
        ;
        (self._frame):MoveToTop()
      end
    end
  end
end

IntroductionTabCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._dataList
end

IntroductionTabCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "handbook.favour.introductioncell"
end

IntroductionTabCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._dataList)[index]
end

IntroductionTabCell.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

return IntroductionTabCell

