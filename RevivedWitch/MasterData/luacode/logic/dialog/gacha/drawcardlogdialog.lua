-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/drawcardlogdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TextStaticFunctions = (((CS.PixelNeko).Lua).UI).TextStaticFunctions
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CCardPool = (BeanManager.GetTableByName)("item.ccardpool")
local TableFrame = require("framework.ui.frame.table.tableframe")
local DrawCardLogDialog = class("DrawCardLogDialog", Dialog)
DrawCardLogDialog.AssetBundleName = "ui/layouts.gacha"
DrawCardLogDialog.AssetName = "GachaRecord"
DrawCardLogDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : DrawCardLogDialog
  ((DrawCardLogDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._tab = nil
end

DrawCardLogDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV, CStringres, CVarConfig, TextStaticFunctions
  local transform = ((self:GetRootWindow())._uiObject).transform
  self._black = self:GetChild("Black")
  self._framePanel = self:GetChild("Back/Frame")
  self._remindTxt = (transform:Find("Back/RemindTxt")).gameObject
  self._empty = (transform:Find("Back/Empty")).gameObject
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._log = {}
  self._frame = (TableFrame.Create)(self._framePanel, self, true, true, false)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local str = ""
  str = (TextManager.GetText)((CStringres:GetRecorder(1154)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", (CVarConfig:GetRecorder(31)).Value)
  ;
  (TextStaticFunctions.SetText)(self._remindTxt, str)
end

DrawCardLogDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

DrawCardLogDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3
  self:Destroy()
end

DrawCardLogDialog.SetData = function(self, log)
  -- function num : 0_4 , upvalues : _ENV, CCardPool, CStringres, TextStaticFunctions
  local poolId = nil
  local dialog = (DialogManager.GetDialog)("gacha.gachamaindialog")
  do
    if dialog and dialog:GetSelectedPool() then
      local pool = dialog:GetSelectedPool()
      if pool then
        poolId = pool.id
      end
    end
    if poolId then
      local cardPoolRecord = CCardPool:GetRecorder(poolId)
      local str = (string.sub)(poolId, 1, 2)
      if cardPoolRecord.cardpooltype == 2 then
        for i,v in ipairs(log) do
          cardPoolRecord = CCardPool:GetRecorder(v.poolId)
          if cardPoolRecord and cardPoolRecord.cardpooltype == 2 then
            (table.insert)(self._log, v)
          end
        end
      else
        do
          for i,v in ipairs(log) do
            cardPoolRecord = CCardPool:GetRecorder(v.poolId)
            if cardPoolRecord and cardPoolRecord.cardpooltype == 1 then
              (table.insert)(self._log, v)
            end
          end
          do
            for k,v in ipairs(log) do
              (table.insert)(self._log, R11_PC83)
            end
            do
              if #self._log == 0 then
                local str = (TextManager.GetText)((CStringres:GetRecorder(1157)).msgTextID)
                ;
                (TextStaticFunctions.SetText)(self._empty, str)
              else
                do
                  ;
                  (TextStaticFunctions.SetText)(self._empty, "")
                end
              end
            end
          end
        end
      end
    end
  end
end

DrawCardLogDialog.OnRefreshPools = function(self)
  -- function num : 0_5
  (self._frame):ReloadAllCell()
end

DrawCardLogDialog.NumberOfCell = function(self, frame)
  -- function num : 0_6
  return #self._log
end

DrawCardLogDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._log)[index]
end

DrawCardLogDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_8
  return "gacha.drawcardlogcell"
end

return DrawCardLogDialog

