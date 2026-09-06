local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemAttrTable = BeanManager.GetTableByName("item.citemattr")
local CItemPinJiTable = BeanManager.GetTableByName("item.citempinji")
local CBaoShiTable = BeanManager.GetTableByName("item.cbaoshi")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local UIManager = CS.PixelNeko.UI.UIManager
local UIRootOffsetMax
local UIRootPanelOffsetMax = UIManager.GetUiRootPanelOffsetMax()
local GemTipsDialog = class("GemTipsDialog", Dialog)
GemTipsDialog.AssetBundleName = "ui/layouts.equip"
GemTipsDialog.AssetName = "EquipXQGemTips"

function GemTipsDialog:Ctor(...)
  GemTipsDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
end

function GemTipsDialog:OnCreate()
  self._tipsBack = self:GetChild("TipsBack")
  self._icon = self:GetChild("TipsBack/Top/EquipCell/BackGround/Icon")
  self._frame = self:GetChild("TipsBack/Top/EquipCell/BackGround/Frame")
  self._level = self:GetChild("TipsBack/Top/Level/Num")
  self._name = self:GetChild("TipsBack/Top/EquipName")
  self._prop_Icon = self:GetChild("TipsBack/Prop1/Image")
  self._prop_Name = self:GetChild("TipsBack/Prop1/Name")
  self._prop_Num = self:GetChild("TipsBack/Prop1/Num")
  self._settingBtn = self:GetChild("BtnArea/EquipBtn")
  self._settingBtnTxt = self:GetChild("BtnArea/EquipBtn/_Text")
  self._settingBtn:Subscribe_PointerClickEvent(self.OnSettingBtnClick, self)
  self._tipsBack:Subscribe_PointerClickEvent(self.OnMouseClick, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWindowClick, self)
  self._width, self._height = self:GetRootWindow():GetRectSize()
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_Update, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  LuaNotificationCenter.AddObserver(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

function GemTipsDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._delegate then
    self._delegate:OnGemTipsClose()
  end
end

function GemTipsDialog:Init(gemID, equipKey, settingPos, delegate)
  self._gemID = gemID
  self._equipKey = equipKey
  self._settingPos = settingPos
  self._delegate = delegate
  if delegate then
    self._settingBtnTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2278))
  else
    self._settingBtnTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2288))
  end
  local itemRecord = CItemAttrTable:GetRecorder(gemID)
  local record = CImagePathTable:GetRecorder(itemRecord.icon) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(record.assetBundle, record.assetName)
  self._name:SetText(TextManager.GetText(itemRecord.nameTextID))
  local pinJiRecord = CItemPinJiTable:GetRecorder(itemRecord.pinJi)
  record = CImagePathTable:GetRecorder(pinJiRecord.imageDir) or DataCommon.DefaultImageAsset
  self._frame:SetSprite(record.assetBundle, record.assetName)
  local baoShiRecord = CBaoShiTable:GetRecorder(gemID)
  local attrId = baoShiRecord.attrid - math.fmod(tonumber(baoShiRecord.attrid), 10)
  local attrRecord = CAttrNameTable:GetRecorder(attrId)
  local attrValue
  if attrRecord.isDecimal == 1 then
    attrValue = baoShiRecord.attrnum / 1000 * 100
    local str = TextManager.GetText(CStringRes:GetRecorder(1286).msgTextID)
    attrValue = string.gsub(str, "%$parameter1%$", tostring(attrValue))
  else
    attrValue = baoShiRecord.attrnum
  end
  self._prop_Num:SetText(attrValue)
  self._prop_Name:SetText(TextManager.GetText(attrRecord.classnameTextID))
end

local function SetTipsPosition(self, cell_width, cell_height, posX, posY)
  local newPos = {}
  local rightSpaceWidth = UIRootOffsetMax.x - (posX + cell_width / 2)
  if rightSpaceWidth > self._width then
    newPos.x = posX + cell_width / 2 + self._width / 2
  else
    newPos.x = posX - cell_width / 2 - self._width / 2
  end
  if posY + cell_height / 2 - self._height < -UIRootPanelOffsetMax.y then
    newPos.y = -UIRootPanelOffsetMax.y + self._height / 2
  else
    newPos.y = posY + cell_height / 2 - self._height / 2
  end
  self:GetRootWindow():SetAnchoredPosition(newPos.x, newPos.y)
end

function GemTipsDialog:OnUpdate()
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    self._width, self._height = self:GetRootWindow():GetRectSize()
    UIRootOffsetMax = UIManager.GetUiRootOffsetMax()
    if self._parmFunc then
      local parms = self._parmFunc()
      SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
    end
  end
end

function GemTipsDialog:OnScreenPixelChanged()
  self._screenPixelChanged = true
end

function GemTipsDialog:SetTipsParmFunc(parmFunc)
  self._parmFunc = parmFunc
  if parmFunc then
    local parms = parmFunc()
    SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
  end
end

function GemTipsDialog:OnRootWindowClick()
  self:Destroy()
end

function GemTipsDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function GemTipsDialog:OnBackBtnClicked()
  self:Destroy()
end

function GemTipsDialog:OnSettingBtnClick()
  local p = LuaNetManager.CreateProtocol("protocol.item.cequipgeminlay")
  if self._delegate then
    p.operate = 1
  else
    p.operate = 2
  end
  p.equipKey = self._equipKey
  p.pos = self._settingPos
  p.gemId = self._gemID
  p:Send()
  self:Destroy()
end

return GemTipsDialog
