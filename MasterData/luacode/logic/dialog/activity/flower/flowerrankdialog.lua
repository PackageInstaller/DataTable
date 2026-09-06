local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CNpcShapeTable = BeanManager.GetTableByName("npc.cnpcshape")
local CFlowerSendRewardTable = BeanManager.GetTableByName("activity.cflowergive")
local CFlowerReceiveRewardTable = BeanManager.GetTableByName("activity.cflowerget")
local FlowerRankCellHelper = require("logic.dialog.activity.flower.flowerrankcellhelper")
local TableFrame = require("framework.ui.frame.table.tableframe")
local FlowerRankDialog = class("FlowerRankDialog", Dialog)
FlowerRankDialog.AssetBundleName = "ui/layouts.flower"
FlowerRankDialog.AssetName = "FlowerRank"
local PageType = {Rank = 1, Reward = 2}
local RewardType = {FLOWER_SEND = 1, FLOWER_RECEIVE = 2}

function FlowerRankDialog:Ctor(...)
  FlowerRankDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function FlowerRankDialog:OnCreate()
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
  self._backBtn = self:GetChild("BackBtn")
  self._titleTxt = self:GetChild("Title")
  self._menuBtn = self:GetChild("MenuBtn")
  self._rolePanel = self:GetChild("Panel/Role")
  self._live2D = self:GetChild("Panel/Role/Live2D")
  self._photo = self:GetChild("Panel/Role/Photo")
  self._playerCell = self:GetChild("Panel/FlowerRankCell")
  self._playerCallRankCellHelper = FlowerRankCellHelper.Create(self._playerCell, true)
  self._groupBtn1 = self:GetChild("Panel/GroupBtn1")
  self._groupBtn2 = self:GetChild("Panel/GroupBtn2")
  self._groupBtnTxt1 = self:GetChild("Panel/GroupBtn1/Text")
  self._groupBtnTxt2 = self:GetChild("Panel/GroupBtn2/Text")
  self._rankPanel = self:GetChild("Panel/FrameRank")
  self._rankFrame = TableFrame.Create(self._rankPanel, self, true, true, true)
  self._rewardPanel = self:GetChild("Panel/FrameReward")
  self._rewardFrame = TableFrame.Create(self._rewardPanel, self, true, true, true)
  self._rankBtn = self:GetChild("Panel/RankBtn")
  self._rewardBtn = self:GetChild("Panel/SoldBtn")
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._rewardBtn:Subscribe_PointerClickEvent(self.OnRewardBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._groupBtn1:Subscribe_PointerClickEvent(function()
    self:OnGroupBtnClick(1)
  end, self)
  self._groupBtn2:Subscribe_PointerClickEvent(function()
    self:OnGroupBtnClick(2)
  end, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshRankData, Common.n_OnSSimpleRank, nil)
  self:Init()
end

function FlowerRankDialog:OnDestroy()
  self._rankFrame:Destroy()
  self._rewardFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  UIBackManager.SetUIBackShow(false)
end

function FlowerRankDialog:Init()
  self._pageType = PageType.Rank
  self:RefreshPageInfo()
  local RankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef()
  self:DoReq(RankType.FLOWER_SEND)
  self._rewardDatas = {}
  self._rewardDatas[RewardType.FLOWER_SEND] = {}
  for _, id in ipairs(CFlowerSendRewardTable:GetAllIds()) do
    local cfg = CFlowerSendRewardTable:GetRecorder(id)
    table.insert(self._rewardDatas[RewardType.FLOWER_SEND], cfg)
  end
  self._rewardDatas[RewardType.FLOWER_RECEIVE] = {}
  for _, id in ipairs(CFlowerReceiveRewardTable:GetAllIds()) do
    local cfg = CFlowerReceiveRewardTable:GetRecorder(id)
    table.insert(self._rewardDatas[RewardType.FLOWER_RECEIVE], cfg)
  end
end

function FlowerRankDialog:RefreshPageInfo()
  self._rankBtn:SetActive(self._pageType == PageType.Reward)
  self._rewardBtn:SetActive(self._pageType == PageType.Rank)
  self._rankPanel:SetActive(self._pageType == PageType.Rank)
  self._rewardPanel:SetActive(self._pageType == PageType.Reward)
  self._playerCell:SetActive(self._pageType == PageType.Rank)
  if self._pageType == PageType.Rank then
    self._groupBtnTxt1:SetText(NekoData.BehaviorManager.BM_Message:GetString(2264))
    self._groupBtnTxt2:SetText(NekoData.BehaviorManager.BM_Message:GetString(2265))
    self._titleTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2268))
  elseif self._pageType == PageType.Reward then
    self._groupBtnTxt1:SetText(NekoData.BehaviorManager.BM_Message:GetString(2266))
    self._groupBtnTxt2:SetText(NekoData.BehaviorManager.BM_Message:GetString(2267))
    self._titleTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2269))
  end
end

function FlowerRankDialog:DoReq(rankType)
  local protocol = LuaNetManager.CreateProtocol("protocol.ranking.csimplerank")
  if protocol then
    protocol.rankType = rankType
    protocol:Send()
  end
end

function FlowerRankDialog:SetLive2D()
  local shapeid = 0
  local shapeRecord = CNpcShapeTable:GetRecorder(shapeid)
  self._rolePanel:SetAnimatorTrigger("loadReady")
  if Live2DManager.CanUse() and shapeRecord and shapeRecord.live2DPrefabName ~= "" and shapeRecord.live2DAssetBundleName ~= "" then
    if self._handler then
      self._live2D:Release(self._handler)
      self._live2D = nil
      self._handler = nil
    end
    self._photo:SetActive(false)
    self._handler = self._live2D:AddLive2D(shapeRecord.live2DAssetBundleName, shapeRecord.live2DPrefabName, shapeRecord.live2DScale)
  elseif shapeRecord then
    local lihuiImage = CImagePathTable:GetRecorder(shapeRecord.lihuiID) or DataCommon.DefaultImageAsset
    self._photo:SetActive(true)
    self._photo:SetSprite(lihuiImage.assetBundle, lihuiImage.assetName)
    local scale = shapeRecord.photoScale
    self._photo:SetLocalScale(scale, scale, scale)
    self._photo:SetAnchoredPosition(shapeRecord.photoLocation[1], shapeRecord.photoLocation[2])
  end
end

function FlowerRankDialog:RefreshRankData(notification)
  if self._pageType ~= PageType.Rank then
    return
  end
  local RankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef()
  self._rankType = notification.userInfo.rankType
  self._groupBtn1:SetSelected(self._rankType == RankType.FLOWER_SEND)
  self._groupBtn2:SetSelected(self._rankType == RankType.FLOWER_RECEIVE)
  self._data = notification.userInfo.ranking
  self._playerIndex = -1
  self._playerRanking = notification.userInfo.playerRanking
  local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
  if self._playerRanking.rank > 0 then
    for i, v in ipairs(self._data) do
      if v.baseUserData.userId == userInfo.userid then
        self._playerIndex = v.rank
        break
      end
    end
  else
    self._playerRanking.baseUserData.userName = userInfo.username
    self._playerRanking.baseUserData.userLv = userInfo.userlevel
    self._playerRanking.baseUserData.frameId = userInfo.frameId
    self._playerRanking.baseUserData.avatarId = userInfo.avatarId
  end
  if self._playerCallRankCellHelper then
    self._playerCallRankCellHelper:RefreshCell({
      simpleRankData = self._playerRanking,
      isMySelf = true
    })
  end
  self._rankFrame:ReloadAllCell()
  self._rankFrame:MoveToTop()
end

function FlowerRankDialog:NumberOfCell(frame)
  if frame == self._rankFrame then
    return #self._data
  else
    return #self._rewardDatas[self._rewardType]
  end
end

function FlowerRankDialog:CellAtIndex(frame, index)
  if frame == self._rankFrame then
    return "activity.flower.flowerrankcell"
  else
    return "activity.flower.flowerrankrewardcell"
  end
end

function FlowerRankDialog:DataAtIndex(frame, index)
  if frame == self._rankFrame then
    return {
      simpleRankData = self._data[index],
      isMySelf = index == self._playerIndex
    }
  else
    return self._rewardDatas[self._rewardType][index]
  end
end

function FlowerRankDialog:OnGroupBtnClick(index)
  if self._pageType == PageType.Rank then
    local RankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef()
    if index == 1 and self._rankType == RankType.FLOWER_SEND then
      return
    end
    if index == 2 and self._rankType == RankType.FLOWER_RECEIVE then
      return
    end
    local reqRankType = RankType.FLOWER_SEND
    if index == 2 then
      reqRankType = RankType.FLOWER_RECEIVE
    end
    self:DoReq(reqRankType)
    return
  end
  if index == 1 and self._rewardType == RewardType.FLOWER_SEND then
    return
  end
  if index == 2 and self._rewardType == RewardType.FLOWER_RECEIVE then
    return
  end
  self._groupBtn1:SetSelected(index == 1)
  self._groupBtn2:SetSelected(index == 2)
  self._rewardType = RewardType.FLOWER_SEND
  if index == 2 then
    self._rewardType = RewardType.FLOWER_RECEIVE
  end
  self._rewardFrame:ReloadAllCell()
  self._rewardFrame:MoveToTop()
end

function FlowerRankDialog:OnRankBtnClicked()
  self._pageType = PageType.Rank
  self:RefreshPageInfo()
  local RankType = NekoData.BehaviorManager.BM_SimpleRank:GetRankTypeDef()
  local reqRankType = RankType.FLOWER_SEND
  if self._groupBtn2:IsSelected() then
    reqRankType = RankType.FLOWER_RECEIVE
  end
  self:DoReq(reqRankType)
end

function FlowerRankDialog:OnRewardBtnClicked()
  self._pageType = PageType.Reward
  self:RefreshPageInfo()
  self._rewardType = RewardType.FLOWER_SEND
  if self._groupBtn2:IsSelected() then
    self._rewardType = RewardType.FLOWER_RECEIVE
  end
  self._rewardFrame:ReloadAllCell()
  self._rewardFrame:MoveToTop()
end

function FlowerRankDialog:OnBackBtnClicked()
  self:Destroy()
end

function FlowerRankDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return FlowerRankDialog
