local DormPlantStateCtrl = BaseClass("DormPlantStateCtrl", BaseUICtrl)
local M = DormPlantStateCtrl

function M:Init()
    self._furnitureId = 0 -- 服务器下发的家具ID，唯一
    self._modelTrans = nil

    self._view.plantWater:onClick(Bind(self, self.OnPlantWater))
    self._view.plantPests:onClick(Bind(self, self.OnPlantKillBug))
    self._view.plantAward:onClick(Bind(self, self.OnPlantAward))

    self._changeState = EventMgr:AddListener(UIMessageNames.DORM_PLANT_STATE, Bind(self, self.OnChangeState))
end

function M:OnEnter(modelTrans, furnitureId)
    self._modelTrans = modelTrans
    self._furnitureId = furnitureId
    self:InitPlant()
end

function M:OnClose()
    -- 停止音效
    local state = DormDataMgr:GetRolePlantState(self._furnitureId)
    if state == DormConst.PlantType.Big then
        GameHelper.PlayAudioById(1228)
    elseif state == DormConst.PlantType.Complete then
        GameHelper.PlayAudioById(1225)
    end
    EventMgr:RemoveListener(UIMessageNames.DORM_PLANT_STATE, self._changeState)
end

function M:InitPlant()
    self._plantData = DormDataMgr:GetRolePlantConfig(self._furnitureId)

    if self._modelTrans == nil or not self._plantData then
        self:Close()
        return
    end

    local state = DormDataMgr:GetRolePlantState(self._furnitureId)
    self:_ShowState(state)

    local csType = typeof(CS.GameX.SceneToUI)
    local scene2UI = self._modelTrans:GetComponent(csType)

    if not scene2UI then
        scene2UI = self._modelTrans.gameObject:AddComponent(csType)
    end

    scene2UI.uiFlag = self._view.transform
end

-- 植物浇水
function M:OnPlantWater()
    self._view.plantWater:SetActive(false)
    EventMgr:Broadcast(UIMessageNames.DORM_PLANT_HANDLE, self._furnitureId, 1)
end

-- 植物杀虫
function M:OnPlantKillBug()
    self._view.plantPests:SetActive(false)
    EventMgr:Broadcast(UIMessageNames.DORM_PLANT_HANDLE, self._furnitureId, 2)
end

-- 植物领奖
function M:OnPlantAward()
    self._view.plantAward:SetActive(false)
    DormDataMgr:DoRqAwardPlantItem(self._furnitureId)
end

function M:OnChangeState()
    local state = DormDataMgr:GetRolePlantState(self._furnitureId)
    -- 播放一次音效
    if state == DormConst.PlantType.Small then
        --GameHelper.PlayAudioById(0)
    elseif state == DormConst.PlantType.Big then
        GameHelper.PlayAudioById(1229)
    elseif state == DormConst.PlantType.Complete then
        GameHelper.PlayAudioById(1226)
    elseif state == DormConst.PlantType.Reward then
        --GameHelper.PlayAudioById(0)
    elseif state == DormConst.PlantType.Fall then
        GameHelper.PlayAudioById(1223)
    end
    self:_ShowState(state)
end

function M:_ShowState(state)
    self._view.plantWater:SetActive(state == DormConst.PlantType.Water)
    self._view.plantPests:SetActive(state == DormConst.PlantType.Fall)
    self._view.plantAward:SetActive(state == DormConst.PlantType.Reward)
    -- 播放循环音效
    if state == DormConst.PlantType.Small then
        --GameHelper.PlayAudioById(0)
    elseif state == DormConst.PlantType.Big then
        GameHelper.PlayAudioById(1227)
    elseif state == DormConst.PlantType.Complete then
        GameHelper.PlayAudioById(1224)
    end
end

return DormPlantStateCtrl
