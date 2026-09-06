local DM_BattleEditor = class("DM_BattleEditor")

function DM_BattleEditor:Ctor()
  self._battleEditorData = NekoData.Data.battleeditor
  self._battleEditorData.pve = {
    battleId = 0,
    right = {}
  }
  self._battleEditorData.pvp = {
    left = {},
    right = {}
  }
  self._battleEditorData.pve.battleId = CS.UnityEngine.PlayerPrefs.GetInt("battleId")
  self._battleEditorData.pve.right[1] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[1]")
  self._battleEditorData.pve.right[2] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[2]")
  self._battleEditorData.pve.right[3] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[3]")
  self._battleEditorData.pve.right[4] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[4]")
  self._battleEditorData.pve.right[5] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[5]")
  self._battleEditorData.pve.right[6] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[6]")
  self._battleEditorData.pve.right[7] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[7]")
  self._battleEditorData.pve.right[8] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[8]")
  self._battleEditorData.pve.right[9] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[9]")
  self._battleEditorData.pvp.left[1] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[1]")
  self._battleEditorData.pvp.left[2] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[2]")
  self._battleEditorData.pvp.left[3] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[3]")
  self._battleEditorData.pvp.left[4] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[4]")
  self._battleEditorData.pvp.left[5] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[5]")
  self._battleEditorData.pvp.left[6] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[6]")
  self._battleEditorData.pvp.left[7] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[7]")
  self._battleEditorData.pvp.left[8] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[8]")
  self._battleEditorData.pvp.left[9] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[9]")
  self._battleEditorData.pvp.right[1] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[1]")
  self._battleEditorData.pvp.right[2] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[2]")
  self._battleEditorData.pvp.right[3] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[3]")
  self._battleEditorData.pvp.right[4] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[4]")
  self._battleEditorData.pvp.right[5] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[5]")
  self._battleEditorData.pvp.right[6] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[6]")
  self._battleEditorData.pvp.right[7] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[7]")
  self._battleEditorData.pvp.right[8] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[8]")
  self._battleEditorData.pvp.right[9] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[9]")
end

function DM_BattleEditor:Clear()
  self._battleEditorData.pve.battleId = CS.UnityEngine.PlayerPrefs.GetInt("battleId")
  self._battleEditorData.pve.right[1] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[1]")
  self._battleEditorData.pve.right[2] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[2]")
  self._battleEditorData.pve.right[3] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[3]")
  self._battleEditorData.pve.right[4] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[4]")
  self._battleEditorData.pve.right[5] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[5]")
  self._battleEditorData.pve.right[6] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[6]")
  self._battleEditorData.pve.right[7] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[7]")
  self._battleEditorData.pve.right[8] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[8]")
  self._battleEditorData.pve.right[9] = CS.UnityEngine.PlayerPrefs.GetInt("pve.right[9]")
  self._battleEditorData.pvp.left[1] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[1]")
  self._battleEditorData.pvp.left[2] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[2]")
  self._battleEditorData.pvp.left[3] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[3]")
  self._battleEditorData.pvp.left[4] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[4]")
  self._battleEditorData.pvp.left[5] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[5]")
  self._battleEditorData.pvp.left[6] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[6]")
  self._battleEditorData.pvp.left[7] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[7]")
  self._battleEditorData.pvp.left[8] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[8]")
  self._battleEditorData.pvp.left[9] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.left[9]")
  self._battleEditorData.pvp.right[1] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[1]")
  self._battleEditorData.pvp.right[2] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[2]")
  self._battleEditorData.pvp.right[3] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[3]")
  self._battleEditorData.pvp.right[4] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[4]")
  self._battleEditorData.pvp.right[5] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[5]")
  self._battleEditorData.pvp.right[6] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[6]")
  self._battleEditorData.pvp.right[7] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[7]")
  self._battleEditorData.pvp.right[8] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[8]")
  self._battleEditorData.pvp.right[9] = CS.UnityEngine.PlayerPrefs.GetInt("pvp.right[9]")
end

function DM_BattleEditor:SetPVPLeft(pos, roleConfigId)
  self._battleEditorData.pvp.left[pos] = roleConfigId
  CS.UnityEngine.PlayerPrefs.SetInt("pvp.left[" .. tostring(pos) .. "]", roleConfigId)
end

function DM_BattleEditor:SetPVPRight(pos, roleConfigId)
  self._battleEditorData.pvp.right[pos] = roleConfigId
  CS.UnityEngine.PlayerPrefs.SetInt("pvp.right[" .. tostring(pos) .. "]", roleConfigId)
end

function DM_BattleEditor:SetPVEBattleId(battleId)
  self._battleEditorData.pve.battleId = battleId
  CS.UnityEngine.PlayerPrefs.SetInt("battleId", battleId)
end

function DM_BattleEditor:SetPVERight(pos, roleConfigId)
  self._battleEditorData.pve.right[pos] = roleConfigId
  CS.UnityEngine.PlayerPrefs.SetInt("pve.right[" .. tostring(pos) .. "]", roleConfigId)
end

return DM_BattleEditor
