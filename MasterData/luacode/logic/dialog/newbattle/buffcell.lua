local CCbuffConfigTable = BeanManager.GetTableByName("buff.ccbuffconfig")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local PlayAnimationDeltaTime = 1.5
local BuffCell = class("BuffCell", Dialog)
BuffCell.AssetBundleName = "ui/layouts.battle"
BuffCell.AssetName = "BuffCell"

function BuffCell:Ctor(...)
  BuffCell.super.Ctor(self, ...)
  self._playAnimation = false
end

function BuffCell:OnCreate()
  self._icon = self:GetChild("Buff")
  self._num = self:GetChild("Num/Num")
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
end

function BuffCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BuffCell:RefreshCell(data)
  self._data = data
  local buffConfigRecord = CCbuffConfigTable:GetRecorder(data.id)
  local imageRecord = CImagePathTable:GetRecorder(buffConfigRecord.iconId)
  if imageRecord then
    self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._icon:SetSprite("", "")
  end
  if data.num == 1 then
    self._num:SetActive(false)
  else
    self._num:SetActive(true)
    self._num:SetText(data.num)
  end
  self._time = 0
end

function BuffCell:OnUpdate()
  local deltaTime = self._data.counttime / 30 - self._time
  if deltaTime <= PlayAnimationDeltaTime and not self._playAnimation then
    self._playAnimation = true
    self:GetRootWindow():PlayAnimation("BuffCell")
  elseif deltaTime > PlayAnimationDeltaTime and self._playAnimation then
    self._playAnimation = false
    self:GetRootWindow():PlayAnimation("BuffCellStop")
  end
  self._time = self._time + CS.UnityEngine.Time.deltaTime
end

function BuffCell:OnEvent(eventName, args)
  if eventName == "RefreshCell" and args.id == self._data.id then
    self:RefreshCell(args)
  end
end

return BuffCell
