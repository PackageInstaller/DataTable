function createSandbox(init_data)
  return strict(setmetatable(init_data or {}, {
    __index = _G
  }))
end

function destroySandbox(sand_box)
  for k, v in pairs(sand_box) do
    sand_box[k] = nil
  end
end

return {
  createSandbox,
  destroySandbox
}
