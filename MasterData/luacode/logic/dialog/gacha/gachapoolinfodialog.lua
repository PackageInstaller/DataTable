local CardPool = BeanManager.GetTableByName("item.ccardpool")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local CVarCfg = BeanManager.GetTableByName("var.cvarconfig")
local CstringCfg = BeanManager.GetTableByName("message.cstringres")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CUniqueEquipItem = BeanManager.GetTableByName("item.cuniqueequipitem")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local tenDrawGuidePoolId = tonumber(CVarCfg:GetRecorder(44).Value)
local CheckOtherRoleInfoDialog = require("logic.dialog.mainline.bossrush.checkotherroleinfodialog")
local Role = require("logic.manager.experimental.types.role")
local GachaPoolInfoDialog = class("GachaPoolInfoDialog", Dialog)
GachaPoolInfoDialog.AssetBundleName = "ui/layouts.gacha"
GachaPoolInfoDialog.AssetName = "GachaMainCell"

function GachaPoolInfoDialog:Ctor(...)
  GachaPoolInfoDialog.super.Ctor(self, ...)
  self._tenKeepDrawGuideEffectHandler = nil
  self._delegate = nil
  self._cellData = nil
end

function GachaPoolInfoDialog:OnCreate()
  self._backImage = self:GetChild("BackImage")
  self._time = self:GetChild("DetailBack/Text2")
  self._oneBtn = self:GetChild("One")
  self._onePricePanel = self:GetChild("OnePrice")
  self._onePrice = self:GetChild("OnePrice/Price")
  self._oneImage = self:GetChild("OnePrice/Image")
  self._fiveBtn = self:GetChild("Five")
  self._fivePricePanel = self:GetChild("FivePrice")
  self._fivePrice = self:GetChild("FivePrice/Price")
  self._fiveImage = self:GetChild("FivePrice/Image")
  self._backImageDetailBack_role = self:GetChild("BackImageDetail")
  self._titleTxt = self:GetChild("BackDetail/Title")
  self._titleTxtPosX, self._titleTxtPosOX, self._titleTxtPosY, self._titleTxtPosOY = self._titleTxt:GetPosition()
  self._titleTxtRectX, self._titleTxtRectY = self._titleTxt:GetRectSize()
  self._poolTimeTxt = self:GetChild("BackDetail/Txt4")
  self._poolTimeBack = self:GetChild("BackDetail/TimeImg")
  self._poolSmallTitle = self:GetChild("BackDetail/SmallTitle")
  self._poolSmallTitlePosX, self._poolSmallTitlePosOX, self._poolSmallTitlePosY, self._poolSmallTitlePosOY = self._poolSmallTitle:GetPosition()
  self._poolSmallTitleSizeX, self._poolSmallTitleSizeOX, self._poolSmallTitleSizeY, self._poolSmallTitleSizeOY = self._poolSmallTitle:GetSize()
  self._jobImg = self:GetChild("BackImageDetail/Job")
  self._jobTxt = self:GetChild("BackImageDetail/JobTxt")
  self._rankImg = self:GetChild("BackImageDetail/Rank")
  self._nameTxt = self:GetChild("BackImageDetail/Name")
  self._name2Txt = self:GetChild("BackImageDetail/Name2")
  self._upImage = self:GetChild("BackDetail/UpImg")
  self._backImageDetailBack_equip = self:GetChild("BackEquipDetail")
  self._backImageDetailBack_equip_name = self:GetChild("BackEquipDetail/Name")
  self._backImageDetailBack_equip_roleName = self:GetChild("BackEquipDetail/Name2")
  self._discountBtn = self:GetChild("Sale")
  self._discountPanel = self:GetChild("SalePrice")
  self._discountPrice = self:GetChild("SalePrice/Price")
  self._discountImage = self:GetChild("SalePrice/Image")
  self._discountText = self:GetChild("SalePrice/Txt (1)/Text")
  self._guideTenBtn = self:GetChild("First")
  self._detailBtn = self:GetChild("DetailBtn")
  self._detailPanel = self:GetChild("DetailBack")
  self._recordBtn = self:GetChild("RecordBtn")
  self._restTimes = self:GetChild("GachaNum")
  self._firstGachaDetail = self:GetChild("FirstGachaDetail")
  self._firstGachaDetails = {}
  for i = 1, 4 do
    self._firstGachaDetails[i] = {
      jobImg = self:GetChild("FirstGachaDetail/Char" .. i .. "/Job"),
      jobTxt = self:GetChild("FirstGachaDetail/Char" .. i .. "/JobTxt"),
      rankImg = self:GetChild("FirstGachaDetail/Char" .. i .. "/Rank"),
      nameTxt = self:GetChild("FirstGachaDetail/Char" .. i .. "/Name"),
      name2Txt = self:GetChild("FirstGachaDetail/Char" .. i .. "/Name2")
    }
  end
  self._guaranteedDescribe = self:GetChild("Txt")
  self._guaranteedText = self:GetChild("Txt/Text")
  self._guaranteedUpText = self:GetChild("UpText")
  self._exchangeBtn = self:GetChild("ExchangeBtn")
  self._checkRoleBaseInfoBtn = self:GetChild("CharDetailBtn")
  self._model = self:GetChild("Model")
  self._modelback = self:GetChild("ModelBack")
  self._dayGachaNumPanel = self:GetChild("DayGachaNum")
  self._dayGachaNumText = self:GetChild("DayGachaNum/Text")
  self._discountBtn:Subscribe_PointerClickEvent(self.OnDiscountBtnClick, self)
  self._discountPanel:Subscribe_PointerClickEvent(self.OnDiscountPriceClick, self)
  self._oneBtn:Subscribe_PointerClickEvent(self.OnOneBtnClick, self)
  self._onePricePanel:Subscribe_PointerClickEvent(self.OnOnePriceClick, self)
  self._fiveBtn:Subscribe_PointerClickEvent(self.OnFiveBtnClick, self)
  self._fivePricePanel:Subscribe_PointerClickEvent(self.OnFivePriceClick, self)
  self._detailBtn:Subscribe_PointerClickEvent(self.OnDetailBtnClick, self)
  self._detailPanel:Subscribe_PointerClickEvent(self.OnDetailBtnClick, self)
  self._recordBtn:Subscribe_PointerClickEvent(self.OnRecordBtnClick, self)
  self._guideTenBtn:Subscribe_PointerClickEvent(self.OnTenDrawGuideBtnClick, self)
  self._checkRoleBaseInfoBtn:Subscribe_PointerClickEvent(self.OnCheckRoleBaseInfoBtnClick, self)
  self._checkRoleBaseInfoBtn:SetActive(false)
  self._exchangeBtn:Subscribe_PointerClickEvent(self.OnExchangeBtnClick, self)
end

function GachaPoolInfoDialog:OnDestroy()
  self._delegate = nil
  LuaNotificationCenter.RemoveObserver(self)
end

function GachaPoolInfoDialog:RefreshInfo(data)
  if not data then
    LogWarning("nil data")
    return
  end
  self._onePriceItemId = nil
  self._tenPriceItemId = nil
  self._cellData = data
  local record = CardPool:GetRecorder(data.id)
  local isEquipCardPool = record.cardpooltype == 2
  self._isEquipCardPool = isEquipCardPool
  self._exchangeBtn:SetActive(not self._isEquipCardPool)
  self._checkRoleId = record.roleshow
  self._checkRoleBaseInfoBtn:SetActive(not isEquipCardPool and record.roleshow and record.roleshow ~= 0)
  local image = ImageTable:GetRecorder(record.imageID) or DataCommon.DefaultImageAsset
  self._backImage:SetSprite(image.assetBundle, image.assetName)
  if record.isshowTimeShow < 1 then
    self._detailPanel:SetActive(false)
  elseif record.isshowTimeShow == 1 then
    self._detailPanel:SetActive(true)
    self._time:SetText(record.timeText)
  else
    self._detailPanel:SetActive(true)
    self._time:SetText(TextManager.GetText(record.isshowTimeShow))
  end
  if 1 > record.isshowrightTimeShow then
    self._poolTimeTxt:SetActive(false)
    self._poolTimeBack:SetActive(false)
  elseif record.isshowrightTimeShow == 1 then
    self._poolTimeTxt:SetActive(true)
    self._poolTimeBack:SetActive(true)
    self._poolTimeTxt:SetText(record.rightTimeShow)
  else
    self._poolTimeTxt:SetActive(true)
    self._poolTimeBack:SetActive(true)
    self._poolTimeTxt:SetText(TextManager.GetText(record.isshowrightTimeShow))
  end
  self._titleTxt:SetText(TextManager.GetText(record.poolNameTextID))
  local titlePos = string.split(record.positionText, ",")
  if 1 < #titlePos then
    local pivotX, pivotY = self._titleTxt:GetPivotPosition()
    self._titleTxt:SetPosition(self._titleTxtPosX, tonumber(titlePos[1]) - self._titleTxtRectX * pivotX, self._titleTxtPosY, tonumber(titlePos[2]) - self._titleTxtRectY * pivotY)
  else
    self._titleTxt:SetPosition(self._titleTxtPosX, self._titleTxtPosOX, self._titleTxtPosY, self._titleTxtPosOY)
  end
  if record.smalltitle ~= 0 then
    self._poolSmallTitle:SetActive(true)
    image = ImageTable:GetRecorder(record.smalltitle) or DataCommon.DefaultImageAsset
    self._poolSmallTitle:SetSprite(image.assetBundle, image.assetName)
  else
    self._poolSmallTitle:SetActive(false)
  end
  titlePos = string.split(record.positionsmalltitle, ",")
  local titleSize = string.split(record.scalesmalltitle, ",")
  if 1 < #titlePos and 1 < #titleSize then
    local pivotX, pivotY = self._poolSmallTitle:GetPivotPosition()
    self._poolSmallTitle:SetPosition(self._poolSmallTitlePosX, tonumber(titlePos[1]) - tonumber(titleSize[1]) * pivotX, self._poolSmallTitlePosY, tonumber(titlePos[2]) - tonumber(titleSize[2]) * pivotY)
  else
    self._poolSmallTitle:SetPosition(self._poolSmallTitlePosX, self._poolSmallTitlePosOX, self._poolSmallTitlePosY, self._poolSmallTitlePosOY)
  end
  if 1 < #titleSize then
    self._poolSmallTitle:SetSize(self._poolSmallTitleSizeX, tonumber(titleSize[1]), self._poolSmallTitleSizeY, tonumber(titleSize[2]))
  else
    self._poolSmallTitle:SetSize(self._poolSmallTitleSizeX, self._poolSmallTitleSizeOX, self._poolSmallTitleSizeY, self._poolSmallTitleSizeOY)
  end
  if record.waterLevelimg ~= 0 then
    self._upImage:SetActive(true)
    image = ImageTable:GetRecorder(record.waterLevelimg) or DataCommon.DefaultImageAsset
    self._upImage:SetSprite(image.assetBundle, image.assetName)
  else
    self._upImage:SetActive(false)
  end
  if not isEquipCardPool then
    self._backImageDetailBack_equip:SetActive(false)
    if self._checkRoleId ~= 0 then
      self._backImageDetailBack_role:SetActive(true)
      self._model:SetActive(true)
      self._modelback:SetActive(true)
      self._role = Role.Create(self._checkRoleId)
      local image = self._role:GetModelRecord()
      if self._handler ~= 0 then
        self._model:ReleaseModel(self._handler)
        self._handler = 0
      end
      self._handler = self._model:AddModelSync(image.assetBundle, image.assetName)
      local list = string.split(record.positionrole, ",")
      local position = {
        x = tonumber(list[1]),
        y = tonumber(list[2]),
        z = tonumber(list[3])
      }
      local scale = tonumber(record.scalerole)
      self._model:SetAnchoredPosition(position.x, position.y)
      self._model:SetLocalScale(scale, scale, scale)
      local imageRecord = self._role:GetVocationDescribeImageRecord()
      self._jobImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._jobTxt:SetText(self._role:GetVocationName())
      imageRecord = self._role:GetRarityImageRecord()
      self._rankImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._nameTxt:SetText(self._role:GetRoleName())
      self._name2Txt:SetText(self._role:GetTitleName())
    else
      self._model:SetActive(false)
      self._modelback:SetActive(false)
      self._backImageDetailBack_role:SetActive(false)
    end
  else
    self._backImageDetailBack_equip:SetActive(true)
    self._model:SetActive(false)
    self._modelback:SetActive(false)
    self._backImageDetailBack_role:SetActive(false)
    local itemRecord = CItemAttrTable:GetRecorder(self._checkRoleId)
    if not itemRecord then
      LogErrorFormat("GachaPoolInfoDialog", "item with id %s is not exist in citemattr", self._checkRoleId)
    else
      self._backImageDetailBack_equip_name:SetText(TextManager.GetText(itemRecord.nameTextID))
      local roleId = CUniqueEquipItem:GetRecorder(self._checkRoleId).roleid
      if roleId == DataCommon.LeaderId then
        self._backImageDetailBack_equip_roleName:SetText(NekoData.BehaviorManager.BM_Message:GetString(1433))
      else
        local roleConfigRecord = RoleConfigTable:GetRecorder(roleId)
        self._backImageDetailBack_equip_roleName:SetText(TextManager.GetText(roleConfigRecord.nameTextID))
      end
    end
  end
  if not self._delegate._tenDrawGuide or self._delegate._tenDrawGuide and data.id ~= tenDrawGuidePoolId then
    self._recordBtn:SetActive(true)
    self._oneBtn:SetActive(true)
    self._onePricePanel:SetActive(true)
    self._fiveBtn:SetActive(true)
    self._fivePricePanel:SetActive(true)
    self._dayGachaNumPanel:SetActive(true)
    self._guideTenBtn:SetActive(false)
    self._restTimes:SetActive(false)
    self._firstGachaDetail:SetActive(false)
    local item
    if data.value.display == 1 then
      self._discountBtn:SetActive(true)
      self._discountPanel:SetActive(true)
      self._discountPriceItemId = data.value.chargeItemIdTen
      item = Item.Create(self._discountPriceItemId)
      self._discountPrice:SetText(data.value.chargeItemNumTen)
      if item:GetItemAttr() then
        self._discountImage:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
      end
      self._discountText:SetText(TextManager.GetText(record.discountText))
    else
      self._discountBtn:SetActive(false)
      self._discountPanel:SetActive(false)
    end
    local haveMoney = true
    local haveItem = true
    if data.value.moneyId ~= 0 then
      item = Item.Create(data.value.moneyId)
      self._onePriceItemId = data.value.moneyId
      self._oneCount = data.value.moneyNum
      self._onePrice:SetText(data.value.moneyNum)
      if item:GetItemAttr() then
        self._oneImage:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
      end
      item = Item.Create(data.value.moneyIdTen)
      self._tenPriceItemId = data.value.moneyIdTen
      self._tenCount = data.value.moneyNumTen
      self._fivePrice:SetText(data.value.moneyNumTen)
      if item:GetItemAttr() then
        self._fiveImage:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
      end
    else
      haveMoney = false
    end
    if data.value.itemid ~= 0 then
      if haveMoney then
        local oneItemId = data.value.itemid
        local oneItemNeedNum = data.value.itemnum
        local tenItemId = data.value.itemidTen
        local tenItemNeedNum = data.value.itemnumTen
        local count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(oneItemId)
        item = Item.Create(oneItemId)
        if item:GetItemAttr() then
          local imageRecord = item:GetIcon()
          if oneItemNeedNum <= count then
            self._onePriceItemId = oneItemId
            self._oneImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            self._onePrice:SetText(oneItemNeedNum)
          end
        end
        count = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(tenItemId)
        item = Item.Create(tenItemId)
        if item:GetItemAttr() then
          local imageRecord = item:GetIcon()
          if tenItemNeedNum <= count then
            self._tenPriceItemId = tenItemId
            self._fiveImage:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
            self._fivePrice:SetText(tenItemNeedNum)
          end
        end
      else
        item = Item.Create(data.value.itemid)
        self._onePriceItemId = data.value.itemid
        self._onePrice:SetText(data.value.itemnum)
        if item:GetItemAttr() then
          self._oneImage:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
        end
        item = Item.Create(data.value.itemidTen)
        self._tenPriceItemId = data.value.itemidTen
        self._fivePrice:SetText(data.value.itemnumTen)
        if item:GetItemAttr() then
          self._fiveImage:SetSprite(item:GetIcon().assetBundle, item:GetIcon().assetName)
        end
      end
    else
      haveItem = false
    end
    local str = TextManager.GetText(CstringCfg:GetRecorder(1501).msgTextID)
    local num = NekoData.BehaviorManager.BM_Gacha:GetCurrentDayDrawTimes()
    local limitNum = CVarCfg:GetRecorder(90).Value
    str = string.gsub(str, "%$parameter1%$", tostring(num))
    str = string.gsub(str, "%$parameter2%$", tostring(limitNum))
    self._dayGachaNumText:SetText(str)
    if not haveMoney and not haveItem then
      LogError("GachaPoolInfoDialog", "there is no money or item to draw card")
    end
  elseif self._delegate._tenDrawGuide and data.id == tenDrawGuidePoolId then
    self._recordBtn:SetActive(false)
    self._oneBtn:SetActive(false)
    self._onePricePanel:SetActive(false)
    self._fiveBtn:SetActive(false)
    self._fivePricePanel:SetActive(false)
    self._dayGachaNumPanel:SetActive(false)
    self._discountBtn:SetActive(false)
    self._discountPanel:SetActive(false)
    self._guideTenBtn:SetActive(true)
    self._restTimes:SetActive(true)
    self._firstGachaDetail:SetActive(true)
    local rileIds = CVarCfg:GetRecorder(77).Value
    rileIds = string.split(rileIds, ";")
    for i, id in ipairs(rileIds) do
      local role = Role.Create(tonumber(id))
      local roleDetail = self._firstGachaDetails[i]
      local imageRecord = role:GetVocationDescribeImageRecord()
      roleDetail.jobImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      roleDetail.jobTxt:SetText(role:GetVocationName())
      imageRecord = role:GetRarityImageRecord()
      roleDetail.rankImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      roleDetail.nameTxt:SetText(role:GetRoleName())
      roleDetail.name2Txt:SetText(role:GetTitleName())
    end
    local restTimes = NekoData.BehaviorManager.BM_Gacha:GetDrawTotalTimes() - NekoData.BehaviorManager.BM_Gacha:GetDrawTimes()
    if restTimes < 5 then
      self._restTimes:SetText(NekoData.BehaviorManager.BM_Message:GetString(1278, {
        restTimes + 1,
        NekoData.BehaviorManager.BM_Gacha:GetDrawTotalTimes()
      }))
    else
      if restTimes < NekoData.BehaviorManager.BM_Gacha:GetDrawTotalTimes() then
        restTimes = restTimes + 1
      end
      self._restTimes:SetText(NekoData.BehaviorManager.BM_Message:GetString(1277, {
        restTimes,
        NekoData.BehaviorManager.BM_Gacha:GetDrawTotalTimes()
      }))
    end
  end
  local baoDiNums = data.value.baoDiNums
  local str
  if record.waterLevelType == 1 then
    if 1 < baoDiNums then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1581).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1293).msgTextID)
      end
      str = string.gsub(str, "%$parameter1%$", tostring(baoDiNums))
    elseif baoDiNums == 1 then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1584).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1296).msgTextID)
      end
    end
  elseif record.waterLevelType == 2 then
    if 1 < baoDiNums then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1582).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1294).msgTextID)
      end
      str = string.gsub(str, "%$parameter1%$", tostring(baoDiNums))
    elseif baoDiNums == 1 then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1585).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1297).msgTextID)
      end
    end
  elseif record.waterLevelType == 3 then
    if 1 < baoDiNums then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1583).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1295).msgTextID)
      end
      str = string.gsub(str, "%$parameter1%$", tostring(baoDiNums))
    elseif baoDiNums == 1 then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1586).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1298).msgTextID)
      end
    end
  end
  if str then
    self._guaranteedText:SetText(str)
    self._guaranteedDescribe:SetActive(true)
  else
    self._guaranteedDescribe:SetActive(false)
  end
  local upBaoDiNums = data.value.upBaoDiNums
  str = nil
  if record.waterLevelType2 == 1 then
    if 1 < upBaoDiNums then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1581).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1293).msgTextID)
      end
      str = string.gsub(str, "%$parameter1%$", tostring(upBaoDiNums))
    elseif upBaoDiNums == 1 then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1584).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1296).msgTextID)
      end
    end
  elseif record.waterLevelType2 == 2 then
    if 1 < upBaoDiNums then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1582).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1294).msgTextID)
      end
      str = string.gsub(str, "%$parameter1%$", tostring(upBaoDiNums))
    elseif upBaoDiNums == 1 then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1585).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1297).msgTextID)
      end
    end
  elseif record.waterLevelType2 == 3 then
    if 1 < upBaoDiNums then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1583).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1295).msgTextID)
      end
      str = string.gsub(str, "%$parameter1%$", tostring(upBaoDiNums))
    elseif upBaoDiNums == 1 then
      if self._isEquipCardPool then
        str = TextManager.GetText(CstringCfg:GetRecorder(1586).msgTextID)
      else
        str = TextManager.GetText(CstringCfg:GetRecorder(1298).msgTextID)
      end
    end
  end
  if str then
    self._guaranteedUpText:SetText(str)
    self._guaranteedUpText:SetActive(true)
  else
    self._guaranteedUpText:SetActive(false)
  end
end

function GachaPoolInfoDialog:OnDiscountBtnClick()
  self._delegate:OnDiscountBtnClick()
end

function GachaPoolInfoDialog:OnOneBtnClick()
  self._delegate:OnOneBtnClick()
end

function GachaPoolInfoDialog:OnFiveBtnClick()
  self._delegate:OnFiveBtnClick()
end

function GachaPoolInfoDialog:OnTenDrawGuideBtnClick()
  self._delegate:OnTenDrawGuideBtnClick()
end

function GachaPoolInfoDialog:OnDetailBtnClick()
  if self._isEquipCardPool then
    DialogManager.CreateSingletonDialog("gacha.equip.gachaequipratedialog"):SetData(self._cellData.id)
  else
    local dialog = DialogManager.CreateSingletonDialog("gacha.gacharatedialog")
    if dialog then
      dialog:Init(self._cellData)
    end
  end
end

function GachaPoolInfoDialog:OnRecordBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.card.copendrawcardlog")
  csend:Send()
end

function GachaPoolInfoDialog:OnDiscountPriceClick()
  if self._discountPriceItemId then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = Item.Create(self._discountPriceItemId)
      })
    end
  end
end

function GachaPoolInfoDialog:OnOnePriceClick()
  if self._onePriceItemId then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = Item.Create(self._onePriceItemId)
      })
    end
  end
end

function GachaPoolInfoDialog:OnFivePriceClick()
  if self._tenPriceItemId then
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = Item.Create(self._tenPriceItemId)
      })
    end
  end
end

function GachaPoolInfoDialog:OnCheckRoleBaseInfoBtnClick()
  DialogManager.CreateSingletonDialog("mainline.bossrush.checkotherroleinfodialog"):Init({
    roleIdList = {
      self._checkRoleId
    },
    cfgIdList = {3},
    index = 1
  }, CheckOtherRoleInfoDialog.ShowType.BaseLevelInfo)
end

function GachaPoolInfoDialog:OnExchangeBtnClick()
  NekoData.BehaviorManager.BM_Message:OpenCurrencyExchangeDialog(3)
end

return GachaPoolInfoDialog
