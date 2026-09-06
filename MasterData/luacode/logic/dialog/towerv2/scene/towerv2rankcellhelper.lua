local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local HeadPhotoTable = BeanManager.GetTableByName("headphoto.cheadphotoconfig")
local HeadPhotoFrameTable = BeanManager.GetTableByName("headphoto.cheadphotoframeconfig")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local cstairlevelcfg = BeanManager.GetTableByName("dungeonselect.cstairlevelcfg")
local TowerV2RankCellHelper = class("TowerV2RankCellHelper")
local bm_towerv2 = NekoData.BehaviorManager.BM_TowerV2

function TowerV2RankCellHelper:Ctor(rootElement, single)
  self._rootElement = rootElement
  self._single = single
  self._rankNum = self._rootElement:FindChild("Back/RankNum/Num")
  self._headFrame = self._rootElement:FindChild("Back/HeadPhoto/Frame")
  self._headPhoto = self._rootElement:FindChild("Back/HeadPhoto/Photo")
  self._userName = self._rootElement:FindChild("Back/NameBack/Name")
  self._callScoreNum = self._rootElement:FindChild("Back/ExpNum")
  self._passTime = self._rootElement:FindChild("Back/ClearTime")
  self._rankBack = {}
  for i = 1, 4 do
    self._rankBack[i] = self._rootElement:FindChild("Rank" .. tostring(i))
  end
  self._singleBack = self._rootElement:FindChild("Rank5")
  self._rankNumImgs = {}
  for i = 1, 3 do
    self._rankNumImgs[i] = self._rootElement:FindChild("Back/Rank" .. tostring(i))
  end
  self._rankNumImgs[4] = self._rankNum
  self._headPhoto:Subscribe_PointerClickEvent(self.OnHeadPhotoClicked, self)
  self._cellItem = {}
  for i = 1, 4 do
    self._cellItem[i] = {}
    self._cellItem[i].root = self._rootElement:FindChild("CellItem" .. tostring(i))
    self._cellItem[i].root:SetActive(false)
    self._cellItem[i].frame = self._rootElement:FindChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_BackGround/Frame")
    self._cellItem[i].count = self._rootElement:FindChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_Count")
    self._cellItem[i].icon = self._rootElement:FindChild("CellItem" .. tostring(i) .. "/Panel/ItemCell/_BackGround/Icon")
    self._cellItem[i].item = nil
    self._cellItem[i].root:Subscribe_PointerClickEvent(function()
      self:OnCellClick(i)
    end, self)
  end
end

function TowerV2RankCellHelper:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function TowerV2RankCellHelper:RefreshCell(data)
  self._data = data
  self._inRank = self._data.remoteData.rank ~= -1
  local userName, score, rank, frameId, avatarId, minute, second
  if not self._inRank then
    local userInfo = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo()
    userName = userInfo.username
    score, minute, second = self:parseScore(self._data.remoteData.score)
    rank = TextManager.GetText(CStringRes:GetRecorder(1681).msgTextID)
    frameId = userInfo.frameId
    avatarId = userInfo.avatarId
  else
    userName = self._data.remoteData.baseUserData.userName
    score, minute, second = self:parseScore(self._data.remoteData.score)
    rank = self._data.remoteData.rank
    frameId = self._data.remoteData.baseUserData.frameId
    avatarId = self._data.remoteData.baseUserData.avatarId
  end
  for index, _ in ipairs(self._rankBack) do
    local isActive = self._data.remoteData.rank == index or index == 4 and (self._data.remoteData.rank >= 4 or self._data.remoteData.rank == -1)
    if self._single then
      self._rankBack[index]:SetActive(false)
      self._singleBack:SetActive(true)
    else
      self._rankBack[index]:SetActive(isActive)
      self._singleBack:SetActive(false)
    end
    self._rankNumImgs[index]:SetActive(isActive)
  end
  self._rankNum:SetText(rank)
  local cfg = cstairlevelcfg:GetRecorder(score)
  if cfg then
    self._callScoreNum:SetText(TextManager.GetText(cfg.name))
  else
    self._callScoreNum:SetText("0")
  end
  self._userName:SetText(userName)
  local headPhotoFrameRecord = HeadPhotoFrameTable:GetRecorder(frameId)
  if headPhotoFrameRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoFrameRecord.photoid) or DataCommon.DefaultImageAsset
    self._headFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headFrame:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CallRankCell", "headPhotoFrameRecord not found. frameId = %s", frameId)
  end
  local headPhotoRecord = HeadPhotoTable:GetRecorder(avatarId)
  if headPhotoRecord then
    local imageRecord = CImagePathTable:GetRecorder(headPhotoRecord.photoid) or DataCommon.DefaultImageAsset
    self._headPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    self._headPhoto:SetSprite(DataCommon.DefaultImageAsset.assetBundle, DataCommon.DefaultImageAsset.assetName)
    LogErrorFormat("CallRankCell", "headPhotoRecord not found. avatarId = %s", avatarId)
  end
  if minute == 0 then
    local time = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID)
    time = string.gsub(time, "%$parameter1%$", second)
    self._passTime:SetText(time)
  else
    local time1 = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(2171).msgTextID)
    time1 = string.gsub(time1, "%$parameter1%$", minute)
    local time2 = TextManager.GetText(BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID)
    time2 = string.gsub(time2, "%$parameter1%$", second)
    self._passTime:SetText(time1 .. time2)
  end
  if self._data.localData then
    local rewardLen = #self._data.localData.item
    local cellItemLen = #self._cellItem
    local startIndex = cellItemLen - rewardLen + 1
    for index, _ in ipairs(self._cellItem) do
      if index < startIndex then
        self._cellItem[index].root:SetActive(false)
      else
        self._cellItem[index].root:SetActive(true)
        self._cellItem[index].item = Item.Create(self._data.localData.item[index - startIndex + 1])
        local imageRecord = self._cellItem[index].item:GetIcon()
        self._cellItem[index].icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        imageRecord = self._cellItem[index].item:GetPinJiImage()
        self._cellItem[index].frame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        self._cellItem[index].count:SetNumber(self._data.localData.num[index - startIndex + 1])
      end
    end
  else
    for index, _ in ipairs(self._cellItem) do
      self._cellItem[index].root:SetActive(false)
    end
  end
end

function TowerV2RankCellHelper:OnCellClick(index)
  local width, height = self._cellItem[index].root:GetRectSize()
  if self._cellItem[index].item then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._cellItem[index].item
      })
      tipsDialog:SetTipsPosition(width, height, self._cellItem[index].root:GetLocalPointInUiRootPanel())
    end
  end
end

function TowerV2RankCellHelper:OnHeadPhotoClicked()
  if self._inRank then
    self:SendCLookOtherInfo(self._data.remoteData.baseUserData.userId)
  end
end

function TowerV2RankCellHelper:SendCLookOtherInfo(userId)
  local protocol = LuaNetManager.CreateProtocol("protocol.chat.clookotherinfo")
  if protocol then
    protocol.userId = userId
    protocol:Send()
  end
end

function TowerV2RankCellHelper:parseScore(score)
  local str = string.format("%07d", score)
  local layer = tonumber(str:sub(1, 4))
  local minute = 99 - tonumber(str:sub(5, 6))
  local second = (9 - tonumber(str:sub(7, 7))) * 6
  return layer, minute, second
end

return TowerV2RankCellHelper
