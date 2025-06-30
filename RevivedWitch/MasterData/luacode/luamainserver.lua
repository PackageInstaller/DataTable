-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/luamainserver.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
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
local dump = function(t)
  -- function num : 0_0 , upvalues : _ENV, dump
  local rt = {}
  if type(t) == "table" then
    for i,d in pairs(t) do
      if tonumber(i) then
        if type(d) == "table" then
          local rd = dump(d)
          rt[tonumber(i)] = rd
        else
          do
            if tonumber(d) then
              rt[tonumber(i)] = tonumber(d)
            else
              rt[tonumber(i)] = d
            end
            if type(d) == "table" then
              local rd = dump(d)
              rt[i] = rd
            else
              do
                do
                  if tonumber(d) then
                    rt[i] = tonumber(d)
                  else
                    rt[i] = d
                  end
                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_THEN_STMT

                  -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

                end
              end
            end
          end
        end
      end
    end
  end
  return rt
end

VaildBattle = function(protocolData, sbattlestart, stepNum)
  -- function num : 0_1 , upvalues : _ENV
  local result = nil
  local callResult = xpcall(function()
    -- function num : 0_1_0 , upvalues : result, _ENV, protocolData, sbattlestart, stepNum
    result = VerifyFunc(protocolData, sbattlestart, stepNum)
  end
, function(err)
    -- function num : 0_1_1 , upvalues : _ENV
    LogError("VaildBattle", (string.format)("lua error : %s", err))
  end
)
  return result
end

VerifyFunc = function(protocolData, sbattlestart, stepNum)
  -- function num : 0_2 , upvalues : _ENV, dump
  local controller = (BattleController.Create)()
  local protocolAndStep = {}
  local t = (JSON.decode)(protocolData)
  if type(t) == "table" then
    for _,d in pairs(t) do
      local temp = {}
      local creq = (BattleClientProtocolManager.CreateProtocol)(Protocols[d.ptype])
      if d.ptype == 5 then
        creq.entityId = (d.content).entityid
        creq.skillid = (d.content).skillid
      else
        if d.ptype == 27 then
          creq.type = (d.content).gmresult
        end
      end
      temp.step = d.step
      temp.protocol = creq
      ;
      (table.insert)(protocolAndStep, temp)
    end
  end
  do
    controller:Init(protocolAndStep, stepNum)
    controller:OnSBattleStart(dump((JSON.decode)(sbattlestart)))
    controller:BSC_UpdateBattleLogic()
    local result = controller:GetVerifyResult()
    controller:OnDestroy()
    return result
  end
end


