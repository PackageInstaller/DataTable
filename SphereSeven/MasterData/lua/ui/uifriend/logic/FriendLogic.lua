---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by win 10.
--- DateTime: 2019/7/11 17:09
---

local FriendLogic = {}
local this = FriendLogic

local friendPfbName = "FriendItem"


local function OnClickDeleteButton(self,friendId)
    ---@type ToolTipFirstData
    local tipData = {}
    tipData.message = LangUtil.GetSysLang(1462) -- 是否删除好友
    tipData.callBack = function()
        PublicRequest.SendRequest(
                PROTOCOL.RemoveFriendReq,
                {
                    role_id = friendId,
                },
                function()
                end
        )
    end
    UIUtil.ToolTipFirstStarLight(tipData)
end

-- 点击最近登录
function this.OnClickLatelyButton(self)
    -- if self.sort == 1 then
    --     return
    -- end
    -- self.sort = 1
    -- this.SortByLate(self)
    -- table.walk(self.friendsList, function (k, v)
    --     if not IsNull(self.friendObjs[v.role.info.roleId]) then
    --         self.friendObjs[v.role.info.roleId].transform:SetAsLastSibling()
    --     end
    -- end)
end

---@param v Friend
function this.OnFriendItem(self, object, v)
    self.friendObjs[v.role.info.roleId] = object
    self.friendObjs[v.role.info.roleId]:SetActive(true)
    self.friendObjs[v.role.info.roleId].transform:SetAsLastSibling()
    local rc = object:GetComponent("ReferenceCollector")
    local avatar_Image = rc:GetObject("Avatar"):GetComponent("Image")
    local name_Text = rc:GetObject("Name")
    local level_Text = rc:GetObject("Level"):GetComponent("Text")
    local StateLX = rc:GetObject("StateLX")
    local StateZX = rc:GetObject("StateZX")
    local IDText= rc:GetObject("IDText")

    LangUtil.GetSpriteLang(456, function(sprite) StateLX:GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(457, function(sprite) StateZX:GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(458, function(sprite) rc:GetObject("SupportImage"):GetComponent("Image").sprite = sprite end)
    LangUtil.GetSpriteLang(459, function(sprite) rc:GetObject("NoFightSoulImage"):GetComponent("Image").sprite = sprite end)
    
    LangUtil.BindText(IDText, FontType.All_Number).text = v.role.info.roleId

    ---@type UnityEngine.Transform
    local buttonRoot = rc:GetObject("ButtonRoot").transform
    local deleteButton
    for i = 0, buttonRoot.childCount - 1 do
        local child = buttonRoot:GetChild(i)
        if child.gameObject.name == "Main" then
            child.gameObject:SetActive(true)
            deleteButton = child.transform:Find("Button")
        else
            child.gameObject:SetActive(false)
        end
    end
    LangUtil.BindText(deleteButton:Find("Text")).text = LangUtil.GetSysLang(331)

    if not v.role.isOnLine then
        local timeDate = ""
        local timeData = TimeUtil.ConvertTimeForm(os.time() - v.role.info.logoutTime)
        local day = timeData.day
        local hour = timeData.hour
        if day < 1 then
            if hour < 1 then
                local min = timeData.minute
                if min < 1  then
                    min = 1
                end
                timeDate = string.gsub(LangUtil.GetSysLang(728),"X",min)
            else
                timeDate = string.gsub(LangUtil.GetSysLang(726),"X",hour)
            end
        else
            if day>30 then
                day = 30
            end
            timeDate = string.gsub(LangUtil.GetSysLang(727),"X",day)
        end
        --end
        LangUtil.BindText(rc:GetObject("OneLineTimeValue")).text = "[" .. timeDate .. "]"
        rc:GetObject("BgImage"):GetComponent("Image").material = DeActiveMat -- 离线
    else
        rc:GetObject("BgImage"):GetComponent("Image").material = nil -- 在线
    end

    local cardItem = rc:GetObject("CardItemLittle")
    local fightSoulItem = rc:GetObject("FightVisitItemMid")

    cardItem:SetActive(v.role.supportUnits.cardData ~= nil)
    if v.role.supportUnits.cardData ~= nil then
        UIPublic.InitCardItemLittle(
            v.role.supportUnits.cardData,
            cardItem
        )
    end
    fightSoulItem:SetActive(v.role.supportUnits.fight_soul ~= nil and v.role.supportUnits.fight_soul.id ~= 0)
    if v.role.supportUnits.fight_soul ~= nil and v.role.supportUnits.fight_soul.id ~= 0 then
        UIPublic.InitVsFightSoulItemMId(
            v.role.supportUnits.fightSoulEntity,
            fightSoulItem
        )
    end
    if v.role.info.avatar ~= nil and Z_HeadPortrait[v.role.info.avatar] ~= nil then
        UIUtil.SetPlayerIcon(avatar_Image,Z_HeadPortrait[v.role.info.avatar].Resourse)
    end
    LangUtil.BindText(name_Text).text = v.role.info.username
    level_Text.text = "LV.".. v.role.info.level
    StateLX:SetActive(not v.role.isOnLine)--离线
    StateZX:SetActive(v.role.isOnLine)--在线
    UIUtil.AddBtnEvent(deleteButton.gameObject,function() OnClickDeleteButton(self,v.role.info.roleId) end)
    UIUtil.AddBtnEvent(avatar_Image.gameObject,function() 
        UIPublic.OpenRoleInfo(v.role)
    end)
end

-- 实例化
function this.InitContent(self)
    coroutine.start(function ()
        table.walk(self.friendObjs, function (k, v) v:SetActive(false) end)
        for k,v in pairs(self.friendsList) do
            if not IsNull(self.friendObjs[v.role.info.roleId]) then
                this.OnFriendItem(self, self.friendObjs[v.role.info.roleId], v)
            else
                ListChildPool:GetInstance():GetChild(friendPfbName,self.friend_Content,function(object)
                    if self.active == false then ListChildPool:GetInstance():Remove(object) return end
                    this.OnFriendItem(self, object, v)
                end)
            end
        end
    end)
end

-- 初始化
---@param self UIFriendView
function this.Init(self)
    -- 在线数量
    local allCount = table.count(self.friends)
    ---@param v Friend
    local ZLCount = table.count(table.choose(self.friends,function(k,v) return v.role.isOnLine end))
    self.Num.text = ZLCount .. "/" .. allCount
    self.hint:SetActive(table.count(self.friends) == 0)
    
    self.friendsList = {}
    for k, v in table.pairsByKeys(self.friends) do
        table.insert(self.friendsList, v)
    end
    ---@param a Friend
    ---@param b Friend
    table.sort(self.friendsList, function(a,b)
        if  a.role.isOnLine ~= b.role.isOnLine then
            return a.role.isOnLine
        end

        if a.Level ~= b.Level then
            return a.Level > b.Level
        end

        return a.role.info.loginTime > b.role.info.loginTime
    end)

    -- -- 排序
    -- if self.sort == 0 then
    --     this.SortByHot(self)
    -- elseif self.sort == 1 then
    --     this.SortByLate(self)
    -- end
    -- 实例化
    this.InitContent(self)
end

function this.FriendEnable(self)
    self.sort = 0
    self.friendObjs = {}
    ListChildPool:GetInstance():ClearContent(self.friend_Content)

    -- 多语言
    self.friend_SortBtnText.text = LangUtil.GetSysLang(4038)
    self.latelyButton.transform:Find("Text"):GetComponent("Text").text = LangUtil.GetSysLang(341)
    
end

function this.FriendDisable(self)
    self.friendObjs = nil
    ListChildPool:GetInstance():ClearContent(self.friend_Content)
end

-- -- 按最近登录排序
-- function this.SortByLate(self)
--     self.friendsList = {}
--     for k, v in table.pairsByKeys(self.friends) do
--         table.insert(self.friendsList, v)
--     end
--     table.sort(self.friendsList, function(a,b)
--         return a.LastLoginTime > b.LastLoginTime
--     end)
-- end

return this