-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/smallbattle/smallbattlewindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local SmallBattleWinDialog = class("SmallBattleWinDialog", Dialog)
SmallBattleWinDialog.AssetBundleName = "ui/layouts.battlepassnew"
SmallBattleWinDialog.AssetName = "BattlePassNewWin"
SmallBattleWinDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SmallBattleWinDialog
  ((SmallBattleWinDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SmallBattleWinDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CStringRes
  self._finish = self:GetChild("Finish")
  self._text = self:GetChild("Text")
  self._tipsTxt = self:GetChild("Finish/Frame/TipText")
  ;
  (self._text):SetText((TextManager.GetText)((CStringRes:GetRecorder(1479)).msgTextID))
  self._item = {count = self:GetChild("ItemCell/_Count"), frame = self:GetChild("ItemCell/_BackGround/Frame"), icon = self:GetChild("ItemCell/_BackGround/Icon")}
  ;
  ((self._item).frame):Subscribe_PointerClickEvent(self.OnAwardItemClicked, self)
  ;
  (self._finish):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (self._finish):SetAnimatorTrigger("End")
end

SmallBattleWinDialog.SetData = function(self, data)
  -- function num : 0_2 , upvalues : Item, _ENV
  self._data = data
  local item = (Item.Create)(DataCommon.TimeCrystal)
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._item)._itemData = item
  ;
  ((self._item).icon):SetSprite(item:GetIconAB())
  ;
  ((self._item).frame):SetSprite(item:GetPinJiImageAB())
  ;
  ((self._item).count):SetText(data)
end

SmallBattleWinDialog.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SmallBattleWinDialog.OnStateExit = function(self, handle, statename, normalizedTime)
  -- function num : 0_4
  if statename == "towerfinish" then
  end
end

SmallBattleWinDialog.OnGlobalPointerDown = function(self)
  -- function num : 0_5
  self:Destroy()
end

SmallBattleWinDialog.OnAwardItemClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (self._item)._itemData})
  end
end

return SmallBattleWinDialog

