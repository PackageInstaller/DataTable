local _computed = require("Vue.reactivity.computed").computed

local function computed(getterOrOptions)
  local c = _computed(getterOrOptions)
  return c
end

return {computed = computed}
