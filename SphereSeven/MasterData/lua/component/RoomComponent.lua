---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/11 9:54
--- 自宅功能

local RoomComponent = BaseClass("RoomComponent", Component)
local base = Component
local this = RoomComponent

local sleepBuffTime = 1
local sleepCoolingTime = 8
local restCoolingTime = 5


function this.UpdateRoomCard(self)
    self.roomCard = self.__entity:GetComponent("CardComponent").Cards[self.__entity.BedroomCardId];
    self.roomBuff = 0;
end

function this.GetSleepBuffContinueTime(h,m,s)
    
    local z_Timer_Sleep = table.first(Z_Timer,function(v) return v.Name == "SleepCooling"  end)
    local z_Timer_SleepBuff = table.first(Z_Timer,function(v) return v.Name == "SleepBuff"  end)
    
    local time1 = { h = z_Timer_Sleep.Hour, m = z_Timer_Sleep.Min, s = z_Timer_Sleep.Second} --总冷却
    local time2 = { h = h, m = m, s = s} -- 剩余冷却
    local time3 = { h = z_Timer_SleepBuff.Hour, m = z_Timer_SleepBuff.Min, s = z_Timer_SleepBuff.Second} -- 持续时间
    local time3_greater; --持续时间是否大于已冷却时间
    local sleep_cooling_difference  --已冷却
    local sleep_buff_difference -- 已冷却与持续时间的差值

    sleep_cooling_difference = UIUtil.GetTimeDifference(time1,time2)
    sleep_buff_difference,time3_greater = UIUtil.GetTimeDifference(time3,sleep_cooling_difference)
    
    if not time3_greater then return 0,0,0 end
    
    return sleep_buff_difference.h,sleep_buff_difference.m,sleep_buff_difference.s;
end

function this.GetRestBuffContinueTime(h,m,s)

    local z_Timer_Rest = table.first(Z_Timer,function(v) return v.Name == "RestCooling"  end)
    local z_Timer_RestBuff = table.first(Z_Timer,function(v) return v.Name == "RestBuff"  end)

    local time1 = { h = z_Timer_Rest.Hour, m = z_Timer_Rest.Min, s = z_Timer_Rest.Second} --总冷却
    local time2 = { h = h, m = m, s = s} -- 剩余冷却
    local time3 = { h = z_Timer_RestBuff.Hour, m = z_Timer_RestBuff.Min, s = z_Timer_RestBuff.Second} -- 持续时间
    local time3_greater; --持续时间是否大于已冷却时间
    local rest_cooling_difference  --已冷却
    local rest_buff_difference -- 已冷却与持续时间的差值

    rest_cooling_difference = UIUtil.GetTimeDifference(time1,time2)
    rest_buff_difference,time3_greater = UIUtil.GetTimeDifference(time3,rest_cooling_difference)

    if not time3_greater then return 0,0,0 end

    return rest_buff_difference.h,rest_buff_difference.m,rest_buff_difference.s;
end



function this.StartSleep(self,timeStamp)
    if timeStamp == 0 then return end;
    local z_Timer = table.first(Z_Timer,function(v) return v.Name == "SleepCooling"  end)
    local time = {}
    time.h = z_Timer.Hour
    time.m = z_Timer.Min
    time.s = z_Timer.Second

    if timeStamp ~= nil then
        local time1 = {h = z_Timer.Hour, m = z_Timer.Min, s = z_Timer.Second};
        local time2 = {}
        time2.h,time2.m,time2.s = UIUtil.GetTimeStampDifference(timeStamp);
        local time1_greater
        time,time1_greater = UIUtil.GetTimeDifference(time1,time2)

        if not time1_greater then
            time.h,time.m,time.s = 0,0,0;
        end
        
    end
    self.isSleep = true;
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_ROOM_INFO_CHG)
    self.startSleepCountDown = CountDown.New(time.h,time.m,time.s,function()print("--Sleep冷却结束！")
        self.isSleep = false  
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ROOM_INFO_CHG)
    end)
    
    print("--sleepBuff开始")
    
    local continue_h,continue_m,continue_s = this.GetSleepBuffContinueTime(time.h,time.m,time.s)

  --  if continue_h > 0 or continue_m > 0 or continue_s > 0 then
        self.sleepBuff = 0;
        self.sleepBuffCountDown = CountDown.New(continue_h,continue_m,continue_s,function()
            print("--sleepBuff结束！")
            self.sleepBuff = 0;
            
            DataManager:GetInstance():Broadcast(DataMessageNames.ON_SLEEP_BUFF_CHG,0);
        end)
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_SLEEP_BUFF_CHG,1);
   -- end
end


function this.StartRest(self,timeStamp)
    if timeStamp == 0 then return end;
    local z_Timer_Rest = table.first(Z_Timer,function(v) return v.Name == "RestCooling"  end)
    local time = {}
    time.h = z_Timer_Rest.Hour;
    time.m = z_Timer_Rest.Min;
    time.s = z_Timer_Rest.Second;
    if timeStamp ~= nil then
        local time1 = {h = z_Timer_Rest.Hour, m = z_Timer_Rest.Min, s = z_Timer_Rest.Second};
        local time2 = {}
        time2.h,time2.m,time2.s = UIUtil.GetTimeStampDifference(timeStamp);
        local time1_greater
        time,time1_greater = UIUtil.GetTimeDifference(time1,time2)

        if not time1_greater then
            time.h,time.m,time.s = 0,0,0;
        end

        UIUtil.GetTimeStampDifference(timeStamp)
    end
   
    self.isRest = true;
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_ROOM_INFO_CHG)
    self.startRestCountDown = CountDown.New(time.h,time.m,time.s,function()
         self.isRest = false
        DataManager:GetInstance():Broadcast(DataMessageNames.ON_ROOM_INFO_CHG)
    end)

    print("--restBuff开始")

    local continue_h,continue_m,continue_s = this.GetRestBuffContinueTime(time.h,time.m,time.s)

    --  if continue_h > 0 or continue_m > 0 or continue_s > 0 then
    self.restBuff = 1;
    self.RestBuffCountDown = CountDown.New(continue_h,continue_m,continue_s,function()
        print("--Rest冷却结束！")
        self.restBuff = 0;

        DataManager:GetInstance():Broadcast(DataMessageNames.ON_REST_BUFF_CHG,0);
    end)
    DataManager:GetInstance():Broadcast(DataMessageNames.ON_REST_BUFF_CHG,1);
    -- end
end

function this.Awake(self)
    base.Awake(self)
    self.roomCard = nil;
    self.roomBuff = 0;
    self.isSleep = false;
    self.isRest = false;
    self.sleepBuff = 0;
    self.restBuff = 0;
    self.sleepCountDown =  table.first(Z_Timer,function(v) return v.Name == "SleepCooling" end).Hour
    self.restCountDown = table.first(Z_Timer,function(v) return v.Name == "RestCooling" end).Hour
end

function this.Dispose(self)
    base.Dispose(self)
    
end



return this