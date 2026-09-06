local CEffectResTable = BeanManager.GetTableByName("skill.ceffectres")
local EffectUtil = {}

function EffectUtil.GetAssetBundleNameAndAssetName(id)
  if CEffectResTable then
    local record = CEffectResTable:GetRecorder(id)
    if record then
      local assetbundle = string.gsub(record.effectPath, "(.*)/(.*).prefab", "%1")
      assetbundle = string.gsub(assetbundle, "/", ".")
      assetbundle = string.lower(assetbundle) .. ".assetbundle"
      local list = string.split(assetbundle, ".")
      local name = ""
      for k, v in pairs(list) do
        if k == 1 then
          name = name .. v .. "/"
        elseif k == table.nums(list) then
          name = name .. v
        else
          name = name .. v .. "."
        end
      end
      local asset = string.gsub(record.effectPath, "(.*)/(.*).prefab", "%2")
      return name, asset
    else
      LogErrorFormat("EffectUtil", "effect not found, id = %s, tablename = skill.ceffectres", id)
    end
  end
  return "", ""
end

return EffectUtil
