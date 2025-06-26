-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/starmirage1/accumulaterewardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStarryMirrorCollect = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorcollect")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local AccumulateRewardCell = class("AccumulateRewardCell", Dialog)
AccumulateRewardCell.AssetBundleName = "ui/layouts.activitystar2"
AccumulateRewardCell.AssetName = "ActivityStar1AccountCell"
AccumulateRewardCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AccumulateRewardCell
  ((AccumulateRewardCell.super).Ctor)(self, ...)
  self._itemList = {}
end

AccumulateRewardCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._getPanel = self:GetChild("GetBack")
  self._getPanel_Btn = self:GetChild("GetBack/GetBtn")
  self._gotPanel = self:GetChild("Grey")
  self._currencyIcon = self:GetChild("Item")
  self._currencyNum = self:GetChild("Loading/Num/Num")
  self._progress = self:GetChild("Loading/Loading/BackGround/Progress")
  self._cellPanel = self:GetChild("ItemFrame")
  self._cellFrame = (TableFrame.Create)(self._cellPanel, self, false, false)
  ;
  (self._getPanel_Btn):Subscribe_PointerClickEvent(self.OnGetBtnClick, self)
end

AccumulateRewardCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._cellFrame):Destroy()
end

AccumulateRewardCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CStarryMirrorCollect, Item, _ENV
  local record = CStarryMirrorCollect:GetRecorder(data.stageId)
  local currencyItem = (Item.Create)(record.collecttype)
  local image = currencyItem:GetIcon()
  ;
  (self._currencyIcon):SetSprite(image.assetBundle, image.assetName)
  local curNum = ((NekoData.BehaviorManager).BM_Activity):GetAccumulatePointsByActivityId((DataCommon.Activities).StarMirageCopy, record.collecttype)
  ;
  (self._currencyNum):SetText(curNum .. "/" .. tostring(record.collectrequirenum))
  ;
  (self._progress):SetFillAmount(curNum / record.collectrequirenum)
  if data.status == 0 then
    (self._getPanel):SetActive(true)
    ;
    (self._gotPanel):SetActive(false)
    ;
    (self._getPanel_Btn):SetInteractable(false)
  else
    if data.status == 1 then
      (self._getPanel):SetActive(true)
      ;
      (self._gotPanel):SetActive(false)
      ;
      (self._getPanel_Btn):SetInteractable(true)
    else
      if data.status == 2 then
        (self._getPanel):SetActive(false)
        ;
        (self._gotPanel):SetActive(true)
      end
    end
  end
  while (self._itemList)[#self._itemList] do
    (table.remove)(self._itemList, #self._itemList)
  end
  for i,v in ipairs(record.collectbonus) do
    (table.insert)(self._itemList, {id = v, num = (record.collectbonusnum)[i]})
  end
  ;
  (self._cellFrame):ReloadAllCell()
end

AccumulateRewardCell.OnGetBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.creceivepointsaward")
  protocol.activityID = (DataCommon.Activities).StarMirageCopy
  protocol.taskID = (self._cellData).stageId
  protocol:Send()
end

AccumulateRewardCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._itemList
end

AccumulateRewardCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "activity.starmirage.accumulaterewarditemcell"
end

AccumulateRewardCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return (self._itemList)[index]
end

return AccumulateRewardCell

