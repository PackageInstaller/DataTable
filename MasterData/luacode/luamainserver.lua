NEKO_RELEASE = true
require("framework.class")
require("framework.table")
require("framework.string")
require("framework.utils.serverlog")
require("framework.utils.generateuniqueid")
require("fixedpoint")
fixedpoint_zero = fixedpoint(0)
Common = require("luacommon")
LuaNotificationCenter = require("framework.utils.luanotificationcenter")
BeanManager = require("framework.utils.beanmanager")
BehaviorManager = require("framework.utils.behaviormanager")
Tween = require("framework.tween")
BattleClientProtocolManager = require("localprotocols.localprotocolmanager")
BattleECS = require("logic.newbattle.battleecs")
BattleController = require("battleverify.battleverifycontroller")
Protocols = require("localprotocols.protocols")
JSON = require("framework.json")
require("pcg")

local function dump(t)
  local rt = {}
  if type(t) == "table" then
    for i, d in pairs(t) do
      if tonumber(i) then
        if type(d) == "table" then
          local rd = dump(d)
          rt[tonumber(i)] = rd
        elseif tonumber(d) then
          rt[tonumber(i)] = tonumber(d)
        else
          rt[tonumber(i)] = d
        end
      elseif type(d) == "table" then
        local rd = dump(d)
        rt[i] = rd
      elseif tonumber(d) then
        rt[i] = tonumber(d)
      else
        rt[i] = d
      end
    end
  end
  return rt
end

function VaildBattle(protocolData, sbattlestart, stepNum)
  local result
  local callResult = xpcall(function()
    result = VerifyFunc(protocolData, sbattlestart, stepNum)
  end, function(err)
    LogError("VaildBattle", string.format("lua error : %s", err))
  end)
  return result
end

function VerifyFunc(protocolData, sbattlestart, stepNum)
  local controller = BattleController.Create()
  local protocolAndStep = {}
  local t = JSON.decode(protocolData)
  if type(t) == "table" then
    for _, d in pairs(t) do
      local temp = {}
      local creq = BattleClientProtocolManager.CreateProtocol(Protocols[d.ptype])
      if d.ptype == 5 then
        creq.entityId = d.content.entityid
        creq.skillid = d.content.skillid
      elseif d.ptype == 27 then
        creq.type = d.content.gmresult
      end
      temp.step = d.step
      temp.protocol = creq
      table.insert(protocolAndStep, temp)
    end
  end
  controller:Init(protocolAndStep, stepNum)
  controller:OnSBattleStart(dump(JSON.decode(sbattlestart)))
  controller:BSC_UpdateBattleLogic()
  local result = controller:GetVerifyResult()
  controller:OnDestroy()
  return result
end
