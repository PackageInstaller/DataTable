local function func(childParams)
  if not childParams or not childParams[1] then
    return
  end
  return {
    childParams[1]
  }
end

return func
