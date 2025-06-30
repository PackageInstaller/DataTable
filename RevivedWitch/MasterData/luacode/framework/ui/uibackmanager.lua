-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/ui/uibackmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSUIBackManager = ((CS.PixelNeko).P1).UIBackManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local UIBackManager = {}
UIBackManager._global_count = 0
UIBackManager._color_list = {}
UIBackManager._active = false
UIBackManager.Clear = function()
  -- function num : 0_0 , upvalues : UIBackManager
  UIBackManager._global_count = 0
  UIBackManager._color_list = {}
  UIBackManager._active = false
end

UIBackManager.SetUIBackShow = function(flag)
  -- function num : 0_1 , upvalues : _ENV, UIBackManager, CSUIBackManager, GlobalCameras
  LogInfoFormat("UIBackManager", "flag %s UIBackManager._global_count %s", flag, UIBackManager._global_count)
  if flag then
    UIBackManager._global_count = UIBackManager._global_count + 1
  else
    -- DECOMPILER ERROR at PC19: Confused about usage of register: R1 in 'UnsetPending'

    if (UIBackManager._color_list)[UIBackManager._global_count] then
      (UIBackManager._color_list)[UIBackManager._global_count] = nil
    end
    UIBackManager._global_count = UIBackManager._global_count - 1
    if (UIBackManager._color_list)[UIBackManager._global_count] then
      (CSUIBackManager.SetUIModalBackColor)((UIBackManager._color_list)[UIBackManager._global_count])
    end
  end
  if UIBackManager._global_count > 0 and not UIBackManager._active then
    (CSUIBackManager.SetUIBackActive)(true)
    UIBackManager._active = true
  end
  if UIBackManager._global_count < 0 then
    UIBackManager._global_count = 0
  end
  if UIBackManager._global_count == 0 and UIBackManager._active then
    (CSUIBackManager.SetUIBackActive)(false)
    UIBackManager._active = false
  end
  if (DialogManager.GetDialog)("activity.starmirage1.maindialog") then
    local mainCamera = (GlobalCameras.GetCamera)("Main")
    ;
    (mainCamera.gameObject):SetActive(true)
  end
end

UIBackManager.SetUIModalBackColor = function(color)
  -- function num : 0_2 , upvalues : _ENV, UIBackManager, CSUIBackManager
  LogInfoFormat("UIBackManager", "color %s _global_count %s", color, UIBackManager._global_count)
  if UIBackManager._global_count > 0 then
    (CSUIBackManager.SetUIModalBackColor)(color)
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R1 in 'UnsetPending'

    ;
    (UIBackManager._color_list)[UIBackManager._global_count] = color
  end
end

UIBackManager.SwitchToNext = function()
  -- function num : 0_3 , upvalues : _ENV, UIBackManager, CSUIBackManager
  LogInfoFormat("UIBackManager", "SwitchToNext _global_count %s", UIBackManager._global_count)
  if UIBackManager._global_count > 0 then
    (CSUIBackManager.SwitchToNext)()
  end
end

UIBackManager.IsActive = function()
  -- function num : 0_4 , upvalues : _ENV, UIBackManager
  LogInfoFormat("UIBackManager", "IsActive_active %s _global_count %s", UIBackManager._active, UIBackManager._global_count)
  return UIBackManager._active
end

UIBackManager.SetActive = function(flag)
  -- function num : 0_5 , upvalues : _ENV, UIBackManager, CSUIBackManager, GlobalCameras
  LogInfoFormat("UIBackManager", "SetActive_active %s flag %s _global_count %s", UIBackManager._active, flag, UIBackManager._global_count)
  ;
  (CSUIBackManager.SetUIBackActive)(flag)
  if (DialogManager.GetDialog)("activity.starmirage1.maindialog") then
    local mainCamera = (GlobalCameras.GetCamera)("Main")
    ;
    (mainCamera.gameObject):SetActive(true)
  end
end

return UIBackManager

