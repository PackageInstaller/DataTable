-- 驻员更换界面
--[[	基地：只有技能有效的会显示出来
]] local oldSelectIDs = {}
local selectIDS = {} -- 字典
local curCount = 0
local maxCount = 0
local presetIndex = nil -- 预设队伍下标

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/CRoleItem/DormSetPetListItem", LayoutCallBack, true)
    animLua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Diagonal)

    -- slider1 = ComUtil.GetCom(Slider1, "Slider")
    -- slider2 = ComUtil.GetCom(Slider2, "Slider")

    CSAPI.SetGOActive(mask, true)
end

function OnInit()
    UIUtil:AddTop2("DormSetPetList", gameObject, function()
        view:Close()
    end, nil, {})
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        local _isSelect = selectIDS[_data:GetID()] ~= nil
        -- local _isRepe = roomType == RoomType.building and IsRepe(_data) or false
        -- local _isUnUse = roomType == RoomType.building and (not IsUsable(_data)) or false
        lua.Refresh(_data, _isSelect) -- , _isRepe, _isUnUse)
    end
end

-- 先选择，点确定后再发送改动（其它宿舍移动到这个宿舍）
function ItemClickCB(item)
    -- 重复的不能选
    -- if (maxCount > 1)then -- and item.isRePe and not item.isSelect) then
    --     return
    -- end
    local id = item.curData:GetID()
    if (selectIDS[id]) then
        selectIDS[id] = nil
        curCount = curCount - 1
    elseif (maxCount == 1) then
        selectIDS = {}
        selectIDS[id] = 1
        curCount = 1
    else
        if (curCount < maxCount) then
            curCount = curCount + 1
            selectIDS[id] = 1
        else
            LanguageMgr:ShowTips(2002)
        end
    end
    SetScount()
    layout:UpdateList()
    curID = id
    SetCurSelectPanel()
end

function OnOpen()
    roomId = data[1] -- 房间id/建筑id
    _presetIndex = data[2]
    -- orderType = DormMgr:GetSetRoleSortUD()
    -- conditionData = DormMgr:GetSetRoleSortTab()
    roomType = DormMgr:GetRoomTypeByID(roomId) -- 房间类型

    -- if (openSetting) then
    --     sortId = openSetting
    -- else
    --     sortId = roomType == RoomType.building and 7 or 8
    -- end

    -- 排序
    -- if (not sortLua) then
    --     ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
    --         sortLua = ComUtil.GetLuaTable(go)
    --         sortLua.Init(sortId, ShowList)
    --     end)
    -- end

    InitDataBase()
    ShowList()
    SetScount()

    -- 默认选中第一个
    curID = oldSelectIDs[1]
    SetCurSelectPanel()

    local str = LanguageMgr:GetTips(2003)
    CSAPI.SetText(txtRempty, str)
end

function SetScount()
    local str = StringUtil:SetByColor(curCount, "ffc146")
    CSAPI.SetText(txtCount2, string.format("%s/%s", str, maxCount))
end

function InitDataBase()
    -- baseDatas = {}
    -- local arr = CRoleMgr:GetArr()
    if (roomType == RoomType.building) then
        -- 建筑 只看技能有效的 改 看所有人
        buildData = MatrixMgr:GetBuildingDataById(roomId)
        buildType = buildData:GetType()
        -- isOpen = CSAPI.IsViewOpen("MatrixTrading")
        -- local newArr = {}
        -- for i, v in ipairs(arr) do
        --     if (v:GetCfg().bAddToBuild == true) then -- and v:CheckSkillCanUseByBuildType(buildType)) then
        --         table.insert(newArr, v)
        --     end
        -- end
        -- baseDatas = newArr
        presetIndex = _presetIndex -- or buildData:GetCurPresetId()
        oldSelectIDs = presetIndex ~= nil and buildData:GetPrestRoles(presetIndex) or buildData:GetRoles()
        maxCount = buildData:GetMaxNum()
    else
        -- 宿舍 看所有人
        roomData = DormMgr:GetRoomData(roomId)
        -- if (#arr > 1) then
        --     for i, v in ipairs(arr) do
        --         if (v:GetCfg().bAddToBuild == true) then
        --             table.insert(baseDatas, v)
        --         end
        --     end
        -- end

        oldSelectIDs = roomData:GetRoles_pet()
        maxCount = roomData:GetMaxNum_pet()
    end

    selectIDS = {}
    curCount = 0
    for i, v in ipairs(oldSelectIDs) do
        selectIDS[v] = 1
        curCount = curCount + 1
    end

    baseDatas = DormPetMgr:GetArr()
    -- local arr =CRoleMgr:GetArr()
    -- if (#arr > 1) then
    --     for i, v in ipairs(arr) do
    --         if (v:GetCfg().bAddToBuild == true) then
    --             table.insert(baseDatas, v)
    --         end
    --     end
    -- end
end

function ShowList()
    -- local copyArr = {}
    -- for i, v in ipairs(baseDatas) do
    --     table.insert(copyArr, v)
    -- end
    -- curDatas = DormSetRoleSortUtil:SortByCondition(copyArr, roomId)
    -- if (orderType == 1) then
    --     local _curDatas = {}
    --     local len = #curDatas
    --     for i = len, 1, -1 do
    --         table.insert(_curDatas, curDatas[i])
    --     end
    --     curDatas = _curDatas
    -- end

    curDatas = baseDatas -- SortMgr:Sort(sortId, baseDatas, roomId)

    layout:IEShowList(#curDatas, FirstAnim)

    SetCurSelectPanel()
    --
    -- SetTab()
end

-- 首次调用完毕回调
function FirstAnim()
    if (not isAnimEnd) then
        isAnimEnd = true
        CSAPI.SetGOActive(mask, false)
    end
end

-- function SetTab()
--     local rota = orderType == RoleListOrderType.Up and 0 or 180
--     CSAPI.SetRectAngle(objSort, 0, 0, rota)
--     -- 排序,筛选
--     local id = conditionData.Sort[1]
--     -- local str = Cfgs["DormSort_Cfg"] and Cfgs.DormSort_Cfg:GetByID(id).sName or LanguageMgr:GetByID(3007)
--     local str = Cfgs.CfgDormSort:GetByID(id).sName or LanguageMgr:GetByID(3007)
--     CSAPI.SetText(txtSort, str)
-- end

function SetCurSelectPanel()
    curData = nil
    if (curID) then
        curData = DormPetMgr:GetData(curID)
    end
    CSAPI.SetGOActive(entityL, curData ~= nil)
    CSAPI.SetGOActive(emptyL, curData == nil)
    if (curData) then
        -- icon
        SetIcon(curData:GetBaseIcon())
        -- name 代号
        CSAPI.SetText(txtName, curData:GetAlias())
        -- -- pl
        -- local curTv = curData:GetCurRealTv()
        -- CSAPI.SetText(txtPL, string.format("%s<color=#929296>/%s</color>", curTv, 100))
        -- slider1.value = curTv / 100
        -- MatrixMgr:SetFace(face, curTv)
        -- -- lv 
        -- local curLv = curData:GetLv()
        -- CSAPI.SetText(txtLv, string.format("%s<color=#929296>/%s</color>", curLv, CRoleMgr:GetCRoleMaxLv()))
        -- slider2.value = curLv / CRoleMgr:GetCRoleMaxLv()
        -- in
        local roomName = curData:GetRoomNama() or "——"
        if (roomName ~= "——") then
            local inBuilding = curData:IsInBuilding()
            roomName = not inBuilding and (LanguageMgr:GetByID(32002) .. roomName) or roomName
        end
        CSAPI.SetText(txtIn, string.format("%s", roomName))
        -- skills
        -- SkillItems(curData)

        -- -- pl
        -- SetPL()
        -- -- cal 
        -- plTimer = nil
        -- plPerTimer = curData:GetPerTimer()
        -- if (plPerTimer and plPerTimer > 0) then
        --     plTimer = Time.time + plPerTimer
        -- end
        CSAPI.SetText(txtDesc, curData:GetCfg().PetStory)
        CSAPI.SetText(txtComfort, curData:GetCfg().comfort.."")
    end

    CSAPI.SetGOActive(SortNone, #curDatas <= 0)
end

-- function Update()
--     if (plTimer and Time.time > plTimer) then
--         plTimer = Time.time + plPerTimer
--         SetPL()
--     end
-- end
-- function SetPL()
--     local curTv = curData:GetCurRealTv()
--     CSAPI.SetText(txtPL, string.format("%s<color=#929296>/%s</color>", curTv, 100))
--     slider1.value = curTv / 100
--     MatrixMgr:SetFace(face, curTv)
-- end

function SetIcon(iconName)
    if (roleItem == nil) then
        local go = ResUtil:CreateUIGOAsync("CRoleItem/MatrixRole", iconParent, function(go)
            roleItem = ComUtil.GetLuaTable(go)
            roleItem.SetIcon_pet(iconName)
        end)
    else
        roleItem.SetIcon_pet(iconName)
    end
end

-- function SkillItems(curData)
--     local cfg = curData:GetAbilityCfg()
--     CSAPI.SetGOActive(skill, cfg ~= nil and cfg.arr ~= nil)
--     if (cfg ~= nil and cfg.arr ~= nil) then
--         -- icon
--         ResUtil.CRoleSkill:Load(imgSkill, cfg.icon)
--         -- name 
--         CSAPI.SetText(txtSkill, cfg.sName)
--         -- childs 
--         skillItemDatas = {}
--         local lv = curData:GetLv()
--         for i, v in ipairs(cfg.arr) do
--             local isUse = false
--             if (lv >= v.roleLvMin and lv <= v.roleLvMax) then
--                 isUse = true
--             end
--             local isLock = lv < v.roleLvMin
--             table.insert(skillItemDatas, {v, isUse, isLock})
--         end

--         skillItems = skillItems or {}
--         ItemUtil.AddItems("DormSetRole/DormSetRoleListItem1", skillItems, skillItemDatas, contentL)
--     end
-- end

--[[
-- 上下
function OnClickUD()
    orderType = orderType == 1 and 2 or 1
    DormMgr:SetSetRoleSortUD(orderType)
    -- local rota = orderType == 1 and 0 or 180
    -- CSAPI.SetRectAngle(objSort, 0, 0, rota)
    ShowList()
end

-- 筛选
function OnClickFiltrate()
    local mData = {}
    -- 需要单选
    mData.single = {
        ["Sort"] = 1
    } -- 1无意义
    -- 由上到下排序
    mData.list = {"Sort", "RoleTeam"} -- , "Pos"}
    -- 标题名(与list一一对应)
    mData.titles = {} -- {"排序", "分队"} -- , "所在房间"}
    table.insert(mData.titles, LanguageMgr:GetByID(3021))
    table.insert(mData.titles, LanguageMgr:GetByID(3022))
    -- 当前数据
    mData.info = conditionData
    -- 源数据
    local _root = {}
    _root.Sort = CfgDormSort -- SGSortCfg()
    -- _root.Theme = "CfgFurnitureTheme"
    _root.RoleTeam = CfgTeamEnum
    -- _root.Pos = SGPPosCfg()
    mData.root = _root
    -- 回调
    mData.cb = SortCB

    CSAPI.OpenView("SortView", mData)
end

function SortCB(newInfo)
    conditionData = newInfo
    DormMgr:SetSetRoleSortTab(newInfo)
    ShowList()
end

-- function SGSortCfg()
--     if (not Cfgs["DormSort_Cfg"]) then
--         local names = {"技能", "疲劳值", "好感度"}
--         local cfg = {}
--         for i, v in ipairs(names) do
--             cfg[i] = {
--                 id = i,
--                 key = i,
--                 sName = v
--             }
--         end
--         local _data = CfgBase.New()
--         _data:Init(cfg)
--         Cfgs["DormSort_Cfg"] = _data
--     end
--     return "DormSort_Cfg"
-- end

-- function SGPPosCfg()
--     if (not Cfgs["DormPos_Cfg"]) then
--         local names = {"未进驻"}
--         local datas = {} -- 建筑
--         local cfgs = Cfgs.CfgBuidingBase:GetAll()
--         local ids = {}
--         for i, v in pairs(cfgs) do
--             table.insert(ids, {v.id, v.name})
--         end
--         table.sort(ids, function(a, b)
--             return a[1] < b[1]
--         end)
--         for i, v in ipairs(ids) do
--             table.insert(names, v[2])
--             local _id = i + 1
--             table.insert(datas, {
--                 id = _id,
--                 key = _id,
--                 buildID = v[1]
--             })
--         end
--         -- table.insert(names, "宿舍")  --宿舍未开放
--         local cfg = {}
--         for i, v in ipairs(names) do
--             table.insert(cfg, {
--                 id = i,
--                 key = i,
--                 sName = v
--             })
--         end

--         local _data1 = CfgBase.New()
--         _data1:Init(cfg)
--         Cfgs["DormPos_Cfg"] = _data1

--         local _data2 = CfgBase.New()
--         _data2:Init(datas)
--         Cfgs["DormPos_Cfg_Datas"] = _data2
--     end
--     return "DormPos_Cfg"
-- end
]]
function CheckIsChange()
    local isChange = false
    if (curCount ~= #oldSelectIDs) then
        isChange = true
    else
        for i, v in ipairs(oldSelectIDs) do
            if (not selectIDS[v]) then
                isChange = true
                break
            end
        end
    end
    return isChange
end

function OnClickClear()
    selectIDS = {}
    curCount = 0
    SetScount()
    layout:UpdateList()
end

function OnClickSure()
    isChange = CheckIsChange()
    if (isChange) then
        local list = {}
        local curRoleIds = {}
        local isMove, isUsable = false, true
        for i, v in pairs(selectIDS) do
            local _data = DormPetMgr:GetData(i)
            local _roomId = _data:GetRoomBuildID() -- 未选择前的房间/建筑id
            -- 与当前的房间id做对比(宿舍id是100+，建筑id是10000+)
            local _isMove = false
            if (_roomId ~= nil and roomId ~= _roomId) then
                _isMove = true
            end
            if (_isMove) then
                if (not list[_roomId]) then
                    list[_roomId] = {}
                    list[_roomId].id = _roomId
                    local _roomType = DormMgr:GetRoomTypeByID(_roomId)
                    if (_roomType == RoomType.dorm) then
                        local _roleIds = DormMgr:GetRoomData(_roomId):GetRoles_pet()
                        list[_roomId].petIds = table.copy(_roleIds)
                        list[_roomId].teamId = nil -- DormMgr:GetRoomData(_roomId):GetCurPresetId()
                    else
                        local _roleIds = MatrixMgr:GetBuildingDataById(_roomId):GetRoles()
                        list[_roomId].petIds = table.copy(_roleIds)
                        list[_roomId].teamId = nil -- MatrixMgr:GetBuildingDataById(_roomId):GetCurPresetId()
                    end
                end
                for k, m in ipairs(list[_roomId].petIds) do
                    if (m == i) then
                        table.remove(list[_roomId].petIds, k)
                        break
                    end
                end
            end
            table.insert(curRoleIds, i)

            -- 其他建筑
            if (not isMove and _isMove) then
                isMove = true
            end
            -- -- 技能生效
            -- local _isUsable = IsUsable(_data)
            -- if (isUsable and not _isUsable) then
            --     isUsable = false
            -- end
        end
        -- 封装
        local infos = {}
        for i, v in pairs(list) do
            table.insert(infos, v)
        end
        table.insert(infos, {
            id = roomId,
            petIds = curRoleIds,
            teamId = presetIndex
        })
        local showTips, languageID = false, nil
        -- 交易中心的提示 
        -- for i, v in ipairs(infos) do
        --     local roomType = DormMgr:GetRoomTypeByID(v.id)
        --     if (roomType == RoomType.building) then
        --         local buildData = MatrixMgr:GetBuildingDataById(v.id)
        --         local buildType = buildData:GetType()
        --         if (buildType == BuildsType.TradingCenter) then
        --             local curRoleID = buildData:GetTradingCurRoleID()
        --             if (curRoleID) then
        --                 languageID = 2017
        --                 showTips = true
        --                 local croleInfo = CRoleMgr:GetData(curRoleID)
        --                 local tv = croleInfo:GetCurRealTv()
        --                 if (tv < 100) then
        --                     for k, m in ipairs(v.roleIds) do
        --                         if (m == curRoleID) then
        --                             showTips = false
        --                             break
        --                         end
        --                     end
        --                 end
        --             end
        --         end
        --     end
        -- end
        -- 宿舍、非建筑不提示
        if (roomType == RoomType.building and buildData:CheckIsBuilding()) then
            if (not isUsable and isMove) then
                showTips, languageID = true, 2303
            elseif (isMove) then
                showTips, languageID = true, 2304
            elseif (not isUsable) then
                showTips, languageID = true, 2305
            end
        elseif (roomType ~= RoomType.building and isMove) then
            showTips, languageID = true, 2304
        end

        if (showTips) then
            local str = LanguageMgr:GetTips(languageID)
            UIUtil:OpenDialog(str, function()
                SetRoles(infos, curRoleIds)
            end, nil)
        else
            SetRoles(infos, curRoleIds)
        end
    else
        -- Tips.ShowTips("未发生改动")
        view:Close()
    end
end

function SetRoles(infos, curRoleIds)
    if (not buildData) then
        -- 宿舍
        local needCount = #curRoleIds + roomData:GetMaxNum()
        if (DormMgr:GetEmptyNum() > needCount) then
            DormProto:SetPet(infos)
        else
            FuncUtil:Call(function()
                LanguageMgr:ShowTips(21034)
            end, nil, 100)
        end
    elseif (not presetIndex) then -- == buildData:GetCurPresetId()) then
        -- 更改当前队伍
        BuildingProto:BuildSetRole(infos)
    else
        -- 仅预设
        BuildingProto:BuildSetPresetRole(roomId, presetIndex, curRoleIds)
    end
    view:Close()
end

-- -- 技能无法重复（不同技能时判断repleaceType，相同技能时判断sameIsReplace） return true:不能重复
-- function IsRepe(_data)
--     if (not buildData:CheckIsBuilding()) then
--         return false
--     end
--     local isRepe = false
--     local repleaceType = _data:GetAbilityCfg().repleaceType -- 相同时不能重复
--     local sameIsReplace = _data:GetAbilityCfg().sameIsReplace -- 为1时不能重复
--     if (repleaceType ~= nil or sameIsReplace ~= nil) then
--         for k, v in pairs(selectIDS) do
--             local cRoleInfo = DormPetMgr:GetData(k)
--             local _cfg = cRoleInfo:GetAbilityCfg()
--             if (_data:GetAbilityId() == _cfg.id) then
--                 if (sameIsReplace ~= nil and _cfg.sameIsReplace and _cfg.sameIsReplace == sameIsReplace) then
--                     return true
--                 end
--             else
--                 if (repleaceType ~= nil and _cfg.repleaceType and _cfg.repleaceType == repleaceType) then
--                     return true
--                 end
--             end
--         end
--     end
--     return false
-- end

-- 技能不生效（交易中心单独处理并且MatrixTrading打开时处理）
-- function IsUnUse(_data)
-- if(isOpen and buildType and buildType == BuildsType.TradingCenter) then
-- 	local _cfg = _data:GetAbilityCfg()
-- 	if(_cfg.type ~= RoleAbilityType.Seller) then
-- 		return true
-- 	end
-- end
-- return false
-- end

-- -- 技能是否生效
-- function IsUsable(_data)
--     if (roomType == RoomType.building and buildData:CheckIsBuilding()) then
--         return _data:CheckSkillCanUseByBuildType(buildType)
--     end
--     return false
-- end

---返回虚拟键公共接口
function OnClickVirtualkeysClose()
    view:Close()
end
