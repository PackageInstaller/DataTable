local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CValentineChocolateReward = BeanManager.GetTableByName("activity.cvalentinechocolatereward")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local SLoverRedPoint = LuaNetManager.GetProtocolDef("protocol.activity.sloverredpoint")
local LoverChocolateDialog = class("LoverChocolateDialog", Dialog)
LoverChocolateDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverChocolateDialog.AssetName = "ActivityValentinesChocolate"
local RewardGetType = {NotGet = 0, Gotten = 1}
local RoleUnLockType = {Lock = 0, UnLock = 1}
local maxBoxNum = 5
local RARITY = {
  R = 1,
  SR = 2,
  SSR = 3,
  UR = 4,
  EX = 5
}
local ELEMENT_TYPE = {
  HYDRAGYRUM = 1,
  SALT = 2,
  FIRE = 3,
  ETHER = 4
}
local FILTER = {
  [RARITY.SSR] = 501831,
  [RARITY.SR] = 501832,
  [RARITY.R] = 501833,
  [RARITY.UR] = 501834,
  [RARITY.EX] = 502614
}
local FILTER_ELEMENT = {
  [ELEMENT_TYPE.HYDRAGYRUM] = 502771,
  [ELEMENT_TYPE.SALT] = 502772,
  [ELEMENT_TYPE.FIRE] = 502773,
  [ELEMENT_TYPE.ETHER] = 502774
}

function LoverChocolateDialog:Ctor(...)
  LoverChocolateDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.LoverActivityManagerID)
  self._screeningConditions = {}
  self._listByConditions = {}
end

function LoverChocolateDialog:OnCreate()
  self._closeBtn = self:GetChild("CloseBtn")
  self._charPanel = self:GetChild("BackImage/Frame")
  self._tips = self:GetChild("BackImage/Tips")
  self._title = self:GetChild("BackImage/Title")
  self._progress = self:GetChild("BackImage/BoxArea/ProgressBack/Progress")
  self._boxClickList = {}
  for i = 1, maxBoxNum do
    self._boxClickList[i] = {}
    self._boxClickList[i].item = self:GetChild("BackImage/BoxArea/Box" .. i .. "/Item")
    self._boxClickList[i].itemNum = self:GetChild("BackImage/BoxArea/Box" .. i .. "/Item/Num")
    self._boxClickList[i].panel = self:GetChild("BackImage/BoxArea/Box" .. i .. "")
    self._boxClickList[i].opened = self:GetChild("BackImage/BoxArea/Box" .. i .. "/BoxOpen")
    self._boxClickList[i].lock = self:GetChild("BackImage/BoxArea/Box" .. i .. "/BoxLock")
    self._boxClickList[i].num = self:GetChild("BackImage/BoxArea/Box" .. i .. "/Num")
    self._boxClickList[i].canget = self:GetChild("BackImage/BoxArea/Box" .. i .. "/Box")
    self._boxClickList[i].opened:Subscribe_PointerClickEvent(function()
      self:OnBoxOpenedClicked(i)
    end, self)
    self._boxClickList[i].lock:Subscribe_PointerClickEvent(function()
      self:OnBoxLockClicked(i)
    end, self)
    self._boxClickList[i].canget:Subscribe_PointerClickEvent(function()
      self:OnBoxCanGetClicked(i)
    end, self)
    self._boxClickList[i].item:Subscribe_PointerClickEvent(function()
      self:OnBoxItemClicked(i)
    end, self)
  end
  self._topGroup = self:GetChild("TopGroup")
  self._iBtn = self:GetChild("BackImage/Ibtn")
  self._unlockRoleNumTxt = self:GetChild("BackImage/TxtLock/Num")
  self._timeLimitTxt = self:GetChild("TimeLimit/Text")
  self._timeLimitPanel = self:GetChild("TimeLimit")
  self._fliterBtn = self:GetChild("BackImage/SiftFrame/FliterBtn")
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  self._characterFrame = GridFrame.Create(self._charPanel, self, true, 5)
  self._moneyFrame = TableFrame.Create(self._topGroup, self, false, false, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._fliterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnSGetLoverReward, Common.n_SGetLoverReward, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSUnlockRoleIcon, Common.n_SUnlockRoleIcon, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshMoney, Common.n_RefreshCurrency, nil)
end

function LoverChocolateDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._characterFrame then
    self._characterFrame:Destroy()
    self._characterFrame = nil
  end
  if self._moneyFrame then
    self._moneyFrame:Destroy()
    self._moneyFrame = nil
  end
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
end

function LoverChocolateDialog:SetData(protocol)
  local str = TextManager.GetText(CStringres:GetRecorder(1702).msgTextID)
  self._title:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1703).msgTextID)
  self._tips:SetText(str)
  self._characterList = {}
  local role
  for roleId, status in pairs(protocol.roleMap) do
    role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
    table.insert(self._characterList, {role = role, status = status})
  end
  self:SortReloadCharacterFrame()
  self._unlockRoleNum = protocol.roleNum
  local simulateNotification = {
    userInfo = protocol.progressReward
  }
  self:OnSGetLoverReward(simulateNotification)
  self:OnRefreshMoney()
  self._timeLimitTxt:SetText(TextManager.GetText(CStringres:GetRecorder(1719).msgTextID))
  self._timeLimitPanel:SetActive(protocol.isMask == 1)
end

function LoverChocolateDialog:SortReloadCharacterFrame()
  table.sort(self._characterList, function(a, b)
    if a.status == b.status then
      local ararity = a.role:GetRarityId()
      local brarity = b.role:GetRarityId()
      local aId = a.role:GetId()
      local bId = b.role:GetId()
      if ararity > brarity then
        return true
      elseif ararity < brarity then
        return false
      else
        return aId < bId
      end
    elseif a.status == RewardGetType.NotGet then
      return true
    else
      return false
    end
  end)
  self:ScreeningAndSorting()
end

function LoverChocolateDialog:NumberOfCell(frame)
  if frame == self._characterFrame then
    return #self._listByConditions
  elseif frame == self._moneyFrame then
    return #self._moneyList
  end
end

function LoverChocolateDialog:CellAtIndex(frame, index)
  if frame == self._characterFrame then
    return "activity.lover.loverchocolatecharcell"
  elseif frame == self._moneyFrame then
    return "activity.lover.lovermoneynumcell"
  end
end

function LoverChocolateDialog:DataAtIndex(frame, index)
  if frame == self._characterFrame then
    return self._listByConditions[index]
  elseif frame == self._moneyFrame then
    return self._moneyList[index]
  end
end

function LoverChocolateDialog:OnBoxOpenedClicked(index)
end

function LoverChocolateDialog:OnBoxLockClicked(index)
end

function LoverChocolateDialog:OnBoxCanGetClicked(index)
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cgetloverreward")
  csend.boxId = index
  csend:Send()
end

function LoverChocolateDialog:OnBoxItemClicked(index)
  local v = self._rewardList[index]
  if not v then
    LogErrorFormat("LoverChocolateDialog", "index %s dont have reward in rewardlist", index)
    return
  end
  local item = Item.Create(v.reward)
  local width, height = self._boxClickList[index].item:GetRectSize()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = item})
    tipsDialog:SetTipsPosition(width, height, self._boxClickList[index].item:GetLocalPointInUiRootPanel())
  end
end

function LoverChocolateDialog:OnBackBtnClicked()
  self:Destroy()
end

function LoverChocolateDialog:OnIBtnClicked()
  DialogManager.CreateSingletonDialog("activity.lover.lovertipsdialog"):SetData(CStringres:GetRecorder(1704).msgTextID)
end

function LoverChocolateDialog:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "LoverChocolateRole", self._screeningConditions)
end

function LoverChocolateDialog:CheckConditionNum()
  local count = 0
  for k, v in pairs(self._screeningConditions) do
    count = count + table.nums(v)
  end
  return count
end

function LoverChocolateDialog:ScreeningAndSorting()
  self._listByConditions = {}
  if self:CheckConditionNum() > 0 then
    local indexMap = {}
    local map1, map2, map3 = {}, {}, {}
    local check1, check2, check3 = false, false, false
    for k, v in pairs(self._screeningConditions) do
      for _, value in ipairs(v) do
        for i, inV in ipairs(self._characterList) do
          if k == 1 then
            check1 = true
            if value.nameid == FILTER[inV.role:GetRarityId()] then
              table.insert(map1, i)
            end
          end
          if k == 2 then
            check2 = true
            if value.nameid == inV.role:GetVocationNameId() then
              table.insert(map2, i)
            end
          end
          if k == 3 then
            check3 = true
            if value.nameid == FILTER_ELEMENT[inV.role:GetElement()] then
              table.insert(map3, i)
            end
          end
        end
      end
    end
    if check1 and check2 and check3 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map2, v1) and table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 and check2 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map2, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 and check3 then
      for _, v1 in ipairs(map1) do
        if table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check2 and check3 then
      for _, v1 in ipairs(map2) do
        if table.indexof(map3, v1) then
          indexMap[v1] = v1
        end
      end
    elseif check1 then
      indexMap = map1
    elseif check2 then
      indexMap = map2
    elseif check3 then
      indexMap = map3
    end
    for _, v in pairs(indexMap) do
      table.insert(self._listByConditions, self._characterList[v])
    end
  else
    self._listByConditions = self._characterList
  end
  self._characterFrame:ReloadAllCell()
end

function LoverChocolateDialog:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function LoverChocolateDialog:OnSGetLoverReward(notification)
  self._rewardList = {}
  local record
  for id, status in pairs(notification.userInfo) do
    record = CValentineChocolateReward:GetRecorder(id)
    table.insert(self._rewardList, {
      roleNum = record.roleNum,
      reward = record.reward,
      num = record.rewardNum,
      status = status
    })
  end
  if #self._rewardList > maxBoxNum then
    LogWarningFormat("LoverChocolateDialog", "SOpenRoleIcon.progressReward count %s more than %s", #self._rewardList, maxBoxNum)
  end
  if #self._rewardList < maxBoxNum then
    LogErrorFormat("LoverChocolateDialog", "SOpenRoleIcon.progressReward count %s less than %s", #self._rewardList, maxBoxNum)
  end
  table.sort(self._rewardList, function(a, b)
    return a.roleNum < b.roleNum
  end)
  self._maxRoleNum = self._rewardList[#self._rewardList].roleNum
  self:RefreshBoxPanel()
end

function LoverChocolateDialog:RefreshBoxPanel()
  if not self._unlockRoleNum or not self._maxRoleNum then
    LogErrorFormat("LoverChocolateDialog", "self._unlockRoleNum %s self._maxRoleNum %s progress Fill failed", self._unlockRoleNum, self._maxRoleNum)
  end
  local finishBoxNum = 0
  local hasCanGet = false
  for i = 1, maxBoxNum do
    local v = self._rewardList[i]
    if not v then
      LogErrorFormat("LoverChocolateDialog", "index %s dont have reward in rewardlist", i)
      break
    end
    self._boxClickList[i].num:SetText(v.roleNum)
    local item = Item.Create(v.reward)
    local imageRecord = item:GetIcon()
    self._boxClickList[i].item:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._boxClickList[i].itemNum:SetText(v.num)
    if v.status == RewardGetType.NotGet then
      if self._unlockRoleNum >= v.roleNum then
        finishBoxNum = finishBoxNum + 1
        hasCanGet = true
        self._boxClickList[i].lock:SetActive(false)
        self._boxClickList[i].opened:SetActive(false)
        self._boxClickList[i].canget:SetActive(true)
      else
        self._boxClickList[i].lock:SetActive(true)
        self._boxClickList[i].opened:SetActive(false)
        self._boxClickList[i].canget:SetActive(false)
      end
    elseif v.status == RewardGetType.Gotten then
      finishBoxNum = finishBoxNum + 1
      self._boxClickList[i].lock:SetActive(false)
      self._boxClickList[i].opened:SetActive(true)
      self._boxClickList[i].canget:SetActive(false)
    end
  end
  self._progress:SetFillAmount(finishBoxNum / maxBoxNum)
  self._unlockRoleNumTxt:SetText(self._unlockRoleNum)
  if hasCanGet then
    if not self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_CHOCOLATE) then
      self._bm:SetRedPointWithState(SLoverRedPoint.LOVER_CHOCOLATE, true)
      LuaNotificationCenter.PostNotification(Common.n_LoverRefreshRedPoint, nil, self._bm.RedPointKey.Chocolate)
    end
  elseif self._bm:GetRedPointWithState(SLoverRedPoint.LOVER_CHOCOLATE) then
    self._bm:SetRedPointWithState(SLoverRedPoint.LOVER_CHOCOLATE, false)
    LuaNotificationCenter.PostNotification(Common.n_LoverRefreshRedPoint, nil, self._bm.RedPointKey.Chocolate)
  end
end

function LoverChocolateDialog:OnSUnlockRoleIcon(notification)
  for _, v in ipairs(self._characterList) do
    if v.role:GetId() == notification.userInfo.roleId then
      v.status = RoleUnLockType.UnLock
      break
    end
  end
  self._characterFrame:FireEvent("UnlockRoleIdIcon", notification.userInfo.roleId)
  local position = self._characterFrame:GetCurrentPosition()
  self:SortReloadCharacterFrame()
  self._characterFrame:MoveToAssignedPos(position)
  self._unlockRoleNum = notification.userInfo.roleNum
  self:RefreshBoxPanel()
end

function LoverChocolateDialog:OnRefreshMoney()
  self._moneyList = {}
  table.insert(self._moneyList, DataCommon.LoveCarefullyPreparedGift)
  self._moneyFrame:ReloadAllCell()
end

return LoverChocolateDialog
