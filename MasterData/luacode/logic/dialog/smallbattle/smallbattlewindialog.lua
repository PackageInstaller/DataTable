local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local SmallBattleWinDialog = class("SmallBattleWinDialog", Dialog)
SmallBattleWinDialog.AssetBundleName = "ui/layouts.battlepassnew"
SmallBattleWinDialog.AssetName = "BattlePassNewWin"

function SmallBattleWinDialog:Ctor(...)
  SmallBattleWinDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SmallBattleWinDialog:OnCreate()
  self._finish = self:GetChild("Finish")
  self._text = self:GetChild("Text")
  self._tipsTxt = self:GetChild("Finish/Frame/TipText")
  self._text:SetText(TextManager.GetText(CStringRes:GetRecorder(1479).msgTextID))
  self._item = {
    count = self:GetChild("ItemCell/_Count"),
    frame = self:GetChild("ItemCell/_BackGround/Frame"),
    icon = self:GetChild("ItemCell/_BackGround/Icon")
  }
  self._item.frame:Subscribe_PointerClickEvent(self.OnAwardItemClicked, self)
  self._finish:Subscribe_StateExitEvent(self.OnStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._finish:SetAnimatorTrigger("End")
end

function SmallBattleWinDialog:SetData(data)
  self._data = data
  local item = Item.Create(DataCommon.TimeCrystal)
  self._item._itemData = item
  self._item.icon:SetSprite(item:GetIconAB())
  self._item.frame:SetSprite(item:GetPinJiImageAB())
  self._item.count:SetText(data)
end

function SmallBattleWinDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SmallBattleWinDialog:OnStateExit(handle, statename, normalizedTime)
  if statename == "towerfinish" then
  end
end

function SmallBattleWinDialog:OnGlobalPointerDown()
  self:Destroy()
end

function SmallBattleWinDialog:OnAwardItemClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = self._item._itemData
    })
  end
end

return SmallBattleWinDialog
