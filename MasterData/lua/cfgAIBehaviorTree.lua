_G["AIBehaviorTree"]={[1004]={["id"]=1004,["type"]="AISequence",["key"]=1004}
,[1005]={["id"]=1005,["type"]="AITask",["key"]=1005}
,[1006]={["id"]=1006,["type"]="AIDecorator",["key"]=1006}
,[2012]={["id"]=2012,["type"]="AITask",["key"]=2012,["ToDo"]=[[-- 自己在战斗中
LogDebugEx("4444444---",self.oOwner.nAIMoveStep)
if self.oOwner.state == eDungeonCharState.Fighting then return true end
-- 判断是否有追击对象
local attacker = self.oAIController.oDuplicate:SearchAreaPlayer(self.oOwner, self.oAIController.nSearchRadius)
if not attacker then return end
self.oAIController.oDuplicate:AIFollow(self.oOwner, attacker)
return true]]}
,[1007]={["decorator"]={2001}
,["type"]="AICtlDuplicate",["key"]=1007,["id"]=1007,["sub"]={2002}
}
,[2014]={["sub"]={2012,2013}
,["type"]="AISequence",["key"]=2014,["id"]=2014}
,[1008]={["decorator"]={2001}
,["type"]="AICtlDuplicate",["key"]=1008,["AICtlParm"]={["ptDest"]=1035}
,["id"]=1008,["sub"]={2003}
}
,[1009]={["decorator"]={2001}
,["type"]="AICtlDuplicate",["key"]=1009,["AICtlParm"]={["ptDestList"]={1035,1043}
}
,["id"]=1009,["sub"]={2004}
}
,[2021]={["id"]=2021,["type"]="AIDecorator",["key"]=2021,["ToDo"]=[[-- 判断有对象触发追击
local attacker = self.oAIController.oDuplicate:SearchAreaPlayer(self.oOwner, self.oAIController.nSearchRadius)
if attacker and not self.oOwner.bAIStart then 
  self.oOwner.bAIStart = true
  self.oOwner.nIntervaloff = self.oAIController.oDuplicate.nStep
  --self.nIntervaloff = self.oAIController.oDuplicate.nStep % self.oOwner.nInterval
  --if self.oOwner.nIntervaloff ~= 0 then
  -- self.oOwner.nIntervaloff = self.oOwner.nInterval - self.oOwner.nIntervaloff
  --end
end

if self.oOwner.nStep and self.oOwner.bAIStart then
 local mod = (self.oAIController.oDuplicate.nStep + self.oOwner.nIntervaloff) % self.oOwner.nInterval
 if mod == 0 then
  return true
 end
end]]}
,[2013]={["id"]=2013,["type"]="AITask",["key"]=2013,["ToDo"]=[[self.oOwner.nAIMoveStep = 0
LogDebugEx("3333333333---",self.oOwner.nAIMoveStep)]]}
,[2001]={["id"]=2001,["type"]="AIDecorator",["key"]=2001,["ToDo"]=[[if self.oOwner.nStep then
 local mod = (self.oAIController.oDuplicate.nStep - self.oOwner.nIntervaloff) % self.oOwner.nInterval
 if mod == 0 then
  return true
 end
end]]}
,[2011]={["id"]=2011,["type"]="AIDecorator",["key"]=2011,["ToDo"]=[[if self.oOwner.nStep then
 local mod = (self.oOwner.nAIMoveStep) % self.oOwner.nInterval
LogDebugEx("22222222---",self.oOwner.nStep, self.oOwner.nAIMoveStep,mod)
 if mod == 0 then
  return true
 end
end]]}
,[1002]={["id"]=1002,["type"]="AIComposite",["key"]=1002}
,[1101]={["decorator"]={2011}
,["type"]="AICtlDuplicate",["key"]=1101,["ToDo"]=[[self.oOwner.nAIMoveStep = self.oOwner.nAIMoveStep or 0
self.oOwner.nAIMoveStep = self.oOwner.nAIMoveStep + 1
LogDebugEx("1111111111---",self.oOwner.nAIMoveStep)
AIController.ToDo(self)]],["id"]=1101,["sub"]={2014}
}
,[1102]={["decorator"]={2021}
,["type"]="AICtlDuplicate",["key"]=1102,["id"]=1102,["sub"]={2002}
}
,[2002]={["id"]=2002,["type"]="AITask",["key"]=2002,["ToDo"]=[[-- 自己在战斗中
if self.oOwner.state == eDungeonCharState.Fighting then return true end
-- 判断是否有追击对象
local attacker = self.oAIController.oDuplicate:SearchPlayer(self.oOwner)
if not attacker then return true end
self.oAIController.oDuplicate:AIFollow(self.oOwner, attacker)
return true]]}
,[2003]={["id"]=2003,["type"]="AITask",["key"]=2003,["ToDo"]=[[-- 自己在战斗中
if self.oOwner.state == eDungeonCharState.Fighting then return true end
if not self.oAIController.ptDest then return true end
-- 移动到指定点
self.oAIController.oDuplicate:AIMoveToPos(self.oOwner, self.oAIController.ptDest)
return true]]}
,[2004]={["id"]=2004,["type"]="AITask",["key"]=2004,["ToDo"]=[[-- 自己在战斗中
if self.oOwner.state == eDungeonCharState.Fighting then return true end
if not self.oAIController.ptDestList then return true end
-- 移动到指定点
self.oAIController.oDuplicate:AIMoveToPosList(self.oOwner, self.oAIController.ptDestList)
return true]]}
,[1003]={["id"]=1003,["type"]="AISelector",["key"]=1003}
,[1001]={["id"]=1001,["type"]="AICtlDuplicate",["key"]=1001}
}

