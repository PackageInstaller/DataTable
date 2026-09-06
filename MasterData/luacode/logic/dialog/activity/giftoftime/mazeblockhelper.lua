local Item = require("logic.manager.experimental.types.item")
local MazeAwardBlockDef = LuaNetManager.GetBeanDef("protocol.activity.mazeawardblock")
local AnimatorStaticFunctions = CS.PixelNeko.Lua.AnimatorStaticFunctions
local MazeBlockHelper = class("MazeBlockHelper")

function MazeBlockHelper:Ctor(rootElement, indexNum)
  self._rootElement = rootElement
  self._indexNum = indexNum
  self._rootElement:Subscribe_PointerClickEvent(self.OnRootClicked, self)
  self._rootWindowAnimator = AnimatorStaticFunctions.Get(self._rootElement:GetUIObject())
  self._img = self._rootElement:FindChild("CellBack/Img")
  self._text = self._rootElement:FindChild("CellBack/Text")
  self._itemCell = self._rootElement:FindChild("ItemCell")
  self._itemCellIcon = self._rootElement:FindChild("ItemCell/_BackGround/Icon")
  self._itemCellFrame = self._rootElement:FindChild("ItemCell/_BackGround/Frame")
  self._itemCellCount = self._rootElement:FindChild("ItemCell/_Count")
  self._gotImg = self._rootElement:FindChild("GotImg")
  self._player = self._rootElement:FindChild("Player")
  self._dm = NekoData.DataManager.DM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeMazeActivityManagerID)
  if self._text then
    self._text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1981))
  end
end

function MazeBlockHelper:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function MazeBlockHelper:RefreshCell(data, dontTrigger)
  self._data = data
  if self._data.serverData.blockType == 0 then
    self._img:SetActive(true)
    self._itemCell:SetActive(false)
  elseif self._data.serverData.blockType == 1 then
    self._img:SetActive(self._data.serverData.status ~= MazeAwardBlockDef.FETCHED)
    self._itemCell:SetActive(self._data.serverData.status == MazeAwardBlockDef.FETCHED)
  else
    self._img:SetActive(false)
    self._itemCell:SetActive(true)
  end
  if 0 < self._data.serverData.itemId then
    self._item = Item.Create(self._data.serverData.itemId)
    local imageRecord = self._item:GetIcon()
    self._itemCellIcon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    imageRecord = self._item:GetPinJiImage()
    self._itemCellFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    self._itemCellCount:SetText(self._data.serverData.itemNum)
  end
  self._gotImg:SetActive(self._data.serverData.status == MazeAwardBlockDef.FETCHED)
  if self._data.hilight then
    if not dontTrigger then
      self._rootWindowAnimator:SetTrigger("show")
    end
  else
    self._rootWindowAnimator:SetTrigger("hide")
  end
  self._player:SetActive(self._data.player)
end

function MazeBlockHelper:OnRootClicked()
  if self._data.serverData.itemId > 0 then
    local width, height = self._itemCellIcon:GetRectSize()
    local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({
        item = self._item
      })
      tipsDialog:SetTipsPosition(width, height, self._itemCellIcon:GetLocalPointInUiRootPanel())
    end
  end
end

return MazeBlockHelper
