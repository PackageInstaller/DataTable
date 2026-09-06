local CanvasStaticFunctions = CS.PixelNeko.Lua.UI.CanvasStaticFunctions
local TabFrame = require("framework.ui.frame.tab.tabframe")
local CAlchemyFormulaTypeCfg = BeanManager.GetTableByName("courtyard.calchemyformulatype")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local TabNum = 3
local ChooseFormulaDialog = class("ChooseFormulaDialog", Dialog)
ChooseFormulaDialog.AssetBundleName = "ui/layouts.yard"
ChooseFormulaDialog.AssetName = "AlchemyChoose"

function ChooseFormulaDialog:Ctor(...)
  ChooseFormulaDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._formulas = nil
  self._tab = nil
  self._willDestroy = false
end

function ChooseFormulaDialog:OnCreate()
  self._groupBtns = {}
  for i = 1, TabNum do
    self._groupBtns[i] = {}
    local map = self._groupBtns[i]
    map.btn = self:GetChild("GroupBtn" .. i)
    map.name = self:GetChild("GroupBtn" .. i .. "/Text")
    map.icon = self:GetChild("GroupBtn" .. i .. "/Image")
    map.btn:Subscribe_PointerClickEvent(function()
      self:OnGroupBtnClicked(i)
    end)
  end
  self._tips = self:GetChild("Tips")
  self._title = self:GetChild("Title")
  self._tabPanel = self:GetChild("Frame")
  self._back = self:GetChild("Back")
  self._closeBtn = self:GetChild("CloseBtn")
  self._tabFrame = TabFrame.Create(self._tabPanel, self)
  self._back:Subscribe_PointerClickEvent(self.OnMouseClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:GetRootWindow():PlayAnimation("AlchemyChooseShow")
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnStateExit, self)
  CanvasStaticFunctions.SetCanvasPixelPerfect(self._rootWindow._uiObject, false)
  self._title:SetText(TextManager.GetText(800130))
end

function ChooseFormulaDialog:OnDestroy()
  self._tabFrame:Destroy()
end

function ChooseFormulaDialog:Init()
  local defaultIndex
  self._formulas = NekoData.BehaviorManager.BM_Alchemy:GetFormulas()
  for i, v in ipairs(self._groupBtns) do
    if not self._formulas[i] then
      v.btn:SetActive(false)
    else
      local recorder = CAlchemyFormulaTypeCfg:GetRecorder(i)
      v.name:SetText(TextManager.GetText(recorder.typeNameTextID))
      local imageRecord = CImagePathTable:GetRecorder(recorder.image)
      v.icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      defaultIndex = defaultIndex or i
    end
  end
  if defaultIndex then
    self:OnGroupBtnClicked(defaultIndex)
  end
end

function ChooseFormulaDialog:SetFormulaId(formulaId)
  self._selectFormulaId = formulaId
  self:Init()
end

function ChooseFormulaDialog:OnGroupBtnClicked(index)
  if not self._willDestroy and index ~= self._tab then
    self._tab = index
    local tabCell = self._tabFrame:ToPage(self._tab)
    tabCell:RefreshTabCell(self._formulas[index])
  end
end

function ChooseFormulaDialog:CellAtIndex(tabFrame, index)
  return "alchemy.formulatabcell"
end

function ChooseFormulaDialog:DidToPage(tabFrame, index)
  for i, v in ipairs(self._groupBtns) do
    self._groupBtns[i].btn:SetSelected(i == index)
  end
  local recorder = CAlchemyFormulaTypeCfg:GetRecorder(index)
  if recorder then
    local str
    if recorder.byproduct == 1 then
      str = TextManager.GetText(CStringres:GetRecorder(1161).msgTextID)
    else
      str = TextManager.GetText(CStringres:GetRecorder(1162).msgTextID)
    end
    self._tips:SetText(str)
  end
end

function ChooseFormulaDialog:OnMouseClicked()
end

function ChooseFormulaDialog:OnBackBtnClicked()
  self:GetRootWindow():PlayAnimation("AlchemyChooseHide")
  self._willDestroy = true
end

function ChooseFormulaDialog:OnStateExit(handler, stateName, normalizedTime)
  if stateName == "AlchemyChooseHide" then
    self:Destroy()
  end
end

return ChooseFormulaDialog
