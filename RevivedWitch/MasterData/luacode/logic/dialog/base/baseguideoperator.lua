-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/base/baseguideoperator.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local PhysicsStaticFunctions = ((CS.PixelNeko).Lua).PhysicsStaticFunctions
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local SceneObjectClick = (((CS.PixelNeko).P1).Scene).SceneObjectClick
local BaseGuideOperator = class("BaseGuideOperator", Dialog)
BaseGuideOperator.AssetBundleName = "ui/layouts.guide"
BaseGuideOperator.AssetName = "ClickEffect"
BaseGuideOperator.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseGuideOperator
  ((BaseGuideOperator.super).Ctor)(self, ...)
  self._groupName = "Operation"
  self._effectWindow = nil
  self._effectHandler = 0
  self._gameObject = nil
end

BaseGuideOperator.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._effectWindow = self:GetChild("Effect")
  self._mirrorTips = self:GetChild("Guide1")
  self._springTips = self:GetChild("Guide2")
  self._gateTips = self:GetChild("Guide3")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnWindowClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

BaseGuideOperator.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BaseGuideOperator.SetSceneController = function(self, sceneController)
  -- function num : 0_3
  self._sceneController = sceneController
end

BaseGuideOperator.ShowGuideEffect = function(self, gameobject, tipsType)
  -- function num : 0_4 , upvalues : TransformStaticFunctions, UIManager, _ENV
  self._gameObject = gameobject
  local px, py, pz = (TransformStaticFunctions.GetPosition)(self._gameObject)
  local x, y = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow()):GetUIObject(), (UIManager.WorldToScreenPointInMargin)("BattleMain", px, py, pz))
  ;
  (self._effectWindow):SetAnchoredPosition(x, y)
  ;
  (self._mirrorTips):SetActive(false)
  ;
  (self._springTips):SetActive(false)
  ;
  (self._gateTips):SetActive(false)
  if self._timer then
    (GameTimer.RemoveTask)(self._timer)
    self._timer = nil
  end
  self._timer = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_4_0 , upvalues : self, tipsType, _ENV
    self._timer = nil
    if tipsType == "mirror" then
      (self._mirrorTips):SetActive(true)
      ;
      (self._springTips):SetActive(false)
      ;
      (self._gateTips):SetActive(false)
    else
      if tipsType == "spring" then
        (self._mirrorTips):SetActive(false)
        ;
        (self._springTips):SetActive(true)
        ;
        (self._gateTips):SetActive(false)
      else
        if tipsType == "gate" then
          (self._mirrorTips):SetActive(false)
          ;
          (self._springTips):SetActive(false)
          ;
          (self._gateTips):SetActive(true)
        end
      end
    end
    if self._effectHandler > 0 then
      (self._effectWindow):ReleaseEffect(self._effectHandler)
      self._effectHandler = 0
    end
    self._effectHandler = (self._effectWindow):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1002))
  end
, nil)
end

BaseGuideOperator.OnWindowClick = function(self, args)
  -- function num : 0_5
  if self._sceneController then
    (self._sceneController):OnClick(args.position)
  end
end

BaseGuideOperator.OnUpdate = function(self, args)
  -- function num : 0_6 , upvalues : TransformStaticFunctions, UIManager
  if self._effectHandler > 0 and self._gameObject then
    local px, py, pz = (TransformStaticFunctions.GetPosition)(self._gameObject)
    local x, y = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow()):GetUIObject(), (UIManager.WorldToScreenPointInMargin)("BattleMain", px, py, pz))
    ;
    (self._effectWindow):SetAnchoredPosition(x, y)
  end
end

return BaseGuideOperator

