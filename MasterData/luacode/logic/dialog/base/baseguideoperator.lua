local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local PhysicsStaticFunctions = CS.PixelNeko.Lua.PhysicsStaticFunctions
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local SceneObjectClick = CS.PixelNeko.P1.Scene.SceneObjectClick
local BaseGuideOperator = class("BaseGuideOperator", Dialog)
BaseGuideOperator.AssetBundleName = "ui/layouts.guide"
BaseGuideOperator.AssetName = "ClickEffect"

function BaseGuideOperator:Ctor(...)
  BaseGuideOperator.super.Ctor(self, ...)
  self._groupName = "Operation"
  self._effectWindow = nil
  self._effectHandler = 0
  self._gameObject = nil
end

function BaseGuideOperator:OnCreate()
  self._effectWindow = self:GetChild("Effect")
  self._mirrorTips = self:GetChild("Guide1")
  self._springTips = self:GetChild("Guide2")
  self._gateTips = self:GetChild("Guide3")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnWindowClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function BaseGuideOperator:OnDestroy()
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  LuaNotificationCenter.RemoveObserver(self)
end

function BaseGuideOperator:SetSceneController(sceneController)
  self._sceneController = sceneController
end

function BaseGuideOperator:ShowGuideEffect(gameobject, tipsType)
  self._gameObject = gameobject
  local px, py, pz = TransformStaticFunctions.GetPosition(self._gameObject)
  local x, y = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow():GetUIObject(), UIManager.WorldToScreenPointInMargin("BattleMain", px, py, pz))
  self._effectWindow:SetAnchoredPosition(x, y)
  self._mirrorTips:SetActive(false)
  self._springTips:SetActive(false)
  self._gateTips:SetActive(false)
  if self._timer then
    GameTimer.RemoveTask(self._timer)
    self._timer = nil
  end
  self._timer = GameTimer.AddTask(1, 0, function()
    self._timer = nil
    if tipsType == "mirror" then
      self._mirrorTips:SetActive(true)
      self._springTips:SetActive(false)
      self._gateTips:SetActive(false)
    elseif tipsType == "spring" then
      self._mirrorTips:SetActive(false)
      self._springTips:SetActive(true)
      self._gateTips:SetActive(false)
    elseif tipsType == "gate" then
      self._mirrorTips:SetActive(false)
      self._springTips:SetActive(false)
      self._gateTips:SetActive(true)
    end
    if self._effectHandler > 0 then
      self._effectWindow:ReleaseEffect(self._effectHandler)
      self._effectHandler = 0
    end
    self._effectHandler = self._effectWindow:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1002))
  end, nil)
end

function BaseGuideOperator:OnWindowClick(args)
  if self._sceneController then
    self._sceneController:OnClick(args.position)
  end
end

function BaseGuideOperator:OnUpdate(args)
  if self._effectHandler > 0 and self._gameObject then
    local px, py, pz = TransformStaticFunctions.GetPosition(self._gameObject)
    local x, y = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow():GetUIObject(), UIManager.WorldToScreenPointInMargin("BattleMain", px, py, pz))
    self._effectWindow:SetAnchoredPosition(x, y)
  end
end

return BaseGuideOperator
