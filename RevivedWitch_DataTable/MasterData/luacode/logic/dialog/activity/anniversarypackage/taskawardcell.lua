-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/anniversarypackage/taskawardcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskAwardcell = class("TaskAwardcell", Dialog)
local Item = require("logic.manager.experimental.types.item")
local CommonAwardsSatus = (LuaNetManager.GetBeanDef)("protocol.common.commonawardstatus")
TaskAwardcell.AssetBundleName = "ui/layouts.activity1yearanniversary"
TaskAwardcell.AssetName = "Activity1YearOtherTaskProgressCell"
TaskAwardcell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TaskAwardcell
  ((TaskAwardcell.super).Ctor)(self, ...)
  self._groupName = "Cell"
end

TaskAwardcell.OnCreate = function(self)
  -- function num : 0_1
  self._processLine = self:GetChild("LinebBack/Line")
  self:GetChild("GetBack2/Text1")
  self:GetChild("GetBack1/Text2")
  self._itemCell = {panel = self:GetChild("Item"), mask = self:GetChild("Item/ItemCell/_BackGround/Mask"), frame = self:GetChild("Item/ItemCell/_BackGround/Frame"), icon = self:GetChild("Item/ItemCell/_BackGround/Icon"), count = self:GetChild("Item/ItemCell/_Count"), receivedBtn = self:GetChild("GetBack1"), getBtn = self:GetChild("GetBack2"), score = self:GetChild("NumFrame/Num")}
  ;
  ((self._itemCell).icon):Subscribe_PointerClickEvent(self.OnItemClicked, self)
end

TaskAwardcell.OnDestroy = function(self)
  -- function num : 0_2
end

TaskAwardcell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CommonAwardsSatus, Item, _ENV
  local state = data.state
  self._data = data
  ;
  ((self._itemCell).mask):SetActive(state ~= CommonAwardsSatus.UNLOCKED)
  ;
  ((self._itemCell).getBtn):SetActive(state == CommonAwardsSatus.UNLOCKED)
  ;
  ((self._itemCell).receivedBtn):SetActive(state == CommonAwardsSatus.FETCHED)
  local itemId = ((data.cfg).rewardItem)[1]
  local needNum = ((data.cfg).rewardQuantity)[1]
  local maxScore = (data.cfg).rewardNum
  if itemId and itemId ~= 0 then
    local item = (Item.Create)(itemId)
    ;
    ((self._itemCell).panel):SetActive(true)
    ;
    ((self._itemCell).icon):SetSprite(item:GetIconAB())
    ;
    ((self._itemCell).frame):SetSprite(item:GetPinJiImageAB())
    ;
    ((self._itemCell).count):SetText((NumberManager.GetNumber)(needNum))
    ;
    ((self._itemCell).score):SetText(maxScore)
    -- DECOMPILER ERROR at PC75: Confused about usage of register: R7 in 'UnsetPending'

    ;
    (self._itemCell).item = item
  else
    ((self._itemCell).panel):SetActive(false)
    ;
    ((self._itemCell).score):SetText(maxScore)
    ;
    ((self._itemCell).getBtn):SetActive(false)
    ;
    ((self._itemCell).receivedBtn):SetActive(false)
  end
  ;
  (self._processLine):SetFillAmount(data.process)
  -- DECOMPILER ERROR: 5 unprocessed JMP targets
end

TaskAwardcell.OnItemClicked = function(self)
  -- function num : 0_4 , upvalues : CommonAwardsSatus, _ENV
  if (self._data).state == CommonAwardsSatus.UNLOCKED then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cfetchanniversarymissionaward")
    csend.awardId = ((self._data).cfg).id
    csend:Send()
  else
    do
      local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
      if tipsDialog then
        tipsDialog:Init({item = (self._itemCell).item})
      end
    end
  end
end

return TaskAwardcell

