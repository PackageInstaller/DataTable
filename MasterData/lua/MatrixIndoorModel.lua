function Awake()
    OnInit1()

    tool = MatrixRoleTool.New()
    tool:Awake(this, false)
end

function OnInit1()
    eventMgr = ViewEvent.New()
    -- 更换服装
    eventMgr:AddListener(EventType.Dorm_Change_Clothes, function(_data)
        tool:DormChangeClothes(_data)
    end)
    -- -- 文本
    -- eventMgr:AddListener(EventType.Dorm_Talk, function(_data)
    --     tool:AddBubble(_data[1], _data[2], _data[3])
    -- end)
end

function OnDestroy()
    eventMgr:ClearListener()

    tool = nil
end

function Update()
    tool:Update()
end

-- 生成场景模型
function Init(_indoorView)
    tool:Init(_indoorView)

    --AddEnterItem(_indoorView)
end

function Refresh()
    tool:Refresh()
end

-- function AddEnterItem(_indoorView)
--     local buildData = _indoorView.buildData
--     if (not isAdd) then
--         isAdd = 1
--         local index = nil
--         if (buildData:GetType() == BuildsType.ControlTower) then
--             index = 9
--         elseif (buildData:GetType() == BuildsType.PowerHouse) then
--         elseif (buildData:GetType() == BuildsType.ProductionCenter) then
--             index = 3
--         elseif (buildData:GetType() == BuildsType.TradingCenter) then
--             index = 5
--         elseif (buildData:GetType() == BuildsType.Expedition) then
--             index = 8
--         elseif (buildData:GetType() == BuildsType.Compound) then
--             index = 2
--         elseif (buildData:GetType() == BuildsType.Attack) then
--             -- 攻击建筑
--         elseif (buildData:GetType() == BuildsType.Defence) then
--             -- 防御建筑
--         elseif (buildData:GetType() == BuildsType.Remould) then
--             index = 1
--         elseif (buildData:GetType() == BuildsType.Entry) then
--             -- 入口建筑
--         end
--         if (index) then
--             if (not enterItem) then
--                 CSAPI.CreateGOAsync("Scenes/Matrix/MatrixEnterItem", 0, 0, 0, enterPoint, function(go)
--                     enterItem = ComUtil.GetLuaTable(go)
--                     enterItem.Init(_indoorView:GetDormGround().cameraGo) 
--                     enterItem.Refresh(buildData, index)
--                 end)
--             else
--                 enterItem.Refresh(buildData, index)
--             end
--         end
--     end
-- end
