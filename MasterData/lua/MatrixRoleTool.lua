-- 操作角色相关
MatrixRoleTool = {}
local this = MatrixRoleTool

function this.New(o)
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    return ins
end

function this:Awake(_main, _isDorm)
    self.main = _main
    self.isDorm = _isDorm
    self:InitAStar()

    Input, GetMouseButton, GetMouseButtonDown, GetMouseButtonUp, Physics = UIUtil:GetFuncs()
    eventCurrent = UnityEngine.EventSystems.EventSystem.current
    -- uiCamera = UIUtil:GetUICamera()
end

--初始化缓存数组的长度
function this:InitAStar()
    self.aStar = ComUtil.GetCom(self.main.gameObject, "AStar")
    local tab = {}
    for k = 1, 10 do
        local pos = UnityEngine.Vector3(0, 0, 0)
        table.insert(tab, pos)
    end
    self.aStar.cachePos = tab
end

function this:SceneCamera()
    if (not self.sceneCamera) then
        local ground = self.mainView.GetDormGround()
        self.sceneCamera = ground.GetCamera()
    end
    return self.sceneCamera
end

-- 相机移动节点
function this:TransCtrlGO()
    if (not self.transCtrlGO) then
        self.transCtrlGO = self.mainView.GetDormGround().transCtrl
    end
    return self.transCtrlGO
end

function this:Update()
    if (self.isInLayout) then
        -- 家具编辑
        self:EditFurniture()
    else
        -- 角色编辑  好友的角色不能操作
        if (self.isOwn) then
            self:EditRole()
        end
    end
end

function this:EditFurniture()
    if (GetMouseButtonDown(0) and not UIUtil.IsClickUI()) then
        local ray = self:SceneCamera():ScreenPointToRay(Input.mousePosition)
        if (self.curFurniture ~= nil) then
            local hits = Physics.RaycastAll(ray, 1000)
            if (hits and hits.Length > 0) then
                local len = hits.Length
                local box = self.curFurniture.box0.transform
                local point = false -- 点中选择

                -- 优先选择家具而非地毯
                local hit = nil
                for i = 0, len - 1 do
                    local _hit = hits[i].transform
                    if (_hit.gameObject.layer == DormLayer.furniture) then
                        if (hit == nil) then
                            hit = _hit
                        end
                        local furnitrue = ComUtil.GetLuaTable(_hit.parent.gameObject)
                        if (not furnitrue.data:IsCarpet()) then
                            hit = _hit
                            break
                        end
                    end
                end
                if (hit) then
                    if (hit == box) then
                        -- 点中当前
                        point = true
                    else
                        -- 初始添加的家具未保存之前不能添加
                        if (not self.curFurniture.IsFirst()) then
                            -- 切换到新物体
                            self.curFurniture.InSelect(false)
                            self.curFurniture = ComUtil.GetLuaTable(hit.parent.gameObject)
                            self.curFurniture.InSelect(true)
                        end
                        point = true
                    end
                end
                if (not point) then
                    self:InSelect(false)
                end
            end
        else
            -- 未选择
            local hits = Physics.RaycastAll(ray, 1000, 1 << DormLayer.furniture)
            if (hits and hits.Length > 0) then
                local len = hits.Length
                for i = 0, len - 1 do
                    local hit = hits[i].transform.parent
                    self.curFurniture = ComUtil.GetLuaTable(hit.gameObject)
                    self:InSelect(true)
                    break
                end
            end
        end
    end
end

function this:EditRole()
    -- 先UI相机发射射线检测,点击到ui则无视该次点击
    if (GetMouseButtonDown(0) and not UIUtil.IsClickUI()) then
        local ray = self:SceneCamera():ScreenPointToRay(Input.mousePosition)
        local hits = Physics.RaycastAll(ray, 1000, 1 << DormLayer.dorm_role)
        if (hits and hits.Length > 0) then
            local hit = hits[0].transform.parent
            self.curRole = ComUtil.GetLuaTable(hit.gameObject)
            if (not self.curRole:IsPet()) then
                pressTimer = Time.time + 0.2 -- 大于0.2s算长按
                self.isPress = true
            end
        end
    end
    if (self.isPress) then
        if (Time.time > pressTimer) then
            -- 拿起
            self.isPress = false
            if (self.mainView.GetChangeType() == 0) then
                -- 基地不能拿起
                if (self.isDorm) then
                    self:ChangeAction1(DormRoleActionType.click_grab, self.curRole)
                end
            end
        else
            -- 点击
            if (GetMouseButtonUp(0) and Time.time < pressTimer) then
                self.isPress = false
                if (self.mainView.GetChangeType() == 3) then
                    -- 送礼
                    if (self.curRole.data:IsMax()) then
                        LanguageMgr:ShowTips(21033) -- 当前角色已满级，无法继续赠送礼物
                        self.curRole = nil
                    else
                        self.mainView.SetGiftRole(self.curRole)
                    end
                else
                    -- 望向镜头有2种类型
                    local str = Dorm_GetClick(self.curRole.data)
                    self:ChangeAction1(DormRoleActionType[str], self.curRole)
                    self.curRole = nil
                end
            end
        end
    end
end

-- 点击或者抓起 （在点击，拿起，交互状态不处理）
function this:ChangeAction1(_action, curRole)
    if (not curRole or curRole.GetIsClick() or curRole.GetIsTookUp() or curRole.GetIsInte()) then
        return
    end
    curRole.ChangeAction(_action, self.isDorm)
    -- 隐藏换装按钮
    if (_action == DormRoleActionType.click_grab) then
        -- self:SetBtnCloths(curRole, false)
        EventMgr.Dispatch(EventType.Dorm_Role_Select)
    else
        -- self:SetBtnCloths(curRole)
        EventMgr.Dispatch(EventType.Dorm_Role_Select, curRole.data)
    end
end
--[[ 隐藏换装
function this:SetBtnCloths(curRole, b)
    b = b == nil and true or b
    if (self.oldRoleID) then
        self:SetBtnCloths2(self.oldRoleID, false)
    end
    self:SetBtnCloths2(curRole.data:GetID(), b)
    self.oldRoleID = curRole.data:GetID()
end
function this:SetBtnCloths2(id, b)
    -- local roleUI = self:GetRoleUI(id)
    -- if (roleUI) then
    --     roleUI.SetBtnCloths(b)
    -- end
    if (self.roleModels[id]) then
        self.roleModels[id].dormUI.SetBtnCloths(b)
    end
end
]]
-- 生成时初始化
function this:Init(_mainView)
    self.mainView = _mainView
    self.roleModels = {}
    self.indexs = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
    -- self.roleUIs = {}
    self.dormUIEmptys = {}
    self.furnitureModels = {}

    self.isOwn = true
    if (self.isDorm) then
        self.isOwn = self.mainView.curRoomData:GetFid() == nil
    end
    -- 生成场景资源
    self.isLoadRes = false
    local sceneKey = self.mainView.GetData():GetSceneKey()
    local sceneCfg = Cfgs.scene:GetByKey(sceneKey)
    local res = sceneCfg.res or {}
    local count = #res
    if (count > 0) then
        for i, v in ipairs(res) do
            CSAPI.CreateGOAsync(v, 0, 0, 0, self.main.gameObject, function(go)
                count = count - 1
                if (count <= 0) then
                    self.isLoadRes = true
                    if (not self.isRefresh) then -- 防止异步加载比主线程更快
                        self:Refresh()
                    end
                end
            end)
        end
    else
        self.isLoadRes = true
    end
end

-- 需要在生成场景资源之后再生成家具、角色（需在家具之后）
function this:Refresh()
    if (self.isLoadRes) then
        self.isRefresh = 1
        if (self.isDorm) then
            -- CSAPI.SetScale(self.main.gameObject,0,0,0)
            self.furnitureDatas = DormMgr:GetCopyFurnitureDatas()
            self:RefreshFurniture() -- >RefreshRoles
        else
            self:RefreshRoles()
        end
    end
end

-- 加载、刷新家具
function this:RefreshFurniture()
    local ids = {}
    for i, v in pairs(self.furnitureDatas) do
        ids[v:GetID()] = 1
    end
    local models = {}
    for i, v in pairs(self.furnitureModels) do
        models[i] = 1
    end
    for i, v in pairs(models) do
        if (ids[i]) then
            -- 已生成，刷新处理
            self.furnitureModels[i].Refresh(self.furnitureDatas[i])
            ids[i] = nil
        else
            -- 销毁
            CSAPI.RemoveGO(self.furnitureModels[i].gameObject)
            self.furnitureModels[i] = nil
        end
    end
    -- 新增
    local count = 0
    for i, v in pairs(ids) do
        if (v ~= nil) then
            count = count + 1
        end
    end
    if (count > 0) then
        for i, value in pairs(ids) do
            if (value ~= nil) then
                local _data = self.furnitureDatas[i]
                if (_data:GetParentID() == nil) then -- 如果是叠放的物体，则先生成父物体，子物体回调后生成
                    CSAPI.CreateGOAsync("Scenes/Dorm/DormFurniture", 0, 0, 0, self.main.furniturePoint, function(go)
                        local _lua = ComUtil.GetLuaTable(go)
                        _lua.Init(self)
                        _lua.Refresh(_data)
                        self.furnitureModels[_data:GetID()] = _lua

                        -- 生成子家具
                        local childIDs = _data:GetChildID()
                        if (childIDs) then
                            for k, m in ipairs(childIDs) do
                                self:CreateChildFurniture(m, go)
                            end
                        end

                        count = count - 1
                        if (count <= 0) then
                            self:SetFurnitureCB()
                        end
                    end)
                else
                    -- 是子物体
                    count = count - 1
                    if (count <= 0) then
                        self:SetFurnitureCB()
                    end
                end
            end
        end
    else
        self:SetFurnitureCB()
    end
end

-- 生成叠放的装饰
function this:CreateChildFurniture(id, father)
    local _data = self.furnitureDatas[id]
    CSAPI.CreateGOAsync("Scenes/Dorm/DormFurniture", 0, 0, 0, father, function(go)
        local _lua = ComUtil.GetLuaTable(go)
        _lua.Init(self)
        _lua.Refresh(_data)
        self.furnitureModels[_data:GetID()] = _lua
    end)
end

-- 生成家具完成回调
function this:SetFurnitureCB()
    -- CSAPI.SetScale(self.main.gameObject,1,1,1) --防止闪烁一下
    self:CheckGroundAndWallIsExit()
    self:Scan()
    if (not self.isInLayout) then
        self:RefreshRoles()
    end

    self:FurnituresUpdate()
end

-- 判断地面墙壁是否已生成，没则生成默认的，已生成则隐藏默认的
function this:CheckGroundAndWallIsExit()
    local isHadGround, isHadWall = false, false
    for i, v in pairs(self.furnitureDatas) do
        if (v:IsGround()) then
            isHadGround = true
        end
        if (v:IsWall()) then
            isHadWall = true
        end
        if (isHadWall and isHadGround) then
            break
        end
    end
    CSAPI.SetGOActive(self.main.Dormitory_Scene_04, not isHadGround)

    CSAPI.SetGOActive(self.main.Dormitory_Scene_03, not isHadWall)
end

-- 拖入家具(如果是地面墙壁则要特殊处理)
function this:FurnitureAdd(_data)
    local cfg = Cfgs.CfgFurniture:GetByID(_data[1])

    -- 地板和墙壁是唯一的
    if (cfg.sType == DormFurnitureType.ground or cfg.sType == DormFurnitureType.wall) then
        local removeID = self:GetRemoveIDByType(cfg.sType)
        local cfgID = removeID and GCalHelp:GetDormFurCfgId(removeID) or nil
        if (cfgID and cfg.id == cfgID) then
            -- 添加相同的墙壁或者地面
            LanguageMgr:ShowTips(21032)
            return
        end
        self:RemoveByID(removeID)
    end
    -- 创建一个家具数据
    local fakeData = DormMgr:CrateFurnitureFakeData(_data)
    self.furnitureDatas[fakeData:GetID()] = fakeData
    CSAPI.CreateGOAsync("Scenes/Dorm/DormFurniture", 0, 0, 0, self.main.furniturePoint, function(go)
        local _lua = ComUtil.GetLuaTable(go)
        _lua.Init(self)
        _lua.Refresh(fakeData)
        self.furnitureModels[fakeData:GetID()] = _lua

        -- 检查地面墙壁
        self:CheckGroundAndWallIsExit()

        -- 首次生成默认进入选择+拖拽状态
        if (cfg.sType ~= DormFurnitureType.ground and cfg.sType ~= DormFurnitureType.wall) then
            self.curFurniture = _lua
            self.isFirst = true
            self:InSelect(true)
        else
            self:InSelect(false)
        end
    end)
end

-- 移除家具
function this:FurnitureRemove(_data)
    local _cfgID = _data[1]
    local cfg = Cfgs.CfgFurniture:GetByID(_cfgID)
    if (cfg.sType == DormFurnitureType.ground or cfg.sType == DormFurnitureType.wall) then
        local removeID = self:GetRemoveIDByType(cfg.sType)
        self:RemoveByID(removeID)
        self:CheckGroundAndWallIsExit()
    else
        local removeID = self:GetRemoveIDByCfgID(_cfgID)
        self:RemoveByID(removeID)
    end
end

-- 根据类型获取家具id
function this:GetRemoveIDByType(type)
    for i, v in pairs(self.furnitureDatas) do
        if (v:GetCfg().sType == type) then
            return i
        end
    end
    return nil
end

-- 更换表id获取家具id
function this:GetRemoveIDByCfgID(_cfgID)
    for i, v in pairs(self.furnitureDatas) do
        local cfgID = GCalHelp:GetDormFurCfgId(v:GetID())
        if (cfgID == _cfgID) then
            return v:GetID()
        end
    end
    return nil
end

function this:RemoveByID(id)
    if (not id) then
        return
    end
    if (self.furnitureDatas[id]) then
        self.furnitureDatas[id] = nil
    end
    if (self.furnitureModels[id]) then
        CSAPI.RemoveGO(self.furnitureModels[id].gameObject)
        self.furnitureModels[id] = nil
    end
end

-- 生成角色(在生成模型之后)
function this:RefreshRoles()
    local ids = self.mainView.GetData():GetRoles()
    local idsDic = {}
    for i, v in ipairs(ids) do
        idsDic[v] = v
    end
    -- 
    if (self.isDorm) then
        local _ids = self.mainView.GetData():GetRoles_pet()
        for i, v in ipairs(_ids) do
            idsDic[v] = v
        end
    end
    -- 
    local removeIDs = {}
    for i, v in pairs(self.roleModels) do
        if (not idsDic[i]) then
            -- 清除引用
            local _index = self.roleModels[i].index
            self:ClearCurPosCache(_index)

            self.roleModels[i].Clear()
            self.roleModels[i] = nil

            -- 清除关联
            self:AddInteGos(i, nil)
            table.insert(removeIDs, v)
        else
            if (not self.aStar:NodeIsWalkable(v.gameObject)) then
                -- 随机可用点
                local pos = self:GetUsablePos(v.index)
                v.SetPos(UnityEngine.Vector3(pos[0], pos[1], pos[2]))
                -- 设置到最近可用的点
                -- aStar:SetToNearPos(v.gameObject)  
            end
            -- CSAPI.SetScale(v.gameObject, 1, 1, 1) -- 重设位置后再设置为1，防止未设置位置就已经和家具发生交互
            if (v.GetIsHide()) then
                v.ChangeAction(DormRoleActionType.idle) -- 改变状态	
            end
        end
    end
    self.inNUm = self.inNUm ~= nil and self.inNUm + 1 or 1
    local isPlayAudio = false
    for i, v in pairs(idsDic) do
        if (not self.roleModels[v]) then
            local path = self.isDorm and "Scenes/Dorm/DormRole" or "Scenes/Matrix/MatrixIndoorRole"
            local father = self.isDorm and self.main.rolePoint or self.main.gameObject
            CSAPI.CreateGOAsync(path, 0, 0, 0, father, function(go)
                local lua = ComUtil.GetLuaTable(go)
                local index = self:GetCanUseIndex()
                local arr = self:GetUsablePos(index)
                local info = nil
                if (v < 10000) then
                    info = self.isOwn and DormPetMgr:GetData(v) or DormPetMgr:GetFakeData(v)
                else
                    info = self.isOwn and CRoleMgr:GetData(v) or CRoleMgr:GetFakeData(v)
                end
                CSAPI.SetPos(go, arr[0], arr[1], arr[2])
                lua.Init(index, self, info, self.isDorm)
                self.roleModels[v] = lua
                if (self.inNUm > 1 and not self.isDorm and not isPlayAudio) then
                    isPlayAudio = true
                    -- 进入设施语言（仅基地）
                    RoleAudioPlayMgr:PlayByType(info:GetFirstSkinId(), RoleAudioType.allocation)
                end
            end)
        end
    end

    if (#removeIDs > 0) then
        EventMgr.Dispatch(EventType.Dorm_Roles_Remove, removeIDs)
    end
end

-- 角色是否已经全部加载
function this:IsLoadSuccess()
    if (self.roleModels) then
        for k, v in pairs(self.roleModels) do
            if (not v.CheckIsLoadSuccess()) then
                return false
            end
        end
    end
    return true
end

-- 用index来辨识每个role，用以获取不重复的初始位置和随机位置
function this:GetCanUseIndex()
    local index = 1
    for k, m in ipairs(self.indexs) do
        if (m == 0) then
            index = k
            self.indexs[k] = 1
            break
        end
    end
    return index
end

-- 清空当前位置缓存
function this:ClearCurPosCache(index)
    self.indexs[index] = 0
    self.aStar:RemoveIndex(index)
end

function this:GetUsablePos(index)
    return self.aStar:GetRandomPos2(index)
end

-- 位置当前是否有其他角色
function this:CheckIsIntersect(posArr, modelId)
    for i, v in pairs(self.roleModels) do
        if (v.modelId ~= modelId) then
            local arr = CSAPI.csGetPos(v.gameObject)
            local pos1 = UnityEngine.Vector3(posArr[0], posArr[1], posArr[2])
            local pos2 = UnityEngine.Vector3(arr[0], arr[1], arr[2])
            if (UnityEngine.Vector3.Distance(pos1, pos2) < 1) then
                return true
            end
        end
    end
    return false
end

function this:ChangeClothes(cRoleID)
    -- 呆状态
    for i, v in pairs(self.roleModels) do
        v.ChangeAction(DormRoleActionType.Await)
    end
    self.mainView.GetDormGround().ActiveCamera(false)
    CSAPI.OpenView("DormDress", {self.roleModels, cRoleID, function()
        self:DressCB()
    end})
end

function this:DressCB()
    for i, v in pairs(self.roleModels) do
        v.SetModelsLayer(false, 21)
        v.ChangeAction(DormRoleActionType.idle)
    end
    self.mainView.GetDormGround().ActiveCamera(true)
end

-- -- 气泡
-- function this:AddBubble(desc, cRoleID, timer)
--     if (self.roleUIs[cRoleID]) then
--         self.roleUIs[cRoleID].AddBubble(desc, timer)
--     end
-- end

function this:SetCamera2(b)
    local c2 = self.mainView.GetDormGround().cameraGo2
    CSAPI.SetGOActive(c2, b)
    if (b) then
        local cm1 = ComUtil.GetCom(self.mainView.GetDormGround().cameraGo, "Camera")
        local cm2 = ComUtil.GetCom(self.mainView.GetDormGround().cameraGo2, "Camera")
        cm2.fieldOfView = cm1.fieldOfView
    end
end

function this:Exit()
    if (self.furnitureModels) then
        for i, v in pairs(self.furnitureModels) do
            CSAPI.RemoveGO(v.gameObject)
        end
    end
    self.furnitureModels = {}

    -- for i, v in pairs(self.roleUIs) do
    --     CSAPI.RemoveGO(v.gameObject)
    -- end
    -- self.roleUIs = {}

    for i, v in pairs(self.roleModels) do
        v.Clear()
    end
    self.roleModels = {}
end

-- function this:GetRoleUI(cRoleID)
--     return self.roleUIs[cRoleID]
-- end

-- 送礼
function this:SetInGift(isShow)
    for i, v in pairs(self.roleModels) do
        v.dormUI.InGift(isShow)
    end
end

-- 送礼回调
function this:SetGiftCB(roleId)
    -- local roleUI = self:GetRoleUI(roleId)
    -- if (roleUI) then
    --     roleUI.SetGift()
    -- end
    self.roleModels[roleId].dormUI.SetGift()
end

-- 是否在送礼
function this:CheckIsGift()
    return self.mainView.GetChangeType() == 3
end

-- 进退家具编辑模式
function this:InLayout(isChange)
    self.isInLayout = self.mainView.CheckIsLayout()
    if (self.isInLayout) then
        -- 编辑家具、人员时,移除所有碰撞关联
        for i, v in pairs(self.roleModels) do
            v.ChangeAction(DormRoleActionType.Hide)
            v.ClearFurnitureAnim() -- 清楚关联的家具动作
            v.RemoveAllInte()
        end
    else
        -- 如果有家具或者人员变动，则放在Scan后处理,有家具变动必定重新进入RefreshRoles
        if (not isChange) then
            -- 退出家具编辑，修改格子通行状态
            if (self.mainView.GetChangeType() == 2) then
                self:Scan()
            end

            if (self.oldIsInLayout) then
                for i, v in pairs(self.roleModels) do
                    if (not self.aStar:NodeIsWalkable(v.gameObject)) then
                        -- 随机可用点
                        local pos = self:GetUsablePos(v.index)
                        v.SetPos(UnityEngine.Vector3(pos[0], pos[1], pos[2]))
                        -- 设置到最近可用的点
                        -- aStar:SetToNearPos(v.gameObject)  
                    end
                    v.ChangeAction(DormRoleActionType.idle) -- 改变状态	
                end
            end
        end
        self:InSelect(false)
    end
    -- 地面网格
    if (self.isDorm) then
        self:SetGridActive(self.isInLayout)
    end

    self.oldIsInLayout = self.isInLayout
end

-- -- 调整相机位置（编辑与否状态）
-- function this:SetCamera()
--     DormMgr:SetSceneCameraAction(not self.isInLayout) -- 相机可否滑动

--     local sceneCamera = self:SceneCamera()
--     local transCtrlGO = self:TransCtrlGO()
--     -- 调整相机父亲的位置
--     if (not transCtrlGO) then
--         return
--     end
--     if (self.isInLayout) then
--         self.oldCameraPos = CSAPI.csGetLocalPos(transCtrlGO)
--         self.oldCameraAngle = CSAPI.csGetAngle(transCtrlGO)
--         self.oldFieldOfView = sceneCamera.fieldOfView
--         CSAPI.SetLocalPos(transCtrlGO, 0, 0, 0)
--         CSAPI.SetAngle(transCtrlGO, 0, 0, 0)
--         sceneCamera.fieldOfView = 45
--     else
--         if (self.oldCameraPos) then
--             CSAPI.SetLocalPos(transCtrlGO, self.oldCameraPos[0], self.oldCameraPos[1], self.oldCameraPos[2])
--         end
--         if (self.oldCameraAngle) then
--             CSAPI.SetAngle(transCtrlGO, self.oldCameraAngle[0], self.oldCameraAngle[1], self.oldCameraAngle[2])
--         end
--         if (self.oldFieldOfView) then
--             sceneCamera.fieldOfView = self.oldFieldOfView
--         end
--     end
-- end

-- 重新计算可行走区域
function this:Scan()
    self:SetFurnitureTrigger(true)
    self.aStar.astar:Scan()
    self.aStar:InitWalkablePos()
    self:SetFurnitureTrigger(false)
end

function this:SetFurnitureTrigger(isScaning)
    for k, v in pairs(self.furnitureModels) do
        v.SetBoxToScan(isScaning)
    end
    -- local boxs = ComUtil.GetComsInChildren(self.main.furniturePoint, "BoxCollider")
    -- local len = boxs.Length - 1
    -- for i = 0, len do
    --     if (boxs[i].gameObject.layer == DormLayer.furniture) then
    --         boxs[i].isTrigger = b
    --     end
    -- end
end

-- 进入选中模式
function this:InSelect(isSelect)
    if (self.curFurniture) then
        self.curFurniture.InSelect(isSelect, self.isFirst)
        self.isFirst = false
    end
    if (not isSelect) then
        self.curFurniture = nil
    end
    local isInWall = false
    if (self.curFurniture) then
        isInWall = self.curFurniture.data:GetPlaneType() ~= 1
    end
    EventMgr.Dispatch(EventType.Dorm_Furnitrue_Select, {isSelect, isInWall})

    DormMgr:SetSceneCameraAction(self.curFurniture == nil) -- 相机可否滑动

    self:FurnituresUpdate()
end

-- 编辑中 
function this:CheckIsSelect()
    return self.curFurniture ~= nil
end

-- 旋转
function this:Rotate()
    if (self.curFurniture) then
        self.curFurniture.SetRotate()
    end
end

-- 回收当前
function this:Recycle()
    if (self.curFurniture) then
        local id = self.curFurniture.data:GetID()
        CSAPI.RemoveGO(self.curFurniture.gameObject)
        self.furnitureDatas[id] = nil
        self.furnitureModels[id] = nil
        self:InSelect(false)
    end
end

-- 确定
function this:Sure()
    if (self.curFurniture) then
        self:InSelect(false)
    end
end

-- 回收所有
function this:Clear()
    for i, v in pairs(self.furnitureDatas) do
        self.furnitureDatas[i] = nil
    end
    self:RefreshFurniture()
    self.mainView.RefreshCurUI()
    self:InSelect(false)
end

-- 当前有编辑家具，并且该家具真发生碰撞
function this:CheckCanSave()
    if (self.curFurniture ~= nil and self.curFurniture.CheckIsInCol()) then
        return false
    end
    return true
end

-- 保存
function this:Save()
    local id = self.mainView.curRoomData:GetID()
    local _furnitureDatas = DormMgr:GetChangeFurnitureDatas()
    DormProto:ModFurniture(id, _furnitureDatas, DormMgr:GetScreenshotFileName(id))

    LanguageMgr:ShowTips(21027)
end

-- 还原进入之前
function this:DontSave()
    self.furnitureDatas = DormMgr:GetCopyFurnitureDatas()
    self:RefreshFurniture()
end

-- 是否有修改  
function this:CheckIsSame()
    -- 当前
    local dic2 = {}
    for i, v in pairs(self.furnitureDatas) do
        dic2[v:GetID()] = v:GetData()
    end
    local isSame = FuncUtil.TableListIsSame(self.mainView.curRoomData:GetFurnitures(), dic2)
    return isSame
end

-- 服装更换回调
function this:DormChangeClothes(proto)
    local roleId = proto.roleId
    for i, v in pairs(self.roleModels) do
        if (v.data:GetID() == roleId) then
            v:ChangeModel()
            break
        end
    end
end

function this:GetFurnitureDataByID(id)
    return self.furnitureDatas[id]
end

function this:GetFurnitureModelByID(id)
    return self.furnitureModels[id]
end

function this:GetRoleModels()
    return self.roleModels
end

-- 当前选中的家具的数据
function this:GetCurFurnitreData()
    if (self.curFurniture) then
        return self.curFurniture.data
    end
    return nil
end

-- 当前选择是否存在碰撞
function this:CheckCurIsInCol()
    if (self.curFurniture) then
        return self.curFurniture.CheckIsInCol()
    end
    return false
end

-- 记录角色当前有些碰撞的物体
function this:AddInteGos(cRoleID, go)
    self.inteGos = self.inteGos or {}
    self.inteGos[cRoleID] = go
end

function this:CheckCanCol(go)
    if (self.inteGos) then
        for i, v in pairs(self.inteGos) do
            if (v == go) then
                return false
            end
        end
    end
    return true
end

-- 网格显示隐藏
function this:SetGridActive(b)
    if (self.isDorm) then
        CSAPI.SetGOActive(self.main.grid, b)
    end
end

-- 拿起时人物按格移动
function this:GetRoleCorrectPoint(point)
    if (not self.offset) then
        local scale = DormMgr:GetDormScale()
        local lenX = scale.x
        -- 偏移
        self.offset = {}

        self.offset[1] = lenX / 2 > math.floor(lenX / 2) and 0 or 0.5 -- 偶然边长+0.5 
        self.offset[2] = 0
        self.offset[3] = lenX / 2 > math.floor(lenX / 2) and 0 or 0.5

        -- 区间
        self.limitXYZ = {}

        self.limitXYZ[1] = -(lenX * 0.5 - 0.5)
        self.limitXYZ[2] = (lenX * 0.5 - 0.5)
        self.limitXYZ[3] = 0
        self.limitXYZ[4] = 0
        self.limitXYZ[5] = -(lenX * 0.5 - 0.5)
        self.limitXYZ[6] = (lenX * 0.5 - 0.5)
        for i = 1, 6 do
            self.limitXYZ[i] = self:LimitNum(self.limitXYZ[i])
        end
    end

    local x1, x2 = math.modf(point.x)
    point.x = math.abs(x2) == 0.5 and math.floor(point.x) + self.offset[1] or math.floor(point.x + 0.5) + self.offset[1]
    local z1, z2 = math.modf(point.z)
    point.z = math.abs(z2) == 0.5 and math.floor(point.z) + self.offset[3] or math.floor(point.z + 0.5) + self.offset[3]

    -- 限制范围
    if (point.x < self.limitXYZ[1]) then
        point.x = self.limitXYZ[1]
    elseif (point.x > self.limitXYZ[2]) then
        point.x = self.limitXYZ[2]
    end
    if (point.z < self.limitXYZ[5]) then
        point.z = self.limitXYZ[5]
    elseif (point.z > self.limitXYZ[6]) then
        point.z = self.limitXYZ[6]
    end
    return point
end

-- 限制精度，否则会出现很长的浮点数
function this:LimitNum(num)
    if (num == math.floor(num)) then
        return num
    end
    return (num + 0.5) >= math.ceil(num) and math.floor(num) + 0.5 or math.floor(num)
end

-- 已放置的家具闪烁
function this:SetShadowFlicker(cfgID)
    for k, v in pairs(self.furnitureModels) do
        if (cfgID == v.data:GetCfgID()) then
            v.SetShadow2()
        end
    end
end

-- 家具有更新
function this:FurnituresUpdate()
    EventMgr.Dispatch(EventType.Dorm_Furnitrues_Update)
end

return this
