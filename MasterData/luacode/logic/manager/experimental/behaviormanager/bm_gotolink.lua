local BM_GotoLink = class("BM_GotoLink")

function BM_GotoLink:Ctor()
end

local _handler = {}

function _handler.gacha(index)
  if not NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Gacha) then
    return
  end
  local id = tonumber(index)
  for _, v in pairs(NekoData.BehaviorManager.BM_Gacha:GetGachaPools()) do
    if v.id == id then
      local dlg = DialogManager.CreateSingletonDialog("gacha.gachamaindialog")
      dlg:Init(SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base))
      dlg:OnPoolCellClick({id = id})
    end
  end
end

function BM_GotoLink:HandleGoto(link)
  local tabs = string.split(link, ":")
  if #tabs == 0 then
    return
  end
  if tabs[1] == "url" then
    local addr = ""
    if tabs[2] == "https" or tabs[2] == "http" then
      addr = table.concat(tabs, ":", 2)
    else
      addr = "http://" .. table.concat(tabs, "", 2)
    end
    LogWarning("[OpenURL]: ", addr, "config url: ", link)
    CS.PixelNeko.Tools.ShareHelper.OpenURL(addr)
  else
    LogWarning("[Goto]", table.concat(tabs, "", 2))
    local args = tabs[2]:split("/")
    _handler[args[1]:lower()](table.unpack(args, 2))
  end
end

return BM_GotoLink
