require "ProtoList";
require "ProtocolRecordMgr";

local  this = {};

function this:Init()
    Log( "初始化网络");
    
--    local co = coroutine.create(self.DelayInit);
--    coroutine.resume(co,self);
    FuncUtil:Call(self.DelayInit,self,10);
end

function this:DelayInit() 
    local NetBase = require "NetBase";
    --主网络
    self.net = NetBase.New("Main");
    --战斗网络
    self.netFight = NetBase.New("Fight");
end

return this;