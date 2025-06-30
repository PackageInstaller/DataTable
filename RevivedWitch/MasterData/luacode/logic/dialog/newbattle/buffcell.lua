-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/buffcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CCbuffConfigTable = (BeanManager.GetTableByName)("buff.ccbuffconfig")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local PlayAnimationDeltaTime = 1.5
local BuffCell = class("BuffCell", Dialog)
BuffCell.AssetBundleName = "ui/layouts.battle"
BuffCell.AssetName = "BuffCell"
BuffCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuffCell
  ((BuffCell.super).Ctor)(self, ...)
  self._playAnimation = false
end

BuffCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._icon = self:GetChild("Buff")
  self._num = self:GetChild("Num/Num")
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
end

BuffCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

BuffCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCbuffConfigTable, CImagePathTable
  self._data = data
  local buffConfigRecord = CCbuffConfigTable:GetRecorder(data.id)
  local imageRecord = CImagePathTable:GetRecorder(buffConfigRecord.iconId)
  if imageRecord then
    (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    ;
    (self._icon):SetSprite("", "")
  end
  if data.num == 1 then
    (self._num):SetActive(false)
  else
    ;
    (self._num):SetActive(true)
    ;
    (self._num):SetText(data.num)
  end
  self._time = 0
end

BuffCell.OnUpdate = function(self)
  -- function num : 0_4 , upvalues : PlayAnimationDeltaTime, _ENV
  local deltaTime = (self._data).counttime / 30 - self._time
  if deltaTime <= PlayAnimationDeltaTime and not self._playAnimation then
    self._playAnimation = true
    ;
    (self:GetRootWindow()):PlayAnimation("BuffCell")
  else
    if PlayAnimationDeltaTime < deltaTime and self._playAnimation then
      self._playAnimation = false
      ;
      (self:GetRootWindow()):PlayAnimation("BuffCellStop")
    end
  end
  self._time = self._time + ((CS.UnityEngine).Time).deltaTime
end

BuffCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5
  if eventName == "RefreshCell" and args.id == (self._data).id then
    self:RefreshCell(args)
  end
end

return BuffCell

