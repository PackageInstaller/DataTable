-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharbreakpart.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CharBreakPart = class("CharBreakPart")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CItemSpecialShow = (BeanManager.GetTableByName)("item.citemspecialshow")
local CSkin = (BeanManager.GetTableByName)("role.cskin")
local AttrTypeEnum = (LuaNetManager.GetBeanDef)("protocol.login.attrtype")
local SHOWTALKTYPE = {Evolve = 1, Break = 2}
local self = nil
CharBreakPart.OnCreate = function(delegate)
  -- function num : 0_0 , upvalues : self, TableFrame, CharBreakPart, _ENV
  self = delegate
  self._break_roleName = self:GetChild("BackGround/Frame/CharBreak/Top/CharName")
  self._break_upPanel = self:GetChild("BackGround/Frame/CharBreak/Up")
  self._break_levelLeftBackBack = self:GetChild("BackGround/Frame/CharBreak/Up/BreakLevelLeftBackBlack")
  self._break_levelLeftBack = self:GetChild("BackGround/Frame/CharBreak/Up/BreakLevelLeftBack")
  self._break_levelLeft = self:GetChild("BackGround/Frame/CharBreak/Up/BreakLevelNumLeft")
  self._break_levelRight = self:GetChild("BackGround/Frame/CharBreak/Up/BreakLevelNumRight")
  self._break_lockSkinPanel = self:GetChild("BackGround/Frame/CharBreak/Up/Lock")
  self._break_lockSkinLabel = self:GetChild("BackGround/Frame/CharBreak/Up/Lock/Txt3")
  self._break_propertyPanel = self:GetChild("BackGround/Frame/CharBreak/Property")
  self._break_healthNum = self:GetChild("BackGround/Frame/CharBreak/Property/Health/Num")
  self._break_phyAtkNum = self:GetChild("BackGround/Frame/CharBreak/Property/PhyAtk/Num")
  self._break_phyDefNum = self:GetChild("BackGround/Frame/CharBreak/Property/PhyDef/Num")
  self._break_magDefNum = self:GetChild("BackGround/Frame/CharBreak/Property/MagDef/Num")
  self._break_bottomPanel = self:GetChild("BackGround/Frame/CharBreak/Bottom")
  self._break_needLv = self:GetChild("BackGround/Frame/CharBreak/Bottom/CostItem/Txt2")
  self._break_needLvRed = self:GetChild("BackGround/Frame/CharBreak/Bottom/CostItem/Txt2Red")
  self._break_needItemPanel = self:GetChild("BackGround/Frame/CharBreak/Bottom/CostItem/Item")
  self._break_needMana = self:GetChild("BackGround/Frame/CharBreak/Bottom/Cost/Txt2")
  self._break_needManaRed = self:GetChild("BackGround/Frame/CharBreak/Bottom/Cost/Txt2Red")
  self._break_needManaIcon = self:GetChild("BackGround/Frame/CharBreak/Bottom/Cost/Soul")
  self._break_breakBtn = self:GetChild("BackGround/Frame/CharBreak/Bottom/Cost/CommonButton2")
  self._levelWarning = self:GetChild("BackGround/Frame/CharBreak/Bottom/LevelWarning")
  self._break_maxPanel = self:GetChild("BackGround/Frame/CharBreak/Max")
  self._break_frame = (TableFrame.Create)(self._break_needItemPanel, self, false, false)
  ;
  (self._break_frame):SetMargin(15, 0)
  ;
  (self._break_breakBtn):Subscribe_PointerClickEvent(CharBreakPart.OnBreakBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(CharBreakPart, CharBreakPart.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
end

CharBreakPart.OnDestroy = function()
  -- function num : 0_1 , upvalues : self, _ENV, CharBreakPart
  self = nil
  ;
  (LuaNotificationCenter.RemoveObserver)(CharBreakPart)
end

CharBreakPart.RefreshBreakInfo = function()
  -- function num : 0_2 , upvalues : self, _ENV, AttrTypeEnum, CSkin, CStringRes, CItemSpecialShow
  self._data = ((NekoData.BehaviorManager).BM_AllRoles):GetRole((self._data):GetRoleId())
  ;
  (self._break_roleName):SetText((self._data):GetRoleName())
  local data = self._data
  local properties = data:GetCurLvBasePro()
  self._break_showSuccessData = {role = data, curLv = data:GetLevel(), curMaxLv = data:GetMaxLevelIgnorePlayerLv(), curBreakLv = data:GetBreakLv(), nextMaxLv = data:GetNextBreakMaxLevel(), nextBreakLv = data:GetNextBreakLv(), maxBreakLv = data:GetMaxBreakLv(), gainSkin = 0, curHp = properties[AttrTypeEnum.MAX_HP], curAttack = properties[AttrTypeEnum.ATTACK], curDefend = properties[AttrTypeEnum.DEFEND], curMagicDefend = properties[AttrTypeEnum.MAGIC_DEFEND]}
  if (self._break_showSuccessData).curBreakLv == (self._break_showSuccessData).maxBreakLv then
    (self._break_upPanel):SetActive(false)
    ;
    (self._break_bottomPanel):SetActive(false)
    ;
    (self._break_propertyPanel):SetActive(false)
    ;
    (self._break_maxPanel):SetActive(true)
    return -1
  else
    ;
    (self._break_bottomPanel):SetActive(true)
    ;
    (self._break_upPanel):SetActive(true)
    ;
    (self._break_propertyPanel):SetActive(true)
    ;
    (self._break_maxPanel):SetActive(false)
  end
  local currentBreakLv = data:GetBreakLv()
  ;
  (self._break_levelLeftBackBack):SetActive(currentBreakLv == 0)
  ;
  (self._break_levelLeftBack):SetActive(currentBreakLv > 0)
  ;
  (self._break_levelLeft):SetActive(currentBreakLv > 0)
  if currentBreakLv > 0 then
    (self._break_levelLeft):SetText(currentBreakLv)
  end
  local nextBreakLV = data:GetNextBreakLv()
  if nextBreakLV then
    (self._break_levelRight):SetText(nextBreakLV)
  end
  local unlockLive2DSkinId = data:GetUnlockLive2DSkinIdByNextBreak()
  if unlockLive2DSkinId then
    (self._break_lockSkinPanel):SetActive(true)
    local skinRecorder = CSkin:GetRecorder(unlockLive2DSkinId)
    if skinRecorder then
      local name = ((TextManager.GetText)(skinRecorder.skinNameTextID))
      local str = nil
      str = ((NekoData.BehaviorManager).BM_Message):GetString(1519, {name})
      ;
      (self._break_lockSkinLabel):SetText(str)
    else
      LogErrorFormat("RefreshBreakInfo", "No skinRecorder by id：%s", unlockLive2DSkinId)
    end
  else
    (self._break_lockSkinPanel):SetActive(false)
  end
  for key,_ in pairs(self._breakItemList) do
    -- DECOMPILER ERROR at PC179: Confused about usage of register: R10 in 'UnsetPending'

    (self._breakItemList)[key] = nil
  end
  local breakLvRange = data:GetBreakLvRange()
  if breakLvRange ~= nil and #breakLvRange >= 4 then
    local pStr = (TextManager.GetText)((CStringRes:GetRecorder(1401)).msgTextID)
    ;
    (self._break_healthNum):SetText((string.format)("%d%s", breakLvRange[1] // 100, pStr))
    ;
    (self._break_phyAtkNum):SetText((string.format)("%d%s", breakLvRange[2] // 100, pStr))
    ;
    (self._break_phyDefNum):SetText((string.format)("%d%s", breakLvRange[3] // 100, pStr))
    ;
    (self._break_magDefNum):SetText((string.format)("%d%s", breakLvRange[4] // 100, pStr))
  else
    (self._break_propertyPanel):SetActive(false)
  end
  self._mana = ((NekoData.BehaviorManager).BM_Currency):GetMoney()
  if (self._break_showSuccessData).nextBreakLv and (self._break_showSuccessData).curBreakLv < (self._break_showSuccessData).nextBreakLv then
    (self._break_bottomPanel):SetActive(true)
    self._breakItemList = data:GetBreakItemList()
    if (self._break_showSuccessData).curMaxLv <= (self._break_showSuccessData).curLv then
      (self._break_needLv):SetText(data:GetShowMaxBreakLv())
      ;
      (self._break_needLv):SetActive(true)
      ;
      (self._break_needLvRed):SetActive(false)
      ;
      (self._levelWarning):SetActive(false)
      ;
      (self._break_needManaIcon):SetActive(true)
      if data:GetBreakSoul() <= self._mana then
        (self._break_needMana):SetNumber(data:GetBreakSoul())
        ;
        (self._break_needMana):SetActive(true)
        ;
        (self._break_needManaRed):SetActive(false)
      else
        (self._break_needManaRed):SetNumber(data:GetBreakSoul())
        ;
        (self._break_needMana):SetActive(false)
        ;
        (self._break_needManaRed):SetActive(true)
      end
    else
      (self._break_needLvRed):SetText(data:GetShowMaxBreakLv())
      ;
      (self._break_needLv):SetActive(false)
      ;
      (self._break_needLvRed):SetActive(true)
      ;
      (self._levelWarning):SetActive(true)
      ;
      (self._break_needMana):SetActive(false)
      ;
      (self._break_needManaRed):SetActive(false)
      ;
      (self._break_needManaIcon):SetActive(false)
    end
  else
    (self._break_bottomPanel):SetActive(false)
  end
  local tag = true
  for i,v in ipairs(self._breakItemList) do
    local count = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(v.itemId)
    if count < v.itemNum then
      tag = false
      if data:GetIsLeader() and count == 0 then
        local record = CItemSpecialShow:GetRecorder(v.itemId)
        if record then
          v.itemId = record.showItemID
          v.itemNum = nil
        else
          LogWarningFormat("CharBreakPart", "leader break item %s doesnt have specialItem in citemspecialshow", v.itemId)
        end
      end
    end
  end
  ;
  (self._break_frame):ReloadAllCell()
  ;
  (self._break_breakBtn):SetInteractable(data:GetBreakSoul() <= self._mana and (self._break_showSuccessData).curLv == (self._break_showSuccessData).curMaxLv and not tag or not (self._break_showSuccessData).nextBreakLv or (self._break_showSuccessData).curBreakLv < (self._break_showSuccessData).nextBreakLv)
  -- DECOMPILER ERROR: 20 unprocessed JMP targets
end

CharBreakPart.OnBreakBtnClick = function()
  -- function num : 0_3 , upvalues : self, _ENV
  self._break_canRefresh = false
  if not self._break_forbidSendProtocol then
    local protocol = (LuaNetManager.CreateProtocol)("protocol.login.crolebreak")
    if protocol then
      self._break_forbidSendProtocol = true
      protocol.roleId = (self._data):GetRoleId()
      protocol:Send()
    end
  end
end

CharBreakPart.OnRoleInfoChange = function(nouse, notification)
  -- function num : 0_4 , upvalues : self, _ENV, SHOWTALKTYPE
  -- DECOMPILER ERROR at PC7: Confused about usage of register: R2 in 'UnsetPending'

  if (notification.userInfo).name == "sroleupdatebreaklv" then
    (self._break_showSuccessData).gainSkin = (notification.userInfo).gainSkin
    local dialog = (DialogManager.CreateSingletonDialog)("character.newcharbreaksuccessdialog")
    if dialog then
      dialog:SetData({role = self._data, effect = 1022, showSuccessData = self._break_showSuccessData, type = SHOWTALKTYPE.Break})
    end
    self._break_forbidSendProtocol = false
  end
end

return CharBreakPart

