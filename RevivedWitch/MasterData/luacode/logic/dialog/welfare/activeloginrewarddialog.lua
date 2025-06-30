-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/welfare/activeloginrewarddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ActiveLoginRewardDialog = class("ActiveLoginRewardDialog", Dialog)
ActiveLoginRewardDialog.AssetBundleName = "ui/layouts.welfare"
ActiveLoginRewardDialog.AssetName = "LoginAccount"
ActiveLoginRewardDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActiveLoginRewardDialog
  ((ActiveLoginRewardDialog.super).Ctor)(self, ...)
  self._receive = true
  self._init = false
end

ActiveLoginRewardDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._active_box = {}
  for i = 1, 7 do
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

    (self._active_box)[i] = {panel = self:GetChild("Award" .. i), dayTxt = self:GetChild("Award" .. i .. "/Day"), name = self:GetChild("Award" .. i .. "/ItemName"), img = self:GetChild("Award" .. i .. "/ItemCell/_BackGround/Icon"), num = self:GetChild("Award" .. i .. "/ItemCell/_Count"), select = self:GetChild("Award" .. i .. "/Select"), grey = self:GetChild("Award" .. i .. "/Grey"), checkMark = self:GetChild("Award" .. i .. "/CheckMark")}
  end
  ;
  (((self._active_box)[1]).panel):Subscribe_PointerClickEvent(self.OnAccumulateOneClicked, self)
  ;
  (((self._active_box)[2]).panel):Subscribe_PointerClickEvent(self.OnAccumulateTwoClicked, self)
  ;
  (((self._active_box)[3]).panel):Subscribe_PointerClickEvent(self.OnAccumulateThreeClicked, self)
  ;
  (((self._active_box)[4]).panel):Subscribe_PointerClickEvent(self.OnAccumulateFourClicked, self)
  ;
  (((self._active_box)[5]).panel):Subscribe_PointerClickEvent(self.OnAccumulateFiveClicked, self)
  ;
  (((self._active_box)[6]).panel):Subscribe_PointerClickEvent(self.OnAccumulateSixClicked, self)
  ;
  (((self._active_box)[7]).panel):Subscribe_PointerClickEvent(self.OnAccumulateSevenClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAccumulatedSignResult, Common.n_AccumulatedSignResult, nil)
end

ActiveLoginRewardDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

ActiveLoginRewardDialog.RefreshTabCell = function(self, refresh)
  -- function num : 0_3 , upvalues : _ENV, CStringRes, Item
  if not self._init or refresh then
    self._init = true
    local data = ((NekoData.BehaviorManager).BM_Welfare):GetTotalLoginInfo()
    self._signedNum = data.signedNum
    self._accDayList = data.accumulatedDayList
    for i = 1, 7 do
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1043)).msgTextID)
      ;
      (((self._active_box)[i]).dayTxt):SetText((self._accDayList)[i] .. str)
    end
    self._accItemList = {}
    for i,d in ipairs(data.accumulatedAwardList) do
      (table.insert)(self._accItemList, d.id)
      local item = (Item.Create)(d.id)
      if item:GetItemAttr() then
        (((self._active_box)[i]).img):SetSprite((item:GetIcon()).assetBundle, (item:GetIcon()).assetName)
        ;
        (((self._active_box)[i]).name):SetText(item:GetName())
      end
      ;
      (((self._active_box)[i]).num):SetText((NumberManager.GetShowNumber)(d.num))
    end
    self._accIndexList = data.accumulatedIndexList
    self:SetAccumulatedLine(self._signedNum, self._accIndexList)
  end
end

ActiveLoginRewardDialog.SetAccumulatedLine = function(self, signDayNum, indexList)
  -- function num : 0_4 , upvalues : _ENV
  self._signedNum = signDayNum
  for i = 1, 7 do
    if (self._accDayList)[i] <= signDayNum then
      (((self._active_box)[i]).select):SetActive(false)
      ;
      (((self._active_box)[i]).grey):SetActive(true)
      ;
      (((self._active_box)[i]).checkMark):SetActive(true)
    else
      ;
      (((self._active_box)[i]).select):SetActive(false)
      ;
      (((self._active_box)[i]).grey):SetActive(false)
      ;
      (((self._active_box)[i]).checkMark):SetActive(false)
    end
  end
  for _,index in ipairs(indexList) do
    (((self._active_box)[index]).select):SetActive(true)
    ;
    (((self._active_box)[index]).grey):SetActive(false)
    ;
    (((self._active_box)[index]).checkMark):SetActive(false)
  end
end

ActiveLoginRewardDialog.OnAccumulateClicked = function(self, index)
  -- function num : 0_5 , upvalues : _ENV, Item
  for _,dayIndex in ipairs(self._accIndexList) do
    if dayIndex == index then
      if self._receive then
        self._receive = false
        local protocol = (LuaNetManager.CreateProtocol)("protocol.login.ctotalsignaward")
        if protocol then
          protocol.day = (self._accDayList)[index]
          protocol:Send()
        else
          LogError("ActiveLoginRewardDialog", "there is no protocol ctotalsignaward can be used")
        end
      end
      do
        do
          do return  end
          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC27: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  local width, height = (((self._active_box)[index]).panel):GetRectSize()
  local tipsdialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsdialog then
    tipsdialog:Init({item = (Item.Create)((self._accItemList)[index])})
    tipsdialog:SetTipsPosition(width, height, (((self._active_box)[index]).panel):GetLocalPointInUiRootPanel())
  end
end

ActiveLoginRewardDialog.OnAccumulateOneClicked = function(self)
  -- function num : 0_6
  self:OnAccumulateClicked(1)
end

ActiveLoginRewardDialog.OnAccumulateTwoClicked = function(self)
  -- function num : 0_7
  self:OnAccumulateClicked(2)
end

ActiveLoginRewardDialog.OnAccumulateThreeClicked = function(self)
  -- function num : 0_8
  self:OnAccumulateClicked(3)
end

ActiveLoginRewardDialog.OnAccumulateFourClicked = function(self)
  -- function num : 0_9
  self:OnAccumulateClicked(4)
end

ActiveLoginRewardDialog.OnAccumulateFiveClicked = function(self)
  -- function num : 0_10
  self:OnAccumulateClicked(5)
end

ActiveLoginRewardDialog.OnAccumulateSixClicked = function(self)
  -- function num : 0_11
  self:OnAccumulateClicked(6)
end

ActiveLoginRewardDialog.OnAccumulateSevenClicked = function(self)
  -- function num : 0_12
  self:OnAccumulateClicked(7)
end

ActiveLoginRewardDialog.OnAccumulatedSignResult = function(self, notification)
  -- function num : 0_13 , upvalues : _ENV
  self._receive = true
  if (notification.userInfo).result == 1 then
    self._accIndexList = ((NekoData.BehaviorManager).BM_Welfare):GetAccumulatedIndexList()
    self:SetAccumulatedLine(self._signedNum, self._accIndexList)
    if #self._accIndexList == 0 then
      (LuaNotificationCenter.PostNotification)(Common.n_SignState, self, {type = "accumulate", state = true})
    end
  end
end

return ActiveLoginRewardDialog

