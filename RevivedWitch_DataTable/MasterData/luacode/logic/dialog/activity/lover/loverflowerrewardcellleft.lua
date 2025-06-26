-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/lover/loverflowerrewardcellleft.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoverFlowerRewardCell = class("LoverFlowerRewardCell", Dialog)
LoverFlowerRewardCell.AssetBundleName = "ui/layouts.activityvalentines"
LoverFlowerRewardCell.AssetName = "ActivityValentinesFlowerCell1"
LoverFlowerRewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverFlowerRewardCell
  ((LoverFlowerRewardCell.super).Ctor)(self, ...)
end

LoverFlowerRewardCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Award/ItemCell/_BackGround")
  self._count = self:GetChild("Award/ItemCell/_Count")
  self._itemImg = self:GetChild("Award/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("Award/ItemCell/_BackGround/Frame")
  self._canGetEffect = self:GetChild("Award/Effect")
  self._gottenTag = self:GetChild("Award/Get")
  self._canGetDot = self:GetChild("Dot")
  self._greyDot = self:GetChild("DotGrey")
  self._canGetNum = self:GetChild("NumGrey/Num")
  self._progress = self:GetChild("LineGrey/Line")
  self._greyNum = self:GetChild("NumGrey")
  self._progressLine = self:GetChild("LineGrey")
  ;
  (self._back):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

LoverFlowerRewardCell.OnDestroy = function(self)
  -- function num : 0_2
end

LoverFlowerRewardCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = (data.item):GetIcon()
  ;
  (self._itemImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._count):SetText(data.itemCount)
  ;
  (self._canGetNum):SetNumber(data.popularity)
  ;
  (self._greyNum):SetNumber(data.popularity)
  if data.progress == -1 then
    (self._progressLine):SetActive(false)
  else
    ;
    (self._progressLine):SetActive(true)
    ;
    (self._progress):SetFillAmount(data.progress)
  end
  if data.gotten then
    (self._canGetDot):SetActive(true)
    ;
    (self._greyDot):SetActive(false)
    ;
    (self._gottenTag):SetActive(true)
    ;
    (self._canGetNum):SetActive(true)
    ;
    (self._canGetEffect):SetActive(false)
  else
    if data.canGet then
      (self._canGetDot):SetActive(true)
      ;
      (self._greyDot):SetActive(false)
      ;
      (self._gottenTag):SetActive(false)
      ;
      (self._canGetNum):SetActive(true)
      ;
      (self._canGetEffect):SetActive(true)
    else
      ;
      (self._canGetDot):SetActive(false)
      ;
      (self._greyDot):SetActive(true)
      ;
      (self._gottenTag):SetActive(false)
      ;
      (self._canGetNum):SetActive(false)
      ;
      (self._canGetEffect):SetActive(false)
    end
  end
end

LoverFlowerRewardCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not (self._cellData).gotten and (self._cellData).canGet then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.creceiveflowerreward")
    csend.rewardType = (self._cellData).id // 100
    csend.id = (self._cellData).id
    csend:Send()
  else
    do
      local width, height = (self._back):GetRectSize()
      local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init({item = (self._cellData).item})
        tipsDialog:SetTipsPosition(width, height, (self._back):GetLocalPointInUiRootPanel())
      end
    end
  end
end

LoverFlowerRewardCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC9: Unhandled construct in 'MakeBoolean' P1

  if eventName == "RefreshProgress" and arg.id == (self._cellData).id then
    (self._cellData).progress = arg.progress
    ;
    (self._progress):SetFillAmount(arg.progress)
  end
  -- DECOMPILER ERROR at PC22: Confused about usage of register: R3 in 'UnsetPending'

  -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

  if eventName == "RewardGotten" and arg == (self._cellData).id then
    (self._cellData).gotten = true
    ;
    (self._canGetDot):SetActive(true)
    ;
    (self._greyDot):SetActive(false)
    ;
    (self._gottenTag):SetActive(true)
    ;
    (self._canGetNum):SetActive(true)
    ;
    (self._canGetEffect):SetActive(false)
  end
  -- DECOMPILER ERROR at PC51: Confused about usage of register: R3 in 'UnsetPending'

  if eventName == "RewardCanGet" and arg == (self._cellData).id then
    (self._cellData).canGet = true
    ;
    (self._canGetDot):SetActive(true)
    ;
    (self._greyDot):SetActive(false)
    ;
    (self._gottenTag):SetActive(false)
    ;
    (self._canGetNum):SetActive(true)
    ;
    (self._canGetEffect):SetActive(true)
  end
end

return LoverFlowerRewardCell

