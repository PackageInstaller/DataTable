local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local CFavourPresentType = BeanManager.GetTableByName("role.cfavourpresenttype")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local RectTransformStaticFunctions = CS.PixelNeko.Lua.RectTransformStaticFunctions
local MaterialStaticFunctions = CS.PixelNeko.Lua.MaterialStaticFunctions
local progressUpEffectTime = 1
local RoleFavourTabCell = class("RoleFavourTabCell", Dialog)
RoleFavourTabCell.AssetBundleName = "ui/layouts.tujian"
RoleFavourTabCell.AssetName = "FavourNew"

local function PlayHeartEffect(self)
  local isplaying
  for i, data in ipairs(self._cachePlayHeartEffectList) do
    if data.playing then
      isplaying = true
      break
    end
  end
  if not isplaying then
    local data = self._cachePlayHeartEffectList[1]
    if data then
      if data.effectType == "LeftHalf" then
        data.heartEffectHandler = self._heartInfo[data.index].effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1123))
        data.playing = true
      elseif data.effectType == "RightHalf" then
        data.heartEffectHandler = self._heartInfo[data.index].effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1124))
        data.playing = true
      elseif data.effectType == "Whole" then
        data.heartEffectHandler = self._heartInfo[data.index].effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1128))
        data.playing = true
      end
    end
  end
end

function RoleFavourTabCell:Ctor(...)
  RoleFavourTabCell.super.Ctor(self, ...)
  self._cacheHeartEffectData = {}
  self._cachePlayHeartEffectList = {}
  self._lastRoleId = nil
end

function RoleFavourTabCell:OnCreate()
  self._showBtn = self:GetChild("Panel/ShowBtn")
  self._heartInfo = {}
  for i = 1, 5 do
    self._heartInfo[i] = {}
    self._heartInfo[i].back = self:GetChild("Panel/Back/Level/Heart" .. i .. "Back")
    self._heartInfo[i].light = self:GetChild("Panel/Back/Level/Heart" .. i)
    self._heartInfo[i].effect = self:GetChild("Panel/Back/Level/Heart" .. i .. "/Effect")
    self._heartInfo[i].effect:Subscribe_UIEffectEndEvent(function(effectHandler, window)
      self:OnHeartEffectEnd(i, effectHandler, window)
    end)
  end
  self._progress = self:GetChild("Panel/Back/Level/Heart")
  self._favourLvTxt = self:GetChild("Panel/Back/Level/LvNum")
  self._favourExpTxt = self:GetChild("Panel/Back/Level/Num")
  self._giftBtn = self:GetChild("Panel/Back/Level/Box")
  self._giftBtnIcon = self:GetChild("Panel/Back/Level/Box/Box")
  self._boxEffect = self:GetChild("Panel/Back/Level/Box/Effect")
  self._redDot = self:GetChild("Panel/Back/Level/RedDot")
  self._itemEmpty = self:GetChild("Panel/Back/Empty")
  self._itemEmptyTxt = self:GetChild("Panel/Back/Empty/Txt")
  self._itemPanel = self:GetChild("Panel/Back/Frame")
  self._itemFrame = GridFrame.Create(self._itemPanel, self, true, 3)
  self._detailBorder = self:GetChild("Panel/Back/Detail")
  self._detail_name = self:GetChild("Panel/Back/Detail/ItemName")
  self._detail_description = self:GetChild("Panel/Back/Detail/Detail")
  self._heartEffectPanel = self:GetChild("Panel/Back/Detail/HeartFrame")
  self._heartEffectFrame = TableFrame.Create(self._heartEffectPanel, self, false, false)
  self._numBorder = self:GetChild("Panel/Back/Num")
  self._curGiveNumTxt = self:GetChild("Panel/Back/Num/Num")
  self._reduceBtn = self:GetChild("Panel/Back/Num/MinusBtn")
  self._addBtn = self:GetChild("Panel/Back/Num/AddBtn")
  self._minBtn = self:GetChild("Panel/Back/Num/MinBtn")
  self._maxBtn = self:GetChild("Panel/Back/Num/MaxBtn")
  self._giveBtn = self:GetChild("Panel/Back/GiveBtn")
  self._itemEmptyTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1471).msgTextID))
  self._showBtn:Subscribe_PointerClickEvent(self.OnShowBtnClick, self)
  self._giftBtn:Subscribe_PointerClickEvent(self.OnGiftBtnClick, self)
  self._reduceBtn:Subscribe_PointerClickEvent(self.OnReduceBtnClicked, self)
  self._addBtn:Subscribe_PointerClickEvent(self.OnAddBtnClicked, self)
  self._minBtn:Subscribe_PointerClickEvent(self.OnMinBtnClicked, self)
  self._maxBtn:Subscribe_PointerClickEvent(self.OnMaxBtnClicked, self)
  self._giveBtn:Subscribe_PointerClickEvent(self.OnGiveBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRedPointNumChanged, Common.n_RedPointNumChanged, nil)
end

function RoleFavourTabCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("character.characterfashionshowdialog")
  DialogManager.DestroySingletonDialog("handbook.favour.favourgiftdialog")
  DialogManager.DestroySingletonDialog("handbook.favour.givegiftdialog")
  self._itemFrame:Destroy()
  self._heartEffectFrame:Destroy()
end

function RoleFavourTabCell:OnRedPointNumChanged(notification)
  if not notification or notification.userInfo.redPointID == 9 and notification.userInfo.redPointParams and notification.userInfo.redPointParams[1] == self._delegate._role:GetId() then
    local value = NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(9, {
      self._delegate._role:GetId()
    }) > 0
    if value then
      self._redDot:SetActive(true)
      self._giftBtnIcon:SetActive(false)
      if not self._boxEffectHandler then
        self._boxEffectHandler = self._boxEffect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1122))
      end
    else
      self._redDot:SetActive(false)
      self._giftBtnIcon:SetActive(true)
      if self._boxEffectHandler then
        self._boxEffect:ReleaseEffect(self._boxEffectHandler)
        self._boxEffectHandler = nil
      end
    end
  end
end

function RoleFavourTabCell:OnHeartEffectEnd(index, window, effectHandler)
  local deleteIndex
  for i, data in ipairs(self._cachePlayHeartEffectList) do
    if data.index == index and data.heartEffectHandler == effectHandler then
      if data.effectType == "LeftHalf" then
        self._heartInfo[index].light:SetFillAmount(0.5)
      else
        self._heartInfo[index].light:SetFillAmount(1)
      end
      deleteIndex = i
      break
    end
  end
  if deleteIndex then
    table.remove(self._cachePlayHeartEffectList, deleteIndex)
    PlayHeartEffect(self)
  end
end

local function RefreshProgress(self)
  local maxLv = self._delegate._role:GetRelationMaxLevel()
  local maxProgress = self._delegate._role:GetRelationMaxProgress()
  local amount
  if maxLv > self._curLv then
    self._favourExpTxt:SetText(self._curProgress .. "/" .. maxProgress)
    amount = self._curProgress / maxProgress
  else
    self._favourExpTxt:SetText("MAX")
    amount = 1
  end
  self._progress:SetFillAmount(amount)
end

function RoleFavourTabCell:RefreshTabCell(refreshData, notChangePos)
  if not self._init or refreshData then
    self._init = true
    if not self._lastRoleId or self._lastRoleId ~= self._delegate._role:GetId() then
      local id = self._delegate._role:GetId()
      self._lastRoleId = id
      self._delegate:OnLiHuiClicked(true)
    end
    if self._progressTask then
      self._progressTask = nil
      self._times = 0
    end
    while self._cacheHeartEffectData[#self._cacheHeartEffectData] do
      table.remove(self._cacheHeartEffectData, #self._cacheHeartEffectData)
    end
    while self._cachePlayHeartEffectList[#self._cachePlayHeartEffectList] do
      table.remove(self._cachePlayHeartEffectList, #self._cachePlayHeartEffectList)
    end
    self._rarityId = self._delegate._role:GetRarityId()
    local curLv = self._delegate._role:GetRelationLevel()
    self._curLv = curLv
    self._lastLv = self._curLv
    local maxLv = self._delegate._role:GetRelationMaxLevel()
    local curProgress = self._delegate._role:GetRelationProgress()
    self._curProgress = curProgress
    local favourExpRecord = CFavourExp:GetRecorder(curLv)
    local curHeartNum = favourExpRecord.heartnum / 10
    local maxHeartNum = math.ceil(CFavourExp:GetRecorder(maxLv).heartnum / 10)
    local integer, decimal = math.modf(curHeartNum)
    for i, v in ipairs(self._heartInfo) do
      if i > maxHeartNum then
        v.back:SetActive(false)
        v.light:SetActive(false)
      elseif curHeartNum > i - 1 and i > curHeartNum then
        v.light:SetFillAmount(decimal)
      elseif i <= curHeartNum then
        v.light:SetFillAmount(1)
      else
        v.light:SetFillAmount(0)
      end
    end
    self._favourLvTxt:SetText(curLv)
    RefreshProgress(self)
    self:OnRedPointNumChanged()
  end
  self:OnSendBtnClick()
end

local function GetRelationMaxProgress(self, level)
  local favourExpRecord = CFavourExp:GetRecorder(level)
  if self._rarityId == 1 then
    return favourExpRecord.Rfavourexp
  end
  if self._rarityId == 2 then
    return favourExpRecord.SRfavourexp
  end
  if self._rarityId == 3 then
    return favourExpRecord.SSRfavourexp
  end
  if self._rarityId == 4 then
    return favourExpRecord.URfavourexp
  end
  if self._rarityId == 5 then
    return favourExpRecord.EXfavourexp
  end
end

local function RefreshProgressByUpdate(self, level, progress)
  local maxLv = self._delegate._role:GetRelationMaxLevel()
  local maxProgress = GetRelationMaxProgress(self, level)
  local amount
  if level >= maxLv then
    self._favourExpTxt:SetText("MAX")
    amount = 1
  else
    self._favourExpTxt:SetText(math.floor(progress) .. "/" .. maxProgress)
    amount = progress / maxProgress
  end
  self._progress:SetFillAmount(amount)
end

local function PlayFavourUpEffect(self, level, progress)
  self._lastLv = self._curLv
  local curLv = self._curLv
  local maxLv = self._delegate._role:GetRelationMaxLevel()
  self._curLv = level
  local curProgress = self._curProgress
  self._curProgress = progress
  if curLv < maxLv then
    local addNum
    if level == curLv then
      addNum = progress - curProgress
    else
      local rarityId = self._delegate._role:GetRarityId()
      local curRecord = CFavourExp:GetRecorder(curLv)
      local curMaxFavourExp = 0
      if rarityId == 1 then
        curMaxFavourExp = curRecord.Rfavourexp
      elseif rarityId == 2 then
        curMaxFavourExp = curRecord.SRfavourexp
      elseif rarityId == 3 then
        curMaxFavourExp = curRecord.SSRfavourexp
      elseif rarityId == 4 then
        curMaxFavourExp = curRecord.URfavourexp
      elseif rarityId == 5 then
        curMaxFavourExp = curRecord.EXfavourexp
      end
      addNum = curMaxFavourExp - curProgress
      for i = curLv + 1, level - 1 do
        local num
        local record = CFavourExp:GetRecorder(i)
        if rarityId == 1 then
          num = record.Rfavourexp
        elseif rarityId == 2 then
          num = record.SRfavourexp
        elseif rarityId == 3 then
          num = record.SSRfavourexp
        elseif rarityId == 4 then
          num = record.URfavourexp
        elseif rarityId == 5 then
          num = record.EXfavourexp
        end
        addNum = addNum + num
      end
      addNum = addNum + progress
    end
    NekoData.BehaviorManager.BM_Message:SendMessageById(100250, {addNum})
  end
  self._favourLvTxt:SetText(self._curLv)
  self:SetData(self._delegate._role:GetId())
end

function RoleFavourTabCell:OnUpdate(notification)
  if self._progressTask then
    if self._progressTask:update(notification.userInfo.deltaTime) then
      local progress = self._progressTask.target.progress
      local level = self._progressTask.target.level
      local trueLv = self._progressTask.target.trueLv
      local trueProgress = self._progressTask.target.trueProgress
      RefreshProgressByUpdate(self, self._progressTask.initial.level, progress)
      if trueProgress and progress / GetRelationMaxProgress(self, self._progressTask.initial.level) ~= trueProgress / GetRelationMaxProgress(self, trueLv) or trueLv and level < trueLv then
        if trueLv and level < trueLv then
          if self._times == 2 or level == trueLv - 1 then
            self._progressTask = Tween.new(progressUpEffectTime, {progress = 0, level = trueLv}, {progress = trueProgress, level = trueLv}, "linear")
          else
            self._times = self._times + 1
            self._progressTask = Tween.new(progressUpEffectTime, {
              progress = 0,
              level = level,
              trueLv = level,
              trueProgress = progress
            }, {
              progress = GetRelationMaxProgress(self, level),
              level = level + 1,
              trueLv = trueLv,
              trueProgress = trueProgress
            }, "linear")
          end
        else
          self._progressTask = Tween.new(progressUpEffectTime, {progress = 0, level = level}, {progress = trueProgress, level = level}, "linear")
        end
      else
        self._progressTask = nil
        self._times = 0
        if self._lastLv < self._curLv then
          self._delegate:AddLevelUpEffect()
          table.insert(self._cacheHeartEffectData, {
            startLv = self._lastLv,
            endLv = self._curLv
          })
          self:PlayHeartEffect()
        end
      end
    else
      RefreshProgressByUpdate(self, self._progressTask.initial.level, self._progressTask.subject.progress)
    end
  end
end

function RoleFavourTabCell:PlayFavourProgressUpEffect(level, progress)
  self._times = 0
  if self._progressTask then
    self._progressTask = nil
    if self._lastLv < self._curLv then
      self._delegate:AddLevelUpEffect()
      table.insert(self._cacheHeartEffectData, {
        startLv = self._lastLv,
        endLv = self._curLv
      })
      self:PlayHeartEffect()
    end
  end
  if progress > self._curProgress or level > self._curLv then
    if level > self._curLv then
      self._times = 1
      self._progressTask = Tween.new(progressUpEffectTime, {
        progress = self._curProgress,
        level = self._curLv,
        trueLv = self._curLv,
        trueProgress = self._curProgress
      }, {
        progress = GetRelationMaxProgress(self, self._curLv),
        level = self._curLv + 1,
        trueLv = level,
        trueProgress = progress
      }, "linear")
    else
      self._progressTask = Tween.new(progressUpEffectTime, {
        progress = self._curProgress,
        level = self._curLv
      }, {progress = progress, level = level}, "linear")
    end
  end
  PlayFavourUpEffect(self, level, progress)
  self:OnSendBtnClick()
end

function RoleFavourTabCell:PlayHeartEffect()
  local data = self._cacheHeartEffectData[1]
  if data then
    table.remove(self._cacheHeartEffectData, 1)
    local lastLv = data.startLv
    for i = data.startLv + 1, data.endLv do
      local lastHeartNum = CFavourExp:GetRecorder(lastLv).heartnum / 10
      local lastInteger, lastDecimal = math.modf(lastHeartNum)
      local favourExpRecord = CFavourExp:GetRecorder(i)
      local curHeartNum = favourExpRecord.heartnum / 10
      local integer, decimal = math.modf(curHeartNum)
      if lastInteger == integer then
        if i == data.endLv and lastDecimal < decimal then
          table.insert(self._cachePlayHeartEffectList, {
            index = math.ceil(curHeartNum),
            effectType = "LeftHalf"
          })
          lastLv = i
        end
      elseif lastInteger < integer then
        if lastDecimal > decimal then
          table.insert(self._cachePlayHeartEffectList, {
            index = math.ceil(curHeartNum),
            effectType = "RightHalf"
          })
          lastLv = i
        else
          table.insert(self._cachePlayHeartEffectList, {
            index = math.ceil(curHeartNum),
            effectType = "Whole"
          })
          lastLv = i
        end
      end
    end
  end
  PlayHeartEffect(self)
end

function RoleFavourTabCell:Leave()
  if self._progressTask then
    self._progressTask = nil
    self:RefreshTabCell(true)
    self._times = 0
  end
  while self._cacheHeartEffectData[#self._cacheHeartEffectData] do
    table.remove(self._cacheHeartEffectData, #self._cacheHeartEffectData)
  end
  while self._cachePlayHeartEffectList[#self._cachePlayHeartEffectList] do
    table.remove(self._cachePlayHeartEffectList, #self._cachePlayHeartEffectList)
  end
end

function RoleFavourTabCell:OnShowBtnClick()
  DialogManager.CreateSingletonDialog("character.characterfashionshowdialog"):SetData(self._delegate._role:GetDefaultFashion())
end

function RoleFavourTabCell:OnGiftBtnClick()
  if not self._delegate._giveItemId then
    DialogManager.CreateSingletonDialog("handbook.favour.favourgiftdialog"):SetData(self._delegate._role:GetId())
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100252)
  end
end

function RoleFavourTabCell:OnSendBtnClick()
  if #NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(75) > 0 then
    self:SetData(self._delegate._role:GetId())
    self._itemEmpty:SetActive(false)
    self._giveBtn:SetInteractable(true)
    self._numBorder:SetActive(true)
    self._itemPanel:SetActive(true)
    self._detailBorder:SetActive(true)
  else
    self._itemEmpty:SetActive(true)
    self._giveBtn:SetInteractable(false)
    self._numBorder:SetActive(false)
    self._itemPanel:SetActive(false)
    self._detailBorder:SetActive(false)
  end
end

function RoleFavourTabCell:SetData(roleId)
  self._itemList = {}
  self._needExp = 0
  self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
  local rarityId = self._role:GetRarityId()
  local curLv = self._role:GetRelationLevel()
  local maxLv = self._role:GetRelationMaxLevel()
  local curProgress = self._role:GetRelationProgress()
  if curLv < maxLv then
    for i = curLv, maxLv do
      local record = CFavourExp:GetRecorder(i)
      local num
      if rarityId == 1 then
        num = record.Rfavourexp
      elseif rarityId == 2 then
        num = record.SRfavourexp
      elseif rarityId == 3 then
        num = record.SSRfavourexp
      elseif rarityId == 4 then
        num = record.URfavourexp
      elseif rarityId == 5 then
        num = record.EXfavourexp
      end
      if i == curLv then
        self._needExp = self._needExp + num - curProgress
      else
        self._needExp = self._needExp + num
      end
    end
  end
  self._favourGiftType = self._role:GetFavourGiftType()
  local itemList = NekoData.BehaviorManager.BM_BagInfo:GetItemListByTypeID(75)
  local list = {}
  for i, v in ipairs(itemList) do
    local pinJiID = v:GetPinJiID()
    if not list[pinJiID] then
      list[pinJiID] = {}
    end
    table.insert(list[pinJiID], v)
  end
  local temp = {}
  for k, v in pairs(list) do
    table.insert(temp, k)
  end
  table.sort(temp, function(a, b)
    return b < a
  end)
  local map = {}
  for k, v in pairs(list) do
    map[k] = {
      likeItemList = {},
      dislikeItemList = {}
    }
    for i, item in ipairs(v) do
      local favourPresentTypeRecord = CFavourPresentType:GetRecorder(item:GetID())
      if favourPresentTypeRecord.presenttype == self._favourGiftType then
        table.insert(map[k].likeItemList, item)
      else
        table.insert(map[k].dislikeItemList, item)
      end
    end
    table.sort(map[k].likeItemList, function(a, b)
      local a_id, b_id = a:GetID(), b:GetID()
      return a_id < b_id
    end)
  end
  for k, v in pairs(temp) do
    local data = map[v]
    for _, item in ipairs(data.likeItemList) do
      table.insert(self._itemList, item)
    end
  end
  for k, v in pairs(temp) do
    local data = map[v]
    for _, item in ipairs(data.dislikeItemList) do
      table.insert(self._itemList, item)
    end
  end
  if self._selectItem == nil then
    self._selectItem = self._itemList[1]
  elseif self._selectItemIndex then
    for i = self._selectItemIndex, 1, -1 do
      if self._itemList[i] then
        self._selectItem = self._itemList[i]
        break
      end
    end
  end
  self:RefreshSelectItemDetail()
  self._itemFrame:ReloadAllCell()
end

function RoleFavourTabCell:RefreshSelectItemDetail()
  self._detail_name:SetText(self._selectItem:GetName())
  self._detail_description:SetText(self._selectItem:GetDestribe())
  local favourPresentTypeRecord = CFavourPresentType:GetRecorder(self._selectItem:GetID())
  self._heartEffectNum = favourPresentTypeRecord.presentuplevel
  self._favourExpNum = favourPresentTypeRecord.favour
  if favourPresentTypeRecord.presenttype == self._favourGiftType then
    self._heartEffectNum = self._heartEffectNum * 2
    self._favourExpNum = self._favourExpNum + favourPresentTypeRecord.exfavour
  end
  self._sendMaxNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(self._selectItem:GetID())
  self._sendNum = 1
  self._curGiveNumTxt:SetText(self._sendNum)
end

function RoleFavourTabCell:SetSelectItem(item, index)
  if item:GetID() ~= self._selectItem:GetID() then
    self._selectItem = item
    self._selectItemIndex = index
    self:RefreshSelectItemDetail()
    self._itemFrame:FireEvent("SetSelectItem", self._selectItem:GetID())
  end
end

function RoleFavourTabCell:OnReduceBtnClicked()
  if self._sendNum > 1 then
    self._sendNum = self._sendNum - 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100253)
  end
end

function RoleFavourTabCell:OnAddBtnClicked()
  if self._sendNum < self._sendMaxNum then
    self._sendNum = self._sendNum + 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100254)
  end
end

function RoleFavourTabCell:OnMinBtnClicked()
  if self._sendNum ~= 1 then
    self._sendNum = 1
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100253)
  end
end

function RoleFavourTabCell:OnMaxBtnClicked()
  if self._sendNum ~= self._sendMaxNum then
    if self._needExp == 0 then
      self._sendNum = self._sendMaxNum
    else
      self._sendNum = self._sendMaxNum
      local num = math.ceil(self._needExp / self._favourExpNum)
      if num < self._sendMaxNum then
        self._sendNum = num
      end
    end
    self._curGiveNumTxt:SetText(self._sendNum)
  else
    NekoData.BehaviorManager.BM_Message:SendMessageById(100254)
  end
end

function RoleFavourTabCell:OnGiveBtnClicked()
  if self._role:GetRelationLevel() < self._role:GetRelationMaxLevel() then
    local csend = LuaNetManager.CreateProtocol("protocol.good.cpresent")
    csend.roleId = self._role:GetId()
    csend.itemId = self._selectItem:GetID()
    csend.itemNum = self._sendNum
    csend:Send()
    local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog")
    if dialog then
      dialog:CacheGiveItemId(self._selectItem:GetID())
    end
  else
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(89, nil, function()
      local csend = LuaNetManager.CreateProtocol("protocol.good.cpresent")
      csend.roleId = self._role:GetId()
      csend.itemId = self._selectItem:GetID()
      csend.itemNum = self._sendNum
      csend:Send()
      local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog")
      if dialog then
        dialog:CacheGiveItemId(self._selectItem:GetID())
      end
    end, {}, nil, {})
  end
end

function RoleFavourTabCell:NumberOfCell(frame)
  if frame == self._itemFrame then
    return #self._itemList
  else
    return self._heartEffectNum
  end
end

function RoleFavourTabCell:CellAtIndex(frame, index)
  if frame == self._itemFrame then
    return "handbook.favour.givegiftitemcell"
  else
    return "handbook.favour.givegiftheartcell"
  end
end

function RoleFavourTabCell:DataAtIndex(frame, index)
  if frame == self._itemFrame then
    return {
      data = self._itemList[index],
      index = index
    }
  end
end

return RoleFavourTabCell
