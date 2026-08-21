-- baoruichang
-- 2023/5/26 16:11:33
-- UIKitChen
local UIKitChenCtrl = BaseClass("UIKitChenCtrl", BaseUICtrl)
local M = UIKitChenCtrl
local OtakuRoomType = OtakuType.OtakuRoomType
local UIKitChenItemCtrl = require("UI.Ctrl.UIKitChen.UIKitChenItemCtrl")
local UIKitChenItemView = require("UI.View.UIKitChen.UIKitChenItemView")
local MessageId = Proto.MessageId
local sfmt = string.format
local mModf = math.modf
local tIndexof = table.indexof
local MATERIALNUM = 4

function M:Init()
    self._view.btnOk:SetOnClick(Bind(self, self._OnBtnOkClick))
    self._view.btnBatch:SetOnClick(Bind(self, self._OnBtnBatchClick))
    -- self._view.imgMoveMat:SetActive(false)
    self.grid = self._view.grid
    self.grid:Init(UIKitChenItemCtrl, UIKitChenItemView)
    self.grid:SetCreateItemCallback(Bind(self, self._onCreateItem))
end

-- 进入UI，可传参数
function M:OnEnter(menuData, roomData, foodId)
    self._tempUpdateHero = EventMgr:AddListener(UIMessageNames.OTAKU_SETTLE_UPDATE, Bind(self, self._UpdateHero))
    self._upGradeCallBack = EventMgr:AddListener(UIMessageNames.OTAKU_UPGRADE, Bind(self, self.StudioUpgradeCallBack))
    self.menuData = menuData
    self.roomData = roomData
    self.level = self.roomData:Level()
    self._view.OtakuTitleCtrl:Init(roomData)
    self:_initHero()
    local selectMenuData
    if foodId then
        for _, menu in pairs(self.menuData) do
            if foodId == menu.food then
                selectMenuData = menu
                break
            end
        end
    else
        selectMenuData = self.menuData[1]
    end
    self:_onClickItem(selectMenuData, true)

end

-- 当盖住自己的全屏UI关闭时掉用
function M:OnVisible()
    self:MaterialEnough()
end

function M:_UpdateHero(roomId)
    if roomId ~= self.roomData:RoomId() then
        return
    end
    self:_initHero()
    self:MaterialEnough()
    for _, menu in pairs(self.menuData) do
        menu.eatNum = self.eatNum
    end
    self.grid:UpdateList()
end

function M:StudioUpgradeCallBack(roomId)
    if roomId ~= self.roomData:RoomId() then
        return
    end
    self.level = self.roomData:Level()
    self:_UpdateBtnState()
end

function M:_initHero()
    local data = self.roomData:LiveSpace()
    data[1].curSettleType = self.roomData:SettleType()
    data[1].noState = true
    self._view.OtakuSettleHeroItemCtrl:UpdateItem(data[1])
    self.heroId = data[1]:HeroId()
    self._view.labNum:SetText(self.heroId and "1" or "0")
    self:_UpdateHeroSkill()
    self:_initEatNums()
end

function M:_initEatNums()
    local rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
    if not rshd then
        -- Logger.LogError("获取英雄当前饱食度，未找到该英雄")
        self.eatNum = 0
        return
    end
    self.eatNum = rshd:GetEater()
end

function M:_OnBtnOkClick()
    if not self.foodEnough then
        GameHelper.TipsById(10454)
        return
    end
    if not self.materialEnough then
        GameHelper.TipsById(5445)
        return
    end
    self:RequestCooking(1)
end

-- 批量烹饪
function M:_OnBtnBatchClick()
    if not self.foodEnough then
        GameHelper.TipsById(10454)
        return
    end
    if not self.materialEnough then
        GameHelper.TipsById(5445)
        return
    end
    local maxNum = self:GetBatchMaxNum()
    UIContextMgr:GetInstance():Show(UIDefine.UIKitChenPop, self.selectMenu.food, maxNum, Bind(self, self.RequestCooking))
end

function M:GetBatchMaxNum()
    local maxNum = mModf(self.eatNum / self.selectMenu.cookCost)
    for i = 1, #self.selectMenu.itemCost do
        local id = self.selectMenu.itemCost[i]
        local haveNum = ItemDataMgr:GetInstance():GetItemNumById(id)
        local num = mModf(haveNum / self.selectMenu.itemNum[i])
        maxNum = maxNum <= num and maxNum or num
    end
    return maxNum
end

function M:_UpdateHeroSkill()
    if not self.heroId then
        self._view.labSkillDes.transform.parent:SetActive(false)
        return
    end
    self.heroData = IHeroDataMgr:GetMyHeroDataById(self.heroId)
    local heroBreak = self.heroData:GetHeroBreak()
    local powerIds = heroBreak.powerId
    local kitPower
    for i = 0, powerIds.Length - 1 do
        if powerIds[i] ~= 1 and powerIds[i] ~= 2 then
            local power = ConfigHelper.GetCfg("power", powerIds[i])
            if power.label == OtakuRoomType.EST_Kitchen then
                kitPower = power
                break
            end
        end
    end
    if kitPower then
        self._view.labSkillName:SetText(kitPower.powerName)
        self._view.labSkillDes:SetText(kitPower.powerDes)
        self._view.labSkillDes.transform.parent:SetActive(true)
    else
        self._view.labSkillDes.transform.parent:SetActive(false)
    end
end

---更新批量烹饪按钮状态
function M:_UpdateBtnState()
    if self.level < self.selectMenu.houseLevel then
        self._view.btnBatch:SetState(1)
        local lockTips = ConfigHelper.GetLocalString(6244)
        lockTips = sfmt(lockTips, self.selectMenu.houseLevel)
        self._view.labLockTips:SetText(lockTips)
        return
    end
    self._view.labLockTips:SetText("")
    self._view.btnBatch:SetState(0)
end

-- 判断饱食度和材料是否充足
function M:MaterialEnough()
    self.foodEnough = self.eatNum >= self.selectMenu.cookCost
    self._view.heroUIState:SetState(self.foodEnough and 3 or 1)
    self.materialEnough = true
    for i = 1, #self.selectMenu.itemCost do
        local id = self.selectMenu.itemCost[i]
        local haveNum = ItemDataMgr:GetInstance():GetItemNumById(id)
        self.materialEnough = self.materialEnough and haveNum >= self.selectMenu.itemNum[i]
        if not self.materialEnough then
            return
        end
    end
end

function M:_onCreateItem(UIKitChenItemCtrl)
    UIKitChenItemCtrl:SetOnClick(Bind(self, self._onClickItem))
    UIKitChenItemCtrl:SetState(1)
end

function M:_onClickItem(selectMenu, first)
    if self.selectMenu == selectMenu then
        return
    end
    self.selectMenu = selectMenu
    self:MaterialEnough()
    self:_UpdateBtnState()
    for _, menu in pairs(self.menuData) do
        menu.selectId = self.selectMenu.id
        menu.eatNum = self.eatNum
    end
    self.grid:SetDataList(self.menuData)

    self._view.labName:SetText(self.selectMenu.name)

    for i = 1, #self.selectMenu.itemCost do
        self._view["imgMat" .. i]:SetItemIcon(self.selectMenu.itemCost[i])
        self._view["imgMat" .. i].transform.parent:SetActive(true)
    end
    for i = #self.selectMenu.itemCost + 1, MATERIALNUM do
        self._view["imgMat" .. i].transform.parent:SetActive(false)
    end

end

---------------------------------Proto Start--------------------------------------
function M:RequestCooking(MakeTimes)
    self._tempCookingCallBack = NetPack:RegistResponse(MessageId.ResponseCooking, Bind(self, self.ResponseCookingCallBack))
    local request = {}
    request.MakeTimes = MakeTimes -- 制作的次数
    request.Studio = self.roomData:RoomId() -- 舱室id
    request.MenuId = self.selectMenu.id -- 菜单id
    NetPack:SendMessage(MessageId.RequestCooking, request)
end

function M:ResponseCookingCallBack(_, result, msg)
    NetPack:UnRegistResponse(MessageId.ResponseCooking, self._tempCookingCallBack)
    self._tempCookingCallBack = nil

    if result ~= 0 then
        Logger.LogError("错误码：" .. result)
        return
    end
    local ids, nums, stateDic = {}, {}, {}
    for index, item in pairs(msg.Items) do
        local tempIndex = tIndexof(ids, item.Id)
        if tempIndex then
            nums[tempIndex] = nums[tempIndex] + item.Cnt
        else
            tempIndex = #ids + 1
            ids[tempIndex] = item.Id
            nums[tempIndex] = item.Cnt
            stateDic[tempIndex - 1] = 1
        end
    end
    for index, item in pairs(msg.EffectItems) do
        local tempIndex = #ids + 1
        ids[tempIndex] = item.Id
        nums[tempIndex] = item.Cnt
        stateDic[tempIndex - 1] = 2
    end
    GameHelper.ShowAwards(ids, nums, stateDic)
    self:_initHero()
    self:MaterialEnough()
    for _, menu in pairs(self.menuData) do
        menu.eatNum = self.eatNum
    end
    self.grid:UpdateList()
    -- 烹饪埋点
    -- dish_id
    -- dish_hero_id
    local data = {msg.MenuId, self.heroId}
    IBuriedPointDataMgr:SubmitData(BuriedPointConst.Cabin_cooking, data)
end
---------------------------------Proto End---------------------------------------

-- 关闭时回调，无参
function M:OnClose()
    self.selectMenu = nil
    EventMgr:RemoveListener(UIMessageNames.OTAKU_UPGRADE, self._upGradeCallBack)
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_UPDATE, self._tempUpdateHero)
    M.super.OnClose(self)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.OTAKU_UPGRADE, self._upGradeCallBack)
    EventMgr:RemoveListener(UIMessageNames.OTAKU_SETTLE_UPDATE, self._tempUpdateHero)
    M.super.OnDispose(self)
end

return UIKitChenCtrl
--                            _ooOoo_
--                           o8888888o
--                           88" . "88
--                           (| -_- |)
--                            O. = /O
--                        ____/`---'.____
--						  . ' ..| |-- `.
--                       / ..||| : |||-- .
--                     / _||||| -:- |||||- .
--                       | | ... - --/ | |
--                     | ._| ''.---/'' | |
--                      . .-.__ `-` ___/-. /
--                   ___`. .' /--.--. `. . __
--                ."" '< `.___._<|>_/___.' >'"".
--               | | : `- .`.;`. _ /`;.`/ - ` : | |
--                 . . `-. ._ __. /__ _/ .-` / /
--         ======`-.____`-.___._____/___.-`____.-'======
--                            `=---='
--
--         .............................................
--                  佛祖镇楼                  BUG辟易
--          佛曰:
--                  写字楼里写字间，写字间里程序员；
--                  程序人员写程序，又拿程序换酒钱。
--                  酒醒只在网上坐，酒醉还来网下眠；
--                  酒醉酒醒日复日，网上网下年复年。
--                  但愿老死电脑间，不愿鞠躬老板前；
--                  奔驰宝马贵者趣，公交自行程序员。
--                  别人笑我忒疯癫，我笑自己命太贱；
--                  不见满街漂亮妹，哪个归得程序员？

