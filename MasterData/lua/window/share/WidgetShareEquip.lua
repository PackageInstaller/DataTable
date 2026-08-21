local WU, DB, REF = require("Common/WindowUtil")(this)
local AU = require("Common/ActorUtil")
local PB = require("Common/PbHelper")
local EU = require("Common/EquipUtil")
local EA = require("Common/EquipAttr")
local m_equip
local m_color = {
  [1] = 2346957670,
  [2] = 2345132902,
  [3] = 3700155238,
  [4] = 3956974950
}

function SetShareInfo(equip)
  m_equip = equip
  local equipQuality = EU.GetEquipQualityById(m_equip.id)
  REF.ShareBG.UITexture.mainTexturePath = "Texture/Background/share_equipment_wide_bg_" .. tostring(equipQuality)
  REF.ShareBGLabel.UILabel.color = CS.NGUIMath.HexToColor(m_color[equipQuality])
  REF.WidgetIconEquip["$SetEquip"](m_equip)
  REF.EquipName.UILabel.text = WU.GetString("EquipName_" .. m_equip.id)
  REF.EquipLevel.UILabel.text = WU.GetString("Window_Level", m_equip.level)
  local desc = WU.GetString("EquipDesc_" .. m_equip.id)
  if desc and desc ~= "" then
    REF.EquipIntruduction.gameObject:SetActive(true)
    REF.EquipIntruduction.UILabel.text = WU.GetString("Window_bracket1", desc)
  else
    REF.EquipIntruduction.gameObject:SetActive(false)
  end
  local equipAttr = EA.GetEquipAttr(m_equip)
  FillAttrList(REF.BaseAttrList, equipAttr.baseAttrMap, true)
  FillAttrList(REF.RandAttrList, equipAttr.randAttrMap, false)
  REF.EquipAttrs.UITable:Reposition()
  REF.ShareInfo.UITable:Reposition()
end

function FillAttrList(refList, attrList, isBase)
  if attrList then
    local displayList = PB.index("AttrTypeSortOrder", 1).list
    local attrShowList = {}
    if isBase then
      for i = 1, #displayList do
        if attrList[displayList[i]] then
          table.insert(attrShowList, attrList[displayList[i]])
        end
      end
    else
      for i = 1, #displayList do
        local attrs = attrList[displayList[i]]
        if attrs then
          for _, v in pairs(attrs) do
            if v then
              table.insert(attrShowList, v)
            end
          end
        end
      end
      if attrList.randAttrUnlockLevels then
        table.insert(attrShowList, attrList.randAttrUnlockLevels)
      end
    end
    local slotCount = #refList
    local slotIndex = 0
    local slotRef
    for i = 1, #attrShowList do
      local attr = attrShowList[i]
      if slotCount > slotIndex then
        slotRef = refList[slotIndex]
      else
        local source = refList[0]["$gameObject"]
        local clone = CS.UnityEngine.GameObject.Instantiate(source, refList.transform)
        clone.name = source.name
        slotRef = _ENV["$"](clone)
        slotCount = slotCount + 1
      end
      slotRef["$gameObject"]:SetActive(true)
      slotRef["$$SetAttr"](attr, {
        quality = EU.GetEquipQualityById(m_equip.id),
        isBase = isBase
      })
      slotIndex = slotIndex + 1
    end
    for i = slotIndex, slotCount - 1 do
      refList[i]["$gameObject"]:SetActive(false)
    end
  else
    refList.gameObject:SetActive(false)
  end
  refList.UITable:Reposition()
end
