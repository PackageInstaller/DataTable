local TU = {}

function TU.render(template, env, subFunc)
  env = setmetatable(table.copy(env, {}, true), {
    __index = table.makeLookup(env, _G)
  })
  local result = template
  local expressions = string.gmatch(template, "{{(.-)}}")
  for expression in expressions, nil, nil do
    local pattern = "{{" .. expression .. "}}"
    if subFunc then
      expression = subFunc(expression)
    end
    local status, value = pcall(TU.evaluate, expression, env)
    if status then
      if type(value) ~= "table" then
        result = result:replace(pattern, value or "")
      else
        error("TextUtil", expression .. " result in a table")
      end
    else
      error("TextUtil", "expression evaludate failed: " .. expression .. " " .. tostring(value))
    end
  end
  return result
end

local expression_cache = {}

function TU.evaluate(expression, env)
  local func = expression_cache[expression]
  if func == nil then
    local message
    func, message = load("return " .. expression)
    if func == nil then
      error("TextUtil", message)
    else
      expression_cache[expression] = func
    end
  end
  if func ~= nil then
    return setfenv(func, env)()
  end
end

function TU.ErectText(text)
  local res = ""
  for p, c in utf8.codes(text) do
    res = res .. utf8.char(c) .. "\n"
  end
  res = string.sub(res, 1, -2)
  return res
end

return TU
