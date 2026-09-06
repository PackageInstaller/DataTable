local CStringRes = BeanManager.GetTableByName("message.cstringres")
local NumberManager = {}
local showKind = 0
local fallbackKind = 0
local W_Str = TextManager.GetText(701764)
local WAN_Str = TextManager.GetText(CStringRes:GetRecorder(1532).msgTextID)
local YI_Str = TextManager.GetText(CStringRes:GetRecorder(1533).msgTextID)
local WANYI_Str = TextManager.GetText(CStringRes:GetRecorder(1534).msgTextID)
local WANYIJIA_Str = TextManager.GetText(CStringRes:GetRecorder(1535).msgTextID):gsub("%$parameter1%$", "9999.9")
local K_STR = TextManager.GetText(CStringRes:GetRecorder(1720).msgTextID)
local M_STR = TextManager.GetText(CStringRes:GetRecorder(1536).msgTextID)
local B_STR = TextManager.GetText(CStringRes:GetRecorder(1537).msgTextID)
local T_STR = TextManager.GetText(CStringRes:GetRecorder(1538).msgTextID)
local TP_STR = TextManager.GetText(CStringRes:GetRecorder(1539).msgTextID):gsub("%$parameter1%$", "999.9")

function NumberManager.Init()
  local languageID = BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(101).Value
  if languageID == 1 or languageID == 3 or languageID == 4 then
    showKind = 0
  elseif languageID == 2 then
    showKind = 1
  else
    showKind = fallbackKind
  end
end

function NumberManager.GetShowNumber(rawNumber, fullShow)
  local rawNumberType = type(rawNumber)
  local retNum
  local retNumStr = ""
  local perfix
  if rawNumberType == "number" then
    retNum = rawNumber
  elseif rawNumberType == "string" then
    retNum = tonumber(rawNumber)
    if retNum == nil then
      LogErrorFormat("NumberManager", "The rawNumber %s cannot be converted to a number", rawNumber)
      return retNumStr
    end
  else
    LogErrorFormat("NumberManager", "Wrong type %s of the rawNumber", rawNumberType)
    return retNumStr
  end
  if retNum < 0 then
    perfix = "-"
    retNum = -retNum
  end
  if showKind == 0 then
    if fullShow then
      retNumStr = NumberManager.GetNumber(retNum)
    elseif 9999900000000000 <= retNum then
      retNumStr = WANYIJIA_Str
    elseif 1000000000000 <= retNum then
      retNumStr = WANYI_Str:gsub("%$parameter1%$", NumberManager.GetNumber1F(retNum / 1000000000000))
    elseif 100000000 <= retNum then
      retNumStr = YI_Str:gsub("%$parameter1%$", NumberManager.GetNumber1F(retNum / 100000000))
    elseif 10000 <= retNum then
      retNumStr = WAN_Str:gsub("%$parameter1%$", NumberManager.GetNumber1F(retNum / 10000))
    else
      retNumStr = NumberManager.GetNumber(retNum)
    end
  elseif fullShow then
    retNumStr = NumberManager.GetCommaNumber(retNum)
  elseif 999900000000000 <= retNum then
    retNumStr = TP_STR
  elseif 1000000000000 <= retNum then
    retNumStr = T_STR:gsub("%$parameter1%$", NumberManager.GetCommaNumber1F(retNum / 1000000000000))
  elseif 1000000000 <= retNum then
    retNumStr = B_STR:gsub("%$parameter1%$", NumberManager.GetCommaNumber1F(retNum / 1000000000))
  elseif 1000000 <= retNum then
    retNumStr = M_STR:gsub("%$parameter1%$", NumberManager.GetCommaNumber1F(retNum / 1000000))
  else
    retNumStr = NumberManager.GetCommaNumber(retNum)
  end
  if perfix then
    return perfix .. retNumStr
  else
    return retNumStr
  end
end

function NumberManager.GetSpringBattleDamageShowNumber(rawNumber, fullShow)
  local rawNumberType = type(rawNumber)
  local retNum
  local retNumStr = ""
  local perfix
  if rawNumberType == "number" then
    retNum = rawNumber
  elseif rawNumberType == "string" then
    retNum = tonumber(rawNumber)
    if retNum == nil then
      LogErrorFormat("NumberManager", "The rawNumber %s cannot be converted to a number", rawNumber)
      return retNumStr
    end
  else
    LogErrorFormat("NumberManager", "Wrong type %s of the rawNumber", rawNumberType)
    return retNumStr
  end
  if retNum < 0 then
    perfix = "-"
    retNum = -retNum
  end
  if showKind == 0 then
    if fullShow then
      retNumStr = NumberManager.GetNumber(retNum)
    elseif 100000 <= retNum then
      retNumStr = W_Str:gsub("%$parameter1%$", math.floor(retNum / 10000))
    else
      retNumStr = NumberManager.GetNumber(retNum)
    end
  elseif fullShow then
    retNumStr = NumberManager.GetCommaNumber(retNum)
  elseif 100000 <= retNum then
    retNumStr = K_STR:gsub("%$parameter1%$", math.floor(retNum / 1000))
  else
    retNumStr = NumberManager.GetCommaNumber(retNum)
  end
  if perfix then
    return perfix .. retNumStr
  else
    return retNumStr
  end
end

function NumberManager._GetSplitNumber(num)
  local integer = num // 1.0
  local integerStr = tostring(integer):gsub("(%d+)%.%d+", "%1")
  local demical = string.format("%0.6f", num - integer)
  local decimalStr = tostring(demical):gsub("%d+%.(%d)%d*", "%1")
  return integerStr, decimalStr
end

function NumberManager._GetCommaNumber(integerStr, decimalStr)
  integerStr = integerStr:reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
  if decimalStr and decimalStr ~= "" then
    return integerStr .. "." .. decimalStr
  end
  return integerStr
end

function NumberManager.GetNumber(num)
  return tostring(num)
end

function NumberManager.GetNumber1F(num)
  local integerStr, decimalStr = NumberManager._GetSplitNumber(num)
  return integerStr .. "." .. decimalStr
end

function NumberManager.GetCommaNumber(num)
  local _, _, integerStr, decimalStr = tostring(num):find("(%d+)%.?(%d*)")
  return NumberManager._GetCommaNumber(integerStr, decimalStr)
end

function NumberManager.GetCommaNumber1F(num)
  local integerStr, decimalStr = NumberManager._GetSplitNumber(num)
  return NumberManager._GetCommaNumber(integerStr, decimalStr)
end

return NumberManager
