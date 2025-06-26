-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/numbermanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local NumberManager = {}
local showKind = 0
local fallbackKind = 0
local W_Str = (TextManager.GetText)(701764)
local WAN_Str = (TextManager.GetText)((CStringRes:GetRecorder(1532)).msgTextID)
local YI_Str = (TextManager.GetText)((CStringRes:GetRecorder(1533)).msgTextID)
local WANYI_Str = (TextManager.GetText)((CStringRes:GetRecorder(1534)).msgTextID)
local WANYIJIA_Str = ((TextManager.GetText)((CStringRes:GetRecorder(1535)).msgTextID)):gsub("%$parameter1%$", "9999.9")
local K_STR = (TextManager.GetText)((CStringRes:GetRecorder(1720)).msgTextID)
local M_STR = (TextManager.GetText)((CStringRes:GetRecorder(1536)).msgTextID)
local B_STR = (TextManager.GetText)((CStringRes:GetRecorder(1537)).msgTextID)
local T_STR = (TextManager.GetText)((CStringRes:GetRecorder(1538)).msgTextID)
local TP_STR = ((TextManager.GetText)((CStringRes:GetRecorder(1539)).msgTextID)):gsub("%$parameter1%$", "999.9")
NumberManager.Init = function()
  -- function num : 0_0 , upvalues : _ENV, showKind, fallbackKind
  local languageID = (((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(101)).Value
  if languageID == 1 or languageID == 3 or languageID == 4 then
    showKind = 0
  else
    if languageID == 2 then
      showKind = 1
    else
      showKind = fallbackKind
    end
  end
end

NumberManager.GetShowNumber = function(rawNumber, fullShow)
  -- function num : 0_1 , upvalues : _ENV, showKind, NumberManager, WANYIJIA_Str, WANYI_Str, YI_Str, WAN_Str, TP_STR, T_STR, B_STR, M_STR
  local rawNumberType = (type(rawNumber))
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local retNum = .end
  local retNumStr = ""
  local perfix = nil
  if rawNumberType == "number" then
    retNum = rawNumber
  else
    if rawNumberType == "string" then
      retNum = tonumber(rawNumber)
      if retNum == nil then
        LogErrorFormat("NumberManager", "The rawNumber %s cannot be converted to a number", rawNumber)
        return retNumStr
      end
    else
      LogErrorFormat("NumberManager", "Wrong type %s of the rawNumber", rawNumberType)
      return retNumStr
    end
  end
  if retNum < 0 then
    perfix = "-"
    retNum = -retNum
  end
  if showKind == 0 then
    if fullShow then
      retNumStr = (NumberManager.GetNumber)(retNum)
    else
      if retNum >= 9999900000000000 then
        retNumStr = WANYIJIA_Str
      else
        if retNum >= 1000000000000 then
          retNumStr = WANYI_Str:gsub("%$parameter1%$", (NumberManager.GetNumber1F)(retNum / 1000000000000))
        else
          if retNum >= 100000000 then
            retNumStr = YI_Str:gsub("%$parameter1%$", (NumberManager.GetNumber1F)(retNum / 100000000))
          else
            if retNum >= 10000 then
              retNumStr = WAN_Str:gsub("%$parameter1%$", (NumberManager.GetNumber1F)(retNum / 10000))
            else
              retNumStr = (NumberManager.GetNumber)(retNum)
            end
          end
        end
      end
    end
  else
    if fullShow then
      retNumStr = (NumberManager.GetCommaNumber)(retNum)
    else
      if retNum >= 999900000000000 then
        retNumStr = TP_STR
      else
        if retNum >= 1000000000000 then
          retNumStr = T_STR:gsub("%$parameter1%$", (NumberManager.GetCommaNumber1F)(retNum / 1000000000000))
        else
          if retNum >= 1000000000 then
            retNumStr = B_STR:gsub("%$parameter1%$", (NumberManager.GetCommaNumber1F)(retNum / 1000000000))
          else
            if retNum >= 1000000 then
              retNumStr = M_STR:gsub("%$parameter1%$", (NumberManager.GetCommaNumber1F)(retNum / 1000000))
            else
              retNumStr = (NumberManager.GetCommaNumber)(retNum)
            end
          end
        end
      end
    end
  end
  if perfix then
    return perfix .. retNumStr
  else
    return retNumStr
  end
end

NumberManager.GetSpringBattleDamageShowNumber = function(rawNumber, fullShow)
  -- function num : 0_2 , upvalues : _ENV, showKind, NumberManager, W_Str, K_STR
  local rawNumberType = (type(rawNumber))
  -- DECOMPILER ERROR at PC3: Overwrote pending register: R3 in 'AssignReg'

  local retNum = .end
  local retNumStr = ""
  local perfix = nil
  if rawNumberType == "number" then
    retNum = rawNumber
  else
    if rawNumberType == "string" then
      retNum = tonumber(rawNumber)
      if retNum == nil then
        LogErrorFormat("NumberManager", "The rawNumber %s cannot be converted to a number", rawNumber)
        return retNumStr
      end
    else
      LogErrorFormat("NumberManager", "Wrong type %s of the rawNumber", rawNumberType)
      return retNumStr
    end
  end
  if retNum < 0 then
    perfix = "-"
    retNum = -retNum
  end
  if showKind == 0 then
    if fullShow then
      retNumStr = (NumberManager.GetNumber)(retNum)
    else
      if retNum >= 100000 then
        retNumStr = W_Str:gsub("%$parameter1%$", (math.floor)(retNum / 10000))
      else
        retNumStr = (NumberManager.GetNumber)(retNum)
      end
    end
  else
    if fullShow then
      retNumStr = (NumberManager.GetCommaNumber)(retNum)
    else
      if retNum >= 100000 then
        retNumStr = K_STR:gsub("%$parameter1%$", (math.floor)(retNum / 1000))
      else
        retNumStr = (NumberManager.GetCommaNumber)(retNum)
      end
    end
  end
  if perfix then
    return perfix .. retNumStr
  else
    return retNumStr
  end
end

NumberManager._GetSplitNumber = function(num)
  -- function num : 0_3 , upvalues : _ENV
  local integer = num // 1
  local integerStr = (tostring(integer)):gsub("(%d+)%.%d+", "%1")
  local demical = (string.format)("%0.6f", num - integer)
  local decimalStr = (tostring(demical)):gsub("%d+%.(%d)%d*", "%1")
  return integerStr, decimalStr
end

NumberManager._GetCommaNumber = function(integerStr, decimalStr)
  -- function num : 0_4
  integerStr = (((integerStr:reverse()):gsub("(%d%d%d)", "%1,")):reverse()):gsub("^,", "")
  if decimalStr and decimalStr ~= "" then
    return integerStr .. "." .. decimalStr
  end
  return integerStr
end

NumberManager.GetNumber = function(num)
  -- function num : 0_5 , upvalues : _ENV
  return tostring(num)
end

NumberManager.GetNumber1F = function(num)
  -- function num : 0_6 , upvalues : NumberManager
  local integerStr, decimalStr = (NumberManager._GetSplitNumber)(num)
  return integerStr .. "." .. decimalStr
end

NumberManager.GetCommaNumber = function(num)
  -- function num : 0_7 , upvalues : _ENV, NumberManager
  local _, _, integerStr, decimalStr = (tostring(num)):find("(%d+)%.?(%d*)")
  return (NumberManager._GetCommaNumber)(integerStr, decimalStr)
end

NumberManager.GetCommaNumber1F = function(num)
  -- function num : 0_8 , upvalues : NumberManager
  local integerStr, decimalStr = (NumberManager._GetSplitNumber)(num)
  return (NumberManager._GetCommaNumber)(integerStr, decimalStr)
end

return NumberManager

