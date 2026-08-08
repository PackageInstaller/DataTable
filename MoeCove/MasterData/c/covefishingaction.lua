

local CoveActionBase = require("CoveActionBase")
---@class CoveFishingAction: CoveActionBase
local CoveFishingAction = class("CoveFishingAction", CoveActionBase)

local catchCount = 6    ---鱼货数量
local minFishCount = 1  ---最少钓鱼数量
local maxFishCount = 3  ---最多钓鱼数量
local fishingTime = 5   ---钓鱼时间


function CoveFishingAction:ctor()
    
    ---@type UnityEngine.Animator
    self.animator = nil


    local cfg = Config.GetConfigInfo("FishingCfg")
    minFishCount = cfg[1]
    maxFishCount = cfg[2]
    catchCount = cfg[3]
    fishingTime = cfg[4]
end

function CoveFishingAction:Init()
    if self.isInit then
       return 
    end

    ---@type table<integer, UnityEngine.GameObject>
    self.catchItems = {}
    local model = self.covebase._model
    self.fishNode = EngineUtil.FindDeepChild(model.transform, "Fish")
    self.fishNode = self.covebase.modelObj.transform
    if self.fishNode == nil then
        return
    end
    --加载鱼竿 鱼具
    local path = Config.PrefabPath.Cove_Fishrod
    PoolMgr:Get(path, function (fishrod)
        if self.covebase:IsDestroy() then
            LuaLogger.es("角色已经删除")
            PoolMgr.Free(fishrod)
            return
        end
        LuaLogger.ds("加载鱼竿成功 id:" .. self.covebase:GetID())
        fishrod.transform:SetParent(self.fishNode)
        fishrod.transform.localPosition = Vector3.zero
        fishrod.transform.localScale = Vector3.one
        fishrod.transform.localRotation = Quaternion.identity
        self.fishrod = fishrod
        --加载鱼饵
        local mode = fishrod.transform:Find("model")
        self.animator = mode:GetComponent(TypeInfo.Animator)
        self.catchNode = EngineUtil.FindDeepChild(fishrod.transform, "catchNode")
        if self.catchNode == nil then
            LuaLogger.es("catchNode 绑点未找到 prefab path:" .. path) 
        end
        self:OnInit()
    end)
end


function CoveFishingAction:OnInit()

    CoveActionBase.OnInit(self)
    self.covebase:SetDefaultState(RoleAnimStateType.FishingLoop)
    self:Action()

end
function CoveFishingAction:Begin()
    CoveActionBase.Begin(self)
    self:Init()
    self.playCount = math.random(minFishCount, maxFishCount)
    if self.isInit then
        self.covebase:SetDefaultState(RoleAnimStateType.FishingLoop)
        self:Action() 
    end
end

function CoveFishingAction:Action()
    if IsNull(self.fishrod) then
        LuaLogger.es("Action self.fishrod 被意外删除 id:" .. self.covebase:GetID())
        return 
    end
    self.fishrod:SetActive(true)
    local rl = math.random(1, catchCount)
    --播放开始钓鱼
    self.covebase._model:PlayAnim(RoleModelAnimEnum.Fishing, function()
        --加载钓鱼结果
        if self.catchItems[rl] ~= nil then
           return
        end
        local path = string.format(Config.PrefabPath.Cove_Catch, rl)
        PoolMgr:Get(path, function (catchObj)
                if self.covebase:IsDestroy() then
                    LuaLogger.es("角色已经删除")
                    PoolMgr.Free(catchObj)
                    return
                end
                catchObj.transform:SetParent(self.catchNode.transform)
                catchObj.transform.localPosition = Vector3.zero
                catchObj.transform.localScale = Vector3.one
                catchObj.transform.localRotation = Quaternion.identity
                catchObj:SetActive(false)
                self.catchItems[rl] = catchObj
            end)
    end)
    self.animator:SetTrigger("star")
  
    --等待若干时间
    local waitTime = fishingTime
    self:AddTimeWait(waitTime, function()
        for k, v in pairs(self.catchItems) do
            v:SetActive(k == rl)
        end
        self.animator:SetTrigger("show")
        self.covebase._model:PlayAnim(RoleModelAnimEnum.fishingShow, function()
            self.animator:SetTrigger("end")
            self.covebase._model:PlayAnim(RoleModelAnimEnum.fishingEnd, function() 
                for k, v in pairs(self.catchItems) do
                    v:SetActive(false)
                end  
                self.playCount = self.playCount - 1
                if self.playCount <= 0 then  
                    self:Stop()
                else
                    self:Action()
                end
            end)
        end)
    end)
end


function CoveFishingAction:Stop()
    --删除鱼竿 鱼具
    CoveActionBase.Stop(self)
    self:Exit()
end

function CoveFishingAction:Exit()
    CoveActionBase.Exit(self)
    self:DeleteAllWaitTime()
    --删除鱼竿 鱼具
    if IsNull(self.fishrod) then
        LuaLogger.es("self.fishrod 被意外删除 id:" .. self.covebase:GetID())
        if GV.IsEditor then
            UnityEngine.Debug.Break()
        end
    end
    if not IsNull(self.fishrod) then
       self.fishrod:SetActive(false) 
    end
    self.covebase._model:SetDefaultState(self.covebase:GetIdleStateVal())
end


function CoveFishingAction:Destroy()
    if IsNull(self.fishrod) then
        LuaLogger.es("鱼竿被删除 id:" .. self.covebase:GetID())
        self.fishrod = nil
    end
    if self.fishrod ~= nil then
        PoolMgr.Free(self.fishrod)
        self.fishrod = nil
    end

    if self.catchItems ~= nil then
        for k, v in pairs(self.catchItems) do
            if not IsNull(v) then
                PoolMgr.Free(v)
            end
        end
        self.catchItems = nil
    end
    CoveActionBase.Destroy(self)
end


return CoveFishingAction
