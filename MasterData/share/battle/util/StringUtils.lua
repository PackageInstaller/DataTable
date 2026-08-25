local System = require("System.System")
local DT = require("System.DataTable")
local StringUtils = System.NewClass("StringUtils")
StringUtils.WordsEffectType = {
  Color = {tag = "color", needValue = true},
  Bold = {tag = "b", needValue = false},
  Italic = {tag = "i", needValue = false},
  Size = {tag = "size", needValue = true}
}

function StringUtils.SetWordEffectStr(str)
  for effect in string.gmatch(str, "%b<>") do
    local effectStr = string.match(effect, "%<(.+)>")
    local strArr = string.split(effectStr, ":")
    local richText = StringUtils.GetWordsEffectRichText(strArr[1])
    local result = string.gsub(richText, "val", strArr[2])
    str = string.gsub(str, effect, result)
  end
  return str
end

function StringUtils.GetWordsEffectRichText(configKey)
  local config = DT.WordsEffectConfig[configKey]
  local effect = ""
  if config then
    effect = "val"
    for key, value in pairs(config) do
      if value and (type(value) == "number" and 0 ~= value or type(value) == "string" and "" ~= value) then
        local effectCfg = StringUtils.WordsEffectType[key]
        if effectCfg then
          local preStr = string.format("<%s>", effectCfg.tag)
          if effectCfg.needValue then
            preStr = string.format("<%s=%s>", effectCfg.tag, value)
          end
          local suffix = string.format("</%s>", effectCfg.tag)
          effect = preStr .. effect .. suffix
        end
      end
    end
  end
  return effect
end

function StringUtils.FindLast(s, pattern, plain)
  local curr = 0
  repeat
    local next = s:find(pattern, curr + 1, plain)
    if next then
      curr = next
    end
  until not next
  if curr > 0 then
    return curr
  end
end

return StringUtils
