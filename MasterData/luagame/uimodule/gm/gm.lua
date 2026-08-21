local ui = {}

local function reload_model(name)
  local suc, msg = pcall(function()
    name = string.lower(name)
    local pre_module = require(name)
    if pre_module then
      package.loaded[name] = nil
      Global.log.Debug("reload " .. name)
      local new_module = require(name)
      if type("table" == new_module) then
        for k, v in pairs(new_module) do
          pre_module[k] = v
        end
      end
      package.loaded[name] = pre_module
    end
  end)
  if not suc then
    Log.Error(msg)
  end
end

function ui:reload_lua(...)
  for _, name in pairs({
    ...
  }) do
    reload_model(name)
    local low_name = string.lower(name)
    if name ~= low_name then
      reload_model(low_name)
    end
  end
  if FightDataMgr then
    FightDataMgr:clear_cache_keyframe_cfg()
  end
end

return ui
