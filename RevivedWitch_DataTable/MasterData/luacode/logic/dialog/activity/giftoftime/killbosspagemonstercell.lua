-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/killbosspagemonstercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local Role = require("logic.manager.experimental.types.role")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CClownRoleLevelUp = (BeanManager.GetTableByName)("activity.cclownrolelevelup")
local CMonster_Handbook = (BeanManager.GetTableByName)("handbook.cmonster_handbook")
local CImagepath = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local charNumber = 1
local KillBossPageMonsterCell = class("KillBossPageMonsterCell", Dialog)
KillBossPageMonsterCell.AssetBundleName = "ui/layouts.battlepassnew"
KillBossPageMonsterCell.AssetName = "BattlePassNewBossRushCell"
KillBossPageMonsterCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : KillBossPageMonsterCell, _ENV, CNPCShape
  ((KillBossPageMonsterCell.super).Ctor)(self, ...)
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)
  local npcShapeId = tonumber(1)
  self._showNpcShapeRecorder = CNPCShape:GetRecorder(npcShapeId)
end

KillBossPageMonsterCell.OnCreate = function(self)
  -- function num : 0_1
  self._battleUI = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._battleUI).model = self:GetChild("Monster/Model")
  local modelPivotX, modelPivotY = ((self._battleUI).model):GetPivotPosition()
  local modelRectSizeX, modelRectSizeY = ((self._battleUI).model):GetRectSize()
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPivotDeltaX = modelRectSizeX * modelPivotX
  -- DECOMPILER ERROR at PC20: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPivotDeltaY = modelRectSizeY * modelPivotY
  -- DECOMPILER ERROR at PC29: Confused about usage of register: R8 in 'UnsetPending'

  -- DECOMPILER ERROR at PC30: Confused about usage of register: R7 in 'UnsetPending'

  -- DECOMPILER ERROR at PC31: Confused about usage of register: R6 in 'UnsetPending'

  -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).modelPosX = ((self._battleUI).model):GetPosition()
  self._charModel = self:GetChild("Actor")
  -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._battleUI).photo = self:GetChild("Monster/Model/Photo")
  self._nameText = self:GetChild("Monster/Text")
  self._monsterType = self:GetChild("Monster/MonsterType/Text")
  self._type_N = self:GetChild("Monster/MonsterType/Type_n")
  self._type_In = self:GetChild("Monster/MonsterType/Type_In")
  self._type_D = self:GetChild("Monster/MonsterType/Type_D")
  self._itemImag = self:GetChild("Monster/MonsterReward/Item")
  ;
  (self._itemImag):Subscribe_PointerClickEvent(self.OnItemClicked, self)
  self._itemNum_text = self:GetChild("Monster/MonsterReward/Text")
  self._LvText = self:GetChild("Monster/MonsterLv")
end

KillBossPageMonsterCell.OnDestroy = function(self)
  -- function num : 0_2
end

KillBossPageMonsterCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CMonster_Handbook, CNPCShape, CImagepath
  self._data = data
  ;
  (self._nameText):SetText(data.name)
  ;
  (self._itemNum_text):SetText(data.itemNum)
  self._item = (Item.Create)(data.itemID)
  ;
  (self._itemImag):SetSprite((self._item):GetIconAB())
  ;
  (self._LvText):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1287, {data.lv}))
  local curChallengingId = ((self._bm):GetCurChallengingId())
  -- DECOMPILER ERROR at PC34: Overwrote pending register: R3 in 'AssignReg'

  local isShowChar = .end
  if (self._delegate)._lastBossId and (self._delegate)._lastBossId == (self._data).id then
    (self._type_N):SetActive(false)
    ;
    (self._type_In):SetActive(false)
    ;
    (self._type_D):SetActive(true)
    isShowChar = true
    ;
    (self._monsterType):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1963))
  else
    if data.id == curChallengingId then
      (self._type_N):SetActive(false)
      ;
      (self._type_In):SetActive(true)
      ;
      (self._type_D):SetActive(false)
      isShowChar = true
      ;
      (self._monsterType):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1964))
    else
      if data.result == 1 then
        (self._monsterType):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1963))
        ;
        (self._type_N):SetActive(false)
        ;
        (self._type_In):SetActive(false)
        ;
        (self._type_D):SetActive(true)
      else
        ;
        (self._monsterType):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1965))
        ;
        (self._type_N):SetActive(true)
        ;
        (self._type_In):SetActive(false)
        ;
        (self._type_D):SetActive(false)
      end
    end
  end
  ;
  (self._charModel):SetActive(false)
  if isShowChar then
    (self._charModel):SetActive(true)
  end
  local record = CMonster_Handbook:GetRecorder(data.handbookid)
  local monsterNpcRecorder = CNPCShape:GetRecorder(record.shapeID)
  if not monsterNpcRecorder then
    LogErrorFormat("KillBossPageMonsterCell", "CNPCShape:%s", data.npcid)
  end
  ;
  ((self._battleUI).photo):SetActive(true)
  local image = CImagepath:GetRecorder(record.miniIcon)
  ;
  ((self._battleUI).photo):SetSprite(image.assetBundle, image.assetName)
end

KillBossPageMonsterCell.OnItemClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = self._item})
  end
end

return KillBossPageMonsterCell

