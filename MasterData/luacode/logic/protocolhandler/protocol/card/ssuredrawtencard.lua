-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/card/ssuredrawtencard.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : _ENV
  local convertItems = {}
  for _,v in ipairs(protocol.items) do
    local flag = true
    for _,w in ipairs(convertItems) do
      if v.id == w.id then
        w.number = w.number + v.number
        flag = false
        break
      end
    end
    do
      do
        if flag then
          (table.insert)(convertItems, v)
        end
        -- DECOMPILER ERROR at PC29: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  if convertItems and #convertItems ~= 0 then
    local dialog = (DialogManager.CreateSingletonDialog)("bag.itemaccountdialog")
    if dialog then
      dialog:LoadData({items = convertItems})
    end
  else
    do
      if ((NekoData.BehaviorManager).BM_Chat):GetGuideCommentCache() then
        ((DialogManager.CreateSingletonDialog)("chat.guidecommentdialog")):SetData()
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

