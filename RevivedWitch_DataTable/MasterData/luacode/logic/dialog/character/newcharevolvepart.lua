-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharevolvepart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CharEvolvePart = class("CharEvolvePart")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local CItemSpecialShow = (BeanManager.GetTableByName)("item.citemspecialshow")
local EvolveTag = {Special = 1, Normal = 2}
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local self = nil
CharEvolvePart.OnCreate = function(delegate)
  -- function num : 0_0 , upvalues : self, CharEvolvePart, _ENV
  self = delegate
  self._evolve_roleName = self:GetChild("BackGround/Frame/CharEvolve/Top/CharName")
  self._evolve_point = self:GetChild("BackGround/Frame/CharEvolve/Top/BreakPoint")
  self._evolve_effectPanel = self:GetChild("BackGround/Frame/CharEvolve/Effect")
  self._propertyNode = self:GetChild("BackGround/Frame/CharEvolve/Effect/Property")
  self._changeProNameTxt = self:GetChild("BackGround/Frame/CharEvolve/Effect/Property/Name")
  self._preProTxt = self:GetChild("BackGround/Frame/CharEvolve/Effect/Property/Num")
  self._newPorTxt = self:GetChild("BackGround/Frame/CharEvolve/Effect/Property/Num2")
  self._evolve_evolveBtn = self:GetChild("BackGround/Frame/CharEvolve/EvolveBtn")
  self._evolve_item1Back = self:GetChild("BackGround/Frame/CharEvolve/Back1")
  self._evolve_item1BackImg = self:GetChild("BackGround/Frame/CharEvolve/Back1/Image")
  self._evolve_item1 = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1")
  self._evolve_item1Panel = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_BackGround")
  self._evolve_item1Rank = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_BackGround/Frame")
  self._evolve_item1Icon = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_BackGround/Icon")
  self._evolve_item1Select = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_BackGround/Select")
  self._evolve_item1SelectImg = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_BackGround/Select/Image")
  self._evolve_item1Num = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_Count/Num")
  self._evolve_item1NumBack = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_Count/NumBack")
  self._evolve_item1NumRed = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_Count/NumRed")
  self._evolve_item1NeedNum = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_Count/Max")
  self._evolve_item1NumDivide = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell1/_Count/Text")
  self._evolve_item1Name = self:GetChild("BackGround/Frame/CharEvolve/ItemName1")
  self._evolve_item2Back = self:GetChild("BackGround/Frame/CharEvolve/Back2")
  self._evolve_item2BackImg = self:GetChild("BackGround/Frame/CharEvolve/Back2/Image")
  self._evolve_item2 = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2")
  self._evolve_item2Panel = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_BackGround")
  self._evolve_item2Rank = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_BackGround/Frame")
  self._evolve_item2Icon = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_BackGround/Icon")
  self._evolve_item2Select = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_BackGround/Select")
  self._evolve_item2SelectImg = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_BackGround/Select/Image")
  self._evolve_item2Num = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_Count/Num")
  self._evolve_item2NumRed = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_Count/NumRed")
  self._evolve_item2NeedNum = self:GetChild("BackGround/Frame/CharEvolve/CharEvolveItemCell2/_Count/Max")
  self._evolve_item2Name = self:GetChild("BackGround/Frame/CharEvolve/ItemName2")
  self._evolve_successEffect = self:GetChild("BackGround/EffectJinHua")
  self._evolve_maxPanel = self:GetChild("BackGround/Frame/CharEvolve/Max")
  ;
  (self._evolve_evolveBtn):Subscribe_PointerClickEvent(CharEvolvePart.OnEvolveBtnClick, self)
  ;
  (self._evolve_item1BackImg):Subscribe_PointerClickEvent(CharEvolvePart.SelectSpecialItem, self)
  ;
  (self._evolve_item2BackImg):Subscribe_PointerClickEvent(CharEvolvePart.SelectNormalItem, self)
  ;
  (self._evolve_item1Icon):Subscribe_PointerClickEvent(CharEvolvePart.OnSpecialItemIconClick, self)
  ;
  (self._evolve_item2Icon):Subscribe_PointerClickEvent(CharEvolvePart.OnNormalItemIconClick, self)
  self._evolve_item2Back_rx = (self._evolve_item2Back):GetRectSize()
  self._evolve_item1_x = (self._evolve_item1):GetPosition()
  self._evolve_item1Back_x = (self._evolve_item1Back):GetPosition()
  self._evolve_item1Name_x = (self._evolve_item1Name):GetPosition()
  ;
  (LuaNotificationCenter.AddObserver)(CharEvolvePart, CharEvolvePart.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
end

CharEvolvePart.OnDestroy = function()
  -- function num : 0_1 , upvalues : self, _ENV, CharEvolvePart
  if self._evolve_successEffectHandler then
    (self._evolve_successEffect):ReleaseEffect(self._evolve_successEffectHandler)
    self._evolve_successEffectHandler = nil
  end
  self = nil
  ;
  (LuaNotificationCenter.RemoveObserver)(CharEvolvePart)
end

CharEvolvePart.RefreshEvolveInfo = function()
  -- function num : 0_2 , upvalues : self, _ENV, Item, CItemSpecialShow, EvolveTag, CharEvolvePart
  (self._evolve_roleName):SetText((self._data):GetRoleName())
  local curLv = (self._data):GetEvolution()
  local maxLv = (self._data):GetEvolutionLimit()
  local changeProName = (self._data):GetEvolutionChangeProName()
  local addProOriginal = (self._data):GetEvolutionAddProOriginalValue()
  local newProValue = (self._data):GetEvolutionNewProValue()
  ;
  (self._changeProNameTxt):SetText(changeProName)
  ;
  (self._preProTxt):SetText(addProOriginal)
  ;
  (self._newPorTxt):SetText(newProValue)
  self._evolve_showSuccessData = {curLv = curLv, maxLv = maxLv, id = (self._data):GetId(), changeProName = changeProName, addProOriginal = addProOriginal, newProValue = newProValue}
  local str = ""
  for i = 1, maxLv do
    if i <= curLv then
      str = str .. "1"
    else
      str = str .. "0"
    end
  end
  ;
  (self._evolve_point):SetText(str)
  if curLv == maxLv then
    (self._propertyNode):SetActive(false)
    ;
    (self._evolve_effectPanel):SetActive(false)
    ;
    (self._evolve_evolveBtn):SetActive(false)
    ;
    (self._evolve_item1Back):SetActive(false)
    ;
    (self._evolve_item1):SetActive(false)
    ;
    (self._evolve_item1Select):SetActive(false)
    ;
    (self._evolve_item1Name):SetActive(false)
    ;
    (self._evolve_item2Back):SetActive(false)
    ;
    (self._evolve_item2):SetActive(false)
    ;
    (self._evolve_item2Select):SetActive(false)
    ;
    (self._evolve_item2Name):SetActive(false)
    ;
    (self._evolve_maxPanel):SetActive(true)
    return -1
  else
    ;
    (self._propertyNode):SetActive(true)
    ;
    (self._evolve_effectPanel):SetActive(true)
    ;
    (self._evolve_evolveBtn):SetActive(true)
    ;
    (self._evolve_item1Back):SetActive(true)
    ;
    (self._evolve_item1):SetActive(true)
    ;
    (self._evolve_item1Select):SetActive(false)
    ;
    (self._evolve_item1Name):SetActive(true)
    ;
    (self._evolve_item2Back):SetActive(true)
    ;
    (self._evolve_item2):SetActive(true)
    ;
    (self._evolve_item2Name):SetActive(true)
    ;
    (self._evolve_item2Select):SetActive(false)
    ;
    (self._evolve_maxPanel):SetActive(false)
  end
  local t1 = (self._data):GetEvolutionExclusiveItem()
  t1 = (string.split)(t1, "_")
  local t1id = tonumber(t1[1])
  local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(t1id)
  self._specialItem = {item = (Item.Create)(t1id), num = count}
  self._specialNeedNum = tonumber(t1[2])
  do
    if (self._data):GetIsLeader() and count == 0 then
      local record = CItemSpecialShow:GetRecorder(t1id)
      if record then
        self._specialItem = {item = (Item.Create)(record.showItemID)}
        self._specialNeedNum = nil
      else
        LogWarningFormat("CharEvolvePart", "leader evolve item %s doesnt have specialItem in citemspecialshow", t1id)
      end
    end
    local imageRecord = ((self._specialItem).item):GetIcon()
    ;
    (self._evolve_item1Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = ((self._specialItem).item):GetPinJiImage()
    ;
    (self._evolve_item1Rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    if self._specialNeedNum then
      (self._evolve_item1NeedNum):SetActive(true)
      ;
      (self._evolve_item1NeedNum):SetText(self._specialNeedNum)
      ;
      (self._evolve_item1NumDivide):SetActive(true)
      ;
      (self._evolve_item1NumBack):SetActive(true)
    else
      ;
      (self._evolve_item1NeedNum):SetActive(false)
      ;
      (self._evolve_item1NumDivide):SetActive(false)
      ;
      (self._evolve_item1NumBack):SetActive(false)
    end
    if (self._specialItem).num then
      if self._specialNeedNum <= (self._specialItem).num then
        self._specialItemEnough = true
        ;
        (self._evolve_item1Num):SetText((self._specialItem).num)
        ;
        (self._evolve_item1Num):SetActive(true)
        ;
        (self._evolve_item1NumRed):SetActive(false)
      else
        self._specialItemEnough = false
        ;
        (self._evolve_item1NumRed):SetText((self._specialItem).num)
        ;
        (self._evolve_item1Num):SetActive(false)
        ;
        (self._evolve_item1NumRed):SetActive(true)
      end
    else
      self._specialItemEnough = false
      ;
      (self._evolve_item1Num):SetActive(false)
      ;
      (self._evolve_item1NumRed):SetActive(false)
    end
    ;
    (self._evolve_item1Name):SetText(((self._specialItem).item):GetName())
    if (self._data):GetIsLeader() then
      (self._evolve_item2):SetActive(false)
      ;
      (self._evolve_item2Name):SetActive(false)
      ;
      (self._evolve_item2Back):SetActive(false)
      ;
      (self._evolve_item2Select):SetActive(false)
      ;
      (self._evolve_item1):SetPosition(self._evolve_item1_x, self._evolve_item1_ox + self._evolve_item2Back_rx / 2, self._evolve_item1_y, self._evolve_item1_oy)
      ;
      (self._evolve_item1Back):SetPosition(self._evolve_item1Back_x, self._evolve_item1Back_ox + self._evolve_item2Back_rx / 2, self._evolve_item1Back_y, self._evolve_item1Back_oy)
      ;
      (self._evolve_item1Name):SetPosition(self._evolve_item1Name_x, self._evolve_item1Name_ox + self._evolve_item2Back_rx / 2, self._evolve_item1Name_y, self._evolve_item1Name_oy)
    else
      ;
      (self._evolve_item2):SetActive(true)
      ;
      (self._evolve_item2Name):SetActive(true)
      ;
      (self._evolve_item2Back):SetActive(true)
      ;
      (self._evolve_item2Select):SetActive(false)
      ;
      (self._evolve_item1):SetPosition(self._evolve_item1_x, self._evolve_item1_ox, self._evolve_item1_y, self._evolve_item1_oy)
      ;
      (self._evolve_item1Back):SetPosition(self._evolve_item1Back_x, self._evolve_item1Back_ox, self._evolve_item1Back_y, self._evolve_item1Back_oy)
      ;
      (self._evolve_item1Name):SetPosition(self._evolve_item1Name_x, self._evolve_item1Name_ox, self._evolve_item1Name_y, self._evolve_item1Name_oy)
      local t2 = (self._data):GetEvolutionCurrentItem()
      t2 = (string.split)(t2, "_")
      local t2id = tonumber(t2[1])
      count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(t2id)
      self._normalItem = {item = (Item.Create)(t2id), num = count}
      self._normalNeedNum = tonumber(t2[2])
      imageRecord = ((self._normalItem).item):GetIcon()
      ;
      (self._evolve_item2Icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      imageRecord = ((self._normalItem).item):GetPinJiImage()
      ;
      (self._evolve_item2Rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._evolve_item2NeedNum):SetText(self._normalNeedNum)
      if self._normalNeedNum <= (self._normalItem).num then
        self._normalItemEnough = true
        ;
        (self._evolve_item2Num):SetText((self._normalItem).num)
        ;
        (self._evolve_item2Num):SetActive(true)
        ;
        (self._evolve_item2NumRed):SetActive(false)
      else
        self._normalItemEnough = false
        ;
        (self._evolve_item2NumRed):SetText((self._normalItem).num)
        ;
        (self._evolve_item2Num):SetActive(false)
        ;
        (self._evolve_item2NumRed):SetActive(true)
      end
      ;
      (self._evolve_item2Name):SetText(((self._normalItem).item):GetName())
    end
    do
      if not self._evolve_selectTag then
        self._evolve_selectTag = EvolveTag.Special
      end
      if self._evolve_selectTag == EvolveTag.Special then
        (CharEvolvePart.SelectSpecialItem)()
      else
        if self._evolve_selectTag == EvolveTag.Normal then
          (CharEvolvePart.SelectNormalItem)()
        else
          ;
          (self._evolve_item1Select):SetActive(false)
          ;
          (self._evolve_item2Select):SetActive(false)
          ;
          (self._evolve_evolveBtn):SetInteractable(false)
        end
      end
    end
  end
end

CharEvolvePart.ClearSelectTag = function()
  -- function num : 0_3 , upvalues : self
  self._evolve_selectTag = nil
end

CharEvolvePart.OnEvolveBtnClick = function()
  -- function num : 0_4 , upvalues : self, _ENV, EvolveTag
  self._evolve_canRefresh = false
  if (self._specialItemEnough or self._normalItemEnough) and self._evolve_selectTag then
    local cSend = (LuaNetManager.CreateProtocol)("protocol.login.cevolution")
    cSend.roleId = (self._data):GetRoleId()
    if self._evolve_selectTag == EvolveTag.Special then
      cSend.itemId = ((self._specialItem).item):GetID()
      cSend.itemNum = self._specialNeedNum
    else
      if self._evolve_selectTag == EvolveTag.Normal then
        cSend.itemId = ((self._normalItem).item):GetID()
        cSend.itemNum = self._normalNeedNum
      end
    end
    cSend:Send()
  end
end

CharEvolvePart.SelectSpecialItem = function()
  -- function num : 0_5 , upvalues : self, EvolveTag
  self._evolve_selectTag = EvolveTag.Special
  ;
  (self._evolve_item1Select):SetActive(true)
  ;
  (self._evolve_item2Select):SetActive(false)
  ;
  (self._evolve_item1Back):SetActive(false)
  ;
  (self._evolve_item2Back):SetActive(not (self._data):GetIsLeader())
  if self._specialItemEnough then
    (self._evolve_evolveBtn):SetInteractable(true)
  else
    ;
    (self._evolve_evolveBtn):SetInteractable(false)
  end
end

CharEvolvePart.UnSelectSpecialItem = function()
  -- function num : 0_6 , upvalues : self
  self._evolve_selectTag = nil
  ;
  (self._evolve_item1Select):SetActive(false)
  ;
  (self._evolve_item1Back):SetActive(true)
  ;
  (self._evolve_evolveBtn):SetInteractable(false)
end

CharEvolvePart.SelectNormalItem = function()
  -- function num : 0_7 , upvalues : self, EvolveTag
  self._evolve_selectTag = EvolveTag.Normal
  ;
  (self._evolve_item1Select):SetActive(false)
  ;
  (self._evolve_item2Select):SetActive(true)
  ;
  (self._evolve_item1Back):SetActive(true)
  ;
  (self._evolve_item2Back):SetActive(false)
  if self._normalItemEnough then
    (self._evolve_evolveBtn):SetInteractable(true)
  else
    ;
    (self._evolve_evolveBtn):SetInteractable(false)
  end
end

CharEvolvePart.UnSelectNormalItem = function()
  -- function num : 0_8 , upvalues : self
  self._evolve_selectTag = nil
  ;
  (self._evolve_item2Select):SetActive(false)
  ;
  (self._evolve_item2Back):SetActive(true)
  ;
  (self._evolve_evolveBtn):SetInteractable(false)
end

CharEvolvePart.OnRoleInfoChange = function(nouse, notification)
  -- function num : 0_9 , upvalues : _ENV, self, SHOWTALKTYPE
  if (notification.userInfo).name == "sevolution" then
    local dialog = (DialogManager.CreateSingletonDialog)("character.newcharevolvesuccessdialog")
    if dialog then
      local data = {role = self._data, effect = 1008, showSuccessData = self._evolve_showSuccessData, type = SHOWTALKTYPE.Evolve}
      dialog:SetData(data)
    end
  end
end

CharEvolvePart.OnSpecialItemIconClick = function()
  -- function num : 0_10 , upvalues : self, _ENV
  local data = self._specialItem
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init(data)
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

CharEvolvePart.OnNormalItemIconClick = function()
  -- function num : 0_11 , upvalues : self, _ENV
  local data = self._normalItem
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init(data)
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

CharEvolvePart.OnEvolveSuccessEffectEnd = function(ins, handler, stateName, normalizedTime)
  -- function num : 0_12 , upvalues : _ENV, self
  if stateName == "UI_TX_jinhua" then
    (DialogManager.DestroySingletonDialog)("guide.blockclickdialog")
    if self._evolve_successEffectHandler then
      self._evolve_successEffectHandler = nil
    end
    ;
    ((DialogManager.CreateSingletonDialog)("character.newcharevolvesuccessdialog")):SetData(self._evolve_showSuccessData)
  end
end

return CharEvolvePart

