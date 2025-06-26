-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/task/taskuihandlers/friendshop.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TaskUIHandler = {}
TaskUIHandler.Handle = function(self)
  -- function num : 0_0 , upvalues : _ENV
  ((NekoData.DataManager).DM_Shop):ClientSetOpenShopID(9)
  local dialog = (DialogManager.GetDialog)("shop.shopmaindialog")
  if dialog then
    ((DialogManager.GetGroup)("Modal")):ReturnModalDialog(dialog)
  else
    ;
    ((DialogManager.GetGroup)("Modal")):ReturnModalDialog()
    local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
end

return TaskUIHandler

