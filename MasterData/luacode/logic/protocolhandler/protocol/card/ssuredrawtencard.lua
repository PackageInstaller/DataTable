local function p1(protocol)
  local convertItems = {}
  
  for _, v in ipairs(protocol.items) do
    local flag = true
    for _, w in ipairs(convertItems) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    if flag then
      table.insert(convertItems, v)
    end
  end
  if convertItems and #convertItems ~= 0 then
    local dialog = DialogManager.CreateSingletonDialog("bag.itemaccountdialog")
    if dialog then
      dialog:LoadData({items = convertItems})
    end
  elseif NekoData.BehaviorManager.BM_Chat:GetGuideCommentCache() then
    DialogManager.CreateSingletonDialog("chat.guidecommentdialog"):SetData()
  end
end

local function p2(protocol, client)
end

return {p1, p2}
