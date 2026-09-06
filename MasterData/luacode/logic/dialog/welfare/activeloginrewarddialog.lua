local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local ActiveLoginRewardDialog = class("ActiveLoginRewardDialog", Dialog)
ActiveLoginRewardDialog.AssetBundleName = "ui/layouts.welfare"
ActiveLoginRewardDialog.AssetName = "LoginAccount"

function ActiveLoginRewardDialog:Ctor(...)
  ActiveLoginRewardDialog.super.Ctor(self, ...)
  self._receive = true
  self._init = false
end

function ActiveLoginRewardDialog:OnCreate()
  self._active_box = {}
  for i = 1, 7 do
    self._active_box[i] = {
      panel = self:GetChild("Award" .. i),
      dayTxt = self:GetChild("Award" .. i .. "/Day"),
      name = self:GetChild("Award" .. i .. "/ItemName"),
      img = self:GetChild("Award" .. i .. "/ItemCell/_BackGround/Icon"),
      num = self:GetChild("Award" .. i .. "/ItemCell/_Count"),
      select = self:GetChild("Award" .. i .. "/Select"),
      grey = self:GetChild("Award" .. i .. "/Grey"),
      checkMark = self:GetChild("Award" .. i .. "/CheckMark")
    }
  end
  self._active_box[1].panel:Subscribe_PointerClickEvent(self.OnAccumulateOneClicked, self)
  self._active_box[2].panel:Subscribe_PointerClickEvent(self.OnAccumulateTwoClicked, self)
  self._active_box[3].panel:Subscribe_PointerClickEvent(self.OnAccumulateThreeClicked, self)
  self._active_box[4].panel:Subscribe_PointerClickEvent(self.OnAccumulateFourClicked, self)
  self._active_box[5].panel:Subscribe_PointerClickEvent(self.OnAccumulateFiveClicked, self)
  self._active_box[6].panel:Subscribe_PointerClickEvent(self.OnAccumulateSixClicked, self)
  self._active_box[7].panel:Subscribe_PointerClickEvent(self.OnAccumulateSevenClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnAccumulatedSignResult, Common.n_AccumulatedSignResult, nil)
end

function ActiveLoginRewardDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function ActiveLoginRewardDialog:RefreshTabCell(refresh)
  if not self._init or refresh then
    self._init = true
    local data = NekoData.BehaviorManager.BM_Welfare:GetTotalLoginInfo()
    self._signedNum = data.signedNum
    self._accDayList = data.accumulatedDayList
    for i = 1, 7 do
      local str = TextManager.GetText(CStringRes:GetRecorder(1043).msgTextID)
      self._active_box[i].dayTxt:SetText(self._accDayList[i] .. str)
    end
    self._accItemList = {}
    for i, d in ipairs(data.accumulatedAwardList) do
      table.insert(self._accItemList, d.id)
      local item = Item.Create(d.id)
      if item:GetItemAttr() then
        self._active_box[i].img:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
        self._active_box[i].name:SetText(item:GetName())
      end
      self._active_box[i].num:SetText(NumberManager.GetShowNumber(d.num))
    end
    self._accIndexList = data.accumulatedIndexList
    self:SetAccumulatedLine(self._signedNum, self._accIndexList)
  end
end

function ActiveLoginRewardDialog:SetAccumulatedLine(signDayNum, indexList)
  self._signedNum = signDayNum
  for i = 1, 7 do
    if signDayNum >= self._accDayList[i] then
      self._active_box[i].select:SetActive(false)
      self._active_box[i].grey:SetActive(true)
      self._active_box[i].checkMark:SetActive(true)
    else
      self._active_box[i].select:SetActive(false)
      self._active_box[i].grey:SetActive(false)
      self._active_box[i].checkMark:SetActive(false)
    end
  end
  for _, index in ipairs(indexList) do
    self._active_box[index].select:SetActive(true)
    self._active_box[index].grey:SetActive(false)
    self._active_box[index].checkMark:SetActive(false)
  end
end

function ActiveLoginRewardDialog:OnAccumulateClicked(index)
  for _, dayIndex in ipairs(self._accIndexList) do
    if dayIndex == index then
      if self._receive then
        self._receive = false
        local protocol = LuaNetManager.CreateProtocol("protocol.login.ctotalsignaward")
        if protocol then
          protocol.day = self._accDayList[index]
          protocol:Send()
        else
          LogError("ActiveLoginRewardDialog", "there is no protocol ctotalsignaward can be used")
        end
      end
      return
    end
  end
  local width, height = self._active_box[index].panel:GetRectSize()
  local tipsdialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsdialog then
    tipsdialog:Init({
      item = Item.Create(self._accItemList[index])
    })
    tipsdialog:SetTipsPosition(width, height, self._active_box[index].panel:GetLocalPointInUiRootPanel())
  end
end

function ActiveLoginRewardDialog:OnAccumulateOneClicked()
  self:OnAccumulateClicked(1)
end

function ActiveLoginRewardDialog:OnAccumulateTwoClicked()
  self:OnAccumulateClicked(2)
end

function ActiveLoginRewardDialog:OnAccumulateThreeClicked()
  self:OnAccumulateClicked(3)
end

function ActiveLoginRewardDialog:OnAccumulateFourClicked()
  self:OnAccumulateClicked(4)
end

function ActiveLoginRewardDialog:OnAccumulateFiveClicked()
  self:OnAccumulateClicked(5)
end

function ActiveLoginRewardDialog:OnAccumulateSixClicked()
  self:OnAccumulateClicked(6)
end

function ActiveLoginRewardDialog:OnAccumulateSevenClicked()
  self:OnAccumulateClicked(7)
end

function ActiveLoginRewardDialog:OnAccumulatedSignResult(notification)
  self._receive = true
  if notification.userInfo.result == 1 then
    self._accIndexList = NekoData.BehaviorManager.BM_Welfare:GetAccumulatedIndexList()
    self:SetAccumulatedLine(self._signedNum, self._accIndexList)
    if #self._accIndexList == 0 then
      LuaNotificationCenter.PostNotification(Common.n_SignState, self, {type = "accumulate", state = true})
    else
    end
  end
end

return ActiveLoginRewardDialog
