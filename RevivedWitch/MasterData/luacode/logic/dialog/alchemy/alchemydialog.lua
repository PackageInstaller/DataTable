-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/alchemydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local StateEventTriggerHelper = ((CS.PixelNeko).Animation).EventTriggerHelper
local AnimationHelper = ((CS.PixelNeko).Animation).AnimationHelper
local CAlchemyLvCfg = (BeanManager.GetTableByName)("courtyard.calchemylv")
local CAlchemyFormulaCfg = (BeanManager.GetTableByName)("courtyard.calchemyformula")
local CAlchemyFormulaTypeCfg = (BeanManager.GetTableByName)("courtyard.calchemyformulatype")
local CAlchemyStageCfg = (BeanManager.GetTableByName)("courtyard.calchemystage")
local CAlchemyStageEffectsCfg = (BeanManager.GetTableByName)("courtyard.calchemystageeffects")
local CYardSkillCfg = (BeanManager.GetTableByName)("courtyard.cyardskill")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAlchemyPicRes = (BeanManager.GetTableByName)("courtyard.calchemypicres")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local MaxAlchemyStage = ((NekoData.BehaviorManager).BM_Alchemy):GetMaxAlchemyStage()
if not CImagePathTable:GetRecorder(12396) then
  local invalidImgRecord = DataCommon.DefaultImageAsset
end
if not CImagePathTable:GetRecorder(12397) then
  local inapplicableImgRecord = DataCommon.DefaultImageAsset
end
local MaterialMaxNum = 3
local speed = 5
local AlchemyDialog = class("AlchemyDialog", Dialog)
AlchemyDialog.AssetBundleName = "ui/layouts.yard"
AlchemyDialog.AssetName = "AlchemyMain"
local FinishGuide = function(self)
  -- function num : 0_0 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(27, 4) then
    (LuaNotificationCenter.RemoveObserver)(self, Common.n_GuideResponseClick)
    ;
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(27)
  end
end

local HandleGuideStatusChanged = function(self, notification)
  -- function num : 0_1 , upvalues : _ENV, FinishGuide
  local guideId = (notification.userInfo).guideID
  if guideId == 27 and (notification.userInfo).guideStatus == "Start" then
    (LuaNotificationCenter.AddObserver)(self, FinishGuide, Common.n_GuideResponseClick, nil)
  end
end

AlchemyDialog.Ctor = function(self, ...)
  -- function num : 0_2 , upvalues : AlchemyDialog
  ((AlchemyDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._courtyardSceneController = nil
  self._formulaId = nil
  self._formulaNum = 0
  self._mainProduct = nil
  self._materials = {}
  self._role = nil
  self._materialsCostAndStock = {}
  self._showAlchemyDetailPanel = false
end

AlchemyDialog.OnCreate = function(self)
  -- function num : 0_3 , upvalues : _ENV, MaterialMaxNum, StateEventTriggerHelper, TableFrame, HandleGuideStatusChanged
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._level = self:GetChild("TopMessage/LVNum")
  self._rateTxt = self:GetChild("Probability/Num2")
  self._alchemyStagePoint = self:GetChild("Level/LvPoint")
  self._alchemyLevelPanel = self:GetChild("Level")
  self._alchemyLevelTxt = self:GetChild("Level/LevelBack/LVNum")
  self._nextAlchemyLevel = self:GetChild("Level/LevelBack/LVNumAdd")
  ;
  (self._nextAlchemyLevel):SetActive(false)
  self._curProgress = self:GetChild("Level/Loading/BackGround/BackGround2/Progress")
  self._nextProgress = self:GetChild("Level/Loading/BackGround/BackGround2")
  ;
  (self._nextProgress):SetFillAmount(0)
  self._normal = self:GetChild("Level/Loading/Level")
  self._curExp = self:GetChild("Level/Loading/Level/Num")
  self._maxExp = self:GetChild("Level/Loading/Level/NumMax")
  self._addExp = self:GetChild("Level/Loading/Level/AddNum")
  self._max = self:GetChild("Level/Loading/TxtMax")
  self._lvUpIcon = self:GetChild("Level/LevelUpState")
  self._ibtn = self:GetChild("Level/Ibtn")
  self._downArrowBtn = self:GetChild("Level/ArrowBtn")
  self._alchemyStageDetailPanel = self:GetChild("Down")
  self._alchemyStageDetailPanel_Title = self:GetChild("Down/Txt")
  self._alchemyStageDetailPanel_effectEmpty = self:GetChild("Down/Empty")
  ;
  (self._alchemyStageDetailPanel_effectEmpty):SetText((TextManager.GetText)(800128))
  self._alchemyStageDetailPanel_effectPanel = self:GetChild("Down/Frame")
  self._alchemyStageDetailPanel_arrowBtn = self:GetChild("Down/ArrowBtn")
  self._levelBack = self:GetChild("Level/LevelBack")
  self._loadingClickPanel = self:GetChild("Level/Loading/Click")
  self._mainProductPanel = self:GetChild("ResultItemBack")
  self._mainProductAdd = self:GetChild("ResultItemBack/Add")
  self._mainProductItem = self:GetChild("ResultItemBack/Item")
  self._mainProductFrame = self:GetChild("ResultItemBack/Item/RankBack")
  self._mainProductIcon = self:GetChild("ResultItemBack/Item/Item")
  self._mainProductNum = self:GetChild("ResultItemBack/Item/Count")
  self._materialPanels = {}
  for i = 1, MaterialMaxNum do
    do
      -- DECOMPILER ERROR at PC151: Confused about usage of register: R5 in 'UnsetPending'

      (self._materialPanels)[i] = {}
      local map = (self._materialPanels)[i]
      map.item = self:GetChild("Empty" .. R9_PC158 .. "/Item")
      map.frame = self:GetChild("Empty" .. R9_PC158 .. "/Item/RankBack")
      -- DECOMPILER ERROR at PC170: Overwrote pending register: R9 in 'AssignReg'

      map.icon = self:GetChild("Empty" .. R9_PC158 .. "/Item/Item")
      -- DECOMPILER ERROR at PC177: Overwrote pending register: R9 in 'AssignReg'

      map.num = self:GetChild("Empty" .. R9_PC158 .. "/Item/Count")
      -- DECOMPILER ERROR at PC184: Overwrote pending register: R9 in 'AssignReg'

      map.numRed = self:GetChild("Empty" .. R9_PC158 .. "/Item/CountRed")
      ;
      (map.item):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_0 , upvalues : self, i
    self:OnMaterialClicked(i)
  end
)
    end
  end
  self._char = self:GetChild("Char")
  self._charAddPanel = self:GetChild("Char/Add")
  self._charNormalPanel = self:GetChild("Char/Cell")
  self._charName = self:GetChild("Char/Cell/Name")
  self._charMoodIcon = self:GetChild("Char/Cell/Mood/Mood")
  self._charCostEnergy = self:GetChild("Char/Cell/Mood/Num")
  self._charCostEnergyRed = self:GetChild("Char/Cell/Mood/NumRed")
  self._charEnergyLessThan0 = self:GetChild("Char/Cell/Empty")
  self._charEnergyLessThan0_txt = self:GetChild("Char/Cell/Empty/Txt")
  self._charEnergyLessThan0_img = self:GetChild("Char/Cell/Empty/Image")
  self._charBack = self:GetChild("Char/Cell/Back")
  self._charPhoto = self:GetChild("Char/Cell/Photo")
  self._charFrame = self:GetChild("Char/Cell/Frame")
  self._charGrey = self:GetChild("Char/Cell/Grey")
  self._charEnergyProgressFull = self:GetChild("Char/Cell/Loading/Loading/BackGround/Progress")
  self._charEnergyProgress = self:GetChild("Char/Cell/Loading/Loading/BackGround/ProgressNotFull")
  self._charEnergyTxt = self:GetChild("Char/Cell/Loading/Num/Num")
  self._charCellMoodIcon = self:GetChild("Char/Cell/Loading/Mood")
  self._yardSkillName = self:GetChild("Char/Cell/SkillName")
  self._yardSkillIcon = self:GetChild("Char/Cell/SkillImg")
  self._yardSkillDescribe = self:GetChild("Char/Cell/SkillDetail")
  self._alchemyCount = self:GetChild("Num/Num")
  self._reduceBtn = self:GetChild("Num/MinusBtn")
  self._minBtn = self:GetChild("Num/MinBtn")
  self._addBtn = self:GetChild("Num/AddBtn")
  self._maxBtn = self:GetChild("Num/MaxBtn")
  self._alchemyBtn = self:GetChild("StartBtn")
  self._effectPanel = self:GetChild("Effect")
  ;
  (StateEventTriggerHelper.AddStateExitListener)((self._effectPanel)._uiObject, self.OnAnimationExit, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._mainProductPanel):Subscribe_PointerClickEvent(self.OnMainProductPanelClicked, self)
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_1 , upvalues : self
    self:OnNumBtnClicked(-1)
  end
)
  ;
  (self._reduceBtn):Subscribe_BeginLongPressEvent(function()
    -- function num : 0_3_2 , upvalues : self
    self:OnBeginLongPressNumBtn(-1)
  end
)
  ;
  (self._reduceBtn):Subscribe_EndLongPressEvent(function()
    -- function num : 0_3_3 , upvalues : self
    self:OnEndLongPressNumBtn(-1)
  end
)
  ;
  (self._reduceBtn):Subscribe_CancelLongPressEvent(function()
    -- function num : 0_3_4 , upvalues : self
    self:OnCancelLongPressNumBtn(-1)
  end
)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_5 , upvalues : self
    self:OnNumBtnClicked(1)
  end
)
  ;
  (self._addBtn):Subscribe_BeginLongPressEvent(function()
    -- function num : 0_3_6 , upvalues : self
    self:OnBeginLongPressNumBtn(1)
  end
)
  ;
  (self._addBtn):Subscribe_EndLongPressEvent(function()
    -- function num : 0_3_7 , upvalues : self
    self:OnEndLongPressNumBtn(1)
  end
)
  ;
  (self._addBtn):Subscribe_CancelLongPressEvent(function()
    -- function num : 0_3_8 , upvalues : self
    self:OnCancelLongPressNumBtn(1)
  end
)
  ;
  (self._minBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_9 , upvalues : self
    self:OnMinOrMaxBtnClicked(-1)
  end
)
  ;
  (self._maxBtn):Subscribe_PointerClickEvent(function()
    -- function num : 0_3_10 , upvalues : self
    self:OnMinOrMaxBtnClicked(1)
  end
)
  ;
  (self._alchemyBtn):Subscribe_PointerClickEvent(self.OnAlchemyBtnClicked, self)
  ;
  (self._char):Subscribe_PointerClickEvent(self.OnCharClicked, self)
  ;
  (self._ibtn):Subscribe_PointerClickEvent(self.OnIBtnClick, self)
  ;
  (self._downArrowBtn):Subscribe_PointerClickEvent(self.OnDownArrowBtnClicked, self)
  ;
  (self._alchemyStageDetailPanel_arrowBtn):Subscribe_PointerClickEvent(self.CloseAlchemyDetailPanel, self)
  ;
  (self._levelBack):Subscribe_PointerClickEvent(self.OpenLvUpDetailDialog, self)
  ;
  (self._loadingClickPanel):Subscribe_PointerClickEvent(self.OpenLvUpDetailDialog, self)
  self._alchemyStageDetailPanel_effectFrame = (TableFrame.Create)(self._alchemyStageDetailPanel_effectPanel, self, true, false, true)
  self._alchemyStageDetailPanel_x = (self._alchemyStageDetailPanel):GetSize()
  self._alchemyStageDetailPanel_effectPanelWidth = (self._alchemyStageDetailPanel_effectPanel):GetDeltaSize()
  self._alchemyStageDetailPanelWidth = (self._alchemyStageDetailPanel):GetDeltaSize()
  self:LoadLocalData()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.LoadLocalData, Common.n_AlchemyRoleChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshAlchemy, Common.n_RefreshAlchemy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleGuideStatusChanged, Common.n_GuideStatusChanged, nil)
end

AlchemyDialog.OnDestroy = function(self)
  -- function num : 0_4 , upvalues : _ENV
  (self._alchemyStageDetailPanel_effectFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("alchemy.chooseformuladialog")
  ;
  (DialogManager.DestroySingletonDialog)("magictree.chooseroledialog")
  ;
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  ;
  (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  ;
  (DialogManager.DestroySingletonDialog)("alchemy.alchemystagedialog")
  if self._courtyardSceneController then
    (self._courtyardSceneController):SetCameraAnimatorState(0)
  end
end

AlchemyDialog.Init = function(self, sceneController)
  -- function num : 0_5 , upvalues : _ENV
  self._courtyardSceneController = sceneController
  ;
  (LuaNotificationCenter.PostNotification)(Common.n_TriggerGuide, self, nil)
end

local RefreshAlchemyDetailPanel = function(self)
  -- function num : 0_6 , upvalues : _ENV, CAlchemyStageCfg, CAlchemyStageEffectsCfg
  if self._showAlchemyDetailPanel then
    (self._downArrowBtn):SetActive(false)
    ;
    (self._alchemyStageDetailPanel):SetActive(true)
    local alchemyStage = ((NekoData.BehaviorManager).BM_Alchemy):GetAlchemyStage()
    local curStageRecorder = CAlchemyStageCfg:GetRecorder(alchemyStage)
    ;
    (self._alchemyStageDetailPanel_Title):SetText((TextManager.GetText)(curStageRecorder.stagenametxtid))
    local alchemyEffectRecorder = CAlchemyStageEffectsCfg:GetRecorder(curStageRecorder.stageeffects)
    if alchemyStage <= 1 then
      (self._alchemyStageDetailPanel_effectEmpty):SetActive(true)
      ;
      (self._alchemyStageDetailPanel_effectPanel):SetActive(false)
    else
      ;
      (self._alchemyStageDetailPanel_effectEmpty):SetActive(false)
      ;
      (self._alchemyStageDetailPanel_effectPanel):SetActive(true)
      self._alchemyStageEffects = {}
      local allIds = CAlchemyStageCfg:GetAllIds()
      for i = 1, #allIds do
        local recorder = CAlchemyStageCfg:GetRecorder(allIds[i])
        if recorder.id <= alchemyStage then
          local effectRecorder = CAlchemyStageEffectsCfg:GetRecorder(recorder.stageeffects)
          if effectRecorder then
            (table.insert)(self._alchemyStageEffects, effectRecorder)
          else
            LogInfoFormat("AlchemyDialog", "Cannot find record(effectId: %s, stageId: %s) in CAlchemyStageEffectsCfg", recorder.stageeffects, recorder.id)
          end
        else
          break
        end
      end
      do
        ;
        (self._alchemyStageDetailPanel_effectFrame):ReloadAllCell()
        do
          local length = (self._alchemyStageDetailPanel_effectFrame):GetTotalLength()
          ;
          (self._alchemyStageDetailPanel_effectPanel):SetDeltaSize(self._alchemyStageDetailPanel_effectPanelWidth, length)
          ;
          (self._alchemyStageDetailPanel):SetDeltaSize(self._alchemyStageDetailPanelWidth, self._alchemyStageDetailPanelHeight - self._alchemyStageDetailPanel_effectPanelHeight + length)
          ;
          (self._alchemyStageDetailPanel_effectFrame):MoveToTop()
          ;
          (self._downArrowBtn):SetActive(true)
          ;
          (self._alchemyStageDetailPanel):SetActive(false)
        end
      end
    end
  end
end

local RefreshAlchemyStagePoint = function(self)
  -- function num : 0_7 , upvalues : _ENV, MaxAlchemyStage
  local alchemyStage = ((NekoData.BehaviorManager).BM_Alchemy):GetAlchemyStage() - 1
  local pointStr = ""
  for i = 1, MaxAlchemyStage do
    if i <= alchemyStage then
      pointStr = pointStr .. "1"
    else
      pointStr = pointStr .. "0"
    end
  end
  ;
  (self._alchemyStagePoint):SetText(pointStr)
end

AlchemyDialog.OnRefreshAlchemy = function(self)
  -- function num : 0_8 , upvalues : _ENV, CAlchemyLvCfg, CAlchemyFormulaCfg, RefreshAlchemyDetailPanel, RefreshAlchemyStagePoint
  local buildingLevel = ((NekoData.BehaviorManager).BM_Alchemy):GetLevel()
  ;
  (self._level):SetText(buildingLevel)
  self._alchemyLevel = ((NekoData.BehaviorManager).BM_Alchemy):GetAlchemyLevel()
  self._alchemyRecord = CAlchemyLvCfg:GetRecorder(self._alchemyLevel)
  self._curAlchemyExp = ((NekoData.BehaviorManager).BM_Alchemy):GetAlchemyExp()
  self._formulaRecord = CAlchemyFormulaCfg:GetRecorder(self._formulaId)
  self:RefreshFormulaPanel()
  if self:IsMaterialsSufficient(1) then
    self._formulaNum = 1
  else
    self._formulaNum = 0
  end
  self:RefreshAlchemyLevelAndExp()
  self:RefreshCharPanel()
  self:RefreshYardSkill()
  self:RefreshOperatePanel()
  RefreshAlchemyDetailPanel(self)
  RefreshAlchemyStagePoint(self)
end

AlchemyDialog.LoadLocalData = function(self)
  -- function num : 0_9 , upvalues : _ENV, CAlchemyLvCfg, CAlchemyFormulaCfg, RefreshAlchemyStagePoint
  local buildingLevel = ((NekoData.BehaviorManager).BM_Alchemy):GetLevel()
  ;
  (self._level):SetText(buildingLevel)
  self._alchemyLevel = ((NekoData.BehaviorManager).BM_Alchemy):GetAlchemyLevel()
  self._alchemyRecord = CAlchemyLvCfg:GetRecorder(self._alchemyLevel)
  self._curAlchemyExp = ((NekoData.BehaviorManager).BM_Alchemy):GetAlchemyExp()
  if self._formulaId then
    self._formulaRecord = CAlchemyFormulaCfg:GetRecorder(self._formulaId)
  else
    self._formulaRecord = nil
    self._formulaNum = 0
  end
  self:RefreshAlchemyLevelAndExp()
  self:RefreshFormulaPanel()
  self:RefreshCharPanel()
  self:RefreshYardSkill()
  self:RefreshOperatePanel()
  RefreshAlchemyStagePoint(self)
end

AlchemyDialog.RefreshAlchemyLevelAndExp = function(self)
  -- function num : 0_10 , upvalues : CAlchemyLvCfg, _ENV, CStringRes
  (self._alchemyLevelTxt):SetText(self._alchemyLevel)
  local allIds = CAlchemyLvCfg:GetAllIds()
  local length = #allIds
  ;
  (self._curProgress):SetActive(true)
  if self._alchemyLevel == length then
    (self._normal):SetActive(false)
    ;
    (self._max):SetActive(true)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1163)).msgTextID)
    ;
    (self._max):SetText(str)
    ;
    (self._curProgress):SetFillAmount(0)
    ;
    (self._lvUpIcon):SetActive(false)
  else
    do
      if self._formulaRecord then
        local addExp = (self._formulaRecord).getExp * self._formulaNum
        local nextAlchemyLevelExp = self._curAlchemyExp + addExp
        local nextAlchemyLevel = self._alchemyLevel
        local nextAlchemyLevelMaxExp = (self._alchemyRecord).exp
        ;
        (self._curProgress):SetFillAmount(nextAlchemyLevelExp / (self._alchemyRecord).exp)
        for i = 1, length do
          if self._alchemyLevel <= i then
            local recorder = CAlchemyLvCfg:GetRecorder(i)
            if recorder.exp <= nextAlchemyLevelExp then
              if i < length then
                nextAlchemyLevelExp = nextAlchemyLevelExp - recorder.exp
                nextAlchemyLevel = i + 1
              else
                nextAlchemyLevelExp = 0
                nextAlchemyLevel = length
              end
            else
              break
            end
          end
        end
        do
          if self._alchemyLevel < nextAlchemyLevel then
            if nextAlchemyLevel == length then
              (self._normal):SetActive(false)
              ;
              (self._max):SetActive(true)
              local str = (TextManager.GetText)((CStringRes:GetRecorder(1163)).msgTextID)
              ;
              (self._max):SetText(str)
            else
              do
                do
                  ;
                  (self._normal):SetActive(true)
                  ;
                  (self._max):SetActive(false)
                  ;
                  (self._curExp):SetText(self._curAlchemyExp + addExp)
                  ;
                  (self._maxExp):SetText((self._alchemyRecord).exp)
                  ;
                  (self._addExp):SetActive(true)
                  ;
                  (self._addExp):SetText((string.gsub)((TextManager.GetText)(800131), "%$parameter1%$", addExp))
                  ;
                  (self._normal):SetActive(true)
                  ;
                  (self._max):SetActive(false)
                  ;
                  (self._curExp):SetText(self._curAlchemyExp + addExp)
                  ;
                  (self._maxExp):SetText((self._alchemyRecord).exp)
                  ;
                  (self._addExp):SetActive(true)
                  ;
                  (self._addExp):SetText((string.gsub)((TextManager.GetText)(800131), "%$parameter1%$", addExp))
                  ;
                  (self._normal):SetActive(true)
                  ;
                  (self._max):SetActive(false)
                  ;
                  (self._curProgress):SetFillAmount(self._curAlchemyExp / (self._alchemyRecord).exp)
                  ;
                  (self._curExp):SetText(self._curAlchemyExp)
                  ;
                  (self._maxExp):SetText((self._alchemyRecord).exp)
                  ;
                  (self._addExp):SetActive(false)
                  ;
                  (self._lvUpIcon):SetActive((self._alchemyRecord).exp <= self._curAlchemyExp)
                  -- DECOMPILER ERROR: 2 unprocessed JMP targets
                end
              end
            end
          end
        end
      end
    end
  end
end

AlchemyDialog.RefreshFormulaPanel = function(self)
  -- function num : 0_11 , upvalues : _ENV, Item, CAlchemyPicRes, CImagePathTable, MaterialMaxNum
  while (self._materials)[#self._materials] do
    (table.remove)(self._materials, #self._materials)
  end
  for k,v in pairs(self._materialsCostAndStock) do
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R6 in 'UnsetPending'

    (self._materialsCostAndStock)[k] = nil
  end
  if self._formulaRecord then
    (self._mainProductAdd):SetActive(false)
    ;
    (self._mainProductItem):SetActive(true)
    self._mainProduct = (Item.Create)((self._formulaRecord).outcome)
    local alchemyPicResRecord = CAlchemyPicRes:GetRecorder((self._mainProduct):GetPinJiID())
    if not CImagePathTable:GetRecorder(alchemyPicResRecord.alchemypageframe) then
      local imageRecord = DataCommon.DefaultImageAsset
    end
    ;
    (self._mainProductFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = (self._mainProduct):GetIcon()
    ;
    (self._mainProductIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._mainProductNum):SetText((self._formulaRecord).outcomeNum)
    local materialNum = #(self._formulaRecord).items
    for i = 1, materialNum do
      local panel = nil
      if materialNum == 1 then
        panel = (self._materialPanels)[2]
      else
        panel = (self._materialPanels)[i]
      end
      ;
      (panel.item):SetActive(true)
      local itemId = ((self._formulaRecord).items)[i]
      local item = (Item.Create)(itemId)
      ;
      (table.insert)(self._materials, item)
      local cost = ((self._formulaRecord).num)[i]
      local stock = 0
      if (string.sub)(itemId, 1, 2) == "35" then
        stock = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(itemId)
      else
        stock = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(itemId)
      end
      alchemyPicResRecord = CAlchemyPicRes:GetRecorder(item:GetPinJiID())
      if not CImagePathTable:GetRecorder(alchemyPicResRecord.alchemypageframe) then
        imageRecord = DataCommon.DefaultImageAsset
      end
      ;
      (panel.frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = item:GetIcon()
      ;
      (panel.icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      if stock < cost then
        (panel.num):SetActive(false)
        ;
        (panel.numRed):SetActive(true)
        ;
        (panel.numRed):SetText(cost)
      else
        ;
        (panel.num):SetActive(true)
        ;
        (panel.numRed):SetActive(false)
        ;
        (panel.num):SetText(cost)
      end
      -- DECOMPILER ERROR at PC185: Confused about usage of register: R13 in 'UnsetPending'

      ;
      (self._materialsCostAndStock)[itemId] = {cost = cost, stock = stock}
    end
    if materialNum == 1 then
      for i = 1, MaterialMaxNum do
        (((self._materialPanels)[i]).item):SetActive(i == 2)
      end
    else
      for i = materialNum + 1, MaterialMaxNum do
        (((self._materialPanels)[i]).item):SetActive(false)
      end
    end
  else
    (self._mainProductAdd):SetActive(true)
    ;
    (self._mainProductItem):SetActive(false)
    self._mainProduct = nil
    for i = 1, MaterialMaxNum do
      (((self._materialPanels)[i]).item):SetActive(false)
    end
  end
  -- DECOMPILER ERROR: 4 unprocessed JMP targets
end

AlchemyDialog.RefreshCharCostEnergy = function(self)
  -- function num : 0_12 , upvalues : invalidImgRecord, _ENV, inapplicableImgRecord
  if self._role then
    local restEnergy = (self._role):GetEnergy()
    local isUseful, yardSkillAlchemyRecord = self:IsRoleSkillUseful()
    if self._formulaRecord then
      local cost = (self._formulaRecord).emotionCost * self._formulaNum
      if cost <= restEnergy then
        (self._charCostEnergy):SetActive(true)
        ;
        (self._charCostEnergyRed):SetActive(false)
        ;
        (self._charCostEnergy):SetText("-" .. cost)
        if restEnergy <= 0 then
          (self._charGrey):SetActive(true)
          ;
          (self._charEnergyLessThan0):SetActive(true)
          if isUseful then
            (self._charEnergyLessThan0_img):SetSprite(invalidImgRecord.assetBundle, invalidImgRecord.assetName)
          end
          ;
          (self._charEnergyLessThan0_txt):SetText((TextManager.GetText)(800124))
        else
          ;
          (self._charGrey):SetActive(false)
          ;
          (self._charEnergyLessThan0):SetActive(false)
        end
      else
        ;
        (self._charCostEnergy):SetActive(false)
        ;
        (self._charCostEnergyRed):SetActive(true)
        if cost > 99 then
          cost = 99
        end
        ;
        (self._charCostEnergyRed):SetText("-" .. cost)
        ;
        (self._charEnergyLessThan0):SetActive(true)
        if isUseful then
          (self._charEnergyLessThan0_img):SetSprite(invalidImgRecord.assetBundle, invalidImgRecord.assetName)
        end
        ;
        (self._charGrey):SetActive(true)
        if restEnergy <= 0 then
          (self._charEnergyLessThan0_txt):SetText((TextManager.GetText)(800124))
        else
          ;
          (self._charEnergyLessThan0_txt):SetText((TextManager.GetText)(800125))
        end
      end
      if not isUseful then
        (self._charEnergyLessThan0_img):SetSprite(inapplicableImgRecord.assetBundle, inapplicableImgRecord.assetName)
      end
    else
      do
        ;
        (self._charCostEnergy):SetActive(true)
        ;
        (self._charCostEnergyRed):SetActive(false)
        ;
        (self._charCostEnergy):SetText("0")
        ;
        (self._charEnergyLessThan0):SetActive(false)
        if restEnergy <= 0 then
          (self._charGrey):SetActive(true)
        else
          ;
          (self._charGrey):SetActive(false)
        end
        if not isUseful then
          (self._charGrey):SetActive(false)
        end
      end
    end
  end
end

AlchemyDialog.RefreshCharPanel = function(self)
  -- function num : 0_13 , upvalues : _ENV
  self._role = nil
  local roleKey = (((NekoData.BehaviorManager).BM_Alchemy):GetDispatchRoles())[1]
  if roleKey then
    self._role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
  end
  if self._role then
    (self._charAddPanel):SetActive(false)
    ;
    (self._charNormalPanel):SetActive(true)
    local restEnergy = (math.floor)((self._role):GetEnergy())
    local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetImgRecordByEnergy(restEnergy)
    if imgRecord then
      (self._charCellMoodIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      LogError("imgRecord is nil.")
    end
    self:RefreshCharCostEnergy()
    ;
    (self._charName):SetText((self._role):GetRoleName())
    imgRecord = (self._role):GetSmallRarityBackRecord()
    ;
    (self._charBack):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    imgRecord = (self._role):GetShapeLittleHeadImageRecord()
    ;
    (self._charPhoto):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    imgRecord = (self._role):GetSmallRarityFrameRecord()
    ;
    (self._charFrame):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    if DataCommon.TotalEnergy <= restEnergy then
      (self._charEnergyProgressFull):SetActive(true)
      ;
      (self._charEnergyProgress):SetActive(false)
      ;
      (self._charEnergyProgressFull):SetFillAmount(1)
    else
      ;
      (self._charEnergyProgressFull):SetActive(false)
      ;
      (self._charEnergyProgress):SetActive(true)
      ;
      (self._charEnergyProgress):SetFillAmount(restEnergy / DataCommon.TotalEnergy)
    end
    ;
    (self._charEnergyTxt):SetText(restEnergy .. "/" .. DataCommon.TotalEnergy)
  else
    do
      ;
      (self._charAddPanel):SetActive(true)
      ;
      (self._charNormalPanel):SetActive(false)
    end
  end
end

local ByProduct = function(self)
  -- function num : 0_14 , upvalues : CAlchemyFormulaTypeCfg
  do
    if self._formulaRecord then
      local alchemyFormulaTypeRecord = CAlchemyFormulaTypeCfg:GetRecorder((self._formulaRecord).type)
      if alchemyFormulaTypeRecord.byproduct == 1 then
        return true
      end
    end
    return false
  end
end

AlchemyDialog.IsRoleSkillUseful = function(self)
  -- function num : 0_15 , upvalues : _ENV, CYardSkillCfg
  local isUseful = false
  local yardSkillAlchemyRecord = nil
  do
    if self._role then
      local yardSkillList = (self._role):GetYardSkillList()
      for i,v in ipairs(yardSkillList) do
        if not yardSkillAlchemyRecord then
          do
            local yardSkillRecord = CYardSkillCfg:GetRecorder(v)
            if yardSkillRecord.functionID == DataCommon.Alchemy then
              yardSkillAlchemyRecord = yardSkillRecord
              if self._formulaRecord then
                local alchemyTypeList = (string.split)(yardSkillRecord.alchemyType, ";")
                for i,v in ipairs(alchemyTypeList) do
                  local type = tonumber(v)
                  if type == (self._formulaRecord).type then
                    isUseful = true
                    break
                  end
                end
              else
                break
              end
            end
            -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC49: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
    return isUseful, yardSkillAlchemyRecord
  end
end

AlchemyDialog.RefreshYardSkill = function(self)
  -- function num : 0_16 , upvalues : _ENV, CImagePathTable, CStringRes, ByProduct, CAlchemyStageEffectsCfg
  local roleAddRateStr = nil
  if self._role then
    local isUseful, yardSkillAlchemyRecord = self:IsRoleSkillUseful()
    ;
    (self._yardSkillName):SetActive(true)
    if yardSkillAlchemyRecord then
      (self._yardSkillDescribe):SetActive(true)
      ;
      (self._yardSkillName):SetText((TextManager.GetText)(yardSkillAlchemyRecord.nameTextID))
      ;
      (self._yardSkillDescribe):SetText((TextManager.GetText)(yardSkillAlchemyRecord.descTextID))
      ;
      (self._yardSkillIcon):SetActive(true)
      local imgRecord = CImagePathTable:GetRecorder(yardSkillAlchemyRecord.image)
      ;
      (self._yardSkillIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      do
        do
          do
            local str = (TextManager.GetText)((CStringRes:GetRecorder(1211)).msgTextID)
            ;
            (self._yardSkillName):SetText(str)
            ;
            (self._yardSkillDescribe):SetActive(false)
            ;
            (self._yardSkillIcon):SetActive(false)
            if isUseful and (math.floor)((self._role):GetEnergy()) > 0 then
              roleAddRateStr = yardSkillAlchemyRecord.alchemyProbability .. "%%"
            end
            ;
            (self._yardSkillName):SetActive(false)
            ;
            (self._yardSkillIcon):SetActive(false)
            ;
            (self._yardSkillDescribe):SetActive(false)
            if ByProduct(self) then
              if roleAddRateStr then
                local alchemyStage = ((NekoData.BehaviorManager).BM_Alchemy):GetAlchemyStage()
                local effectStr = ""
                do
                  if alchemyStage - 1 >= 2 then
                    local alchemyEffectRecorder = CAlchemyStageEffectsCfg:GetRecorder(2)
                    effectStr = (TextManager.GetText)(800129)
                    effectStr = (string.gsub)(effectStr, "%$parameter1%$", alchemyEffectRecorder.stageeffectparameter1 / 10)
                  end
                  do
                    local roleAddRateString = (string.gsub)((TextManager.GetText)(800137), "%$parameter1%$", roleAddRateStr)
                    ;
                    (self._rateTxt):SetText((self._alchemyRecord).byproductProbability .. "%" .. roleAddRateString .. effectStr)
                    ;
                    (self._rateTxt):SetText((self._alchemyRecord).byproductProbability .. "%")
                    ;
                    (self._rateTxt):SetText("0%")
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

AlchemyDialog.RefreshOperatePanel = function(self)
  -- function num : 0_17
  if self._formulaRecord then
    if self._formulaNum < 1 then
      (self._alchemyBtn):SetInteractable(false)
      ;
      (self._reduceBtn):SetInteractable(false)
      ;
      (self._minBtn):SetInteractable(false)
      ;
      (self._addBtn):SetInteractable(true)
      ;
      (self._maxBtn):SetInteractable(true)
    else
      ;
      (self._alchemyBtn):SetInteractable(true)
      ;
      (self._addBtn):SetInteractable(true)
      ;
      (self._maxBtn):SetInteractable(true)
      if self._formulaNum == 1 then
        (self._reduceBtn):SetInteractable(false)
        ;
        (self._minBtn):SetInteractable(false)
      else
        ;
        (self._reduceBtn):SetInteractable(true)
        ;
        (self._minBtn):SetInteractable(true)
      end
    end
  else
    ;
    (self._alchemyBtn):SetInteractable(false)
    ;
    (self._reduceBtn):SetInteractable(false)
    ;
    (self._minBtn):SetInteractable(false)
    ;
    (self._addBtn):SetInteractable(false)
    ;
    (self._maxBtn):SetInteractable(false)
  end
  ;
  (self._alchemyCount):SetText(self._formulaNum)
end

AlchemyDialog.IsMaterialsSufficient = function(self, num)
  -- function num : 0_18 , upvalues : _ENV
  for k,v in pairs(self._materialsCostAndStock) do
    if v.stock < v.cost * num then
      return false
    end
  end
  return true
end

AlchemyDialog.ChooseFormula = function(self, formulaId)
  -- function num : 0_19 , upvalues : CAlchemyFormulaCfg
  self._formulaId = formulaId
  self._formulaRecord = CAlchemyFormulaCfg:GetRecorder(self._formulaId)
  self._formulaNum = 1
  self:RefreshOperatePanel()
  self:RefreshAlchemyLevelAndExp()
  self:RefreshFormulaPanel()
  self:RefreshCharCostEnergy()
  self:RefreshYardSkill()
end

AlchemyDialog.OnMaterialClicked = function(self, index)
  -- function num : 0_20 , upvalues : _ENV
  local materialNum = #(self._formulaRecord).items
  local materialIndex = index
  if materialNum == 1 then
    materialIndex = 1
  end
  local width, height = (((self._materialPanels)[index]).item):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._materials)[materialIndex]})
    tipsDialog:SetTipsPosition(width, height, (((self._materialPanels)[index]).item):GetLocalPointInUiRootPanel())
  end
end

AlchemyDialog.OnMainProductPanelClicked = function(self)
  -- function num : 0_21 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("alchemy.chooseformuladialog")):SetFormulaId(self._formulaId)
end

AlchemyDialog.OnNumBtnClicked = function(self, value)
  -- function num : 0_22 , upvalues : _ENV
  if value < 0 then
    self._formulaNum = self._formulaNum + value
    self:RefreshAlchemyLevelAndExp()
    self:RefreshCharCostEnergy()
    self:RefreshOperatePanel()
  else
    if self:IsMaterialsSufficient(self._formulaNum + value) then
      self._formulaNum = self._formulaNum + value
      self:RefreshAlchemyLevelAndExp()
      self:RefreshCharCostEnergy()
      self:RefreshOperatePanel()
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100167)
    end
  end
end

AlchemyDialog.OnMinOrMaxBtnClicked = function(self, value)
  -- function num : 0_23 , upvalues : _ENV
  if value < 0 then
    self._formulaNum = 1
    self:RefreshAlchemyLevelAndExp()
    self:RefreshCharCostEnergy()
    self:RefreshOperatePanel()
  else
    local map = {}
    for k,v in pairs(self._materialsCostAndStock) do
      map[k] = (math.floor)(v.stock / v.cost)
    end
    local num = nil
    for k,v in pairs(map) do
      if not num then
        num = v
      else
        if v < num then
          num = v
        end
      end
    end
    if self._formulaNum ~= num then
      self._formulaNum = num
      self:RefreshAlchemyLevelAndExp()
      self:RefreshCharCostEnergy()
      self:RefreshOperatePanel()
    end
  end
end

AlchemyDialog.OnBeginLongPressNumBtn = function(self, value)
  -- function num : 0_24 , upvalues : _ENV
  self._formulaNumPre = self._formulaNum
  self._longPressOperate = value
  self._beginLongPressTime = (ServerGameTimer.GetServerTimeForecast)()
end

AlchemyDialog.OnEndLongPressNumBtn = function(self)
  -- function num : 0_25 , upvalues : _ENV, speed
  if self._beginLongPressTime then
    local longPressDeltaTime = ((ServerGameTimer.GetServerTimeForecast)() - self._beginLongPressTime) / 1000
    self._beginLongPressTime = nil
    local deltaFormulaNum = (math.floor)(self._longPressOperate * longPressDeltaTime * speed)
    local formulaNum = self._formulaNumPre + deltaFormulaNum
    if formulaNum ~= self._formulaNum then
      if self._longPressOperate < 0 then
        if formulaNum <= 1 then
          self._formulaNum = 1
        else
          self._formulaNum = formulaNum
        end
        self:RefreshAlchemyLevelAndExp()
        self:RefreshCharCostEnergy()
        self:RefreshOperatePanel()
      else
        if self:IsMaterialsSufficient(formulaNum) then
          self._formulaNum = formulaNum
          self:RefreshAlchemyLevelAndExp()
          self:RefreshCharCostEnergy()
          self:RefreshOperatePanel()
        else
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100167)
        end
      end
    end
  end
end

AlchemyDialog.OnCancelLongPressNumBtn = function(self)
  -- function num : 0_26 , upvalues : _ENV, speed
  if self._beginLongPressTime then
    local longPressDeltaTime = ((ServerGameTimer.GetServerTimeForecast)() - self._beginLongPressTime) / 1000
    self._beginLongPressTime = nil
    local deltaFormulaNum = (math.floor)(self._longPressOperate * longPressDeltaTime * speed)
    local formulaNum = self._formulaNumPre + deltaFormulaNum
    if formulaNum ~= self._formulaNum then
      if self._longPressOperate < 0 then
        if formulaNum <= 1 then
          self._formulaNum = 1
        else
          self._formulaNum = formulaNum
        end
        self:RefreshAlchemyLevelAndExp()
        self:RefreshCharCostEnergy()
        self:RefreshOperatePanel()
      else
        if self:IsMaterialsSufficient(formulaNum) then
          self._formulaNum = formulaNum
          self:RefreshAlchemyLevelAndExp()
          self:RefreshCharCostEnergy()
          self:RefreshOperatePanel()
        else
          ;
          ((NekoData.BehaviorManager).BM_Message):SendMessageById(100167)
        end
      end
    end
  end
end

AlchemyDialog.OnUpdate = function(self, notification)
  -- function num : 0_27 , upvalues : _ENV, speed
  if self._beginLongPressTime then
    local longPressDeltaTime = ((ServerGameTimer.GetServerTimeForecast)() - self._beginLongPressTime) / 1000
    local deltaFormulaNum = (math.floor)(self._longPressOperate * longPressDeltaTime * speed)
    local formulaNum = self._formulaNumPre + deltaFormulaNum
    if self._longPressOperate < 0 then
      if formulaNum <= 1 then
        self:OnEndLongPressNumBtn()
      else
        self._formulaNum = formulaNum
        self:RefreshAlchemyLevelAndExp()
        self:RefreshCharCostEnergy()
        self:RefreshOperatePanel()
      end
    else
      if self:IsMaterialsSufficient(formulaNum) then
        self._formulaNum = formulaNum
        self:RefreshAlchemyLevelAndExp()
        self:RefreshCharCostEnergy()
        self:RefreshOperatePanel()
      else
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100167)
        self._beginLongPressTime = nil
      end
    end
  end
end

AlchemyDialog.OnAlchemyBtnClicked = function(self)
  -- function num : 0_28 , upvalues : AnimationHelper, _ENV
  local materialNum = #(self._formulaRecord).items
  if materialNum == 1 then
    (AnimationHelper.SetAnimatorTrigger2)((self._effectPanel)._uiObject, "single")
  else
    ;
    (AnimationHelper.SetAnimatorTrigger2)((self._effectPanel)._uiObject, "triple")
  end
  ;
  (DialogManager.CreateSingletonDialog)("guide.blockclickdialog")
end

AlchemyDialog.OnCharClicked = function(self)
  -- function num : 0_29 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("magictree.chooseroledialog")
  if dialog then
    dialog:Init(nil, DataCommon.Alchemy)
  end
end

AlchemyDialog.OnAnimationExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_30 , upvalues : _ENV
  if stateName == "UI_TX_LianJin_1ge" or stateName == "UI_TX_LianJin" then
    local cstartAlchemy = (LuaNetManager.CreateProtocol)("protocol.yard.cstartalchemy")
    cstartAlchemy.formulaId = self._formulaId
    cstartAlchemy.formulaNum = self._formulaNum
    cstartAlchemy:Send()
    ;
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
  end
end

AlchemyDialog.OnIBtnClick = function(self)
  -- function num : 0_31 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("alchemy.alchemystagedialog")
end

AlchemyDialog.OnDownArrowBtnClicked = function(self)
  -- function num : 0_32 , upvalues : RefreshAlchemyDetailPanel
  self._showAlchemyDetailPanel = true
  RefreshAlchemyDetailPanel(self)
end

AlchemyDialog.CloseAlchemyDetailPanel = function(self)
  -- function num : 0_33 , upvalues : RefreshAlchemyDetailPanel
  self._showAlchemyDetailPanel = false
  RefreshAlchemyDetailPanel(self)
end

AlchemyDialog.OpenLvUpDetailDialog = function(self)
  -- function num : 0_34 , upvalues : _ENV
  if (self._lvUpIcon):IsActive() then
    (DialogManager.CreateSingletonDialog)("alchemy.alchemylvupdetaildialog")
  end
end

AlchemyDialog.NumberOfCell = function(self, frame)
  -- function num : 0_35
  return #self._alchemyStageEffects
end

AlchemyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_36
  return "alchemy.alchemyeffectcell"
end

AlchemyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_37
  return (self._alchemyStageEffects)[index]
end

AlchemyDialog.OnIBtnClicked = function(self)
  -- function num : 0_38 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(((DataCommon.LocalTips).GuideOpenInstructionDialog_Alchemy).guideId)
end

AlchemyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_39
  self:Destroy()
end

AlchemyDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_40 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

AlchemyDialog.AddNewModal = function(self)
  -- function num : 0_41
end

return AlchemyDialog

