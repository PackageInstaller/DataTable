---@class DockRolePanel : DockRolePanel_Generate
---##################### 【DockRolePanel Custom Field】  Start #####################
---TODO 自定义变量声明在这里: ---@field [public|protected|private] field_name FIELD_TYPE[|OTHER_TYPE]
---%%%%%%%%%%%%%%%%%%%%% 【DockRolePanel Custom Field】 End %%%%%%%%%%%%%%%%%%%%%
local DockRolePanel = require "DockRolePanel_Generate"
local utf8util = require "utf8util"
local DOTween = DG.Tweening.DOTween
local Screen = UnityEngine.Screen
local cjson = require "cjson"
-- local LoopTextRoller = require "LoopTextRoller"

-- 模块级工具函数，避免每次 SetView 调用都重建
local function is_numeric(str)
    return tonumber(str) ~= nil
end

local function getAffectionRewardMaxLevel(affectionRewardList)
    local maxLevel = 0
    if affectionRewardList then
        for _, level in pairs(affectionRewardList) do
            if level > maxLevel then
                maxLevel = level
            end
        end
    end
    return maxLevel
end

-- 筛选列表预处理为 O(1) 查找表，0 表示该维度全选
local function buildFiltrateLookup(filtrateList)
    local lookup = {}
    local acceptAll = false
    if filtrateList then
        for _, value in pairs(filtrateList) do
            if value == 0 then
                acceptAll = true
            else
                lookup[value] = true
            end
        end
    end
    return lookup, acceptAll
end

local function matchFiltrateLookup(lookup, acceptAll, data)
    return acceptAll or lookup[data] == true
end

function DockRolePanel:InitLogic(data)
    self.msgEventHandler = {
        {GameMsgType.RefreshTopResource, function()
            self.customBackPanel.customBackPanel:RefreshTopResource()
        end},
        {GameMsgType.HeroLevelUp, self.Refresh},
        {GameMsgType.HeroSkillChange, self.Refresh},
        {GameMsgType.HeroSkinChange, self.Refresh},
        {GameMsgType.HeroNatureChange, self.Refresh},
        {GameMsgType.ItemMapNtf, self.RefreshGiftListView},
    }
    self.nowSortMode = 1    --当前排序模式 默认
    self.sortBtnlist = {}
    self.natureBtnlist = {}
    self.nowSortIndex = 1
    self.lastSortIndex = nil --上次选中的模式
    self.nowNatureMode = nil

    self.roleData = nil
    self.maxLevel = 100     --最大等级 等配置
    self.roleSeverData = {}
    self.checkDrag = false      --滑动切换判定开启开关
    self.inRecover = false      --滑动切换判恢复开关
    self.RoleIndex = 1        --当前index 到达列表最大值时变回1
    self.nowSelectRoleID = nil
    --self.RoleList = {}
    self.roleConfig = {}

    self.filtrateData = nil
    self.nowSortFace = 1            --排序正反 默认从大到小
    self.RoleList = {}

    self.roleBoxList = {}
    self._roleIdToIndex = {}
    self._roleIdToEntry = {}
    self._roleListRedMap = {}
    self.nowSelectRoleData = {}
    self.affectionBoxList = {}
    self.nowMode = nil       --1 角色选择 2 角色详情 3 羁绊 4 档案

    self.filesModeType = 1 --1 角色档案 2 角色语音
    -- UIMgr:depositUI(self)
    self.characterId = nil   --打开时指定角色ID

    self.nowAudioKey = nil
    self.nowPlayCvObj = nil

    self.clickPos = Vector2.zero
    self.nowRoleBox = nil --当前角色格子
    self.nowShowSpineObj = nil
    self.nextRoleBox = nil --下一个角色格子
    self.nextShowSpineObj = nil
    self.needScreenWidth = nil --屏幕宽度值
    self.dragMoveWidth = 0 --滑动移动距离
    self.isLockDrag = true --是否锁定滑动
    self.needDragUpdate = false --是否需要每帧跑滑动检测（列表有数据且未锁定滑动）
    self._sortCompareCacheKey = nil --排序比较函数缓存键
    self._sortCompareCacheFunc = nil --排序比较函数缓存
    self._insufficientToastIndex = nil

    self.uiModeType = {
        ["normal"] = 1, --普通模式
        ["hankBook"] = 2, --图鉴模式
        ["character"] = 3, --角色模式
    }

    self.uiMode = self.uiModeType.normal --默认界面模式
    self.btnSoundPath = string.format(Config.AudioPath.SE, "click")
    self.giftObjList = {} --礼物预制体列表
    self.nowSelectGiftIndex = nil --当前选中礼物索引
    self.nowSelectGiftId = nil --当前选中礼物ID
    self.nowSelectGiftCount = 0 --当前选中礼物数量
    self.longPressTimer = nil
    self.likeMode = false --是否在喜爱筛选模式
    self.pendingSortRefresh = false --是否有待执行的排序刷新（非角色列表模式时触发升级/升星等操作后延迟执行）

    --好感度入场动画相关
    -- self.maxBgEndPos = self.maxBg.transform.position
    -- self.maxIconEndPos = self.maxIcon.transform.position
    -- self.linkEndPos = self.link.transform.position
    -- self.affectionLevelUpBtnEndPos = self.affectionLevelUpBtn.transform.position
    local newObj = Instantiate(self.affectionbtnParent)
    newObj:SetParent(self.startPos.transform)
    newObj.transform.localPosition = Vector3.zero
    -- self.maxBgStartPos = newObj.transform:Find("maxBg").transform.position
    -- self.maxIconStartPos = newObj.transform:Find("maxIcon").transform.position
    -- self.linkStartPos = newObj.transform:Find("link").transform.position
    -- self.affectionLevelUpBtnStartPos = newObj.transform:Find("AffectionLevelUpBtn").transform.position
    self.btnPatentStartPos = newObj.transform.position
    GameObject.Destroy(newObj)
    self._repeatTimer = {}
    self.skillMsgPanel.skillMsgPanel:setMono(self)
    self.roleList.loopGridView:InitGridView(0, BindCallback_NoParams(self, self.OnRoleItemValueChange))
end

--function DockRolePanel:StartCreating(time)
--
--end

--function DockRolePanel:StartEnter(time)
--
--end

--function DockRolePanel:StartRemoving(time)
--
--end

--function DockRolePanel:StartExit(time)
--
--end

function DockRolePanel:OnOpen(data, initiative)
    self:SetUpdateInterval(0)
    self.customBackPanel.customBackPanel:ClearBackFunc()
    -- self.transform:GetComponent("GraphicRaycaster").enabled = true
    self.uiMode = data and data.uiMode or self.uiModeType.normal
    if self.uiMode == self.uiModeType.character then
        self.nowMode = 2
    end
    self.characterId = data and data.characterId or nil
    self:__RefreshNavigation()

    if initiative then
        self:initShowRoleBox()
        self:SetView()
        self:SortInfo()
        self:sortView()
        self:SelectMode(self.nowMode or 1, true)
        self:refreshSortView()
        self:CheckNeedDrag()
        self:SetPostProcessing()
        self:SetUpdateInterval(0)
    else
        if self.uiMode == self.uiModeType.hankBook or self.uiMode == self.uiModeType.character then
            -- 图鉴/角色模式从子界面返回时不刷新角色列表，保持选中角色与滚动位置
        else
            self:SetView(self.filtrateData, true, nil, true)
        end
        self:SelectMode(self.nowMode, true)
        self:SetSkillListView()
    end
    self:changeUiModeView()
    LoadingMgr:SetUISwitchOver(function()
        GuideMgr:StartGuideTrigger("DockRolePanel")
    end)
end

--设置相机的后处理
function DockRolePanel:SetPostProcessing()
    --特效相关
    -- local UICamera = UIMgr.uiCamera
    
    -- local cameraData = UICamera:GetComponent(typeof(UnityEngine.Rendering.Universal.UniversalAdditionalCameraData))
    -- if cameraData then
    --     cameraData.renderPostProcessing = true                      --后处理
    --     cameraData.volumeTrigger = self.volume.transform          --特效触发器
    --     cameraData.volumeLayerMask = LayerMask.GetMask("UI")            --默认层和UI层
    -- end
end

--根据UI模式，切换不同显示内容
function DockRolePanel:changeUiModeView()
    self.affectionlBtn:SetActive(self.uiMode == self.uiModeType.normal and self.roleConfig.isSpecial ~= 1
        and (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.RoleAffectionl)) ~= GE.FunctionOpenState.Lock)
    self.filesBtn:SetActive(self.uiMode == self.uiModeType.normal and (UICommonUtils.CheckFunctionOpen(GE.FunctionOpenModule.RoleFiles)) ~= GE.FunctionOpenState.Lock)
    -- self.likeView:SetActive(self.uiMode == self.uiModeType.normal)
    -- self.showMsgBtn:SetActive(self.uiMode == self.uiModeType.normal)
    self.skinBtn:SetActive(self.uiMode == self.uiModeType.normal)
    self.levelUpBtn:SetActive(self.uiMode == self.uiModeType.normal)
    self.starUpBtn:SetActive(self.uiMode == self.uiModeType.normal) 
    self.weaponView:SetActive(self.uiMode == self.uiModeType.normal)
    self.equipView:SetActive(self.uiMode == self.uiModeType.normal)
    self.storyView:SetActive(self.uiMode == self.uiModeType.hankBook or self.uiMode == self.uiModeType.character)
    ---新增角色模式
    self.toggleList:SetActive(self.uiMode == self.uiModeType.normal or self.uiMode == self.uiModeType.hankBook)
    self.changeNameBtn:SetActive(self.uiMode == self.uiModeType.normal)
end

--初始化角色显示格子
function DockRolePanel:initShowRoleBox()
    self.showRoleBox1.rectTransform.anchoredPosition = Vector2.New(0, 0)
    self.showRoleBox2.rectTransform.anchoredPosition = Vector2.New(Screen.width, 0)
    self.nowRoleBox = self.showRoleBox1
    self.nextRoleBox = self.showRoleBox2
end

--加载角色spine
---@param nowRoleBox UnityEngine.GameObject
---@param skinConfig CharacterSkinTable
---@param nowSpineObj string  
function DockRolePanel:initShowSpine(nowRoleBox, skinConfig, nowSpineObj)
    if UICommonUtils.Checkobj(self[nowSpineObj]) then
        if skinConfig.spineKey ~= "" and self[nowSpineObj].name == skinConfig.spineKey then
            return
        end
    end
    local function destroySpineObj()
        if UICommonUtils.Checkobj(self[nowSpineObj]) then
            GameObject.Destroy(self[nowSpineObj])
            self[nowSpineObj] = nil
        end
    end
    if skinConfig.spineKey == "" then
        destroySpineObj()
    end
    UICommonUtils:ShowRolePicOrSpine(self, nowRoleBox.showCharacter, skinConfig.id, function(spineObject)
        destroySpineObj()
        spineObject.name = skinConfig.spineKey
        --设置spine物理效果
        local objSpine = spineObject:GetComponent("SkeletonGraphic")
        objSpine.PhysicsPositionInheritanceFactor = Vector2.New(0.1, 0.1)

        if self.needAnim then
            local myRT = spineObject:GetComponent("SkeletonGraphicRenderTexture_Custom")
            myRT.enabled = true
        end

        self[nowSpineObj] = spineObject
    end)
end

--排序文字显示处理
function DockRolePanel:sortView()
     if self.sortSelectList.activeSelf then
        if self.nowSortIndex == GE.RoleSortType.nature and self.nowNatureMode == nil then
            self.sortSelectList:SetActive(false)
            self.nowSortIndex = self.lastSortIndex
            self.nowSortMode = self.lastSortIndex
            if self.nowSortMode == GE.RoleSortType.nature and self.nowNatureMode ~= nil then
                self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
            else
                self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
            end
        end
    end
end

--根据当前界面页签刷新导航栏
function DockRolePanel:__RefreshNavigation()
    --导航栏
    if self.nowMode == 1 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.DockRolePanel)
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = false
            if self.uiMode == self.uiModeType.hankBook then
                UIMgr:closeSpecificUI(self)
            else
                UIMgr:closeUI(self)
                self.customBackPanel.customBackPanel.backBtn.scaleButton.interactable = true
                self:stopNowAudio()
            end
            --清空返回方法
            self.customBackPanel.customBackPanel:ClearBackFunc()
        end)
    elseif self.nowMode == 2 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.DockRolePanel_Info)
        --接管返回方法
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            if self.uiMode == self.uiModeType.character then
                UIMgr:closeSpecificUI(self)
            else
                self:SelectMode(1)
            end
        end)
    elseif self.nowMode == 3 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.DockRolePanel_Info_Affectionl)
        --接管返回方法
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self:SelectMode(1)
        end)
    elseif self.nowMode == 4 then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.DockRolePanel_Info_Files)
        --接管返回方法
        self.customBackPanel.customBackPanel:OverrideBackFunc(function()
            self:SelectMode(1)
        end)
    end

    if self.uiMode == self.uiModeType.hankBook then
        self.customBackPanel.customBackPanel:Bind(GE.NavigationType.HandbooksChar)
    end
end

---排序后重建 roleBoxList、roleId 索引与列表红点缓存
function DockRolePanel:RebuildRoleListDerivedCaches()
    self.roleBoxList = {}
    self._roleIdToIndex = {}
    self._roleIdToEntry = {}
    self._roleListRedMap = {}

    local roleList = self.RoleList
    local needRedMap = self.uiMode == self.uiModeType.normal

    for index, value in ipairs(roleList) do
        local roleId = value.config.id
        local skinConfig = Config.GetCharacterSkinInfo(value.server.equipSkin)
        local entry = {
            index = index,
            skinConfig = skinConfig,
            roleData = value,
        }
        table.insert(self.roleBoxList, entry)
        self._roleIdToIndex[roleId] = index
        self._roleIdToEntry[roleId] = entry

        if needRedMap and RedPointMgr:DockRolePanelRoleListRedJudge(roleId) then
            self._roleListRedMap[roleId] = true
            RedPointMgr:SetRedDotState("DockBtnRedJudge" .. roleId, true)
        end
    end
end

---将 roleId 同步到 nowSelectRoleID / nowSelectRoleData / RoleIndex
function DockRolePanel:ApplySelectRoleEntry(roleId)
    if not roleId then
        return false
    end
    self.nowSelectRoleID = roleId
    local entry = self._roleIdToEntry[roleId]
    if entry then
        self.nowSelectRoleData = entry
        self.RoleIndex = entry.index
        return true
    end
    for _, value in ipairs(self.roleBoxList) do
        if value.roleData.config.id == roleId then
            self.nowSelectRoleData = value
            self.RoleIndex = value.index
            return true
        end
    end
    return false
end

---刷新所有可见格子的选中态（安全 API，不重绑对象池 Replace）
function DockRolePanel:RefreshRoleListSelectionState()
    if #self.RoleList > 0 then
        self.roleList.loopGridView:RefreshAllShownItem2()
    end
end

---同步 LoopGridView 数量与可见格数据（筛选/排序后调用）
function DockRolePanel:SyncRoleListGrid(newCount, resetPos)
    local loopGridView = self.roleList.loopGridView
    local oldCount = loopGridView.ItemTotalCount
    if newCount ~= oldCount then
        loopGridView:SetListItemCount(newCount, resetPos ~= false)
    end
    if newCount > 0 then
        -- SetListItemCount 在数量变少时只回收超出项，不会重绑仍留在视野内的格子，
        -- 导致 index 0~N 的 UI 仍显示筛选前的角色；必须强制 RefreshAllShownItem 重绑数据
        loopGridView:RefreshAllShownItem()
    elseif oldCount > 0 then
        loopGridView:SetListItemCount(0, true)
    end
    self.checkDrag = newCount > 0
    self:RefreshNeedDragUpdate()
end

---解析 SetView 后应选中的 roleId
function DockRolePanel:ResolveSelectRoleId(isSort, roleList)
    if not roleList or not next(roleList) then
        return nil
    end
    if not isSort then
        if self.uiMode == self.uiModeType.character and self.characterId ~= nil then
            return self.characterId
        end
        return roleList[1].config.id
    end
    local selectRoleId = self.nowSelectRoleID
    if selectRoleId and self._roleIdToEntry[selectRoleId] then
        return selectRoleId
    end
    return roleList[1].config.id
end

---根据筛选信息显示角色列表
---@param FiltrateData DockSaveData @筛选数据
function DockRolePanel:SetFiltrate(FiltrateData)
    local starLookup, starAcceptAll
    local rankLookup, rankAcceptAll
    local typeLookup, typeAcceptAll
    if FiltrateData ~= nil then
        starLookup, starAcceptAll = buildFiltrateLookup(FiltrateData.StarList)
        rankLookup, rankAcceptAll = buildFiltrateLookup(FiltrateData.RankList)
        typeLookup, typeAcceptAll = buildFiltrateLookup(FiltrateData.TypeList)
    end

    -- 获取角色列表
    local roleList = ClientData:GetRoleList()
    if self.uiMode == self.uiModeType.hankBook or self.uiMode == self.uiModeType.character then
        local heroConfigList = Config.GetAllConfig("CharacterTable")
        roleList = {}
        for _, heroConfig in pairs(heroConfigList) do
            local heroData = Me:getPlayerHero(heroConfig.id)
            local temp = {
                id = heroConfig.id,
                level = 1, --默认等级
                star = heroConfig.baseStar, --默认星级
                getTime = 0, --获取时间
                equipSkin = heroConfig.baseSkinID, --装备皮肤
                EquippedSkillList = {heroConfig.baseSkill[1],0,0}, --装备技能列表
            }

            if heroData then
                temp.getTime = heroData.getTime or 0
            end
            if heroConfig.isOpen == 1 then
                table.insert(roleList, temp)
            end
        end
    end

    --LuaLogger.ds("roleList", tablex.dump(roleList))

    self.RoleList = {}
    for _,v in pairs(roleList) do
        ---@class DockRoleInfo                  @角色信息
        ---@field server RoleInfo               @服务器数据
        ---@field config CharacterTableTable    @配置数据
        local data = {
            server = v,
            config = Config.GetCharacterInfo(v.id)
        }

        if FiltrateData ~= nil then
            if matchFiltrateLookup(starLookup, starAcceptAll, data.server.star) and
                matchFiltrateLookup(rankLookup, rankAcceptAll, data.config.rank) and
                matchFiltrateLookup(typeLookup, typeAcceptAll, data.config.attribute) then
                table.insert(self.RoleList, data)
            end
        else
            table.insert(self.RoleList, data)
        end
    end
    self:SetSortView()
    self:RebuildRoleListDerivedCaches()
end

--设置排序
function DockRolePanel:SetSortView()
    local cacheKey = string.format("%s_%s_%s", tostring(self.nowSortIndex), tostring(self.nowSortFace), tostring(self.nowNatureMode))
    local comparisonFunction = self._sortCompareCacheFunc
    if self._sortCompareCacheKey ~= cacheKey then
        comparisonFunction = self:BuildSortComparisonFunction()
        self._sortCompareCacheKey = cacheKey
        self._sortCompareCacheFunc = comparisonFunction
    end
    if comparisonFunction then
        table.sort(self.RoleList, comparisonFunction)
    end
end

---按当前排序模式构建比较函数（仅模式变化时重建）
function DockRolePanel:BuildSortComparisonFunction()
    local ascending = self.nowSortFace == 1
    local function compareValues(aValue, bValue)
        if ascending then
            return aValue > bValue
        else
            return aValue < bValue
        end
    end

    local function multiCompare(a, b, keys)
        for _, key in ipairs(keys) do
            local aValue, bValue
            if key[1] == "server" then
                aValue = a.server[key[2]]
                bValue = b.server[key[2]]
            elseif key[1] == "config" then
                aValue = a.config[key[2]]
                bValue = b.config[key[2]]
            end
            if aValue ~= bValue then
                return compareValues(aValue, bValue)
            end
        end
        return false
    end

    if self.nowSortIndex == GE.RoleSortType.default or self.nowSortIndex == GE.RoleSortType.level then
        return function(a, b)
            return multiCompare(a, b, {
                {"server", "level"},
                {"config", "rank"},
                {"server", "star"},
                {"config", "id"},
            })
        end
    elseif self.nowSortIndex == GE.RoleSortType.star then
        return function(a, b)
            return multiCompare(a, b, {
                {"server", "star"},
                {"server", "level"},
                {"config", "rank"},
                {"config", "id"},
            })
        end
    elseif self.nowSortIndex == GE.RoleSortType.quality then
        return function(a, b)
            return multiCompare(a, b, {
                {"config", "rank"},
                {"server", "level"},
                {"server", "star"},
                {"config", "id"},
            })
        end
    elseif self.nowSortIndex == GE.RoleSortType.getTime then
        return function(a, b)
            return multiCompare(a, b, {
                {"server", "getTime"},
                {"server", "level"},
                {"config", "rank"},
                {"server", "star"},
                {"config", "id"},
            })
        end
    elseif self.nowSortIndex == GE.RoleSortType.allDmg then
        return function(a, b)
            return multiCompare(a, b, {
                {"server", "allDmg"},
                {"server", "level"},
                {"config", "rank"},
                {"server", "star"},
                {"config", "id"},
            })
        end
    elseif self.nowSortIndex == GE.RoleSortType.nature then
        local attribute = GE.NatureTypeName[self.nowNatureMode]
        return function(a, b)
            return multiCompare(a, b, {
                {"server", attribute},
                {"server", "level"},
                {"config", "rank"},
                {"server", "star"},
                {"config", "id"},
            })
        end
    elseif self.nowSortIndex == GE.RoleSortType.favorability then
        return function(a, b)
            return multiCompare(a, b, {
                {"server", "affectionLevel"},
                {"server", "level"},
                {"config", "rank"},
                {"server", "star"},
                {"config", "id"},
            })
        end
    end
    return nil
end

---@param FiltrateData? DockSaveData     筛选数据
---@param isSort? boolean                是否是排序后的数据
---@param likeData? DockSaveData         喜爱筛选数据
---@param noEffect? boolean              不播放动画效果
function DockRolePanel:SetView(FiltrateData, isSort, likeData, noEffect)
    --羁绊界面不显示阵营
    self.campImg:SetActive(self.nowMode ~= 3)
    self.filtrateData = FiltrateData

    if likeData then
        self:SetFiltrate(likeData)
    else
        self:SetFiltrate(self.filtrateData)
    end

    local roleList = self.RoleList
    local newCount = #roleList
    local loopGridView = self.roleList.loopGridView

    local selectRoleId = self:ResolveSelectRoleId(isSort, roleList)
    if selectRoleId then
        self:ApplySelectRoleEntry(selectRoleId)
    end

    self:SyncRoleListGrid(newCount, true)

    for i = 0, newCount - 1 do
        local item = loopGridView:GetShownItemByItemIndex(i)
        if item ~= nil then
            local btnTrs = item.transform:Find("Btn")
            ---@type UnityEngine.CanvasGroup
            local canvasGroup = btnTrs:GetComponent(TypeInfo.CanvasGroup)
            if not noEffect then
                btnTrs.anchoredPosition = Vector2.New(0, -20)
                canvasGroup.alpha = 0
                btnTrs:DOKill()
                canvasGroup:DOKill()
                btnTrs:DOAnchorPosY(0, 0.2):SetDelay(i * 0.02)
                canvasGroup:DOFade(1, 0.2):SetDelay(i * 0.02)
            else
                btnTrs:DOKill()
                canvasGroup:DOKill()
                canvasGroup.alpha = 1
                btnTrs.anchoredPosition = Vector2.New(0, 0)
            end
        end
    end

    if selectRoleId then
        self:SelectRoleBox(selectRoleId, isSort, nil, true)
    else
        self:updateLeftPoint(self.nowSelectRoleID)
    end

    -- LoopGridView 可能在下一帧才补全边缘格子，延迟再同步一次选中态
    if newCount > 0 then
        self:RefreshRoleListSelectionState()
        DLuaTimer:DoAfter(0, function()
            if self.roleList and self.roleList.loopGridView then
                self:RefreshRoleListSelectionState()
            end
        end)
    end

    isSort = false
end

---LoopGridView 角色格子回调
function DockRolePanel:OnRoleItemValueChange(gridView, index, row, col)
    local loopItem = gridView:GetShownItemByItemIndex(index)
    if loopItem == nil then
        loopItem = gridView:NewListViewItem("RoleBox")
    end
    local obj = loopItem.gameObject
    EngineUtil.FillPeer(self.roleBox, obj)
    local roleBox = obj
    local dataIndex = index + 1  -- LoopGridView index 从0开始，转为1-based
    local roleData = self.RoleList[dataIndex]
    if not roleData then return loopItem end

    local roleId    = roleData.config.id
    local server    = roleData.server
    local equipSkin = server.equipSkin

    -- 贴图脏检查：roleId 或皮肤变化才重新 LoadSpriteAsync
    local cache = roleBox._dockCache
    if not cache then
        cache = {}
        roleBox._dockCache = cache
    end
    -- 始终更新缓存中的 roleId，供复用点击回调读取
    cache.roleId = roleId

    if cache.skin ~= equipSkin or cache.boundRoleId ~= roleId or cache.star ~= server.star then
        cache.boundRoleId = roleId
        cache.skin = equipSkin
        cache.star = server.star

        local skinConfig = Config.GetCharacterSkinInfo(equipSkin)
        local resourceFolder = skinConfig.resourceFolder
        if is_numeric(resourceFolder) then
            resourceFolder = tostring(math.floor(tonumber(resourceFolder)))
        end

        self:LoadSpriteAsync(string.format(Config.SpritePath.roleRankFarmeBg, roleData.config.rank), roleBox.rangeFarme.image)
        roleBox.starImg:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.StarLevelImg, server.star), roleBox.starImg.image)
        roleBox.typeIcon:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.RoleTypeIconPath, roleData.config.attribute), roleBox.typeIcon.image)
        local cutRolePath = string.format(Config.SpritePath.CutRolePath, resourceFolder, skinConfig.halfimgKey)
        roleBox.roleImg:SetActive(true)
        self:LoadSpriteAsync(cutRolePath, roleBox.roleImg.image)
    end

    roleBox.redPoint:SetActive(false)
    local roleListRedMap = self._roleListRedMap
    if self.uiMode == self.uiModeType.normal and roleListRedMap and roleListRedMap[roleId] then
        roleBox.redPoint:SetActive(true)
    end

    roleBox.transform.localScale = Vector3.New(0.8, 0.8, 1)
    roleBox:SetActive(true)
    roleBox.levelTxt.text.text = server.level

    --测试版本处理，未来具体显示需要问策划
    local typeOffset = self.uiMode ~= self.uiModeType.normal and 32 or 1
    local typeNewPos = Vector2.New(roleBox.typeBg.rectTransform.anchoredPosition.x, typeOffset)
    roleBox.typeBg.rectTransform.anchoredPosition = typeNewPos
    roleBox.nameBg:SetActive(self.uiMode ~= self.uiModeType.normal)
    if server.name ~= nil and server.name ~= "" then
        roleBox.nameTxt.text.text = server.name
    else
        roleBox.nameTxt.text.text = roleData.config.name
    end

    roleBox.isSelect:SetActive(self.nowSelectRoleID == roleId)
    roleBox.groundBg:SetActive(self.uiMode == self.uiModeType.normal)
    roleBox.isLock:SetActive(server.getTime == 0)

    -- 点击回调只绑定一次，点击时从 cache.roleId 读取当前角色，避免滚动复用时反复创建闭包
    if not cache.clickBound then
        cache.clickBound = true
        roleBox.btn.scaleButton.onClick:RemoveAllListeners()
        roleBox.btn.scaleButton.onClick:AddListener(function()
            local clickCache = roleBox._dockCache
            local clickRoleId = clickCache and clickCache.roleId
            if not clickRoleId then
                return
            end
            self:play2DSound(self.btnSoundPath)
            self:SelectRoleBox(clickRoleId)
        end)
    end
    return loopItem
end

--选中某个角色格子
---@param skipListRefresh? boolean  SetView 路径已刷新列表，跳过列表 UI 更新
function DockRolePanel:SelectRoleBox(roleId, isSort, isDrag, skipListRefresh)
    self.nowSelectGiftId = nil
    self.nowSelectGiftIndex = nil
    self.detailEffect:SetActive(false)
    if self.nowSelectRoleID == roleId and not isSort and not skipListRefresh then
        -- 重复点击同一角色：仅刷新左侧红点，不走完整 SetMsgView
        self:updateLeftPoint(roleId)
        return
    end

    if not self:ApplySelectRoleEntry(roleId) then
        return
    end

    -- 刷新所有可见格选中态；仅改两项会留下对象池复用格的脏 isSelect
    if not skipListRefresh then
        self:RefreshRoleListSelectionState()
    end
    -- 只有在需要刷新角色时才重新加载spine，但点击选择（isSort 为 nil）也应生效
    -- 保持不在拖拽中加载spine以免干扰滑动切换
    if not isDrag and (isSort ~= false) then
        local skinConfig = self.nowSelectRoleData.skinConfig
        if skinConfig then
            self:initShowSpine(self.nowRoleBox, skinConfig, "nowShowSpineObj")
        end
    end
    -- SetMsgView 内部会 updateLeftPoint，此处不再重复调用
    self:SetMsgView(self.nowSelectRoleData, isSort)   --显示角色信息
    self.affectionView.scrollRect.verticalNormalizedPosition = 1
    self:stopNowAudio()

    if self.roleConfig.isSpecial == 1 and self.nowMode == 3 then
        self:SelectMode(2)
    end
    self:changeUiModeView()
end

--判断是否需要滑动检测
function DockRolePanel:CheckNeedDrag()
    self.checkDrag = #self.RoleList > 0
    if not self.dragRect then
        self.dragRect = self.drag.rectTransform
    end
    self.inRecover = false
    self:RefreshNeedDragUpdate()
end

---同步 needDragUpdate：仅在有列表且未锁定滑动时每帧检测
function DockRolePanel:RefreshNeedDragUpdate()
    self.needDragUpdate = self.checkDrag and not self.isLockDrag
end

function DockRolePanel:CheckDragMove()
    if self.isLockDrag then
        return
    end
    if self.inRecover then
        if math.abs(self.dragRect.anchoredPosition.x) < 40 then
            self.inRecover = false
        end
        return
    end

    if self.showEndAnimTimer or self.moveTweener1 or self.moveTweener2 then
        return
    end

    local function updateRoleIndex(offset)
        local newIndex = self.RoleIndex + offset
        if newIndex > #self.RoleList then
            newIndex = 1
        elseif newIndex < 1 then
            newIndex = #self.RoleList
        end
        
        -- 档案模式下跳过 R 卡
        if self.nowMode == 4 or self.nowMode == 3 then
            local startIndex = newIndex
            local attempts = 0
            while attempts < #self.RoleList do
                local roleConfig = self.RoleList[newIndex].config
                if roleConfig.isSpecial ~= 1 then
                    break
                end
                -- 继续按方向查找下一个
                newIndex = newIndex + offset
                if newIndex > #self.RoleList then
                    newIndex = 1
                elseif newIndex < 1 then
                    newIndex = #self.RoleList
                end
                attempts = attempts + 1
            end
        end
        
        local serverData = self.RoleList[newIndex].server
        local skinConfig = Config.GetCharacterSkinInfo(serverData.equipSkin)
        self:initShowSpine(self.nextRoleBox, skinConfig, "nextShowSpineObj")
        self.nextRoleBox.canvasGroup.alpha = 0
    end
    local function setRoleIndex(offset)
        local newIndex = self.RoleIndex + offset
        if newIndex > #self.RoleList then
            newIndex = 1
        elseif newIndex < 1 then
            newIndex = #self.RoleList
        end
        
        -- 档案模式下跳过 R 卡
        if self.nowMode == 4 then
            local startIndex = newIndex
            local attempts = 0
            while attempts < #self.RoleList do
                local roleConfig = self.RoleList[newIndex].config
                if roleConfig.isSpecial ~= 1 then
                    break
                end
                -- 继续按方向查找下一个
                newIndex = newIndex + offset
                if newIndex > #self.RoleList then
                    newIndex = 1
                elseif newIndex < 1 then
                    newIndex = #self.RoleList
                end
                attempts = attempts + 1
            end
        end
        
        self.RoleIndex = newIndex
        self:SelectRoleBox(self.RoleList[self.RoleIndex].config.id, false, true)
        self.inRecover = true
        self:refreshFileModeToggleRedPoint(self.filesModeType)
        self.dragMoveWidth = 0
    end

    local function changeNowSpineData()
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
            GameObject.Destroy(self.nowShowSpineObj)
        end

        local temp = self.nowRoleBox
        self.nowRoleBox = self.nextRoleBox
        self.nextRoleBox = temp
        local tempSpine = self.nowShowSpineObj
        self.nowShowSpineObj = self.nextShowSpineObj
        self.nextShowSpineObj = tempSpine

        --检测spine正确性
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
            local skinConfig = self.nowSelectRoleData.skinConfig
            if not string.find(self.nowShowSpineObj.name, skinConfig.spineKey) then
                self:initShowSpine(self.nowRoleBox, skinConfig, "nowShowSpineObj")
            end
        end
    end

    local function playFinishAnim()
        if self.needAnim then
            if self.showEndAnimTimer then
                DLuaTimer:RemoveTimer(self.showEndAnimTimer)
                self.showEndAnimTimer = nil
            end
            self.showEndAnimTimer = DLuaTimer:DoRepeatForever(0.01, function()
                local aniStateInfo = self.animator:GetCurrentAnimatorStateInfo(0)
                if aniStateInfo.normalizedTime >= 1 then
                    self.animator:SetTrigger("Init")
                    DLuaTimer:RemoveTimer(self.showEndAnimTimer)
                    self.showEndAnimTimer = nil
                    self.needAnim = false
                end
            end)
        end
        --关闭RenderTexture
        if UICommonUtils.Checkobj(self.nowShowSpineObj) then
            local myRT = self.nowShowSpineObj:GetComponent("SkeletonGraphicRenderTexture_Custom")
            myRT.enabled = false
        end
        if UICommonUtils.Checkobj(self.nextShowSpineObj) then
            local myRT = self.nextShowSpineObj:GetComponent("SkeletonGraphicRenderTexture_Custom")
            myRT.enabled = false
        end
    end

    if Input.GetMouseButtonDown(0) then
        if self.needAnim then
            return
        end
        self.clickPos = self.dragRect.anchoredPosition
        self.clickTime = os.clock()
    end
    if Input.GetMouseButton(0) then
        if math.abs((self.dragRect.anchoredPosition.x - self.clickPos.x)) > 2 and not self.needAnim then
            -- self.affectionUpEf:SetActive(false)
            self.animator.enabled = true
            self.animator:SetTrigger("Out")
            self.needAnim = true
            if (self.dragRect.anchoredPosition.x - self.clickPos.x) > 2 then
                updateRoleIndex(-1)
                self.needScreenWidth = -Screen.width
            end
            if (self.dragRect.anchoredPosition.x - self.clickPos.x) < -2 then
                updateRoleIndex(1)
                self.needScreenWidth = Screen.width
            end
            --开启RenderTexture
            if UICommonUtils.Checkobj(self.nowShowSpineObj) then
                local myRT = self.nowShowSpineObj:GetComponent("SkeletonGraphicRenderTexture_Custom")
                myRT.enabled = true
            end
        end
        if self.needAnim then
            local rate = Screen.width / 1200 * 5
            local needPos = self.dragRect.anchoredPosition.x - self.clickPos.x
            self.dragMoveWidth = rate * needPos
            if self.dragMoveWidth > Screen.width or self.dragMoveWidth < -Screen.width then
                return
            end
            self.nowRoleBox.canvasGroup.alpha = 1 - math.abs(self.dragMoveWidth) / Screen.width
            self.nextRoleBox.canvasGroup.alpha = math.abs(self.dragMoveWidth) / Screen.width
            self.nowRoleBox.rectTransform.anchoredPosition = Vector2.New(self.dragMoveWidth, 0)
            self.nextRoleBox.rectTransform.anchoredPosition = self.nowRoleBox.rectTransform.anchoredPosition + Vector2.New(self.needScreenWidth, 0)
        end
    end
    if Input.GetMouseButtonUp(0) then
        if ((self.dragRect.anchoredPosition.x - self.clickPos.x) > 2 and (os.clock() - self.clickTime) < 1) or (self.dragMoveWidth > 1200) then--右滑
            self.moveTweener1 = self.nowRoleBox.rectTransform:DOAnchorPos(Vector2.New(Screen.width, 0), 0.2):OnComplete(function()
                self.moveTweener1 = nil
            end)
            self.moveTweener2 = self.nextRoleBox.rectTransform:DOAnchorPos(Vector2.New(0, 0), 0.2):OnComplete(function()
                setRoleIndex(-1)
                changeNowSpineData()
                playFinishAnim()
                self.moveTweener2 = nil
            end)
            self.nowRoleBox.canvasGroup.alpha = 0
            self.nextRoleBox.canvasGroup.alpha = 1
            return
        end
        if ((self.dragRect.anchoredPosition.x - self.clickPos.x) < -2 and (os.clock() - self.clickTime) < 1) or (self.dragMoveWidth < -1200) then--左滑
            self.moveTweener1 = self.nowRoleBox.rectTransform:DOAnchorPos(Vector2.New(-Screen.width, 0), 0.2):OnComplete(function()
                self.moveTweener1 = nil
            end)
            self.moveTweener2 = self.nextRoleBox.rectTransform:DOAnchorPos(Vector2.New(0, 0), 0.2):OnComplete(function()
                setRoleIndex(1)
                changeNowSpineData()
                playFinishAnim()
                self.moveTweener2 = nil
            end)
            self.nowRoleBox.canvasGroup.alpha = 0
            self.nextRoleBox.canvasGroup.alpha = 1
            return
        end
        --如果没有滑动超过20像素，则回到原位
        self.nowRoleBox.rectTransform:DOAnchorPos(Vector2.New(0, 0), 0.1)
        self.nextRoleBox.rectTransform:DOAnchorPos(Vector2.New(self.needScreenWidth, 0), 0.1)
        self.dragMoveWidth = 0
        self.nowRoleBox.canvasGroup.alpha = 1
        self.nextRoleBox.canvasGroup.alpha = 0
        if UICommonUtils.Checkobj(self.nextShowSpineObj) then
            GameObject.Destroy(self.nextShowSpineObj)
        end
        playFinishAnim()
        -- self.affectionUpEf:SetActive(true)
    end
end

function DockRolePanel:Update()
    if not self.needDragUpdate then
        return
    end
    self:CheckDragMove()
end

--初始化排序按钮列表
function DockRolePanel:SortInfo()
    self.sortBtnlist = {}
    if self.nowSortMode == GE.RoleSortType.nature and self.nowNatureMode ~= nil then
        self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
    else
        self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
    end
    self:FillTemplateContent(self.sortTypeBtn, self.sortSelectList, tablex.size(GE.RoleSortTypeName), function(index, sortTypeBtn)
        local temp = {
            obj = sortTypeBtn,
            key = index,
        }
        table.insert(self.sortBtnlist, temp)
        sortTypeBtn.sortTypeTxtOff.text.text =  LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[index]]]
        sortTypeBtn.sortTypeTxt.text.text =  LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[index]]]
        sortTypeBtn.isEx:SetActive(GE.RoleSortType[GE.RoleSortTypeName[index]] == GE.RoleSortType.nature)

        if GE.RoleSortType[GE.RoleSortTypeName[index]] == GE.RoleSortType.nature then
            self.natureBtnlist = {}
            self:FillTemplateContent(self.natureNameBtn, sortTypeBtn.natureList, tablex.size(GE.NatureTypeName), function(key, natureNameBtn)
                natureNameBtn.natureNameTxtOff.text.text =  LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[key]]]
                natureNameBtn.natureNameTxt.text.text =  LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[key]]]
                local t = {
                    obj = natureNameBtn,
                    key = key,
                }
                table.insert(self.natureBtnlist, t)
                natureNameBtn.scaleButton.onClick:RemoveAllListeners()
                natureNameBtn.scaleButton.onClick:AddListener(function()
                    self:play2DSound(self.btnSoundPath)
                    self.nowNatureMode = key
                    self.sortSelectList:SetActive(false)
                    self.sortMask:SetActive(false)
                    self.sortTxt.text.text = LocalStrEnum["NatureType_"..GE.NatureType[GE.NatureTypeName[self.nowNatureMode]]]
                    for _, v in pairs(self.natureBtnlist) do
                        v.obj.isOpen:SetActive(self.nowNatureMode == v.key)
                    end
                    self:SetView(self.filtrateData, true)
                end)
            end)
        end
        sortTypeBtn.scaleButton.onClick:RemoveAllListeners()
        sortTypeBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.lastSortIndex = self.nowSortIndex
            self.nowSortIndex = index
            if GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]] == GE.RoleSortType.nature then
                self.nowSortMode = GE.RoleSortType.nature
            else
                self.nowNatureMode = nil
                self.nowSortMode = GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]]
                self.sortTxt.text.text = LocalStrEnum["RoleSortType_"..GE.RoleSortType[GE.RoleSortTypeName[self.nowSortMode]]]
                self.sortSelectList:SetActive(false)
                self.sortMask:SetActive(false)
                self:SetView(self.filtrateData, true)
            end
            self:refreshSortView()
            for _, v in pairs(self.natureBtnlist) do
                v.obj.isOpen:SetActive(self.nowNatureMode == v.key)
            end
        end)
    end)
end

function DockRolePanel:refreshSortView()
    for k,v in pairs(self.sortBtnlist) do
        v.obj.isOpen:SetActive(self.nowSortIndex == v.key)
        if GE.RoleSortType[GE.RoleSortTypeName[self.nowSortIndex]] == GE.RoleSortType.nature and self.nowSortIndex == v.key then
            v.obj.natureList:SetActive(not v.obj.natureList.activeSelf)
        else
            v.obj.natureList:SetActive(false)
        end
    end
end

--更换界面模式
--modeIndex 1 选择角色 2 角色详情
--refresh 是否强制刷新
--needRefreshRole 是否需要刷新角色（重新选择角色格子，会播放入场动画）
function DockRolePanel:SelectMode(modeIndex, refresh, needRefreshRole)
    if self.nowMode == modeIndex and not refresh then
        return
    end
    self.nowMode = modeIndex
    local isAni
    if self.nowMode == 3 then
        isAni = self:CheckAniForAffection()
    end
    if isAni and self.roleConfig.isSpecial ~= 1 then
        self:DoAniForAffection()
    end
    self:stopNowAudio()
    -- 这里改动画接管
    --检测是否需要播放入场动画
    -- local isAni
    -- if self.nowMode == 3 then
    --     isAni = self:CheckAniForAffection()
    -- end
    -- self.affectionMode.animation.enabled = not isAni
    -- if isAni then
    --     self.affectionMode.canvasGroup.alpha = 1
    -- end
    self.roleMode:SetActive(self.nowMode == 1)
    self.msgMode:SetActive(self.nowMode == 2)
    self.affectionMode:SetActive(self.nowMode == 3)
    -- if isAni then
    --     self:DoAniForAffection()
    -- end
    -- self.affectionBg:SetActive(self.nowMode == 3)
    if self.nowMode == 3 then
        self.affectionBg.canvasGroup.alpha = 0
        self.affectionBg.canvasGroup:DOFade(1, 0.2)
    else
        self.affectionBg.canvasGroup:DOFade(0, 0.2)
    end
    self.filesMode:SetActive(self.nowMode == 4)

    self.isLockDrag = self.nowMode == 1 or self.uiMode == self.uiModeType.character
    self:RefreshNeedDragUpdate()
    self.msgBtn.isSelect.canvasGroup.alpha = self.nowMode == 2 and 1 or 0
    self.affectionlBtn.isSelect.canvasGroup.alpha = self.nowMode == 3 and 1 or 0
    self.filesBtn.isSelect.canvasGroup.alpha = self.nowMode == 4 and 1 or 0
    self:__RefreshNavigation()
    
    -- 切换回角色列表模式时，若有因升级/升星等操作积累的待刷新标记，则执行完整排序刷新
    if self.nowMode == 1 and self.pendingSortRefresh then
        self.pendingSortRefresh = false
        self:SetView(self.filtrateData, true)
        return
    end
    -- 根据参数决定是否刷新角色
    -- 页签切换时默认不刷新角色，只有显式传入true时才刷新
    if needRefreshRole then
        self:Refresh()
    else
        self:RefreshWithoutRole()
    end
end

--设置信息显示
---@param roleData any          角色数据
---@param isSort boolean        是否是排序后的数据
function DockRolePanel:SetMsgView(roleData, isSort)
    self.roleConfig = roleData.roleData.config
    self.roleSeverData = Me:getPlayerHero(self.roleConfig.id)
    
    self.levelUpBtn.redPoint:SetActive(RedPointMgr:RoleCanLvUp(self.roleConfig.id))
    self.starUpBtn.redPoint:SetActive(RedPointMgr:RoleCanStarUp(self.roleConfig.id))
    self.skillTreeBtn.redPoint:SetActive(self.uiMode == self.uiModeType.normal and
    RedPointMgr:RoleTalentTreeCanUp(self.roleConfig.id))
    -- 同步刷新左侧页签红点，避免升级/升星后 MsgBtn 状态滞后
    self:updateLeftPoint(self.roleConfig.id)
    if self.uiMode == self.uiModeType.hankBook or self.uiMode == self.uiModeType.character then
        self.roleSeverData = {
            id = self.roleConfig.id,
            level = 1,
            hp = math.floor((self.roleConfig.hp + self.roleConfig.hpAddition * 0) * (self.roleConfig.hpStar[self.roleConfig.baseStar])),
            armor = math.floor((self.roleConfig.armor + self.roleConfig.armAddition * 0) * (self.roleConfig.armStar[self.roleConfig.baseStar])),
            bombard = math.floor((self.roleConfig.bombard + self.roleConfig.bomAddition * 0) * (self.roleConfig.bomStar[self.roleConfig.baseStar])),
            torpedo = math.floor((self.roleConfig.torpedo + self.roleConfig.torAddition * 0) * (self.roleConfig.torStar[self.roleConfig.baseStar])),
            evade = math.floor((self.roleConfig.evade + self.roleConfig.evaAddition * 0) * (self.roleConfig.evaStar[self.roleConfig.baseStar])),
            airdefense = math.floor((self.roleConfig.airdefense + self.roleConfig.adfAddition * 0) * (self.roleConfig.adfStar[self.roleConfig.baseStar])),
            lucky = math.floor((self.roleConfig.lucky + self.roleConfig.lukAddition * 0) * (self.roleConfig.lukStar[self.roleConfig.baseStar])),
            carryWeapon = {0,0},
            star = self.roleConfig.baseStar,
        }
        local hpPoint = self.roleSeverData.hp * self.roleConfig.hpScore
        local armorPoint = self.roleSeverData.armor * self.roleConfig.armorScore
        local evadePoint = self.roleSeverData.evade * self.roleConfig.evadeScore
        local bombardPoint = self.roleSeverData.bombard * self.roleConfig.bombardScore
        local torpedoPoint = self.roleSeverData.torpedo * self.roleConfig.torpedoScore
        local luckyPoint = self.roleSeverData.lucky * self.roleConfig.luckyScore
        local airdefensePoint = self.roleSeverData.airdefense * self.roleConfig.airdefenseScore

        local totalPoints = (hpPoint + armorPoint + evadePoint + bombardPoint + torpedoPoint + luckyPoint + airdefensePoint) * self.roleConfig.baseDamageRate
        local twoThirdsPower = math.pow(totalPoints, 2 / 3)
        --作战能力值
        self.roleSeverData.allDmg = math.floor(twoThirdsPower)
        self.heroStoryTxt.text.text = self.roleConfig.characterDesc
    end

    if self.roleSeverData.name ~= nil and self.roleSeverData.name ~= "" then
        self.nameTxt.text.text = self.roleSeverData.name
        self.nameShadowTxt.text.text = self.roleSeverData.name
    else
        self.nameTxt.text.text = self.roleConfig.name
        self.nameShadowTxt.text.text = self.roleConfig.name
    end

    self.classTxt.text.text = self.roleConfig.class
    self.levelValue.text.text = self.roleSeverData.level
    self.isMax:SetActive(self.maxLevel == self.roleSeverData.level)
    self.levelUpBtn:SetActive(self.maxLevel ~= self.roleSeverData.level and self.uiMode == self.uiModeType.normal)
    self.levelMax.text.text = Me:getUserLevel()
    self.typeName.text.text = self.roleConfig.typeName
    --属性显示
    self.hpTxt.text.text = self.roleSeverData.hp                         --耐久
    self.bombardTxt.text.text = self.roleSeverData.bombard               --炮击
    self.torpedoTxt.text.text = self.roleSeverData.torpedo               --雷击
    self.armorTxt.text.text = self.roleSeverData.armor                   --装甲
    self.evadeTxt.text.text = self.roleSeverData.evade                   --机动
    self.airdefenseTxt.text.text = self.roleSeverData.airdefense         --防空
    self.luckyTxt.text.text = self.roleSeverData.lucky                   --幸运
    self.battlePointTxt.text.text = self.roleSeverData.allDmg
    --品质显示
    local qualityIcon = string.format(Config.SpritePath.roleQualityIcon, self.roleConfig.rank)
    self.rankImg:SetActive(true)
    self:LoadSpriteAsync(qualityIcon, self.rankImg.image)
    --角色头像
    local RoleTypeIconPath = string.format(Config.SpritePath.RoleTypeIconPath, self.roleConfig.attribute)
    self.typeImg:SetActive(true)
    self:LoadSpriteAsync(RoleTypeIconPath, self.typeImg.image)

    --阵营显示
    local CharacterNationPath = string.format(Config.SpritePath.CharacterNationPath, self.roleConfig.nation)
    self:LoadSpriteAsync(CharacterNationPath, self.campImg.image)

    local weaponLock = Me:getWeaponLockStateById(self.roleSeverData.id)
    for i = 1, 2 do
        self["weaponBox_"..i].redPoint:SetActive(RedPointMgr:RoleWeaponSlotRedJudge(self.roleSeverData.id, i))
        self["weaponBox_"..i].btn.scaleButton.onClick:RemoveAllListeners()
        self["weaponBox_"..i].btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            --TODO: 锁定态判断
            if i == 2 and not weaponLock then
                return
            end
            self.skillMsgPanel.skillMsgPanel:closeSkillMask()
            UIMgr:popUI("EquipPanel", {part = i, roleData = self.roleSeverData, mode = 1})
        end)

        if self.roleSeverData.carryWeapon then
            if self.roleSeverData.carryWeapon[i] ~= 0 then
                local WeaponData = Me:getWeaponDataById(self.roleSeverData.carryWeapon[i])
                local WeaponConfig = Config.GetWeaponInfo(WeaponData.cid)
                if WeaponData then
                    self["weaponBox_"..i].weaponName.text.text = WeaponConfig.name
                end
                self["weaponBox_"..i].equipIcon:SetActive(true)
                self:LoadSpriteAsync(string.format(Config.SpritePath.WeaponIconPath, WeaponConfig.icon), self["weaponBox_"..i].equipIcon.image)
                self:LoadSpriteAsync(string.format(Config.SpritePath.EquipShowRankBg, WeaponConfig.rare), self["weaponBox_"..i].showBg.image)
                self["weaponBox_"..i].isOn:SetActive(true)
                self["weaponBox_"..i].bg:SetActive(false)
            else
                self["weaponBox_"..i].equipIcon:SetActive(false)
                self["weaponBox_"..i].isOn:SetActive(false)
                self["weaponBox_"..i].bg:SetActive(true)
            end
        end
    end
    
    self.weaponBox_2.isLock:SetActive(not weaponLock)            -- 这里要接技能树数据

    for i = 1, 4 do
        self["equipBox_"..i].redPoint:SetActive(RedPointMgr:RoleEquipSlotRedJudge(self.roleSeverData.id, i))
        self["equipBox_"..i].isLock:SetActive(false)
        self["equipBox_"..i].equipBtn.scaleButton.onClick:RemoveAllListeners()
        self["equipBox_"..i].equipBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self.skillMsgPanel.skillMsgPanel:closeSkillMask()
            UIMgr:popUI("EquipPanel", {part = i, roleData = self.roleSeverData, mode = 2})
        end)

        if self.roleSeverData.carryEquip then
            if self.roleSeverData.carryEquip[i] ~= 0 then
                local equipData = Me:getEquipDataByid(self.roleSeverData.carryEquip[i])
                local equipConfig = Config.GetEquipmentInfo(equipData.cid)
                if equipData then
                    for j = 1, 5 do
                        if j <= equipData.star then
                            self["equipBox_"..i]["star_"..j]:SetActive(true)
                        else 
                            self["equipBox_"..i]["star_"..j]:SetActive(false)
                        end
                    end
                    self["equipBox_"..i].itemNum.text.text = "Lv."..equipData.level
                end
                self:LoadSpriteAsync(string.format(Config.SpritePath.EquipIconPath, equipConfig.icon), self["equipBox_"..i].itemIcon.image)
                self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme, equipConfig.quality), self["equipBox_"..i].rankBg.image)
                self:LoadSpriteAsync(string.format(Config.SpritePath.ItemRankFarme2, equipConfig.quality), self["equipBox_"..i].rangeImg.image)
                self["equipBox_"..i].nullDataPanel:SetActive(false)
                self["equipBox_"..i].hasDataPanel:SetActive(true)
                self["equipBox_"..i].itemIcon:SetActive(true)
            else
                self["equipBox_"..i].itemIcon:SetActive(false)
                self["equipBox_"..i].nullDataPanel:SetActive(true)
                self["equipBox_"..i].hasDataPanel:SetActive(false)
            end
        end

        self.starIcon:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.roleLevelIcon, self.roleSeverData.star), self.starIcon.image)

    end

    self:SetSkillListView()
    self:SetWeaponView()
    local talentConfig = Config.GetSkillInfo(self.roleConfig.talentId[self.roleSeverData.star])
    self.talentBox.nullBg:SetActive(true)
    if talentConfig then
        self.talentBox.isOn:SetActive(true)
        self.talentBox.iconImg:SetActive(true)
        self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, talentConfig.icon), self.talentBox.iconImg.image)
    else
        self.talentBox.isOn:SetActive(false)
    end

    self.talentBox.btn.scaleButton.onClick:RemoveAllListeners()
    self.talentBox.btn.scaleButton.onClick:AddListener(function()
        self:play2DSound(self.btnSoundPath)
        local temp = {
            skillId = self.roleConfig.talentId[self.roleSeverData.star],
            uiMode = self.uiMode,
        }
        self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp)
    end)
    if self.uiMode ~= self.uiModeType.hankBook and self.uiMode ~= self.uiModeType.character then
        self:SetAffectionView()
        self:SetFilesView()
    end
end

--设置武器显示
function DockRolePanel:SetWeaponView()
    for i = 1, 2 do
        local weaponList = self.roleSeverData.carryWeapon
        local weaponData = Me:getWeaponDataById(weaponList[i])
        if weaponData then
            local weaponConfig = Config.GetWeaponInfo(weaponData.cid)
            if weaponConfig then
                self["weaponBox_"..i].weaponName.text.text = weaponConfig.name
            else
                self["weaponBox_"..i].weaponName.text.text = "--"
            end
        else
            self["weaponBox_"..i].weaponName.text.text = "--"
        end
    end
end

--设置技能显示
function DockRolePanel:SetSkillListView()
    local skillData = self.nowSelectRoleData.roleData.server.EquippedSkillList
    for i = 1, 3 do
        --self["skillBox_"..i].shadow:SetActive(false)
        self["skillBox_"..i].btn.scaleButton.onClick:RemoveAllListeners()
        self["skillBox_"..i].btn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            local temp = {
                roleCid = self.roleSeverData.id,
                skillId = skillData[i],
                index = i,
                uiMode = self.uiMode,
            }
            if skillData[i] ~= 0 then
                self.skillMsgPanel.skillMsgPanel:showSkillMsg(temp)
            else
                if self.uiMode == self.uiModeType.normal then
                    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
                    UIMgr:popUICover("SkillChangePanel", temp)
                end
            end
        end)
        if skillData[i] ~= 0 then
            self["skillBox_"..i].addBg:SetActive(false)
            self["skillBox_"..i].nullBg:SetActive(true)
            self["skillBox_"..i].isOn:SetActive(true)
            local skillConfig = Config.GetSkillInfo(skillData[i])
            if skillConfig then
                self["skillBox_"..i].passivity:SetActive(skillConfig.skillType == GE.SkillType.Passive)
                self["skillBox_"..i].iconImg:SetActive(true)
                self:LoadSpriteAsync(string.format(Config.SpritePath.SkillIconPath, skillConfig.icon), self["skillBox_"..i].iconImg.image)
            end
        else
            self["skillBox_"..i].addBg:SetActive(true)
            self["skillBox_"..i].nullBg:SetActive(false)
            self["skillBox_"..i].isOn:SetActive(false)
            self["skillBox_"..i].passivity:SetActive(false)
            if self.uiMode == self.uiModeType.hankBook or self.uiMode == self.uiModeType.character then
                self["skillBox_"..i].nullBg:SetActive(true)
                self["skillBox_"..i].addBg:SetActive(false)
            end

        end
    end
end

--入场动画
function DockRolePanel:DoAniForAffection()
    self.btnPatentEndPos = self.affectionbtnParent.transform.position
    local aniList = {
        -- maxBg = {
        --     target = self.maxBg,
        --     start = self.maxBgStartPos,
        --     bezierList = {self.bmaxBg.transform.position},
        --     endPos = self.maxBgEndPos,
        --     time = 1
        -- },
        -- max = {
        --     target = self.maxIcon,
        --     start = self.maxIconStartPos,
        --     bezierList = {self.bmax.transform.position},
        --     endPos = self.maxIconEndPos,
        --     time = 1.5
        -- },
        -- link = {
        --     target = self.link,
        --     start = self.linkStartPos,
        --     bezierList = {self.blink.transform.position},
        --     endPos = self.linkEndPos,
        --     time = 1.3
        -- },
        -- levelUp = {
        --     target = self.affectionLevelUpBtn,
        --     start = self.affectionLevelUpBtnStartPos,
        --     bezierList = {self.bbtn.transform.position},
        --     endPos = self.affectionLevelUpBtnEndPos,
        --     time = 1.2
        -- },
        btnParent = {
            target = self.affectionbtnParent,
            start = self.btnPatentStartPos,
            bezierList = {},
            endPos = self.btnPatentEndPos,
            time = 0.4,
            curve = "DockRoleAni1"
        }
    }
    local finishNum = 0
    local finishMax = tablex.size(aniList)
    --结束回调
    local endFunc = function()
        finishNum = finishNum + 1
        if finishNum >= finishMax then
            --全部结束
            local fadeTime = 0.5
            self.aniParent.image:DOFade(0, fadeTime):OnComplete(function()
                self.aniParent:SetActive(false)
                self.affectionbtnParent.transform:SetParent(self.affectionMode.transform, true)
                self.affectionLevelUpBtn.button.interactable = true
            end)
            self.affectionLevelUpBtn:SetActive(true)
            self.affectionLevelUpBtn.canvasGroup:DOFade(1, fadeTime)
        end
    end
    --开始动画表现
    self.aniParent:SetActive(true)
    self.aniParent.image.color = Color(0, 0, 0, 0)
    self.affectionbtnParent.transform:SetParent(self.aniParent.transform, true)
    self.affectionLevelUpBtn.button.interactable = false
    self.affectionLevelUpBtn:SetActive(false)
    self.affectionLevelUpBtn.canvasGroup.alpha = 0
    self:LoadCurveLibraryAsync(Config.AssetFile.CurveLibrary, function(lib)
        --起始位置
        for k, v in pairs(aniList) do
            v.target.transform.position = v.start
        end
        --曲线显示数字滚动
        local showTextTime = 2
        local showEffectTime = 1.3
        local showTextMax = 100
        local passTime = 0.02
        local currentTimes = 0
        local times = math.ceil(showTextTime/passTime)
        self.maxIcon:SetActive(false)
        self.aniParent.image:DOFade(177/255, 0.5):OnComplete(function()
            self.maxText.text.text = ""
            self.maxText:SetActive(true)
            local timer = self:_DoRepeat(passTime, times, function ()
                currentTimes = currentTimes + 1
                local progress = (currentTimes / times)
                --曲线
                local curve = lib:GetCurve("DockRoleAniText")
                local cueveProgress
                if curve then
                    cueveProgress = curve:Evaluate(progress)
                end 
                local realProgress = cueveProgress or progress
                self.maxText.text.text = math.floor(realProgress * showTextMax)
            end)
            --延迟播放特效
            self:_DoAfter(showTextTime, function()
                self.maxIcon:SetActive(true)
                self.maxText:SetActive(false)
                self.aniEffect:SetActive(true)
                --延迟进行位移
                self:_DoAfter(showEffectTime, function()
                    self.aniEffect:SetActive(false)
                    for k, v in pairs(aniList) do
                        --贝塞尔曲线
                        self:startBezierMove(v.start, v.bezierList, v.endPos, v.time, 
                            function(pos, progress)
                                --位置
                                v.target.transform.position = pos
                            end, 
                            function()
                                endFunc()
                            end,
                            lib:GetCurve(v.curve)
                        )
                    end
                end)
            end)
        end)
    end)
end

--入场动画检测
function DockRolePanel:CheckAniForAffection()
    local id = self.roleSeverData.id
    local watchedJsonData = ClientData:GetCustomData(GE.CustomDataKey.AffectionWatched)
    local watchedData = {}
    if watchedJsonData then
        watchedData = watchedJsonData
    end
    --未看过
    if watchedData ~= 1 then
    -- if true then
        watchedData = 1
        local newJsonData = watchedData
        --更新最新数据
        Me:RecordCustomData({
            [GE.CustomDataKey.AffectionWatched] = newJsonData
        })
        return true
    end
end

---贝赛尔曲线移动
---@param startPos Vector3	起始点
---@param bezierPoint Vector3	贝塞尔点
---@param endPos Vector3	终点
---@param totalTime number	移动时间
---@param updateFunc function	更新回调
---@param endFunc function	结束回调
function DockRolePanel:startBezierMove(startPos, bezierPointList, endPos, totalTime, updateFunc, endFunc, curve)
	if not totalTime or totalTime == 0 then
		endFunc()
		return
	end
	local passTime = 0.02
	local currentTimes = 0
	local times = math.ceil(totalTime/passTime)
	local pointList = {}
	table.insert(pointList, startPos)
	for _, v in pairs(bezierPointList) do
		table.insert(pointList, v)
	end
	table.insert(pointList, endPos)
	local timer = self:_DoRepeat(passTime, times, function ()
		currentTimes = currentTimes + 1
        local progress = (currentTimes / times)
        --曲线
        local cueveProgress
        if curve then
            cueveProgress = curve:Evaluate(progress)
        end
        local nextPos = luautil.getBezierMultiple(pointList, cueveProgress or progress)
        if updateFunc then
            updateFunc(nextPos, progress)
        end
        --到终点
        if (currentTimes == times) then
			if endFunc then
				endFunc()
			end
        end
	end)
    table.insert(self._repeatTimer, timer)
end

function DockRolePanel:_DoRepeat(interval, times, event)
	return DLuaTimer:DoRepeat(interval, times, function ()
		if event then
			event()
		end
	end)
end

function DockRolePanel:_DoAfter(time, event)
	return DLuaTimer:DoAfter(time, function()
		if event then
			event()
		end
	end)
end

-- 显示角色好感度信息
function DockRolePanel:SetAffectionView()
    --LuaLogger.ds("SetAffectionView", debug.traceback())
    self.nowSelectGiftIndex = nil
    self.nowSelectGiftId = nil
    self.nowSelectGiftCount = 0
    self.affectionExpMax = false
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    -- LuaLogger.ds("self.roleSeverData", tablex.dump(self.roleSeverData))
    local curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, self.roleSeverData.affectionLevel)
    --显示好感等级 经验 经验条
    --LuaLogger.ds("curLevelData", tablex.dump(curLevelData))
    self:setHeartFillView(self.roleSeverData.affectionLevel, self.roleSeverData.affectionExp, curLevelData.exp)
    local maxLevel = Config.GetConfigInfo("AffectionLevelGiftMax")

    if self.roleSeverData.affectionExp >= curLevelData.exp and self.roleSeverData.affectionLevel >= maxLevel then
        self.affectionExpMax = true
    end
    -- --送礼物按钮显示
    -- self.affectionGiftBtn:SetActive(self.roleSeverData.affectionExp < curLevelData.exp and self.roleSeverData.affectionLevel < maxLevel)
    -- self.affectionGiftBtn.redPoint:SetActive(RedPointMgr:RoleAffectionItemCanUp(self.roleSeverData.id))
    -- self.affectionLevelUpBtn.redPoint:SetActive(RedPointMgr:RoleAffectionCanUp(self.roleSeverData.id))
    --生成好感度阶段数量的预制体
    local levelData = Config.GetLevelconfigInfoByType(GE.LevelDataType.affection)
    --去除0级的数据
    for i = #levelData, 1, -1 do
        if levelData[i].level == 0 then
            table.remove(levelData, i)
        end
    end
    local affectionConfig = Config.GetAffectionInfo(self.roleConfig.affection)
    if not affectionConfig then
        -- LuaLogger.e("GetAffectionInfo nil, id:", self.roleConfig.affection)
        return
    end
    self.giftObjList = {}
    --加载好感度礼物，根据角色自身配置生成
    self:FillTemplateContent(self.giftBox, self.giftList, tablex.size(affectionConfig.Gift), function(index, giftBox)
        local giftId = affectionConfig.Gift[index]
        local itemConfig = Config.GetItemInfo(giftId)
        local itemData = Me:getItemById(giftId)
        local customData = {
            id = giftId,
            type = GE.RewardType.ItemProp,
            num = itemData and itemData.num or 0,
        }
        local temp = {
            obj = giftBox,
            key = index,
            giftId = giftId,
            customData = customData,
        }
        table.insert(self.giftObjList, temp)
        giftBox:SetActive(true)
        giftBox.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(index * 0.025, function()
            giftBox.canvasGroup:DOFade(1, 0.2)
        end)
        giftBox.isSelect:SetActive(self.nowSelectGiftIndex == index)
        giftBox.countBg:SetActive(self.nowSelectGiftCount > 0)
        giftBox.addValueTxtOn.text.text = "+"..itemConfig.effect[2]
        giftBox.addValueTxtOff.text.text = "+"..itemConfig.effect[2]
        if customData.num > 0 then
            giftBox.emptyState:SetActive(false)
            giftBox.giftMsgBox.customBox.countObj:SetActive(true)
        else
            giftBox.emptyState:SetActive(true)
            giftBox.giftMsgBox.customBox.countObj:SetActive(false)
        end
        giftBox.giftMsgBox.customBox:setMono(self)
        giftBox.giftMsgBox.customBox:SetUIData(customData, {disableClick = true})

        giftBox.giftMsgBox.customBox.itemNum.text.text = customData.num

        giftBox.scaleButton.onClick:RemoveAllListeners()
        giftBox.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self:selectGiftBoxByIndex(index, customData)
        end)
        giftBox.reduceBtn.scaleButton.onClick:RemoveAllListeners()
        giftBox.reduceBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self:reduceGiftByIndex(index)
        end)
        giftBox.clickLongPressListener.onLongpress = function()
            self.isLongPress = true
            self.longPressTimer = Timer.New(function()
                self:selectGiftBoxByIndex(index, customData)
            end, 0.1, -1)
            self.longPressTimer:Start()
        end
        giftBox.clickLongPressListener.onDown = function()
            self.isLongPress = false
            self.longPressTimer = Timer.New(function()
                self.isLongPress = true
                self.longPressTimer = nil
            end, 0.2, 1)
            self.longPressTimer:Start()
            self._insufficientToastIndex = nil
        end
        giftBox.clickLongPressListener.onUp = function()
            if self.longPressTimer then
                self.longPressTimer:Stop()
                self.longPressTimer = nil
            end
            self._insufficientToastIndex = nil
        end
    end)

    --特效
    self.affectionLevelData = levelData
    self.affectionBoxList = {}
    -- self.affectionUpEf:SetActive(self.roleSeverData.affectionLevel == maxLevel)     --TODO: 无需求，暂定满级是开启
    self:FillTemplateContent(self.affectionBox, self.affectionList, tablex.size(levelData), function(index, affectionBox)
        affectionBox:SetActive(true)

        --如果affectionReward、affectionSound、affectionArchive 三个表中都没有当前等级的数据，则隐藏该等级显示
        local hasData = (affectionConfig.affectionReward[index] and next(affectionConfig.affectionReward[index])) or
                        (affectionConfig.affectionSound[index] and next(affectionConfig.affectionSound[index])) or
                        (affectionConfig.affectionAVG[index] and next(affectionConfig.affectionAVG[index])) or
                        (affectionConfig.affectionArchive[index] and next(affectionConfig.affectionArchive[index]))
        affectionBox:SetActive(hasData and true or false)

        DLuaTimer:DoAfter(index * 0.025, function()
            affectionBox.canvasGroup:DOFade(1, 0.2)
        end)
        --等级显示
        affectionBox.levelTxt.text.text = levelData[index].level..LocalStrEnum.AffectionLevel
        --解锁事项显示
        local unLockTxt = ""
        if affectionConfig.affectionSound[index] and next(affectionConfig.affectionSound[index]) then
            for _, soundId in pairs(affectionConfig.affectionSound[index]) do
                local soundConfig = Config.GetAffectionSoundInfo(soundId)
                if soundConfig then
                    unLockTxt = unLockTxt .. LocalStrEnum.AffectionSoundUnlock..soundConfig.soundTitle.."\n"
                end
            end
        end

        if affectionConfig.affectionArchive[index] and next(affectionConfig.affectionArchive[index]) then
            for _, filesId in pairs(affectionConfig.affectionArchive[index]) do
                local filesConfig = Config.GetArchiveInfo(filesId)
                unLockTxt = unLockTxt .. LocalStrEnum.AffectionArchiveUnlock..filesConfig.title.."\n"
            end
        end
        if affectionConfig.affectionAVG[index] and next(affectionConfig.affectionAVG[index]) then
            for _, avgId in pairs(affectionConfig.affectionAVG[index]) do
                local archiveConfig = Config.GetArchiveInfo(avgId)
                unLockTxt = unLockTxt .. LocalStrEnum.AffectionAvgUnlock .. archiveConfig.title.."\n"
            end
        end
        local addCfg = Config.GetConfigInfo("AffectionAddFrag")
        if addCfg then
            for _, v in pairs(addCfg) do
                if index == v[1] then
                    unLockTxt = unLockTxt .. string.format(LocalStrEnum.AddFrag_Affection, v[2]).."\n"
                end
            end
        end

        affectionBox.msgTxt.text.text = unLockTxt
        --奖励显示
        local isGet = getAffectionRewardMaxLevel(self.roleSeverData.affectionRewardList) >= levelData[index].level
        local rewardData = affectionConfig.affectionReward and affectionConfig.affectionReward[index]
        if rewardData and next(rewardData) and rewardData[2] then
            local itemConfig = Config.GetItemInfo(rewardData[2])
            local customData = {
                isGet = isGet,
                disableClick = true,
                showItemName = true,
            }
            affectionBox.reward:SetActive(true)
            affectionBox.reward.customBox:setMono(self)
            affectionBox.reward.customBox:SetUIData(rewardData,customData)
        else
            -- 没有奖励时隐藏奖励区域（根据 UI 结构可替换为默认显示）
            affectionBox.reward:SetActive(false)
        end
        affectionBox.affectionIsLock:SetActive(levelData[index].level > self.roleSeverData.affectionLevel)
        affectionBox.affectionBg:SetActive(not (levelData[index].level > self.roleSeverData.affectionLevel))
        affectionBox.lockTxt.text.text =  string.format(LocalStrEnum.AffectionLevelUnlock, levelData[index].level)

        local isOpen = self.roleSeverData.affectionLevel >= levelData[index].level

        affectionBox.affectionIsOpen:SetActive(not isGet and isOpen) --TODO: 这里需要获取affectionRewardList 领取记录更改点击解锁的样式
        affectionBox.affectionIsOpen.scaleButton.onClick:RemoveAllListeners()
        affectionBox.affectionIsOpen.scaleButton.onClick:AddListener(function()
            self:clickAffectionBox(index)
        end)
        table.insert(self.affectionBoxList, affectionBox)
    end)

    self:setDetailEffectView()
end

--好感度格子点击方法
function DockRolePanel:clickAffectionBox(index)
    self:play2DSound(self.btnSoundPath)
    --TODO: 发送请求领取当前阶段好感度奖励
    Me:heroAffectionRewardReq({id = self.roleSeverData.id, level = self.affectionLevelData[index].level}, function(data)
        -- self.affectionUpEf:SetActiv(false)
        self:SetMsgView(self.nowSelectRoleData)  --刷新六维属性（好感度等级提升影响属性）
        self:SetAffectionView()
        self:SetFilesView()
        self:updateLeftPoint(self.roleSeverData.id)

        Me:ReceiveReward(data.rewardList, function()
            -- self.affectionUpEf:SetActive(true)
        end)
    end)
end

--选择好感度礼物
---@param Index integer 礼物索引
function DockRolePanel:selectGiftBoxByIndex(Index, customData)
    if self.affectionExpMax then
        --如果好感度已经满级 或礼物数量为零，则不允许选择礼物
        return
    end
    -- 以实时持有量判断，避免自选礼包兑换后闭包内数量未更新
    local itemData = Me:getItemById(customData.id)
    local haveNum = itemData and itemData.num or 0
    customData.num = haveNum
    if haveNum == 0 then
        if self._insufficientToastIndex ~= Index then
            --UICommonUtils.PopToast("道具不足")
            Me:ShowItemTips({
                id =  customData.id,
                type = GE.RewardType.ItemProp,
                navType = GE.NavigationType.TechnologyTree,
                tipsPassEventState = false,
                ownerPanelName = "DockRolePanel",
            })
            self._insufficientToastIndex = Index
        end
        return
    end
    if self.nowSelectGiftIndex == Index then
        --不能超过拥有数量
        if self.nowSelectGiftCount >= haveNum then
            return
        end
        self.nowSelectGiftCount = self.nowSelectGiftCount + 1
    else
        self.nowSelectGiftCount = 1
    end
    self.nowSelectGiftIndex = Index
    for _, v in pairs(self.giftObjList) do
        v.obj.isSelect:SetActive(self.nowSelectGiftIndex == v.key)
        v.obj.countBg:SetActive(self.nowSelectGiftIndex == v.key and self.nowSelectGiftCount > 0)
        if v.key == self.nowSelectGiftIndex then
            v.obj.countTxt.text.text = self.nowSelectGiftCount
            self.nowSelectGiftId = v.giftId
        end
    end
    self:affectionExpView()
end

--减少好感度礼物数量
---@param Index integer 礼物索引
function DockRolePanel:reduceGiftByIndex(Index)
    if self.nowSelectGiftIndex == Index then
        self.nowSelectGiftCount = self.nowSelectGiftCount - 1
    end
     for _, v in pairs(self.giftObjList) do
        if v.key == self.nowSelectGiftIndex then
            v.obj.countTxt.text.text = self.nowSelectGiftCount
            if self.nowSelectGiftCount <= 0 then
                self:affectionExpView()
                self.nowSelectGiftCount = 0
                self.nowSelectGiftIndex = nil
                self.nowSelectGiftId = nil
                v.obj.isSelect:SetActive(false)
                v.obj.countBg:SetActive(false)
            else
                self:affectionExpView()
            end
        end
    end
end

--赠送礼物信息预览
function DockRolePanel:affectionExpView()
    -- 计算好感度能够提升到几级，经验能够变成多少
    local giftConfig = Config.GetItemInfo(self.nowSelectGiftId)
    if not giftConfig then
        return
    end
    local affectionConfig = Config.GetAffectionInfo(self.roleConfig.affection)
    local curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, self.roleSeverData.affectionLevel)
    local maxLevel = Config.GetConfigInfo("AffectionLevelGiftMax")
    if curLevelData == nil then
        return
    end
    local curExp = self.roleSeverData.affectionExp
    -- 判断是否喜欢的礼物
    local likeRage = (affectionConfig and affectionConfig.extraGift and tablex.find(affectionConfig.extraGift, self.nowSelectGiftId)) and 2 or 1
    local addExp = giftConfig.effect[2] * likeRage * self.nowSelectGiftCount
    local targetExp = curExp + addExp
    local targetLevel = self.roleSeverData.affectionLevel
    local maxExp = curLevelData.exp

    -- 修正：满级时允许经验累积到最大值
    while targetExp >= maxExp and targetLevel < maxLevel do
        targetExp = targetExp - maxExp
        targetLevel = targetLevel + 1
        curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, targetLevel)
        if not curLevelData then
            break
        end
        maxExp = curLevelData.exp
    end

    -- 满级经验允许累积到最大值
    if targetLevel >= maxLevel then
        targetLevel = maxLevel
        maxExp = curLevelData and curLevelData.exp or maxExp
        targetExp = math.min(targetExp, maxExp)
        self.affectionExpMax = (targetExp >= maxExp)
    else
        self.affectionExpMax = false
    end

    self:setHeartFillView(targetLevel, targetExp, maxExp)
end

--设置爱心瓶显示
---@param level integer 好感等级
---@param exp integer 好感经验
---@param maxExp integer 好感最大经验
function DockRolePanel:setHeartFillView(level, exp, maxExp)
    self.affectionLevelTxt.text.text = level
    self.affectionExpTxt.text.text = exp.."/"..maxExp

    --设置爱心瓶的填充量
    self.affectionExp.image.material:SetFloat("_FillAmount", exp / maxExp)
    --动态充能 暂时无法使用
    -- local curFill = self.affectionExp.image.material:GetFloat("_FillAmount") or 0
    -- local targetFill = exp / maxExp
    -- local duration = 0.25 -- 动画时长（秒）
    -- local step = 0.02 -- 每帧间隔
    -- local elapsed = 0

    -- local timerObj
    -- timerObj = DLuaTimer:DoRepeatForever(step, function()
    --     elapsed = elapsed + step
    --     local t = math.min(elapsed / duration, 1)
    --     local newFill = curFill + (targetFill - curFill) * t
    --     self.affectionExp.image.material:SetFloat("_FillAmount", newFill)
    --     if t >= 1 then
    --         timerObj:Stop()
    --         self.affectionExp.image.material:SetFloat("_FillAmount", targetFill)
    --     end
    -- end)
end

--设置好感度带来的加成列表
function DockRolePanel:setDetailEffectView()
    local levelData = Config.GetLevelconfigInfoByType(GE.LevelDataType.affection)
    self:FillTemplateContent(self.detailEffectNode, self.detailEffectList, tablex.size(levelData), function(index, detailEffectNode)
        detailEffectNode:SetActive(true)
        detailEffectNode.lv.text.text = levelData[index].level
        detailEffectNode.desc.text.text = levelData[index].desc
        if self.roleSeverData.affectionLevel == levelData[index].level then
            detailEffectNode.light:SetActive(true)
            detailEffectNode.lv.text.color = Color.NewFromStr("e52270")
        else
            detailEffectNode.light:SetActive(false)
            detailEffectNode.lv.text.color = Color.NewFromStr("272a31")
        end
        
    end)
end

---@param data CustomMsgData
function DockRolePanel:OpenCustomMsgPanel(data)
    self.customMsgPanel:SetActive(true)
    self.customMsgPanel.customMsgPanel:setMono(self)
    self.customMsgPanel.customMsgPanel:SetView(data)
end

--TODO: 显示角色档案信息
function DockRolePanel:SetFilesView()

    --R卡屏蔽档案和语音
    self.cvBtn:SetActive(self.roleConfig.isSpecial ~= 1)
    self.avgBtn:SetActive(self.roleConfig.isSpecial ~= 1)

    --生成档案显示
    local filesList = Config.GetArchiveInfoByType(self.roleSeverData.id, GE.ArchiveType.normal)
    --对档案进行排序
    if filesList ~= nil then
        table.sort(filesList, function(a, b)
            return a.id < b.id
        end)
        self.filesListIsNull = false
    else
        self.filesListIsNull = true
    end

    self:FillTemplateContent(self.filesBox, self.filesBoxList, tablex.size(filesList), function(index, filesBox)
        filesBox:SetActive(true)
        filesBox.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(index * 0.025, function()
            filesBox.canvasGroup:DOFade(1, 0.2)
        end)
        local filesConfig = filesList[index]
        filesBox.msgTxt.text.text = filesConfig.text
        filesBox.titleTxt.text.text = filesConfig.title
        --判断是否已解锁，未解锁需要缩起来，解锁了的展开
        local isOpen = false
        if next(filesConfig.unlock) then
            if filesConfig.unlock[1] == GE.FilesUnlockType.affectionLevel then
                isOpen = getAffectionRewardMaxLevel(self.roleSeverData.affectionRewardList) >= filesConfig.unlock[2]
                filesBox.lockBg:SetActive(not isOpen)
                filesBox.isOpenBg:SetActive(isOpen)
                filesBox.lockTxt.text.text = string.format(LocalStrEnum.AffectionLevelUnlock, filesConfig.unlock[2])
            end
        else
            filesBox.msgTxt:SetActive(true)
            filesBox.lockBg:SetActive(false)
            filesBox.isOpenBg:SetActive(true)
        end

        filesBox.playBtn.scaleButton.onClick:RemoveAllListeners()
        filesBox.playBtn.scaleButton.onClick:AddListener(function()
            --TODO: 播放AVG剧情
            self:play2DSound(self.btnSoundPath)
        end)
    end)

    --生成语音显示
    local soundList = Config.GetAffectionSoundInfoById(self.roleSeverData.id)
    --对语音进行排序 
    if soundList ~= nil then
        table.sort(soundList, function(a, b)
            local function isOpen(sound)
                if sound.unlock and next(sound.unlock) then
                    return sound.unlock[1] == GE.FilesUnlockType.affectionLevel
                        and getAffectionRewardMaxLevel(self.roleSeverData.affectionRewardList) >= sound.unlock[2]
                end
                return true
            end
            local openA, openB = isOpen(a), isOpen(b)
            if openA ~= openB then
                return openA
            end
            return a.id < b.id
        end)
        self.soundListIsNull = false
    else
        self.soundListIsNull = true
    end

    self:FillTemplateContent(self.cvBox, self.cvBoxList, tablex.size(soundList), function(index, cvBox)
        cvBox:SetActive(true)
        cvBox.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(index * 0.025, function()
            cvBox.canvasGroup:DOFade(1, 0.2)
        end)
        local soundConfig = soundList[index]
        cvBox.cvTxt.text.text = soundConfig.soundTitle

        --锁定判断
        if next(soundConfig.unlock) then
            if soundConfig.unlock[1] == GE.FilesUnlockType.affectionLevel then
                local isOpen = getAffectionRewardMaxLevel(self.roleSeverData.affectionRewardList) >= soundConfig.unlock[2]
                cvBox.isLock:SetActive(not isOpen)
                cvBox.bg:SetActive(isOpen)
                cvBox.lockTxt.text.text = string.format(LocalStrEnum.AffectionLevelUnlock, soundConfig.unlock[2])
            else
                cvBox.lockTxt.text.text = "解锁条件未知"
                cvBox.isLock:SetActive(true)
                cvBox.bg:SetActive(false)
            end
        else
            cvBox.isLock:SetActive(false)
            cvBox.bg:SetActive(true)
        end

        local nowLineConfig = Config.GetScriptLinesInfo(soundConfig.attribute)
        cvBox.playBtn.scaleButton.onClick:RemoveAllListeners()
        cvBox.playBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            if self.nowPlayCvObj and self.nowAudioKey then
                self.nowPlayCvObj.playBtn:SetActive(true)
                self.nowPlayCvObj.stopBtn:SetActive(false)
                self.nowPlayCvObj.isPlay:SetActive(false)
                self.nowPlayCvObj.isStop:SetActive(true)
                AudioMgr:stopVoice(self.nowAudioKey)
            end

            cvBox.playBtn:SetActive(false)
            cvBox.stopBtn:SetActive(true)
            cvBox.isPlay:SetActive(true)
            cvBox.isStop:SetActive(false)
            self.nowPlayCvObj = cvBox
            self.nowAudioKey = UICommonUtils.Play2DVoiceByLanguage(self.roleSeverData.id, nowLineConfig.resource,function()
                self.nowAudioKey = nil
                cvBox.playBtn:SetActive(true)
                cvBox.stopBtn:SetActive(false)
                cvBox.isPlay:SetActive(false)
                cvBox.isStop:SetActive(true)
                self.nowPlayCvObj = nil
            end, self.gameObject)
        end)

        cvBox.stopBtn.scaleButton.onClick:RemoveAllListeners()
        cvBox.stopBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            self:stopNowAudio()
        end)
    end)

    local avgList = Config.GetArchiveInfoByType(self.roleSeverData.id, GE.ArchiveType.avg)
    if avgList ~= nil then
        table.sort(avgList, function(a, b)
            return a.id < b.id
        end)
        self.avgListIsNull = false
    else
        self.avgListIsNull = true
    end
    self:FillTemplateContent(self.avgBox, self.avgBoxList, tablex.size(avgList), function(index, filesBox)
        filesBox:SetActive(true)
        filesBox.canvasGroup.alpha = 0
        DLuaTimer:DoAfter(index * 0.025, function()
            filesBox.canvasGroup:DOFade(1, 0.2)
        end)
        local filesConfig = avgList[index]
        filesBox.titleTxt.text.text = filesConfig.title
        --判断是否已解锁，未解锁需要缩起来，解锁了的展开
        local isOpen = false
        if next(filesConfig.unlock) then
            if filesConfig.unlock[1] == GE.FilesUnlockType.affectionLevel then
                isOpen = getAffectionRewardMaxLevel(self.roleSeverData.affectionRewardList) >= filesConfig.unlock[2]
                filesBox.lockBg:SetActive(not isOpen)
                filesBox.isOpenBg:SetActive(isOpen)
                filesBox.lockTxt.text.text = string.format(LocalStrEnum.AffectionLevelUnlock, filesConfig.unlock[2])
            end
        else
            filesBox.lockBg:SetActive(false)
            filesBox.isOpenBg:SetActive(true)
        end

        filesBox.playBtn:SetActive(true)
        filesBox.playBtn.scaleButton.onClick:RemoveAllListeners()
        filesBox.playBtn.scaleButton.onClick:AddListener(function()
            self:play2DSound(self.btnSoundPath)
            AudioMgr:pauseBGM()
            UIMgr:popUICover("StoryPanel", {storyName = "avg_"..filesConfig.id, callBack = function()
                --测试版本演出结束后回复bgm
                AudioMgr:resumBGM()
            end})
        end)
    end)
    --档案or语音toggle初始化
    self:selectFilesToggle(self.filesModeType, true)
end

function DockRolePanel:stopNowAudio()
    if self.nowAudioKey and self.nowPlayCvObj then
        self.nowPlayCvObj.playBtn:SetActive(true)
        self.nowPlayCvObj.stopBtn:SetActive(false)
        self.nowPlayCvObj.isPlay:SetActive(false)
        self.nowPlayCvObj = nil
        AudioMgr:stopVoice(self.nowAudioKey)
        self.nowAudioKey = nil
    end
end

function DockRolePanel:selectFilesToggle(mode, isRefresh)
    if self.filesModeType == mode and not isRefresh then
        return
    end
    self.filesModeType = mode
    self:stopNowAudio()

    self.fileBtn.isSelect:SetActive(self.filesModeType == 1)
    self.cvBtn.isSelect:SetActive(self.filesModeType == 2)
    self.avgBtn.isSelect:SetActive(self.filesModeType == 3)

    --显示对应的模式
    self.filesView:SetActive(self.filesModeType == 1)
    self.cvView:SetActive(self.filesModeType == 2)
    self.cvChoice:SetActive(self.filesModeType == 2)
    self.avgView:SetActive(self.filesModeType == 3)

    -- 判断当前模式和对应的预制体子节点数量控制isNull的开关，数量为0时显示
    local isNullActive = false
    if self.filesModeType == 1 then
        isNullActive = self.filesListIsNull
    elseif self.filesModeType == 2 then
        isNullActive = self.soundListIsNull
    elseif self.filesModeType == 3 then
        isNullActive = self.avgListIsNull
    end
    self.isNull:SetActive(isNullActive)

    --设置角色语音选项数据
    self:setCvChoiceView()
end

--设置语音选项显示
function DockRolePanel:setCvChoiceView()
    --LuaLogger.ds(">>>>>>>roleSeverData<<<<<<", tablex.dump(self.roleSeverData))
    local roleVoiceType = self.roleSeverData.voiceType
    self.cvChoiceTxt.text.text = roleVoiceType == GE.RoleLanguage.CHS and "中文语音" or "日文语音"
    local voiceTypeList = Config.GetConfigInfo("LanguageType")
    self:FillTemplateContent(self.voiceBox, self.voiceBoxList, #voiceTypeList, function (index, voiceBox)
        local isSelect = roleVoiceType == voiceTypeList[index]
        voiceBox.isSelect:SetActive(isSelect)
        voiceBox.tickIcon:SetActive(isSelect)
        local txtColor = isSelect and Color.NewFromStr("FFFFFF") or Color.NewFromStr("333333")
        voiceBox.typeNameTxt.text.color = txtColor
        voiceBox.typeNameTxt.text.text = index == 1 and "中文语音" or "日文语音"
        voiceBox.scaleButton.onClick:RemoveAllListeners()
        voiceBox.scaleButton.onClick:AddListener(function ()
            self:play2DSound(self.btnSoundPath)
            if roleVoiceType ~= voiceTypeList[index] then
                Me:setCharVoiceReq({idList = {self.roleSeverData.id}, type = voiceTypeList[index]}, function ()
                    self:setCvChoiceView()
                end)
            end
        end)
    end)
end

--刷新左侧红点
function DockRolePanel:updateLeftPoint(roleId)
    roleId = roleId or self.nowSelectRoleID
    if not roleId then
        self.msgBtn.redPoint:SetActive(false)
        self.affectionlBtn.redPoint:SetActive(false)
        self.filesBtn.redPoint:SetActive(false)
        return
    end
    --信息按钮
    self.msgBtn.redPoint:SetActive(self.uiMode == self.uiModeType.normal and
    RedPointMgr:DockRolePanelRoleMsgBtnRedJudge(roleId))
    self.affectionlBtn.redPoint:SetActive(RedPointMgr:DockRolePanelAffectionlBtnRedJudge(roleId))
    self.filesBtn.redPoint:SetActive(RedPointMgr:DockRolePanelFileBtnRedJudge(roleId))
    RedPointMgr:Refresh("DockBtnRedJudge")
end

function DockRolePanel:_onStartDrag()
    self.isDraging = true
end
function DockRolePanel:_onStopDrag()
    self.isDraging = false
end

--刷新
function DockRolePanel:Refresh()
    -- 非角色列表模式时，不立即重排列表，记录待刷新标记，待切回模式1时执行
    -- 但仍需立即刷新当前角色详情面板（SetMsgView），使升级/升星等数据变化即时呈现
    if self.nowMode ~= 1 then
        self.pendingSortRefresh = true
        if self.nowSelectRoleData and self.nowSelectRoleData.roleData then
            self:SetMsgView(self.nowSelectRoleData)
        end
        return
    end
    self:SetView(self.filtrateData, true)
end

--刷新界面但不重新选择角色格子（不会播放角色入场动画）
function DockRolePanel:RefreshWithoutRole()
    -- 这里可以添加其他需要刷新的界面元素
    -- 例如技能列表、装备信息等，但不调用SetView来避免重新选择角色
    self:SetSkillListView()
    -- 从获取途径跳转返回时，刷新好感度礼物数量与可用状态
    self:RefreshGiftListView()
end

-- 刷新好感度礼物列表数量与空状态（自选礼包兑换/外部跳转获得后需同步）
function DockRolePanel:RefreshGiftListView()
    if self.nowMode ~= 3 or not self.giftObjList or not next(self.giftObjList) then
        return
    end
    for _, v in pairs(self.giftObjList) do
        local giftBox = v.obj
        if not giftBox then
            goto continue
        end
        local itemData = Me:getItemById(v.giftId)
        local num = itemData and itemData.num or 0
        if v.customData then
            v.customData.num = num
        end
        if num > 0 then
            giftBox.emptyState:SetActive(false)
            giftBox.giftMsgBox.customBox.countObj:SetActive(true)
        else
            giftBox.emptyState:SetActive(true)
            giftBox.giftMsgBox.customBox.countObj:SetActive(false)
        end
        if v.customData then
            giftBox.giftMsgBox.customBox:SetUIData(v.customData, {disableClick = true})
        end
        giftBox.giftMsgBox.customBox.itemNum.text.text = num
        -- 选中数量超过当前持有量时进行钳制
        if self.nowSelectGiftIndex == v.key then
            if num <= 0 then
                giftBox.isSelect:SetActive(false)
                giftBox.countBg:SetActive(false)
                self.nowSelectGiftIndex = nil
                self.nowSelectGiftId = nil
                self.nowSelectGiftCount = 0
            elseif self.nowSelectGiftCount > num then
                self.nowSelectGiftCount = num
                giftBox.countTxt.text.text = self.nowSelectGiftCount
            end
        end
        ::continue::
    end
end

function DockRolePanel:OnClose(initiative)
    if self.showEndAnimTimer then
        DLuaTimer:RemoveTimer(self.showEndAnimTimer)
        self.showEndAnimTimer = nil
    end
    --清空好感度入场动画
    for k, v in pairs(self._repeatTimer) do
        DLuaTimer:RemoveTimer(v)
        v = nil
    end
    -- 关闭面板后清空本次会话的筛选/喜爱筛选状态
    self.filtrateData = nil
    self.likeMode = false
    self.likeFiltrateBtn.isOn:SetActive(false)
end

--function DockRolePanel:OnRefresh(data)
--
--end

--[[
/SortMask onClick 
--]]
function DockRolePanel:sortMask_Button_onClick(sortMask)
    self:play2DSound(self.btnSoundPath)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/SortTypeBtn onClick 
--]]
function DockRolePanel:sortTypeBtn_ScaleButton_onClick(sortTypeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/NatureNameBtn onClick 
--]]
function DockRolePanel:natureNameBtn_ScaleButton_onClick(natureNameBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/CustomSortBox/SortBg/SortBtn onClick 
--]]
function DockRolePanel:sortBtn_ScaleButton_onClick(sortBtn)
    self:play2DSound(self.btnSoundPath)
    self.sortSelectList:SetActive(not self.sortSelectList.activeSelf)
    self.sortMask:SetActive(self.sortSelectList.activeSelf)
    if self.sortSelectList.activeSelf then
        if self.nowSortIndex == GE.RoleSortType.nature and self.nowNatureMode == nil then
            self.nowSortIndex = self.lastSortIndex
            self.nowSortMode = self.lastSortIndex
            self:refreshSortView()
        end
    end
end

--[[
/CustomSortBox/SortBg/SortStateBtn onClick 
--]]
function DockRolePanel:sortStateBtn_ScaleButton_onClick(sortStateBtn)
    self:play2DSound(self.btnSoundPath)
    if self.nowSortFace == 1 then
        self.nowSortFace = 2
    elseif self.nowSortFace == 2 then
        self.nowSortFace = 1
    end
    self.sortStateBtn.upImg:SetActive(self.nowSortFace == 2)
    self.sortStateBtn.downImg:SetActive(self.nowSortFace == 1)
    self:SetView(self.filtrateData, true)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/CustomSortBox/FiltrateBtn onClick 
--]]
function DockRolePanel:filtrateBtn_ScaleButton_onClick(filtrateBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("DockFiltrateBox", { filtrateData = self.filtrateData })
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/CustomSortBox/LikeFiltrateBtn onClick 
--]]
function DockRolePanel:likeFiltrateBtn_ScaleButton_onClick(likeFiltrateBtn)
    self:play2DSound(self.btnSoundPath)
    if self.likeMode then
        self:SetView(self.filtrateData, true)
        self.likeMode = false
    else
        if PlayerPrefs.HasKey("DockFiltrateData") then
            local str = PlayerPrefs.GetString("DockFiltrateData")
            local saveData = loadstring("return "..str)()
            self:SetView(self.filtrateData, true, saveData)
        end
        self.likeMode = true
    end
    self.likeFiltrateBtn.isOn:SetActive(self.likeMode)
    self.sortSelectList:SetActive(false)
    self.sortMask:SetActive(false)
end

--[[
/ToggleList/MsgBtn onClick  信息按钮
--]]
function DockRolePanel:msgBtn_ScaleButton_onClick(msgBtn)
    self:play2DSound(self.btnSoundPath)
    self:SelectMode(2)
end

--[[
/NameCardBg/TagBtn onClick 
--]]
function DockRolePanel:tagBtn_ScaleButton_onClick(tagBtn)
    self:play2DSound(self.btnSoundPath)
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    UIMgr:popUICover("RoleTagPanel", {roleIndex = self.RoleIndex, roleList = self.RoleList, uiMode = self.uiMode, roleSeverData = self.roleSeverData, roleConfig = self.roleConfig})
end

--[[
/NameCardBg/TypeImg onClick 
--]]
function DockRolePanel:typeImg_ScaleButton_onClick(typeImg)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUICover("RestraintMsgPanel", self.roleConfig)
end

--[[
/LevelBg/LevelUpBtn onClick 
--]]
function DockRolePanel:levelUpBtn_ScaleButton_onClick(levelUpBtn)
    self:play2DSound(self.btnSoundPath)
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    UIMgr:popUICover("LevelUpPanel", self.roleSeverData.id)
end

--[[
/WeaponView/WeaponBox_1/Btn onClick 
--]]
function DockRolePanel:btn_ScaleButton_onClick(btn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgPanel/SkillMsgBg/EquipBtn onClick 
--]]
function DockRolePanel:equipBtn_ScaleButton_onClick(equipBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgPanel/SkillMsgBg/UnEquipBtn onClick 
--]]
function DockRolePanel:unEquipBtn_ScaleButton_onClick(unEquipBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/SkillMsgPanel/SkillMsgBg/ChangeBtn onClick 
--]]
function DockRolePanel:changeBtn_ScaleButton_onClick(changeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/MsgMode/StarBg/StarUpBtn onClick 
--]]
function DockRolePanel:starUpBtn_ScaleButton_onClick(starUpBtn)
    self:play2DSound(self.btnSoundPath)
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    UIMgr:popUI("StarUpPanel", {id = self.roleSeverData.id, uiMode = self.uiMode})
end

--[[
/MsgMode/SkillView/SkillTreeBtn onClick 
--]]
function DockRolePanel:skillTreeBtn_ScaleButton_onClick(skillTreeBtn)
    self:play2DSound(self.btnSoundPath)
    self.skillMsgPanel.skillMsgPanel:closeSkillMask()
    UIMgr:popUI("SkillTreePanel",  {serverData = self.roleSeverData, config = self.roleConfig, uiMode = self.uiMode})
end

--[[
/MsgMode/SkinBtn onClick 
--]]
function DockRolePanel:skinBtn_ScaleButton_onClick(skinBtn)
    self:play2DSound(self.btnSoundPath)
    LoadingMgr:SetUISwitchStart(function()
        UIMgr:popUI("SkinPanel",  {roleID = self.roleSeverData.id})
    end)
end

--[[
/ToggleList/NoneBtn onClick 
--]]
function DockRolePanel:noneBtn_ScaleButton_onClick(noneBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/ToggleList/NoneBtn_1 onClick 
--]]
function DockRolePanel:noneBtn_1_ScaleButton_onClick(noneBtn_1)
    self:play2DSound(self.btnSoundPath)
end

--[[
/ToggleList/NullBtn1 onClick 
--]]
function DockRolePanel:nullBtn1_ScaleButton_onClick(nullBtn1)
    self:play2DSound(self.btnSoundPath)
end

--[[
/ToggleList/NullBtn2 onClick 
--]]
function DockRolePanel:nullBtn2_ScaleButton_onClick(nullBtn2)
    self:play2DSound(self.btnSoundPath)
end

--[[
/ModeList/RoleMode/ShowMsgBtn onClick 
--]]
function DockRolePanel:showMsgBtn_ScaleButton_onClick(showMsgBtn)
    self:play2DSound(self.btnSoundPath)
    self:SelectMode(2)
end

--[[
/AdjustRoot/ModeList/GiftList/CloseBtn onClick 
--]]
function DockRolePanel:closeBtn_ScaleButton_onClick(closeBtn)
    self:play2DSound(self.btnSoundPath)
end

--[[
/AdjustRoot/ToggleList/AffectionlBtn onClick 
--]]
function DockRolePanel:affectionlBtn_ScaleButton_onClick(affectionlBtn)
    self:play2DSound(self.btnSoundPath)
    self:SelectMode(3)
end

--[[
/AdjustRoot/ToggleList/FilesBtn onClick 
--]]
function DockRolePanel:filesBtn_ScaleButton_onClick(filesBtn)
    self:play2DSound(self.btnSoundPath)
    self:SelectMode(4)
    self:refreshFileModeToggleRedPoint(self.filesModeType)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.avgBoxList.transform)
    UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self.filesBoxList.transform)
end

--[[
/AdjustRoot/ModeList/FilesMode/bg/ToggleBg/FileBtn onClick 
--]]
function DockRolePanel:fileBtn_ScaleButton_onClick(fileBtn)
    self:play2DSound(self.btnSoundPath)
    self:selectFilesToggle(1)
    self:refreshFileModeToggleRedPoint(1)
end

--[[
/AdjustRoot/ModeList/FilesMode/bg/ToggleBg/CvBtn onClick 
--]]
function DockRolePanel:cvBtn_ScaleButton_onClick(cvBtn)
    self:play2DSound(self.btnSoundPath)
    self:selectFilesToggle(2)
    self:refreshFileModeToggleRedPoint(2)
end

function DockRolePanel:refreshFileModeToggleRedPoint(index)
    if self.uiMode == self.uiModeType.hankBook or self.uiMode == self.uiModeType.character then
        return
    end
    if index == 1 then
        local filesList = Config.GetArchiveInfoById(self.roleSeverData.id)
        if filesList then
            for _, v in pairs(filesList) do
                if v.unlock and next(v.unlock) then
                    if v.unlock[1] == GE.FilesUnlockType.affectionLevel then
                        if self.roleSeverData.affectionLevel >= v.unlock[2] then
                            RedPointMgr:SetRedDotState("RoleArchiveCheck".. v.id, true)
                        end
                    end
                end
            end
        end
    else
        local soundList = Config.GetAffectionSoundInfoById(self.roleSeverData.id)
        if soundList then
            for _, v in pairs(soundList) do
                if v.unlock and next(v.unlock) then
                    if v.unlock[1] == GE.FilesUnlockType.affectionLevel then
                        if self.roleSeverData.affectionLevel >= v.unlock[2] then
                            RedPointMgr:SetRedDotState("RoleAffectionSoundCheck".. v.id, true)
                        end
                    end
                else
                    RedPointMgr:SetRedDotState("RoleAffectionSoundCheck".. v.id, true)
                end
            end
        end
    end
    self.fileBtn.fileRedPoint:SetActive(RedPointMgr:DockRolePanelFileToggleRedJudge(self.roleSeverData.id))
    self.cvBtn.cvRedPoint:SetActive(RedPointMgr:DockRolePanelCvToggleRedJudge(self.roleSeverData.id))
    self:updateLeftPoint(self.roleSeverData.id)
end

--[[
/AdjustRoot/ModeList/FilesMode/bg/ToggleBg/AvgBtn onClick 
--]]
function DockRolePanel:avgBtn_ScaleButton_onClick(avgBtn)
    self:play2DSound(self.btnSoundPath)
    self:selectFilesToggle(3)
end

--[[
/AdjustRoot/ModeList/AffectionMode/Bg/GiveGiftBtn onClick 
--]]
function DockRolePanel:giveGiftBtn_ScaleButton_onClick(giveGiftBtn)
    if self.nowSelectGiftId == nil then
        UICommonUtils.PopToast("请选中要赠送的礼物")
        return
    end
    self.affectionUpEf:SetActive(false)
    Me:heroAffectionGitfReq({id = self.roleSeverData.id, giftId = self.nowSelectGiftId, count = self.nowSelectGiftCount}, function()
        UICommonUtils.PopToast(LocalStrEnum.AffectionGiftSuccess)
        self:SetMsgView(self.nowSelectRoleData)  --刷新六维属性（好感度等级可能提升影响属性）
        self:SetAffectionView()
        self.affectionUpEf:SetActive(true)
        self:updateLeftPoint(self.roleSeverData.id)
    end)
end

--[[
/Custom/GiftBox/Bg/CountBg/ReduceBtn onClick 
--]]
function DockRolePanel:reduceBtn_ScaleButton_onClick(reduceBtn)

end

--[[
/AdjustRoot/ModeList/AffectionMode/AffectionLevelUpBtn onClick  好感度提升按钮
--]]
function DockRolePanel:affectionLevelUpBtn_Button_onClick(affectionLevelUpBtn)
    -- self:play2DSound(self.btnSoundPath)
    -- local screenPos = UIMgr.uiCamera:WorldToScreenPoint(self.affectionLevelUpBtn.transform.position)
    -- local pos = UICommonUtils.ScreenToUILocalPos(self.detailEffect.transform, UIMgr.uiCamera, screenPos)
    -- self.detailEffect.bg.transform.localPosition = Vector3.New(pos.x - 400, self.detailEffect.bg.transform.localPosition.y, 0)
    -- self.detailEffect:SetActive(true)
    --处理效果展示界面显示
end

--[[
/AdjustRoot/ModeList/NameCardBg/NameTxt/ChangeNameBtn onClick 
--]]
function DockRolePanel:changeNameBtn_ScaleButton_onClick(changeNameBtn)
    self:play2DSound(self.btnSoundPath)
    UIMgr:popUI("MsgBox", {
        title = "修改名称", 
        type = MsgBoxType.ChangePlayerName,
        titleIcon = MsgTitleIconType.Pen,
        okCallback = function(nameText)
            self:play2DSound(self.btnSoundPath)
            local signTxt = ""
            signTxt = nameText

            if signTxt == nil then
                return
            end

            if UICommonUtils.ToastLogicError(signTxt:len() > 0, ActionFailReason.NameTooShort) then
                return
            end
            if UICommonUtils.ToastLogicError(utf8util.len(signTxt) <= 7, ActionFailReason.NameTooLong) then
                return
            end
            signTxt = signTxt:trim()
            local checkRes = GV.GlobalConfig.HasForbiddenWord(signTxt)
            if checkRes ~= false then
                local msg = utf8util.gsub("\"$word\"不可使用", "%$(%w+)", checkRes)
                UICommonUtils.PopToast(msg)
                return
            end
            if UICommonUtils.ToastLogicError(not signTxt:find("['\"\\]") and not utf8util.hasEmoji(signTxt), ActionFailReason.NameContainsInvalidChar) then
                return
            end
            -- self.roleSeverData = Me:getPlayerHero(self.roleConfig.id)
            Me:heroChangeNameReq({id = self.roleSeverData.id, newName = signTxt}, function()
                -- self.userNameTxt.text.text = Me:getUserName()
                local heroInfo = Me:getPlayerHero(self.roleConfig.id)
                if heroInfo.name == nil or heroInfo.name == "" then
                    self.nameTxt.text.text = self.roleConfig.name
                    self.nameShadowTxt.text.text = self.roleConfig.name
                else
                    self.nameTxt.text.text = heroInfo.name
                    self.nameShadowTxt.text.text = heroInfo.name
                end
                self:SetView(self.filtrateData, true)
                UICommonUtils.PopToast("更换成功")
            end)
        end,
        resetNameCallBack = function()
            self:play2DSound(self.btnSoundPath)
            local heroInfo = Me:getPlayerHero(self.roleConfig.id)
            if heroInfo.name == nil or heroInfo.name == "" then
                return
            end
            Me:heroChangeNameReq({id = self.roleSeverData.id}, function()
                if heroInfo.name == nil or heroInfo.name == "" then
                    self.nameTxt.text.text = self.roleConfig.name
                    self.nameShadowTxt.text.text = self.roleConfig.name
                else
                    self.nameTxt.text.text = heroInfo.name
                    self.nameShadowTxt.text.text = heroInfo.name
                end
                self:SetView(self.filtrateData, true)
                UICommonUtils.PopToast("重置成功")
            end)
        end}
    )
end

--[[
/DetailEffect onClick 
--]]
function DockRolePanel:detailEffect_Button_onClick(detailEffect)
    self.detailEffect:SetActive(false)
end

--[[
/AdjustRoot/ModeList/FilesMode/bg/CvChoice onClick 
--]]
function DockRolePanel:cvChoice_ScaleButton_onClick(cvChoice)
    self.voiceChiocePanel:SetActive(true)
end

--[[
/AdjustRoot/VoiceChiocePanel onClick 
--]]
function DockRolePanel:voiceChiocePanel_Button_onClick(voiceChiocePanel)
    self.voiceChiocePanel:SetActive(false)
end

function DockRolePanel:OnDestroy()
    self.super:OnDestroy(self)
end

return DockRolePanel
