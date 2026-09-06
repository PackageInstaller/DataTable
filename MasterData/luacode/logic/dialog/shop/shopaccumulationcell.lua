local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CRechargeReward = BeanManager.GetTableByName("recharge.crechargerewards")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CRoleItem = BeanManager.GetTableByName("item.croleitem")
local RoleConfig = BeanManager.GetTableByName("role.roleconfig")
local ShopAccumulationCell = class("ShopAccumulationCell", Dialog)
ShopAccumulationCell.AssetBundleName = "ui/layouts.baseshop"
ShopAccumulationCell.AssetName = "AccumulationCell"

function ShopAccumulationCell:Ctor(...)
  ShopAccumulationCell.super.Ctor(self, ...)
  self._rewardList = nil
  self._rewardFrame = nil
end

function ShopAccumulationCell:OnCreate()
  self._backTxt = self:GetChild("Cell/Back/Txt")
  self._pendingBack = self:GetChild("Cell/SpecialBack")
  self._pendingBackTxt = self:GetChild("Cell/SpecialBack/Txt")
  self._doneBack = self:GetChild("Cell/SpecialBack2")
  self._doneBackTxt = self:GetChild("Cell/SpecialBack2/Txt")
  self._requiredLevelText = self:GetChild("Cell/Level/Num")
  self._requiredLevelText2 = self:GetChild("Cell/Lv/LvNum")
  self._canGetImage = self:GetChild("Cell/Get")
  self._gottenImage = self:GetChild("Cell/Done")
  self._canNotGetImage = self:GetChild("Cell/Normal")
  self._loading = self:GetChild("Cell/Loading")
  self._loadingBar = self:GetChild("Cell/Loading/BackGround/Progress")
  self._totalBack = self:GetChild("Cell/Loading/BackGround/Back")
  self._totalTxt = self:GetChild("Cell/Loading/BackGround/Back/Num")
  self._rewardFrameNode = self:GetChild("Cell/ItemFrame")
  self._charSmallCell = self:GetChild("Cell/CharSmallCell")
  self._frame = self:GetChild("Cell/CharSmallCell/Frame")
  self._photo = self:GetChild("Cell/CharSmallCell/Photo")
  self._downRankBack = self:GetChild("Cell/CharSmallCell/DownRankBack")
  self._level = self:GetChild("Cell/CharSmallCell/Level/Num")
  self._rankBack = self:GetChild("Cell/CharSmallCell/RankBack")
  self._rank = self:GetChild("Cell/CharSmallCell/Rank")
  self._job = self:GetChild("Cell/CharSmallCell/Job")
  self._breakLevelBackBlack = self:GetChild("Cell/CharSmallCell/BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("Cell/CharSmallCell/BreakLevelBack")
  self._breakLevelNum = self:GetChild("Cell/CharSmallCell/BreakLevelNum")
  self._breakLevel = self:GetChild("Cell/CharSmallCell/BreakLevel")
  self._element = self:GetChild("Cell/CharSmallCell/Element")
  self._grey = self:GetChild("Cell/CharSmallCell/Grey")
  self._select = self:GetChild("Cell/CharSmallCell/Select")
  self._rewardFrame = GridFrame.Create(self._rewardFrameNode, self, false, 2, false)
  self._canGetImage:Subscribe_PointerClickEvent(self.OnCanGetImageClicked, self)
  self._photo:Subscribe_PointerClickEvent(self.OnCharacterImageClicked, self)
end

function ShopAccumulationCell:OnDestroy()
  self._rewardFrame:Destroy()
end

function ShopAccumulationCell:RefreshCell(data)
  local record = data.record
  self._requiredLevelText:SetText(record.unlockLevel)
  self._requiredLevelText2:SetText(record.unlockLevel)
  local points = self._cellData.record.totalExperience
  local str = TextManager.GetText(CStringRes:GetRecorder(1432).msgTextID)
  str = string.gsub(str, "%$parameter1%$", points)
  self._backTxt:SetText(str)
  self._pendingBackTxt:SetText(str)
  self._doneBackTxt:SetText(str)
  self:SetLoadingBar()
  if record.rarity == 3 then
    self._rewardList = {}
    self._charSmallCell:SetActive(true)
    self._rewardFrameNode:SetActive(false)
    self._pendingBack:SetActive(false)
    self._backTxt:SetActive(true)
    local roleItemID = self._cellData.record.items[1]
    local roleID = CRoleItem:GetRecorder(roleItemID).roleid
    self._role = Role.Create(roleID)
    local image = self._role:GetShapeLittleHeadImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetSmallRarityFrameRecord()
    self._frame:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetRarityBottomBackRecord()
    self._downRankBack:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetRarityImageRecord()
    self._rank:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetVocationImageRecord()
    self._job:SetSprite(image.assetBundle, image.assetName)
    image = self._role:GetElementImageRecord()
    self._element:SetSprite(image.assetBundle, image.assetName)
  else
    self._charSmallCell:SetActive(false)
    self._rewardFrameNode:SetActive(true)
    self._rewardList = {}
    for k, v in ipairs(record.items) do
      local temp = {}
      temp.itemID = v
      temp.itemCount = record.amount[k]
      table.insert(self._rewardList, temp)
    end
    self._rewardFrame:Destroy()
    if #self._rewardList <= 1 then
      self._rewardFrame = GridFrame.Create(self._rewardFrameNode, self, false, 1, false)
    else
      self._rewardFrame = GridFrame.Create(self._rewardFrameNode, self, false, 2, false)
    end
  end
  self:SetBtnState()
  self._rewardFrame:ReloadAllCell()
end

function ShopAccumulationCell:NumberOfCell(frame)
  return #self._rewardList
end

function ShopAccumulationCell:DataAtIndex(frame, index)
  return self._rewardList[index]
end

function ShopAccumulationCell:CellAtIndex(frame, index)
  return "shop.shopaccumulationitemcell"
end

function ShopAccumulationCell:OnCanGetImageClicked()
  local cReceiveShopPointReward = LuaNetManager.CreateProtocol("protocol.good.creceiveshoppointreward")
  if cReceiveShopPointReward then
    cReceiveShopPointReward.id = self._cellData.record.id
    cReceiveShopPointReward:Send()
  end
end

function ShopAccumulationCell:OnCharacterImageClicked()
  local roleItemID = self._cellData.record.items[1]
  local roleID = CRoleItem:GetRecorder(roleItemID).roleid
  local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
  local roleInfoDialog = DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog")
  local roleIDList = {roleID}
  local cfgIDList = {4}
  roleInfoDialog:Init({
    roleIdList = roleIDList,
    cfgIdList = cfgIDList,
    index = 1
  }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
end

function ShopAccumulationCell:SetLoadingBar()
  local record = self._cellData.record
  local len = #CRechargeReward:GetAllIds()
  if record.unlockLevel == 1 then
    self._loading:SetActive(false)
  else
    self._totalBack:SetActive(false)
    self._loading:SetActive(true)
    local currentLevel = NekoData.BehaviorManager.BM_Shop:GetChargAccumulationLevel()
    local currentLevelExp = NekoData.BehaviorManager.BM_Shop:GetChargAccumulationCurrentLevelExp()
    local totalLevelExp = NekoData.BehaviorManager.BM_Shop:GetChargAccumulationTotalScore()
    local lastLevelReward = CRechargeReward:GetRecorder(len)
    local processValue = 0
    local isReachEnd = currentLevel == lastLevelReward.unlockLevel and totalLevelExp >= lastLevelReward.unlockExperience and record.unlockLevel == currentLevel
    if record.unlockLevel == currentLevel + 1 or isReachEnd then
      local totalNum = NekoData.BehaviorManager.BM_Shop:GetChargAccumulationTotalScore()
      if totalNum <= NekoData.BehaviorManager.BM_Shop:GetMaxNeededShopPoints() then
        local currentLevelExp = NekoData.BehaviorManager.BM_Shop:GetChargAccumulationCurrentLevelExp()
        local maxExp = 0
        if len <= currentLevel then
          maxExp = lastLevelReward.totalExperience - CRechargeReward:GetRecorder(len - 1).totalExperience
        else
          maxExp = CRechargeReward:GetRecorder(currentLevel + 1).totalExperience - CRechargeReward:GetRecorder(currentLevel).totalExperience
        end
        processValue = currentLevelExp / maxExp
        self._totalBack:SetActive(true)
        local width = self._loadingBar:GetRectSize()
        local lx, ly, lz = self._totalBack:GetLocalPosition()
        lx = width / 2
        self._totalBack:SetLocalPosition(lx, ly, lz)
        self._totalTxt:SetText(totalNum)
        local dis = width - processValue * width
        lx, ly, lz = self._totalBack:GetLocalPosition()
        if isReachEnd then
          dis = 0
        end
        lx = lx - dis
        self._totalBack:SetLocalPosition(lx, ly, lz)
      end
    end
    if currentLevel >= record.unlockLevel then
      processValue = 1
    end
    self._loadingBar:SetFillAmount(processValue)
  end
end

function ShopAccumulationCell:SetBtnState()
  local data = self._cellData
  if data.isUnlock then
    self._canNotGetImage:SetActive(false)
    if data.hasGotten then
      self._pendingBack:SetActive(false)
      self._doneBack:SetActive(true)
      self._canGetImage:SetActive(false)
      self._gottenImage:SetActive(true)
    else
      self._pendingBack:SetActive(true)
      self._doneBack:SetActive(false)
      self._canGetImage:SetActive(true)
      self._gottenImage:SetActive(false)
    end
  else
    self._canGetImage:SetActive(false)
    self._gottenImage:SetActive(false)
    self._canNotGetImage:SetActive(true)
    self._pendingBack:SetActive(false)
    self._doneBack:SetActive(false)
  end
end

function ShopAccumulationCell:OnEvent(name, args)
  if args.receivedID == self._cellData.record.id then
    self._cellData.hasGotten = true
    self:RefreshCell(self._cellData)
  end
end

return ShopAccumulationCell
