-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtyard/currencycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CurrencyCell = class("CurrencyCell", Dialog)
CurrencyCell.AssetBundleName = "ui/layouts.yard"
CurrencyCell.AssetName = "TopGroupCell"
CurrencyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CurrencyCell
  ((CurrencyCell.super).Ctor)(self, ...)
  self._effectHandler = nil
  self._moneyTask = nil
  self._lastNum = 0
end

CurrencyCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._cell = self:GetChild("Num0")
  self._addBtn = self:GetChild("Num0/Add")
  self._icon = self:GetChild("Num0/Icon")
  self._text = self:GetChild("Num0/Text")
  self._effect = self:GetChild("Effect")
  self._redDot = self:GetChild("RedDot")
  ;
  (self._redDot):SetActive(false)
  ;
  (self._icon):Subscribe_PointerClickEvent(self.OnCellClick, self)
  ;
  (self._addBtn):Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

CurrencyCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

CurrencyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item
  self._item = (Item.Create)(data.currecyId)
  local imageRecord = (self._item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._lastNum = data.num
  self._maxCapacity = data.maxCapacity
  ;
  (self._text):SetText(data.num .. "/" .. self._maxCapacity)
  ;
  (self._addBtn):SetActive(data.canJump)
  if self._maxCapacity <= data.num then
    (self:GetRootWindow()):PlayAnimation("TopGroupCellAddBtn")
  else
    ;
    (self:GetRootWindow()):PlayAnimation("New State")
  end
end

CurrencyCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self._cell):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
    tipsDialog:SetTipsPosition(width, height, (self._cell):GetLocalPointInUiRootPanel())
  end
end

CurrencyCell.OnAddBtnClick = function(self)
  -- function num : 0_5 , upvalues : _ENV, CCourtyardLvUpCfg
  local controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  if controller then
    if ((NekoData.BehaviorManager).BM_Firefly):GetLevel() > 0 then
      if (controller._yardFSM):GetCurrentState() == "Init" then
        ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
        controller:SetCameraAnimatorState(5)
      else
        ;
        (controller._yardFSM):SetNumber("sceneId", 0)
        ;
        (controller._yardFSM):SetNumber("cameraAnimatorState", 5)
      end
    else
      ;
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100092, {(CCourtyardLvUpCfg:GetRecorder(DataCommon.Firefly + 1)).openCondition})
    end
  end
end

CurrencyCell.OnUpdate = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  if self._moneyTask then
    if (self._moneyTask):update((notification.userInfo).deltaTime) then
      if self._effectHandler then
        (self._effect):ReleaseEffect(self._effectHandler)
        self._effectHandler = nil
      end
      self._moneyTask = nil
      ;
      (self._text):SetText(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._cellData).currecyId) .. "/" .. self._maxCapacity)
    else
      ;
      (self._text):SetText((math.ceil)(((self._moneyTask).subject).value) .. "/" .. self._maxCapacity)
    end
  end
end

CurrencyCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_7 , upvalues : _ENV
  if eventName == "PlayUpEffect" and arg[(self._cellData).currecyId] then
    local curNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum((self._cellData).currecyId)
    if self._lastNum < curNum and (self._rootWindow):IsAciveInHierarchy() then
      self._moneyTask = (Tween.new)(0.5, {value = self._lastNum}, {value = curNum}, "linear")
      self._lastNum = curNum
      if not self._effectHandler then
        self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1026))
      end
      if self._maxCapacity <= curNum then
        (self:GetRootWindow()):PlayAnimation("TopGroupCellAddBtn")
      else
        ;
        (self:GetRootWindow()):PlayAnimation("New State")
      end
    else
      if curNum ~= self._lastNum then
        if self._moneyTask then
          self._moneyTask = nil
        end
        if self._effectHandler then
          (self._effect):ReleaseEffect(self._effectHandler)
          self._effectHandler = nil
        end
        self._lastNum = curNum
        ;
        (self._text):SetText(curNum .. "/" .. self._maxCapacity)
        if self._maxCapacity <= curNum then
          (self:GetRootWindow()):PlayAnimation("TopGroupCellAddBtn")
        else
          ;
          (self:GetRootWindow()):PlayAnimation("New State")
        end
      else
        if self._maxCapacity ~= ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity((self._cellData).currecyId) then
          self._maxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity((self._cellData).currecyId)
          local str = (self._text):GetText()
          local strList = (string.split)(str, "/")
          if #strList > 0 then
            str = strList[1] .. "/" .. self._maxCapacity
            ;
            (self._text):SetText(str)
          end
          if self._maxCapacity <= tonumber(strList[1]) then
            (self:GetRootWindow()):PlayAnimation("TopGroupCellAddBtn")
          else
            ;
            (self:GetRootWindow()):PlayAnimation("New State")
          end
        end
      end
    end
  end
end

return CurrencyCell

