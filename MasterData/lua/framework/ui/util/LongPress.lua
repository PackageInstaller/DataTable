local LongPress = BaseClass("LongPress")

local objecTab = {}

local function __init(self,target,longPressCallBack)
    objecTab[target] = self;
    self.target = target;
    self.longPressCallBack = longPressCallBack;
    self.isLongPress = false;
    self.timer = nil;
    self.delay = 1.5;
    self:Init(self);
end

local function Init(self)
    EventTriggerListener.Get(self.target).onLuaDown = self.OnDownCallBack
    EventTriggerListener.Get(self.target).onLuaUp = self.OnUpCallBack
    EventTriggerListener.Get(self.target).onLuaExit = self.OnExitCallBack
    EventTriggerListener.Get(self.target).onLuaDragHandler = self.onLuaDragHandler
end

local function GetSelf(target)
    for k,v in pairs(objecTab) do
        if(k == target) then
            return v;
        end
    end
end


local function SetButtonState(target,isActive)
    if(target:GetComponent("Button")) then
        target:GetComponent("Button").enabled = isActive;
    end
end

local function OnLongPressCallBack(target)
    GetSelf(target).isLongPress = true;
    SetButtonState(target,false);
    GetSelf(target).longPressCallBack(target);
end


local function OnDownCallBack(target)
    GetSelf(target).timer = TimerHelper.CreateTimer();
    GetSelf(target).timer:TimerStart(GetSelf(target).delay,OnLongPressCallBack,target);
end

local function onLuaDragHandler(target)
    if(GetSelf(target).timer ~= nil) then
        GetSelf(target).timer:TimerStop()
        GetSelf(target).isLongPress = false
        GetSelf(target).timer = nil
    end
end


local function OnUpCallBack(target)
    if(GetSelf(target).timer ~= nil) then
        GetSelf(target).timer:TimerStop();
        if(GetSelf(target).isLongPress) then
            coroutine.start(function()
                coroutine.waitforframes(5);
                SetButtonState(target,true);
            end)
        end
        GetSelf(target).isLongPress = false;
        GetSelf(target).timer = nil;
    end
end

local function OnExitCallBack(target)
    if(GetSelf(target).timer ~= nil) then
        GetSelf(target).timer:TimerStop();
        SetButtonState(target,true);
        GetSelf(target).isLongPress = false;
        GetSelf(target).timer = nil;
    end
end
LongPress.__init = __init
LongPress.Init = Init
LongPress.OnDownCallBack = OnDownCallBack
LongPress.OnUpCallBack = OnUpCallBack
LongPress.OnExitCallBack = OnExitCallBack
LongPress.onLuaDragHandler = onLuaDragHandler

return LongPress;