-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/buildingunlocknoitemdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CCourtyardNameCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardname")
local BuildingUnlockNoItemDialog = class("BuildingUnlockNoItemDialog", Dialog)
BuildingUnlockNoItemDialog.AssetBundleName = "ui/layouts.yard"
BuildingUnlockNoItemDialog.AssetName = "YardTreeUnLockNoItem"
local HandleHandleStage = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  if userInfo.guideID == 16 then
    if (userInfo.stageRefCountTable)[4] > 0 then
      self._guideTag = true
      local width, height = (self._confirmBtn):GetRectSize()
      local screenPos = (self._confirmBtn):GetLocalPointInUiRootPanel()
      local dialog = (DialogManager.CreateSingletonDialog)("guide.guidedialog")
      dialog:SetGuideId(userInfo.guideID)
      dialog:SetGuidePoint(width, height, screenPos.x, screenPos.y)
    else
      do
        if self._guideTag then
          self._guideTag = false
          ;
          (DialogManager.DestroySingletonDialog)("guide.guidedialog")
        end
      end
    end
  end
end

BuildingUnlockNoItemDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : BuildingUnlockNoItemDialog
  ((BuildingUnlockNoItemDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._taskId = nil
end

BuildingUnlockNoItemDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : _ENV, HandleHandleStage
  self._name = self:GetChild("Title")
  self._time = self:GetChild("Time/Time")
  self._result = self:GetChild("Effect/Txt")
  self._cancelBtn = self:GetChild("CancelBtn")
  self._confirmBtn = self:GetChild("ConfirmBtn")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, HandleHandleStage, Common.n_HandleStage, nil)
end

BuildingUnlockNoItemDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("guide.guidedialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BuildingUnlockNoItemDialog.Init = function(self, taskId)
  -- function num : 0_4 , upvalues : CCourtyardLvUpCfg, _ENV, CCourtyardNameCfg, CStringres
  self._taskId = taskId
  local record = CCourtyardLvUpCfg:GetRecorder(taskId)
  local str = ""
  str = (TextManager.GetText)((CCourtyardNameCfg:GetRecorder(record.functionID)).nameTextID)
  ;
  (self._name):SetText(str)
  local time = record.time * 60
  str = (TextManager.GetText)((CStringres:GetRecorder(1109)).msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", (os.date)("!%H", time))
  str = (string.gsub)(str, "%$parameter2%$", (os.date)("!%M", time))
  str = (string.gsub)(str, "%$parameter3%$", (os.date)("!%S", time))
  ;
  (self._time):SetText(str)
  ;
  (self._result):SetText((TextManager.GetText)(record.unlockEffectTextID))
end

BuildingUnlockNoItemDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

BuildingUnlockNoItemDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_6 , upvalues : CCourtyardLvUpCfg, _ENV
  local record = CCourtyardLvUpCfg:GetRecorder(self._taskId)
  local cstartTreeTask = (LuaNetManager.CreateProtocol)("protocol.yard.cstarttreetask")
  cstartTreeTask.buildId = record.functionID
  cstartTreeTask:Send()
end

return BuildingUnlockNoItemDialog

