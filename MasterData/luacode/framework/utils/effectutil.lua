-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/effectutil.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CEffectResTable = (BeanManager.GetTableByName)("skill.ceffectres")
local EffectUtil = {}
EffectUtil.GetAssetBundleNameAndAssetName = function(id)
  -- function num : 0_0 , upvalues : CEffectResTable, _ENV
  if CEffectResTable then
    local record = CEffectResTable:GetRecorder(id)
    if record then
      local assetbundle = (string.gsub)(record.effectPath, "(.*)/(.*).prefab", "%1")
      assetbundle = (string.gsub)(assetbundle, "/", ".")
      assetbundle = (string.lower)(assetbundle) .. ".assetbundle"
      local list = (string.split)(assetbundle, ".")
      local name = ""
      for k,v in pairs(list) do
        if k == 1 then
          name = name .. v .. "/"
        else
          if k == (table.nums)(list) then
            name = name .. v
          else
            name = name .. v .. "."
          end
        end
      end
      local asset = (string.gsub)(record.effectPath, "(.*)/(.*).prefab", "%2")
      return name, asset
    else
      do
        do
          LogErrorFormat("EffectUtil", "effect not found, id = %s, tablename = skill.ceffectres", id)
          return "", ""
        end
      end
    end
  end
end

return EffectUtil

