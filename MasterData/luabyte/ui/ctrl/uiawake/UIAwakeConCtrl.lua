-- baoruichang
-- 2022/12/1 18:32:02
-- RoleAwakeContent
local UIAwakeConCtrl = BaseClass("UIAwakeConCtrl", BaseUICtrl)
local M = UIAwakeConCtrl
local EQuality = EnumConst.EQuality
local NumPicPath = EnumConst.NumPicPath
local TaskState = TaskConst.TaskState
local TaskType = TaskConst.TaskType
local tInsert = table.insert
local tIndexof = table.indexof
local sfmt = string.format
local MessageId = Proto.MessageId
local SSRLEVEL = 6
local SRLEVEL = 3
local ItemPfbCtrl = require("UI.Ctrl.RoleDevelop.UICoreCostCtrl")
local ItemPfbView = require("UI.View.Common.ItemPfbView")

function M:Init()
    self._view.btnAwake:onClick(Bind(self, self._OnBtnAwakeClick))
    self._view.btnGo:onClick(Bind(self, self._OnBtnGoClick))
    self._view.btnBack:onClick(Bind(self, self.Close))
    self.tabBtnCtrl = {}
    tInsert(self.tabBtnCtrl, self._view.UIAwakeBtnCtrl)
    self.grid = self._view.grid
    self.grid:Init(ItemPfbCtrl, ItemPfbView)
    self.system333 = ConfigHelper.GetSystemParams(333)
end

-- 进入UI，可传参数
function M:OnEnter(heroId)
    self.heroId = heroId
    self.heroData = IHeroDataMgr:GetMyHeroDataById(self.heroId)
    self.awakeLevel = self.heroData:GetAwakeLevel()
    self:_InitUI()
end

function M:_InitUI()
    self.rare = ConfigHelper.GetCfgPropByLua("hero", self.heroId, "rare")
    self.levelNum = self.rare == EQuality.SSR and SSRLEVEL or SRLEVEL
    self.heroAwakes = ConfigHelper.GetCfgsByLua("heroAwake", {heroId=self.heroId})
    local resource = ConfigHelper.GetCfg("resource", self.heroId)
    self._view.RawImageHero:SetPic(resource.illustration)
    self._view.RawImageBg:SetPic(resource.DevelopAwakePicture)
    self._view.stateNum:SetState(self.rare == EQuality.SSR and 1 or 2)
    if self.levelNum == 6 then
        self._view.stateOpen1:SetState(self.awakeLevel + 1)
    else
        self._view.stateOpen2:SetState(self.awakeLevel + 1)
    end
    for i = 1, self.levelNum do
        local UIAwakeBtnCtrl = self.tabBtnCtrl[i]
        if not UIAwakeBtnCtrl then
            UIAwakeBtnCtrl = self._view.UIAwakeBtnCtrl:Instantiate()
            tInsert(self.tabBtnCtrl, UIAwakeBtnCtrl)
        end
        local tempData = {}
        tempData.id = i
        tempData.isOpen = self.awakeLevel >= i
        tempData.clickFunc = Bind(self, self._OnClickLvItem)
        tempData.heroAwake = self.heroAwakes[i]
        UIAwakeBtnCtrl:UpdateData(tempData)
    end

    local tempSelectLv = self.awakeLevel < self.levelNum and self.awakeLevel + 1 or self.awakeLevel
    self:_OnClickLvItem(tempSelectLv)
end

function M:_OnClickLvItem(lv)
    self.selectLv = lv
    if self.selectLastBtn then
        self.selectLastBtn:SetSelectState(lv)
    end
    self.selectLastBtn = self.tabBtnCtrl[lv]
    self.selectLastBtn:SetSelectState(lv)

    local heroAwake = self.selectLastBtn:GetHeroAwake()
    self._view.stateCondition:SetState(heroAwake.type)
    self._view.imgNum:SetPic(NumPicPath .. lv)
    self.canClick = self.awakeLevel + 1 == lv
    local isOpen = self.awakeLevel >= lv

    self:_SetRightInfo(heroAwake, isOpen)
    if isOpen then
        self._view.stateBtn:SetState(3)
    elseif self.canClick and not self.jumpId then
        self._view.stateBtn:SetState(1)
        self._view.labBtn1:SetText(sfmt(ConfigHelper.GetLocalString(5808), lv))
    else
        self._view.stateBtn:SetState(2)
        if self.canClick then
            self._view.labBtn2:SetText(1207)
        else
            self._view.labBtn2:SetText(sfmt(ConfigHelper.GetLocalString(5806), lv - 1))
        end
    end

    if self.lastStateItem then
        self.lastStateItem:SetState(1)
    end
    if not isOpen then
        if self.levelNum == SRLEVEL then
            self.lastStateItem = self._view["stateItem" .. (lv + SSRLEVEL)]
        else
            self.lastStateItem = self._view["stateItem" .. lv]
        end
        self.lastStateItem:SetState(2)
    end
end

---设置资源消耗和任务完成情况
function M:_SetRightInfo(heroAwake, isOpen)
    self.conditionComplete = true
    self.jumpId = nil
    if heroAwake.type == 1 then -- 任务
        local taskData = TaskDataMgr:GetTaskData(TaskType.Awake, heroAwake.task)

        local limit = taskData.limitValue1

        local task = ConfigHelper.GetCfgByLua("task", heroAwake.task)

        if isOpen then -- 已经完成
        elseif taskData.state == TaskState.Doing then -- 正在做
            if table.arrayContains(self.system333, task.limit) then
                limit = self:_GetTaskLimit(task)
            else
                limit = taskData.value0
            end
        end
        local desc = ConfigHelper.GetLocalString(heroAwake.des)
        self.conditionComplete = limit >= taskData.limitValue1
        if self.conditionComplete then
            desc = sfmt("%s<color=#4cd391>(%d/%d)</color>", desc, limit, taskData.limitValue1)
        else
            desc = sfmt("%s(<color=red>%d</color>/%d)", desc, limit, taskData.limitValue1)
            if self.canClick then
                self.jumpId = task.jumpId
            end
        end
        self._view.labDesc1:SetText(desc)
    else -- 材料
        if isOpen then
            self._view.labDesc2:SetText(30247)
            self.grid:SetDataList({})
            self._view.ComItemSlipCtrl:SetActive(false)
        else
            self._view.labDesc2:SetText(30197)
            local tempDatas = {}
            local constId1 = 0
            local constId1Num = 0 -- 消耗星币数量
            for index, id in pairs(heroAwake.costItems) do
                local haveNum = ItemDataMgr:GetInstance():GetItemNumById(id)
                local needNum = heroAwake.costNum[index]
                self.conditionComplete = self.conditionComplete and needNum <= haveNum
                if id ~= 1 then
                    tInsert(tempDatas, {id=id, haveNum=haveNum, needNum=needNum})
                else
                    constId1Num = needNum
                    constId1 = id
                end
            end
            self.grid:SetDataList(tempDatas)
            if constId1Num > 0 then
                self._view.ComItemSlipCtrl:SetItemById(constId1, constId1Num)
            else
                self._view.ComItemSlipCtrl:SetActive(false)
            end
        end
    end
end


function M:_GetTaskLimit(task)
    if task.limit == 46 then
        return self:_GetLimitHeroLevel(task.limitValue2)
    elseif task.limit == 83 then
        return self:_GetLimitSkillLevel(task.limitValue2)
    elseif task.limit == 85 then
        return self:_GetLimitGeneLevel(task.limitValue2)
    end
    return 0
end

function M:_GetLimitHeroLevel(heroId)
    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    return heroData:GetLevel()
end

function M:_GetLimitSkillLevel(heroId)
    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    return heroData:GetSkillLevel()
end

function M:_GetLimitGeneLevel(heroId)
    local heroData = IHeroDataMgr:GetMyHeroDataById(heroId)
    return heroData:GetGeneStar()
end

function M:_OnBtnAwakeClick()
    if not self.canClick then
        return
    end
    if not self.conditionComplete then
        GameHelper.TipsById(10318)
    end
    self._TempResponseAwakeUpgradeCallback = NetPack:RegistResponse(MessageId.ResponseAwakeUpgrade, Bind(self, self.ResponseAwakeUpgradeCallback))
    local request = {}
    request.HeroId = self.heroId
    NetPack:SendMessage(MessageId.RequestAwakeUpgrade, request)
end

function M:_OnBtnGoClick()
    if self.canClick and self.jumpId then
        GameHelper.Jump(self.jumpId)
        return
    end
end

-- 请求觉醒升级Ack
function M:ResponseAwakeUpgradeCallback(messagId, result, msg)
    Logger.Log("请求觉醒升级Ack")
    NetPack:UnRegistResponse(MessageId.ResponseAwakeUpgrade, self._TempResponseAwakeUpgradeCallback)
    self._TempResponseAwakeUpgradeCallback = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    self.awakeLevel = self.awakeLevel + 1
    self.heroData:SetAwakeLevel(self.awakeLevel)
    self:_InitUI()
    self:_ShowUpLevel()
    -- UIContextMgr:GetInstance():Show(UIDefine.UIAwakeSuccess, self.heroId, Bind(self, self._ShowUpLevel))
    EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_AWAKE, self.heroId)

    -- 埋点数据
    local profession = ConfigHelper.GetCfgPropByLua("role", self.heroId, "profession")
    -- local dataKey = { "hero_type", "hero_quality", "hero_id", "wake_level" }
    local dataValues = {tostring(profession), tostring(self.rare), tostring(self.heroId), tostring(self.awakeLevel)}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.HeroWakeup, dataValues)
    IRedPointMgr:ForceCheck(RedPointConst.RoleAwakeRedPointChecker)
end

function M:_ShowUpLevel()
    if self.rare == EQuality.SSR and self.awakeLevel == SSRLEVEL or self.rare == EQuality.SR and self.awakeLevel == SRLEVEL then
        local showCfg = ConfigHelper.GetCfg("awakeShow", self.heroId)
        if showCfg then
            UIContextMgr:GetInstance():Show("RoleAwakeShow", self.heroId)
        else
            UIContextMgr:GetInstance():Show(UIDefine.UpLevel, nil, 5682, 688)
        end
    else
        UIContextMgr:GetInstance():Show(UIDefine.UpLevel, nil, 5682, 688)
    end
end

-- 点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

function M:OnDispose()
    for _, value in ipairs(self.tabBtnCtrl) do
        CS.UnityEngine.GameObject.Destroy(value.gameObject)
        value:OnDestroy()
    end
    M.super.OnDispose(self)
end

return UIAwakeConCtrl
