-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/returnwelfare/returnbattlepasstasklastcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CReturnBattlePassReward = (BeanManager.GetTableByName)("welfare.creturnbattlepassreward")
local ReturnBattlePassTaskLastCell = class("ReturnBattlePassTaskLastCell", Dialog)
ReturnBattlePassTaskLastCell.AssetBundleName = "ui/layouts.welfare"
ReturnBattlePassTaskLastCell.AssetName = "ReturnBattlePassCellMax"
ReturnBattlePassTaskLastCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ReturnBattlePassTaskLastCell
  ((ReturnBattlePassTaskLastCell.super).Ctor)(self, ...)
end

ReturnBattlePassTaskLastCell.OnCreate = function(self)
  -- function num : 0_1
  self._txt = self:GetChild("Panel/Normal/Txt")
  self._normalItem = self:GetChild("Panel/Normal/ItemCell")
  self._itemFrame = self:GetChild("Panel/Normal/ItemCell/_BackGround/Frame")
  self._itemIcon = self:GetChild("Panel/Normal/ItemCell/_BackGround/Icon")
  self._itemChoose = self:GetChild("Panel/Normal/ItemCell/_BackGround/Select")
  self._num = self:GetChild("Panel/Normal/ItemCell/_Count")
  self._reddot = self:GetChild("Panel/Normal/RedDot")
  self._lock = self:GetChild("Panel/Normal/Lock")
  self._effect = self:GetChild("Panel/Effect")
  ;
  (self._itemIcon):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._itemChoose):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ReturnBattlePassTaskLastCell.OnDestroy = function(self)
  -- function num : 0_2
end

ReturnBattlePassTaskLastCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CReturnBattlePassReward, CStringRes
  self._data = data
  local common = data.common
  local item = (Item.Create)(common.itemId)
  local imageRecord = item:GetPinJiImage()
  ;
  (self._itemFrame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._itemIcon):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
  self._awardTimes = ((self._delegate)._returnBattlePass).canReceiveMaxAward
  ;
  (self._num):SetText((NumberManager.GetShowNumber)(common.itemNum))
  ;
  (self._reddot):SetActive(self._awardTimes > 0)
  ;
  (self._lock):SetActive(self._awardTimes <= 0)
  local show = self._awardTimes > 0
  if show and not self._effectHandler then
    self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)(1127))
  elseif not show and self._effectHandler then
    (self._effect):ReleaseEffect(self._effectHandler)
    self._effectHandler = nil
  end
  local maxLevel = (CReturnBattlePassReward:GetRecorder((CReturnBattlePassReward:GetAllIds())[#CReturnBattlePassReward:GetAllIds() - 1])).level
  local s = (TextManager.GetText)((CStringRes:GetRecorder(1331)).msgTextID)
  s = (string.gsub)(s, "%$parameter1%$", maxLevel)
  ;
  (self._txt):SetText(s)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

ReturnBattlePassTaskLastCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV, Item
  if self._awardTimes > 0 then
    local cmd = (LuaNetManager.CreateProtocol)("protocol.activity.creceivereturnmaxlevel")
    cmd:Send()
  else
    do
      local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if tipsDialog then
        local itemId = ((self._data).common).itemId
        tipsDialog:Init({item = (Item.Create)(itemId)})
        local width, height = (self._normalItem):GetRectSize()
        tipsDialog:SetTipsPosition(width, height, (self._normalItem):GetLocalPointInUiRootPanel())
      end
    end
  end
end

return ReturnBattlePassTaskLastCell

