local BM_BattleEditor = class("BM_BattleEditor")

function BM_BattleEditor:Ctor()
  self._battleEditorData = NekoData.Data.battleeditor
end

function BM_BattleEditor:GetPVPLeftData(pos)
  return self._battleEditorData.pvp.left[pos]
end

function BM_BattleEditor:GetPVPRightData(pos)
  return self._battleEditorData.pvp.right[pos]
end

function BM_BattleEditor:GetPVEBattleId()
  return self._battleEditorData.pve.battleId
end

function BM_BattleEditor:GetPVERightData(pos)
  return self._battleEditorData.pve.right[pos]
end

return BM_BattleEditor
