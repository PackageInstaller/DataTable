local Item = require("logic.manager.experimental.types.item")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CurrencyCell = class("CurrencyCell", Dialog)
CurrencyCell.AssetBundleName = "ui/layouts.yard"
CurrencyCell.AssetName = "TopGroupCell"

function CurrencyCell:Ctor(...)
  CurrencyCell.super.Ctor(self, ...)
  self._effectHandler = nil
  self._moneyTask = nil
  self._lastNum = 0
end

function CurrencyCell:OnCreate()
  self._cell = self:GetChild("Num0")
  self._addBtn = self:GetChild("Num0/Add")
  self._icon = self:GetChild("Num0/Icon")
  self._text = self:GetChild("Num0/Text")
  self._effect = self:GetChild("Effect")
  self._redDot = self:GetChild("RedDot")
  self._redDot:SetActive(false)
  self._icon:Subscribe_PointerClickEvent(self.OnCellClick, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function CurrencyCell:OnDestroy()
  if self._effectHandler then
    self._effect:ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function CurrencyCell:RefreshCell(data)
  self._item = Item.Create(data.currecyId)
  local imageRecord = self._item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._lastNum = data.num
  self._maxCapacity = data.maxCapacity
  self._text:SetText(data.num .. "/" .. self._maxCapacity)
  self._addBtn:SetActive(data.canJump)
  if data.num >= self._maxCapacity then
    self:GetRootWindow():PlayAnimation("TopGroupCellAddBtn")
  else
    self:GetRootWindow():PlayAnimation("New State")
  end
end

function CurrencyCell:OnCellClick()
  local width, height = self._cell:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item
    })
    tipsDialog:SetTipsPosition(width, height, self._cell:GetLocalPointInUiRootPanel())
  end
end

function CurrencyCell:OnAddBtnClick()
  local controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  if controller then
    if NekoData.BehaviorManager.BM_Firefly:GetLevel() > 0 then
      if controller._yardFSM:GetCurrentState() == "Init" then
        DialogManager.GetGroup("Modal"):ReturnModalDialog()
        controller:SetCameraAnimatorState(5)
      else
        controller._yardFSM:SetNumber("sceneId", 0)
        controller._yardFSM:SetNumber("cameraAnimatorState", 5)
      end
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100092, {
        CCourtyardLvUpCfg:GetRecorder(DataCommon.Firefly + 1).openCondition
      })
    end
  end
end

function CurrencyCell:OnUpdate(notification)
  if self._moneyTask then
    if self._moneyTask:update(notification.userInfo.deltaTime) then
      if self._effectHandler then
        self._effect:ReleaseEffect(self._effectHandler)
        self._effectHandler = nil
      end
      self._moneyTask = nil
      self._text:SetText(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._cellData.currecyId) .. "/" .. self._maxCapacity)
    else
      self._text:SetText(math.ceil(self._moneyTask.subject.value) .. "/" .. self._maxCapacity)
    end
  end
end

function CurrencyCell:OnEvent(eventName, arg)
  if eventName == "PlayUpEffect" and arg[self._cellData.currecyId] then
    local curNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._cellData.currecyId)
    if curNum > self._lastNum and self._rootWindow:IsAciveInHierarchy() then
      self._moneyTask = Tween.new(0.5, {
        value = self._lastNum
      }, {value = curNum}, "linear")
      self._lastNum = curNum
      if not self._effectHandler then
        self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1026))
      end
      if curNum >= self._maxCapacity then
        self:GetRootWindow():PlayAnimation("TopGroupCellAddBtn")
      else
        self:GetRootWindow():PlayAnimation("New State")
      end
    elseif curNum ~= self._lastNum then
      if self._moneyTask then
        self._moneyTask = nil
      end
      if self._effectHandler then
        self._effect:ReleaseEffect(self._effectHandler)
        self._effectHandler = nil
      end
      self._lastNum = curNum
      self._text:SetText(curNum .. "/" .. self._maxCapacity)
      if curNum >= self._maxCapacity then
        self:GetRootWindow():PlayAnimation("TopGroupCellAddBtn")
      else
        self:GetRootWindow():PlayAnimation("New State")
      end
    elseif self._maxCapacity ~= NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(self._cellData.currecyId) then
      self._maxCapacity = NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(self._cellData.currecyId)
      local str = self._text:GetText()
      local strList = string.split(str, "/")
      if 0 < #strList then
        str = strList[1] .. "/" .. self._maxCapacity
        self._text:SetText(str)
      end
      if tonumber(strList[1]) >= self._maxCapacity then
        self:GetRootWindow():PlayAnimation("TopGroupCellAddBtn")
      else
        self:GetRootWindow():PlayAnimation("New State")
      end
    end
  end
end

return CurrencyCell
