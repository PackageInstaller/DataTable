-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/chooseformuladialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CanvasStaticFunctions = (((CS.PixelNeko).Lua).UI).CanvasStaticFunctions
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CAlchemyFormulaTypeCfg = (BeanManager.GetTableByName)("courtyard.calchemyformulatype")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local TabNum = 3
local ChooseFormulaDialog = class("ChooseFormulaDialog", Dialog)
ChooseFormulaDialog.AssetBundleName = "ui/layouts.yard"
ChooseFormulaDialog.AssetName = "AlchemyChoose"
ChooseFormulaDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChooseFormulaDialog
  ((ChooseFormulaDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._formulas = nil
  self._tab = nil
  self._willDestroy = false
end

ChooseFormulaDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TabNum, TabFrame, CanvasStaticFunctions, _ENV
  self._groupBtns = {}
  for i = 1, TabNum do
    do
      -- DECOMPILER ERROR at PC8: Confused about usage of register: R5 in 'UnsetPending'

      (self._groupBtns)[i] = {}
      local map = (self._groupBtns)[i]
      map.btn = self:GetChild("GroupBtn" .. i)
      map.name = self:GetChild("GroupBtn" .. i .. "/Text")
      map.icon = self:GetChild("GroupBtn" .. i .. "/Image")
      ;
      (map.btn):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnGroupBtnClicked(i)
  end
)
    end
  end
  self._tips = self:GetChild("Tips")
  self._title = self:GetChild("Title")
  self._tabPanel = self:GetChild("Frame")
  self._back = self:GetChild("Back")
  self._closeBtn = self:GetChild("CloseBtn")
  self._tabFrame = (TabFrame.Create)(self._tabPanel, self)
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self:GetRootWindow()):PlayAnimation("AlchemyChooseShow")
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (CanvasStaticFunctions.SetCanvasPixelPerfect)((self._rootWindow)._uiObject, false)
  ;
  (self._title):SetText((TextManager.GetText)(800130))
end

ChooseFormulaDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._tabFrame):Destroy()
end

ChooseFormulaDialog.Init = function(self)
  -- function num : 0_3 , upvalues : _ENV, CAlchemyFormulaTypeCfg, CImagePathTable
  local defaultIndex = nil
  self._formulas = ((NekoData.BehaviorManager).BM_Alchemy):GetFormulas()
  for i,v in ipairs(self._groupBtns) do
    if not (self._formulas)[i] then
      (v.btn):SetActive(false)
    else
      local recorder = CAlchemyFormulaTypeCfg:GetRecorder(i)
      ;
      (v.name):SetText((TextManager.GetText)(recorder.typeNameTextID))
      local imageRecord = CImagePathTable:GetRecorder(recorder.image)
      ;
      (v.icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if not defaultIndex then
        defaultIndex = i
      end
    end
  end
  if defaultIndex then
    self:OnGroupBtnClicked(defaultIndex)
  end
end

ChooseFormulaDialog.SetFormulaId = function(self, formulaId)
  -- function num : 0_4
  self._selectFormulaId = formulaId
  self:Init()
end

ChooseFormulaDialog.OnGroupBtnClicked = function(self, index)
  -- function num : 0_5
  if not self._willDestroy and index ~= self._tab then
    self._tab = index
    local tabCell = (self._tabFrame):ToPage(self._tab)
    tabCell:RefreshTabCell((self._formulas)[index])
  end
end

ChooseFormulaDialog.CellAtIndex = function(self, tabFrame, index)
  -- function num : 0_6
  return "alchemy.formulatabcell"
end

ChooseFormulaDialog.DidToPage = function(self, tabFrame, index)
  -- function num : 0_7 , upvalues : _ENV, CAlchemyFormulaTypeCfg, CStringres
  for i,v in ipairs(self._groupBtns) do
    (((self._groupBtns)[i]).btn):SetSelected(i == index)
  end
  local recorder = CAlchemyFormulaTypeCfg:GetRecorder(index)
  do
    if recorder then
      local str = nil
      if recorder.byproduct == 1 then
        str = (TextManager.GetText)((CStringres:GetRecorder(1161)).msgTextID)
      else
        str = (TextManager.GetText)((CStringres:GetRecorder(1162)).msgTextID)
      end
      ;
      (self._tips):SetText(str)
    end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

ChooseFormulaDialog.OnMouseClicked = function(self)
  -- function num : 0_8
end

ChooseFormulaDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  (self:GetRootWindow()):PlayAnimation("AlchemyChooseHide")
  self._willDestroy = true
end

ChooseFormulaDialog.OnStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_10
  if stateName == "AlchemyChooseHide" then
    self:Destroy()
  end
end

return ChooseFormulaDialog

