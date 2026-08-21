local Stack = {}

function Stack.create(stack)
  stack.s = {}
  stack.top = Stack.top
  stack.push = Stack.push
  stack.pop = Stack.pop
  stack.empty = Stack.empty
  return stack
end

function Stack.new()
  return Stack.create({})
end

function Stack.top(stack)
  return stack.s[#stack.s]
end

function Stack.push(stack, element)
  stack.s[#stack.s + 1] = element
end

function Stack.pop(stack)
  if #stack.s > 0 then
    local r = stack.s[#stack.s]
    table.remove(stack.s)
    return r
  else
    return nil
  end
end

function Stack.empty(stack)
  return #stack.s == 0
end

return Stack
